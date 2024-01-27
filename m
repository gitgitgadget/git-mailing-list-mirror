Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBEA1A723
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706390592; cv=none; b=lugFrdbzyUx+N9EVTUPt4Q7BYqUwu9jOgId+QDixXjWWGUveBlNQOcOd0gQnD88KnWS1yGM7W/d9IFYbFQCv3l1sBE+79ygUx6YNGUHuP3ueDOlWdA6DrhSuHakkB4Q6/yyGPvaCqgSNcUbfle8zI0olfgCXyP+NEMfvxvv13YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706390592; c=relaxed/simple;
	bh=3vnoWhhed503MjLE4YTpQVkGne3WdlY3uKZKv2CEyMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6Kl0Q5sraBujBifN2bPQ3J0rqcirTPUcSZLZKMZtZnDVH1gOkEyz3VKNyKst018xdkMYgLtw4b6kZO7MaoXKFJWfYYpq1vf1c3FJS6nMcJfTPwGHM/017NKzuuny3vsqphtCJgDX6noQSTl2/NrmxO8iIZ/sUpqJPDEwiUf78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSWzj416; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSWzj416"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so14805501fa.3
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 13:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706390588; x=1706995388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYmirEPxplmsXucyOmadMe6flle1/E5DAOULUyOH6wI=;
        b=gSWzj416IXxUvDgXbi4L7YQnh3usF8u5t8GKYCt5MIUelx1iGZkf37ml9bCu+khLHU
         HVbsDTfnJRnD0M0DMpERvo55sJGu9PZayQjlvYmF0+EztcyOB3ZhkJHdApk4DvD9acg3
         AM03l+dl6CO0Ln6MMdNxE+gYnjXOttJXpzFJceIoT1etS4ByEw6qSbCtHARDdJLpH6/I
         U7an63ZwFdKYPFIX/9w3vJdfMYQo0cVIl60YvNGeFVDglUTAm15H7qad6kGF8yjuKu1u
         NBdcSgtfzmLSTJDDzDGfltfzhijPLL0WRp4L+GaBw/qAFg2Zt/9tch+kQYGVITTB7vIu
         ct4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706390588; x=1706995388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYmirEPxplmsXucyOmadMe6flle1/E5DAOULUyOH6wI=;
        b=WzVMe0S9dKvprIZfWN9fj/33N7KKF33iGwHHh3/Wyy57npvZQBUpQkKV0kHrICDUYB
         fN3WE+5UbRI5nlFAfZFtM2Y8i6/w/Z6Kyo90l5XVwFXKWHRQngL967YJCO7flrweX4Ub
         z7zXVGrPJllCWKNTkp5BL7tfm0lJqGLTpv5rLMgRYwPmYKSNRGCgIwz2SdGBEMz5Cf4J
         F/qxExKQ8/X+xnOrtX/JmH8K6p4VjyuJx1g0hYXLGo+e+QxaRuGGSHK2QEL/bfuCCC+8
         7JMloHqgiaQodxfwofuoNjgccys2J7ASYqaP54nBl7MsNL5kz+wxG2YCCZnB63OW71jM
         rWEw==
X-Gm-Message-State: AOJu0YwhGrO1if64geOkI6Nwp2L5hXL5wOtF9vGp641ZenqIiBwez8rl
	NDeel5aXxmjGef7hdbvQWFuSdlC/fHKrythd+61s8lkOEiqMKEAGJu3ykznPteRzyGvW40QI3fl
	cFpWOMPotEnynCPQalZetNBeENMs=
X-Google-Smtp-Source: AGHT+IFtRdxUEJiGnMRkMmG2BWeL4GtMI7r+v0Gjlry5WV4Ku+beWXBdZKJB1FanpRomtPvZtrorUobgy/dP8busFsg=
X-Received: by 2002:a05:6512:3241:b0:510:2582:5590 with SMTP id
 c1-20020a056512324100b0051025825590mr1068513lfr.12.1706390587975; Sat, 27 Jan
 2024 13:23:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-3-brianmlyles@gmail.com> <192892be-262c-487e-bb1d-6e50c01e2d66@gmail.com>
In-Reply-To: <192892be-262c-487e-bb1d-6e50c01e2d66@gmail.com>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Sat, 27 Jan 2024 15:22:31 -0600
Message-ID: <CAHPHrSdOVoBPR9vJou_Bxmq=4QW_z6nhnzxfmZ1Am0i-GJuz4g@mail.gmail.com>
Subject: Re: [PATCH 2/4] docs: Clean up `--empty` formatting in `git-rebase`
 and `git-am`
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip

On Tue, Jan 23, 2024 at 8:24=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
> > From: Brian Lyles <brianmlyles@gmail.com>
> >
> > Both of these pages document very similar `--empty` options, but with
> > different styles. This commit aims to make them more consistent.
>
> I think that's reasonable though the options they are worded as doing
> different things. For "am" it talks about the patch being empty - i.e. a
> patch of an empty commit whereas for "rebase" the option applies to
> non-empty commits that become empty. What does "am" do if you try to
> apply a patch whose changes are already present?

Hm -- as you mention, this does appear to have a different meaning for
git-am(1) than it does for git-rebase(1). Regardless of the `--empty`
value passed to git-am(1), a non-empty patch that is already present
appears to error and stop.

That is an unfortunate difference. I think that my updated version of
the git-am(1) docs is still easier to read, and preserves the original
meaning. So I'm inclined to say that it's still an improvement worth
making, and perhaps my commit message should just clarify that.
Thoughts?

> If you're aiming for consistency then it would be worth listing the
> possible values in the same order for each command.

That makes sense. I had initially maintained the existing order in which
these were documented, keeping the default option first. I think that
the updated layout makes the order less relevant by making it easier to
read and identify the default anyway.

I could see alphabetical being better, though with the changes later in
this series we'd end up with the deprecated `ask` being first or
out-or-order at the end. What are your thoughts on the ideal order for
these?

> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
> > index b4526ca246..3ee85f6d86 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -293,13 +293,20 @@ See also INCOMPATIBLE OPTIONS below.
> >       How to handle commits that are not empty to start and are not
> >       clean cherry-picks of any upstream commit, but which become
> >       empty after rebasing (because they contain a subset of already
> > -     upstream changes).  With drop (the default), commits that
> > -     become empty are dropped.  With keep, such commits are kept.
> > -     With ask (implied by `--interactive`), the rebase will halt when
> > -     an empty commit is applied allowing you to choose whether to
> > -     drop it, edit files more, or just commit the empty changes.
> > +     upstream changes):
> > ++
> > +--
> > +`drop`;;
> > +     The empty commit will be dropped. This is the default behavior.
>
> I think it would be clearer to say "The commit" - I found "The empty
> commit" confusing as the commit that is being picked isn't empty.

I could see that -- I'll adjust this for v2 of the patch.

> > +`keep`;;
> > +     The empty commit will be kept.
> > +`ask`;;
> > +     The rebase will halt when the empty commit is applied, allowing y=
ou to
> > +     choose whether to drop it, edit files more, or just commit the em=
pty
> > +     changes. This option is implied when `--interactive` is specified=
.
> >       Other options, like `--exec`, will use the default of drop unless
> >       `-i`/`--interactive` is explicitly specified.
>
> Thanks for adding a bit more detail about the default, however it looks
> to me like we keep commits that become empty when --exec is specified
>
>         if (options.empty =3D=3D EMPTY_UNSPECIFIED) {
>                 if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
>                         options.empty =3D EMPTY_STOP;
>                 else if (options.exec.nr > 0)
>                         options.empty =3D EMPTY_KEEP;
>                 else
>                         options.empty =3D EMPTY_DROP;
>         }
>
> Off the top of my head I'm not sure why or if that is a good idea.

The two lines indicating this behavior are actually pre-existing -- I
did not change them in this patch and thus didn't even think to fact
check them.

Upon testing this, I've confirmed that you are correct about the actual
behavior. I will address this in a separate commit in v2.

Thanks,
Brian Lyles
