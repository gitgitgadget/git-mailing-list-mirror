Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A80C0018C
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4455023107
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgLSOsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 09:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgLSOsE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 09:48:04 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03AFC061282
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:47:23 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id w7so1839371uap.13
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaxhOzEFVbMAVlzggiHuQEjWRwva1ZbOtbifQrd0t1A=;
        b=Ga6aj8CVGlY8YTL3g7yIuM5Ejkn8EQxaHdEWtVbMiPE8tsUlO9G5/DTyITf8jRowQq
         ra+3KCKqIsepcTJwt44BfhjZcLtjOReN0NvL8sgU/qdV0kV/pI3LK1GX3SwFDni2wUIs
         8oERCHaFXD5g4tySnJUPC8cPqrSM29avFh+fFo2dHy1S9f9u9FJktIxYHShQNAdyT8Fh
         i72sgRu5JwRSN7equrgb8kIYDnMSgasUQNwZcFgzyj6WP5AzeXc9CWb6wI7w/ECFa7rs
         Lry/pG7tUfOwoa5x42Ns1X0sSB4mWTuINdIMeFeJr9QLsNky/+n7zsvqpxQ53QQ7AuJE
         LbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaxhOzEFVbMAVlzggiHuQEjWRwva1ZbOtbifQrd0t1A=;
        b=oWmuqg4rvLeNfRfa8SWDrSvCon7Ocob+PB2Vk6ZjnL3I5TjlTqG7ESQmmP3kM8mj2N
         +Esl/T8brXvYlqTWDCHHd1xoNLYgdNldzc0SHBMdQaV5VO+DKlqEDWRYZ8qKuIDejDjL
         sjARRvVol0p0IjYKQaq/xagTtqIYRnUVmUPmJWkZ6HmXhEZbWKDBff2rz5bzyTbQl4Q+
         ege8pFDTMban2hQ+Wev7Q0elqILAw0ybWVnticpTDozfEIIhGArwgWCkOAPzkytfxIX6
         VXnAUx6TGMeOKv4UdoDyA/OrQee0/9gxP2YsGScd6HWtY4efjapE9F8iZ3jHnZMvQVaT
         1W4g==
X-Gm-Message-State: AOAM5320bF4hPOPl1aWaNr5/kA+go15Gdyod37+mbgmty9x+H8n09YHo
        mB7ZGx1LqYjL4l4vR5HXT9BEAZpAwd7W9oB1X3g=
X-Google-Smtp-Source: ABdhPJxDeLu8aoWuVjuIpGwoemlPVoL7uRs4kCfKMYFWr3XteKpi1c4rHAPJsu4abEqOL9YD2ktEBaydfDNWvIVusec=
X-Received: by 2002:ab0:3b59:: with SMTP id o25mr8894529uaw.62.1608389243076;
 Sat, 19 Dec 2020 06:47:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.818.git.1608337339246.gitgitgadget@gmail.com>
In-Reply-To: <pull.818.git.1608337339246.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 19 Dec 2020 15:47:09 +0100
Message-ID: <CAN0heSpEnZGN9DBCabYg8JPWdSzRGh5YQ6CdrN4ubLqG-JkN8A@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: do leave commit message intact in fixup! chains
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Vojt=C4=9Bch_Knyttl?= <vojtech@knyt.tl>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sat, 19 Dec 2020 at 01:25, Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 6e98de72c03 (sequencer (rebase -i): add support for the 'fixup' and
> 'squash' commands, 2017-01-02), this developer introduced a change of
> behavior by mistake: when encountering a `fixup!` commit (or multiple
> `fixup!` commits) without any `squash!` commit thrown in, the final `git
> commit` was invoked with `--cleanup=strip`. Prior to that commit, the
> commit command had been called without that `--cleanup` option.
>
> Since we explicitly read the original commit message from a file in that
> case, there is really no sense in forcing that clean-up.

>                 if (!final_fixup)
>                         msg_file = rebase_path_squash_msg();
> -               else if (file_exists(rebase_path_fixup_msg())) {
> -                       flags |= CLEANUP_MSG;
> +               else if (file_exists(rebase_path_fixup_msg()))
>                         msg_file = rebase_path_fixup_msg();
> -               } else {
> +               else {

I see. The bug survived your 789b3effec ("sequencer: make commit
options more extensible", 2017-03-23). Which isn't surprising for such a
mechanical change.

Nit: The "else" still needs braces, so if we follow the coding
guidelines, the "else if" should also use them. And even the "if",
FWIW. So it would arguably be more in line with CodingGuidelines to have
this diff just drop a single line, no additions needed.

So what this does in the end is, it stops adding `--cleanup=strip` and
it doesn't do anything instead, i.e., not even `--cleanup=whitespace`.
OK, we want to use the exact original message. But what if
`commit.cleanup` happens to be "strip"?

> +test_expect_success 'fixup does not clean up commit message' '
> +       oneline="#818" &&
> +       git commit --allow-empty -m "$oneline" &&
> +       git commit --fixup HEAD --allow-empty &&
> +       git rebase -ki --autosquash HEAD~2 &&
> +       test "$oneline" = "$(git show -s --format=%s)"
> +'

I changed your test to use

  git -c commit.cleanup=strip rebase ...

and it started failing. Maybe `run_git_command()` in sequencer.c could
learn to pass `--cleanup=verbatim` or in some other way make sure to
override any user configuration here? I couldn't figure out how to get
this to actually work, though...

Looking around for `CLEANUP_MSG`, I spotted the logic added by
15ef69314d ("rebase --skip: clean up commit message after a failed
fixup/squash", 2018-04-27). It seems like it has the same problem, but
that this proposed patch misses it. I did some testing that seemed to
confirm it:

Adding a commit with some "#message", then adding a fixup and then
adding a fixup that will conflict, then running the rebase and skipping
the conflicting fixup, I end up with a commit with the empty log
message. That's both before and after this proposed patch.

Martin
