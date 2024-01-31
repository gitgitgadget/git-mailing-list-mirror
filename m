Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693237BAEC
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719254; cv=none; b=r2nw32+uYwh3+2sMMOpJD6T+WpiGCdif6WgnsSpwnNxRbLCvxhulsiFnGcBteGue4NC93is9/PF/USIgMOnNGtrQfHWJMaCRHZsbhwP2kOyjVW4d106WwxVqTJytZ5wR9q7kxk0o77PYzS7y7wgIJOB5BLxjpaLPRGGc2ptb0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719254; c=relaxed/simple;
	bh=GFXwTSHJKnFUSBvMk0l9lXgP2oOY5ORYE55KrQZD5o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lM4yNpA+rJ3JQH/ZsFQTtZHrVjBXMfOnBS/KlL3pDXS1/apuCN2vyw7qZVszL9qiBAZvfZrpp1wtU21Jx6y7C1/a3YvNNyEUImgwVCvhTCp4l2n+tovRXeiWor780OK4S5wkchYVz747AQ3ZZ7mJVX17Q6/P7uNYXyfC9T8PCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMRuFZX2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMRuFZX2"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-510221ab3ebso7516515e87.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 08:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706719250; x=1707324050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG+kaISee2Bzy+z8sDcFFqYNP9+MSILKhxwvDEfMFFE=;
        b=UMRuFZX2va5YyrR3f9g/FvCMCffVwuIyXMDB4iSbQ9v/doYfZzczYK1oGG+6MntJgd
         NgUKFCNWkucXOlVqQ09DVUiSmRCvMuznOwf4dtvMG6c73ieYwJkFGMOs+923aPMXGCwz
         qAhHCvyl7iD5m9V7D2zNOQbTG/baNc3Aegb+E4HNPdo5lmaAOngE8CN61VHJVzc+sQOY
         2XUxh6Ca9cu5YN+XsRAW+jUIyxMWM7gfFom85B5Yforqd+ZQ1DJeDBp66ZaufFJmBumE
         D8tq0yAuULznER3UvC//YNIGMjYAY1ukplqYrwqKHwFYA/75bjE3PZ1+SNpdnWfyBIV3
         Cfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706719250; x=1707324050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG+kaISee2Bzy+z8sDcFFqYNP9+MSILKhxwvDEfMFFE=;
        b=I60gUNddftVyWH/Bc70aE5u/UupFEJmMIpfrNLUvlfUNwiMyeXL/J6nCAvqnnuiI2t
         tryx1vvhc5b3LG3RWQdz4nNHcgH/18pqGIJM/z2VGl2jZXrxmHPJysYUXHzzsPsfQ3q3
         Ux6v72wLbI2s5n4LF0idS+eoph9gkLWReOUeJ3MTkafbq4NJVPLO6umWFVijtUZIez0e
         oByiIR7bNs7cKYN3NvfoW0K18byWpyK55IOHrpuz0P69wudCOZQhu90hR82YLQxW/qyv
         Teq/IuLNkycd6X/w8bMbpGNCoxr6oCHmMlSLiglSX5birdsb0JCHhzDnyQc00Uv7Pbcl
         IQDw==
X-Gm-Message-State: AOJu0YzWxQcSjZEP06nD6g6NEJ3SMSyMwZwcjnD4RNmxJQ1zT6pAi8zb
	3WxwlXpLRkgjcmiDpjodCBTUwEFtdRlDdd6Sc2tYbTRlvCnZSF2B8aDtHc4NFFPUYOC9TY9ynB6
	WzfJfk0z5bjrwseaOeWD03NJr0YA=
X-Google-Smtp-Source: AGHT+IGGuxs7B9ruQfWfMW20a/+nq52r2N2RHIwY+0mQHKa4UgYgxA5ZFlbnRFzsT+MDPrk6HHI9+8k2LmZPZg1trGQ=
X-Received: by 2002:a05:6512:2355:b0:510:1624:d78a with SMTP id
 p21-20020a056512235500b005101624d78amr1967353lfu.48.1706719250156; Wed, 31
 Jan 2024 08:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
 <CABPp-BFPe_RrX5ZHo7-mMHHS96j_O+1wiEwGC5+zGPP5h+686Q@mail.gmail.com> <557604aa-dea4-995a-4fb2-a71b515a8129@gmx.de>
In-Reply-To: <557604aa-dea4-995a-4fb2-a71b515a8129@gmx.de>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 31 Jan 2024 08:40:37 -0800
Message-ID: <CABPp-BF1p48hZ0Y7tRqKb8R53CjTB1oJGW_iV4dA29ALgbh8KQ@mail.gmail.com>
Subject: Re: [PATCH] merge-tree: accept 3 trees as arguments
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Tue, Jan 30, 2024 at 12:04=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Mon, 29 Jan 2024, Elijah Newren wrote:
>
> > On Fri, Jan 26, 2024 at 6:18=E2=80=AFAM Johannes Schindelin via GitGitG=
adget
> > <gitgitgadget@gmail.com> wrote:
> > >
[...]
> That's funny: I asked Victoria Dye to look over the patch, and she pointe=
d
> out the exact opposite: I had written `<tree>` and she remarked that most
> of Git's manual pages would call this a `<tree-ish>` :-)

A code review isn't complete until you get two contradictory requests, I gu=
ess?

> On another funny note, I tried to establish the term "ent" for this categ=
ory
> almost 222 months ago because I also disliked the "-ish" convention:
> https://lore.kernel.org/git/Pine.LNX.4.63.0508051655480.8418@wgmdd8.bioze=
ntrum.uni-wuerzburg.de/

:-)

> > > diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> > > index 3bdec53fbe5..cbd8e15af6d 100644
> > > --- a/builtin/merge-tree.c
> > > +++ b/builtin/merge-tree.c
> > > @@ -429,35 +429,43 @@ static int real_merge(struct merge_tree_options=
 *o,
> > >         struct merge_options opt;
> > >
> > >         copy_merge_options(&opt, &o->merge_options);
> > > -       parent1 =3D get_merge_parent(branch1);
> > > -       if (!parent1)
> > > -               help_unknown_ref(branch1, "merge-tree",
> > > -                                _("not something we can merge"));
> > > -
> > > -       parent2 =3D get_merge_parent(branch2);
> > > -       if (!parent2)
> > > -               help_unknown_ref(branch2, "merge-tree",
> > > -                                _("not something we can merge"));
> > > -
> > >         opt.show_rename_progress =3D 0;
> > >
> > >         opt.branch1 =3D branch1;
> > >         opt.branch2 =3D branch2;
> >
> > If branch1 and branch2 refer to trees, then when users hit conflicts
> > they'll see e.g.
> >
> > <<<<<<< aaaaaaa
> >   somecode();
> > =3D=3D=3D=3D=3D=3D=3D
> >   othercode();
> > >>>>>>> bbbbbbb
> >
> > but aaaaaaa and bbbbbbb are not commits that they can find.
>
> That is true. And it is not totally obvious to many users that they could
> then call `git show aaaaaaa:file` to see the full pre-image on the
> first-parent side.
>
> On the other hand, the label that is shown is precisely what the user
> specified on the command-line.

So this is only for direct use?  I was curious if the user was using
some other tool of yours, perhaps even some web GUI, and thus that
something else was controlling what was passed to git-merge-tree.

> For example:
>
>         $ git merge-tree --merge-base=3Dv2.42.0:t v2.43.0~11:t v2.43.0~10=
^2:t
>
> will result in the following conflict markers:
>
>         $ git show 021c3ce211:t0091-bugreport.sh
>         [...]
>         <<<<<<< v2.43.0~11:t
>                 grep usage output &&
>                 test_path_is_missing git-bugreport-*
>         '
>
>         test_expect_success 'incorrect positional arguments abort with us=
age and hint' '
>                 test_must_fail git bugreport false 2>output &&
>                 grep usage output &&
>                 grep false output &&
>         =3D=3D=3D=3D=3D=3D=3D
>                 test_grep usage output &&
>         >>>>>>> v2.43.0~10^2:t
>         [...]
>
> which I personally find very pleasing output.

Oh, good point -- if users provide trees in the revision:path format
then they still have access to more information about why the change
was made via the revision.

Of course, if users are using the tool directly, presumably they have
access to more information about where those trees came from anyway
even without the conflict label.

> Besides, the manual page of `git merge-tree` says in no sugar-coated
> words:
>
>         Do NOT look through the resulting toplevel tree to try to find wh=
ich
>         files conflict; [...]
>
> :-)

Right, but this isn't using the tree to find which files conflict;
they already are looking at the conflict.  They are instead wanting to
learn why certain textual changes were made on one side of history to
better inform how to resolve an otherwise less than obvious conflict
resolution.  At least, that's the only thing I've seen those conflict
labels be used for.
