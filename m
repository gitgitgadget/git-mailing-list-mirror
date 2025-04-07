Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6D2E62B0
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744020472; cv=none; b=aZSkS2f0AVFi5Z8ZR7kdat6yuWV9SA+hVO6zrsQ0QIh1SsCuZm7gzPJepfJ9ljh3MugKLAdjcb6PHyHvtimZZTW4nd7pFYADDdY4cmcEFwzFiEQ4yJzAxz5xbckWqJyadDjZrg2oiUBlE5NEtj5NhOdAPE7LGkMEuvMvsMEKw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744020472; c=relaxed/simple;
	bh=B0SyI1GEY8RidQKU18Lz/ncIEAx64mbQHYYBZ/9ZC5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pN/FfhfiWCn+H0aErCv/+RuOUXlZwMFIWgQhtCzs2o9LysA76QIRdHgSNpvHMSQe7sPReduStYgPlvJPhrWKYTwopep4aYm9QH7L+3p1BCAGYnx3s6OGEP/AOn750MftqeT+lGKdj96x4Qq3n0lOiEaPDIibqcls5zDx3zs/66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsI4Je9q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsI4Je9q"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af9925bbeb7so3033501a12.3
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744020470; x=1744625270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B0SyI1GEY8RidQKU18Lz/ncIEAx64mbQHYYBZ/9ZC5Q=;
        b=EsI4Je9qA3N+d6f3PAItoVFCoCxjBKLssNktCe+5awQV1v9y+kpfAVQPakocGofrbo
         3jwjQTUQknk4NH+c1bJEMDD3wO4KeUh2F7n2DrNux4VVvnfA9hRpMZSWsH4AqKUrS4oe
         sgEjrj9SBNnq5wU49pzwfMzXw6+bV77ufNSD30px8lfPVM7TCJ6lj+3CURgJPXQe1uS8
         dZnNtxifEefymgCcgZzUy1HIcGLHFZJu0WRAHueYS34XOJEtS/1lWvpc349vA8ZZay2G
         ht2+7EmjQyeiMe7pd5/PC2cc/IyAtOSKeCiKhfIzBgD9eEuqPbZPPDBvohCqne4tBEBp
         JTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744020470; x=1744625270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0SyI1GEY8RidQKU18Lz/ncIEAx64mbQHYYBZ/9ZC5Q=;
        b=DO000bxUjoQTyh0xbxBkkBA6fFLohlyMCxw6VH03ctfNivzXLi4KsbKQPdqTGWuCMB
         Bbu6QtjlWbDh1dCr3PTvZtzA02LoVW9lmKo+nmqh2mrbogIN9uz/fIAOQc6fITB9loOV
         mwKDoR7hc/fuVvm7UpzmNa3DZStumk2s3u5rwOe0yAQdZyfcaF+B5E2HFcLbnQGjrQ3s
         z/2w8W2ELhal0LWU/iiFjXVKTBg/iky3DEi3E7ugFsrHqLlLbVRUFlX4gUtSQy5uHOWj
         Md4e74TKN95JhVPVmtFU/+nGG/pZZ/bLZoRkW5NOveweXsD5P2HHUj1R5oKE0+Xm4iDe
         luKg==
X-Forwarded-Encrypted: i=1; AJvYcCWBz33aom2k8RleXxId8Hx171Mf9xAma0a6QTwRwAEMemq/pEcUg5oGwJAF4lTQY17Mba0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkqU9S8BY55ua4bNRWV6ET0yYjW9sWiv1bO/0jg/jXiCRLUeZ
	pDiv0V2a5xCSIL7EPGiZxJDE5ZGebAJEeERmBLCeuEMLnRSlASqViiavzkf+OHPEZZoraLvUVAN
	TBrLS8nmoc3vgdTIcU19WNl9pRbYcCqtHthY=
X-Gm-Gg: ASbGncvT7axni5eJ334d8Ou1/Igg+Tw4jFqNz2fsCezozHmukcZUZI1kPRnQDYgEDiq
	7H+qFryDIi2cSES2cxhDBWQrKijG9c+O6n8c9IhnQ1vE3g36ely6SlBzNFdb+/SoYWIXU6yrCpV
	3UKDUtSvLhM2wdZ0GGMP6WVJaK/de+Z8ndkWH6yA==
X-Google-Smtp-Source: AGHT+IHgIg11RMwXvTDqiN7ysbSKPUFfF9OWe1l2LZR83BCjt6s5v5iXU6E/HiuZpXplmif8eV8/knWQY/iKuM9EZAQ=
X-Received: by 2002:a17:90a:c88d:b0:2f6:d266:f45e with SMTP id
 98e67ed59e1d1-306a4821d6emr17230153a91.2.1744020469869; Mon, 07 Apr 2025
 03:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326052602.265989-1-ayu.chandekar@gmail.com>
 <20250404085133.1098274-1-ayu.chandekar@gmail.com> <CAOLa=ZQ8KvAZjsDWerF0E9VUzsbNOj+Vcxo_mFL5Y3Of9iCAHQ@mail.gmail.com>
 <CAE7as+atJcycd4Awav6RKkTDvwiocyv4j=0rZvEhDcVpREsmqA@mail.gmail.com> <CAP8UFD0a9rvVEJj4nk0ONK7=HXYRS1td6nEw7nO6mhj4gTjY9g@mail.gmail.com>
In-Reply-To: <CAP8UFD0a9rvVEJj4nk0ONK7=HXYRS1td6nEw7nO6mhj4gTjY9g@mail.gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Mon, 7 Apr 2025 15:37:38 +0530
X-Gm-Features: ATxdqUGmMWFsvVmWUIaWw401NM_LJ1VLa-Ohf3IuskcSaHzGpqgBqQOyKpCBbw0
Message-ID: <CAE7as+bnsBMW=UQtzQrNKTK3cMDSyYP=Q1EqEb2z8-ur3_my5w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSOC=5D_=5BPROPOSAL_v2=5D=3A_Refactoring_in_order_to_re?=
	=?UTF-8?Q?duce_Git=E2=80=99s_global_state?=
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	shejialuo@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> Well, initially 'the_repository' wasn't tightly tied to a single
> subsystem and even now I am not sure we could say it's tightly tied to
> a single subsystem. Or maybe I don't understand what you mean.
>
> Do you mean that it's tightly tied because it needs `#define
> USE_THE_REPOSITORY_VARIABLE`?
>
Sorry if I was not clear earlier. I wasn't referring to
'the_repository' being tied, it was about other
global variables being tied to a subsystem.
What I meant is that the approach of picking a subsystem and removing the
`#define USE_THE_REPOSITORY_VARIABLE` is really effective for removing
'the_repository.'
It also helps in localizing the global variables from environment.h
that are specific to that subsystem,
either into the subsystem itself or into struct repository / repo_settings.

But let's say if a global variable is common to 2-3 different subsystems, then
this approach would not be feasible for that variable. For that, I
would require to individually
tackle that variable. This is an approach which I mentioned in my proposal.

So using these two approaches according to different needs, I can move forward.

> But for other global variables it could be possible to define and use
> similar macros. This way it might be possible to remove those
> variables step by step only in some files.
>
Yes, I still need to think through how that would align with the
approach I mentioned.
Defining a single macro like `#define USE_GLOBAL_VARIABLES` is
something I can look into.

> > So what I can do is, for removing
> > `the_repository`, I can follow the approach you mentioned, and for relocating
> > the more general global variables, I can use the approach which I
> > talked about in the
> > proposal.
> >
> > What do you think?
>
> If removing `the_repository` is part of your proposal, then yeah,
> describing the approach you will use to remove is a good idea.

Yes, it is a part of the project but I haven't added this specific
approach in the proposal yet and was hence asking if I can.
Thanks:)
