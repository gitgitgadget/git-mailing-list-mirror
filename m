Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D913AA23
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037811; cv=none; b=K6zOEsZek+8tBaAIiZ9eFndefUQjyKwXY/emEW9vdEZjNx5+yeK32D4CYHyhXPn06i6eG1Wnz/DEKfvPySFtYAPEG6uOEwCa8aW7zJa1SsfH6i0N7wt22y7K6LrACgv7jm1Fw8GbMgmhUmfk+u2eQxuNTcUHbQe9BvZ0RQ94Cug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037811; c=relaxed/simple;
	bh=dtDLvAOymgykmIHj6Hf+SAVCn2smj9L5U+m/IFYc3Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIsC7FCre3Qoz2LJLxxXnS//Sq9mFJbUCZoS4jzeyHfpR9gqXZsmbtrXj5wnmG1CrtolqFgQW3ZYOunACejpyzK3L2K/jaor4ZSx90GLRX8rxMSjSWm+3BIZELt/sBbVjO7qNSJCNQloOcGjPxuwm+pfadBysogeEYDVAGy1n2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=to4NI4O0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="to4NI4O0"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5101cd91017so1829915e87.2
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 14:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708037808; x=1708642608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR3ND939I9+qhpo/q2ULIeXOyhA4VX+D/gxqEla8Wms=;
        b=to4NI4O02bLSjWfyB/x3jezCveyDNefmiQFV+nx7mX2iYbE0i9hyDcFNu9eEluS2JA
         sB4Jgz4Y+4z4gjjlbIs8MrKEvXNTVbOrOs3+LpzmpO5SVPkSWzSQlVkqGV+HXkarWEsV
         nt5OCS9e4W5SrZ/hJLt6zZArGRP7QpKky9mP7m8Pxf6C1smYUu65O851a3NdhtI0xHrS
         Vp6pHnwmPh5KrNOCcaeSjmU6h7UcE6OvPNS2HfI/gLhir9DnAsr4VHViItKoPS6KeaOJ
         6jGXL9n4wpQt2ZKv/LADRS0P2W4Ya+eG7RvhHNy/2dr46dCKL71yi5cEK+zttg/bYW+b
         yTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708037808; x=1708642608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR3ND939I9+qhpo/q2ULIeXOyhA4VX+D/gxqEla8Wms=;
        b=LhxQH4jdjLEqwa2wSlWw8eX11ZAOhW8I5b4q4u9T3pUPon1L0f8y9hc5T1DRiPnqlv
         8HLO0eBTETGeM2KgGJ4kfhxxQFP+ipUS6YJit3ApwVZhZfeW94XQXrd85HnZJSBF9zBg
         cQ7ilBOdnjfhx4nEWkd24pX9cW87MH3zyYzl+rJCPaWurw9OQBacIdZw9raMbmU5Adv+
         DYzxcST15EYDnckmFTU36CMle+GcNXmcsV8Eo9w7caWH0SqTMyuR9mFnLouHC7vWFgNS
         1a/n85JlKlhysjQwCTZPHHFKo02EwdackqrrjSYXhmn1ZKDHJ85FbpReYVdsZEbysJnH
         b+CA==
X-Gm-Message-State: AOJu0YyNEDKS5EKJR5JG7eVuK7LImByDcKTckSCzc78RxwbxQJZPqiPG
	eaxEnunZrKFKzulqX5HJOAgGVq16FGkTSldzz1m1y8hIYeCaJkWrCU1oE0zbPPjp98E8ORf/uoM
	3XqVcBiY2Rz/rK6/zVIpa1XOJ0YhvBX5V77Xt0K+hNDpk/GAcIA==
X-Google-Smtp-Source: AGHT+IGnm6oTRNiuFnvXxGZ0w3I2QYUDYIeZjo5JqtulHzuyhWP5wtIU/xa31T4GDPcKWj3coTPqs8FmZklcXkELr4I=
X-Received: by 2002:a05:6512:945:b0:511:6031:3f1c with SMTP id
 u5-20020a056512094500b0051160313f1cmr2173842lft.28.1708037807385; Thu, 15 Feb
 2024 14:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <CAO_smVioz0izmunDRyHjU_7GGz-_Om_6AVw2CZGFyb4ZF8yedg@mail.gmail.com> <e02b953f3320eff7d6ae2ecf684c8be2@manjaro.org>
In-Reply-To: <e02b953f3320eff7d6ae2ecf684c8be2@manjaro.org>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 15 Feb 2024 14:56:30 -0800
Message-ID: <CAO_smVizZ6K-tSSubr7Pd95zn42GAHrgeeSQ7ZWmKdPH7gMy3w@mail.gmail.com>
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy operations
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 2:38=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Kyle,
>
> On 2024-02-15 23:31, Kyle Lippincott wrote:
> > On Thu, Feb 15, 2024 at 10:43=E2=80=AFAM Dragan Simic <dsimic@manjaro.o=
rg>
> > wrote:
> >>
> >> Move the descriptions of the <oldbranch> and <newbranch> arguments to
> >> the
> >> descriptions of the branch rename and copy operations, where they
> >> naturally
> >> belong.  Also, improve the descriptions of these two branch operations
> >> and,
> >> for completeness, describe the outcomes of forced operations.
> >>
> >> Describing the arguments together with their respective operations,
> >> instead
> >> of describing them separately in a rather unfortunate attempt to
> >> squeeze more
> >> meaning out of fewer words, flows much better and makes the
> >> git-branch(1)
> >> man page significantly more usable.
> >>
> >> The subsequent improvements shall continue this approach by either
> >> dissolving
> >> as many sentences from the "Description" section into the "Options"
> >> section,
> >> or by having those sentences converted into some kind of more readable
> >> and
> >> better flowing prose, as already discussed and outlined. [1][2]
> >>
> >> [1] https://lore.kernel.org/git/xmqqttmmlahf.fsf@gitster.g/T/#u
> >> [2] https://lore.kernel.org/git/xmqq8r4zln08.fsf@gitster.g/T/#u
> >>
> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> ---
> >>
> >> Notes:
> >>     This patch was originally named "branch: clarify <oldbranch> and
> >> <newbranch>
> >>     terms further", submitted and discussed in another thread, [3] but
> >> the nature
> >>     of the patch has changed, causing the patch subject to be adjusted
> >> to match.
> >>
> >>     Consequently, this is effectively version 2 of the patch, which
> >> includes
> >>     detailed feedback from Kyle and Junio, who suggested moving/adding
> >> the
> >>     argument descriptions to their respective commands.  This resulted
> >> in more
> >>     significant changes to the contents of the git-branch(1) man page,
> >> in an
> >>     attempt to make it more readable.
> >>
> >>     [3]
> >> https://lore.kernel.org/git/e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1=
707136999.git.dsimic@manjaro.org/T/#u
> >>
> >>  Documentation/git-branch.txt | 44
> >> +++++++++++++++---------------------
> >>  1 file changed, 18 insertions(+), 26 deletions(-)
> >
> > Thanks! I think this is a great improvement to this document.
>
> Thank you, I'm glad that you like it. :)
>
> >> diff --git a/Documentation/git-branch.txt
> >> b/Documentation/git-branch.txt
> >> index 0b0844293235..370ea43c0380 100644
> >> --- a/Documentation/git-branch.txt
> >> +++ b/Documentation/git-branch.txt
> >> @@ -72,16 +72,6 @@ the remote-tracking branch. This behavior may be
> >> changed via the global
> >>  overridden by using the `--track` and `--no-track` options, and
> >>  changed later using `git branch --set-upstream-to`.
> >>
> >> -With a `-m` or `-M` option, <oldbranch> will be renamed to
> >> <newbranch>.
> >> -If <oldbranch> had a corresponding reflog, it is renamed to match
> >> -<newbranch>, and a reflog entry is created to remember the branch
> >> -renaming. If <newbranch> exists, -M must be used to force the rename
> >> -to happen.
> >> -
> >> -The `-c` and `-C` options have the exact same semantics as `-m` and
> >> -`-M`, except instead of the branch being renamed, it will be copied
> >> to a
> >> -new name, along with its config and reflog.
> >> -
> >>  With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
> >>  specify more than one branch for deletion.  If the branch currently
> >>  has a reflog then the reflog will also be deleted.
> >> @@ -128,18 +118,28 @@ Note that 'git branch -f <branchname>
> >> [<start-point>]', even with '-f',
> >>  refuses to change an existing branch `<branchname>` that is checked
> >> out
> >>  in another worktree linked to the same repository.
> >>
> >> --m::
> >> ---move::
> >> -       Move/rename a branch, together with its config and reflog.
> >> +-m [<oldbranch>] <newbranch>::
> >> +--move [<oldbranch>] <newbranch>::
> >> +       Rename an existing branch <oldbranch>, which if not specified
> >> defaults
> >> +       to the current branch, to <newbranch>.  The configuration
> >> variables
> >
> > Very minor nit: the prevailing style in this document appears to be to
> > have a single space after the period, but it's definitely
> > inconsistent. I don't see anything in Documentation/CodingGuidelines
> > suggesting one way or the other, so don't consider this comment as
> > blocking, just informational. If we want to achieve (eventual)
> > consistency, we may want to use a single space after the period now.
>
> In this case, I went with following the intersentence spacing used in
> the surrounding text.  Though, my brain and muscle memory are kind of
> hardcoded to use double spacing, which may not be as prevalent as a
> while
> ago, but IMHO makes reading text rendered using a fixed-width font much
> easier.  I can adjust if needed, of course.

No need to adjust if I'm the only one mentioning it. I'm very new to
the project, so please don't take my style nits as any sort of
mandate, since I'm the one that's most likely to be miscalibrated. :)

>
> >> +       for the <oldbranch> branch and its reflog are also renamed
> >> appropriately
> >> +       to be used with <newbranch>.  Renaming fails if branch
> >> <newbranch>
> >> +       already exists, but you can use `-M` or `--move --force` to
> >> overwrite
> >> +       the files in existing branch <newbranch> while renaming.
> >>
> >> --M::
> >> +-M [<oldbranch>] <newbranch>::
> >>         Shortcut for `--move --force`.
> >>
> >> --c::
> >> ---copy::
> >> -       Copy a branch, together with its config and reflog.
> >> +-c [<oldbranch>] <newbranch>::
> >> +--copy [<oldbranch>] <newbranch>::
> >> +       Copy an existing branch <oldbranch>, which if not specified
> >> defaults
> >> +       to the current branch, to <newbranch>.  The configuration
> >> variables
> >> +       for the <oldbranch> branch and its reflog are also copied
> >> appropriately
> >> +       to be used with <newbranch>.  Copying fails if branch
> >> <newbranch>
> >> +       already exists, but you can use `-C` or `--copy --force` to
> >> overwrite
> >> +       the files in existing branch <newbranch> while copying.
> >>
> >> --C::
> >> +-C [<oldbranch>] <newbranch>::
> >>         Shortcut for `--copy --force`.
> >>
> >>  --color[=3D<when>]::
> >> @@ -311,14 +311,6 @@ superproject's "origin/main", but tracks the
> >> submodule's "origin/main".
> >>         given as a branch name, a commit-id, or a tag.  If this
> >>         option is omitted, the current HEAD will be used instead.
> >>
> >> -<oldbranch>::
> >> -       The name of an existing branch.  If this option is omitted,
> >> -       the name of the current branch will be used instead.
> >> -
> >> -<newbranch>::
> >> -       The new name for an existing branch. The same restrictions as
> >> for
> >> -       <branchname> apply.
> >> -
> >>  --sort=3D<key>::
> >>         Sort based on the key given. Prefix `-` to sort in descending
> >>         order of the value. You may use the --sort=3D<key> option
> >>
