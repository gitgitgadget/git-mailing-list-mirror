Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B427AC44
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751394257; cv=none; b=tAP7wgNW7E8A50si/xrbAFONfjqUOi32rC24e7emwz3yancZcJnouHEA7BEI9jGJ5tkcCUbEYlSFRtnNe9yVX3GVfzw2P0DGE9DO4zuzaaVf4jtrvVALGsQCUI9mP61TtbleX0wE456z7PeJno/INlOwrepCzfSgGU2r+OiWx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751394257; c=relaxed/simple;
	bh=aS7t3aEEwme/BzForkqhwoYZDDklICLCaqVdkZ2qVt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5mCiBD+eY5e4d9y7YeLob7p/ofC78+q7wE1F9r46ATscDVgIfqnV6PORw1o2ojxSYILYy4FgLLr391ZkcPS/n9qMGWMxUuYiLR+lavyioG0GKtH+6EL3VpibtphHwbhEODVn/VpqhuG0Z4Nyc0qdXGsPjyBW7mMiFNMOblqqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDODg4Ta; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDODg4Ta"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313b6625cf1so4512776a91.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751394255; x=1751999055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez/pXwBjfYVBR5d646eCmsiXNrryWpQjuqLU8+evQ0I=;
        b=eDODg4TapqY+/KRa1FAF9j/xEtW7Uhu2hEfbxduUWe4nIlfShsu6SfLnthr5cKnOuW
         BDZjZIMszu1blLB/uExAZvCKfwGPxTq5BX/0SgmYTeBa5As4CiD4MkbdGX8GVgmuYjSw
         JMztCvI4UdB4ireKRCPlhHzqDpoY8OC1X/TKvHiYk+Bs33Behd9YPUfa0BN6SzJDP0EF
         W/6wSL/gKM9X9Vy4bWyIGLBIAmouluCBkKC18MPwejmCDn/7z9BIohywoNU5yNCmfslN
         qmc6INQajikCBwqt4Yl4mA+pwwenHWeA+1wA/lpCy9JikbFEB9+0MxbGrb942O/l4jMq
         VmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751394255; x=1751999055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez/pXwBjfYVBR5d646eCmsiXNrryWpQjuqLU8+evQ0I=;
        b=UJTacov3Ko2I5SotUVTAjyCh0BMJEEZz08mqSMmSCHnpijr0AZHbAPGtimoc5CtYFo
         Q+1wJ8iqzngobC+z/weOH4BITNSZIVSP92Ni/DarqjvE+3ZCjl8OA+xFPcLCwP395yRK
         2YRACIA3Tr+V3ZX8MTRHV2IHt9dRG+c4DgMX6uuiUu3rMsKbbvncoWck4Y2N8OVcGoG2
         6ImOj8Fn+7iYylcj3zv/6ykLbgU7TUNFAwtmXPqYE7inQlSbfYmWkt/Sok7DOqzhjqOM
         l/iU8m9acHFontqcs8qby6RwxXDBlSOoJjgao40fHEWVy1FH3xuPW5pcvwXuhZVD8hQ9
         rZvA==
X-Forwarded-Encrypted: i=1; AJvYcCVWZMvHu3Ucdr1A9rZ98va8eY633apyMgcwz5HEWQVSZ9/sw6S2IMIaNtZ3dBXvOd4E4iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3j+e2v5BEpNi3r60oCvXEFLKXFJn1tK5gwCozO300f8BqOSn
	I4RKZa77zLn9fN88bN/KBWGLs91bWrilTn9O7vepdpunJ7FStHZpigayFnicpa6TD1jjzbZtskf
	LxD9kREnyW52fwOgNzshuQOaLnPDzVGQQgwH+wG0=
X-Gm-Gg: ASbGncuaHMKTfseDytMBEb9DBbiSop6KOaIccNqf1qJLzaO6bllAvXKylqPWUSHTHqy
	lrBvXs5gvrWTtC9MRVGa0pUrF6kubQ61KgyhKrNpjH3BnXM0mfmqQRee9V4MOWI0hmOnRRrbtt3
	GsPOrsKYLGFoC1zl1xruIFbOy2QGTrOw8fdkjmzR6JpzzB5X1TuKTO/Xn+QS/U3ytazypGXhNUl
	u2v17IVbb1tpVcS
X-Google-Smtp-Source: AGHT+IFIJ3BcXg5aN85bQu7+kakqnvxqv5V8dCi616YlOgf7rYGtyUutUWB4Ss4lf/qnyM9sTTZl8b4IW3jkvfIKgyQ=
X-Received: by 2002:a17:90b:17cb:b0:312:dbcd:b93d with SMTP id
 98e67ed59e1d1-31939b7bd6cmr7197148a91.14.1751394254497; Tue, 01 Jul 2025
 11:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751296633.git.ayu.chandekar@gmail.com> <995389d6229df0c2a76ee4ba57e663a43abb4540.1751296633.git.ayu.chandekar@gmail.com>
 <aGPcJMfBCJuQLdtu@pks.im>
In-Reply-To: <aGPcJMfBCJuQLdtu@pks.im>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 1 Jul 2025 23:54:02 +0530
X-Gm-Features: Ac12FXwLcIOB3CfF4h1cD4pHxM1wsqyz8ozrAztq2-AcTVzTRgBBl2N9ohu9EH4
Message-ID: <CAE7as+aVrZZtu7goaMC2W9dEc4xsqOT7RRxPZ6Dmvu=cm8h1vw@mail.gmail.com>
Subject: Re: [GSOC PATCH v2 1/2] repository: move 'repository_format_precious_objects'
 to repo scope
To: Patrick Steinhardt <ps@pks.im>
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 6:31=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Mon, Jun 30, 2025 at 10:11:04PM +0530, Ayush Chandekar wrote:
> > The 'extensions.preciousObjects' setting when set true, prevents
> > operations that might drop objects from the object storage.
> > This setting is populated in the global variable
> > 'repository_format_precious_objects'.
> > Move this global variable to repo scope by adding it to struct
> > `repository` and also refactor all the occurences accordingly.
>
> Tiny nit: the line wrapping of this paragraph is a bit weird -- it
> should generally wrap at 72 characters and paragraphs are typically
> separated from one another by an empty newline.
>

Okay, I will fix it.

> > diff --git a/repository.c b/repository.c
> > index 9b3d6665fc..62709d1c91 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -284,6 +284,7 @@ int repo_init(struct repository *repo,
> >       repo_set_ref_storage_format(repo, format.ref_storage_format);
> >       repo->repository_format_worktree_config =3D format.worktree_confi=
g;
> >       repo->repository_format_relative_worktrees =3D format.relative_wo=
rktrees;
> > +     repo->repository_format_precious_objects =3D format.precious_obje=
cts;
> >
> >       /* take ownership of format.partial_clone */
> >       repo->repository_format_partial_clone =3D format.partial_clone;
>
> The list of variables that we copy from `format` grows longer and
> longer. I wonder whether it would make sense to embed a `struct
> repository_format` in the repository and then copy over the whole
> structure?
>
> Patrick

Yeah, I suggested this in a discussion with my mentors and was
expecting comments regarding the same. I can create a new patch for
this change if there's consensus on this.
