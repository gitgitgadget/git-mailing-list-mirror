Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA942652BD
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765752789; cv=none; b=tjfp4q/LDTfJsQ2I44pSoQqCMwfUNA+FMVc/tSPZBTgMj0UkO3XIuF5xom7GN7vc6KXLxgn0zyzEf7/nXGccr3PA4MFWZdENdRI/gdk7anbHjPpgHiDTPKcUYz4rqszuL1lxRWFQ/giDoJ3bKjPqG2zxPAPMUeH0JLMnmWW0Wnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765752789; c=relaxed/simple;
	bh=hObcT1YaGY4Hx/TpZVNz793/XVNRR/bxChzWJmSgA1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Axl57gTm/jrUAoGIRmmU+Xt+qQb4IGWGjnMLIMFeond2Xw8VHVuWGYYnzh/jsY4/nDOdICRFoYEP+9pVWGYJMSZk5FmJCjgMcZwCb+Rnix7yba6nb2umi4CN39LPEKKqwbMen3DI0fYi0tqlFOxNr95o57vOTycc+avnWy8ghPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFLBIgkS; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFLBIgkS"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787eb2d8663so32018687b3.0
        for <git@vger.kernel.org>; Sun, 14 Dec 2025 14:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765752785; x=1766357585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSuK8SW6pCjMUzOJ3wAt0gR5d4BCdSXZ6zhjvtWc1Yo=;
        b=VFLBIgkSLq+a44WUUkESFhYle+r5x3pXE9XDrM5MdL276KPVTd+r6q8Ht+QKpO3nxD
         NQwWbUJl83RrlAU8hbMbkCxIY1JF7rTecNj31SHH0VGC1h5LULd26eA4YiWLRhtRPQAn
         ZfoxHvrmAd/0qn+mVZfNHJ6gRfqDkRjQ86wIHR03xYBMF1groriCHrjZ50iSQcIXA1jG
         LE4JLp8FXBweAm4tZaBlz46IcDsG/1R9V8/mqlR5Gw4nXPe2kw27IKtOhFTQk3/GhKAE
         qOk/b7mnuDTR//AjyHOKL9lL96bmzJjJx85Q8dkOvLeQ0TXmsPRU9to3AQJCSHR8XzXA
         r1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765752786; x=1766357586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSuK8SW6pCjMUzOJ3wAt0gR5d4BCdSXZ6zhjvtWc1Yo=;
        b=Mzh+06y30hkimpQ260Q3ws6jpnmxqRx4CxqPEQ014pD31S/krpyaDLUOglH4gQ7Pbo
         YOckkUZNJ04sJQcCYY0cElgcS52ZC2mJDtqxL8h+Q/CNZpnfmuzB0wQGI3Za1DPqH73r
         VJ9cBpTtGOXzaGPXRceNEwApGElSqd2qMSWx+o3gPP7lCa+cGDTOSMw3lVOJHQzFqT8u
         UcdDFg2/7avUIf6+2J/nUSgWfIn/dTfKjjUIKoBBp2jUPPJQVUOYWa0ITCftojgof9TP
         M2+a1VqF+alUIdtONFHkjnwmwnHf+hcPxIsKgoaA12JgDYFa1PxcJtHBGTgZe/chI1x1
         GrRA==
X-Forwarded-Encrypted: i=1; AJvYcCXDtC002WNJ4Qw22BKeKhgwkXDAYFlWmeG4UvElMK8yH/cY3sLRqfAoMJ1+IeRFxhqqj38=@vger.kernel.org
X-Gm-Message-State: AOJu0YygbXU7nFAYV2LK++5DmHsdMGDTKLiTGMBaLvJbUK6H65lz2dyS
	1f2+HbWsGxjpOd5Irh5D9CdegPPfewCfWMSIQzplBI0kQw/G0DUvcZj6z0/0cooscxJk6LRZnpj
	YIJkAnuok+Fh5B40ThJBW/Bm+YBiLXaI=
X-Gm-Gg: AY/fxX5VQYzgM2rWAkjvDqVo3J6eANrUc4uAm3tZP6BdMB2QY2ah5iEbWCiwmicZJCg
	c+gZFnLsDAiI6zyrhNXiGCRzktzQf08Ipbo4ZnWJoMqz03JZY6NX6DOPKfl3QoyC/Jt34Y7bQW3
	GGuxSKrnIBGvCEXSnDeuJUJI8CCUgHmb1H2gZRumPUnTuIenZgFycTKqApLoUSS9gmzWJ5+D8it
	8ZXiU15Ab90C1vuRDWdOKTIrK2wdkbW9MX/JCFPoiaTP5N/SvvDtWMitMrqtbcYiT2WeoY=
X-Google-Smtp-Source: AGHT+IFtYdXbnNbpupm4QEH4/BSblx8ewfr7djUW0v7kdqsmHfxIgvSyKqOXUqb2xBAr1n5RX5ulv9vu5mcJlQG4w68=
X-Received: by 2002:a05:690c:ed5:b0:787:a126:5619 with SMTP id
 00721157ae682-78d6ded44bcmr114503467b3.11.1765752785575; Sun, 14 Dec 2025
 14:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118201842.1447666-1-jim.cromie@gmail.com>
 <76038c97-39ca-4672-adc0-4e8fe0e39fc8@akamai.com> <CAJfuBxxFWD0rEjm-va+Bjmf-m2nfOD_+ZEqKy22WX6QdugQCUw@mail.gmail.com>
 <5b3d492c-7037-45a5-a001-0064f14d5f81@akamai.com> <CAJfuBxzW6TMmdS74ZPfPSe1w6S=oO17WYZc-Jgn_et=-Muw05A@mail.gmail.com>
 <20251214195420.GA791422@coredump.intra.peff.net>
In-Reply-To: <20251214195420.GA791422@coredump.intra.peff.net>
From: jim.cromie@gmail.com
Date: Mon, 15 Dec 2025 11:52:38 +1300
X-Gm-Features: AQt7F2oF9KYX_NOYyJRdpuYbe94jvmSjXRbCv5mEmYXa2feu5Fj7bdBNw1hYX-0
Message-ID: <CAJfuBxx-_Z_hCoqdj2Lma7oP6LhCM6Pz=afe2P=wKO41T7R3mA@mail.gmail.com>
Subject: Re: [PATCH v6 00/31] drm/dyndbg: Fix dynamic debug classmap regression
To: Jeff King <peff@peff.net>
Cc: Jason Baron <jbaron@akamai.com>, git@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org, 
	ukaszb@chromium.org, louis.chauvet@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 8:54=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Dec 15, 2025 at 07:24:34AM +1300, jim.cromie@gmail.com wrote:
>
> > for some reason I cannot grasp,
> > git am fails to process this mbox.
> >
> > It entirely misses 13/31,
> > then fails to apply 14, which needs 13
>
> Can you show the exact input you fed to git-am?
>

in the 1st report, I got mbox.gz from:
https://lore.kernel.org/lkml/20251118201842.1447666-1-jim.cromie@gmail.com/

using the mbox.gz from your link, I get a different failure, this time
on patch 11


jimc@frodo:~/projects/lx/linux.git$ git am --abort
jimc@frodo:~/projects/lx/linux.git$ git describe
v6.18
jimc@frodo:~/projects/lx/linux.git$  cksum
~/Downloads/PATCH-v6-00-31-drm-dyndbg-Fix-dynamic-debug-classmap-regression=
.mbox.gz
540358004 206558
/home/jimc/Downloads/PATCH-v6-00-31-drm-dyndbg-Fix-dynamic-debug-classmap-r=
egression.mbox.gz

jimc@frodo:~/projects/lx/linux.git$ gunzip
~/Downloads/PATCH-v6-00-31-drm-dyndbg-Fix-dynamic-debug-classmap-regression=
.mbox.gz
gzip: /home/jimc/Downloads/PATCH-v6-00-31-drm-dyndbg-Fix-dynamic-debug-clas=
smap-regression.mbox
already exists; do you wish to overwrite (y or n)? y
jimc@frodo:~/projects/lx/linux.git$ git am --empty=3Ddrop
~/Downloads/PATCH-v6-00-31-drm-dyndbg-Fix-dynamic-debug-classmap-regression=
.mbox
Skipping: drm/dyndbg: Fix dynamic debug classmap regression
Applying: dyndbg: factor ddebug_match_desc out from ddebug_change
Applying: docs/dyndbg: explain flags parse 1st
Applying: test-dyndbg: fixup CLASSMAP usage error
Applying: dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
Applying: dyndbg: make ddebug_class_param union members same size
Applying: dyndbg: tweak pr_fmt to avoid expansion conflicts
Applying: dyndbg: refactor param_set_dyndbg_classes and below
Applying: dyndbg: reduce verbose/debug clutter
Applying: dyndbg: drop NUM_TYPE_ARRAY
Applying: dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
error: patch failed: lib/dynamic_debug.c:170
error: lib/dynamic_debug.c: patch does not apply
Patch failed at 0011 dyndbg: hoist classmap-filter-by-modname up to
ddebug_add_module
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort=
".
hint: Disable this message with "git config set advice.mergeConflict false"
jimc@frodo:~/projects/lx/linux.git$

Upon closer inspection, it misses several patches, and reorders others ??

in particular, the reported 0011 patch above is numbered 16 in the mbox.


2025-11-18 20:18 ` [PATCH v6 02/31] dyndbg: add stub macro for
DECLARE_DYNDBG_CLASSMAP Jim Cromie
2025-11-18 20:18 ` [PATCH v6 03/31] docs/dyndbg: update examples \012
to \n Jim Cromie
2025-11-20  9:30   ` Bagas Sanjaya
2025-11-18 20:18 ` [PATCH v6 06/31] dyndbg: reword "class unknown," to
"class:_UNKNOWN_" Jim Cromie
2025-11-18 20:18 ` [PATCH v6 09/31] dyndbg: tweak pr_fmt to avoid
expansion conflicts Jim Cromie
2025-11-18 20:18 ` [PATCH v6 12/31] dyndbg: tighten fn-sig of
ddebug_apply_class_bitmap Jim Cromie
2025-11-18 20:18 ` [PATCH v6 13/31] dyndbg: replace classmap list with
a vector Jim Cromie
2025-11-18 20:18 ` [PATCH v6 14/31] dyndbg: macrofy a 2-index for-loop
pattern Jim Cromie
2025-11-18 20:18 ` [PATCH v6 15/31] dyndbg,module: make proper
substructs in _ddebug_info Jim Cromie

2025-11-18 20:18 ` [PATCH v6 16/31] dyndbg: hoist
classmap-filter-by-modname up to ddebug_add_module Jim Cromie

jimc@frodo:~/projects/lx/linux.git$ git --version
git version 2.52.0
Im using fedora packaged git.
