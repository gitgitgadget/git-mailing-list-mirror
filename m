Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB86C433E9
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB3122BF3
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgLVABW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgLVABV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:01:21 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE54C061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:00:41 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id l200so13015461oig.9
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vftSUcxQWkp9fIaJSNsEJeB0iEqkuXOTbL1a4hffdm4=;
        b=PfTWFfF2TVPuwfVYhvgNEaa5QmjhVFLem3Z93f9/IB7Vx3PRQ6BVgZcI3ab43HhIM9
         EEXs//ncUnmfgjan+y05UZLvjWrngPqx9e6OXEwqI/BjHo8/LD62dh7NCC7JALzB6bWH
         LcD4WuntCCKnxUuyoIXnerBBxlzbRRiOY65HjThANApkUGCZn0E2k8y1JKMXn5R1ukje
         V64D8mgQdsymXg20RXvxC4B2LSRaJ01JynPo4bhJYo/eZAY63r3hlhN/m1rn4G+dYFOW
         Z0Oa45vHlBICbAZiQ7uSL8pMbLuJbvq+CkWo4HskuLorUUKHiczD8VjzaopcWOLNRA1J
         TuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vftSUcxQWkp9fIaJSNsEJeB0iEqkuXOTbL1a4hffdm4=;
        b=dAKAEAn0+B78wIvxXkNaj1oaXPxdQaIc9ds1iJaKHEzbcdftAGHsCNI8IFwKk2Ur1e
         /7rGYNgBKIbSZZPBYTR93L4zIIi3sjU7sZFsPcGZ4jBfNzFK0O0RNMXQfWEZzkS02j8+
         bRIHFP+rUaA40s1SzPb+dtmqkusSoAeON284apbXEq2TuqTV2Y7qD+1kfHfsupWUDBxR
         m0a/6HqK6OLo2/uRhNJvOT6SWFOU3Q5oEssj6DIHK6OR3x362ZfVjoZYF4j1B7q1r16Q
         +DRYsFYJPFUjR+ur2EZtkhrTxe7v0tNfX8FfJtNkz94ZKM5VSRiHnHPGkAjelgTb00rG
         e5ug==
X-Gm-Message-State: AOAM533IC98DpKbn/emjaGUovfacTXF5T83LuOf1r71aotyDciNfgyfl
        4fn29vWCH+lHu1NEXmznoiutyWAqgNNEFI/1/VK+5rdmRH1hnsAs
X-Google-Smtp-Source: ABdhPJypHhwNe4mqQhSJEiLffOGjkmNRY0TBNmtIfURJWY8i1Jtelk8ShnRg1w6Y5U7zJ0fBeA/8D65Lpuac4V221Ew=
X-Received: by 2002:aca:bac3:: with SMTP id k186mr12355954oif.93.1608595240765;
 Mon, 21 Dec 2020 16:00:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
 <pull.820.v3.git.1608516320.gitgitgadget@gmail.com> <733c674bd1901c931a8917045eb72f661872f462.1608516320.git.gitgitgadget@gmail.com>
 <CAPig+cSaq4vTK7CtvxB2bd0=WTW+d=s0H2RMquyCEf+q0YVn2w@mail.gmail.com>
 <xmqqa6u7m1bu.fsf@gitster.c.googlers.com> <CAPig+cRqa9Y4mEdktdP3d2+PHWanKZ6q6tXfJXEAW9sqcVwHOw@mail.gmail.com>
In-Reply-To: <CAPig+cRqa9Y4mEdktdP3d2+PHWanKZ6q6tXfJXEAW9sqcVwHOw@mail.gmail.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Tue, 22 Dec 2020 00:00:29 +0000
Message-ID: <CAN8Z4-UG-watOnJMYUe3KU4JHnmJTxvwKSZ3s2DtBg104PACaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] test-lib-functions: handle --add in test_config
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I forgot to mention that it likely would be a good idea to at least
> mention in the commit message why test_config() is not being used for
> that particular case. Perhaps saying something along the lines of "one
> test handles config cleanup manually since test_config() is not
> prepared to take arbitrary options such as --add" -- or something
> along those lines -- would be sufficient. Alternatively, an in-code
> comment within the test explaining the open-coding might be more
> helpful to people reading the code in the future.

I found that since test_unconfig uses --unset-all, I can write a test as such

    test_config -C two remote.one.push +: &&
    test_must_fail git -C two push one &&
    git -C two config --add remote.one.push ^refs/heads/master &&
    git -C two push one

The unconfig of the test_config will --unset-all remote.one.push. I can
use this technique and add a comment to that extent.

--Nipunn
