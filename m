Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CAAC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 10:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiCaKcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 06:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiCaKb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 06:31:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BC05B3DC
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:30:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z92so27598453ede.13
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SO6gEvyZ3TkUOurtvP7sFaMPCfsYRSgCG4UQkRChy9I=;
        b=e2pERWeXIgba435M4XMS8VP6ikiWCK7b3rllCGEg5aTkuyYdL48cCKqw4J9zipctBx
         KHTgnM1M1gRGxP3OlILtSo9ctoR4H36cO1H3aPegcAaaPTFbXdDTf7hmB1MBp3/TjuOr
         88nQuYW8ub0aBCsY8RYkulYYBojnBKoButG+km7hM9ki1mQK5oncG2K8bBA/oHgXaDPv
         h4mHZdnFC190AHTF2VxtxMg7glOEUQ4wn4fTiilVdTjV5PtRD+fB4vRx3zwQWZLCulSz
         hFxy5kE03RQ8EDDmWgJA+vHJq9UJwVFWnQQixCAWkR3pRqkRQHXW2eglA9fAIRlX7vmn
         JA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SO6gEvyZ3TkUOurtvP7sFaMPCfsYRSgCG4UQkRChy9I=;
        b=xzOuMvoH/ZgkD52ZEPiZvDNzDaO7WopQ01xsZZGE5gerTfAYpa2eOQY06bZEe3R8Le
         SFBxGn3jiLW46LuUFp77gBshnkoIh/WJYWbiRt+nge69vdtaLF/hJBA9YWn7bAnYU9vG
         ZCjRZuBRJqscuA8HCO5jr3f17YNbGxMDSsrSGNyOmhDteR2gtv++ZsUGQdBT31axqgDe
         WgPnefk2PggUUuxNGVnuFhuHA8xklRzU8QSyoj/owi02eQrWS3L/+zqsDGCYIOx8z3rx
         V6XWgZ6S18etGmHcV+qCjM8fp2AkZur2g806CWG9rshwhMe4klsQEv2iJXfnmUXIQMhK
         LhVQ==
X-Gm-Message-State: AOAM530J4bFrWENuKwn9KC0zFVYI+3VTwgn5MoYDaH+40qOu5A5S/DKw
        hPQR06zyCLZYVBogO1Fup1cQQ88UWupBeg==
X-Google-Smtp-Source: ABdhPJxGAmRU2ncBiU0APxg8bc8rvqqoYOuoDGxZJbx62LfhjnqUYGt5JJmwLqZzAQTbJdRXJRwHhw==
X-Received: by 2002:a50:ff0a:0:b0:419:4240:3be4 with SMTP id a10-20020a50ff0a000000b0041942403be4mr16017184edu.304.1648722607974;
        Thu, 31 Mar 2022 03:30:07 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090674cc00b006df9afdda91sm9030509ejl.185.2022.03.31.03.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 03:30:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZs46-000MI1-Sc;
        Thu, 31 Mar 2022 12:30:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com,
        gitster@pobox.com
Subject: Re: [WIP v1 2/4] mv: add check_dir_in_index() and solve general dir
 check issue
Date:   Thu, 31 Mar 2022 12:25:36 +0200
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-3-shaoxuan.yuan02@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220331091755.385961-3-shaoxuan.yuan02@gmail.com>
Message-ID: <220331.86mth6qus1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, Shaoxuan Yuan wrote:

> +static int check_dir_in_index(const char *dir)
> +{
> +	int ret = 0;
> +	int length = sizeof(dir) + 1;
> +	char *substr = malloc(length);
> +
> +	for (int i = 0; i < the_index.cache_nr; i++) {

See https://lore.kernel.org/git/xmqqy20r3rv7.fsf@gitster.g/ for how
we're not quite using this syntax yet.

This should also be "unsigned int" to go with the "cache_nr" member.

> +		memcpy(substr, the_index.cache[i]->name, length);
> +		memset(substr + length - 1, 0, 1);
> +
> +		if (strcmp(dir, substr) == 0) {

Style: don't compare against == 0, or == NULL, use !, see CodingGuidelines.

> +			else if (check_dir_in_index(src_w_slash) &&
> +			!path_in_sparse_checkout(src_w_slash, &the_index)) {

Funny indentation, the ! should be aligned with "(".

> -				modes[i] = WORKING_DIRECTORY;
> +				if (!modes[i])
> +					modes[i] = WORKING_DIRECTORY;

This works, but assuming things about enum values (even if 0) always
seems a bit nasty, can this be a comparison to BOTH instead of !? May or
may not be better...

But then again we do xcalloc() to allocate it, so we assume that
already, nevermind... :)

(there were also indentation issues below)
