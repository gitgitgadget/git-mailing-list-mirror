Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E7225761
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016794; cv=none; b=HIjgeP8uo98vUKmtiipO1rNA41tsQu4eSqdWC9RzHheUm9dzFsitbTaWo+VXP8DIuh1kzyNsM37IilY2YaFizBp5Z3DMZ0Mhc2H+i0xlMC4NTHWpoOTe0pEGEzlIsDFKfUeJxSLL8lB+OwpcFeCo28vAkQeG3Q31O2EW5yFeV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016794; c=relaxed/simple;
	bh=tdlUs0PP58smbDcBtvzvNj7GVG6XzPFNQLt1VarqlSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VM8N67wLa2EBtDFRwcR4nwRhoDpPjJw/T/zE5JHfJcGGDix+mP6NK3i5vewh+R5uoCpv2I/R+wWhnWm62xOL2nv/iW7Qgij00CVz7U9jDOHFl5QERAfFufgcUP20EJmS1TnhKu+QhdnyZ1Zp4pYg1StIurOjtpxgRZfY2T0dZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV/326WR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV/326WR"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac34257295dso837810666b.2
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744016791; x=1744621591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4dfe5TCYv3G+Rz06tGkgRqzYz/LiWqMcc4jjODeERU=;
        b=BV/326WRbEGMrBkvDd44d/NDewIFpLUMgPSQ1SVvWwj+L9FmEOzRUKAF/R0mDtYZ/o
         sI1cXuMskzZFi/I8e6MXRfSXFnIgfdsdK1Jj/pXGquMIJj09nv39oMUkMq1PmjlSDewJ
         fbJjaEP7NjOU9CuNFKMDo90k6xVTjU0xunAi+4pl0JIfm2mzetGcCBl40EdiEjWJsaUM
         G5HyOmkTzDuVBjaVBcgFivdMQOhtNCEOKpLqlbguih7B9/kO7ZqaOa7yJghphxMjGCiR
         9Tru12kzXMp2GaYH+cby5CXTWZEfVX07A6vk0TdRhxrtjxr7uNCFaygnM9ZKAte9R8GT
         UhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016791; x=1744621591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4dfe5TCYv3G+Rz06tGkgRqzYz/LiWqMcc4jjODeERU=;
        b=Zs+P6NI5/ctMsh372pUpBHiNKc+AFgcvfQHkgovbgPZ8vFRB2Aymw5CE1VV16X+MYI
         k704ymhIS53mPliszN7oKGgRnaupNLc45+FzrXmeZ4O4oLlr342q+z6QQrMdJCba8fxe
         FElszAB2qERof83ez85MNlptKhMfDlCiKtTFD+H6MEIwp4zu9x8pp8KWBu0MidcwC82L
         MkY8yutK65ZfbacNwcmklsCCNcijpUTohGf6kAIvNjvP+0kGpR/bSb2k59EmUAoynI6t
         haqb+Rt18qqmrTQQKP+ChPhHsjQeeEJJDgdjkENW5WvOIduX2dWyQoLpDxaR4OHSk8kn
         KeeA==
X-Forwarded-Encrypted: i=1; AJvYcCW6P5Mi0aLQtGnH06FlLI5HWaJyXm13g5pQDjvmlgPDZ8GC/33p5nnynC4pTVzR1SL2eRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygayrs6G7gKY0F3jljC3nyCrhiEG4lrWKzvpjkp0el/8u0KPQv
	wxaimpmfK0j9DE01aW/Tfh/B/f6t0h5DANeuGKgU2/GO0gIM1Om7MvrR/o2Wxj+i/N23W33A9ue
	7m1Ry0oplYWrOemvO4T0Hcqv24VoPLxCA
X-Gm-Gg: ASbGnctTNGmQqwDn9//lqwracnfGvJbve1QbH/RBQHZZ+XzgfTUhH4i5DrfsV9wIbZ/
	mM2UrBvouJowC5A7t5MuDRWs//ePAYwocaZ/7USm1rhHuCBFkYw2IDJnZPjqT9ovwMuBTCqiPb8
	xaZak5ioqYayU68XS9qGc8tdDde0D5vO9m0KktYGSbH2yCrAyun8Ioh/toIg==
X-Google-Smtp-Source: AGHT+IEyZyYuNZg+1gVHsJYIfnuE5KChwxXdXYquTwXfy+2YGwwuZCH40VFyWaDuM038AfT9+tWZ0tnuXgTv6VcRL6U=
X-Received: by 2002:a17:907:3f9d:b0:ac7:3595:56df with SMTP id
 a640c23a62f3a-ac7d6e3d130mr888987166b.47.1744016790529; Mon, 07 Apr 2025
 02:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326052602.265989-1-ayu.chandekar@gmail.com>
 <20250404085133.1098274-1-ayu.chandekar@gmail.com> <CAOLa=ZQ8KvAZjsDWerF0E9VUzsbNOj+Vcxo_mFL5Y3Of9iCAHQ@mail.gmail.com>
 <CAE7as+atJcycd4Awav6RKkTDvwiocyv4j=0rZvEhDcVpREsmqA@mail.gmail.com>
In-Reply-To: <CAE7as+atJcycd4Awav6RKkTDvwiocyv4j=0rZvEhDcVpREsmqA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 7 Apr 2025 11:06:18 +0200
X-Gm-Features: ATxdqUGEbHKIiAeKCtIwRJZI_-K2yNZjiRoZy0nTSwcQTEKMIf7nSx0sp6p6f7Q
Message-ID: <CAP8UFD0a9rvVEJj4nk0ONK7=HXYRS1td6nEw7nO6mhj4gTjY9g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSOC=5D_=5BPROPOSAL_v2=5D=3A_Refactoring_in_order_to_re?=
	=?UTF-8?Q?duce_Git=E2=80=99s_global_state?=
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	shejialuo@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 6, 2025 at 12:44=E2=80=AFPM Ayush Chandekar <ayu.chandekar@gmai=
l.com> wrote:
>
> >
> > So the approach you suggest is to comb through the global variables and
> > config and find new locations for them to be stored. While this is
> > definitely a bunch chunk of the problem, shouldn't we also talk about
> > how we can reduce usage of some of these variables?
> >
> > In particular, I'm wondering how you'd want to tackle 'the_repository'
> > usage. There is some previous work done here, where Patrick added the
> > '#define USE_THE_REPOSITORY_VARIABLE' definition which tracks usage of
> > global variable and usage of them in different files.
> >
> > A possible approach which has been followed is to simply go from the
> > bottom layers of the code upwards, cleaning up usage of global variable=
s
> > and ensuring we can remove '#define USE_THE_REPOSITORY_VARIABLE' from
> > files. This is also the approach taken in some of the patches that
> > you've linked.
> >
>
> Your approach makes a lot of sense to me, that is, picking a specific
> subsystem or file and aiming to remove the `#define USE_THE_REPOSITORY_VA=
RIABLE`
> definition and thus 'the_repository' eventually. This was the method
> used by Patrick to tackle
> the object subsystem in [1]  and the path subsystem in [2] and you to
> tackle the packfile in [3].
> This approach also helps in removing some of the global variables used
> within that particular
> subsystem, which is a nice bonus.
>
> However, this approach might not be feasible for the global variables tha=
t
> arent tightly tied to a single subsystem.

Well, initially 'the_repository' wasn't tightly tied to a single
subsystem and even now I am not sure we could say it's tightly tied to
a single subsystem. Or maybe I don't understand what you mean.

Do you mean that it's tightly tied because it needs `#define
USE_THE_REPOSITORY_VARIABLE`?

But for other global variables it could be possible to define and use
similar macros. This way it might be possible to remove those
variables step by step only in some files.

> So what I can do is, for removing
> `the_repository`, I can follow the approach you mentioned, and for reloca=
ting
> the more general global variables, I can use the approach which I
> talked about in the
> proposal.
>
> What do you think?

If removing `the_repository` is part of your proposal, then yeah,
describing the approach you will use to remove is a good idea.
