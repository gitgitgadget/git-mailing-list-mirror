Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80A21348
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756042296; cv=none; b=GKeWF/dN7IkSMxb68vSGtcMkcFVIsJhIOmHzPB8mwv9eEjvYghz3byAxJyJTtWg4ReNB7I8FOVxD+0s0I9saNXDaZ/TfTcqrk0Uk+xhMSUHOytQ5Na7S9RFYwXEgnArRm9oA5quIcnLpFRsqTTbr6qZY7TDIjlRXNQVBOA1H7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756042296; c=relaxed/simple;
	bh=SjQ8aHu5KvHNikzgxtjGagWrTXTy6OgERhPkK0I5+M4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DyztiZ0Nj6q+RIJc9ASrpBV6mpzoyllr6vWcmZLXRd+LanCoGQ23cD9/++D0OgTfCr4SYDl/NKBc63x6OgWBbulgXMAG5ZDuA3JFpdawmfnemwSrtmNeRdQDD2+CFdMOXeH3Kv8j5LhJULI+5OyTyD1Pz2rOi3z+X/TAyy6iMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iESkNNoO; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iESkNNoO"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e953397c16eso662347276.0
        for <git@vger.kernel.org>; Sun, 24 Aug 2025 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756042294; x=1756647094; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uq6eUbmwTXnAp+GsvMkDYLRWNydy+w79MPrLr48oT8Y=;
        b=iESkNNoOdCW4V/NhH9dafxZSSLOu0malTe3ZWmD52o3lGbgmu6SRXI+9XhQstTxMao
         zjX2Cir1gzguDWpNKJz1wrTBvc/9Gvwpzp5joGMVbWeDkdGedtjl9kLrtHaEdHys6s6C
         8d9x+MrKNwYwy7XdnrMYO1lDroobBDujJpGAG2cnVaTqeinxE0TAOMUpqeDX2q9TcOGE
         hTJgG+3LXuWQUOlWlpaDgAUtrQ3dzXh8jcxi8awGY72Tik4acOF5U/KbUr2Firc6cvLQ
         KRy37ekfI8MAI0N8ZeK7KOzdTi81GhWbVy8dsX4HNIb+EDxr5oti9wCLGGRA88zDyPVc
         PExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756042294; x=1756647094;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq6eUbmwTXnAp+GsvMkDYLRWNydy+w79MPrLr48oT8Y=;
        b=TyOdH6LqohBD0gRuJMWB1GGHp62d+SsC+pdqsSC2grhdy2dv25RBExC1+WsoJIOjMB
         DJnhNRYn6YUbZflrU5FulTZgl7rBlt+FYAqS94r777gAqXnkC5NdHoJO735b3fsmrzOm
         cDB1wpTukA34CjAUFUkgilQCOt9yd0suI0jVTjHlNcOH5E7hHdNpiYchdLJ8E+pO/rJ2
         4892eexV8tN25ETrCHWP64MQpkAWt7KIYvfDqXgeIuZJdlQ4DZkm558iE8m2iDnttMkQ
         X3XG0rTB7bkC6aWjT+r+pDjiTkvd++uoX4808av7RcQrGElMCsIHb6C2CIm0w9U7GbKm
         h10w==
X-Gm-Message-State: AOJu0Yyr1VQSOGE/mRApf5ymyKMk+sBFbLB1iPsrdjK4NrinqBkgqYRf
	c2eDgJpYfdKI4vvNUxXdX413MDGCIZ0GqfQcWhGsrPxo/yZLYUDS2SJb
X-Gm-Gg: ASbGncvpUi1Psw0GCXPxiz9e3rdEbOASGcKhLC5r4UWZUIdsWp9mmYrOuDeVwr57F+q
	rRPPM4bskhHEgeLw70lKw1kx4klBLfTwDVgkluzDHAO96GTFAAcvCgDncf07pAsjxtytE9CBTQN
	1n90Nt+rvKC6gPihJ3EfBmkmqu22LECZ+cSOF6P5+3+RphRihukRDg/NISHk0I98EnJXjqjGZy9
	aqihl0VnnhrqZ0KEFpoCaFte1r8XF74snEMznzq0yQGr91PCADDeE+SBt2Jjf7x3GER7qGQ19TM
	YW5YL6Q+6QFUghLn01680pRLXr4ha1vw8k4abMWXyqSBUsucVAi90grs+VOb5MtfVEzaa8Ypu9h
	mdNwvILry2CCKKnOij4qqbu1WpIhAfa83/6/rmYe0sihe5pFAuv8=
X-Google-Smtp-Source: AGHT+IHGeP5/tgdU4mHvGkM67395GqM1Mb7SHZLpi1YpkS/nfkfzvAPX92NDoqX3GD1lNDyRoWxRug==
X-Received: by 2002:a05:690c:450c:b0:71b:b928:74ed with SMTP id 00721157ae682-71fdc2f0d6bmr118292047b3.20.1756042294197;
        Sun, 24 Aug 2025 06:31:34 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:9915:caa3:d40d:9850])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18aeb27sm11199557b3.52.2025.08.24.06.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 06:31:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is interoperable between C and Rust
Date: Sun, 24 Aug 2025 09:31:22 -0400
Message-Id: <71B2DFE6-77E5-47FE-9FAC-AFC1B85DA0E2@gmail.com>
References: <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Eli Schwartz <eschwartz@gentoo.org>,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 =?utf-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
 Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>,
 Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
In-Reply-To: <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 22 ao=C3=BBt 2025 =C3=A0 23:56, Ezekiel Newren via GitGitGadget <gitgit=
gadget@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Ezekiel Newren <ezekielnewren@gmail.com>
>=20
> Trying to use Rust's Vec in C, or git's ALLOC_GROW() macros (via
> wrapper functions) in Rust is painful because:
>=20
>  * C doing vector things the Rust way would require wrapper functions,
>    and Rust doing vector things the C way would require wrapper
>    functions, so ivec was created to ensure a consistent contract
>    between the 2 languages for how to manipulate a vector.
>  * Currently, Rust defines its own 'Vec' type that is generic, but its
>    memory allocator and struct layout weren't designed for
>    interoperability with C (or any language for that matter), meaning
>    that the C side cannot push to or expand a 'Vec' without defining
>    wrapper functions in Rust that C can call. Without special care,
>    the two languages might use different allocators (malloc/free on
>    the C side, and possibly something else in Rust), which would make
>    it difficult for a function in one language to free elements
>    allocated by a call from a function in the other language.
>  * Similarly, git defines ALLOC_GROW() and related macros in
>    git-compat-util.h. While we could add functions allowing Rust to
>    invoke something similar to those macros, passing three variables
>    (pointer, length, allocated_size) instead of a single variable
>    (vector) across the language boundary requires more cognitive
>    overhead for readers to keep track of and makes it easier to make
>    mistakes. Further, for low-level components that we want to
>    eventually convert to pure Rust, such triplets would feel very out
>    of place.

I=E2=80=99m mildly surprised Vec isn=E2=80=99t a good fit: isn=E2=80=99t it a=
 pointer, length, capacity triple? But it sounds like the main issue is allo=
cator interop=E2=80=A6 which I would also have thought was supported? At lea=
st the current version is documented as being generic against an Allocator, t=
oo.

>=20
> To address these issue, introduce a new type, ivec -- short for
> interoperable vector. (We refer to it as 'ivec' generally, though on
> the Rust side the struct is called IVec to match Rust style.)  This new
> type is specifically designed for FFI purposes, so that both languages
> handle the vector in the same way, though it could be used on either
> side independently. This type is designed such that it can easily be
> replaced by a standard Rust 'Vec' once interoperability is no longer a
> concern.

Am I reading the patch correctly that the ivec implementation is primarily C=
? I=E2=80=99m not familiar with too many FFI projects in Rust, but I might h=
ave hoped we could write parts in Rust to gain any benefits from that, too. I=
s that a fool=E2=80=99s errand I=E2=80=99m thinking of?=
