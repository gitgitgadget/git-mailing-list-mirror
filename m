Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C590C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 23:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKWXve (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKWXva (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 18:51:30 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD66316B
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 15:51:24 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n17so159846pgh.9
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 15:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8pHHfUNUJkdrs3y8iZaIXeotP2C3swWgRkLVHHHclE=;
        b=PX+AZyfoCXgPHGjgmo39OGJzLIoUSRgVM5yDye7DFPkzFY70q913kqOrGhTaW+HNIY
         0arLOQFvqSOPWlKjUbYm7rjOYpW+W8alX/T4J0yJXJ/EQ4dAzbB/jnqWKE0Vsmu/ayvB
         Zz+ThhuYsVKJqNmxEu3zJfl0Ue1fkDpaXJb8v1TASz/pGmpSm+FiyjXoHASrIZag2p1x
         O5ZZ3CSNda3ZhwksmtLOpJ7X4gvx6GOHHcVXTB9nazHEWTb3sv++zqMolWgiGZDJIh9M
         F8bQGDVwlIweikDXflxrw/mC9CYzDdqSMSdPjsb1ZLASWujOP9ptUIyRMEI2XXSgZkwg
         4zUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r8pHHfUNUJkdrs3y8iZaIXeotP2C3swWgRkLVHHHclE=;
        b=aaczqnSjznZNsF3LYCEYN8E4hVKghSS5eqWM/bXutU3OxtbzDQEnLZfNu8ZbcHQYWS
         JeGvqGN8t6YFCqvo5wbV6JxHpf1a11tYwHuqK77fQewRxaavHOibUCwF82G82ACOHQve
         fzBssum14Dw5LacT6BFu6s3TOaMXU3f5gIEckijBSiuL0oetLX6F6dQSGp8sHlVHr/Oq
         7VgjdN1alK//kpkigL9aCmnKt3liGHOra1O27K0VrRk9oy0NgobAmqPkZZKkfANFowg0
         6Agwct5CgUJXBbTZCCkgqBZDxy6QfR8XhZklV9AVeO99XO6I0D2FNXnvOHlk2P+GO/NO
         n7MA==
X-Gm-Message-State: ANoB5pnl1zOlbFdJEA+sw+ojNp2INFxlVGJFQYbtwCF6TPxZl59DaPk6
        PGDzwpDxfnl/77s4Bi0YneM=
X-Google-Smtp-Source: AA0mqf4YehNJ2uat7iu9ihm+MF4kuwmA6jCOk1R+dS6wx5QNJFPWkeIBXLs3Arx/tPuN/gILT19www==
X-Received: by 2002:aa7:96e6:0:b0:56d:9eed:61eb with SMTP id i6-20020aa796e6000000b0056d9eed61ebmr32691721pfq.4.1669247484355;
        Wed, 23 Nov 2022 15:51:24 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c14-20020a624e0e000000b0056bd6b14144sm13207138pfb.180.2022.11.23.15.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 15:51:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
        <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
        <221122.864juraxl2.gmgdl@evledraar.gmail.com>
        <9c0ecaff-3d66-2b83-eb78-64632d1fcddd@dunelm.org.uk>
        <xmqqilj6plta.fsf@gitster.g>
        <a07b5cd7-7ada-7cdf-78cc-375ef21687b0@dunelm.org.uk>
Date:   Thu, 24 Nov 2022 08:51:23 +0900
In-Reply-To: <a07b5cd7-7ada-7cdf-78cc-375ef21687b0@dunelm.org.uk> (Phillip
        Wood's message of "Wed, 23 Nov 2022 15:07:41 +0000")
Message-ID: <xmqqk03lmdqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I can see that we would want to respect the preferred spelling in our
> documentation but it seems a bit mean to penalize users who write
>
> 	[IncludeIf "os:windows"]
>
> rather than
>
> 	[IncludeIf "os:Windows"]

I do not think "uname-s/i:windows" is out of question.  I am saying
that the default should be case sensitive for consistency with
others.

Also, as I said already, I do not think we should squat on a good
name "os" with this "uname -s" feature that may not be a good
differenciator for two OSes for some cases (e.g. telling Debian and
Fedora apart was a good example raised upthread already).
