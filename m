Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B418AC4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 23:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9877A61185
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 23:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhHVXvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 19:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHVXvr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 19:51:47 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11AC061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 16:51:05 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso10746431otv.3
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 16:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9fdBIY1KYMFZ4JFMNlpu0pm5ABu/2B68JmMEK1VM25g=;
        b=RJ4sOrR0MjB4OYiHtKb5vHX5nncC+oWqJ7wrHYl/xqdRi0tlGXysQUvh2/pOwDipl1
         K/FUFBTOCURuP2x6YhETU70rQr+jVN+NTcWHZVXGPgafSAx6dF5CVGgPflD4U9tkbRJZ
         R8LFmN70HXWBbJSDw2OxrLAM4PTmu7+6CT9frprbyeFtjmaUfr4ZVuyfRcW759/LZQxj
         mZfGeyiOdxn+db3KDXx43zyaoyCWXv4CNIwsIxEkH149zgsQ+e9ER3mJ7dxIrkSLqgiN
         IkMbsWU0DndF6YEuoD4nS2iHm7Lsj8V8qIrfyFQAQv2DrX0RD9IjJnK8PQuikRIatKSw
         e4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9fdBIY1KYMFZ4JFMNlpu0pm5ABu/2B68JmMEK1VM25g=;
        b=mYykABnOjpyLB9XF8Nonf46Qe/qKStFL202hVV4i33YqiM9hWr9Z3ifDWy7xyv+EE9
         lMScdRkOFsbNMYzv5H1dAsr6cyku6nPJDkP3Yi5XqStDGMK/9Xw1MzbQg2Gff+fx3/yc
         oUKXN2OevKc9mDAKKdaLFYN6h68ADqI3UxnedhtidQeN1aOOrHIQAOMN1I207XrFsS/H
         HWFTvHOOiNaZFhBmmuEKjR3fWvVueI6iXlT0sEmeCURQElTV1SjzUDlOCOthXi8UmKqa
         9zlTwK0lnCMlvweOcqYAMrymPlOJNoMwqYkhG9bF9rbWE5Tc78asDUC7in+gDEUzqLOr
         Ojdw==
X-Gm-Message-State: AOAM533OoD3gv2RQ2SLuKucIFeNFWanOdQnZ34L1RM2TGnK5GGnoyaqZ
        V6peXx5KHg2Py4p3bbP/e5NOUfOAXJU=
X-Google-Smtp-Source: ABdhPJxvJaWKZJDehNH7wo6O0D+mHw/IM2FM8V2kVx1vefDbnoJoDzqvWcvtBbWEjeWS4mUKqQ+X+w==
X-Received: by 2002:a05:6830:86:: with SMTP id a6mr25189156oto.88.1629676264124;
        Sun, 22 Aug 2021 16:51:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:48bd:24c0:4055:3255? ([2600:1700:e72:80a0:48bd:24c0:4055:3255])
        by smtp.gmail.com with ESMTPSA id p2sm3279426oip.35.2021.08.22.16.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 16:51:03 -0700 (PDT)
Subject: Re: [PATCH] multi-pack-index: fix --object-dir from outside repo
To:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org
Cc:     "Signed-off-by : Taylor Blau" <me@ttaylorr.com>
References: <20210820193504.37044-1-johannes@sipsolutions.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <04ed58aa-94fa-010e-f4db-f41cd51876a5@gmail.com>
Date:   Sun, 22 Aug 2021 19:51:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820193504.37044-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2021 3:35 PM, Johannes Berg wrote:
> If using --object-dir to point into a repo, 'write' will
> segfault trying to access the object-dir via the repo it
> found, but that's not fully initialized. Fix it to use
> the object_dir properly.

Thanks for finding this! It's difficult to cover all of
the cases, but I'm glad you found this and added a test.

> +test_expect_success 'multi-pack-index with --object-dir need not be in repo' '
> +	p="$(pwd)" &&
> +	rm -f $objdir/multi-pack-index &&
> +	cd / &&
> +	git multi-pack-index --object-dir="$p/$objdir" write &&
> +	cd "$p"

Why are you using "cd /" here? Even if you mean to use "cd",
please do so within a sub-shell.

Could you instead init a new repo within the current directory
and point the object-dir to that location?

It could look something like this, (warning: I did not test this)

	git init other &&
	test_commit -C other first &&
	git multi-pack-index --object-dir=other/.git/objects write

And is the only post-condition you are checking that we do not
crash? Or is there a specific result you are looking for? For
instance, we can double check that the MIDX was written:

	test_path_is_file other/.git/objects/pack/multi-pack-index

but also you seem to be touching areas that delete files. Could
we 'touch' some of those and then see them get deleted?

Thanks,
-Stolee
