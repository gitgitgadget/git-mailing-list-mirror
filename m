Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C863C433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014E564DCE
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhBNHw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 02:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhBNHwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:52:09 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C106C061788
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:28 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id k10so3384866otl.2
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HM5Vbr8Q4KRYpwZKN9wSNMekgSvcq3m6lyp0YxROkoo=;
        b=Jx9z/U9QeAR8RxrNxNmAqjnMUrSP2/t2aUMqDJFuUofluMkCvZCpIGoDwTiqkfwuLW
         pBwBRe7BzQ7nzC/zcqTHHrtYMA2VW3kgGAaCgeDT93Mav2TOOYQZ33NvYBEQLdQ57EAn
         8x6evabi3jdr9ZDm93j3CiOqFPlvLhOXBJN2Cd8xr0UogfXduF0LG97F6jh86vBtQ9vD
         MFDc7CCxJT7qbGgqYA4dD9OjgsqPUzDI8rBkz0t0h3kxgp7z9t52O+z1an72twlyN4MG
         UnS+9YYAmJks2g8FJiJ5HZQgWi9U7G3VIn2b5pk7o8SCnrNJ0HpDRgmlyuGeqdu/hbW5
         uv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HM5Vbr8Q4KRYpwZKN9wSNMekgSvcq3m6lyp0YxROkoo=;
        b=dC5EJkxld4CbbryyEoLVmIasf7tuYRHUxo3mtBAGhpTYH6AYl19s5AfRZ896++TIQd
         pEqY59IrL80Bw2qS6MXJT4ZhLTV0Ep6H1pHecqZS6QNarrRZtWbX3DZ5yIsUnG6vY17S
         izFuaEeNffHiITh6RyL3OGhHuAnvefuFA916Gc9MEr/72uUMcut6X2Jb6OkLcS/6mi9N
         ePQ7WD6z2/i8FvrdD8RlUQha9ss2QsKR5SScsT9ckhZjWtP1YKGyiivI1zYCRYaMcgAa
         qRfqXy5Sj2QCIuCWifaA6DAzXEaxx4UStbL2T86lkrYlzih9+Z9U8+0RmVi63vPQBF+G
         XBHA==
X-Gm-Message-State: AOAM530j71bF/ixiJ+WExmI5VHJI38aG69AkDHlVBgCmYOiFxg+ALdOO
        B/DOE2GAaFoYnmN9l5fEITw8DCpY2uC95tD+9ek=
X-Google-Smtp-Source: ABdhPJylc9LkoZEsPP73O0RzMaiUvvq93U963w8JKoWWjDgZvRyA37FQEsoqYTR78y0vVq0K8P5EhcsX5lIm1hn2DMg=
X-Received: by 2002:a9d:21ca:: with SMTP id s68mr7738623otb.164.1613289087754;
 Sat, 13 Feb 2021 23:51:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com>
 <pull.870.v3.git.1612884654078.gitgitgadget@gmail.com> <xmqqeehp2jis.fsf@gitster.c.googlers.com>
 <CAOLTT8QbutZ2pHZ7Zg7vEJAy=d66YKP12rVW=RSJV+8fH6RRMw@mail.gmail.com> <xmqqk0rf3i07.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0rf3i07.fsf@gitster.c.googlers.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 14 Feb 2021 15:53:44 +0800
Message-ID: <CAOLTT8QmHvfQeOTbw0xwDY=z_GyF2g5bc-C3Do1ONoQ+CqiqgA@mail.gmail.com>
Subject: Re: [PATCH v3] difftool.c: learn a new way start from specified file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8811=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:17=E5=86=99=E9=81=93=EF=BC=9A
>
> =E8=83=A1=E5=93=B2=E5=AE=81 <adlternative@gmail.com> writes:
>
> > It has no effect on this new feature. I should put this modification
> > in an additional commit, right?
>
> Or you can just drop it.  It certainly is a distracting change to be
> part of this topic.
>
OK.
> > Yes, I want to know why being so cautious in git log?If the file name i=
s
> > wrong, why can't I make it exit? :)
>
> Imagine a history where file1 and file2 are in the initial commit.
> The second commit adds file3 and modifies file2, and then the third
> commit modifies file1.  What would happen when you did this?
>
>   $ git log -p --rotate-to=3Dfile2
>
> For the commit at HEAD, the set of paths shown would be file1 and
> nothing else (because it is the only path that gets modified).  You
> cannot start showing from "file2".  Dying (and not showing HEAD~1
> and HEAD~2) is the last thing you want to do in this situation.  We
> do not even want to give a warning or an error, as it is totally
> expected that some commits do not touch a given path---it would be
> very unusual if a path is touched by every commit ;-).
>
Now I understand that in `log -p`, some commit do not have the file, and so=
me
commit have the file. The best way to display the commit without the file
is to keep it as it is, and rotate the commit with the file. And in `diffto=
ol`
need to ensure the exist the specified file or give the more matching file
as the beginning(As you mentioned later).
> For "difftool --start-at=3Dfile2", the equation is different.  It does
> not traverse history where each commit may or may not modify file2,
> and when the user says s/he wants to resume from file2, file2 must
> be in the set of paths that have changes, or something is wrong (i.e.
> the user meant file3 but mistyped it as file2).
>
> > Awesome idea. In this way, `difftool --rotate-to=3D<file>` can call
> > `diff --rotate-to=3D<file>` , user can choose the starting file, and th=
ey can
> > also see previous files.
>
> So "difftool --start-at=3D<file>" can of use "diff --rotate-to=3D<file>"
> to implement the feature (after all, that is why I wrote it), but
> the error condition between the two are quite different.  And ...

> > After that, there was too little work I could do,do i just need to add
> > the following
> >  code in `diff_flush_patch_all_file_pairs`?
>
>
> > if (o->rotate_to && q->nr && strcmp(q->queue[0]->one->path, o->rotate_t=
o) &&
> > strcmp(q->queue[0]->one->path, o->rotate_to)) {
> >     error(_("could not find start file name '%s'"), o->rotate_to);
> >         return;
> > }
>
> ... that is why an unconditional change like this in diff.c is not
> acceptable, as it would break other codepaths like "git log -p".  If
> we were to add an error there, it has to be very limited to exclude
> at least "log -p"---there may be other features that share the code
> that should not trigger an error for similar reasons.
>
> If diffcore-rotate chooses "missing rotate-to file makes it a no-op"
> as its semantics, and if "difftool --start-at" does not want to see
> a misspelt filename making it a no-op, then the latter needs to
> ensure that the name it got from the user is indeed in the set of
> paths that have changes before running "diff --rotate-to" to
> implement its "difftool --start-at" feature.
>
> The "missing rotate-to file in the diff_queue MUST NOT cause
> diffcore-rotate to error out" rule is probably unnegitiable, but
> there are other ways to make it easier to use, though.
>
> For example, we could change the rotate-to logic to mean "start at
> the given path, or if such a path does not exist in the diff_queue,
> then the first path that sorts after the given path is where we
> start".  That way, if the diff_queue has paths A B C D E and
> rotate-to gives C, then we rotate the output to C D E A B.  And if
> the diff_queue has A B D E and rotate-to gives C, then the output
> would become D E A B (instead of becoming a no-op).  Then, a mistyped
> filename may not do what the user wanted to do (after all, that is
> the definition of MIStyping), but it would do something noticeable
> by the user, which may be useful enough and at least would let the
> user notice the mistake.
>
In doing this, I think the processing methods of difftool and other diffs
are unified.I think this kind of processing is actually very easy,
just need to change
> if (!strcmp(rotate_to_filename, q->queue[i]->two->path))
to
> if (strcmp(rotate_to_filename, q->queue[i]->two->path) <=3D 0)
Of course, it might be better if there is an algorithm that can achieve
the highest degree of file name matching.

Now that `difftool --start-at` and `diff --rotate-to` are unified effects,
is "start-at" just an alias for "rotate-to"?
Or do I need to write like this?
> OPT_STRING(0, "start-with", &options->rotate-to, N_("<path>"),
>   N_("pass from difftool to diff, has the same effort as `rotate-to`")),

> > In addition, Do I need to do the documentation and tests related to
> > your `diff --rotate-to`?
>
> Once we know how we want "diff --rotate-to" to behave exactly, I can
> help that part further, if you want.  And then you can build on top.
>
> But we need to design exactly what the desired semantics would be
> before any of that.
>
> Thanks.
>
Thanks.
