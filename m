Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC533C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 15:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiCNPsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiCNPsf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 11:48:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C63E3D49B
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:47:25 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t14so14206541pgr.3
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MAuNzNtjyoDXtiiFqfYE1i54nE1vrlpf0O09Nbbbe6o=;
        b=aGHrDINHx3RVMpsCYFtPbSDkpYwd27zHzOpKMXiOMSFvFQU0r7gi4yTMsnTFgQdKkQ
         uVoUPHuy22PWB0sWk1jeAV1qEqFA84KtEfVPuQCAKJLckInfX+Lfm3KiU0CHpq5sxvjT
         DKZpygO6yEKiD5pDxouxvOeuwmaJoWPNQ/S3sypxJDxQUGBNy49uKFB84QXE3IV2q6Br
         n8SVmRShg8Cw+Z/Nij2I6AnFdQdnFnPsD6lzWSSW8AWscQbb8AKV8nYO78gvbLTknsG2
         DbinvVaqPxQJzRjAHVQI0SjhsnV1tOo7atVwoVP0Vhs4H17hfej3oPZKQJE/FH0mTFSD
         +h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MAuNzNtjyoDXtiiFqfYE1i54nE1vrlpf0O09Nbbbe6o=;
        b=2lHIr0hnYlTuIXjGdaj9bkUKx1pTMUs03+pkW7Wb9KxN2pIor8nvBRIiSV/jBjCLxO
         GZUGrGfWs3zXzhu8Xof7Z/KssK79ZTObdK/HM6ohd5vkHBdFw4sq7iYWBZ8OhUMFBQfJ
         3WH+JI0+5+EYjESFcMU9INMrNZgqSKljm1zj3MslIEAFTFHQOBDRvm6KWK5kgSZ+7aKl
         5Zn5W+LOfD9VZZ9rsv+aqG0iwHkL+7DzU5qsQp3yTz1T5QidbO25/WsGRsY6MoSvbIcj
         r0Lz3ca3mTqOUsf+GDHpg08enyxAGcMUVZPPPrrzxl5iLR2OOtM7fDqQk18u0S7lYlkE
         qOWQ==
X-Gm-Message-State: AOAM533QQp/trlvVqDv/MYM8SxLOO69DWMurQ9DpkARaHM/WNEeEBnl0
        IIe3g98UF7tD8rLwhGXpK+s=
X-Google-Smtp-Source: ABdhPJxQJf9BuqRMva5poKHPyW/HCzDRWlTJ1ves04PgHBSZZVHRhKlaZLpI1mrZODzYEkAbnPv3Ng==
X-Received: by 2002:a65:63d6:0:b0:375:7cc6:2b63 with SMTP id n22-20020a6563d6000000b003757cc62b63mr20367821pgv.598.1647272844829;
        Mon, 14 Mar 2022 08:47:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2e10:b60c:eca1:b385:455:3d0a])
        by smtp.gmail.com with ESMTPSA id bg3-20020a17090b0d8300b001c6077ea0edsm4265898pjb.23.2022.03.14.08.47.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Mar 2022 08:47:24 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
Date:   Mon, 14 Mar 2022 21:16:38 +0530
Message-Id: <20220314154638.59046-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqq4k41vdwe.fsf@gitster.g>
References: <xmqq4k41vdwe.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Is this "doesn't" (documenting current behaviour, without saying if
> it is wrong or is desired) or "shouldn't" (documenting the desired
> behaviour, which the current implementation may or may not satisfy)?

The current behaviour is okay and this commit adds the test case for it.
So, in that sense, I think "shouldn't" is better word.

> That's mouthful.

Sorry if the test name is very long. But, I couldn't think of shorter
test name than this - to explain what the test case is.

> Lose SP after '>'.
>
> 		git -C partial.git log --follow -- new-file.txt >"$(pwd)/trace.txt" &&

Okay.

> Looking at the implementation of the helper, it seems to be prepared
> to handle negation itself.  Shouldn't this be
>
>	test_subcommand_inexact ! fetch <trace.txt
>
> instead?

Oops, completely missed it. Correcting it :)

> Why can't you specify what should NOT come before "fetch" in your
> use of this helper?

Below is the event triggered for non-exact OID rename -

	git -c fetch.negotiationAlgorithm=noop fetch origin --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin

Derrick told me to not depend on other flags like
`-c fetch.negotiationAlgorithm` etc. as they might be changed or omitted
and as it makes sense to me also. That's why I didn't specify those things.

> I wonder if it was more like this that the original wanted to grep for:
>
>	grep '"event":"child_start".*\["git","pack-objects",.*\]'

I don't know about other cases, but in my case, atleast I really wanted
it.

So, In this scenerio, should I stick with `test_subcommand_inexact` or I
have to see other helper functions (or make my own) for it?

