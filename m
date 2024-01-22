Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7231447A47
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956678; cv=none; b=odCn4vL/y7v8GVB5q2vV7TZg4Bde0kR9NWGWrSxDK38pNu8K+HM6bVuzcmYtNDogIDMuC+TGmQbF60e8gIitEb2N0ahzAXDoEvY5NNykVIvkWEvrbPwY0792W79DmnggVDvq+W4DYe90b/Ch2/VKuRpyIwiM8ZlUIGbVLSuDyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956678; c=relaxed/simple;
	bh=S9rlbKiVbXk7Nd1BkKo4DwczB9bPLFOO2JhTGCvbx6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZxQDZQhGij7xBu6239aTk2qzz0RrruFgY5EkwjOiVVseugSo4WjsZ0brMgy2B2A+q8RLf7+MXtFMJOoajOGUmgRw7TNWOWqhPiWFvfzokZMSQQHjvG1ZNoAioOHkYb/q6RCWsOsIjq8ppcAlsfz2eeKRIlAnTzUIKlifsGFS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3MPtc4ew; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3MPtc4ew"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so3990225e87.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 12:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705956674; x=1706561474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMwlMh5Fz/SEmzGVC/OcgRxQvnYTfgGtKt5N+QzmJC4=;
        b=3MPtc4ew8n9DG/2QdlNdLV7mwYKREFLsaIPnBBBX7GElpUbuhDvJZTIFnV1KJBm0Ut
         cEkvsOQZ2GTPQzD677o3mjyFXxtcYCVMQnS1RJWyNYhg/ThKr5PD1GBg9/cXD6hOKrY0
         Si8i8iVs/+KTZHDxVeXbgr0WbIvm+pUrXwrtNGnzRchRlZWER4uLEky4/Bu/q02cUxU4
         BdvqtcobCe9CqIMXXjhIsMI2nzf1w0MqIKsUia9xtWiYDbXtrEkXf4QqQ1nVPh/O03nA
         9Y+7G5nYrEVQPDpfniRB83q7u57bUbssUNsF7EiL93rkGFKFl+okbfKAzDUNtm3ne8HF
         EZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705956674; x=1706561474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMwlMh5Fz/SEmzGVC/OcgRxQvnYTfgGtKt5N+QzmJC4=;
        b=IeiDYxCJemlH/IlBHL0ZGoZ7HbKtwwUX3swnCpdZdKOTJuT8fiv/jXRdwEZHZLQBYx
         NtZIYCIVHz6vzYyEkmOPXSeb0nu5hu5ypB+rOjvyKTTApmvB77ntIvaVZGLGTcBlBLH2
         JzuI/3tRoaJy0ebrGfYuS7Kok3PlSfWp3pMnDAIOtZUn8mAitNS6qcfpVS6w9ZI+no2C
         Ry0uC4QE0xUGiLu5T6OtxKZfc/MpLSgwheqJJcz6oYAo7EIyYfo9AQcZh0yD4DDXCcwM
         hPs+ykFD0EE0HyB/8w4Nw20BhTllmoDRhzBS8f6sGW0Tej7Y6m06CftkOzVe0RKHREOJ
         RJYw==
X-Gm-Message-State: AOJu0YxKUaEETboDkFrSvnrbfYzp3rq9c8ZeAnaGbDq9cxS44Y76H1TI
	KEeNS5U7xK4irejWJ4vFLY+DUq0c0kdMvxtqqeSj82hE6DTRuejhgm+uelNTBsXkU4qV6n6JwzS
	iYfY4a7ic/HMUyz8dKegikuLoRH62P4KJarL2
X-Google-Smtp-Source: AGHT+IHoLwP176nglpc8X9EnZbfRFNsyfReN/Q3WvxrUygqh/+fXnOnse7cO/TICtN2aZrFeWgLJzfO5Q99B8ZyEbsU=
X-Received: by 2002:a05:6512:12d1:b0:50e:7b5e:5064 with SMTP id
 p17-20020a05651212d100b0050e7b5e5064mr1006440lfg.138.1705956674200; Mon, 22
 Jan 2024 12:51:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1645.git.1705709303098.gitgitgadget@gmail.com> <xmqqh6j7ej5w.fsf@gitster.g>
In-Reply-To: <xmqqh6j7ej5w.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 22 Jan 2024 12:50:57 -0800
Message-ID: <CAO_smViDR-JKRiKO-8-6mCGBpCR8Y1gLS9Y9DkoCFw=kHm5Mdw@mail.gmail.com>
Subject: Re: [PATCH] setup: allow cwd=.git w/ bareRepository=explicit
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 2:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Kyle Lippincott <spectral@google.com>
> >
> > The safe.bareRepository setting can be set to 'explicit' to disallow
> > implicit uses of bare repositories, preventing an attack [1] where an
> > artificial and malicious bare repository is embedded in another git
> > repository. Unfortunately, some tooling uses myrepo/.git/ as the cwd
> > when executing commands, and this is blocked when
> > safe.bareRepository=3Dexplicit. Blocking is unnecessary, as git already
> > prevents nested .git directories.
>
> In other words, if the directory $D that is the top level of the
> working tree of a non-bare repository, you should be able to chdir
> to "$D/.git" and run your git command without explicitly saying that
> you are inside $GIT_DIR (e.g. "git --git-dir=3D$(pwd) cmd")?

Correct.

>
> It makes very good sense.
>
> I briefly wondered if this would give us a great usability
> improvement especially for hook scripts, but they are given GIT_DIR
> when called already so that is not a big upside, I guess.
>
> > Teach git to not reject uses of git inside of the .git directory: check
> > if cwd is .git (or a subdirectory of it) and allow it even if
> > safe.bareRepository=3Dexplicit.
>
>
> >     My primary concern with this patch is that I'm unsure if we need to
> >     worry about case-insensitive filesystems (ex: cwd=3Dmy_repo/.GIT in=
stead
> >     of my_repo/.git, it might not trigger this logic and end up allowed=
).
>
> You are additionally allowing ".git" so even if somebody has ".GIT"
> that won't be allowed by this change, no?

My concern was what happens if someone on a case-insensitive
filesystem does `cd .GIT` and then attempts to use it. If the cwd path
isn't case-normalized at some point, we'll have a string like
/path/to/my-repo/.GIT from getcwd() and it won't be allowed by this
code, since this code is checking for `.git` in a case sensitive
fashion.

>
> >     I'm assuming this isn't a significant concern, for two reasons:
> >
> >      * most filesystems/OSes in use today (by number of users) are at l=
east
> >        case-preserving, so users/tools will have had to type out .GIT
> >        instead of getting it from readdir/wherever.
> >      * this is primarily a "quality of life" change to the feature, and=
 if
> >        we get it wrong we still fail closed.
>
> Yup.
>
> If we really cared (which I doubt), we could resort to checking with
> is_ntfs_dotgit() and is_hfs_dotgit(), but that would work in the
> direction of loosening the check even further, which I do not know
> is needed.

Agreed, it's not worth the additional complexity.

>
> > -                     if (get_allowed_bare_repo() =3D=3D ALLOWED_BARE_R=
EPO_EXPLICIT)
> > +                     if (get_allowed_bare_repo() =3D=3D ALLOWED_BARE_R=
EPO_EXPLICIT &&
> > +                         !ends_with_path_components(dir->buf, ".git"))
> >                               return GIT_DIR_DISALLOWED_BARE;
>
> Thanks.
