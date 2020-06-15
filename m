Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0E9C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 17:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CCA0207DD
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 17:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnGwTC9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgFORcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731196AbgFORcq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 13:32:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EE3C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 10:32:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j10so17973101wrw.8
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kfqfhfr7MYL92+YdLOI9rqMn81dAXKRff/EWI28Sc40=;
        b=mnGwTC9aljUcwOo+NCCz1rI6RMp8ziUQCPCrTy5jtHCcO5hlHA6fxMdvzBLScYG+pj
         7Gr4rP5XhB5R9w/ekdhNyeJaIP/2qawVe500KUfam3U3ysb91GtOF+YDS37ClBJho2+X
         VqWog9RapScrgKaDGm1XJJFQ/Kf+zaO2Wt94A3QLVdGTq/CqvbEPSbPlQH3PognrHViA
         7OIwTO4AxgFfKf/hkP1fiOJB+fM/RVD/2C8YsLkxRkBg/5DGG+F1l4G1qY4S10pjSh0M
         pGsS2VCYI+ZaM1+GGp6mrbNJFjGH3bptgjOG5XioQDAX9f45Q+jW5lDsAAFOJXwJZlZc
         kLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kfqfhfr7MYL92+YdLOI9rqMn81dAXKRff/EWI28Sc40=;
        b=OBZ2ByJQTbq0C4nCk3iONIRbHqyc7d817ccQl/Rb1WBKefSyNiJBBpxi3wxgbbeVvP
         YKNtgAPEkfbgDqSZwkZH5+BvyDfI7rqTQ8JGE+1+vR1wunep8yot1ql0YsPA3KGgz3AU
         llwN7pG1ZP9zVHLo287z9eMin5uJbbmWy/bdl5J0G0Yozyovw5+54dedUUm+/smEJ3Hm
         krCm1gq7fEZcR4udIffTuehqbpoGANE1nHRYxY26gSL5l4ay2H7sZ7zQfyglF12JD88I
         9JtcxXnKaeq1sMza3M0TpyvHEqTHrSTN7q/9SXoG/g4feDZPn0ZIdfCS48RfL0ba9AQY
         5TdQ==
X-Gm-Message-State: AOAM5324F9WvREU7fCFkoQwbRk7NI72Bma8Qc5r6VTeDs7yQKpE46Wwo
        SwHnxvpiRlKxO051QE6tNAOsGOE0qv/x2Os08GI=
X-Google-Smtp-Source: ABdhPJxsYjUkObCrBbRyGfOkv9Q4noDNupKpNZ33AD19lZCPnUcW46mojQ0+/JIDqBMZMcFCHvvvE3SsmYV2SIhO4/0=
X-Received: by 2002:adf:f30d:: with SMTP id i13mr28311389wro.146.1592242363821;
 Mon, 15 Jun 2020 10:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com> <30661592138737@mail.yandex.ru>
 <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <c4ebf430-a69d-3d46-bfb9-37c9ece9f519@iee.email> <xmqq1rmgxo67.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rmgxo67.fsf@gitster.c.googlers.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 15 Jun 2020 10:32:33 -0700
Message-ID: <CAPx1GvdT6sZRtu8q1R9=fA-mE9pi1Ag-gKEzQfwbGap+KqSoSg@mail.gmail.com>
Subject: Re: Collaborative conflict resolution feature request
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "Curtin, Eric" <Eric.Curtin@dell.com>,
        Konstantin Tokarev <annulen@yandex.ru>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney, Stephen" <Stephen.Coveney@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 10:11 AM Junio C Hamano <gitster@pobox.com> wrote:
> Assuming that there are paths A and B that would leave conflict in
> an attempted merge between commits X and Y, you somehow resolve the
> conflict in A and leave B unresolved, what would you pass to the
> other person and ask to resolve the conflicts in B?  It cannot be a
> merge commit that records X and Y as its parents and a single tree
> object as the result, because the whole point of this is that you do
> not even know what to record for B.
>
> I think the most important and useful part of this is to design the
> data format used for that task of passing from you to the other
> person.  The way to specify which paths are yours etc. are much less
> interesting and trivial part of the story, I would think.

I've thought about this (some) myself in the past.  It seems to me that what
is needed is the ability to pass the complete unmerged state on.  That is,
we need something like five commits, made in a way similar to the way a
stash is made:

 * all resolved (stage 0) index entries (1 tree)
 * all index stage 1, 2, and 3 entries (3 trees)
 * and the current work-tree (1 tree)

This isn't quite complete as we also need the merge information; perhaps
that goes into a sixth commit, or can be wedged into the commit message
text of one (or more?) of the five trees.

The "resume unresolved merge" command then must unpack all of this
into the appropriate places.

Chris
