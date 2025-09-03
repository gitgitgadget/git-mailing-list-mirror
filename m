Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E21482E8
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909885; cv=none; b=Njfcl73BButJ6YLnYiGa4triQfaMskB3X3QI4GWZGt1e/F8dGgjeGMB11cE9ASg5lEfqw8m9bTThh3U1KzfHIV9HyZhPdSWJuDpf2aFRb0jDuE0oOhld1MoVZPn5mHWMAtVz3K5xSyqWT0xShaPlqY75l/KUJN9Us253b8VXHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909885; c=relaxed/simple;
	bh=mOii0AhE+mfk5XuJgxLYFAmx8HVnryvGUIyTcSZkvl4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lRtqsJZljP11H82Wsu73L8pK3zbc7cUvdaYIx6g1vqQTmMA3SwF9SjtuA8lCTYuIjDZudspkA6IBhgPRR4O+fb5ktqqKMv4FqP4idx00a/z3VW8UUR3D7wjG8iL0c+08xEtD8Q0EMnb9Hr1195pwp6w3qVSF8PPT0liwG0jOuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWqAqib4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWqAqib4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32b5d8bea85so828462a91.1
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756909881; x=1757514681; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUlSaKiatQX5NtdyXWY629/LOKGkseEfahBSe4KY8nI=;
        b=bWqAqib4jb9YNlrlHQK50pE93fdHQPZPtCtuBDrIQh32/+ZMNRSnoNUCWbyQ9ng/TR
         Y2fsjEffxSeU7Ie/NgVZZK5kC0jFOMnBuiMZMTwmsymEmcH2Cjykmr2LTKb+XxMarJuv
         hqj4KSPsw/jTuwehpYnWXkSoHT3HEioNDmPXC4kd2NmwF1RYvCKkslbyATszTMBrFLEQ
         QTlWumoc23OsLex362xZRAjr4W/dqwzMBbxGsmwOUY2XXirrse+Uq3Y36YKpg9sP1za3
         Z777WHs/N1ZyJ6fFsTI7gEFrH+MMY7pM9PO//ZkC+acqK+WvJwpgMaNcvm7djXdRgU66
         a3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756909881; x=1757514681;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUlSaKiatQX5NtdyXWY629/LOKGkseEfahBSe4KY8nI=;
        b=to1WSox65lvdzEhrHY3m5D/Oa0eGw0+Ctub9gdO+nBrm/loa9p8DFLyBXiKrY5/nIY
         s8JggC5hJfAFOHdWwJLZWKdCw2amQqzjhSc8js5wIB6kyNTbDrHTbKYlbj2qwiyZt6vu
         GYNAmdnlDcHhpydI5R1oRIOco4oY4eWGcdat2utWXxvWOcrbZmO8smMtLTz9Pbn0677P
         vw/URNfCyFNgVifU/cRyh5E6N4+CmSRmju9sb7T1i8/J/oinGY8w2emEJWwZjcW9Jtq4
         RlzvHUPfhjy15CoXjDKfGPL8Q7n63ZZxNikTxfhIB2YSZnZ76zP7g1qbHwHU7Ra+xaeC
         FPKQ==
X-Gm-Message-State: AOJu0YzMk4a5yIIyQiQXH24OKutY2A7QT/lqXITvhKb79PUCmTR7+W3i
	RGOLeu+x+dRqDWIdg1GMGjxaQ2nEJKZk7BnqGzVtv2O6W7aqinzOcXpEuU2K3A==
X-Gm-Gg: ASbGnctr+zf/UQ/i30V6fmsrTM6COJ2i3Iezemv6T0ZBfRwCMUf472w87MpPDzTVDmL
	RJdeAuJLkq3RQDllUmStGT3zkOHQ6i4v0dXjxv2X8K/X6RsQSBw+OYKPudaZVJWhW9TmCll39+Z
	1SNnR5wt20O7fWpcQ/0uBAdocqSvqZyP9AIk/h6EfAcXODFGAnI1yth7LlnJ2Oc4G+IkVrEVmaS
	aMAwJmKUTZYpf4Lo8TgTGa3yVR+bhkbpA4gO/s2t34BnCOXQQ3CtfU6ZziM7HFu1xNzfyspkcXN
	VoK0zt4kDorSHKqN36fzE8xk70gk9KUrQVevK6BFtNAOg94bXxYNFhAaeVGf8mIXoKUeLMMqNAd
	Eqv/vtWfWOEgHwIbjtw422zQ1QB8/Aarpt6nM/oObWaBiJeJZVUg5GRBjIVhHM7sZafw=
X-Google-Smtp-Source: AGHT+IEJwS+Ith+NYVtK9+y8zzKbxGniTvGbKo3mg3EHWrsLykTPkYj+wuXp/HtBTZDD3HawbHaD9w==
X-Received: by 2002:a17:90b:3844:b0:321:82a0:fe50 with SMTP id 98e67ed59e1d1-3280d2d9b63mr21614859a91.5.1756909880947;
        Wed, 03 Sep 2025 07:31:20 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f0:b77d:8aa:fda6:1fc7:374b:6356])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f57b232sm23150975a91.2.2025.09.03.07.31.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:31:20 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: What's cooking in git.git (Sep 2025, #01; Tue, 2)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqv7m0kd1a.fsf@gitster.g>
Date: Wed, 3 Sep 2025 11:31:07 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <10A6F3A4-E4EE-4E2F-B23A-7A4985B4B536@gmail.com>
References: <xmqqv7m0kd1a.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)


> * lo/repo-info-step-2 (2025-08-26) 3 commits
> - repo: add the field objects.format
> - repo: add the flag -z as an alias for --format=nul
> - Merge branch 'lo/repo-info' into lo/repo-info-step-2
> 
> "repo info" learns a short-hand option "-z" that is the same as
> "--format=nul", and learns to report the objects format used in the
> repository.
> 
> Waiting for review responses.

I've answered your last review, is there something left to do in
this patch?
