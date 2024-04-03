Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3880514A4EE
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159853; cv=none; b=kAYYAnxGMc65mgTgga9r5rF5MFeXMqb9sEhGZ7EZptR3WxWC+C1NuEJp7cTiyZQrMSDkOIEdfqPONh0dtGpqe6vFASBKadWiNemQHV2iQ2G1bRJX6BH8bTipREbDckfLZzZ+M7toBIEVYHXm5qQDsPGkT7JAk17qiJaUfFgCTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159853; c=relaxed/simple;
	bh=ok/OQViYccFpeZxRNaMFLzuR0BsIiw4fHKcPVpgGbxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDz2a88As4NwEixaPy9hebEWOJLtAE5H1+cGD1lKWz8m/xAwy798kl3uV0tcWAPt/81J5cSjz5gKaBIGwSMCHfw1fFWE09hOOMt0VkfA1R5Wtgrnd3WIaLgkmabcvoTVtG5Xop9KtYAaCmxdDlCPFn6GOCXLqXBdI1iGMSzJrYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwZfhkEC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwZfhkEC"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e8f765146fso5599795b3a.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712159851; x=1712764651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaVovNBB1rgmg9ieZuehL4AmmZ4PHKMHFPwWySmFOQQ=;
        b=PwZfhkECvT6KyEgrn1CY9/lyJXOgSgzZFL3ZBexciLv/NFUtCIal1ab4h8y8+pcCL2
         5r8NyEpLCH4sM5BoOg0SLuLSUaBpNSnGSKYu13oqGPjlTE3uduFzT8gZlWXwQWqHnH8n
         Q1rG0LdRsqvTlQYmmk/i7Mg2LQhgBieoo4K91n1+31iOS65FTAWAkc85rg8swaeNtXob
         xxLzi5TcfenynlZMM+EwsAjtakw0BZY4HD4J34me4O9R8/aj3GKdTrLvCgqDwIiW6By5
         xTwG8JywHdj2lOSK3yPP3HupSDbsJJRV+hlZi2bLSUbjdBeiMHDYB7t1tM5F+BI9ysFl
         1qNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159851; x=1712764651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaVovNBB1rgmg9ieZuehL4AmmZ4PHKMHFPwWySmFOQQ=;
        b=meNPd5CYmb30dYR/7XrA6fyW8/WANpBEt8Ifr/4ESH0iFJg0PKYijbtaPpTZD67p7q
         3RICzJhGBmMjjZgU2rOKL4MJSBCnDlXOt5PHsvZLWGoqe5s8I/InQ2/CmYrrsnHjEfzr
         WME9wfY+8zjZDBzNCj5CxfvuGBvGe1fNGLYlfMShGjY1zrSb+gc90j26KRValwApgf+n
         Igzv3dA/rwui7KxMXFieJ3kF9U7UwD8bNpwgb0G8UvpcTcoi7gW/Kic4aeuMEArRZ9uU
         WjlTMOttKtvxRGpZ43CtAY3lqMpjrJyNfX19pgp2NOTK7wN/GvQ1SHtlTUfS2QJ0msNv
         lv+Q==
X-Gm-Message-State: AOJu0YyeANof3Dw3xjVXTFDRTVZJEvQ3DYDhYZizSWg/ZeH5C9AU8tPl
	dyoGn9ig7WZhcAkV9+ERpuKnqpNjYy/7D8FFSIc/3uRwPCIgVJ0MrCj7RYXhyrMdY6xC9K5XEC6
	FJa7txKZd4Bh35hZaqU8P6uWwefU=
X-Google-Smtp-Source: AGHT+IH8KYN1nx8cNgQCJv7ubeppm4N/Z1QSQfI3jxhu9VxJx8xiIKWjj6VESbkHEDu18GtGhE/mfUuXxZV4/fQLFyU=
X-Received: by 2002:a17:90a:98c:b0:2a2:510f:fa43 with SMTP id
 12-20020a17090a098c00b002a2510ffa43mr5111104pjo.32.1712159851363; Wed, 03 Apr
 2024 08:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
 <Zg0zs2_QLpXv2PwT@tanuki>
In-Reply-To: <Zg0zs2_QLpXv2PwT@tanuki>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 3 Apr 2024 17:57:19 +0200
Message-ID: <CAOw_e7Y_MwgrrJzuHk7tzBR9a2kDfTnwCzC-7_rgj8UJPKqp9g@mail.gmail.com>
Subject: Re: reftable & jgit compatibility
To: Patrick Steinhardt <ps@pks.im>
Cc: git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:41=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Wed, Apr 03, 2024 at 12:36:04PM +0200, Han-Wen Nienhuys wrote:
> > Thanks again for taking up this work.
> >
> > As I'm browsing over your patches (and realizing how much of the
> > arcana of the format I've forgotten), I hope that I did not make any
> > errors in implementing the spec (and/or that Shawn didn't deviate his
> > implementation from the spec). It would be extremely unfortunate if an
> > incompatibility between CGit and JGit were discovered after it is
> > released.
> >
> > So far I have always been able to read JGit reftables using the C / Go
> > code, but it would be good to systematically test this, ie. generate a
> >  bunch of tables using JGit and check that passing them through the C
> > code (read & write) leaves them unchanged. Or perhaps check in some
> > tables as golden reference data.
> >
> > Josh can probably connect you to the right folks to help with this on
> > the JGit side.
>
> I very much agree, this thought has crossed my mind multiple times while
> working on the whole reftable saga. Ideally, we would have integration
> tests that write reftables with one of the implementations and then read
> them with the respective other implementation. I wouldn't really know
> where to put those though. CGit is very unlikely to pull in JGit as a
> test dependency. Does JGit have any tests that already use CGit?

Yes, but not many (eg. CGitIgnoreTest.java).

I think the easiest way to make this happen is if CGit would ship a
command to dump a raw reftable in a release soonish. Then JGit could
use that command to cross-check that a JGit-written reftable can be
read correctly by the CGit code.  By shipping just the dumper you
avoid having to wait for proper reftable support to land in git.

Probably the dumper should be extended to also support seeks, so you
can also exercise the indexing/searching code.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
