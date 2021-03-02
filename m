Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9511CC4332E
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6401D64F20
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578495AbhCBPY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:24:26 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:32924 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348819AbhCBGrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 01:47:14 -0500
Received: by mail-ej1-f46.google.com with SMTP id jt13so33156507ejb.0
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 22:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnniLbkhj/rrxKhXC63nmOjrVoXCeYO1ScfKVyILDf8=;
        b=RRfl26ZqpgVkb1DwziRr3i7jk/fGp+YbO1XZfddUWeFLBZHyqfsY/4YpIvEtrrd5r3
         T7Qq5ssJADH4vPJcPF0Ha7rB465yynpo40XEOwHI3MHEPi0rVHudUcpDnXxTG81LEzaU
         OIXhJg2QUR7BhLd4TuXfqB3GM+TpI57pBcieuFlS2GLIs94WsSbE7vOZo8s2OSidCmNL
         YpTgRPKndau3TAW8A+YDEHp4/CJy8i3Gw/BDS4DoGXhUuPAOWUteebY1qF+SUkV42QEo
         GCbGkh79szCpP+A1JgAHbN3FUqdB9h3loBfWsr+NY7EPyCQYFqUx441L22rvfSC8xaav
         fEXw==
X-Gm-Message-State: AOAM531p5sP9lKOqHNwQaKm4/vkdAEl4xXdSobDXFVBdURrXqah4NL+q
        FAY5IUANVDeilt7cBAxwi/Wholjdv10jRNPNhYjj3B46Xdc=
X-Google-Smtp-Source: ABdhPJy9u743S4Z3lLdRfiYb+6FkZYGKfsxd23sY6JfTFxaDGbFBxNFjn2lG83w997QdP2BTSI9HcYyZnhIbAcpyWK8=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr19238569edt.233.1614667152158;
 Mon, 01 Mar 2021 22:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-7-charvi077@gmail.com>
In-Reply-To: <20210301084512.27170-7-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Mar 2021 01:39:01 -0500
Message-ID: <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 3:52 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
> +          [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
> @@ -86,11 +86,39 @@ OPTIONS
> ---fixup=<commit>::
> +--fixup=[(amend|reword):]<commit>::

Although technically correct, I can't help but wonder if we can be
more friendly to readers by rephrasing this as:

    --fixup=<commit>::
    --fixup=amend:<commit>::
    --fixup=reword:<commit>::

which is probably a lot easier to take in and understand at a glance.
Same comment applies to the synopsis.

Not necessarily worth a re-roll.

> +       Without `amend:` or `reword:`, create a `fixup!` commit where
> +       the commit message will be the subject line from the specified
> +       commit with a prefix of "fixup!'". The resulting "fixup!" commit
> +       is further used with `git rebase --autosquash` to fixup the
> +       content of the specified commit.

I think it becomes important at this point to make it more clear that
_only_ the content of <commit> gets changed by the "fixup!" commit,
and that the log message of <commit> is untouched.

> +The `--fixup=amend:<commit>` form creates an "amend!" commit to
> +fixup both the content and the commit log message of the specified
> +commit. The resulting "amend!" commit's commit message subject
> +will be the subject line from the specified commit with a prefix of
> +"amend!'" and the message body will be commit log message of the
> +specified commit. It also invokes an editor seeded with the log
> +message of the "amend!" commit to allow to edit further. And it
> +refuses to create "amend!" commit if it's commit message body is
> +empty unless used with the `--allow-empty-message` option. "amend!"
> +commit when rebased with `--autosquash` will fixup the contents and
> +replace the commit message of the specified commit with the "amend!"
> +commit's message body.

I had to read this several times to understand what it is trying to
say. I believe that part of the problem is that the bulk of the
description goes into great detail describing bits and behaviors which
make no sense without understanding what an "amend!" commit actually
does, which isn't explained until the very last sentence. So, I think
the entire description needs to be flipped on its head. In particular,
it should start by saying "create a new commit which both fixes up the
content of <commit> and replaces <commit>'s log message", and only
then dive into the details.

In fact, what I just wrote suggests a larger problem with the
description of `--fixup` overall. There is no high-level explanation
of what a "fixup" (or "amend" or "reword") is; it just dives right
into the minutiae without providing the reader with sufficient context
to understand any of it. Only a reader who is already familiar with
interactive rebase is likely to grok what is being said here. So,
extending the thought I expressed above, it would be helpful for the
description of `--fixup=[amend:|reword:]` to start by first explaining
what a "fixup" is, followed by simple descriptions of "amend" and
"reword" (building upon "fixup"), and followed finally by details of
each. Very roughly, something like this:

    Creates a new commit which "fixes up" <commit> when applied with
    `git rebase --autosquash`.

    A "fixup" commit changes the content of <commit> but leaves its
    log message untouched.

    An "amend" commit is like "fixup" but also replaces the log
    message of <commit> with the log message of the "amend" commit.

    A "reword" commit replaces the log message of <commit> with its
    own log message but makes no changes to the content.

And then dive into the details of each variation.

> +The `--fixup=amend:` and `--fixup=reword:` forms cannot be used with
> +other options to add to the commit log message i.e it is incompatible
> +with `-m`/`-F`/`-c`/`-C` options.

I suppose it doesn't hurt, but I wonder if it's really necessary to
document this considering that the user will learn soon enough upon
trying invalid combinations.

> +Also, after fixing the commit using `--fixup`, with or without option
> +and rebased with `--autosquash`, the authorship of the original commit
> +remains unchanged. See linkgit:git-rebase[1] for details.

Good.

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> @@ -593,16 +593,17 @@ See also INCOMPATIBLE OPTIONS below.
>  --autosquash::
>  --no-autosquash::
> +       When the commit log message begins with "squash! ..." (or "fixup! ..."
> +       or "amend! ..."), and there is already a commit in the todo list that

Should this also be mentioning `reword!`?

> +       matches the same `...`, automatically modify the todo list of
> +       `rebase -i`, so that the commit marked for squashing comes right after
> +       the commit to be modified, and change the action of the moved commit
> +       from `pick` to `squash` (or `fixup` or `fixup -C`) respectively. A commit

It's becoming difficult to know which of the "foo!" prefixes get
transformed into which sequencer command since there is no longer a
one-to-one correspondence between "foo!" prefixes and sequencer
commands as there was when only "squash!" and "fixup!" existed. The
reader should be told what sequencer command(s) "amend!" and "reword!"
become.

> +       matches the `...` if the commit subject matches, or if the `...` refers
> +       to the commit's hash. As a fall-back, partial matches of the commit
> +       subject work, too. The recommended way to create fixup/squash/amend
> +       commits is by using the `--fixup=[amend|reword]`/`--squash` options of
> +       linkgit:git-commit[1].

At this point, it may be beneficial to write these out long-form to
make it easier on the reader; something along the lines of:

    ... the `--fixup`, `--fixup:amend:`, `--fixup:reword:`, and
    `--squash` options of ...
