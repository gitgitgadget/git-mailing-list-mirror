Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7B327A2D
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645178; cv=none; b=dgFvpirRyjqNyXhny6P7ArqWPG0sUFaO/P8X+xeHkGjnj2hUzPQYQSKp2MG/Bt5QMmdYeOJboYMHcrEb8zZdi6bgnPOG17DnhQ0KI+y8FUOCE0JocRygCl1/Fd65yLvLXyfEBQ6lQ/fGmwYVj/9S40tcmOM1WPGpci/7n7YqtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645178; c=relaxed/simple;
	bh=Ww3yCvaZ9fyE5q6KO9WQ3kalpExwuL5WV/prQ3G6/VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bf0w6QlJdoKQTvJTZRaJs8nnAW3OPjV9un0ttUIuIbp6G06hkkhy8J7b+abiuBIepMlQx7Obbqhp7zE9cKipR0iiOT6INZMtyKmuwmMYSeZsmlcGn3npnMsLwE8qQmnQi4qbFAgqZAVor2tZ2HH72hlZxNB0aC6SJUdsS5p8bso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/vHUbcx; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/vHUbcx"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-365df96398bso432551fa.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758645174; x=1759249974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww3yCvaZ9fyE5q6KO9WQ3kalpExwuL5WV/prQ3G6/VU=;
        b=d/vHUbcxmFijegnyQ1ObHI7u6yigslnB2W1UXRMJTZyk7U4xda9qADhhT5kcwf9nfU
         IDw6z3lBqmePqP9J050bqhEBLkSg2BT6dFl962dZX6sQPFMkxPQPqyQQ1JYWEkVh83Ci
         SNR/w27mlR1DUdQItxp9FK2YPyupymdAhDVcHy5B0dz57JnAALdhGlMOvYa637OOQWoi
         Oke5cW/gdIElTUAVAE5LQJMrPvBaKI5BhtwYGHpJ/oai7ckNXyCf4+8jfo66mIZC3fLV
         9N1XJRs0JMV+kaGTTG0HdZPf5t7n9eQieP0zJIQOZ6y1BOxR0kBEtV3TXwg6aa9WaJ9y
         FJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758645174; x=1759249974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ww3yCvaZ9fyE5q6KO9WQ3kalpExwuL5WV/prQ3G6/VU=;
        b=qS6HDvvR0ufpq2IfSwWXCZgJ1N+tumyQcA+a44dARoBlTWd9S9sC6HUPiU0ZXgM/U1
         bnDY8TkhceuGljZRiicQI9XvNRWvPZMfoG7jHPuCeI4E/pipQd1IutalqHBhzKnz7yBE
         TPA8rm7XRsCmHIxMlIS6IiWo3EJsBGw1/xVEkPcolA2EdweVq73rRahgF3KEqW02RXvG
         967gfvIw11TAXFy/gyeOEkAXcETfPbVGIcBjKaKhQhPHOhNU2kanzAv6yK+GGJYjrhwp
         b8KrCW7r+FQYPDvm9nOZ4hy3HdSpcFBhMqCLYijJE7FbAW4GD+3ulVnJ5LXZaBvQ2h/6
         epeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFi9ycsuM1Y8pU5s9FWXRKwhUL7Rd1RbpbBE4J8F1c8qjbPefGrq37hKQPEwjblYx8kwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUqN0/4KIz+OebE3WxmfZLnrq+ddaTFBBvCYeRsRE1Y7M9sqn
	GqWIm/D5QUUHC0Q1bnRUrM4GvJ4WC7NjDGxkvLFd986bG4Vqrsw47zEwzRJMBZxbK7Eb5ppb+mJ
	Ohlgj6cRznAbvrh+mWyrn9O6iQZXZB34=
X-Gm-Gg: ASbGnctfqfta/ZFDjwe1DX+mOosXAwSMYjaoIMtzqovEnrvxuYkhSEbOP7Q8sLHjSy2
	DnitB0R8VthI1XVItF7tskKf5kpxL5O0iOGBZb8p24qWbj56G1ZKYv4/nmvkKLVS4xUBgRMcjso
	w4hJyKr+HdS+apuhpo/hwOZ/yOjYmQhvptUC+Jyl7UqemfN8+SEKPP1q2fIzy70vGXN1LIbkREd
	JmdN4uFqMLbgkpfeG0=
X-Google-Smtp-Source: AGHT+IEn78UmlUZZi0pwXZDRRXE7F5Lpc3pPByZG0o0nwwQai8lRlLuSD13JzV9CgMmj9WMOAiDj4s2bLTJUl4vVzc8=
X-Received: by 2002:a05:651c:1541:b0:360:eb0d:76b3 with SMTP id
 38308e7fff4ca-36d13f3b716mr11109821fa.0.1758645173929; Tue, 23 Sep 2025
 09:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <xmqqcy7pc8ix.fsf@gitster.g>
 <CABPp-BHJUkSERQon6xx=sHrhN7i=6ekv+Hz1+P+2mh0=Xw15Mg@mail.gmail.com>
 <xmqqy0qcae6z.fsf@gitster.g> <aNFIwFD6E6Lngy5M@pks.im> <CAH=ZcbDkDfc6j_gQCt_q9RLP_ozYqr09i1-xe2mvhSQRgf8MGg@mail.gmail.com>
 <aNFz-0rO79l7crZ5@pks.im> <CAH=ZcbB_AZ7a=kQ_tHRtm7jPD6h_7AAiQYyaMQrG+ijj8Dyvrw@mail.gmail.com>
 <aNIr_P6HMEvwERUL@pks.im>
In-Reply-To: <aNIr_P6HMEvwERUL@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 23 Sep 2025 10:32:41 -0600
X-Gm-Features: AS18NWCPZ5A6Y0-JBGhfxLDvxLHDOhFypJTkh2PnRbgOAKUDjdQXCuZ7i9RR08Q
Message-ID: <CAH=ZcbCLMHzMXZu3SQzJ-HvLuiG=goZ-xQWwr=J2Qs=k1=fy7g@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 11:11=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Mon, Sep 22, 2025 at 10:27:32AM -0600, Ezekiel Newren wrote:
> > On Mon, Sep 22, 2025 at 10:16=E2=80=AFAM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > > On Mon, Sep 22, 2025 at 09:18:14AM -0600, Ezekiel Newren wrote:
> > > > > By the way: I'm also happy to change attribution of some of the p=
atches
> > > > > in my patch series to mention Ezekiel as author. I don't care muc=
h who
> > > > > is listed for the initial patches that introduce Rust, but would =
retain
> > > > > my own authorship for the "varint" and "BreakingChanges" commits.
> > > >
> > > > My only other concern is with varint. You use usize on the Rust sid=
e
> > > > and then uint64_t on the C side, but I'm ok with fixing that later =
as
> > > > it only breaks 'linux32 (i386/ubuntu:focal)' in the github workflow=
s.
> > >
> > > Oh, this is actually an oversight, good catch! I refactored "varint.c=
"
> > > to use `uint64_t`, but then forgot to adjust the Rust side in the sam=
e
> > > spirit. Will fix.
> >
> > You also missed updating varint.h.

Oh, I think when I was editing your patches locally varint.h got out of syn=
c.

> Hm, am I missing anything? It does use `uint64_t`, and if it didn't it
> would cause a compiler error due to mismatching declarations.

unsigned char should be replaced with uint8_t. I don't know the exact
location that causes linux32 (i386/ubuntu:focal) to fail, I think it
had to do with specifying uint64_t on the C side, and usize on the
Rust side. usize is 32-bits on i386/ubuntu:focal.

> > > I suggested in [1] that I can change authorship of the patches that
> > > introduce the initial infrastructure into Meson and our Makefile (so =
I
> > > guess patches 1 and 3) to instead list you as author and myself as
> > > Co-authored-by. Is that something you want? Given that you have
> > > kickstarted the whole effort around introducing Rust again I wouldn't
> > > mind that at all.
> >
> > It doesn't make sense to me to list myself as the author of any of
> > your commits, but I would like my name referenced in your commit
> > messages.
>
> Okay, will do. Is it sufficient if I say something "Based-on-patch-by"
> or "Inspired-by"? Don't really have much of a better idea for how to
> include it, but please let me know in case you have any preference.

Inspired-by would be my preference.
