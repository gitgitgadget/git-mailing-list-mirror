Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D34191F60
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733371158; cv=none; b=py0spA6GSwqHuP0/tDB5IAabaQ5yH1v8/yi4AasiNqmnTLFL3UHVNkTRPkrqP8cqY+aaYoUSSuCIPzNLXSaCw5pNcZ5Go5JmkjDFzcJ1nrYf/rzlNUX+dwpoNX/1JJuD8XmayMK0FqDDLnFDeR8dWasV1mF7OTyC8uSuRT2zg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733371158; c=relaxed/simple;
	bh=3xr3vMXl2A0+YVArzLDJOB8DZj8PXF2ZXwrvACF8iF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfCo9jNY/wJc8823f+u80x4Bhe2c0ZA+0KIZ1RGEMyGPq05A/J6v6QUAaphvcokGZDQE67bDXT0OhAdxehmLiKO0hn6s0Zal8+ENjBnl4nW86/ZLItQJPMR4JRQj0bCcvNlYV3uLtaOtgtJDP9tuKCPTGuJA+5MN6NnDeNAvSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5ty2aGt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5ty2aGt"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffc016f301so3568561fa.1
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 19:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733371155; x=1733975955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHh0LuRCl38lyveBc/VkTSqQu9Bqv+gyhxC/IeKC1FM=;
        b=C5ty2aGtUutzHy1esi3NNjJj9dCgmtWHm8J2ZL6dQzkO3Qx6A2vb5J2d7tFGmKVgad
         Ey80zv99YTLfSAMLirImamuTy1M6RkAswMjtWl1LuFHsOhHIoHKJiPv/Ox2B5ivURgYD
         bw/wpiR367HZzNTwKEqVraiAfOu+mODWCmZSXuO77gpJmg8FEbPLO4KSnm7Z8X+KXBWO
         NySIXXhVSmlHMp0/yuM330g2BxjPyoGzdfFwqSelumb8DNoCyeoXPUwPYky0ADYayl7f
         tgeHjJPUe2hAEUIDfI/IPsaByr8LDALizYR/jiXv59BftuHKuLbMtRX9OF7G7GoT/yh7
         6cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733371155; x=1733975955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHh0LuRCl38lyveBc/VkTSqQu9Bqv+gyhxC/IeKC1FM=;
        b=DNRh1KtiZw4jm47XO1MeTVtzWdvrEtEAUvA1wLjVOc79aD+jaUXlLsbh9vJdAhU/mB
         06McMjo0Zb8WLpkozDG6j1ruh1oVr7QtfD7nVRQxcfDpHoU50phoPefYi1ikn41iqDo4
         byKoFqfgT9Q4+1lnA+qvlDo2tUTIwattl3PCwwZsxgkkbTIBphj9M2K9z4U19LLUVWgV
         eJlOwFJCr0aOZDoeBULTJAEeQVVFmpH0sprjs00xHiiDOnWr+knCBxpzm+RMXC/1wjaT
         JUB0eKKiLaBiTVgye82KWRQyEOi/6BXge/hLDXOzzQvutPlAL/ANr7dcETxiypSqxlJ4
         6WYw==
X-Gm-Message-State: AOJu0YxRS3D1M1T/iqCgqAI4/JqVk8JFdyJ9giemD9AKQtbwyuvTFuzp
	go6OhxzqjmhjxNvX12dpNjYAR9n4CNDGTvoYSEowar76pIQiZHRvjvBPxVagz8zfLKN5vK+FshU
	uyny3xjZF/JV3J++rZL4XW9cakd9ng0Xl
X-Gm-Gg: ASbGncu85bXwrObMaEUtsS6+Ge5xfg6s3ukFP0Trrsjvrev8BqdVouNLXE8KRZ1MsqX
	MHcIriMN4kUMGsSub0Ue3967AGvSKsQ0=
X-Google-Smtp-Source: AGHT+IEH+8w048D2wvjQK4WeGkTupCI+F6zH/OosOTzKIfNQH6i0WKMYQV2+8ZilGa2N//Ide+MxAEQL9stsEp5Jb0Y=
X-Received: by 2002:a05:651c:2210:b0:2fa:cdd1:4f16 with SMTP id
 38308e7fff4ca-30009be4929mr42350431fa.14.1733371154753; Wed, 04 Dec 2024
 19:59:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
 <20241130163801.GA110697@coredump.intra.peff.net> <CAJ-DG_CNPGgfafyTcKWYeNXHD4gsspWakzQoRhfggMqZjenkyg@mail.gmail.com>
 <20241201213636.GB145938@coredump.intra.peff.net> <CAJ-DG_A3RY0ngY-pc6riho=OyzX2VjeaR2LRGb5=ru3CNruECA@mail.gmail.com>
 <20241202203451.GA776185@coredump.intra.peff.net> <CAJ-DG_BLtwg51UoBN4m64ejYUcS99zu54oPYGnC5p+55tNtzpQ@mail.gmail.com>
 <20241203211830.GA1423791@coredump.intra.peff.net> <CAJ-DG_AU8cFdLqfAnEE8N2KSqnQgJ47YJszyXWOvXuuKreAbCw@mail.gmail.com>
 <20241205032246.GA2573761@coredump.intra.peff.net>
In-Reply-To: <20241205032246.GA2573761@coredump.intra.peff.net>
From: Dmitriy Panteleyev <dpantel@gmail.com>
Date: Wed, 4 Dec 2024 20:59:03 -0700
Message-ID: <CAJ-DG_BdAiFk_2eV=JDF7Lth9+Ay=86w-VT26Rt+T5fdN1vd_w@mail.gmail.com>
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 8:22=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Wed, Dec 04, 2024 at 07:21:16PM -0700, Dmitriy Panteleyev wrote:
>
> > After trying NO_MMAP=3D1 with and without SANITIZE, I get:
> > "fatal: mmap failed: Permission denied"
>
> Hmm, that's odd. If you run it under strace, which syscall fails? That
> message should be reporting errno from mmap(), which in NO_MMAP mode
> should be a pread() call. I'm not sure why that would get EACCES if the
> open() call succeeded, but that might explain why the mmap'd version
> gets SIGBUS (I don't know much about NFS, but I imagine that under the
> hood the client is probably issuing reads for individual pages to
> fault in the map).

Strace with NO_MMAP=3D1, I gives:

openat(AT_FDCWD,
".git/objects/34/5819b235838e219d66420b536a54ce4cf0624c",
O_RDONLY|O_CLOEXEC) =3D 4
fstat(4, {st_mode=3DS_IFREG|0444, st_size=3D154, ...}) =3D 0
pread64(4, 0x61a0292e15d0, 154, 0)      =3D -1 ESTALE (Stale file handle)
write(2, "fatal: mmap failed: Permission d"..., 38) =3D 38

Weirdly, it's throwing ESTALE not EACCESS...

Without NO_MMAP, I get:

openat(AT_FDCWD,
".git/objects/51/da8e85661b60d7378b8ac0d896cfc955405fdf",
O_RDONLY|O_CLOEXEC) =3D 4
fstat(4, {st_mode=3DS_IFREG|0444, st_size=3D154, ...}) =3D 0
mmap(NULL, 154, PROT_READ, MAP_PRIVATE, 4, 0) =3D 0x73ceb860e000
close(4)                                =3D 0
--- SIGBUS {si_signo=3DSIGBUS, si_code=3DBUS_ADRERR, si_addr=3D0x73ceb860e0=
00} ---
+++ killed by SIGBUS (core dumped) +++


Also, it's odd that the same set of commands -- openat(), fstat(), and
pread64() / mmap() -- succeed multiple times before an error is
encountered.


>
> Does your system have AppArmor enabled?

Yes, but I don't see any profiles related to git. And I can't image
AppArmor would be version-dependent.

>
> This issue sounds similar to yours:
>
>   https://unix.stackexchange.com/questions/633389/man-cannot-read-manpage=
-from-nfs-although-the-file-is-readable
>
> especially the bit where reading the metadata once makes it magically
> work for a brief period (which is the only thing I'd expect the commit
> you found via bisection to have an effect on).
>
> -Peff
