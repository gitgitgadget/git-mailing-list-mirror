Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA7FC4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 22:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiLAW5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 17:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiLAW5X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 17:57:23 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533AAC7250
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 14:57:22 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-381662c78a9so32387057b3.7
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 14:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bHq7O7sAq+4S7qRfIxyJiPfcJ9L72976rkVsbAou3l4=;
        b=aQ2usFns6i3U1LRfzV8TLGC6pYFM4eUV/GFB1I+qWpgAZqofqGCxcoo+u0XIrpDdQ8
         jKEEMA0Ol+W6lX+HAVJcH5hascivcqxkj2ODFjUGo+7PP38FfS0F46goag3Y4XaNnmoI
         9iqC6b9vrr6dRbkumm0l80FYHVoKRp8sj4x0gj0kO+8S7DpJlTqEEdCfx+FYl4eZmMdj
         Ria8anprC7RZ15WInnIsO4sWJcOnAzd4hJqFDC/flhZlfOwtZ7cUXFcHHzIIgJK1xUqk
         ot8RcxT0fRagNLG/yldh3Z3HH4bV3ohIDV2K6Ug7i5xdNaCFIC7x89tpEKGo6ck4erAI
         uLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHq7O7sAq+4S7qRfIxyJiPfcJ9L72976rkVsbAou3l4=;
        b=v7rC7IJMGqf49nmagzlq6A7d8SUSnIIwt0ad8dOwP/tX6Na9ZRLRNyKn/KimttZk3w
         5cFWLhDHnJAKapM3+zAyA5N7z3tWvWo9CJuGJiGPcBote207YYtRjW8+OB49TARue/06
         40j9AbtL8H39SDTpJccU2XGb6yux9ZY6lstSkyG16RhUnDcPYXYjOYzCt4CswXVcHLbn
         cc7GDzURWekPzEvOs9mpkrpTz4Onf4BpvONMXr4frPWIXjAEwzbI+Z96QH+hvcABBk3w
         yhRu58UdHWxzUupPmA+N5WDsNKe4Mmd0P7LO7tNhojhWD98X8B1/X0hR+81+IFCY4xN9
         3qjQ==
X-Gm-Message-State: ANoB5pld+XHAIqWwEjpRMIdPxrtmRHOsYoH74Oaa+yr4ooBA11HSVcW0
        /mfUk0Fi9PKoQZ73052aQnlEgasK51UMYvieyA0=
X-Google-Smtp-Source: AA0mqf5dji4EPu3BI9O7G7bvJ2NRx26yukbRpZJYi+dtoWilfmMSxkHe1Adj1/MU4YSjwT2Zdc6guQ48GDGOHMDECzk=
X-Received: by 2002:a0d:d103:0:b0:370:4c23:eacc with SMTP id
 t3-20020a0dd103000000b003704c23eaccmr66273358ywd.127.1669935441049; Thu, 01
 Dec 2022 14:57:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v8.git.1669154823035.gitgitgadget@gmail.com>
 <pull.1384.v9.git.1669769536707.gitgitgadget@gmail.com> <xmqq4juftyan.fsf@gitster.g>
 <CANaDLWLdkaJs96KTBA2B-h+Ei+f7ayS-gvvN06Y4T7w=GgPGrg@mail.gmail.com> <xmqqedtispyc.fsf@gitster.g>
In-Reply-To: <xmqqedtispyc.fsf@gitster.g>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Thu, 1 Dec 2022 16:57:09 -0600
Message-ID: <CANaDLW+aMk3ph25VohqOve6wC46+Zig1a=UtUYHTAwX1K6bDYw@mail.gmail.com>
Subject: Re: [PATCH v9] status: modernize git-status "slow untracked files" advice
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, now I understand!

But I had skipped it because I couldn't find it in my patch, and even
now, I'm afraid I can't. It looks to me like part of an old patch, a
paragraph that was rewritten 2 patches back. Is it possible that you
found it in the lines that were being removed on the patch that you
commented on, for instance?

If I'm correct, then yeay! No problem in the end, this won't reach users.
If I'm looking wrong though, then I'm very sorry about the miss. I
also do get how this may not be worth a new round just for this fix.

Thanks a lot for your (and everybody else's) guidance through this.
This was my first patch, and I'm delighted about the solid shape it's
landing with; I'm hoping it is the first of many.

Thanks a lot!
