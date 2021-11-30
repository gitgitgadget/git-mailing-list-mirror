Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3778CC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343992AbhK3VYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343976AbhK3VYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:24:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC99C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:20:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so92422279edd.13
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6MSwugTv4u7kbbdpgKaX0vYHzs8UtRoFR7xeIWewBhU=;
        b=kANTtRfRw4OIfkLeNpFZ/IOgs2pK4vLIlPdqoPuR/r4q7yuUnnGDT/FevNpUEOkfPj
         jq24LqGZhbDmnzp9v62aoLNOvsY0O8yNvr2kzL8Sa2hkeEDSZUyIO38EBWLMuvLvQDjY
         PeAlND+YoIAFUGECJ3axrfS5aPOOBam1XH4/A0ZbaAOr0A49tWYIrymZe9EOVTrN8cxY
         fUxFtFchXWaL56Hv+Cuy7DayeBXNUH+zuf7/p2N8krXkOxhq1SE7B2WyToEVJWYSDo7N
         jzxV85OWJmjB9NoV4X23QBKs723TOveZiGaz+0hm+MFWIf9DNXrJPT2wr7dKtKi2Nlma
         p+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6MSwugTv4u7kbbdpgKaX0vYHzs8UtRoFR7xeIWewBhU=;
        b=Uo4Zb/aQgJU9qUADc5obbIBY//TcSYmJ8fHiN4O/XJy529fyond0KeRmnkhwVDCpUG
         4gvgXLDM/pd/8++QNxrGAjaTPIKGDrZdw2qEziRqrBHdBeIcxU/2rWDLfwK8cY8elFX+
         hJzfp1uQR/VKaAYpIqCrZY3o1XW/GrUKjutcEN9GWPJcmTixgje4X4KV6XNDQsBx3fQB
         kj1HrEjGYEMTQG8SLnXvFyUNQ2c8kMUZ7nxgzBi06WBMqR+/t1ZzYSpHUFIP6+pvlE5z
         Zv+1Of7rQ5NcIuXj9LyYZrxVJy4WVcNusZzI0Tb5lhF3oCp42qjbQqSMG3juLUw2St3t
         QJ0Q==
X-Gm-Message-State: AOAM532219pOqE7vLk75AlERwr0eflW6Hf074UliXUWxYzRNMq9QcIUC
        CBgunZVm2TWoeGOsmN/cdgE=
X-Google-Smtp-Source: ABdhPJwvy3brbazjBtM8U7oUzIndGvfYcBfV5GGKbA2ZaoafWaJ/cVbG8yqUL/C4GXiLDMTK4eVj3w==
X-Received: by 2002:a17:906:58c6:: with SMTP id e6mr1926411ejs.524.1638307248213;
        Tue, 30 Nov 2021 13:20:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y19sm13548633edc.17.2021.11.30.13.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:20:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msAYR-001ACm-91;
        Tue, 30 Nov 2021 22:20:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: jc/c99-var-decl-in-for-loop (was: What's cooking in git.git (Nov
 2021, #07; Mon, 29))
Date:   Tue, 30 Nov 2021 22:18:40 +0100
References: <xmqqzgpm2xrd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqzgpm2xrd.fsf@gitster.g>
Message-ID: <211130.8635ndcpcg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Junio C Hamano wrote:

> * jc/c99-var-decl-in-for-loop (2021-11-22) 1 commit
>  - revision: use C99 declaration of variable in for() loop
>
>  Weather balloon to break compilers that do not grok variable
>  declaration in the for() loop.
>
>  Will merge to 'next'?

I think that sounds good!

The change is trivial, and due to the nature of it having it sooner than
later this cycle can only be better, in case there's some obscure system
we didn't consider, catching that before the next release would be
preferable.
