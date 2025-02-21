Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153EC1FC102
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170483; cv=none; b=OwLxRbMUBVg+XVTovpzWCEmz7edCTAvvhS+/I5PBVLHjum4ZamSDPX/6CWAxlyy9urm0SbUudMUtYpW46MkBPnjIO2Fnlei63OcLsq9DtijNxwUnkdWWu8KcVmdMV45Qia9Fq4tFZSN+NaTitpf3i8t90VyK9cdSK2zjNkoREFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170483; c=relaxed/simple;
	bh=yEJ2AvChh5mBGDV8vFXdwh4MSSnXwrDkVoYItkOVbhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRQftNd5cKJ64TXmDSFfWFBK7kXUFEyDU+ywLqBs04MVTuBtAekJBpawOn5B1mlZFIqz43klx1bXc+Ukm/WuANQWy3R+X0DrQohdNuChg4g88H34L9uqCuIxRZPLXClX8nZnO8gwgN+Jcqcoz9oYA4Kft0FVN4YM7zZyOeqEqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rhelmot.io; spf=none smtp.mailfrom=rhelmot.io; dkim=pass (2048-bit key) header.d=rhelmot-io.20230601.gappssmtp.com header.i=@rhelmot-io.20230601.gappssmtp.com header.b=fJlKukMd; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rhelmot.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rhelmot.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rhelmot-io.20230601.gappssmtp.com header.i=@rhelmot-io.20230601.gappssmtp.com header.b="fJlKukMd"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5dde837d82so299589276.1
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 12:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rhelmot-io.20230601.gappssmtp.com; s=20230601; t=1740170480; x=1740775280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RWkYKwdS7Qz+MrTSULa4nEjEu8yGyLN8C1yZ+60vNtw=;
        b=fJlKukMdV6km7X0J4JQBdL8FazBg7lzqsfyttmXaDf0Gz0C0yfwFBrQJA6QdSrbgW9
         LaHisvmV37XQgCexBl5wmEcWPHatqSqBkXZKkHQgsigdYTp4mcmWmZjSazg4Ue8bnlZT
         ajS48SLKpFwJe2SwViRcdojaRjnAwApg7tcuPt0arQe5spZ5A+0S5lFcSKmGDZzmtXq0
         E2rg/MQC0ofJy0759kweXt8LHLYrE3dAVjX4dVGO2YEic7pMhXv1inPFXvv37P3X5XC7
         +6mM3QzhNGvw7zgXQGhEiLVCGLVG90Ypg+QycyKBUBcQ7OFR9HRNftI+SqEsxYtLiTIq
         qeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740170480; x=1740775280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWkYKwdS7Qz+MrTSULa4nEjEu8yGyLN8C1yZ+60vNtw=;
        b=dRAPfwU65BHdriDjtu4szgNXbI2ep211TQ0lRwNANdNNjJ8i3nr7zGknxDNxzpVLt5
         WCp7hsaDcr2aPi091KwM0B64nYxFtEUoU+IHlxJM7zfs1CSQxAnkkuKyGH5CDC1yWEOR
         MPQF2hICWXX35gQbNRcNwTvp6UUkqm2oWdYanFYBPDOC5HzEqt7gqFH0pP3IFZa2tugx
         Cc1XTwA+CSyXLffBd9TVfmorV9CqZGaOTPGMHOTMvwq/9f6GzbO6dMioZGxpsZa1zRsn
         agRydWjpTvksNaUcy1Y42B1rabWPPehrqG3Mj60/F3xsRQyEuzRm/xsLLa8Dt3Erpi7h
         W88g==
X-Gm-Message-State: AOJu0YytrFle0AK2IgivDasqOVyvMUEASSX1afeNRqNbuskk/i6oaZ4I
	cimNlaAf/U8dndjpuBj6uhylOj4ce2D1gad9QyJqWYwu8Zo1cdczronEJCHjmjm2Wx4hzdwWABI
	wBffo6EZndPRO0xHN0RY1pQ0zOhWV2eP9GQmLqlSzSk47D4pL
X-Gm-Gg: ASbGncvj3Miv+vhJ+ZSy/7cVBu0T5p/EyXgl6mWkaPt9Uk34pXJf5oHxY0gpZv3hnfB
	93cmv/s3KyyH0+WCqkrI2FuTJlZ+uBx7DOA8MVYIOENVCLaC5GW04URdJB7/rO0227NgVHN/T4Q
	rp4Yr5avyQe3HnuXv3uKikECWCIvNKRLaQnQC1iiZIQg==
X-Google-Smtp-Source: AGHT+IE29l2B/Xe3/lOy2tGAksZOMUDNgyBrgG5YUgMi3AdURPgskHOZ9kf6IbFWGgJj8sRNUn1pa5gxFMUiOTqEJvQ=
X-Received: by 2002:a05:6902:2303:b0:e5a:d58e:cff4 with SMTP id
 3f1490d57ef6-e5e245df64dmr1694167276.3.1740170479881; Fri, 21 Feb 2025
 12:41:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221180225.3176533-1-audrey@rhelmot.io> <xmqqeczr9guk.fsf@gitster.g>
In-Reply-To: <xmqqeczr9guk.fsf@gitster.g>
From: Audrey Dutcher <audrey@rhelmot.io>
Date: Fri, 21 Feb 2025 13:41:08 -0700
X-Gm-Features: AWEUYZm-voIyehXbCf75ehL9L9LP-X9gWKUK94Rv9S9EcsIwcp0TLjCFTy95New
Message-ID: <CADanSV3w++kkTgedLQorKgJ15kc5bEkNvYTidRU1UbwW4jCC6Q@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util.h: Bump _XOPEN_SOURCE on OpenBSD
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Is this a recent regression?  Blaming these two line ranges ...
>
> >
> > [1] https://github.com/openbsd/src/blob/6a403588e27467d1f271831ca1de62a3befea6a0/include/stdio.h#L236-L237
> > [2] https://github.com/openbsd/src/blob/6a403588e27467d1f271831ca1de62a3befea6a0/sys/sys/cdefs.h#L299-L302
>
> ... in the OpenBSD repository says they haven't changed for many
> years, and I am wondering what triggered this all of a sudden.
>
> If we know how we used to have no issue, in addition to how we now
> have issue with the current OpenBSD (which you outlined very well
> above), and when the situation changed, please add to the proposed
> log message.  That would help people on OpenBSD to decide when they
> want to upgrade their copy of Git.

The thing that changed was the release of clang 19, which enabled the
mentioned Werror by default. This is showing up now because I am
experimenting with building software for OpenBSD through nixpkgs,
which prefers the most recent version of everything. I am not sure
what of this is appropriate to add to the commit message.

> Also, I am wondering if this "A and B needs only 500 but C needs
> 600, hence require 600 from all three" is a healthy thing to
> continue.  How bad it would become to split C at least from A and B,
> to give it an independent status, i.e. leaving the above line as-is,
> but insert
>
>         #elif defined(OPENBSD)
>         #define _XOPEN_SOURCE 700
>
> before the existing catchall
> "#elif !defined(__APPLE__) && !defined(__FreeBSD__) ..."  line?

I can give it a shot.
