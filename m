Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2204C33C9E
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C6B207FD
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNd+k/co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgAFReT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:34:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35413 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgAFReT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 12:34:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so21844212pfo.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 09:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JnahMR9b0QZTJ6joZgQP5G27ICMUpZHh0Xaoy+xDos=;
        b=hNd+k/co6lNUaWKpHYgU3hXVXi0tQcfmUmKe8rQ+ziheON7PghRaTnfUthzg1+pDVE
         Z1t9rTiL1QDWnz9Z+jU6nr0JpPbcM8LvV/AaJDlbMPnB304vFs6nvgepjdXA2L+6DnmF
         WhCYGHfxsjlINJY9OyOTaZQsdqWC1dBK/meXOyAf2FYnBX88obvfjPI2HJDFuUUGMwVZ
         IA2+6EnnNjLsGTv1DIBmtXXNSgk+looMzOKQhcH2kpBCj2lSQKe+M40osk+Fo2WldIFS
         UveCsMg6XxBCDZUG3GK5OVXP4L/bMxPvosWU7q7+IXDZV5CuuW6qdpv1tSO4WNqjP0KA
         oTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JnahMR9b0QZTJ6joZgQP5G27ICMUpZHh0Xaoy+xDos=;
        b=KvX/GOXMY/hHpMuyVQRrr+kHvCxa5P0AAQFwxEn6mIf57fMK4HvpAjhIcOcE1ub8aC
         U/xr4fK4fBx4Y9GbWcLcsC8I8EzBuZyoqM8PAzSeFD2XOI/efp1lUHjShMmUHKslvaJX
         SIDNic6UlVhVQGVM9IckbssndbIGKwLPeG6+X/8LG0Ep87UlJkD7oFCsIYHpe93ScnEN
         NUHgYl9OE1Bb8/fp4NPs6LVqrhG0GI6gVYK206qCg7gjdR1rUhnO0MZdQz5DcsiKxL51
         cB9nnRx/cvg6u81nxVRyX2EqAH2CjON4/f6GJu0hQJ0ZoJ8Expmjun1h+bDbXJJsNjzT
         ZweA==
X-Gm-Message-State: APjAAAUw/5b78VtWMyJt1FSAXyRZa9JMP8DLLMtMyzMKe5TkyHLO4wr4
        vyBoyALvFTKEltv8j6g5TqWNKVCZcASO+DAWciA=
X-Google-Smtp-Source: APXvYqxE61hid5IwBRl6foHvVLPdpqSuMPKpWXiZKjuNYX7qpgt/lKw+SLPys36Qtfmrnl3LLmMxIkUs4xp0t9CwzGU=
X-Received: by 2002:aa7:8181:: with SMTP id g1mr111151371pfi.215.1578332058555;
 Mon, 06 Jan 2020 09:34:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
 <b262a9d099b882339e9cb930b0a09fd5fe6734b0.1578326648.git.gitgitgadget@gmail.com>
 <13b47c13-7a8b-a205-0cdb-5fdcb8d42412@gmail.com>
In-Reply-To: <13b47c13-7a8b-a205-0cdb-5fdcb8d42412@gmail.com>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Mon, 6 Jan 2020 12:34:07 -0500
Message-ID: <CANoM8SVnrRafqF4F70vFtUQpbM=u6j9MFc9XNgUvjZMz32hYbA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sequencer: comment out the 'squash!' line
To:     phillip.wood@dunelm.org.uk
Cc:     Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 6, 2020 at 12:10 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Michael
>
> On 06/01/2020 16:04, Michael Rappazzo via GitGitGadget wrote:
> > From: Michael Rappazzo <rappazzo@gmail.com>
> >
> > When performing a squash commit, the commit comments are combined into a
> > single commit.  Since the subject line of the squash commit is used to
> > identify the squash-to target commit, it cannot offer any useful
> > contribution to the new commit message.  Therefore, the squash commit
> > subject line it commented out from the combined message (much like a
> > fixup commit's full comment).
>
> I like the idea but I think it would be better to only comment out the
> subject of the commit message if it starts with squash! for fixup!
> otherwise it may well be a useful part of the message. For correctness I
> think it would be better to comment out the subject (everything before
> the first blank line as returned by `git log --pretty=%s`) rather than
> just the first line. I've actually implemented this as part of a longer
> series that I've never got round to posting to the list[1] - feel free
> to use any of that which you find useful. That commit also shows an
> alternative way to change the --autosquash tests.
>
> [1]
> https://github.com/phillipwood/git/commit/b91b492e4aba1ac8d244859361379d5063cfc2b8

That makes sense.  Since your implementation is probably better, it
seems like the
only thing useful left from mine is the test that I added.  I'll look
to resubmit the patch
with your commit.

> > The body of a squash commit may contain additional content to add to the
> > commit message, so this part of the squash commit message is retained.
> >
> > Since this change what the expected post-rebase commit comment would look
> > like, related test expectations are adjusted to reflect the the new
> > expectation.  A new test is added for the new expectation.
> >
> > Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> > ---
> >   sequencer.c                   |  1 +
> >   t/t3404-rebase-interactive.sh |  4 +---
> >   t/t3415-rebase-autosquash.sh  | 36 +++++++++++++++++++++++++++--------
> >   t/t3900-i18n-commit.sh        |  4 ----
> >   4 files changed, 30 insertions(+), 15 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 763ccbbc45..e5602686d7 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1756,6 +1756,7 @@ static int update_squash_messages(struct repository *r,
> >               strbuf_addf(&buf, _("This is the commit message #%d:"),
> >                           ++opts->current_fixup_count + 1);
> >               strbuf_addstr(&buf, "\n\n");
> > +             strbuf_addf(&buf, "%c ", comment_line_char);
> >               strbuf_addstr(&buf, body);
> >       } else if (command == TODO_FIXUP) {
> >               strbuf_addf(&buf, "\n%c ", comment_line_char);
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> > index ae6e55ce79..57d178d431 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -513,8 +513,6 @@ test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messa
> >       cat >expect-squash-fixup <<-\EOF &&
> >       B
> >
> > -     D
> > -
> >       ONCE
> >       EOF
> >       git checkout -b squash-fixup E &&
> > @@ -1325,7 +1323,7 @@ test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
> >       test_cmp_rev HEAD F &&
> >       rm file6 &&
> >       git rebase --continue &&
> > -     test $(git cat-file commit HEAD | sed -ne \$p) = I &&
> > +     test $(git cat-file commit HEAD | sed -ne \$p) = F &&
> >       git reset --hard original-branch2
> >   '
> >
> > diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> > index 22d218698e..51c5a94aea 100755
> > --- a/t/t3415-rebase-autosquash.sh
> > +++ b/t/t3415-rebase-autosquash.sh
> > @@ -59,7 +59,6 @@ test_auto_squash () {
> >       git add -u &&
> >       test_tick &&
> >       git commit -m "squash! first" &&
> > -
> >       git tag $1 &&
> >       test_tick &&
> >       git rebase $2 -i HEAD^^^ &&
> > @@ -67,7 +66,7 @@ test_auto_squash () {
> >       test_line_count = 3 actual &&
> >       git diff --exit-code $1 &&
> >       test 1 = "$(git cat-file blob HEAD^:file1)" &&
> > -     test 2 = $(git cat-file commit HEAD^ | grep first | wc -l)
> > +     test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
> >   }
> >
> >   test_expect_success 'auto squash (option)' '
> > @@ -82,6 +81,27 @@ test_expect_success 'auto squash (config)' '
> >       test_must_fail test_auto_squash final-squash-config-false
> >   '
> >
> > +test_expect_success 'auto squash includes squash body but not squash directive' '
> > +     git reset --hard base &&
> > +     echo 1 >file1 &&
> > +     git add -u &&
> > +     test_tick &&
> > +     git commit -m "squash! first
> > +
> > +Additional Body" &&
> git commit --squash=first -m "Additional Body"
> would avoid the multi line argument
>
> > +     git tag squash-with-body &&
> > +     test_tick &&
> > +     git rebase --autosquash -i HEAD^^^ &&
> > +     git log --oneline >actual &&
> > +     git log --oneline --format="%s%n%b" >actual-full &&
>
> git log --format=%B ?

The difference is that %B has the extra blank line.  The check below wouldn't
see the difference, so I guess %B is easier to read.

>
> > +     test_line_count = 3 actual &&
> > +     git diff --exit-code squash-with-body &&
> > +     test 1 = "$(git cat-file blob HEAD^:file1)" &&
> > +     test 1 = $(git cat-file commit HEAD^ | grep first | wc -l) &&
> > +     test 0 = $(grep squash actual-full | wc -l) &&
>
> grep -v squash actual-full
> is simpler I think
>
> Best Wishes
>
> Phillip
>
> > +     test 1 = $(grep Additional actual-full | wc -l)
> > +'
> > +
> >   test_expect_success 'misspelled auto squash' '
> >       git reset --hard base &&
> >       echo 1 >file1 &&
> > @@ -114,7 +134,7 @@ test_expect_success 'auto squash that matches 2 commits' '
> >       test_line_count = 4 actual &&
> >       git diff --exit-code final-multisquash &&
> >       test 1 = "$(git cat-file blob HEAD^^:file1)" &&
> > -     test 2 = $(git cat-file commit HEAD^^ | grep first | wc -l) &&
> > +     test 1 = $(git cat-file commit HEAD^^ | grep first | wc -l) &&
> >       test 1 = $(git cat-file commit HEAD | grep first | wc -l)
> >   '
> >
> > @@ -152,7 +172,7 @@ test_expect_success 'auto squash that matches a sha1' '
> >       test_line_count = 3 actual &&
> >       git diff --exit-code final-shasquash &&
> >       test 1 = "$(git cat-file blob HEAD^:file1)" &&
> > -     test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
> > +     test 0 = $(git cat-file commit HEAD^ | grep squash | wc -l)
> >   '
> >
> >   test_expect_success 'auto squash that matches longer sha1' '
> > @@ -168,7 +188,7 @@ test_expect_success 'auto squash that matches longer sha1' '
> >       test_line_count = 3 actual &&
> >       git diff --exit-code final-longshasquash &&
> >       test 1 = "$(git cat-file blob HEAD^:file1)" &&
> > -     test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
> > +     test 0 = $(git cat-file commit HEAD^ | grep squash | wc -l)
> >   '
> >
> >   test_auto_commit_flags () {
> > @@ -192,7 +212,7 @@ test_expect_success 'use commit --fixup' '
> >   '
> >
> >   test_expect_success 'use commit --squash' '
> > -     test_auto_commit_flags squash 2
> > +     test_auto_commit_flags squash 1
> >   '
> >
> >   test_auto_fixup_fixup () {
> > @@ -228,7 +248,7 @@ test_auto_fixup_fixup () {
> >               test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
> >       elif test "$1" = "squash"
> >       then
> > -             test 3 = $(git cat-file commit HEAD^ | grep first | wc -l)
> > +             test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
> >       else
> >               false
> >       fi
> > @@ -268,7 +288,7 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
> >       test_line_count = 3 actual &&
> >       git diff --exit-code final-squash-instFmt &&
> >       test 1 = "$(git cat-file blob HEAD^:file1)" &&
> > -     test 2 = $(git cat-file commit HEAD^ | grep squash | wc -l)
> > +     test 0 = $(git cat-file commit HEAD^ | grep squash | wc -l)
> >   '
> >
> >   test_expect_success 'autosquash with empty custom instructionFormat' '
> > diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> > index d277a9f4b7..bfab245eb3 100755
> > --- a/t/t3900-i18n-commit.sh
> > +++ b/t/t3900-i18n-commit.sh
> > @@ -226,10 +226,6 @@ test_commit_autosquash_multi_encoding () {
> >               git rev-list HEAD >actual &&
> >               test_line_count = 3 actual &&
> >               iconv -f $old -t UTF-8 "$TEST_DIRECTORY"/t3900/$msg >expect &&
> > -             if test $flag = squash; then
> > -                     subject="$(head -1 expect)" &&
> > -                     printf "\nsquash! %s\n" "$subject" >>expect
> > -             fi &&
> >               git cat-file commit HEAD^ >raw &&
> >               (sed "1,/^$/d" raw | iconv -f $new -t utf-8) >actual &&
> >               test_cmp expect actual
> >
