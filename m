Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2022B59C
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622327; cv=none; b=I5WoGCxDdA0vmd8rMcDX7VbFlqXNyZQ/YZaATkkSDDpjJ9YfpEygonfyW/CkmHHim3d32WSWhrn0fIgxzqc9NS1APWMA0zNeR8rxpspz/wMOMqgheMjwrjo1deETn5UmrEJrLOO6au5y6GzqidxAo47i7rxSKCSm17GGLfDFye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622327; c=relaxed/simple;
	bh=MCyzAiLG1iR4biRAT5bQgQqsGj7xYlRg6yNQAlX9oYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbpHt3VYNe+irsf6PPantgsgEZLW3CL+6L6vlYVzbNhHnXYEalyi7EJKKCEuTroBRE8wSuDhnn5obP4VB+wbvOujNqEY8g9rL556aiBksh8A60olU2/Lg68CeG3AZp5+CQD5MMANt0G8jhQojYWteatQiBZGkO0PHbtc+RJok4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF/V4qmh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF/V4qmh"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so5663071a12.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622324; x=1742227124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UvWwnsfFGw7CWHl8/KyrW5xFZCDtR0xaVAtOlF6nes=;
        b=cF/V4qmhSH911vGZE0nfrI/o/vwRhxYXRu46gHHac/mSyxHZ435/hNLSz2grHNnJQU
         qThgTo/LPu72yGMDgV59xHKbPxtl5zCVqQKPlV/Y5yNF0ox2Kzk8TWQniYx8Go7IWpTr
         hoRtgsXTja25/QGVFoAAZG4jEc+tc50Tv1CH8QyoZcws70OvMZUZ0ulfExdiiB0MN/mI
         LmC2ZC/r1RA+vemgR142Zmex59bSy8lBasFukdDaDYRxOyFXV1PeeJCB1IKDLIbWAq5l
         k+xoacuvXcuZt5qrHAS8Y3XpuP7C+MrtrPYRkAPX/GaLp4YdKQEQZLa+gBXwq27La9kP
         3pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622324; x=1742227124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UvWwnsfFGw7CWHl8/KyrW5xFZCDtR0xaVAtOlF6nes=;
        b=B3qaG2sFvo7N3+cZpsAe3ZeIuNBZWItYFgoSOMyeio1GX1RKWMAAqkPiMBonjFw571
         ADWX2rUdHREyeospJuFNlCJ1zr6OmbiXef907eBCoUqw+xBn8Kzy/lidaD5V9aBLdc97
         9Q1MPxO+AX6tZGR7K7N0Qp0iGL92r4mX4tDH4nTyzyhxfQC8wNbzGx8JFFawDgPE0VKM
         98BFDun68WzAXXoBNecEjPU7C33IMwfnRpw/+Tbf48ZWF/42WvTTAn2ZMQ9n8f+BvJtR
         A1obsR7istYSPMgbHhnv3A4fFPEZu4Ryvw25sTpWI+1Qr528hTRbXWbM0BWOHqPeCbiN
         FS9g==
X-Gm-Message-State: AOJu0YxMfvAegUNeAGAfytuZ5I6isg/29h6enLZBh98Vy++Oo7z2GZ78
	+I/4zu6T4HhjW1Ju1CoWrHdf4ffy8vBNx39Ogo6BnpBBuXoDTEGGeUgV53eeRUuChncQBjnPcc1
	oUseHF41aTzprEWWgiC9SM+ytCQA=
X-Gm-Gg: ASbGncuCzCoJFdg+I0R24+pZ1qTDXtAJUx506oFOw4+Sov/Yr5L+I0A5KalyLlKbxvw
	RPZe6F8dnHMTAns1tG7O9gMyQvs3SqzXOWWYkCpFOaGhNk4ae9w0m5DuU0sIkpAr+aYkDUZhxC1
	/8vKMJTMZ9RC//kIOMk24QCMBBEZ19
X-Google-Smtp-Source: AGHT+IHJDBPtOmaf0nYGbipwAZUUVC0TCHDL72RgPNBNPmyXye0BzBImPgdL8ZbrZt7XYJEAgZJ89/L13WoMU7YYCfw=
X-Received: by 2002:a17:907:15d4:b0:ac1:fb27:d3b7 with SMTP id
 a640c23a62f3a-ac2527048a6mr1124176866b.21.1741622323717; Mon, 10 Mar 2025
 08:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210430232537.1131641-1-lukeshu@lukeshu.com> <20250224142744.279643-1-christian.couder@gmail.com>
 <20250224142744.279643-5-christian.couder@gmail.com> <CABPp-BFG=g_tCz5HjjsLXNc41aYiGvLi_8oq3d5o9cBLKmd1og@mail.gmail.com>
In-Reply-To: <CABPp-BFG=g_tCz5HjjsLXNc41aYiGvLi_8oq3d5o9cBLKmd1og@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 10 Mar 2025 16:58:31 +0100
X-Gm-Features: AQ5f1JosSJioZ4p_Gx7Ue03B9B1zLlM4V_cIm6mbNOhJw6_uGsZxYtdIJxuN9NA
Message-ID: <CAP8UFD3sSnvGwebKRvYRkf_V4RjUT0G=h0tpGDHkrKfvYZiZ6g@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] git-fast-export.txt: clarify why 'verbatim' may
 not be a good idea
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Luke Shumaker <lukeshu@lukeshu.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Taylor Blau <me@ttaylorr.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, 
	Luke Shumaker <lukeshu@datawire.io>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:26=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Mon, Feb 24, 2025 at 6:28=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > From: Luke Shumaker <lukeshu@datawire.io>
> >
> > Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  Documentation/git-fast-export.adoc | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fas=
t-export.adoc
> > index ab9a315fa9..1b19f17b78 100644
> > --- a/Documentation/git-fast-export.adoc
> > +++ b/Documentation/git-fast-export.adoc
> > @@ -29,15 +29,19 @@ OPTIONS
> >
> >  --signed-tags=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
> >         Specify how to handle signed tags.  Since any transformation
> > -       after the export can change the tag names (which can also happe=
n
> > -       when excluding revisions) the signatures will not match.
> > +       after the export (or during the export, such as excluding
> > +       revisions) can change the hashes being signed, the signatures
> > +       may become invalid.
> >  +
> >  When asking to 'abort' (which is the default), this program will die
> >  when encountering a signed tag.  With 'strip', the tags will silently
> >  be made unsigned, with 'warn-strip' they will be made unsigned but a
> >  warning will be displayed, with 'verbatim', they will be silently
> >  exported and with 'warn-verbatim' (or 'warn', a deprecated synonym),
> > -they will be exported, but you will see a warning.
> > +they will be exported, but you will see a warning.  'verbatim' and
> > +'warn-verbatim' should only be used if you know that no
> > +transformation affecting tags will be performed, or if you do not
>
> perhaps it'd be worth clarifying this slightly to
>
> "...transformation affecting tags or any commit in their history will
> be performed..."
>
> Although, I'm not sure if that's strong enough either.  Even if users
> don't transform the fast-export output, the fast-export output will
> have already possibly undergone transformations and fast-import might
> send it through more.  For example, if someone had a permission
> recorded as 644 or 100640 it'd be canonicalized to 100644.  If they
> had a duplicate tree entry or an improperly sorted tree in their
> history, that would be corrected by fast-export + fast-import.  If
> they had extended headers other than a commit signature, those would
> be dropped.  So, maybe it needs to be something more like
>
> "..transformation affecting tags or any commit in their history will
> be performed by you or by fast-export or fast-import, or if you do
> not....

I agree it's better like this, so this is used in the next version.

> > +care that the resulting tag will have an invalid signature.

Thanks!
