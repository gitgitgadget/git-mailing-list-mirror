Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E979C433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B05613D7
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhDEWND (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 18:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhDEWNC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 18:13:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CBDC061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 15:12:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so18812175ejc.4
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OulNebA6/KalJT7USWlBM9QsJkxNnZufD/vqBaorSM=;
        b=L9s0pIRQZsMwq3wFRQbQbMJG0a5jbwwlr+30r6h+2TiLPXohVfuma9O8po/fbYGkv1
         uN4orknMnzPEtS+mg8ruhKD4npFjSX3igsLIaOSejg0E3mCckKm+pKtekpSQlxXpoh8H
         fOWHg2fbaiagGKk/DPLdUZ+ermq73WTLF9bdkBqgUzSijNfqZHxnUi6hQ0mytTCbIGLO
         c+FTRQvjyBaTUcKjZ3YuIJFLYFjuBL8bO21qghf6nE4f/A6IM7v/gKswnqTuv8sBlt1K
         dg+djFiM1o+EaZxWKzWq2rGR7DfM2OlKT8v1Vkuq+8caL/xmNavHhsviCeZHQwfleK/a
         97qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OulNebA6/KalJT7USWlBM9QsJkxNnZufD/vqBaorSM=;
        b=LrAWuZIFFyyGBVEK9qwUvqRbAQvmcSwW16N/GjvuWM6BvlyfL5yKML2JI21byGrm0+
         S/ajMMyPpARc87q4SZEidVLhCDJlrvOqt/sa+RIH/CX6H4wBa8HUPR83lq3gnIPK/1F8
         qqtXr1cNo2BvSlr1IWe8LFdWiatDPC1JddqVHB+m1tpFduQUsrex4ypxFQlzrfD+kcw6
         NTRpsbc7ABdD0ZeNtDpZgJN1Q5V3N8UQBnAQ6yA+JkCv/EWKNjcwOt4WnyhZoC5e4Cun
         Y/sYpGrT8/BunxSdOBGAQIp7ndbN/UXy/16xh/ZnqZboeQmp/w+nmj66Cmy0d8QsUEyg
         e6QA==
X-Gm-Message-State: AOAM5338nHTDRC6tfFclaUaVBKL1d5RGgT9AB7U1svGGAj/j+vK9HA87
        ZmE+qv/AXhwyosgha/FWlNc2NxZbY3OLKlLN5EqN9A==
X-Google-Smtp-Source: ABdhPJxVCA4mGEeYfWOZv9O/zJjrAnxI4jwRe4puqKReVv0Ap+zDMVfGvGPaINafUSAyYGaCbs11RNnoIKJo00J8FNY=
X-Received: by 2002:a17:906:2dda:: with SMTP id h26mr30575846eji.163.1617660774583;
 Mon, 05 Apr 2021 15:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210403013410.32064-1-jerry@skydio.com> <20210403013410.32064-2-jerry@skydio.com>
 <CABPp-BGhvQF9k1Jw9NPbZWMkNSffqR777-4S-y-Sh=Etvw-SAA@mail.gmail.com>
 <xmqqy2e00zaf.fsf@gitster.g> <xmqq1rbq276g.fsf@gitster.g>
In-Reply-To: <xmqq1rbq276g.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Mon, 5 Apr 2021 15:12:43 -0700
Message-ID: <CAMKO5CtCk_sJsFFiKKFR1wCSyY226CbxPtN6=p6JRzocSuv8jQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-apply: Allow simultaneous --cached and --3way options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Jerry Zhang <jerryxzha@googlemail.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 3, 2021 at 6:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > It might be OK to only allow the combination when everything auto
> > resolves cleanly and fail the operation without touching either the
> > index or the working tree.  Pretending there was no delete/modify
> > conflicts or adding contents with unresolved conflicts as if nothing
> > bad happened as stage 0 entries would never be acceptable.
Yep I've changed it to just leave the higher stages in the index
> >
> > Perhaps
> >
> >  * Error out if the index does not match HEAD.
> >
> >  * Try applying to the contents in the index.  If there are any
> >    structural conflicts, leave these paths at higher stage and do
> >    not touch their contents.
> >
> >  * For paths without structural conflict but need content merges,
> >    attempt ll-merge of the contents.  If autoresolves cleanly,
> >    register the result at stage 0.  Otherwise, discard the failed
> >    conflicted merge, and leave stages 1, 2 and 3 as they are.
> >
> >  * Exit with status 0 if and only if everything has resolved
> >    cleanly.  Otherwise, exit with non-zero status.
> >
> > would be the minimally-acceptably-safe behaviour.
>
> Note that, while a lot unsatisfactory than the above, the following
> would also be acceptable.
>
>   * Error out if the index does not match HEAD.
>
>   * Try applying to the contents in the index.  If there are any
>     structural conflicts, abort without touching the index (or the
>     working tree --- but that is best left unsaid as we all know we
>     are talking about '--cached').
>
>   * For paths without structural conflict but need content merges,
>     attempt ll-merge of the contents.  If ALL SUCh PATHS autoresolve
>     cleanly, register their result at stage 0.  Otherwise, abort
>     without touching the index (or the working tree).
>
>   * Exit with status 0 if and only if everything has resolved
>     cleanly.  Otherwise, exit with non-zero status (and never touch
>     the index or the working tree).
>
> The version I earlier gave would give a good starting point to
> manually resolve the conflicts in the index and when resolved fully,
> it is safely recorded as the result of applying the patch on top of
> HEAD, because the non-final results are all in higher stages, and
> all the paths at stage 0 are either from the HEAD and unaffected by
> the merge, or the ones that cleanly resolved.  The "the index must
> match HEAD" upfront is to ensure that.  Otherwise it would make it
> very tempting, after spending all that time to resolve the conflicts
> only in the higher stages of the index, to commit the index as-is to
> make a child commit of HEAD and record that it is the result of
> applying the patch.  But if the starting condition had a change
> unrelated to the change the patch brings in already in the index,
> the resulting commit would be _more_ than what the patch did to the
> codebase.
I can see what you mean about the user safety issue. However,
my specific use case (see cover letter) involves an index that does not
match HEAD, and wouldn't be possible at all if we forced the index to
match HEAD. Furthermore git-apply --cached even without --3way
doesn't force the index to match HEAD either, so why force it now?

>
> The simplified version would let the user proceed only when the
> conflicts can mechanically resolved, but it still has the "make sure
> what is recorded is only from the incoming patch" safety.
>
> Of course, if the user is trying to cherry-pick parts of multiple
> patches and combine them to create a new single commit, the second
> and subsequent applycation of the patches would be thwarted by the
> "the index must match HEAD" rule, but it is far safer to make each
> step into its own snapshot commit during such a workflow to combine
> multiple patch pieces and then squash them together after finishing,
> than carrying an intermediate result only in the index and risk
> losing work you did in the previous step(s) to incorrect resolution
> in later step(s).
