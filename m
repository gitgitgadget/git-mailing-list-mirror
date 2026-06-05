Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAD38F636
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680956; cv=none; b=CUILlDGGrKOQkmSBz7cS7pew9YtLfpFKtRPR80alEryb3NDz6md2BgBY2sY3PguQpmuN7fWHdQFaD9ZmYG+oES1OXLB8FC3z2s7Nqy4vhV78ijCoL2E1V8EBrDe6gA9J/lct/5IsxxvW7Il92/tO39L5aMShgzjg1bR0L6VsvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680956; c=relaxed/simple;
	bh=yPdCM0+ECQ0NkrwuY8o1oduRWEVYsLRfjktFkirr278=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i/84EeJFMHn/0Zi94hiZDSU1DT96QsYQkgJyKJmhwNp71lA0F9ifrZ1Ek6WR1Q2qqkTRtlRFcW+MYsiUvAYdqqYuCYy4FIOssJa4Qn9D0rOMbISv5WBnDdfpO/Yli/A1B2Zd/ViX3w8UNskRvSqOXIzQvdeViGwyyx/ekpNHhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUlZGLYK; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUlZGLYK"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-96395a59ff6so790903241.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780680954; x=1781285754; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOtED0Z8oBXjAiTx/v8dSvYM3t5qcNaoKV1bLeScW8A=;
        b=sUlZGLYK5AR4NSNEoEEy99s4ZCIqfn+7nO6Br3wJF/G0EAxznEnL5dpLoZxPk6PZEs
         WF9OGyfDEA6zHXPx12V/US04kkV+weiOal0aTV5AMQVt/UG0O1RHVVLP3IxOMXHJ7BEb
         yyRCSNqQTygIqVkp4/5NibFUviM7FljuskHcj5iGLyDs0Lv+MBntWx5/L7OEsKqAnpQr
         k4t+RqJ/qdCbqCD/fs05dXiuxYh5aysFiwVZ44CclhIiE8tJwqcyVJxUtg+hzDnZ+JoL
         p1dPLMBCyY34xi/1gPgq+ZCyUlNW3q+0XJ+7NSG2iHrbmgT9AeSli+/pHmQ0sInVYpaG
         8iWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780680954; x=1781285754;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOtED0Z8oBXjAiTx/v8dSvYM3t5qcNaoKV1bLeScW8A=;
        b=KMKhGv0oevxFJrAJ324symU6ijRNRzjOgREW1HaSNfkDpOi8h+1hensTFuESHwCikM
         qyl74fhUeg7pofZX6dn+Or9wwjH4FHzCxI2mzk9BBiZCGXulazRIRxlKC9EyHl0QFHLL
         WO/CQpdMPpyzfGcrxyZtsKkk9X8Ds+U/UWNhuAXz5cM0tjGNhrUIfGIAL456JM5n69ol
         gsAspWOBwxozFRjooF/dF1fovOxmFl6bHsYc4jL5Y1AsP8MDYJFi3G3NWkI2L4wrCIxU
         3fQKMwhOmskxsbIOWKDg1hBtZVvo3eSnnXFnZs/b+FSWUOAF6V+B0eCVoT0nFFkaLD+G
         xV2w==
X-Gm-Message-State: AOJu0YxDUu0tsRILcFhSmAdf3KMq+T90gSduuJWCkB2xsPdPX28IawK7
	qpKaVzrZ487aVAuAAhY44EV6CRJe4IJEGkLwYq1FltSEqNzAca21g96T
X-Gm-Gg: Acq92OGtv4xvuITSE82330c7ET0xXDRqGfyPScmAKh7VoJPYOfJ/p0qsjGgjC4Y8h0N
	nHf8EUvZjwjBuP2OfKK8AwzWD2QMX1n/+pkw0+nbc9FRPDzcfPICMBjDKMC/b/ImqdVOd/b97IM
	S0fAcEYIxWyvy9dcOIyEK8wmvcBLvXmRjA5aX7xXWWgv1wbak5DDk5uaxQ/8HsSiUP0+EGDfFlZ
	WzMktL80RkHy5qQBu4c/YrpnlawCWZxX1u98WYkke9lcAZbjmoJWXN5lSGCjAep+4Oa7cvGnwWO
	8VsT2sxn2MG7LeJleWPYPnVx9bYk5RCbiHgvneY0dzVKvMH+JMoph3HcPFAt+PRe8eCrc72Ri+1
	VEG/MJaL1iFWutfI6wx6hQl24AyeclwqpPKRQsr0l/pVwUv2rldJnhTYjD9FtEDQ0OSSOw2j1hs
	wHEfPpO0qIUSwr6jKRWnRV/q8gVQutesET5jM2PTvE1tQlcupWnYGv1LJoPQ==
X-Received: by 2002:a05:6102:5490:b0:6e2:501c:3c93 with SMTP id ada2fe7eead31-6ff0eba884dmr2790267137.14.1780680953755;
        Fri, 05 Jun 2026 10:35:53 -0700 (PDT)
Received: from smtpclient.apple ([189.62.148.96])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb649b710csm8080955137.7.2026.06.05.10.35.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2026 10:35:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC PATCH v2 0/4] teach git repo info to handle path keys
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
Date: Fri, 5 Jun 2026 14:35:37 -0300
Cc: git@vger.kernel.org,
 a3205153416@gmail.com,
 gitster@pobox.com,
 jltobler@gmail.com,
 kumarayushjha123@gmail.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net
Content-Transfer-Encoding: 7bit
Message-Id: <A67C8C8B-2600-41D2-9E61-0923BFDDD06B@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> * About lexicographical order: "Breaking" wasn't the right term
>  before, but I do believe keeping .absolute and .relative as
>  suffixes is a better choice. I prefer having the two choices
>  side-by-side grouped by entity, rather than a cluster of absolute
>  keys followed by relative ones. Open to hearing if the latter is
>  preferred!

I prefer `.(absolute|relative)` at the end. `path.gitdir.relative`
means that we have a collection of paths, in those collections we
have gitdir that can be relative or absolute, and we want the
relative. `path.relative.gitdir` means that we have a collection
of relative paths and from those we're picking gitdir. The first
feels more natural.

> Thanks for this round of feedback guys, this has been fruitful!

Thanks again for your interest in improving `git repo info`!
I'll review your patchset with more attention later.

PS: this is a nitpick, but it would be really helpful if you provide
a range-diff in the cover letter. Check the usage of `--range-diff`
in git-format-patch documentation (this flag also works for
git-send-email). Or, if you prefer, you can generate it by running
`git range-diff` and copying the output.
