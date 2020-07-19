Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05566C433E0
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 01:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D171F20882
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 01:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0bjgaZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGSBsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 21:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgGSBsV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 21:48:21 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E58C0619D2
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 18:48:20 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k6so11409524oij.11
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 18:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlPwXZQfrcvgSp9/ATZDCV9MQMBJn0/6RP7+HaJTVcI=;
        b=H0bjgaZCUfDKznvqzdwxEQduUKAhb+i50sjZxbjbN9UkFJmMGugk57oco1sdF+4Qug
         qorogEiNOHG/tpTmxuyO7F0heNKlA6uzBnkw7EOmwaLtcwlZ6M2N5VafUPb/W93XlzqH
         XEmoofS7OxuL8dDOz0ZR7lZk3g/vsIQSSgReKzCugTYKMg6NgzYD2TqsTrBt/0o1TIoY
         9yHdLVjbPFZ0M5yfsIm/ICPCElE8dQpK8EFlIL9FU50aUjwyuMDaXaX1JD6LfiHQDNOY
         czh6EYQHJErUEzX/DRRl6mnGY+aYN1tJzGT9bJ/s8FjziSJKDhEOskc9gfP6ipWcc8mv
         8Mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlPwXZQfrcvgSp9/ATZDCV9MQMBJn0/6RP7+HaJTVcI=;
        b=JE6FP6KtjwNu507QeqDhaoIvG89ZICM4TUFsYtJPZcBqZNc5KpnmEyqWOQ38mr+xfp
         d2r3nk0we8ZuD2b7c0fQbc9qd89MH8+cro5cOy5EkOO+4iUGgFhtmIhz1Z0k/0pevTTx
         E0IKgNoAD/cD8pZxnbx2lQbfDkGnkf0xRdaunTUbDfTn6PyVUVkTM5dLidOASiRVyNhg
         rjUCQArr8pFEXcFLhD3b5HFLYraaza+Rs4Ryiong9ExFPllLifxTPe8TEKrrIGaTe/zH
         omGrv6+Z4rLi0spInG+vUDWcj0fy6Bbo69a0fDxGZXAnDpiI6a1oMhToPgQxExhFtZ8t
         ll5Q==
X-Gm-Message-State: AOAM533NdocAv5QRgt3KWOjV/S3lJ0TOW0Ith2Ke1/4XtXMFf42Xr+r/
        WEsrLQ9rzxlIGi0DuOvNCQxQGM17cpyxyJFKOoM=
X-Google-Smtp-Source: ABdhPJwIhG4P/IWsWWUS1Ujsko8q95CEkBz/rzdwP6emMirCCx9D3e3iah4hGcfzzaSSX+0YM9JflHYRdhRJth421SQ=
X-Received: by 2002:aca:3dd7:: with SMTP id k206mr12526238oia.31.1595123299744;
 Sat, 18 Jul 2020 18:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.678.git.1595028293855.gitgitgadget@gmail.com>
 <xmqqeep9d6tm.fsf@gitster.c.googlers.com> <CABPp-BGDp_SjJKvi+XVd6KvRLA5PVsK4xBLPvBxAimDft+0M9g@mail.gmail.com>
 <xmqq8sfgd8cu.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sfgd8cu.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Jul 2020 18:48:08 -0700
Message-ID: <CABPp-BGJdwpwhQUp4Wa4bKBp4hQFB9OM3N1FXH7SzY0mvLDa7Q@mail.gmail.com>
Subject: Re: [PATCH] git-mv: improve error message for conflicted file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Torek via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 18, 2020 at 10:46 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Or, even better, make ce_stage(ce) not be an error; see
> > https://lore.kernel.org/git/xmqqk1ozb6qy.fsf@gitster-ct.c.googlers.com/.
>
> Hmph, I actually am not convinced with that one, even though I know
> I wrote it, I do not think I had thought things through before I
> did.  It may make sense in a narrow special case where there is a
> single entry at a higher stage to rename it to the destination path
> and drop it down to stage #0, but I do not think of a good behaviour
> for more general cases.
>
> What should happen, for example, if two or more entries at higher
> stages exist for the path being moved?  Renaming all of them to the
> destination path without changing their stage number may make more
> sense [*1*].  At least, that solution still lets the user to choose
> object at which stage [*2*] to use in the final resolution.
>
> Now, if we define that "git mv src dst", when 'src' is a conflicted
> path, moves the working tree file src to dst at the same time moves
> all the higher stage entries for 'src' to 'dst' while retaining
> their stage number, what does the degenerate case of having only one
> such entry look like?  You start from the state where you have
> $that_path at stage #3, "git mv $that_path $over_there" would put
> you in the state where you have the same contents at $over_there and
> at stage #3.  If you want to just take "their" contents as the
> resolution, "git add $over_there" after doing that "git mv" would
> let you record the resolution, so it does not look too bad.
>
> It would also be a handy way to recover from a mistake made by
> "directory level rename" heuristics.  Instead of resolving the
> content-level conflicts at the wrong path and then moving that
> resolved result to the right path, you can first correct the wrong
> path by moving the conflicted whole to the right path and then
> perform the content-level conflict resolution.  The advantage of the
> latter is obvious.  You have to do two things (rename and edit) and
> with the former way of doing 'edit' first and then 'rename', after
> resolving the conflict and adding the result at the wrong path, "git
> ls-files -u" or "git status" no longer help you remember that the
> path still needs to be moved.  Instead, you can move first and "git
> ls-files -u" would still remember that even after the move you still
> need to deal with content-level conflicts.

Oh, good, I actually like the idea of not auto-resolving better; I was
always a bit uncomfortable with it.  And now that you brought up this
case, there's another good case I can think of too: D/F conflicts that
arise from a rename/add-like situation, but where the add is a new
directory rather than a new file.  In such a case, there can be three
higher order stages for the file due to content conflicts carried with
the rename and auto-resolving them when renaming doesn't make any
sense.  So, yeah, keeping the higher order stages but just renaming
the path seems like a nice improvement for the user.

> Anyway, I think the "separate missing entry and conflicted entry
> when issuing an error message" is a strict improvement.

Agreed.

> [Footnotes]
>
> *1* Of course, the "D/F conflicts are issue only among the entries
>     at the same stage" and other usual rules apply when we check if
>     the move of these higher stage entries is possible.  I am not
>     sure if the low-level API functions like rename_index_entry_at()
>     are prepared to deal with higher stage entries, though, so this
>     may be a nontrivial amount of new work.  It is unclear to me if
>     it is worth doing.

Yeah, if it were trivial, I would have just done it back when I
mentioned it a couple years ago.  I think it's still worth doing, but
I agree it might need some new low-level API function(s) or some
modifications to some existing one(s).

> *2* Actually, "the object at stage #1 for conflicted path P" is a
>     wrong thing to say.  The index is designed to hold multiple
>     stage #1 entries at the same path so that it can express the
>     case where there are more than one common ancestors, and
>     multiple stage #3 entries to express an octopus merge in
>     progress.

Really?  Wow.  I never had any clue that this was possible and never
ran across it.  Is it documented anywhere?

>     The notation to name the object in the index punts
>     and does not let you say "git diff :1.0:path :1.1:path" to
>     compare the first and the second common ancestor versions of
>     path, though it probably should if we wanted to be consistent.
