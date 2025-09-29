Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417DB2264AD
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174401; cv=none; b=FDqYwEbQQb04esdj9ra9fB+G2Tz2xTycJ6PSesXnnIvtcgmrUxI+I+ONQ5dKUStT6gZ7zB55tc0uwwXIyi7IQF+9swQ2tpkXSXfyT+e5NMUB3/2sJS403TMNwb8l0uGmzinc5DwN156PfBmWU11Wam5pR54QFd2cnaR9vtJDpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174401; c=relaxed/simple;
	bh=Oy5TPgAP5bys7fnpIPrGdyHSkzdtWcHx7EJeKRmYGvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtRFqaOOwvZRJRtH04zuiZfxk5fKinK1K+3Y90tGd/7hsSpYFfWxjF3gx8Z/R4goNbtOxU/9aHPkqnfpvXvEKCWGGeHVYbWx+F6sl1BaB4baxKcXHf/lT/yjhEhwT8cSTGgFtyJ8v9jpjN3hzo/m374bORdjWwU4Zqm+DjeZ1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDLbJNuo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDLbJNuo"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso9021514a12.0
        for <git@vger.kernel.org>; Mon, 29 Sep 2025 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759174398; x=1759779198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy5TPgAP5bys7fnpIPrGdyHSkzdtWcHx7EJeKRmYGvY=;
        b=KDLbJNuo+M5PXOXVthszD943Kg6GOmErFCCNctjRLXaVAVl7yoJkUaYMapR4f8NYj/
         M0hDNdw1CedlPnN4w0zy2D7jQTAuutUhD5uw1ft8XXcufeRt2LPvuK2EnoXz881VygVe
         +WdW4gMnwEp/Yr0d/9fEwJUoKRl4sFBj++Kzd44TEwdXbxZ5Iam/I7eRXDhh9ILc393+
         1f3LncQOjD0ylpKEOERscpnIqHp7P6QOnriPMbVuS1soAxi7jR0HDD8wdGAz3shbQtPB
         0IJ+m8NtmtNmm118DHlsSLEQxsh7lIvExA6wQ77KmZQ8drv3RUy89cxAN8xcEsnG0MzG
         Vd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759174398; x=1759779198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy5TPgAP5bys7fnpIPrGdyHSkzdtWcHx7EJeKRmYGvY=;
        b=jzp+PSju9hJyOhlShuJSACLk7v790at9TM3pue5+pO5sFDWy4NpT1+W3lU4tpt00BM
         YdEVvNGiSyOYOsLU6FI8zDGManPvm7nSDsinl94agz3TuWd86Wawd74fBz02yVN1jEYO
         0b0xAa5SifiCkuLRbuAW4K3Q0O3tgC45LJ9GF6GDhOjtw7p5AZsdgaqIPYf86i2BoJPo
         wYkx+Pv8hpnfK1PBZ9jri0RTH87CoCkeFYIFDJz2nSKV0gB2M9hL0+TB2c/lpjLdH+5y
         jXObiPDyeAqM2USJYdML8njQ2RXT3MrgjwqKXM5UiS7/kLhNJyEMg7bBLqKdmHUhn3AQ
         1tGQ==
X-Gm-Message-State: AOJu0YwesDrLvXWFqMvavBGmhgsCAJrOmKruEmCcR1caFs1NWeA/CBj+
	xueGPUnnjVXJWxKX8ONSORbtnBmbDSTwZuO6XWFeHLPenI0h1nK6loQj81Rf7y4yPxHi64DUytr
	7eq6gaOgbswYgDNNtAXWqsUx8kFXKyor1OV0IOQeeRA==
X-Gm-Gg: ASbGncuhS+HN954M6dKPPuYEgFemBilCRXEEpoKJDpcGHeV+oSi5ihlvGdWqZyfUbL/
	JlQ4B7BkYijNF2TFGgK3cpFAKpqKE20ahNVoj1fyqX/AyOF8qxIC/42dn9eJ4oHa0csiEd2adeP
	cVzUD0go/VM9zMT/d5K2XMthmsn4rg6JiFoRgiZtyNBxok0e9+WwriDHlG5oeWRIrsTT85dOxpp
	glNS2whxfGwYEaFMN23m2Pw5IANLwGnEtpIkw0CePDWGOuetQ33XPxA4Ywpa/jUI22owA==
X-Google-Smtp-Source: AGHT+IEjJ7MDPmU1K5hpFgVLwFmfOLMHxfFphTTdkDvjUrB2r72N40ZbW+F94Iy9YWdEuD3TsWUIEaucijBcXdR9iYs=
X-Received: by 2002:a05:6402:5243:b0:62f:760c:345c with SMTP id
 4fb4d7f45d1cf-6349f9f56cbmr17209975a12.16.1759174398252; Mon, 29 Sep 2025
 12:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ5EAUw_VN4GXiHYJq0et8oZN0L+AHZz+ROLtK3Hxdp3SEL3=g@mail.gmail.com>
 <03d601dc3166$0f302170$2d906450$@nexbridge.com>
In-Reply-To: <03d601dc3166$0f302170$2d906450$@nexbridge.com>
From: George Ogden <george.ogden.human@gmail.com>
Date: Mon, 29 Sep 2025 21:32:41 +0200
X-Gm-Features: AS18NWBh1dHcmkyW5R6X0rZR7dlg9chnL5YA1tetXp1uh43_apyx-Gu9Oy82LA0
Message-ID: <CAJ5EAUyfOLZHqs8BKnxzjHXj6H1ZiWSKLimL5smB3ML0KCLEKw@mail.gmail.com>
Subject: Re: [Feature Request] Support for sharing root-level files across repositories
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randall,

Thanks so much for your thoughtful reply. I agree that there would be
a lot of use cases beyond the one I initially mentioned.

I don=E2=80=99t have the technical background to suggest how this might bes=
t
fit into Git, but I=E2=80=99d be very interested to hear more from others o=
n
the list about possible directions. My main motivation is simply to
make it easier to maintain a single shared file across multiple
repositories, without having to copy it around manually.

Thanks again for taking the time to engage with this idea. I really
appreciate it.

Best regards,
George

On Mon, 29 Sept 2025 at 19:25, <rsbecker@nexbridge.com> wrote:
>
> On September 26, 2025 4:33 AM, George Ogden wrote:
> >Hello Git developers,
> >
> >Firstly, apologies if this has already been discussed or if there is a w=
ay to solve this
> >problem that I am not aware of.
> >
> >Motivation
> >
> >Git submodules are very useful for sharing directories between repositor=
ies.
> >However, in some workflows, there is a need to share a single file that =
must live in
> >the repository root.
> >
> >A concrete example is .pre-commit-config.yaml. I maintain a standard tem=
plate
> >across many repositories. When I add a new hook or update a version, I h=
ave to
> >manually update the file in each repository. I could use a submodule for=
 this, but
> >submodules always appear in a subdirectory =E2=80=94 not at the root whe=
re tools expect
> >this file.
> >
> >The same issue arises with other configuration files that need to reside=
 at the top
> >level of a project (linters, CI configs, licenses, etc.).
> >
> >Proposal
> >
> >It would be helpful if Git provided a way to share a file across reposit=
ories so that it
> >appears at the root of the working tree, without requiring a separate bu=
ild step,
> >symlink, or copy operation.
> >
> >I understand there are alternative approaches (subtrees, packages, exter=
nal
> >tooling), but they all involve extra indirection. Having first-class sup=
port within Git
> >for this use case would make it much simpler and more consistent.
> >
> >Thanks
> >
> >Thank you for your work maintaining and evolving Git! I would greatly ap=
preciate
> >any feedback on whether this idea has been considered before, and if the=
re are
> >technical reasons it may not fit Git=E2=80=99s model.
>
> I have been thinking about a current use case for this RFE. Consider
> GNU/Configure-based projects where we have config.guess and config.sub in=
 the
> repository root. These two files are independent of the project itself an=
d truly
> should be shared and managed from a single authoritative source. It can b=
e a
> real delay/pain to wait for the project to manually update these two file=
s
> from an upstream to get platform support for their project.
>
> In order to support something like this, we might need a submodule concep=
t
> That supports something like a link upwards. Or this might be something
> That could be part of the sparse-checkout infrastructure. I'm not sure, b=
ut I
> Do think there is merit to this. It could also apply to organisations tha=
t have
> cross-application root certificates that need to be in the same directory
> as the application root.
>
> Just my musings.
> --Randall
>
