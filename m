Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0645DC433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 00:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7E760FE6
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 00:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhIFAwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 20:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhIFAwg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 20:52:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A116C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 17:51:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ia27so10062075ejc.10
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 17:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UZSIEE28YSvYgkmUg0DgGI3HuzrMjKsebi9iI4EG4Sg=;
        b=ipdB5SmXn9uZ0X2C7pUBOfFBuCepLqgzPSxUGhaVwopm5mxU3OtoMh+w+8jvvcnlHF
         Haq+Yh7b03Lziycmgvl6J3euNUm8t40NsBk/oZ8/GTODUkYJ2lkVWBMcG07Jzo94Tl41
         5EU7lwDEcoNvupp6s4WUyTQPP5UgZbi88KTWAW4pB3Zktf1/ci0FCcPEBVlgyFwFwtEO
         S7NXA6FSKEAp5Z3dby4UW9A9uo69hUNYMdVUDcGM7l3GIbm0NLFdo4O5fijpWuOowawj
         hCbUcjBYM4Gzbv1TT9n13RMHsDbQftt+5AdoW0HyHR63yqjgZ9CsGG/ON3eFjuwd2sbg
         Imvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UZSIEE28YSvYgkmUg0DgGI3HuzrMjKsebi9iI4EG4Sg=;
        b=HECwuIRBO26ufiGbRAvbnbLy2K3kTmsI+/3lCOR7t7+Y3hPDgg0dDJFwkaVN+Qk2K8
         TD5/vPPNBDHevuywkMVZKmGqgOLGNOi+OVe4+FGaKk6RvaPRI6AG2TKVel0s3nl7K8cH
         RDGmCjftXTlFfa7AGMAEL9IP6u03qq//aMsWLS2sGLL1VY0YJ+LW9sAMIV5mjx4RsaP6
         ppxTbtMu1P+gTOfIdjKleAlQwugHf+2I+qAr9jqkf866WFTnTDcHS8WdWi9x4X5rURN+
         sbqeH3UT9IA6HdBcN4CqCV9yuEj/EgUpPcztnkBcpivG5dUrGIbW4i+Rg0XEZEERHLFq
         iRoA==
X-Gm-Message-State: AOAM530cu+uXbP8iDtif7xYvWBefaiKQMxKveqeYeOX/vXnuyAiOUFay
        ifXB58LPCP6b9t/t77Ox4nVw7s0f6ERTwg==
X-Google-Smtp-Source: ABdhPJxN/Rfbp5J7xIucwNASpp33lXbNE34FN3JEfu+weExtlHTJy8dbasMFwrmLdTKmnwCAaADuSQ==
X-Received: by 2002:a17:906:a399:: with SMTP id k25mr10909652ejz.514.1630889490887;
        Sun, 05 Sep 2021 17:51:30 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e19sm2954640eja.48.2021.09.05.17.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 17:51:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrew Olsen via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrew Olsen <andrew232@gmail.com>
Subject: Re: [PATCH 0/4] Compile-time extensions for list-object-filter
Date:   Mon, 06 Sep 2021 02:49:38 +0200
References: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
Message-ID: <87fsuiplv2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 05 2021, Andrew Olsen via GitGitGadget wrote:

> Adds an extension: option to list-object-filters, these are implemented by
> static libraries that must be compiled into Git. The Makefile argument
> FILTER_EXTENSIONS makes it easier to compile these extensions into a custom
> build of Git. When no custom filter-extensions are supplied, Git works as
> normal.

Having skimmed this and the added documentation I think what's really
missing is a "why"? What concrete use-case is this going to serve?

I.e. what is an extension you have in mind that's useful, but not so
useful as to even suggest it for inclusion in git.git before coming up
with this plug-in API mechanism?

Also, for such plug-ins the license is going to be GPL-v2 too I assume?
But that aspect isn't covered at all.
