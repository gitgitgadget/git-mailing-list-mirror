Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C3C142
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036307; cv=none; b=NEpZ9M2mr2+1uKQaHRum7crYcPRrqe37XUlqOQGoPRWKzZe6KeVha2aiUea3P79MT/Q1gOJ3lLlat9L/GiaElC1sIhb9sEbUZWf9Ri1uEc4MLZeuVRn/FN6SGxsUEydbehAHmOeLLEv/qe+QL8NeyAGkaGLBok3QtEPJ2aELjDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036307; c=relaxed/simple;
	bh=gIiWlTMdrq2Hww6bbrvCkw1l/M/yQ3/OsWQ1lI+ckL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRglzml1t1K6ODqVyFp8CQf9SjyybQEmzC3828jE1QFCAXyvKUoHk5WUpBokFKmpvlyeKWWLjJE0KYz3myyUUcq6d1ZJx91qnQLwn9ODhYFev2D1jFog41YBtMUKsbqDNzrl5f+Z04ouh0fKzxxW7zlJXc0G1hLPvC4/7HO27To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJ64w4VS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJ64w4VS"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2a17f3217aso178301566b.2
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708036303; x=1708641103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1KirdrNp2yix9Ju7QvVq6Fshc1+HA/rtqe0n3AfjGE=;
        b=WJ64w4VSay7tZig0KHSUQjaE5lICSRJqf8S5kyh5tIWZKQn9626Ng3WdKG5ergW6+x
         brh5PNJpK9+5b8xwxQxQLceVNBtw/heWvgxurDBOwHVNx/SnaLs+nn+1s7LOA99vKCqU
         Fj7YTQ3KdEVykSKKaTuYRonoh24dH6msMGHAzdjn/iIECsCK6Cd12fQI5F3u5T0f7gkH
         MEo1zo3qkGaARSfdFhFY6bCCyD/AhW/4/cEF34O0z0xARHBHxu9zwbH3b+yuQSh1nJhj
         u5CMuoiiNA5vFxKlo0LN/UqDxZ+yQFwKWWSVCeFNg6P9/pw+EdN31709rvxB0A1WZHGh
         rW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708036303; x=1708641103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1KirdrNp2yix9Ju7QvVq6Fshc1+HA/rtqe0n3AfjGE=;
        b=ItFriY/9BVw0QT9YHl47KDViqw+hHk9xQE4uIJG6QJEqhcevRWQBpEgeEf7wBK6ymA
         vQ0qjt54TR8pnugStGw6zSbuhGmVKkxxKvBcwhcVPK06YMe7+g1DzaLpu0iLZ3cI70fV
         6BhFyCUXibKTb2Vm1BFSzQqhsSSAGzbsxg8S4WAGTJBzGsi4dg12XWnay/NEyaPgYDWv
         eVqaiYexjC/0LgCIZKdlL/Lzu1U6zP5xwtiodwHEGUgIETOmwkIC+cSNu/zGrvckZQfc
         ZyY7/w42AduSx97Qj1e30ERx9HeIf9EfO3gNWw0KjT4cWg+Dhh9YhVn76UytUHFazhfZ
         TAmg==
X-Gm-Message-State: AOJu0YyFCIJYrKCbd/GEbQy6+F6MDUKd0DHHqeWsCrUoJtzXMgw/qqtf
	B3nHUNYl5hG0dJNjVZ7b5s0vHOm6h8mHygEVBJ5WRDrlTVGN6LiaTPsZhfTjH8dEMxWjcyuihLB
	4JdgaMtMPVIhU+NGnxsUYsSU9h90ENWYFg5B2Aejzb91nqEGLOg==
X-Google-Smtp-Source: AGHT+IGCTKBGXSEDa5LYcVZG1aN/tc5tMCmIVrGYdfNCM+q4L6ACHzMn+PFheTd+siavDtFb2VY+V0hHTU/HLoopN6E=
X-Received: by 2002:a17:906:4a17:b0:a38:107a:94f6 with SMTP id
 w23-20020a1709064a1700b00a38107a94f6mr2022176eju.71.1708036303306; Thu, 15
 Feb 2024 14:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
In-Reply-To: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 15 Feb 2024 14:31:31 -0800
Message-ID: <CAO_smVioz0izmunDRyHjU_7GGz-_Om_6AVw2CZGFyb4ZF8yedg@mail.gmail.com>
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy operations
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:43=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Move the descriptions of the <oldbranch> and <newbranch> arguments to the
> descriptions of the branch rename and copy operations, where they natural=
ly
> belong.  Also, improve the descriptions of these two branch operations an=
d,
> for completeness, describe the outcomes of forced operations.
>
> Describing the arguments together with their respective operations, inste=
ad
> of describing them separately in a rather unfortunate attempt to squeeze =
more
> meaning out of fewer words, flows much better and makes the git-branch(1)
> man page significantly more usable.
>
> The subsequent improvements shall continue this approach by either dissol=
ving
> as many sentences from the "Description" section into the "Options" secti=
on,
> or by having those sentences converted into some kind of more readable an=
d
> better flowing prose, as already discussed and outlined. [1][2]
>
> [1] https://lore.kernel.org/git/xmqqttmmlahf.fsf@gitster.g/T/#u
> [2] https://lore.kernel.org/git/xmqq8r4zln08.fsf@gitster.g/T/#u
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>
> Notes:
>     This patch was originally named "branch: clarify <oldbranch> and <new=
branch>
>     terms further", submitted and discussed in another thread, [3] but th=
e nature
>     of the patch has changed, causing the patch subject to be adjusted to=
 match.
>
>     Consequently, this is effectively version 2 of the patch, which inclu=
des
>     detailed feedback from Kyle and Junio, who suggested moving/adding th=
e
>     argument descriptions to their respective commands.  This resulted in=
 more
>     significant changes to the contents of the git-branch(1) man page, in=
 an
>     attempt to make it more readable.
>
>     [3] https://lore.kernel.org/git/e2eb777bca8ffeec42bdd684837d28dd52cfc=
9c3.1707136999.git.dsimic@manjaro.org/T/#u
>
>  Documentation/git-branch.txt | 44 +++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)

Thanks! I think this is a great improvement to this document.

>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 0b0844293235..370ea43c0380 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -72,16 +72,6 @@ the remote-tracking branch. This behavior may be chang=
ed via the global
>  overridden by using the `--track` and `--no-track` options, and
>  changed later using `git branch --set-upstream-to`.
>
> -With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
> -If <oldbranch> had a corresponding reflog, it is renamed to match
> -<newbranch>, and a reflog entry is created to remember the branch
> -renaming. If <newbranch> exists, -M must be used to force the rename
> -to happen.
> -
> -The `-c` and `-C` options have the exact same semantics as `-m` and
> -`-M`, except instead of the branch being renamed, it will be copied to a
> -new name, along with its config and reflog.
> -
>  With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
>  specify more than one branch for deletion.  If the branch currently
>  has a reflog then the reflog will also be deleted.
> @@ -128,18 +118,28 @@ Note that 'git branch -f <branchname> [<start-point=
>]', even with '-f',
>  refuses to change an existing branch `<branchname>` that is checked out
>  in another worktree linked to the same repository.
>
> --m::
> ---move::
> -       Move/rename a branch, together with its config and reflog.
> +-m [<oldbranch>] <newbranch>::
> +--move [<oldbranch>] <newbranch>::
> +       Rename an existing branch <oldbranch>, which if not specified def=
aults
> +       to the current branch, to <newbranch>.  The configuration variabl=
es

Very minor nit: the prevailing style in this document appears to be to
have a single space after the period, but it's definitely
inconsistent. I don't see anything in Documentation/CodingGuidelines
suggesting one way or the other, so don't consider this comment as
blocking, just informational. If we want to achieve (eventual)
consistency, we may want to use a single space after the period now.

> +       for the <oldbranch> branch and its reflog are also renamed approp=
riately
> +       to be used with <newbranch>.  Renaming fails if branch <newbranch=
>
> +       already exists, but you can use `-M` or `--move --force` to overw=
rite
> +       the files in existing branch <newbranch> while renaming.
>
> --M::
> +-M [<oldbranch>] <newbranch>::
>         Shortcut for `--move --force`.
>
> --c::
> ---copy::
> -       Copy a branch, together with its config and reflog.
> +-c [<oldbranch>] <newbranch>::
> +--copy [<oldbranch>] <newbranch>::
> +       Copy an existing branch <oldbranch>, which if not specified defau=
lts
> +       to the current branch, to <newbranch>.  The configuration variabl=
es
> +       for the <oldbranch> branch and its reflog are also copied appropr=
iately
> +       to be used with <newbranch>.  Copying fails if branch <newbranch>
> +       already exists, but you can use `-C` or `--copy --force` to overw=
rite
> +       the files in existing branch <newbranch> while copying.
>
> --C::
> +-C [<oldbranch>] <newbranch>::
>         Shortcut for `--copy --force`.
>
>  --color[=3D<when>]::
> @@ -311,14 +311,6 @@ superproject's "origin/main", but tracks the submodu=
le's "origin/main".
>         given as a branch name, a commit-id, or a tag.  If this
>         option is omitted, the current HEAD will be used instead.
>
> -<oldbranch>::
> -       The name of an existing branch.  If this option is omitted,
> -       the name of the current branch will be used instead.
> -
> -<newbranch>::
> -       The new name for an existing branch. The same restrictions as for
> -       <branchname> apply.
> -
>  --sort=3D<key>::
>         Sort based on the key given. Prefix `-` to sort in descending
>         order of the value. You may use the --sort=3D<key> option
>
