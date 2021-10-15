Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74505C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F05561151
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbhJOQsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbhJOQsL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:48:11 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E506C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:46:04 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id g14so6122785qvb.0
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J2xY2jRGTopcZUnYGY75BEygOxapaHxSAvyd+utsqp0=;
        b=Mtb3h364f0a245IORje5wIscuHvOxH/NzQCtv+mv+GY8LUgSFh+NrAT6dB2y/fh8oV
         m1jDDmUR1R8paLaPGv1Ixfn7i6j30qZnWjNbT0xpgF7Z8z+Ujk0Fo4GlrA/gY3H/EqIR
         OfrMm0oTOI1opoFZSKOJ/Gdv6LPt8GoZ8AhJc3D3GgeOYqgx0xtxrJbF9z/ZGhGJfZlg
         Iswe5xmtBayu3PZhMbtGvOH1uHmMzxK4xy9hZccKB7dWJuWcXtoLUJFKKDZaXVy9A/7E
         +/l3Y9BLsuN431VAMwWcuh+XLbVN8xQnq6ue2H2CN/+STgWIBBQt8Ar6WjJqU/tXUJ9e
         yKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J2xY2jRGTopcZUnYGY75BEygOxapaHxSAvyd+utsqp0=;
        b=Oc5yZYoCd+TYj8ZtHXiE8//jcmtznWMQrW8NWspNx/CKcqYIx2v2OcC5XP0kCUd0sx
         JLwtc/gyeLxh8T5B5KulMDDMA5MwHq1FNP1C4ohHLh5xhVrdkr8P5mDaIo2Pa8CNB4ks
         VpTT8r2I+Cxa+gVGERPq6TYjjCB8uXD0qat0QYlWcQ36uBrokK5JRyiG0lkgCrM6NTpP
         +3docgTEEvMS7G9gwP9IYo2fnV64CXFBJOq253mmUqrcpgpEA2tKparqBGL+qSM337Ye
         rKYFOVcCn0Ek7uVB9GuSVCpYmloi11tqZF3sku3wmUf3Ac8ncu8BjQi12FYqUyEsBMO0
         MIuA==
X-Gm-Message-State: AOAM531XJJopglR3e2VWfaSvBt/zourzjz1MbzwGIra9nh9+UXUDGAKP
        gA8cz7SzEF3YAUmaETeJTZX23O5VBSU=
X-Google-Smtp-Source: ABdhPJysu7G8dXvp6j7UWZDSDTalAaCxRGo5VFpKBUyWgG32RlgUzzwT5mR0tbiVEZJAwpEoXO0Y6g==
X-Received: by 2002:a0c:f10c:: with SMTP id i12mr12112489qvl.27.1634316363603;
        Fri, 15 Oct 2021 09:46:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7410:d2b1:c643:df9b? ([2600:1700:e72:80a0:7410:d2b1:c643:df9b])
        by smtp.gmail.com with ESMTPSA id m6sm2759233qkh.69.2021.10.15.09.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:46:03 -0700 (PDT)
Message-ID: <a8e7c755-6ee0-cec7-9721-0e244e561542@gmail.com>
Date:   Fri, 15 Oct 2021 12:46:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] diff: enable and test the sparse index
Content-Language: en-US
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
 <9a597233cf4127e97ac9f680f540c7c9a9304211.1634232353.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <9a597233cf4127e97ac9f680f540c7c9a9304211.1634232353.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/14/2021 1:25 PM, Lessley Dennington via GitGitGadget wrote:

There is a failure in 'seen', and it's due to a subtle reason
that we didn't catch in gitgitgadget PR builds. It's because
ds/add-rm-with-sparse-index wasn't in your history until it was
merged into 'seen'.

> +test_expect_success 'diff partially-staged' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>$1
> +	EOF
> +
> +	# Add file within cone
> +	test_all_match git sparse-checkout set deep &&

The root cause is that you should use "test_sparse_match" when
adjusting the sparse-checkout definition. The full-checkout repo
is getting the sparse-checkout set to a single pattern "deep",
but without cone mode.

> +	run_on_all ../edit-contents deep/testfile &&
> +	test_all_match git add deep/testfile &&

But the test fails here because "deep/testfile" doesn't match
the sparse-checkout definition in the full-checkout repo.

> +	run_on_all ../edit-contents deep/testfile &&
> +
> +	test_all_match git diff &&
> +	test_all_match git diff --staged &&
> +
> +	# Add file outside cone
> +	test_all_match git reset --hard &&
> +	run_on_all mkdir newdirectory &&
> +	run_on_all ../edit-contents newdirectory/testfile &&
> +	test_all_match git sparse-checkout set newdirectory &&

You'll want to change this line, too.

Thanks,
-Stolee
