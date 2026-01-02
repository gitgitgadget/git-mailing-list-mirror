Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DDA2EDD4D
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767353167; cv=none; b=raUMXiRvloJZT7MqxVzRasm4a74mfMPtlvuZo37Pzk433Z5T68p8e6lmppwBx1I0nCpxOG+Moek5jJYuIB0TkJPXDaU1rP3hOo90hwMNkbV7BW/wfDskVEbQXvOCFKH0Am6xIIHp/RzY7v5J9Eh5A/IK4fXxRxUg9bfGG0LSM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767353167; c=relaxed/simple;
	bh=WJ8CbukeHkJcmOk3ef5eT3H77xhlRPaE2OdZhB3FTbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nI46qIisbJp9t9md2oF6Du9UxvGlx5VMi8vajUp0FJ6IIEw2TAuXxGYzrm3NzBLTF2NKB66DVY53jQeU9+Shxs+KNKn0odIDnHJsHP2UiJdyyuTGEwJhV3TTeW2CgysbbirtKfVZYQyP2mOZ4ESnSi0Puq7O5YUs2e+2/Wl6WS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0l2pF1P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0l2pF1P"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a12ed4d205so105493175ad.0
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 03:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767353163; x=1767957963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B5QjEx9p2blB+Y3EWwlhQoGb03FABBw/4I9jnu9hqoQ=;
        b=V0l2pF1PZyV4obFAoP2TCDza76b3efSYhn4wIBY1DVxehe3WLmrK/P6slP+NNWfEpA
         16IlLP7AJn+XhhpyUK0gUWLMKm2AYt+FDnjkxOnrV5+Y8cS35xGNkP34nSlSG5AZ2sS9
         xe0yQXa0iDw3FYo3EodmYXxxe9m1PXVkwiu4EBCFtD3ZauwfFhOk62z/MISYM6cSCkdz
         yDxbGuvQjUJ61jRRnF6IiXXCwE/igbgeWTfQihyvdrt3SflBDXrGo/miVlPg3YioA6o8
         f20r/CnBiGH0yAM6jPyJkkBeh3Z0781ubdjEisG5Pcbc19FEEeGJ4W+IFVUtNVZ79jE8
         OsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767353163; x=1767957963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5QjEx9p2blB+Y3EWwlhQoGb03FABBw/4I9jnu9hqoQ=;
        b=LkvxPZCMCrdUlvhOiYZL5dEtPVsxeJHsJqrAR5HAIZvUBEH2HrrnHs/BYTG4uu+2lo
         TxzH4T0kaTTGCPAZW2h2VPf/+eQVvBYDnztT8xNn3J3UA53+zLEacoeUDdmlZH9sMEiJ
         kEuFfczbagXKEgc9Ab58XpGq5i5NcgEn1nnH13x3K8hCOgdDpDUbg4OxjGaECcDM5o0Q
         YANp+miHPexerjBB/VOabnjqgYla0YXEroC6TXrqNr+qn7cyAQRrIX0hyufpWE95nIXr
         rRU5Au005PJXcon80aEQ0op2t4NnOexA6Q+/aG+mf6icqIIikqhr5JQHNj10IrwGhrdM
         vEmg==
X-Gm-Message-State: AOJu0YxVB7FoI71y4+nEOU4OoVb/vYHuWRxm8hBWp7mka22LSRE8Zp4K
	ADC0SpxcK1znq59YtdFzDNBYccub0iXYexV7HlMSZXH5byL+bNd7xY4olTAX2oeXi+9GhxVRDWF
	4fb387K03WsKARFyTH0/rWJ26HwtVhqA=
X-Gm-Gg: AY/fxX6L2Q0uuJMB1JQ5MrvZg2B1mRIDq6Fqj2euWqmP7hdNDKaAxbGG6j5ks/ek3wv
	JL2Hjk75dw2eERjXmhdpzJXZKBdrCkvm0a44vb8LW+k+2PEpZlTPZcc0FvBsHFomkuFHiX0EYqN
	AbzPs7wmRsFB9ir8CzsUOlfR62ANR6djrivY7riTyjD/+X7C6AYH+hrqcTty145WZUEFOqkMZ6D
	eZDEXfy8AFKCV0H7iBQbTe6uOd2/bqD+mGxbANhEpL8hjbm2tpvr/IHvCEe/vEtWpjEPaPPq37J
X-Google-Smtp-Source: AGHT+IFeexJLPoWMrMqK6Q2rOml09Us7u+WvwCaOxE6T/X4TuO4fBh4BWo5hIdkTol9aus4qSvpi6Crniyx8ZOip/vg=
X-Received: by 2002:a05:7022:6294:b0:11b:9b9f:427a with SMTP id
 a92af1059eb24-121722b4fdfmr39861902c88.21.1767353162637; Fri, 02 Jan 2026
 03:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aUO7jQQAERTe5xYc@ubuntu> <CAOLa=ZRDFdZJWsq5JOckRgfF2V0Whv-jCxbpgeRi80NOs0oTDQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZRDFdZJWsq5JOckRgfF2V0Whv-jCxbpgeRi80NOs0oTDQ@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Fri, 2 Jan 2026 12:26:04 +0100
X-Gm-Features: AQt7F2rZ2D8RJqHGMlEajCf5O8lAzKWIp6qZnfbloNESr7xQe22FdxMh-KQXnCg
Message-ID: <CAD=f0L8K+Ou6Kg5gUEqQpNzbSi-FHMsovOKtJN2hzjFYHywiPQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH] environment: move "core.attributesFile" into repo-setting
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Jan 2026 at 09:48, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > When handling multiple repositories within the same process, relying on
> > global state for accessing the "core.attributesFile" configuration can
> > lead to incorrect values being used. It also makes it harder to isolate
> > repositories and hinders the libification of git.
> > The functions `bootstrap_attr_stack()` and `git_attr_val_system()`
> > retrieve "core.attributesFile" via `git_attr_global_file()`
> > which reads from global state `git_attributes_file`.
> >
> > Move the "core.attributesFile" configuration into the
> > `struct repo_settings` instead of relying on the global state.
> > A new function `repo_settings_get_attributesfile_path()` is added
> > and used to retrieve this setting in a repository-scoped manner.
> > The functions to retrieve "core.attributesFile" are replaced with
> > the new accessor function `repo_settings_get_attributesfile_path()`
> > This improves multi-repository behaviour and aligns with the goal of
> > libifying of Git.
> >
> > Note that in `bootstrap_attr_stack()`, the `index_state` is used only
> > if it exists, else we default to `the_repository`.
> >
> > Based-on-patch-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> > Mentored-by: Christian Couder <christian.couder@gmail.com>
> > Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> > ---
> > The link to the GitHub CI is provided below
> > https://github.com/cloobTech/git/actions/runs/20284228144
> >
> >  attr.c          | 20 +++++++++-----------
> >  attr.h          |  3 ---
> >  builtin/var.c   |  2 +-
> >  environment.c   |  6 ------
> >  environment.h   |  1 -
> >  repo-settings.c | 10 ++++++++++
> >  repo-settings.h |  8 ++++++++
> >  7 files changed, 28 insertions(+), 22 deletions(-)
>
> The change is very welcome. Apart from some small comments below, the
> patch looks good.
>
> [snip]
>
> > diff --git a/repo-settings.h b/repo-settings.h
> > index d477885561..362f355267 100644
> > --- a/repo-settings.h
> > +++ b/repo-settings.h
> > @@ -68,6 +68,7 @@ struct repo_settings {
> >       unsigned long big_file_threshold;
> >
> >       char *hooks_path;
> > +     char *git_attributes_file;
> >  };
> >  #define REPO_SETTINGS_INIT { \
> >       .shared_repository = -1, \
>
> It would make more sense to rename this variable to
> `attributes_file_path`, that would better denote what is actually stored
> here and syncs better with `repo_settings_get_attributesfile_path`.
>
> > @@ -99,4 +100,11 @@ int repo_settings_get_shared_repository(struct repository *repo);
> >  void repo_settings_set_shared_repository(struct repository *repo, int value);
> >  void repo_settings_reset_shared_repository(struct repository *repo);
> >
> > +/*
> > + * Read the value for "core.attributesfile".
> > + * Defaults to xdg_config_home("attributes") if the core.attributesfile
> > + * isn't available.
>
> While it is obvious, it would be nice to point out that
> `core.attributesfile` is set via config.
>
Thank you for the review Karthik.
I will send an updated version with the changes.

Bello.
