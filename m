Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC321B87F2
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751349159; cv=none; b=df5GVzm79De3s7JdssLTg1aH0QH9DoV8q2b5Oknf25hG+AJKZ+UPSrdzMjddjSC3vKLJGmGcqQzqX0FNHLpdecPJqB9Fz4Y6fDgOYskEU1gZs+b4RCxcNslZVYm75hDZZT3VDscjSnpId5+iZmk757UPxD9OlngfDRH6j7IJUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751349159; c=relaxed/simple;
	bh=O8mPvL9Cm2+JB/HaMBNPLzKgV3laP2NlaKpPN8aw9cY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=e301atm75YgC1KZFnLnH1hFEjBKJE4pXGSa5Y+3l5gwxa4Jh3d1xbmqRBZdSsJIInPdQb1oC8RTD6+bDlwMgxHlDxMKz1QaY5B+5HhXQpTV7XX/WWXUeutVHu5ipjVOWfNKVyP/jGC+8JlSkCxWbFHX1rIIg92WpYNSyo78V1jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3sq3Tiw; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3sq3Tiw"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-234c5b57557so26588195ad.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 22:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751349157; x=1751953957; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz/46LI6z8p45U/lU3M0iPzZpAbjrnGBWKweyoIrWJI=;
        b=h3sq3TiwKj7sVa9z7NdL920kvptF2Owa5PNaehe4W49WQSvSux2mXMlo0YnYhW3gMs
         O1MJs0xte/keEf+hXi3acthEud6QMjG96nZzdmXGTSHwZ4WBbExyrfkkhVz3PDMlkg+u
         Bmnr3Irb56pb+hZ/F00IUdkjFltgu/1GdBfcqtVQD4Vd+9h4ZQE9GjWtO/XEmQdiCdPA
         DihHq6cI5K8LvtQSkjyU+knu171WAXGc/vWAD/15PJP6mP3QQHdYXJBbs6tnuYMC4A3y
         IuTJ4mOHZ54wAK5HCN9Q3oWKnPPp9Pe2ZoglOpMQpQOHjWZzrFASJZEE5CgxAJFo7ZeF
         hyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751349157; x=1751953957;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gz/46LI6z8p45U/lU3M0iPzZpAbjrnGBWKweyoIrWJI=;
        b=q35VTCYDlIcuS91VH52eYV2uF7ix6W111yEksisi7foH7G0unaxVBHdDfDo9z1rCFj
         AkwCqRXoEBkew/iaTZs2cwBxUQ7B2+jt0diMpPzrueAQ5oF1KIXLN4HKEBotWV+15iMo
         kIt1JnUx+rst5G3pj4bhFU5QfW1JGswaHWqcxtf+q/JcdkkF7oj50GDtIpYIhwlF1aqq
         Q74YahqD+2wXoPVIjZbffFBFDqQn2cM4Xj1GQVDfspihc7+0G5N16r0DL9BgNovhyeOh
         S3bNQJsC2xciZS84n59UPv3cNPNl1XsFSMC5L0OMEKRYAmSiYAm6ugE5xcCGwSszGPQ2
         I4kw==
X-Gm-Message-State: AOJu0YzEnhxdqawgoU3aUDDZWH+J9tyFrlskizWJfwrVF5yTSL7jYTRN
	23OS1fZhn/1hjzZfNCGbNnwwh8RFF+wYwna1uhdEjqNUtFO7/MLZlsAF
X-Gm-Gg: ASbGncv/pqf1XXgCRkkeVsSUwMzZ0Wib72AN2Ttoxxe7ZHYzd2zCl6YTSXGWlKPRS3u
	T1iYlZLWgX0DJ8/viMIp4Xvv/QpqQTRVicFFdM3fokAqelkHYSjq/m7p7OGkVhaqqX7kneHKy8w
	CTtuocWslyqlts6riG8G8aMCi4LuZnmDYCeVjA4k6oNPxlQI5QJxLz3U1sn2lgihZ+sI225ZTra
	gj8baIluHVbTpnt667157CYWlcUkirtgHuggZAdaudON/u9OOooh4hDEhzeE7DYDQwRuQuMevK8
	XP+6WQ6XTgssu3pEqHsHFXZ1UKu3iGybexBy5yYsCMb3niuQAbAMvQooHKv/lzO4RAtYHDDsoZz
	UbyB/Qrhr7hMgzFc9in3Yt0GVmPGPOd+Wq9LKgmUjnXEb8s+PNRBMcUsDg4GTmFm6
X-Google-Smtp-Source: AGHT+IGhgLEcieS4OooKl91OB3kJzeaTK1C6aQqqu003OG/xC96eoVElh+xb/ew2yunZJCCo8uzokw==
X-Received: by 2002:a17:903:41d1:b0:237:f7f8:7453 with SMTP id d9443c01a7336-23ac4667df2mr223071605ad.51.1751349157140;
        Mon, 30 Jun 2025 22:52:37 -0700 (PDT)
Received: from smtpclient.apple (n058152022194.netvigator.com. [58.152.22.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b8d2sm101721135ad.128.2025.06.30.22.52.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jun 2025 22:52:36 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqy0td8fa9.fsf@gitster.g>
Date: Tue, 1 Jul 2025 13:52:26 +0800
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C8E0D62E-11B1-4921-AD4C-2905F10E07B6@gmail.com>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
 <20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
 <xmqqy0td8fa9.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Junio C Hamano <gitster@pobox.com> writes:
> Totally outside the topic, but I wonder if we can further optimize
> by adding an early rejection using .nowildcard_len?  Instead of
> allowing a wildcarded "dir/*" pathspec element from disabling the
> Bloom filter altogether, we could say "dir/ is not possibly altered,
> so there may be dir/A, dir/B, etc., in the directory, nothing that
> would match dir/* wildcard would have been modified", couldn't we?

I think, except for PATHSPEC_EXCLUDE, all other pathspec magic flags
could potentially be optimized using .nowildcard_len by restricting checks to
just the dir/ part of each pathspec item.

Here;s are all possible pathspec magic
#define PATHSPEC_FROMTOP	(1<<0)
#define PATHSPEC_MAXDEPTH	(1<<1)
#define PATHSPEC_LITERAL	(1<<2)
#define PATHSPEC_GLOB		(1<<3)
#define PATHSPEC_ICASE		(1<<4)
#define PATHSPEC_EXCLUDE	(1<<5)
#define PATHSPEC_ATTR		(1<<6)


