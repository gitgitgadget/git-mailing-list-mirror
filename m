Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F1BC433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 13:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiF2NHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiF2NHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 09:07:05 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677312559B
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 06:07:00 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v6so11956433qkh.2
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 06:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WWfg/AR8VQCwajCJr0hLjO19R4esJqJGlrUTK5y6CgQ=;
        b=aHj+WKPeWFeNf8ReDQRaPwVgbEtrC8hZ0bF0eGAuGVGsmSb+BlY02D3QMSX8mlDw4/
         qiRnY1cEEPt0xjEUCpEbXuuOnEdJP8gGIh0ey38pitigcD9LpaITdiwVWj96q17ZA/TB
         Gd1qOxImAossCsdA31xlV5aaq3hLrL6oXz31YapXef4Q0eET9oAhRkweZ9TMzy95wF4b
         O5sT+Q1XSY432MDCimqiHd8dT0tLWEWbrvfGJn45E9BgHbo8cY641eDK5b3u7eBhQpHu
         0OBlFXPY7hQ0pR766nn0rEJZ64OiNRE5fNbgOa+Pa9tnqMLkenuaKEDrEcBk7efeZQyS
         ZpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WWfg/AR8VQCwajCJr0hLjO19R4esJqJGlrUTK5y6CgQ=;
        b=1mRhFpGO/QXe7veHZ7fJLFn2ilxFEgQpCrzm8M34Wah6oPN1Vjz6DM4UjjqTe0Xgyw
         wK06dTeKgEBTxrSf+IDKXE9R3dJXlDgm/7eoHcFhUWzYx/6YHHRSDPG/XeQs4/3Igt8C
         ywkTL6r3gP8/mFMphqnsb8nraW0qRlrky+T4Jy6fJYX3SSXqBvGU3TNpQ+1CV8QUZ+FN
         fl/mY+zPLhhBlr104UzvO7Zxrsqr6iWW2h55I1z1q0xi08dKj9ZSdp8UBw483D4COLOv
         AicXCsh73Ai+WAr1Sg0IENEo+hmufhfQHhh6wTy/FSymAw5w1+JgrnT91qgKJQNvONOi
         CSQA==
X-Gm-Message-State: AJIora/xRkkgUmEt1hd8RyOyd2a5P6j0n0U9leOCul/+66GafbXjrSm5
        JLmgRPDGHhBP0qUvCrPgx1mV
X-Google-Smtp-Source: AGRyM1s3oRv41c6wbskkD7CWduPoOI+ol7sXZNgWcLp8l+60ILvhPj2MYppFMSMfVNYl/U76L+Y/bg==
X-Received: by 2002:a05:620a:bc9:b0:6a9:8e98:8b94 with SMTP id s9-20020a05620a0bc900b006a98e988b94mr1876103qki.729.1656508019511;
        Wed, 29 Jun 2022 06:06:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d803:95aa:58b0:8205? ([2600:1700:e72:80a0:d803:95aa:58b0:8205])
        by smtp.gmail.com with ESMTPSA id bi32-20020a05620a31a000b006af3f3b385csm6011169qkb.98.2022.06.29.06.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:06:59 -0700 (PDT)
Message-ID: <ecca0613-069a-a081-0326-6fa6c6b35569@github.com>
Date:   Wed, 29 Jun 2022 09:06:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 7/8] rebase: update refs from 'update-ref' commands
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/22 9:25 AM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>

> +static int write_update_refs_state(struct string_list *refs_to_oids)
> +{
> +	int result = 0;
> +	FILE *fp = NULL;
> +	struct string_list_item *item;
> +	char *path = xstrdup(rebase_path_update_refs());
> +
> +	if (safe_create_leading_directories(path)) {
> +		result = error(_("unable to create leading directories of %s"),
> +			       path);
> +		goto cleanup;
> +	}
> +
> +	fp = fopen(path, "w");

I realized (while trying to go to sleep, of course) that I need
to use a lockfile here. Parallel processes might be reading this
file while we are writing it.

Thanks,
-Stolee
