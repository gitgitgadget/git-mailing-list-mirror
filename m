Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FFFC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 21:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A648623433
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 21:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgLPVfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 16:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgLPVfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 16:35:32 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A169CC061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 13:34:52 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d8so24802576otq.6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 13:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErMf6Z+AErvSXwRX5iNuYbJoF/yoQ8G8qCFiiRlG2sM=;
        b=RVDx09e8kZDGZSEOkbFmulnm5m/qsgRxcaDknwiaQMFkS7b0gJxpRVia+u++n0R4d1
         zz/J3vUEXJnRbbavPLttF0JzNPSCd7YS7LPkj9uGZMUJJy68jlYb92RserI23Z88LmZv
         BePHBeM4lvwp31rGt6zwwR5VaqfoBc/DyRc+QmBcRGoIYmolwQnemiy2Mzb9CBQ1CjAa
         eOlxfWvkMoT0tPwVpFah3VtJRVxueCdhTzCjzkKXlwGzbYVxUYRe8sv0Ug9npVvciNJ+
         XNklYOPf9iEIF2i/9GJ73JW7EKy9j6Idu3VfI5B81qejkNNDtOE0Iz6OWwuvZnjbVKd0
         A8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErMf6Z+AErvSXwRX5iNuYbJoF/yoQ8G8qCFiiRlG2sM=;
        b=bEtuRcZRFb1v7F2jdRWHL1sMUAkD93I3neuW2t/39y54g31fEQFjgDfznkMTJKmUK5
         NKNKBrDvjjJf8PF/HcbXZP6lTzxZm4TML+PLtn+uJ2TOuBQPsoSReAYkrHeDGe2RmkVA
         h9ktRM/KqSv2lJBlxDuH9pePat6VoiQAD5J4iHlMLDTBGTNCSIe10bxqTsCdSTfHnmGB
         krLefP7MdSqgC5pIZ5ChoCSZbCqbLmUbnuwvXPoQOJsjU5H5O0jSV+Dw2u0UKEaSh02q
         v49u6g0Squ+3zdcmqdB5l/Jt7NmxqO8TtsxON6wUtUOiKMrDDMMkAbwqbWY3ge5oRrrl
         7eaA==
X-Gm-Message-State: AOAM530EF30I7Zq2Fq73PyWhsTOZ7cFo1iwK0IRX2AgWG+IoOp7McMZU
        jM9qxWR5Es1aRWCib1o1YIwHps8KrI9fg0rf0qY=
X-Google-Smtp-Source: ABdhPJyj0pYT7Hsyc+0z6Y6hHq3AdGCORq40/ol0Wo31iUcXwsXWxb5XnWJcXId3biovBPtBxjX8vLVt4LXq9ca6NtM=
X-Received: by 2002:a05:6830:10:: with SMTP id c16mr26786915otp.162.1608154491949;
 Wed, 16 Dec 2020 13:34:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
 <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
 <4a4d9d29-ccba-8d39-a7cd-34b1ba785e22@gmail.com> <xmqqim914pfs.fsf@gitster.c.googlers.com>
 <CABPp-BG+_4Dv_+HNgQxW8KNe1q04NwuhRpExeOuc=wLeunsj_w@mail.gmail.com> <xmqqlfdx32ln.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfdx32ln.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Dec 2020 13:34:40 -0800
Message-ID: <CABPp-BE-EXbJxvJ-dy8SfK3-1rjsM0eKAq1G_vWMfC+A5UTHaQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] merge-ort: copy a few small helper functions from merge-recursive.c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 12:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I wonder if a slightly different codeflow may be easier to follow
> >>
> >>         struct commit_list *result = NULL;
> >>         while (list) {
> >>                 struct commit_list *next = list->next;
> >>                 list->next = result;
> >>                 result = list;
> >>                 list = next;
> >>         }
> >>         return result;
> >>
> >> if we were to try improving this for readability?
> >
> > Looks like Felipe also came up with the same version you did (modulo
> > the temporary variable name).
>
> Funny if it was sent as a response to the message that already had
> the same answer...


>
> >> I dunno if it matters too much, though.
> >
> > Yeah, reverse_commit_list() has been unchanged in merge-recursive.c
> > since its introduction in August of 2006.  The function's purpose
> > seems obvious from its name, so no one ever needs to look at or modify
> > the implementation.  I'm certain I'll never touch it again.  So, I
> > personally don't care what the particular implementation is, and I'm
> > happy to take whatever reviewers prefer here.
> >
> > Since we have three people weighing in with opinions though -- and on
> > a point that's irrelevant to me -- do you want to make the call here
> > Junio?
>
> If I were pressed to give a suggestion, I have two ;-)
>
> I would prefer to see us first find out if all other callers of
> get_merge_bases() _care_ about a particular order of the resulting
> list.  If they do not care [*1*] and if it seems feasible to teach
> get_merge_bases() build its return value reversed already without
> too much extra effort, then the commit list reverser can
> disappear and get_merge_bases() can be fixed to return its commit
> list in older-to-newer order.

The ones in sequencer.c and builtin/merge.c care about the order, but
they manually reverse it (because they are going to call the merge
machinery).  So, these two would benefit from it being reversed.
However...

notes-merge.c and submodule.c both have subtle dependencies on the
order (in ways that might be buggy).  They could perhaps be taught to
depend on the reversed order, but I'm leery of touching something that
looks possibly buggy (one even has a TODO highlighting it) and
becoming responsible.

get_octopus_merge_bases() depends on the order from get_merge_bases(),
and builtin/merge-base.c depends on that function.  So, the output
order of a command depends on it, which might thus affect user
scripts.

builtin/pull.c also depends on the order returned by get_octopus_merge_bases().

That's enough dependencies that I'm inclined to just leave this side
of things as they are.


> If the above does not happen, then I'd prefer to see a single commit
> list reverser in commit.c and have it *shared* between the two merge
> backends, instead of adding another one in merge-ort.c while leaving
> the one in merge-recursive.c behind.  And the single implementation
> can be either "copied from merge-recursive as that may be
> unintuitive or harder to follow but at least we know it is battle
> tested", or the one we see above.  If we were to take the latter, we
> really need to avoid making stupid mistakes while attempting to
> replace an existing awkward one with "simplified" version, though.

commit.c seems like a natural location.  I'll insert a patch at the
beginning of the series to move the function there, and just use
Johannes' original version from 2006 as-is -- that'll make it easier
to verify that my patch is simply moving things, anyway.

> Sorry for listing even more work, but since you asked ... ;-)
>
>
> [Footnote]
>
> *1* if those who care actually would benefit if we used
> older-to-newer order, it would be even better.
