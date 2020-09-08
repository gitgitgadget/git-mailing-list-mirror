Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6770AC43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 23:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED33720EDD
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 23:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3kkuvhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgIHX6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 19:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgIHX6E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 19:58:04 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E5CC061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 16:58:03 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so642582qvk.11
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 16:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuN5XLfrnd4i3R3/5l6b3NCMJiMdmn8fZz0NXavy+hU=;
        b=t3kkuvhbRnMdl+nN8Irv9NJGwVBx99PvfzyX07lFiNXFU6he7WLT/vUnDAUszbMhHo
         hKix3mgVInYvWd+lEp8kv/mMVig0AeHP2dfaS0pEN9lwMEuTuFAL/7i69LKRgWHJ8u4k
         ismN0+wNc25Rtbj4dUleESqNhuc8SEHLxPnzzcy7H1Qq4jwlvc6Xupe7r2il1ZwTxhRk
         o7xAwy5AtCfxkHl+Fdvkz7kkOHIUd0ALyI7il8LU7sfIWJh9Q6CxolMCUqQv7+1HBXxh
         QaeSX+EBZqkrS4rb4i0hr2vD8CmohyPW43vDyItbHsqBUiPDTOYHJvu4AMg5xYuiOi6Z
         PM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuN5XLfrnd4i3R3/5l6b3NCMJiMdmn8fZz0NXavy+hU=;
        b=tyJYvkfF1B8NMZpAFGZXCJFfBvPmUGRNhKD+jujLij1ZyXgjd9ioZFY8QhYvu1ldIL
         6PTtsylKfnewh7L+gMg7fSlaSFDZwnbGxtcf1inrMUXf0fmRY+dfDJVQJJBjmASqrMO4
         HUfzXvEzYsDMcSbYPKl2LByAXX7L9COXYVEeX5jtx64Khp59X3AH0w1rpAAvhATM+I/O
         Xp9LD1Hea+j5mWZpRx/DB4Rv+EMnPeoCpvT66CuBDMufKO/A4wBsL9xWjxabxtRCG7JS
         1d6Jxinw476THCXfuWw2leqiiPRFSJJjDKNdJQzRjCFDHPO5nhDiQVxv+0uGV92DYJRW
         QmFw==
X-Gm-Message-State: AOAM532oMWbSVlln1/FyYRXXSM8lZ/C/U9AG0JA8c+0ltw5hAeUF7sOV
        K8yhW5mbwhPDb/L5KJ+u69DKPqmFQV/JUdUL4GT0JNVqw/Z2RA==
X-Google-Smtp-Source: ABdhPJwlhqqVlDiYgqOlqthSJrXjljiOD0Sd8dFb3GBoICBy4YxUxl7/Op0lJKIzn0/+Oz5m1fbYc4nz7mg0oCT55+Y=
X-Received: by 2002:a05:6214:4f:: with SMTP id c15mr1626977qvr.28.1599609482796;
 Tue, 08 Sep 2020 16:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200908153759.36504-1-alipman88@gmail.com> <xmqqsgbrx4xo.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgbrx4xo.fsf@gitster.c.googlers.com>
From:   Aaron Lipman <alipman88@gmail.com>
Date:   Tue, 8 Sep 2020 19:57:52 -0400
Message-ID: <CAEJZ43ivtDS4mG35gt7HyKVWqLdS6XCwt5j8ZEYgDZDTdwE0OA@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: allow merged and no-merged filters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That would mean the rule would be "refs must be reachable by any one
> (or more) of the <merged> commits, and must be reachable by none of
> the <no-merged> commits".  I am not using the same phrasing you used
> (i.e. "must satisify ... filter"), but are we saying the same thing?

Yes, that is how I've implemented this. (Your wording may be more
clear, I'll plan on updating the commit message.)

> The expectation is that topics in flight are either reachable from
> 'next' or 'seen' (there can be commits in 'next' but not in 'seen'
> when fixes to mismerges are involved) and those already graduated
> are either in 'master' or 'maint', and the above "log" and "branch"
> would show the stuff still in flight.

I think we're on the same page: If a branch is merged into 'seen' but
not 'next', it should show up in the output of
"git branch --merged seen --merged next".

If a branch is merged into 'master' but not 'maint', it should not
show up in the output of
"git branch --no-merged master --no-merged maint".

To clarify, is that the behavior that makes sense/seems useful to you?
If so, I can add some test cases for those filter combinations in v2.
