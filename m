Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1CD1DF25C
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258090; cv=none; b=aTgRc9BHD5dPpMjkHR2ddpYdIHs1rBgJl1HU5n4MbLgvW52/qcgg9B5CbSfYY6rJmACFZZhJjaQaAbgg8cXd8C52DdviWqAvQu4RreLerlIuKJtdCwAhYFfIRKza2N+uCNlpaKLRkzipIuPDNnGXa8kqmB6QZnr4pqq7vQf+yFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258090; c=relaxed/simple;
	bh=ayk6dC16Wn+IbY8SwvozYnmaaYMndRBAN5GPVpMzzx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVow6KUnJlJQOTUnMxlOisLwU4EAre2xhpRNJlTFfqbmaOUi2aWfn4ddPCXcf4q91NO/JiAvL/dJBbSuhNnCl7T48iYDFMaQzW+j2McCJILkMf52bAuN8W9QDW8XTsTcnggbjb3sjXAsWX5i3vz6lzsPjxY71IOqoMQw3BXu07c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkV00jvU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkV00jvU"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa696d3901bso2089188566b.1
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 05:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258085; x=1736862885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsoNAsByWCvwz2AP69j97be+9MiteH63U4f4d0wxeCc=;
        b=BkV00jvUce19ObUfz1JwMRnJzxQqXTHRGo9a1z8kdkk8104bdDpvcUFO6oA2xeQumG
         xr21wsB2iK0uDcGfEhL8zakHUPLnbF4zDxPAfkJFqtMF+xS5OLZaJxnKrg58eYnDtyPP
         XNy5ZmpBm666uWa3GhUR5KqmiXiSJlLgIRMaQDAvRTAbZV3hWiXwGFA6CvTMWFvTk9xF
         G3zPyrJl9Lzc7e32+W8o86PRUVgA03VPSQm1tTJFthEIHjBB/Ru6rMlFEQPTenjkz5np
         rslJmk3FG+S9qtJekzLC0Oa9dFOxCssR7U0+qePrwTKjZ+OdYRoUyRzVGGRvVdRLNozh
         rPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258085; x=1736862885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsoNAsByWCvwz2AP69j97be+9MiteH63U4f4d0wxeCc=;
        b=Kkgmhhi/A4A0rG9d2fHEbWXIz2Z9r6pnYH1OJsi3BB2jNluKr/ftkIFgQgfW+bl4rK
         JqS346C4gFkcmPMD+v63T5t1hKEw/km4Z+v0QJCYKjMntl32B0tlofioxopNDty9hB3Z
         iu7Hhnfsd8kCPbHUoyWLvgtxvuYk7nvURw0+5Xayg7l5w9iggsLpXpXVTL94PFqkjI1b
         acA/4PE8zyvNLaE/xWma/CBOI71bdaY/npMhqR5PAuZA+wkgqlMP1o3zi4CKc6MHDUl9
         6hIJ2L8rFZjujTOVbLquwgCLWHgaBrOS2mL2wKDl4IQh5+3z44dTWkJ1iD72S2HA0m2R
         jCQg==
X-Gm-Message-State: AOJu0Yx4kXAi/N4ZF7G227uXtKYMf082Hjxm8Vp10UwfhCaBw6DUGy+7
	LGxzOsVH+U4BQbD79gKb2I8boUPsYi1Rm1J2pIIkvJQVY3ryAUfe07UF4ZlXk2BE1YRaIYQ5XFS
	UyW6yZGLTN80PEHPqC/5w9gFmgqY=
X-Gm-Gg: ASbGnctjbvZtmbeqYxKwYrPaqmoBdkTLZH4AFyLwEpPgvDbaue9Ot0xjDsuIMxofjTy
	Tm4vjgTYkMjO3Ry0VcUWaqhQbjANArN4OXB2EBOQn
X-Google-Smtp-Source: AGHT+IH8ixavTi4/CS8Vky50m5lS9EWQT2Kj7IfKa4VfFcFNVI3E2fT8k4PtRpZgJywVkxraqlIMA7eJpV3S8McR9Lk=
X-Received: by 2002:a17:907:a089:b0:aa6:8e61:669d with SMTP id
 a640c23a62f3a-aac289357e7mr4333772366b.9.1736258085130; Tue, 07 Jan 2025
 05:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-2-2ce87c053536@pks.im>
 <CAP8UFD1ALC2f9iQady35MCdm18V3u9+b0iRhgx2Zd_UTeCY8vA@mail.gmail.com> <Z30ipNB88iyaWMBT@pks.im>
In-Reply-To: <Z30ipNB88iyaWMBT@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 7 Jan 2025 14:54:33 +0100
X-Gm-Features: AbW1kvYHjQDTf812aYn3nf7ExYIxwc218zs5WlllPvcsgQH2wVAoaMutlwJuDx4
Message-ID: <CAP8UFD2MLfHVhz85sEJwJqhd-hFPUOm8b9eBSbjTgV=k966Tjw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ci: merge linux-gcc-default into linux-gcc
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 1:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Mon, Jan 06, 2025 at 02:25:23PM +0100, Christian Couder wrote:
> > On Mon, Jan 6, 2025 at 8:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > >
> > > The "linux-gcc-default" job is mostly doing the same as the "linux-gc=
c"
> > > job, except for a couple of minor differences:
> > >
> > >   - We use an explicit GCC version instead of the default version
> > >     provided by the distribution. We have other jobs that test with
> > >     "gcc-8", making this distinction pointless.
> > >
> > >   - We don't set up the Python version explicitly, and instead use th=
e
> > >     default Python version. Python 2 has been end-of-life for quite a
> > >     while now though, making this distinction less interesting.
> > >
> > >   - We set up the default branch name to be "main" in "linux-gcc". We
> > >     have other testcases that don't and also some that explicitly use
> > >     "master".
> > >
> > > So overall, the job does not add much to our test coverage. Merge it
> > > into our "linux-gcc" job to reduce our test matrix a bit.
> >
> > I understand that the subject uses "merge" as the space is limited
> > there, but it might be better to be a bit more explicit here about
> > what the patch is doing, which is:
> >
> >   - making the "linux-gcc" job use the default version of gcc provided
> > by the distribution (which is ubuntu-20.04) instead of "gcc-8",
> >   - removing the "linux-gcc-default" job.
>
> But isn't that what "merging" is about? One merges the diff of side A
> into B and then removes A. I don't have an idea for a better subject,
> honestly.

My comment was saying that it was fine to use "merge" in the subject,
but that, in the body part of the commit message, it would be better
if there were more details about what the commit is actually doing.

When the commit message is not clear about what the commit does, it's
difficult to check that the changes in the commit were intended.
