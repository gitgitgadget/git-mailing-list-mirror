Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D901F152D
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304613; cv=none; b=kbSXqCHgxuL+szba+iEV2Rsy96qP9SASUmdB4FvtLW70L/z5PJB7mxBBQ6QE0lEHhV+s69jqJFxCUw3dOlX6rt6hvYD5X2Pz1I4uKwRyf3cMCq+n6Zg1Xv4q8frPemYM2VgRkvEqoxwDBURBbWi4+OnhvgZgqJMoFiPy+6a7cv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304613; c=relaxed/simple;
	bh=K2bvvPsSjzcFhb6dyygQ0MWxOi3kijP4N5PWs9P2vsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSNG1T2VFoLpBBWuzD2A3KBGvh/sr75YCbGcy/eupScBrHLN74Qq/027HGxQFVmDIJ1Vw7eoh1HRXerXvQtV9YNJOg+IYnikcjA58ADDLOo/MP0I4IiYxWVkiBvcuID09nBfOtLQM+V/gP+Gko0gWs6xFGLmIapyaojNnrR/r98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcNJPqZr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcNJPqZr"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3515a0bca13so37298491fa.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758304610; x=1758909410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2bvvPsSjzcFhb6dyygQ0MWxOi3kijP4N5PWs9P2vsM=;
        b=RcNJPqZrQG2PNnSigRPaYHctC459o4z+cjyul6KOT/xtlh91utZ5uSQZUCyw4RnzEr
         lXqd26c4RkSnNR5/yOiKKD/0EdP8MsLbiJ3XzSZPGlc3+p06LgHAbX3B7nW82eY/tc+k
         mHMHMnflBvQyY7AT8w/H+VdPhH/m0t9SFIqNFr9Wi1AP7JlJK5ZkZHNsDhTJrBPflZLs
         KrdJ+UAoxzyGuV8K5vylJ/UMBtPFIw0jSEAubqX40tUVwVWQkG2hTr2GeisWkImIHn6k
         gLq7NWCcsmH1LXUO3sx3qGlHLai96JSYJSvjnhOCaGPJGqTD0F6IJQ0mOqlg7U5hRe7X
         mfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304610; x=1758909410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2bvvPsSjzcFhb6dyygQ0MWxOi3kijP4N5PWs9P2vsM=;
        b=F+UPXapxof9MSTac1HB0/BtFMBnyyGPzcsZzkGQEfq5v1hBHKlb/5Gh9DnR9K5iBJJ
         yIh9JE5YlBKAkd1byZcFRXOpb6zHOfwRFh/I6gA2rjIFppFt7jo1sqG+BYOm6Ffr6lK5
         v82LCilWf8CsZkzjfZhdP3U/gQKpU7NhaeiyFITov7hohTxDbpOEhzsELx8ZuZv8UcPH
         60auANpiA//nseM928Z2Hh+I2ESSQpkH0NYThityisycfvQz3tabegwPEFPbTcl22y1d
         z8NTVYFQQ/Y7dBEpWSovBEdK+UqlOc95t9o8tE6yWBtoZdH89UytwsBmZEr5wO4sQVoX
         znGw==
X-Forwarded-Encrypted: i=1; AJvYcCU1pup3OpriWwwTKiugaVf+3xaYj0nytpD9WLMS7QgmvfeDBWwvUkj/9vfEG8rgBnmTRmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ltJfiUiOMgRK7/hannEXmJdE18wUk+6crEF3EqN54AQX9ccZ
	m5dd0skSN8d4rsVT5i/nVS3O2dVeSeW6wOW7P22QD6X9pKWeq1dpIQH0LVCUTd3lEgK4kfYcYJA
	8NIdA8mY93oNRYyJEqAxc2q3r++L/9H0=
X-Gm-Gg: ASbGnctwz0HVfuodFiNjkZsdyW8IVoHm+mOo8jMwciQ/+yBNOPYZJFA+z+RHjlqY3lv
	Irg5i9FNUPU8nvG+oKzLNYXHdMPk+iwF2550jDhfV7wGHCkC0vcuLUJsYCX2TvcE/VT8wxDXAGT
	HDx4TsnlmNL6UYt4QymF0F0fUkJsUm5wUTJ4+MBGze3v9uiAEnh0KI1LIhbPIqZ149NBT8i+JYf
	jjX98Zw
X-Google-Smtp-Source: AGHT+IGnPpIt1TpHS7FHlQKIzbxgKUQtI3qi9PAr9Jr0RZ64MsI1buF9NuFj2Qwo8+5zhBh/P5blA6TJLurd4CMn/Qo=
X-Received: by 2002:a05:651c:4343:10b0:35f:fc7e:ce48 with SMTP id
 38308e7fff4ca-3640c0177efmr13802431fa.19.1758304609267; Fri, 19 Sep 2025
 10:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4C760AB2-C102-43A3-B0B9-11E248F3FCE0@macos-powerpc.org>
In-Reply-To: <4C760AB2-C102-43A3-B0B9-11E248F3FCE0@macos-powerpc.org>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 11:56:38 -0600
X-Gm-Features: AS18NWBVd3u0b2RyiiV4PnK3IcGE1EEyOvamgQ7qbj5BAYrunkAW8w1tFfnl6_A
Message-ID: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
To: 20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im
Cc: ps@pks.im, Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org, 
	collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org, 
	git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, newren@gmail.com, 
	phillip.wood123@gmail.com, pierre-emmanuel.patry@embecosm.com, sam@gentoo.org, 
	sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 11:36=E2=80=AFAM Sergey Fedorov
<barracuda@macos-powerpc.org> wrote:
> This will be a disaster, please consider not making rust mandatory.
> It will break git for all systems without rust, in effect killing not onl=
y possibility to use GitHub and other git-based services, but also breaking=
 build systems, since many ports =E2=80=93 and package managers =E2=80=93 r=
ely on git to fetch sources.
> As for local version control, git could be replaced with some alternative=
 (likely inferior, but at least that is not the end).
> There is no replacement, AFAIK, for build systems and for git-based onlin=
e services.
>
> P. S. In case anyone wonders, this is personally relevant for me: I won=
=E2=80=99t be able to continue contributing to open-source anymore (at leas=
t certainly not like in past years) with git being unusable due to broken r=
ust.

The mailing list has had extremely heated debates about this, and
there are many who would agree and disagree with you. So please try to
read my comment as a genuine interest in trying to understand your
situation. I would like to hear why making Rust mandatory would make
using and contributing to Git insurmountable. We know for sure that
NonStop currently does not support Rust at all, and that there are
problems with porting Rust to Gentoo, but I'd like to hear what OSes
and Architectures you use personally and professionally and why adding
Rust would be a bad idea. Is it corporate policy? Is it that the Rust
toolchain doesn't exist for your os/arch? Is it that Rust is a new
language and isn't as battle tested as C? Something else?

I believe that even "I don't know Rust and don't want to learn it."
would be a valid comment to add as well. I think the discussion of
Rust has been so hot because we (the Git community) don't understand
everyone's situations and how they'll be affected, and what could
possibly be done to address concerns.
