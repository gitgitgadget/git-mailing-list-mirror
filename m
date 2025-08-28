Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991FC2116E9
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409297; cv=none; b=Jzo8MtpZq9Y5YYjyj+TEVUVkZAX94fsMyA6/6fGO7EznRe+AemP6qZS9jdbao2vSje5RQ5Gjt5/FZr2+IkaxmZEqHNiy5YGRc8kzm7nb+aod25v4UpE8cnF9JikaCYS21twS7x/3HpYb8AkUDW+7E/JbNRZcZBVPmcaYKw7s7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409297; c=relaxed/simple;
	bh=eOKspV5aC4H30Az7n3vFPQKzvOKaZb5vAdc2wmgb48s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWH2G6ymw6Y6zxjHIQUbBa0ooX0l5FwCarCtBZpXvI5WANtGQu5Mi/7gpKM+JeWBMhq9KlMiPGZn8CEyb04LCfsnpPOAmLfRmEFNpWQodjJOWkAMSxxIkPKkeXurHsWwoEV/2Skw932YQkNA8I0NHl/aWNBrMMjp3mf2mMKpIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNiX10F7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNiX10F7"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61caa266828so2843671a12.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756409294; x=1757014094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4iMOuqeqQzCW35iWxbRlNrAKYdbjaixjEmXEHT91H4=;
        b=hNiX10F7DFdzTJVg1z3O/avI8H6mxqm7wvezoAiraHmOXaTEM8LEib9XtL9FsaN/7Y
         5AGbxdFvtmm9isuXbLa3WSlgSMHL4vhWnVX+pn4iiCQVl5OIaa7Lq4vbM0OQusgU7Vgr
         srTWCC06CFEByHAE3UTT5D2q+75tpq4YOR73mhEDy3qA9CSMOy6Od5gZWIrwfT7JFKYZ
         vnWJ33UMMa0/idhRB6Tpq2iRSJ+JFYnGOHam1rwq0AKkcBhWiBWWrg7r5txq2ihLX7pH
         FwFK0HHzLx9Vcsgdgwb1bx482X01qhzxfsURxU1tmymEt+SE+O85cjuBNbYt9dWR04d6
         5JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756409294; x=1757014094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4iMOuqeqQzCW35iWxbRlNrAKYdbjaixjEmXEHT91H4=;
        b=b8OEdMMMF9Hwfkrk2t7CwXzxSE9JjbDzgc0rEm5oAtFoiwrLHiByMm+ElCpzVqHyLn
         2CIfeTJ5j9iKf5tvQbW6MjYs5eCC/hP0AJai40ZO0yZ10K3WfmvQGMvlnoR829QAupK0
         SDINSX0LSY0KQlaLvE0+kzsAKy/oBURRbxm5UPo+7oZt3CQ5+fl13v6Oss3zBWhlRDNJ
         5gmYUqQS22UxcEaSDy0GA6nFhTJpPiHha4/Oe3UIkEB6d2wFbiFBkbSmeDm5nlEocQFq
         c+yud05qDAKsvrUmSrvGsx7gvL146lvn7m8EJBvI63bFOsEp7UAy8SsWHUqimMzfJOzo
         3MoQ==
X-Gm-Message-State: AOJu0YyZsYqQ+6HZVxBx0ldKh8z5BV1P6gvq0SiYWd1lxLtnEKsfE+9y
	ucNLvO0rvFojxIqMlz+orIaNDV+XV+9eM7u0fUmn4XbISQBV+LhWih8cExA2ok5qqQzbRACGXgS
	aHlKC6jyxbuhAf6CrcTgTgH0PuX2v16M=
X-Gm-Gg: ASbGnctBEaLLCCayM2JXw/KONmbBd8/u3Oi5X8qS8/S8ZBgY5R4dE65KpEkZ0VO6kJz
	+Gd9UwNVeCcc2S35Gcz8yYTBVgcq/FiTgsZq8exBIa+QLFq0gIQwjDJRnYTbQTxFMLeK1Mbzv8A
	F5THKntcH4aJmncNxWfQQ3gO3ejEsqN0F2mWp3HJONxphLQjVGly5sdCf3LJdMHA9pfuB6NAO26
	ISeMnCLMcoPE+6zNQ4l/vE7wkfaYr22iMVMGmDSIlvT2YgYj4sdy8H3Z4Dp7Yg=
X-Google-Smtp-Source: AGHT+IFRSKabf6WYI63HyTDCKR66e6itlmlZklWj00fk54ZPZlSX1FtwOQvQb4cpRg7GSD3QOYQ/5byyKILJ7VuapE8=
X-Received: by 2002:a05:6402:5207:b0:61c:ae5e:d1cd with SMTP id
 4fb4d7f45d1cf-61cae5ed3cemr6359623a12.35.1756409293513; Thu, 28 Aug 2025
 12:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com> <72114133aafc94354c8b7f3c8ac65456421ce34b.1756240823.git.gitgitgadget@gmail.com>
In-Reply-To: <72114133aafc94354c8b7f3c8ac65456421ce34b.1756240823.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 28 Aug 2025 15:28:02 -0400
X-Gm-Features: Ac12FXz_kcoohAS42WLCuoE661xaQXrQNodOM2ZaKKgrNPuVnFWZp9LImBbq6Fs
Message-ID: <CALnO6CCZD+DQSG9OMbAia02Nhpseuko95RVRYZ6-YJpvfsAWog@mail.gmail.com>
Subject: Re: [PATCH 4/4] doc: git-push: rewrite refspec specification
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the docs updates! A few nits below, but this looks nice to me :)

On Tue, Aug 26, 2025 at 4:40=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> - Originally it said that a refspec was `+<src>:<dst>`, but then later
>   contradicted itself by saying that the `:<dst>` is optional.
>   Mention that `:<dst>` is optional much earlier.
> - Put the complex sets of rules about different refspec forms
>   in lists instead of in long paragraphs of prose
> - Add examples for the various types of refspecs
>   (negative, deletion, pattern, etc)
> - Previously `*` and `^` were not mentioned, mention them
> - Explain what `+` does earlier
> - Remove "might be added in the future" (it's a given that software
>   might change in the future)

Excellent ideas!

> diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
> index 0232195515c9..78d433c60c51 100644
> --- a/Documentation/git-push.adoc
> +++ b/Documentation/git-push.adoc
> @@ -57,77 +57,74 @@ OPTIONS[[OPTIONS]]
> +The format for a refspec is [+]<src>[:<dst>], for example `main`,
> +`main:other`, or `HEAD^:refs/heads/main`.
> ++
> +The `<src>` is often the name of the local branch to push, but it can be
> +any arbitrary "SHA-1 expression" (see linkgit:gitrevisions[7]).
> ++
> +The `<dst>` determines what to update on the remote side. It must be the
> +name of a branch, tag, or other ref, not an arbitrary expression.

A welcome (to me) simplification from the original paragraph,
especially if we don't lose the original content but rearrange it
better :)

> +`:<dst>` is optional.

Here=E2=80=A6

> ++
> +`+` is optional and does the same thing as `--force`.
> ++

=E2=80=A6and here, I find it odd to start sentences with punctuation if we =
can avoid it.

> +You can write a refspec using the fully expanded form (for
> +example `main:refs/heads/main`) which specifies the exact source
> +and destination, or with a shorter form (for example `main` or
> +`main:other`). Here are the rules for how refspecs are expanded,
> +as well as various other special refspec forms:
> ++
> + 1. `<src>` without a `:<dst>` means to update the same ref as the
> +       `<src>`, unless the `remote.<repository>.push` configuration spec=
ifies a
> +       different <dst>. For example, if `main` is a branch, then the ref=
spec
> +    `main` expands to `main:refs/heads/main`.
> + 2. If <dst> unambiguously refers to a ref on the <repository> remote,
> +    then expand it to that ref. For example, if `v1.0` is a tag on the
> +    remote, then `HEAD:v1.0` expands to `HEAD:refs/tags/v1.0`.
> + 3. If <src> resolves to a ref starting with refs/heads/ or refs/tags/,
> +    then prepend that to <dst>. For example, if `main` is a branch, then
> +    `main:other` expands to `main:refs/heads/other`
> + 4. The special refspec `:` (or `+:` to allow non-fast-forward updates)
> +    directs Git to push "matching" branches: for every branch that exist=
s on
> +    the local side, the remote side is updated if a branch of the same n=
ame
> +    already exists on the remote side.

I'm not 100% sure this belongs as an item in an ordered list here,
since it implies (structurally) something about the order of possible
expansions tried. But the introduction to the list does say "rules
[and] special refspec forms"=E2=80=A6 Hm. Maybe it's worth splitting the
special ones out? idk.

I see Junio mentioned something similar.

> + 5. `tag <tag>` expands to `refs/tags/<tag>:refs/tags/<tag>`.
> + 6. <src> may contain a * to indicate a simple pattern match.
> +    This works like a glob that matches any ref matching the pattern.
> +    There must be only one * in both the <src> and <dst>.
> +    It will map refs to the destination by replacing the * with the

Should src/dst/* have backticks here? I'm not sure.

> +    contents matched from the source. For example, `refs/heads/*:refs/he=
ads/*`
> +    will push all branches.
> + 7. A refspec starting with ^ is a negative refspec.

Ditto the "^"

> +    This specifies refs to exclude. A ref will be considered to
> +    match if it matches at least one positive refspec, and does not
> +    match any negative refspec. Negative refspecs can be pattern refspec=
s.
> +    They must only contain a <src>.
> +    Fully spelled out hex object names are also not supported.
> +    For example, `git push origin 'refs/heads/*' '^refs/heads/dev-*'`
> +    will push all branches except for those starting with `dev-`

I learned something new today! This isn't in the manual I have for
2.48.1 or 2.51.x locally. Thanks! [Junio mentions it's on the fetch
side, which I see now]

> + 8. If `<src>` is empty, it deletes the <dst> ref from the remote

Backticks for dst ;)

> +    repository. For example, `git push origin :dev` will
> +    delete the `dev` branch.
> +    Deletions are always accepted without a leading `+` in the
> +    refspec (or `--force`), except when forbidden by configuration or ho=
oks.

Maybe "except when forbidden on the remote by=E2=80=A6" ? (This came from t=
he
original and does not need tweaked in this series, though.)

> +    See `receive.denyDeletes` in linkgit:git-config[1] and `pre-receive`=
 and
> +    `update` in linkgit:githooks[5].
> + 9. If the refspec can't be expanded unambiguously, error
> +    out with an error indicating what was
> +    tried, and depending on the `advice.pushUnqualifiedRefname`
> +    configuration (see linkgit:git-config[1]) suggest what refs/
> +    namespace you may have wanted to push to.

Wrapping looks strange to me here.

> +
> ++
> +Not all updates are allowed: it depends on what kind of destination
> +you're pushing to. In the following rules "update" means any
> +modifications except deletes, which as noted above are treated different=
ly.
> ++
> +All of these rules
> +can be overridden by adding the optional leading `+` to a refspec

Ditto.

>  (or using `--force` command line option). The only exception to this
>  is that no amount of forcing will make the `refs/heads/*` namespace
>  accept a non-commit object. Hooks and configuration can also override
> @@ -135,18 +132,21 @@ or amend these rules, see e.g. `receive.denyNonFast=
Forwards` in
>  linkgit:git-config[1] and `pre-receive` and `update` in
>  linkgit:githooks[5].
>  +
> -Pushing an empty <src> allows you to delete the <dst> ref from the
> -remote repository. Deletions are always accepted without a leading `+`
> -in the refspec (or `--force`), except when forbidden by configuration
> -or hooks. See `receive.denyDeletes` in linkgit:git-config[1] and
> -`pre-receive` and `update` in linkgit:githooks[5].
> -+
> -The special refspec `:` (or `+:` to allow non-fast-forward updates)
> -directs Git to push "matching" branches: for every branch that exists on
> -the local side, the remote side is updated if a branch of the same name
> -already exists on the remote side.
> -+
> -`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
> +1. If the destination is a **branch** (`refs/heads/*`): the source must
> +   be a commit object, and only fast-forward updates are allowed.
> +2. If the destination is a **tag** (`refs/tags/*`):  the source can
> +   be any object (as commits, trees and blobs can be tagged), and any
> +   updates to them will be rejected.
> +3. For destinations outside of `refs/{tags,heads}/*`:
> +   * If the source is a tree or blob object, any updates will be rejecte=
d
> +   * If the source is a tag or commit object, any fast-forward update
> +     is allowed, even in cases where what's being fast-forwarded is not =
a
> +     commit, but a tag object which happens to point to a new commit whi=
ch
> +     is a fast-forward of the commit the last tag (or commit) it's
> +     replacing. Replacing a tag with an entirely different tag is also
> +     allowed, if it points to the same commit, as well as pushing a peel=
ed
> +     tag, i.e. pushing the commit that existing tag object points to, or=
 a
> +     new tag object which an existing commit points to.

I didn't close-read this bit, but it seems reasonable.

--=20
D. Ben Knoble
