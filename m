Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B42C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 20:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbiF0ULq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 16:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbiF0ULp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 16:11:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439421FCF6
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 13:11:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ej4so14642970edb.7
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VBONBi45XIjPq+g9/SrkzL+Ugvi8PwEm4xk1jsw6FNA=;
        b=NJ3w8SKsmD0uzcMnCsd+YK+yMpaB/fHHQDhxyT2WiXMSzvRcwnnBZ33LlrZdt5uIic
         z1rGcirGAkRG+lhJrpUYJjRab8mGqCfL6J8P4lCMmwNYHxyJP5miVWWeOOebM8Oa+eXR
         yW5xMFfBUdAqSPZORgD+9z+l3X6HYFwbRrY4O+NpkeEaK7xPTEo2cb7UVn6v42v5lNa1
         8hzPWwkJD0QspqxBYnjVamZRy6GXa4S7RjqlsUTA7G2mIp6NxMsjuLWnoHWlSYzuSriq
         p8cun9FRsE2XTTvQOdU56aBppbLaXFsSb4y2KNpRr2uCyFPB5dJOZYWFN0sjHDS2O2lh
         i60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VBONBi45XIjPq+g9/SrkzL+Ugvi8PwEm4xk1jsw6FNA=;
        b=LiT3n+dEFktd44CjfNfysKTcvLoxmN6CVbMc3ebF9Azs2j5PdgPel0q1EJcDwF6kKo
         QeOO9hBlU3Y3IWZx688F4Jzuu5AtpXbuYaENup4OOEkCEdB27SDdFEPkX8N7FnE61vBi
         H2cWtZs7KWr6bkEzndRpz5mm5tn8ub2ryfQNkRjk8hOy7/pV6S4B18LHXN+MEvOBN+cO
         ibTvPuSsLWv0FcikOa4Ky9yTmO5dJmM75w9jDo/Y6X92t/kHF80aNyyKTY/fqVslVAnu
         T8uvPWi4STEt7EHI7tzEevWYlSFU46KkAjcXmTPi22AbDoCBcnQ29PDgLJoGOy8xQmpf
         5RQA==
X-Gm-Message-State: AJIora91cQCV9RzlvNsS67rcgyiPat/3ZYrsSHd3AYBqplWKCAPp7n1D
        YLRm5YU+2I8ZSRBt9hUtZqHUipIly+4=
X-Google-Smtp-Source: AGRyM1t44UOsKw50efy/h8VgmemWDU5RHTOutgUcOHn3cagj3sf6fsq9ixHIXsQhJFS/Ur3bA3cpew==
X-Received: by 2002:a05:6402:388b:b0:42b:5f20:c616 with SMTP id fd11-20020a056402388b00b0042b5f20c616mr18529902edb.50.1656360702448;
        Mon, 27 Jun 2022 13:11:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v8-20020aa7d648000000b004377151dfbdsm4940221edr.50.2022.06.27.13.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:11:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o5v5A-001fYl-Uq;
        Mon, 27 Jun 2022 22:11:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 11/16] bisect--helper: return only correct exit codes
 in `cmd_*()`
Date:   Mon, 27 Jun 2022 22:09:28 +0200
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
 <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
 <ce508583e455a1dbb7620a238edb11dae195f00d.1656354677.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <ce508583e455a1dbb7620a238edb11dae195f00d.1656354677.git.gitgitgadget@gmail.com>
Message-ID: <220627.86ilolhnnn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 27 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Exit codes cannot be negative, but `error()` returns -1.

That's good, but...

> Let's just go with the common pattern and call `die()` in
> `cmd_bisect__helper()` when incorrect arguments were detected.

...the common and correct pattern on bad options is to return 129, not
128, which using use usage_msg_opt() instead of die() here would give
you for free. I think this should use that instead.
