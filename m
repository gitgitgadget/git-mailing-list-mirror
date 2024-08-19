Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC881804E
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087215; cv=none; b=FNz32nFNogUej+UsX7OMm0E7zXIy6dnwdmC/f1tMamBBX7NnDCmwCcbVxraDngCVYNCJIK1I+QZEFFtsnc7Hm2Ag14dMDEqnQn0Sbw8gMQ1YxjX/M7Ejx5JETj2JnbQ/Wzm8Ed1qNN4fyyw0ioRqxo/G4AVxvTUcf2j26ZttraI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087215; c=relaxed/simple;
	bh=d0HTMhdKGrgTyZs6epUav74DhTtdHOvGiAkLtOCjKlM=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=DeLCWfproMIkkdTSWN8ojnRUKoG6l5KAJ/mSifoxfF653X+KSwYVWhnqG/foVuI4fAWWR+bFpLQFWnXGDl2fhYy2mtAvLVFeI/vYmVxezplrvLnYpQ1r35XvX0Me48Dc4jlNlszx/wTWODH8BgYCbodFLh3vDcBc7inKFKcStOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUBwltt+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUBwltt+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20230059241so9803175ad.3
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724087213; x=1724692013; darn=vger.kernel.org;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0HTMhdKGrgTyZs6epUav74DhTtdHOvGiAkLtOCjKlM=;
        b=kUBwltt+vrGWild7F0M8FnmxtyikNieZal/VgIcVayqe639SKxedpRDb/lxMl2F10J
         y6CcPWt6qzffpjD4OQvyJiB8m9pYItBPH8Al3uirKGHwBdVnfl8W1pzRwRTQbvZn/97+
         /wO06ZNOAOfpEiTzmWlv4vGFdIRjqunQ/8GrC3I6gOWyUAm6kHT2GiygQaW7w5HoKMYC
         rCG6msaGMG9w3GJizb4Tt40o4mc1R08IHMTtlvGs5EshrAnnFG7CdHlWaUZ+r/ofcSAj
         zmxCTIqJ82BbblgoSPeI12k1KTZ9TyDkv0x5VwPFbKuP/AVrVJtb9ALGf/6QDqloHF6C
         Mqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087213; x=1724692013;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d0HTMhdKGrgTyZs6epUav74DhTtdHOvGiAkLtOCjKlM=;
        b=LiimZdYkwI0Fbz8/nCjtUd8/Tj3zTnNc0FAVXFPlLLxOhHglRO9Sz1P1SK3TH7SzGn
         7aGCf4yjmMwQ0SmMwHqm5I1wo6TZ8FTbm3W5AenebwVBMheZpjUdPgoEjne0BGKOwoAL
         QP+QwlaLnGIThxEllShP0ajmixIaWoObjLhtHxdJS4J9hC09AII56dmt3WPPef4MyOGl
         PfiQUsnKuTFoWdxoKfo8uGJJLvfb83FaOx1fxsfhjLRBpPmPmjr4L3c0D4GY3a/T9Psz
         Ojqk6sLcP9M4p0eUKIeymGaOB5Hti5M1jjVt6PCfQJV/1I3KKrryqHmS6CGurchIgjC0
         olBw==
X-Forwarded-Encrypted: i=1; AJvYcCX0ldIGKEfLNDqWWlx23iE7kZp0VPLinqzw56DkeBEcL9MK58Od+L2sVC+PKi4yX97YnEWerlQoapmzikoVSJciN1xY
X-Gm-Message-State: AOJu0Yzw92p4HYtzLhI/i/nGeeCbi+cUmiJDYU4OoBVGTJQodVcpIcOW
	xgyrZoKKICEaFbOGU+7fmb5cJBTxtb2UT5zuxC3koeW8Hs/wkkqw4rYGooM5
X-Google-Smtp-Source: AGHT+IHNU3EMLBjUHKJP4KhuW61H9hoZMnGbmjLpZLtnVd5Z+GLa0LyQr8XEWBRMF0LtdqpVJJwWeQ==
X-Received: by 2002:a17:902:ce81:b0:201:fcd1:e40d with SMTP id d9443c01a7336-20203e4c4bcmr126749555ad.6.1724087212787;
        Mon, 19 Aug 2024 10:06:52 -0700 (PDT)
Received: from smtpclient.apple ([117.20.113.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031953esm64974825ad.90.2024.08.19.10.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 10:06:52 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: khmer song and funny clip 855 <limeangkonkhmer@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 20 Aug 2024 00:06:49 +0700
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
Message-Id: <F8A54D67-FF8A-427E-8049-75024F6B0641@gmail.com>
Cc: dominik.salvet@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 jrnieder@gmail.com, peff@peff.net
To: felipe.contreras@gmail.com
X-Mailer: iPhone Mail (19H386)

Hi

Sent from my iPhone
