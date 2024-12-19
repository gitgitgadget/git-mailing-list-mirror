Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70E218ADB
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734596793; cv=none; b=KuljAIoxlSqm4+Snf9aYmaoJEE1J/PVwUOWxbrzq/8mAsVNBVzOgGAz5W/tH0P+ZVaWYY4s2x0T91pgGU1ctte12YNNhtj0DaEbjejeGxoRsDgS6XTtjQRV0PYC5xyd2ErzOSWTVemSIC5KHupzoMiCe4HOHZWXyN7rlUOXYfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734596793; c=relaxed/simple;
	bh=l0HJrXfwwpipzVh66PMIDwOZU0rmKGwe79VUmVBwgCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHNWsxduFyeoXKDN7CJusIQYSJNoyU/B4ByhN2eYEhgapMnDHMZUciTboT2U7+0XizH7oRKrUaWglgDt7UY00iCGm9sFk2T9qFlrvLWbMQ0ZECYDynYyIi+ehDcHNrPi0NBm8Pi4Zmx65XhJ9MiEWdyw05wsA7VNALIKRfQ8lhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpH3olXt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpH3olXt"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so248145a12.3
        for <git@vger.kernel.org>; Thu, 19 Dec 2024 00:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734596791; x=1735201591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QgiIU/Dym3g/HD7Ljthi51HC9ZIpGi6wTdzrtjyxs/0=;
        b=CpH3olXthARvKZIU31mRRll1Fb49Y8x4M0vLCuO8lyDiz+2osCx4TETRJGB7bFWnjq
         87Qjcz/AcyTJPvrQpCCTcQE0YR7J8I8qEeaqGdp2/BKQpTkSDzggyi84bFNZyQoSGJXi
         W6TjV+cog/yc1wZ4vwQcUGVx2YEeUOqZKGRFM0T41yPa6GyirimAtwTfyln5x8U/T/gd
         BJAA/1FZtB52dAkQNeZDkLpxqVbwud3DgGX6rhnq+bKT0CRww/zkL7plpuQ2NToR48tM
         v8KNFIeiTzQ/xabPnpUuAvNGlzzf4UtCqOSjHxt2O41rth8MV4MGc5q9guJCj/3YH5BK
         5x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734596791; x=1735201591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgiIU/Dym3g/HD7Ljthi51HC9ZIpGi6wTdzrtjyxs/0=;
        b=J1GPjplNepZ0v1xxjO45nNV2m/kPZYjl5SBaTehjKwpyFbfX+xbmxCu3ySE5834kTq
         wUVw1tI2f0zoy1l+V7VkhrHosopaV/bWE00uzHnB2w9M3U++FoZXNcj3rPc8bPxv+/+w
         3QcFgPFmidJ3O+k1yupd03wVGSF633m2fZWCUWgbwSjSYW+BO9iVX4iQOMhS8folG8Ry
         vHvOVRHBN+4Bxng4+LmOP5gFrAqozDJFDY6J4pGTbJ+FP/EgPO8KWWA2IVpkL5iGX2Um
         c1Fz3uRdhhLC6XHNew1kR9dD2kVpCeq0ZMC2TnDgHG/uyMzj6fSmEcYkzlLJDBCxmlrZ
         kgAg==
X-Gm-Message-State: AOJu0Yx0E5zDizmw5sm85ybbKuuDaJqXD1j/boOVPsKWVsST4DzwFcuf
	+2OGdWLR1TG0cUk7yCVwwPIuj2tR6gumzAikYAojA3Dh6cBee8oi4GYkDvB2q/NtzJt99oRJa/K
	JhbDOLXhBwLa6vzzN6NaGWN+KnHI=
X-Gm-Gg: ASbGncsJCupb2H/bR+j4zBChhtPWG86turwwk6yVJqmYvr/BmtAr+yg3ODN3zp8D9OX
	wv3R+VtYiOx4htmaYYP21JJ/54bYbZw1aR3qzVw==
X-Google-Smtp-Source: AGHT+IGftM41FuLhaw9v2pQEGdKx2QgR354AgSUeS+b3AT0ShoRXtIryhYBTl6poNCVwbtah7uOYxdEVe/8jnQdandc=
X-Received: by 2002:a17:90b:53d0:b0:2ea:5054:6c49 with SMTP id
 98e67ed59e1d1-2f2e8f5e4b6mr9582096a91.0.1734596791507; Thu, 19 Dec 2024
 00:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADMKT2-vsUUi-23YGexvxbW9wj0Br+cQcv34eStnw-0EDRiKMw@mail.gmail.com>
 <20241219054222.GA2310556@coredump.intra.peff.net>
In-Reply-To: <20241219054222.GA2310556@coredump.intra.peff.net>
From: Boomman <boomman37@gmail.com>
Date: Thu, 19 Dec 2024 00:26:15 -0800
Message-ID: <CADMKT28cZcdW8UJ59vZHoMa0WEbyAccx4A10-jk3MiBkhZLxEg@mail.gmail.com>
Subject: Re: git gc does not clean tmp_pack* files
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Yes, if the behavior in case of running out of disk space is to just
leave the malformed file there, it stands to reason that cleaning up
those malformed files should be the first operation to do for gc.
At the very least, git should notify the user that they've got all of
those tmp_pack files totaling 20+ GB in the object folder before it
will declare that it can't write a single byte into a lock file
because previous "git gc" calls exhausted all the disk space.
I know that on Windows it's possible to take an exclusive write lock
on a file while the process is running, so at least on Windows those
tmp_pack files could be "soft-try" cleaned up without affecting other
running git processes, not sure if it's possible for other supported
OSes.
https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-lockfileex

-Vitaly


>
> On Wed, Dec 18, 2024 at 06:19:06PM -0800, Boomman wrote:
>
> > D:\Platform>dir .git\objects\pack\tmp*
> >  Directory of D:\Platform\.git\objects\pack
> >
> > 12/18/2024  05:33 PM     7,367,032,832 tmp_pack_FG1inp
> > 12/18/2024  05:35 PM     3,787,194,368 tmp_pack_IFvamY
> > 12/18/2024  05:39 PM     7,713,062,912 tmp_pack_khHCC9
> > 09/11/2024  11:33 AM     3,068,002,304 tmp_pack_XTVFUi
> >                4 File(s) 21,935,292,416 bytes
> >                0 Dir(s)         339,968 bytes free
> >
> > I believe that before trying to write *anything* to disk "git gc"
> > should try to take exclusive handles on these and wipe them, ideally
> > by default. The total size of these tmp* files is multiple times
> > larger than the repo I'm trying to compact, so if the command just did
> > this pre-cleaning I'd not have hit this problem once I cleaned enough
> > disk space.
>
> git-gc does know how to clean up these files, but they are subject to
> the same mtime grace period that loose objects are. This is to avoid
> deleting a file that is being actively used by a simultaneous process.
>
> Try "git gc --prune=now" if you know there are no other active processes
> in the repository.
>
> We usually prune things after finishing the repack. So if you're running
> out of disk space to repack, there might be a chicken-and-egg problem.
> You can run "git prune" manually in that case.
>
> Possibly git-gc should prune first for this reason, but I'd be hesitant
> to do so for actual loose objects. It's a little weird that tempfile
> cleanup is lumped in with loose object cleanup, and is mostly
> historical. Possibly those should be split.
>
> -Peff
