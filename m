Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EFEC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiF3XkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiF3XkD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:40:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88B94D174
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:39:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id pk21so1022528ejb.2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DnVcdod5ggeFj7s21CSnifsVGHIm36ONmI706DE/a7o=;
        b=FoPb/BGWiSVfnIiCZ6JboSDWMShgMElv1VLR4B20Rz+FIeZvIB1M3SuEbU/jhT0vmK
         VtqFAjIWd2YL5tHeJ0LUCMNQJB/xNkvgCkavnn7l3fKKo3I6iwsHItO7/YuBGNR7woSR
         oP0jPYLhXGNFO3BL+fj/9K8fyw+SUu7qbPaQRyNfpq7U5aBSYeFNvs04f3Gd5znQLh6v
         uczCZ+egLuh6nAPXYyAGy9Q07cblvVJFg5DBmiTjhM8rlhUf+K2mHSE7WMwWAJ26hk4U
         ZmAwWONlffrHc/hAsnGTJbzLgWc+yhba2a78Y6Vga9+dxmPiKXrvmSKdTzaH4zQFoQyi
         cwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DnVcdod5ggeFj7s21CSnifsVGHIm36ONmI706DE/a7o=;
        b=c/4poQ7JsT2VK/BRgovjKTF3lBeNm/pmccQLw7o3LytaJ/W8qPItxJXz9SJBOOgD1C
         IcMe47TIz5ApBJ8xBq7BuG/6ZlWhqsGsH8C/5+honmbHF6i/Vpj5Z1Chr6ditARb4vmp
         Ujw2e+rFBc+OknaRXnQNCaED/qabZEdP/gG5nExYO0DYRHZE/dgSGceBeTT2s20WQTF/
         YpnKP7pAX5m7wCBDB3vlPRYIdmaZcIGwuNjv0j3Bif6U/z/lh8FsSssCmx+LX9V7tV/z
         5uQ3WSR5W7z1HRvxDprv152OvkkSIZRvRW7OmV3u4lreY/p6yC+Lgc/Gn/29vXdM0zql
         hZ3w==
X-Gm-Message-State: AJIora8QSarLhuZdUjA9YHkBYb1M97keFMexABoIMvRBxtdNuoIdgYNA
        RHNP0+TjLB5HmKU68T4ajdXSD09Y933tSQ==
X-Google-Smtp-Source: AGRyM1tP1DpgGFuxtxK2C+QKn43NZX8//BzAXHyz+0nU2dO/iDz3j6ZU4AW1pEG2AaRS+2+InX802A==
X-Received: by 2002:a17:906:38ce:b0:715:8483:e02e with SMTP id r14-20020a17090638ce00b007158483e02emr11761878ejd.442.1656632398091;
        Thu, 30 Jun 2022 16:39:58 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s3-20020a1709067b8300b0070efa110afcsm9651725ejo.83.2022.06.30.16.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:39:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o73lM-002ceC-Q8;
        Fri, 01 Jul 2022 01:39:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 3/3] cat-file: add mailmap support
Date:   Fri, 01 Jul 2022 01:36:40 +0200
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220630142444.651948-4-siddharthasthana31@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220630142444.651948-4-siddharthasthana31@gmail.com>
Message-ID: <220701.86sfnlbu0j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Siddharth Asthana wrote:

> git cat-file is not a plumbing command anymore, especially as it gained
> more and more high level features like its `--batch-command` mode. So
> tools do use it to get commit and tag contents that are then displayed
> to users. This content which has author, committer or tagger
> information, could benefit from passing through the mailmap mechanism,
> before being sent or displayed.
>
> This patch adds --[no-]use-mailmap command line option to the git
> cat-file command. It also adds --[no-]mailmap option as an alias to
> --[no-]use-mailmap.

I think I know the answer, but I think it would be helpful to discuss
the underlying motivations too. I.e. an obvious alternative is "why not
just get this information out of git show/log then?".

The "I think I know the answer" being that I suspect this is to cater to
gitaly having persistent "cat-file" processes around, whereas for "git
log" it would entail spinning up a new process per-request.

But maybe I'm missing something :)

So not as a blocker for this change, which I think can be made small
enough to be justified in cat-file, but just for context: If "git log"
had a similar --batch mode, would there be a need for this change, or is
this just adding a common case to "cat-file" to "tide us over" (as it
were) while that sort of thing doesn't exist yet (and maybe never will
:()?

