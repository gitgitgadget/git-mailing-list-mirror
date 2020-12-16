Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E0C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C375233FB
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbgLPTVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 14:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbgLPTVh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 14:21:37 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0AAC06179C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 11:20:57 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id o11so24191625ote.4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 11:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90X4gssr+PmM/SRCrBGPBXvcOitD7cQqyqHt+oxuGtg=;
        b=GRNOz3vex+fAc7KYON5Tvb3tIs9BweTSs4ZhK//m8UwHOhBbBpsxx85W1G7OrHUBG2
         8VD/wp5vAjcgI+PJyWYtJukg1Mi5fKxqXWL4v81zXuF08YsWGePHIzMQMtqT/7PkDHfc
         pNlINMijPvYF4hjTp5nOtP1GMmA/5CuRmp9J/1/kVZEqeXjEmWdeP1AwTrCsWCDHs0GV
         mjvFSuoyhKPjhBgznwFpGjqkWQ9EKD52gZ2zrNV/wARGKnYdpiyHiGvAcZUrd4BKecpo
         odAeSrhxg+zwGPKaDP9FJJUDxcSGfaX8p2shIUA+cuP5XfUmMjdRGsz0DrEnNiWVkphy
         Vl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90X4gssr+PmM/SRCrBGPBXvcOitD7cQqyqHt+oxuGtg=;
        b=kyvOT9/VOuFvxMBIVTlSL/3N0f5agTN0Lf3B4tcEdmzniEldwRO3U0YQmyPBT8bMRk
         DLcv4yxZYyKEM2KNrOS/N3+u2wB6g0iboGgikZDVRZQD7dYXeN7q5bKV+bZofLt0Rtj8
         RTXI3QpNDUM6k/gGd1ImzD1oIByhWgpQLgvUsJUNifdKpEh17+14xAE3doPmGlPNEIPF
         lSdACtQPdhzpG4H1Hj53DulgVBGgDl8zXOKiZcF2OVpt7/ImZQ1YUkJKp9qRWEULrYjv
         Yxd0C0GvjvnNKZ6ISEBJT9dCEeU8NsG//k49Luo0ODQDf4QLIbhamhU1qzuV7M7JkgX/
         ODLg==
X-Gm-Message-State: AOAM532HROEvCWObbVxxopT49l4IrBXHKwuXZJ3VRJH8L8wFX389Kg4C
        jletLOXXwL4F6c5EVYIvz23deZNi7gE+LWnHYCg=
X-Google-Smtp-Source: ABdhPJz2E7++7QpgQgtXjkWCW05izqv7Eg+o0wxGjILgeEPzTLoOIUNqwdOmG53VgkcfpMLDk871Ywy3SJS2OiBvcys=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr26780589oth.316.1608146456925;
 Wed, 16 Dec 2020 11:20:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
 <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
 <4a4d9d29-ccba-8d39-a7cd-34b1ba785e22@gmail.com> <xmqqim914pfs.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqim914pfs.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Dec 2020 11:20:45 -0800
Message-ID: <CABPp-BG+_4Dv_+HNgQxW8KNe1q04NwuhRpExeOuc=wLeunsj_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] merge-ort: copy a few small helper functions from merge-recursive.c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 9:43 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> > On 12/15/2020 12:53 PM, Elijah Newren via GitGitGadget wrote:
> >> From: Elijah Newren <newren@gmail.com>
> >>
> >> In a subsequent commit, we will implement the traditional recursiveness
> >> that gave merge-recursive its name, namely merging non-unique
> >> merge-bases to come up with a single virtual merge base.  Copy a few
> >> helper functions from merge-recursive.c that we will use in the
> >> implementation.
> >
> > I'm sure these are copies, but...
> >
> >> +static struct commit_list *reverse_commit_list(struct commit_list *list)
> >> +{
> >> +    struct commit_list *next = NULL, *current, *backup;
> >> +    for (current = list; current; current = backup) {
> >> +            backup = current->next;
> >> +            current->next = next;
> >> +            next = current;
> >> +    }
> >
> > The naming of 'next' seems backwards to me, since it is really
> > the "previous" node. Using something like 'previous' makes it
> > clear that you are reversing when you say
> >
> >       current->next = previous;
>
> Hmph.  I took "next" commit_list as "list is the original one, and
> next is the reversed list, the next generation of what we received".
>
> Calling it "previous" feels even more backwards when you view among
> three "struct commit_list *" pointers, one (the one that holds the
> eventual return value) is primarily used to denote the resulting
> list itself, and the other two are used to point individual elements
> on the original list.
>
> I wonder if a slightly different codeflow may be easier to follow
>
>         struct commit_list *result = NULL;
>         while (list) {
>                 struct commit_list *next = list->next;
>                 list->next = result;
>                 result = list;
>                 list = next;
>         }
>         return result;
>
> if we were to try improving this for readability?

Looks like Felipe also came up with the same version you did (modulo
the temporary variable name).

> I dunno if it matters too much, though.

Yeah, reverse_commit_list() has been unchanged in merge-recursive.c
since its introduction in August of 2006.  The function's purpose
seems obvious from its name, so no one ever needs to look at or modify
the implementation.  I'm certain I'll never touch it again.  So, I
personally don't care what the particular implementation is, and I'm
happy to take whatever reviewers prefer here.

Since we have three people weighing in with opinions though -- and on
a point that's irrelevant to me -- do you want to make the call here
Junio?

Otherwise I'll just leave it as-is and not update further.
