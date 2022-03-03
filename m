Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A783C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 11:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiCCLG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiCCLGy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 06:06:54 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1930B17C416
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 03:06:09 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hw13so9779185ejc.9
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 03:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=PsMgwCBq0KOCxTJ+/xmcl5VJT+hnKhfDqB2pljGybO0=;
        b=oOrZ0Ghj+AJ/dIYGw2vE/iAugxzl1Zzx3ix/3l4y6i/OBj1IMNYL/RTM7OfkR67B1B
         VjW+cTilIGuLUUYroM3f7EuhA38RjEISiZHarqYoe3x3l+sT/+PDt/KZbxeIVLm19jqj
         exKVXv5q1toSJ7aaSolXx0wp0Mx59l8fO7aocA1ElVcO6P16A3Frtnli3Z2bHrguqDxN
         uoebniKdXvKr/0GpicVA8ijbirEOboPsmLQ5AQOfGnUE+yGXTsn97fn5UBZ71ha5Fhov
         xiONU2qTDVWkssmE4j7TL57pdK8PRguiiA0B1bL4xEM8lOUtOlowMPMPuuxBqsulzwLT
         +u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=PsMgwCBq0KOCxTJ+/xmcl5VJT+hnKhfDqB2pljGybO0=;
        b=65RY8rxR9aBplpOl5APKcJfhV4yAc6MddDiVX2j7awR7JiPaxMsO9YwyN3QVFV4+n6
         kHJyCM7djl1QyAk+p0tIYzNkDLtiDIzlvh/fM1hmAjzRe22/jambuI5ijkCnY5dTNMqY
         cAEdnGwKv4egjcC2mXmA6uLMS0eXhttP3brOJJKDAvbrs9QibyzQ+h6eqtUrhwDd/B1u
         L8vw3ScIfZnabZynA7xLNkOPESV0qvkqp22xHeSN9WuY8cubT1p1tx8KTLBDQJOxb9Dg
         7AA/o5U4dN/gNxpcj9BQ5A3sHzp2mP7PSP4Enwg6kGYvaIyG4R2EkdSR1gbaKPqnEerB
         x6Cg==
X-Gm-Message-State: AOAM533MUhB8u/peFJiEJoU/JdYQ0QVgiRsw1QO8KbcbU8fL7n5o3vba
        u+CYE2NbnqTm+/0bFJMzfm4=
X-Google-Smtp-Source: ABdhPJzJlFikCsp1TtdCCovjGnt0sQRBoJLRb737WfJP4R55igzZP/IgBI2LYyiSIzaa81oAA5lNGg==
X-Received: by 2002:a17:906:2991:b0:6cc:fc18:f10c with SMTP id x17-20020a170906299100b006ccfc18f10cmr26413755eje.744.1646305567529;
        Thu, 03 Mar 2022 03:06:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7cfcb000000b00412c58c43ccsm708869edy.37.2022.03.03.03.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 03:06:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPjHa-000Rhk-Dy;
        Thu, 03 Mar 2022 12:06:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        derrickstolee@github.com, gitster@pobox.com
Subject: Re: [PATCH v2] builtin/remote.c: show progress when renaming remote
 references
Date:   Thu, 03 Mar 2022 12:04:22 +0100
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <dc63ec91ab24eb24a276de074138745fa061eba1.1646261969.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <dc63ec91ab24eb24a276de074138745fa061eba1.1646261969.git.me@ttaylorr.com>
Message-ID: <220303.86y21r47oh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, Taylor Blau wrote:


> @@ -753,8 +753,9 @@ test_expect_success 'rename a remote' '
>  	(
>  		cd four &&
>  		git config branch.main.pushRemote origin &&
> -		git remote rename origin upstream &&
> +		GIT_PROGRESS_DELAY=0 git remote -v rename origin upstream 2>err &&
>  		grep "pushRemote" .git/config &&
> +		grep "Renaming remote references: 100% (4/4), done" err &&

Just on this part. You can use some variant of "test_region" to do this with trace2:

    git grep -C10 TRACE.*progress -- t

Which as an improvement also tests that you called stop_progress(),
i.e. that the trace2 region is ended.

>  		test -z "$(git for-each-ref refs/remotes/origin)" &&
>  		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/main" &&
>  		test "$(git rev-parse upstream/main)" = "$(git rev-parse main)" &&

