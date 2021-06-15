Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71434C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5F06128B
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFOThq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOTho (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 15:37:44 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CE5C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:35:40 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q10so15236969oij.5
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKtN5RBNkWR1Q9uMT8No2AhVOEMErg8HJr5fk3SlYMA=;
        b=GZoExV3sbgg6c31Qmjwme1xwINYzZczA6MfRJzUprw3dY7Cc8SDP+dXE6Vn93PghZd
         ePNSbvlY3PaPbqbfeplJLCQ48qK7C861Dh9YhtOZfYQuT5ZOJXNtqUJhcGEqWpAU/4XI
         bMb/PPD6Ef3nkozp9Ee9IrwvSBV8VJzWPu0FbjydMm//i7qkoeEalq5Nr/W/PEp/qcrn
         u9Pv7c0S54ujB14h3gT5pHijFgJcUfZkgsJsAG7JctBTp9L9vzo+/wJX9B12nE5ECcVj
         zVWAnhMkrGs3eO0keQs/9PjP+xhe7ND8NqYs5CssJyIVvaKjMhsNS/tf4lHvup6JecQi
         jq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKtN5RBNkWR1Q9uMT8No2AhVOEMErg8HJr5fk3SlYMA=;
        b=qyF50vtg7CIeDGCzUdqOT0lNLHYb7UtP9RznM0kmGIYNq9KcaQMZggbLm0R8T6ZueY
         vdpN6BuYi01D5C+qnpc5GAqpcgqelqbjvol4f6nzgrYX1SseKikus+4KfqSAsqxNPzg7
         9AZsxyqb2Bn107vnoHDacGM6xhl+Z7K0hyDiTWBCbHITGXrQChLf3UqXHgqY4ZNOrnF7
         t6sOxW/VqFaQpL/w0uXEbjMXRguas42qgtBnw7dV/bvboa9VYgfB0CU8kgx6y93O+ANw
         badOQdY7VYaKmLBkCFVSfpI+PXmh3sPlCDC9qtapp7gV6nxR2VyDIRnXSvp0RCZ0zOpr
         Ev0w==
X-Gm-Message-State: AOAM531IQ5QkhUqlkpxJtpT3kkWXSWjL1rCuiIdFj6kZpURf90+Nea4F
        fT7ANVf5oxDt00ajSQPwyy+OUncDscFR1N5M9XE=
X-Google-Smtp-Source: ABdhPJwaMOjdMfSiuOv1Vpa1EZUjVpab19AZJ9kU7LgIEiw1vlXoi5BYvakMSciMyDj8gvLzZNfF+iyklF+J64QoW0I=
X-Received: by 2002:aca:f482:: with SMTP id s124mr4312619oih.167.1623785739443;
 Tue, 15 Jun 2021 12:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com> <YMh2M8Ek/RUVjKkL@coredump.intra.peff.net>
In-Reply-To: <YMh2M8Ek/RUVjKkL@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Jun 2021 12:35:28 -0700
Message-ID: <CABPp-BE7-E03+x38EK-=AE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: implement new zdiff3 conflict style
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 2:43 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Jun 15, 2021 at 05:16:08AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > Implement a zealous diff3, or "zdiff3". This new mode is identical to
> > ordinary diff3 except that it allows compaction of common lines between the
> > two sides of history, if those common lines occur at the beginning or end of
> > a conflict hunk.
> >
> > This is just RFC, because I need to add tests. Also, while I've remerged
> > every merge, revert, or duly marked cherry-pick from both git.git and
> > linux.git with this patch using the new zdiff3 mode, that only shows it
> > doesn't segfault. (Though I also reran 10% of the linux remerges with zdiff3
> > under valgrind without issues.) I looked through some differences between
> > --remerge-diff with diff3 and --remerge-diff with zdiff3, but those are
> > essentially diffs of a diff of a diff, which I found hard to read. I'd like
> > to look through more examples, and use it for a while before submitting the
> > patches without the RFC tag.
>
> I did something similar (but I wasn't smart enough to try your
> remerge-diff, and just re-ran a bunch of merges).

What I did was great for testing if there were funny merges that might
cause segfaults or such with zdiff3, but not so clever for viewing the
direct output from zdiff3.  Using remerge-diff in this way does not
show the [z]diff3 output directly, but a diff of that output against
what was ultimately recorded in the merge, forcing me to attempt to
recreate the original in my head.

(And, of course, I made it even worse by taking the remerge-diff
output with diff3, and the remerge-diff output with zdiff3, and then
diffing those, resulting in yet another layer of diffs that I'd have
to undo in my head to attempt to construct the original.)

> Skimming over the results, I didn't see anything that looked incorrect.
> Many of them are pretty non-exciting, though. A common case seems to be
> ones like 01a2a03c56 (Merge branch 'jc/diff-filter-negation',
> 2013-09-09), where two sides both add functions in the same place, and
> the common lines are just the closing "}" followed by a blank line.
>
> Removing those shared lines actually makes things less readable, IMHO,
> but I don't think it's the wrong thing to do. The usual "merge" zealous
> minimization likewise produces the same unreadability. If we want to
> address that, I think the best way would be by teaching the minimization
> some heuristics about which lines are trivial.
>
> Here's another interesting one. In 0c52457b7c (Merge branch
> 'nd/daemon-informative-errors-typofix', 2014-01-10), the diff3 looks
> like:
>
>   <<<<<<< ours
>                   if (starts_with(arg, "--informative-errors")) {
>   ||||||| base
>                   if (!prefixcmp(arg, "--informative-errors")) {
>   =======
>                   if (!strcmp(arg, "--informative-errors")) {
>   >>>>>>> theirs
>                           informative_errors = 1;
>                           continue;
>                   }
>   <<<<<<< ours
>                   if (starts_with(arg, "--no-informative-errors")) {
>   ||||||| base
>                   if (!prefixcmp(arg, "--no-informative-errors")) {
>   =======
>                   if (!strcmp(arg, "--no-informative-errors")) {
>   >>>>>>> theirs
>
> A little clunky, but it's easy-ish to see what's going on. With zdiff3,
> the context between the two hunks is rolled into a single hunk:
>
>   <<<<<<< ours
>                   if (starts_with(arg, "--informative-errors")) {
>                           informative_errors = 1;
>                           continue;
>                   }
>                   if (starts_with(arg, "--no-informative-errors")) {
>   ||||||| base
>                   if (!prefixcmp(arg, "--informative-errors")) {
>   =======
>                   if (!strcmp(arg, "--informative-errors")) {
>                           informative_errors = 1;
>                           continue;
>                   }
>                   if (!strcmp(arg, "--no-informative-errors")) {
>   >>>>>>> theirs
>
> which seems worse. I haven't dug/thought carefully enough into your
> change yet to know if this is expected, or if there's a bug.

Yeah, I don't know for sure either but that does look buggy to me.
Thanks for digging up these examples.  I'm a bit overdrawn on time for
this, so I'll pick it back up in a week or two and investigate this
case further.
