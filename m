Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D039C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3823A611CC
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhJERKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhJERKW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 13:10:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937F6C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 10:08:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z1so1436320edb.8
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=XJ3puP9ejOZv1bzo2M7+Vu021qv86subGUux1kQ8IAM=;
        b=J8Vy4zEzjScIi980HeTe1Ha8lCl1thGv1BtrxPfZ3RO9YisnTNWTFt43Cjr+zKbOUp
         2SrF07VkmCUQ9YNtRznejHnqNVfY4kMG+P04Gra2byn4lGj2pyPHtsL3qdg74bgFCYKK
         AIyERVaLo3h11TZ9pdRS1343qdw6zjaQ2VsNyihaZ3doPBsyV5Ds0hC4TOAb41P2t5Rv
         9H4uH0WsIwu1/CpDh5k0ycXA8mFRFO94OVQLETp0nYh9TxB1qU0frIlS/LeQgof2b+/u
         y7bYyUFI6XNYP5vB6NSAmEnHQwyVOHfBD51dmYxAkk+Zp33P1hIKz9nZ72G7x5UvxQss
         P9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=XJ3puP9ejOZv1bzo2M7+Vu021qv86subGUux1kQ8IAM=;
        b=dmluGB5hC60jLFNtjqGD1KWfM/uzgYT6NrxQhsxvmriik0hZuQd1ZJdqJZK2GWRBjl
         sKgkqAvoqWMkXZdLSnz62PXUbxiK22jVYYaMfkFjAl0W4VkTMLB0k4BGxX+aTVHAVp+f
         IZTpHNtudtYga5ix5q7+m+03YSUW1WioiA1ftAMiwE1OrJ/uTPcxddemwyS2GlSum0vx
         2sjzN0VKSRNGs5hyUCchtutC8WzsWOfaNeaT1tjiav/ZJ+cP/ynb0Yzcq9inNLNe/Viq
         mlITgvMVY/rjP15VbehUJdxtX4SmYkAORhVaWZBnTL2HznK8V9quK2Gn0pyxyAm92/0r
         cyLw==
X-Gm-Message-State: AOAM5314kZKcGXtjKOF8gKBQGMqCfiLYnFz6xv2v2DKNVubUmH/EEHWB
        bWi7CVa8CI+BBGqznMNyDrLiHRntiUfGfA==
X-Google-Smtp-Source: ABdhPJyZdB7VYUFrKD8tAzI/Wy2GsDFxqOaANGB6f3FN4yVj94WKbK3q+4u/FpBqiXfTnfQRZs3/rQ==
X-Received: by 2002:aa7:c401:: with SMTP id j1mr19393371edq.88.1633453710012;
        Tue, 05 Oct 2021 10:08:30 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v10sm1023327edw.96.2021.10.05.10.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:08:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/designated-initializers-more
Date:   Tue, 05 Oct 2021 19:07:14 +0200
References: <xmqqo884tkxd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqo884tkxd.fsf@gitster.g>
Message-ID: <87mtnnjt6a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Junio C Hamano wrote:

> * ab/designated-initializers-more (2021-10-01) 6 commits
>  - builtin/remote.c: add and use SHOW_INFO_INIT
>  - builtin/remote.c: add and use a REF_STATES_INIT
>  - urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
>  - builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
>  - daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
>  - Merge branch 'ab/designated-initializers' into ab/designated-initializers-more
>  (this branch uses ab/designated-initializers.)
>
>  Code clean-up.
>
>  Will merge to 'next'?

That would be great, noted in the last What's Cooking too, just after
the then-re-roll:
https://lore.kernel.org/git/8735plrlql.fsf@evledraar.gmail.com/

I've got some memory leak fixes queued up behind this.
