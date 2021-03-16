Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADBFC433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 17:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D74650DC
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 17:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhCPR0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 13:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbhCPRZe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 13:25:34 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DF4C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 10:25:33 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t16so8983401ott.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRhSud913j++rinUAz9sDga06JB0c5exx2WPehGWL/w=;
        b=TOtMARY1dfANM3hfSm7H1RLQmZp7g7OmpclKPAgBQJam/5QugO7LtO45UXXShkiL/N
         FEoK9JI0Ox0D/h47oqoGkAs+CEle9PegINnBsZCloqxYIayQwXcf78a48hQAe8Zi0G3y
         etV2xVix4/AvtF4379SL+2LfUBNB4AVV/1lmXL/onWh6zg0pakfInbvtqTfhl5r5IcVU
         7vB2wN39tDdKqS+tHi3YJ7Sl9Ve7ViykwXLLhXqfH7ruX4UyzI/aUiKu3PjrjTTcloQk
         ao7QfCrsT49742H3eiF46YkWWhQvg3r0YguLhtIoxf3JZGILDyDMh0fZo1Hq3VyyMx2U
         ETfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRhSud913j++rinUAz9sDga06JB0c5exx2WPehGWL/w=;
        b=GrAkvN+rLHpZum3s+0kvsUbe0yNlaGW8NGGlEBsRwh7Wz9TpZwtbiktIlYJY06kN6e
         huDyFnd3dCP7q7z0Ek0fEsi471Qg0fFTdrB2UVNQba9W4oqCkzA9D6mkvHj7CWY9sUg3
         ImyZcmMinyMHs98Fd/MSZxQRMZSTYeuwFK354Z8ogf0VFgWpUrIv41adYx8siXg/BV8l
         VFWyEoBsEAmYPta1/Bnf8bqRoc/aV6ziqwTB4p6kzTAqXUmzbI9P27n7tMWRQH7rJ8Fq
         ORnIBz4o+4Cy2z+gc6k8jWgjgiTt51PTeQnP9JDxhzHD93MWJkEbFaUEIfYo4XFQGjNh
         42TA==
X-Gm-Message-State: AOAM530loC72I7OYuUXNLmmgqKb1rwGA8wLv+bvthdpWCPmIxT70LTQh
        VJxAuvwQkq+Sj2q6ohm2t43YBYaaMlhC1wMo+Sg=
X-Google-Smtp-Source: ABdhPJwLybBzYU8xBjymvjvSkmKV3Gk6w70AgrvHGajSry6bbFsBKc+cXpX5a3GPrHaolvZn4WuGe6s0XUKA8u9Lrv8=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr4548453otf.345.1615915533015;
 Tue, 16 Mar 2021 10:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.905.git.1615867503.gitgitgadget@gmail.com> <44487d2a-f591-7e0f-8532-41397ec805c9@gmail.com>
In-Reply-To: <44487d2a-f591-7e0f-8532-41397ec805c9@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Mar 2021 10:25:21 -0700
Message-ID: <CABPp-BEP5dJpT3q9Lx_Kk5qqSq+zN2F=13nTuTg7UpLCeFKSWw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Declare merge-ort ready for general usage
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 10:01 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/16/2021 12:05 AM, Elijah Newren via GitGitGadget wrote:
> > This tiny series depends on ort-perf-batch-10[1].
> >
> > If the ort-remainder topic[2] is merged with this series, then the result is
> > a version of merge-ort ready for general usage. Users can select it by (a)
> > passing -sort to either git merge or git rebase, or (b) by setting
> > pull.twohead=ort [3], or (c) by setting GIT_TEST_MERGE_ALGORITHM=ort.
>
> Does the other topic add GIT_TEST_MERGE_ALGORITHM=ort to the CI builds?
>
> Specifically, the Linux builds have a second run with some optional
> GIT_TEST_* environment variables. This seems like a nice addition.
>  Other than that extra request, this series was easy to review. LGTM.

The other topic left tests in t6423 failing.  This topic leaves the
tests in t6409 and t6418 failing; it's only the merge of the two that
has all passing tests.

I guess since the ort-remainder topic still hasn't been picked up, I
could just combine it with this series (basing on ort-perf-batch-10).
Then I could either add a patch at the end of the series that runs
tests under GIT_TEST_MERGE_ALGORITHM=ort, or which changes the default
merge backend to ort.
