Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC81C33C9A
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 00:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAB02465E
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 00:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyLCkk3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgAFAmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 19:42:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46842 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgAFAmR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 19:42:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so46107923edi.13
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 16:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbbUbDVrxNKtsB41OkwhyYU+8mhpHIsqnvKgRVLtZBY=;
        b=JyLCkk3aVMoNi1S1FQOXs8lVWe+PJ3r/CSYKGaMijaU2nGMdTtbToop5a43okReFBt
         HhlaKjz/LSnoVFCyPeYyKo4RxBcmtDZuY+cntw7CWZIFpoaXYT6HRx1g0axENOHXxDw/
         oB7Cqsn7Lo8keITAqEJmtWskylqjcpxQL7r8ic2EOyxzmlKCCzaPGrjtE4URIM96Dn3x
         oeyGpcH7phgCbAJW+gmbRuhM8vU211Zd+GzRqa0/pbqs85ooFKbpjIdbncAzS7hX5k5O
         /d2U5MUKV2r/iEQbWxaFuPTjMPBh0rNBaWmpvtTUvD63Qy6jWQgX/yCtnZ+5EwY9u+Dd
         /T/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbbUbDVrxNKtsB41OkwhyYU+8mhpHIsqnvKgRVLtZBY=;
        b=RT+a5PKXqbmoBQ/Ju4Vio65+SeUzLh+eMpMf2cGAgWSULSHzFrHkO2iQlQJdQ4CqtQ
         8sUiNzjTAc8EaKOK5mxKQWDvACMm7yU8EAqWem3xdlX1Lu0INBOQdBs9lY+b4eUjJev7
         FzC7U7pqdHRu7du95LTJUZ0ZIt9gf61I5zOeyn7uf3K95ZPWan5qhv2MDGYOvJidFWD7
         PajVlpnwogoCVJOEKv/4yWr7K8rI4nM+zB0jAeCxAZWYtD1jHicddjeO5uLyHlsCQ4QB
         lrzTTI8/TPwLuFeYkZIdZMGNziTSbXhGBv/vgQh7m3XDwWYCSVSZ01JOf1KRidJa+txX
         GxGg==
X-Gm-Message-State: APjAAAVhWIkZzMypHecJmLdA5BMi3YLFUv5PACnTHu+XRBlxRkaD7TBA
        QUuflac7MyZ8yF1UIqssAWg3rFW1yXpZDDOudNq6xUYX
X-Google-Smtp-Source: APXvYqyEPir4wTn6NJIWNvnRZwMCFA6ql9yPyMr8JH/ngjQ4ouGTVaD7j8B7V4zSTUhFqEWmnydW14i38w+UkhNd3Lg=
X-Received: by 2002:a17:906:5208:: with SMTP id g8mr107057513ejm.104.1578271335218;
 Sun, 05 Jan 2020 16:42:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
 <82bf24ce537ca9333d72c2b4698864817801f10f.1577933387.git.gitgitgadget@gmail.com>
 <CAPig+cS39vcy6yT3Dg2HfGVCyg2U+7t7Xj85ayM7LaAk3zTjrg@mail.gmail.com>
In-Reply-To: <CAPig+cS39vcy6yT3Dg2HfGVCyg2U+7t7Xj85ayM7LaAk3zTjrg@mail.gmail.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Mon, 6 Jan 2020 13:42:03 +1300
Message-ID: <CACg5j25bNcy66R3bCwwc1NQ1F1rEoc=QOPBteyux0Xr6xwHLSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] branch: advise the user to checkout a different
 branch before deleting
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 2, 2020 at 9:18 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Jan 1, 2020 at 9:50 PM Heba Waly via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Display a hint to the user when attempting to delete a checked out
> > branch saying "Checkout another branch before deleting this one:
> > git checkout <branch_name>".
> >
> > Currently the user gets an error message saying: "error: Cannot delete
> > branch <branch_name> checked out at <path>". The hint will be displayed
> > after the error message.
> >
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > @@ -240,6 +240,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
> >                                 error(_("Cannot delete branch '%s' "
> >                                         "checked out at '%s'"),
> >                                       bname.buf, wt->path);
> > +                               advise(_("Checkout another branch before deleting this "
> > +                                                "one: git checkout <branch_name>"));
>
> s/another/a different/ would make the meaning clearer.
>
Ok.

> Let's try to avoid underscores in placeholders. <branch-name> would be
> better, however, git-checkout documentation just calls this <branch>,
> so that's probably a good choice.
>
Yes.

> However, these days, I think we're promoting git-switch rather than
> git-checkout, so perhaps this advice should follow suit.
>

I didn't know that, will change it.

> Finally, is this advice sufficient for newcomers when the branch the
> user is trying to delete is in fact checked out in a worktree other
> than the worktree in which the git-branch command is being invoked?
> That is:
>
>     $ pwd
>     /home/me/foo
>     $ git branch -D bip
>     Cannot delete  branch 'bip' checked out at '/home/me/bar'
>     hint: Checkout another branch before deleting this one:
>     hint: git checkout <branch>
>     $ git checkout master # user follows advice
>     $ git branch -D bip
>     Cannot delete  branch 'bip' checked out at '/home/me/foo'
>     hint: Checkout another branch before deleting this one:
>     hint: git checkout <branch>
>     $
>
> And the user is left scratching his or her head wondering why
> git-branch is still showing the error despite following the
> instructions in the hint.
>

Understood.

> > diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> > @@ -808,7 +808,8 @@ test_expect_success 'test deleting branch without config' '
> >  test_expect_success 'deleting currently checked out branch fails' '
> >         git worktree add -b my7 my7 &&
> >         test_must_fail git -C my7 branch -d my7 &&
> > -       test_must_fail git branch -d my7 &&
> > +       test_must_fail git branch -d my7 >actual.out 2>actual.err &&
> > +       test_i18ngrep "hint: Checkout another branch" actual.err &&
>
> Why does this capture standard output into 'actual.out' if that file
> is never consulted?
>

Correct, I missed this one.

> >         rm -r my7 &&
> >         git worktree prune
> >  '

Thanks Eric, will submit an updated version soon.

Heba
