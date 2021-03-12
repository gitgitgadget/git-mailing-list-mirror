Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C6AC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9F064FB3
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhCLIeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 03:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhCLIds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 03:33:48 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534CFC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:33:48 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mj10so51736838ejb.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=95XmWSnEXqdrXzVHH8oVXnymkaLVcn8jlb10Vzaay64=;
        b=X2jdT75HJ+dDpH0wbzbmQ/oi2yYIijSS/9BslZL12edDMiCx6/vZaSMTdkQ661gCvi
         R60nsPhdTVJEf4QIWCOxiFRNO4mHq37M+Uz/sRVYRUsQH3pcG4A2opGfEhsidLEkDNFy
         IF13V4xYVSiODt70m1c7Wa4pZoCncsdlU4i1cvEldqYtfPubI8ZzUY/KhY0g3HkqI+6L
         W5jKzqsaML+8PNUh2DglCirH1IY1ps84Lb5QfCNjBs23jpX/5QhtEix3r2RalK0sfM0e
         kwfn6mjACj1wpH/vZdNPx238PHnV8Mw1+m14KxDsfNQ5U3KbS2kpDYTrKjlX1pX1SAdS
         EoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=95XmWSnEXqdrXzVHH8oVXnymkaLVcn8jlb10Vzaay64=;
        b=MAPO3iCnoCLgdhU1U2I6q2PRWP7qbZFZma90eMI5fSNZaCQ5yl4/8IosXH4Grf1G4k
         52uhBsTF1n0nkie/zT7tzUHjvxeAXDfuBIPBTJxmL6ejL3UJHX3dP/tpAtGNontie4dq
         lULiElG0Ke4+yn+WH3Fqw+gsQafvPLSIZvCwk0sy/u7DoUfhNP/iY4qJdU/mmx3BVl+q
         gatiZQ9qCOQoFcM0aC7PfoVyaFaVJf+/CiXGRVNbkDvaVJDrp+BgB0B6hdr1ayUvaYiX
         pDBwJfX6qpQoyDhvIjAZ0M3HN8pe7CzG6w5BC/0i8uIxd85noCassB60aYyR/GpVH7WC
         cZCQ==
X-Gm-Message-State: AOAM530ajFP7OMX9vY73TeRV6Q1bHWj504atQhdkR4RB8A1XOwMnjRKS
        xqW4YBjb9bfrfvQaraLcwxQ=
X-Google-Smtp-Source: ABdhPJzx7/pMWzm8RDuQOWI1O2lqj7pP/LYKzre53ASc1Q+lgiUbGB3VoiACM2Oy89IiNBaTggC9Cg==
X-Received: by 2002:a17:907:2642:: with SMTP id ar2mr7355450ejc.145.1615538027059;
        Fri, 12 Mar 2021 00:33:47 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y12sm2382585ejb.104.2021.03.12.00.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:33:46 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 05/37] hook: teach hook.runHookDir
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-6-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-6-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 09:33:46 +0100
Message-ID: <87im5whitx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> +	switch (should_run_hookdir) {
> +		case HOOKDIR_NO:

Style: case shouldn't be indented

> +			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
> +			break;
> +		case HOOKDIR_ERROR:
> +			strbuf_addstr(&hookdir_annotation, _(" (will error and not run)"));
> +			break;
> +		case HOOKDIR_INTERACTIVE:
> +			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
> +			break;
> +		case HOOKDIR_WARN:
> +			strbuf_addstr(&hookdir_annotation, _(" (will warn but run)"));
> +			break;
> +		case HOOKDIR_YES:
> +		/*
> +		 * The default behavior should agree with
> +		 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
> +		 * do the default behavior.
> +		 */
> +		case HOOKDIR_UNKNOWN:
> +		default:
> +			break;

We should avoid this sort of translation lego.

> +	}
> +
>  	list_for_each(pos, head) {
>  		struct hook *item = list_entry(pos, struct hook, list);
>  		item = list_entry(pos, struct hook, list);
>  		if (item) {
>  			/* Don't translate 'hookdir' - it matches the config */
> -			printf("%s: %s\n",
> +			printf("%s: %s%s\n",

native speakers in some languages to read the sentance backwards.
Because if you concatenate strings like this you force.

(We don't currently have a RTL language in po/, still, but let's not
create churn for if/when we do if we can help it)>


I have a patch on top to fix this, will send it as some general reply of
proposed fixup.s

>  			       (item->from_hookdir
> +	git hook list pre-commit >actual &&
> +	# the hookdir annotation is translated
> +	test_i18ncmp expected actual

This (and the rest of test_i18ncmp in this series) can and should just
be "test_cmp" or "test_i18ncmp", the poison mode is dead. See my recent
patches to search/replace test_i18ncmp.

The reason the function isn't gone entirely was to help a series like
yours in "seen", but if we're re-rolling...
