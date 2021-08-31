Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE3EC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD0F60FED
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbhHaI34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240255AbhHaI3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 04:29:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E50C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:29:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b6so26308371wrh.10
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=p0AUSpB6V+43l0g8nzFB59A5UKRNvGmF3KylpaJkycg=;
        b=SWC9kzr3f6+YWafkmPkuxB3mqtKpx9x3zO/vMVsbOU4j1lr/PPn/NL/x5090J6xZch
         7VWwZ8VYyDA7tAA5yKqbo8tpwZuTPK0t4omqQsebTlwjYs/OG6FFHU0OuCQ5jhsAWn87
         Ct06wybWbx/vDgtnfq6hMry20QF5s7SKiZekI4uMA6DFNJdqSJje7/zmuLldhixahRlN
         et/XlVU5zoiYxk3y4MiPjg5o0+jqi6QdCYCrGyXTivQoVpuc33Wz0mgGQeSefgEN8wf3
         4JzHDMfVOTli3VbxUv7yGpckt207FbmQFQktRl7mrvUBo/uuPEsycEo1SYsoHv0t83+3
         neNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=p0AUSpB6V+43l0g8nzFB59A5UKRNvGmF3KylpaJkycg=;
        b=T7wjkeXv0zdvSyiKoMZhrqHAtv4gB7i4F8QNmD8AMQltHP6n1nUB886sgaTXizD28i
         BaylJUIHmhB4+Pu/fVq9b2wQIwIwlQTyW1g1U7rOtGwnes5BDKaAp3Kuuk/EJLx9+/ux
         uWEO9rGZY6M3QaF0UD7AF8Isood6eo0bZgz2ak3wl+x1F6SxzLjXvzt/D+Uu1RplPBU1
         Qz2muXR6JVg45cpGhSFfNjXZh39Uc0Ern+VTe8RRV7BPxalV5bxa/vnUmiSkybFJHyrj
         7UJnp8kAV3TrXix9pGHkFXvWBMQ0Ogj/1rlT3q9t/b8d9qoxjq8FIsH+D3KVFjqmmj5i
         ZJ4g==
X-Gm-Message-State: AOAM533is9o0Cv63wkX0EJ1OgWWbuektMXi0teyZJdNsZdmFIzN1Bf4p
        CIWpwaKyaxLVwqD/s92BLfM=
X-Google-Smtp-Source: ABdhPJwW66Ax0R7VUYFe28PcM2RpB4Bs6y5bs8YDluU0NnB/mS/FQK5pdNJan/wkH3qVfmnggU/TgQ==
X-Received: by 2002:adf:e68b:: with SMTP id r11mr30153260wrm.394.1630398539244;
        Tue, 31 Aug 2021 01:28:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z5sm1772570wmp.26.2021.08.31.01.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 01:28:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 10/15] scalar: implement the `run` command
Date:   Tue, 31 Aug 2021 10:27:30 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <c3f16bccd023601bb1d041c36cf5f49011abcb76.1630359290.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <c3f16bccd023601bb1d041c36cf5f49011abcb76.1630359290.git.gitgitgadget@gmail.com>
Message-ID: <877dg2xbjp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 30 2021, Derrick Stolee via GitGitGadget wrote:

> +	const char *usagestr[] = { NULL, NULL };

Missing usage strings?

> +	if (argc == 0)

Style nit (per style guide): s/argc == 0/!argc/g.

> +	if (!strcmp("all", argv[0]))
> +		i = -1;

Style nit (per style guide): missing braces here.

(Just noting the style nits once, but more in this patch, and presumably
the rest of the series...)
