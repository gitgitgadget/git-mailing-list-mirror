Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33041C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 09:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiKBJ0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 05:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiKBJZo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 05:25:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6DC1F629
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 02:23:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v17so1810122edc.8
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rmDvbg8C2FwMAXeutZi6B0N9j1ND7LnZT1IB/EdQhM=;
        b=GB/QDpNF/o3QvyvFQM++l3XFutqLRJX1uZLorsKcNp87FUgk9I44ihQ9deZQO3DHU5
         /NJ0yNi2otCO7J65vmJ0MyI8MTqyaRDGQ9zR9exONEcLIByBHJVyk+rWy3VHlgVn+gTQ
         wcpm0uvC0MPaDz/xlZz8/tikgEM4XXCu1Y/58AQH1S3wmr/yvHFQ/8OeU3XNoPHtw0tP
         pIbUr6DbraNbJWJS232xcG4R6GO9q9s5hL2gGq0lc5IpIw5P8RGBMJzRsG82/maaUgG/
         pf+f8BD7LX8lBrUu9zW4B3iqb6XyEkcXpgEkItVGNCjGBJAgPU5eFNPFCexhl0DWIk99
         AE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rmDvbg8C2FwMAXeutZi6B0N9j1ND7LnZT1IB/EdQhM=;
        b=RkLFJWJhOAPzMlbfpx9GLxqeiJ9eiAe2+p1mttejh66IilmhmrF1RygmHLKEu7QGul
         9D6vyJ5JFGkCEJrjz2dhH22/Mgt9+y5zxlNmNBk7b0JVl0BnKy5qnwXnNm19VkQ/YVA7
         rp3VuMQTnZ5cQ300HOtipbQqTPgb+PYUcdwY98MiVdZRUbJXKrZ67EFByeua6LFm+dVF
         4TpsjvrU+JpCx8Pdrgnae14LLYmMBNiOnnR8pwt6+ZGL4YDsnulq7hvaOoYk2B102bXd
         FzYjCCGbFZCYmGoTc3wkVBA1JtBpUPBIv0+A/SneCwuMyEFnEHzFE48Jnpyt9E4Bh7Fs
         il6g==
X-Gm-Message-State: ACrzQf2MgHBwM+o0QhG7zL6aSO1hqZzaSVOB0q5S0MKGEBZzv2XQNCTD
        N7ATTs7qLOi/k9R8fwrVzmlFd3o+4+Sx9g==
X-Google-Smtp-Source: AMsMyM41wHdy+68gzL4iE+oC+vm02vL3PJeJO90ncEY7HdqacKma8P+g+P2P26/YqhMnQAZIUZqmvg==
X-Received: by 2002:aa7:c491:0:b0:461:7f0c:c573 with SMTP id m17-20020aa7c491000000b004617f0cc573mr23449430edq.8.1667381020396;
        Wed, 02 Nov 2022 02:23:40 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090632c800b0073d81b0882asm5125050ejk.7.2022.11.02.02.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:23:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oq9yF-00BhgI-0i;
        Wed, 02 Nov 2022 10:23:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, derrickstolee@github.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Wed, 02 Nov 2022 10:20:31 +0100
References: <20220826070912.70274-1-dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20220826070912.70274-1-dyroneteng@gmail.com>
Message-ID: <221102.86tu3h3e1w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 26 2022, Teng Long wrote:

> This patch tries to avoid the problem of leaking sensitive information that
> could output the absolute path of the repository when try to open multiple
> bitmaps. For example, in "alternates" scenario, where the repository
> "alternate_repo" serves as alternate object stores for repository
> "want_to_borrow" , and each of both has it's own bitmap file, then we run
> `git rev-list --use-bitmap-index HEAD`, the output might be:
>
>   $ cd want_to_borrow.git
>   $ git rev-list --test-bitmap HEAD
>   warning: ignoring extra bitmap file: /Users/tenglong.tl/Downloads/alternate_repo.git/.git/objects/pack/pack-bff67e2a7a154e6933afe61b3681726cf9bd8e8b.pack
>   Bitmap v1 test (1 entries loaded)
>   Found bitmap for 30f146d41a7a86930fae3f4a5e1f1c1f2bfacbba. 64 bits / 11030517 checksum
>   Verifying bitmap entries: 100% (3/3), done.
>   OK!
>
> After apply this patch:
>
>   $ git rev-list --test-bitmap HEAD
>   warning: ignoring extra bitmap files
>   Bitmap v1 test (1 entries loaded)
>   Found bitmap for 30f146d41a7a86930fae3f4a5e1f1c1f2bfacbba. 64 bits / 11030517 checksum
>   Verifying bitmap entries: 100% (3/3), done.
>   OK!

I see that downthread of here there's discussion about keeping the
warning, adding tracing, etc. etc.

Maybe it's been brought up (I was skimming, sorry), but for the problem
you have isn't a narrow and acceptable solution to you to keep the
warning, but just don't print the absolute path?

I.e.:

	warning: ignoring extra bitmap file: /Users/tenglong.tl/Downloads/alternate_repo.git/.git/objects/pack/pack-bff67e2a7a154e6933afe61b3681726cf9bd8e8b.pack

To:

	warning: ignoring extra bitmap file: ../alternate_repo.git/.git/objects/pack/pack-bff67e2a7a154e6933afe61b3681726cf9bd8e8b.pack

Or would the relative path to the alternate also be sensitive?

We might also want to just remove this etc., but that's a different
question than "should we print these absolute paths?".
