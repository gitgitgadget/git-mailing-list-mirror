Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92881C433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 06:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiBSGhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 01:37:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiBSGhG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 01:37:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09EFEA740
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:36:45 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gb39so19935560ejc.1
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RCv2CuWoy6pRn0/hEuYuXrtyzATbnyJJSOmIyNY8KBE=;
        b=inqPR+f/vnJXfcQQH7r6mkARawWouMYPiIG0RDUIPt96JxJIT6mTAED2bELxc1oeeH
         GwUYR3tIbd8MJSJX3duOT6frXX8R7k+smmaXLNpd0KRBpwMfWSx+bHIx0V1qPwubkkRL
         Fdm0srmdPztgzYDTKSznQ37bHr/BBwghTj0JWrF8BSGUfSN8icZyyGrmXzDRXaskQrq+
         t9d5P7T7Zq01YdKaUCGtgE2FWTtDhLQl0xks+CsB2gL7fhvFNS1p9C6T1ci+0Eo1q7K/
         ylstkybxxRU/t7iggAIFW3sTf8Ac7N68JfCgU2tLhWbk3tv32bjnkD7z+laQ1pMGxpEY
         XQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RCv2CuWoy6pRn0/hEuYuXrtyzATbnyJJSOmIyNY8KBE=;
        b=JlSyaSPCEUD743gqLcEtdK6O0hMfa5CvnpuEztVoL3nGD7r5GV/C04vzoI5FNFeiPZ
         eros1me015Kn+808HkX8YTdnK/toK4p6Qg57XSUbN2Awy4CAcNFe6cV3fo5e/HF+PqoP
         MV87LVqituV3QPOERdUneejr2yta2fMcRZYs9Z3DquCSMqtNx4XcRXEBhgudc+8Oayv7
         DhOz0IIa460ILwYsQqlyKRHZciiV9cCrbq9ni6KsqKTYK2fGLRBVBU+i+9BZMhVEOgUO
         z/p35xy0uZwLM3Vbz/2nUvf5HU051XYF5MOkb/flcr1ZZ9iLRNh8OjhAySn3r5rvfL8h
         Ik9Q==
X-Gm-Message-State: AOAM532QSx4eNhMDzdcYHlYcn2cS7o7gB/n82YHzJ9QkO06e6qiu9pFF
        XnC4UXGnmucRWA+kIaVPLa9BRfD2eFYymA==
X-Google-Smtp-Source: ABdhPJzh1epeLvYZ9yjBP6atUB+Ao6xd63Daloub7PW84dLo403YVTf4QcyKsot9sp7YqO0Ln6XSOg==
X-Received: by 2002:a17:907:76fc:b0:6ce:a836:34a1 with SMTP id kg28-20020a17090776fc00b006cea83634a1mr9197463ejc.663.1645252604057;
        Fri, 18 Feb 2022 22:36:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r10sm2947825ejy.148.2022.02.18.22.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 22:36:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLJMJ-004puu-09;
        Sat, 19 Feb 2022 07:36:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v10 4/4] cat-file: add --batch-command mode
Date:   Sat, 19 Feb 2022 07:35:30 +0100
References: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
 <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
 <c6ea1214062381e2c669959e9084adead5600510.1645208594.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <c6ea1214062381e2c669959e9084adead5600510.1645208594.git.gitgitgadget@gmail.com>
Message-ID: <220219.865ypbe51h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
> [....]
> +    for opt in --buffer --no-buffer
> +    do
> +	test -z "$content" ||
> +		test_expect_success "--batch-command $opt output of $type content is correct" '
> +		maybe_remove_timestamp "$batch_output" $no_ts >expect &&
> +		maybe_remove_timestamp "$(test_write_lines "contents $sha1" |
> +		git cat-file --batch-command $opt)" $no_ts >actual &&
> +		test_cmp expect actual
> +	'
> +
> [...]
> +test_expect_success '--batch-command with multiple command calls gives correct format' '
> +	remove_timestamp >expect <<-EOF &&
> +	$hello_sha1 blob $hello_size
> +	$hello_content
> +	$commit_sha1 commit $commit_size
> +	$commit_content
> +	$tag_sha1 tag $tag_size
> +	$tag_content
> +	deadbeef missing
> +	EOF
> +
> +	git cat-file --batch-command --buffer >actual_raw <<-EOF &&
> +	contents $hello_sha1
> +	contents $commit_sha1
> +	contents $tag_sha1
> +	contents deadbeef
> +	flush
> +	EOF
> +
> +	remove_timestamp <actual_raw >actual &&
> +	test_cmp expect actual
> +'

Re my comment on 3/4; I then tried my suggested change to
maybe_remove_timestamp on this patch, and it also works on this
commit...
