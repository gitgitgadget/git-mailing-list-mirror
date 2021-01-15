Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A18C433E6
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE3B23A04
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbhAOCh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbhAOCh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 21:37:27 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6CEC061757
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:36:47 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id w79so10441892qkb.5
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mYLAcKbHOfFeKmEZnnvwJyLSBbENW5Mb3RDWhG4KT/U=;
        b=rpNcq5WNwJaMB40z9HpoCx7STI1gJ/EE5EVOp3NfhnpxRGjvBx0Ev7CoILLKbfXTLP
         1xvf/cf7DtMlYmTxX7XxaIzRS5Oq++MFle1TBYYvNA02jChUaYfbllFPZx52mCbLr5Wt
         eEIuajnTNPcMx6TjQ8AsMI5GXSTkuuGNxzbZkJ/N7KJPz5bsf2CGhv7U27qzEDAIJdv1
         ybzl98kZCXoPw7MuV3v0asFROkL8PKl0aLp+Xw5O+MDFgV8UKi/XXXQzBsXHD0zk8Imi
         mqGTAaxe04yKiRbMxVd3OS5El2HnTfrLUQdQYXnpCR1PBIPzPV2Rwa2UNqMf8k8eZ0uz
         KFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mYLAcKbHOfFeKmEZnnvwJyLSBbENW5Mb3RDWhG4KT/U=;
        b=AdZgiUmEviFYvXLJelfBkv0sauFC5wrENFCbXi7fzNklmN1c++kzJRBj1QE/8CNnmj
         wronW1sNv0m52xA5oUTdtRhFnDfuJu/UwwaExp5pDRTgOMLpwExxTAAbf+waHam5D7GJ
         loaFm1wz9MWgQ1uYFpQktStF+W4/rFgygyIkV6tVuPP1md7W6B/nnAXni+TYTjJR2Wqz
         w73l+p4t1qkSkYhsuY4QYKRFJSXPEmERTvQAzxIeKWClC3HeVy6ibx678dQ/K0t0fDRj
         IHehcgY36hEKLiHvXGfmyAmwVHpnNS5zgLauxuD0M8Vhp6IVATPn3K13MF7XGWCIWuVw
         HEAg==
X-Gm-Message-State: AOAM533zHwvMilPQiaoBQKyBEhDqYh/28GyZHGte1aPW5OnoNyv9pCIx
        5y7JIWwWKrFmLeTnZVvarIVAGFY5/uA=
X-Google-Smtp-Source: ABdhPJwwG4fmwjd8kD5F9ygmAkL8fhK5x41J9X/P/Cgd3M9VQTY9bcNPzmRlMGxqy+E/WIiTc1yGIA==
X-Received: by 2002:a05:620a:544:: with SMTP id o4mr10392151qko.19.1610678205930;
        Thu, 14 Jan 2021 18:36:45 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:81b0:4431:6d9:fc9e? ([2600:1700:e72:80a0:81b0:4431:6d9:fc9e])
        by smtp.gmail.com with UTF8SMTPSA id x25sm4158013qkx.88.2021.01.14.18.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 18:36:45 -0800 (PST)
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
To:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <YADOf41CcaRuToD7@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <15237c6c-98eb-0d1f-e6d5-2dda91c0ce09@gmail.com>
Date:   Thu, 14 Jan 2021 21:36:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YADOf41CcaRuToD7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/14/2021 6:06 PM, Emily Shaffer wrote:
> On Fri, Jan 08, 2021 at 11:22:23AM -0800, Junio C Hamano wrote:
>> * ds/maintenance-part-4 (2021-01-05) 4 commits
>>   (merged to 'next' on 2021-01-08 at 1f98c859ea)
>>  + maintenance: use Windows scheduled tasks
>>  + maintenance: use launchctl on macOS
>>  + maintenance: include 'cron' details in docs
>>  + maintenance: extract platform-specific scheduling
>>
>>  Follow-up on the "maintenance part-3" which introduced scheduled
>>  maintenance tasks to support platforms whose native scheduling
>>  methods are not 'cron'.
>>
>>  Will merge to 'master'.
> 
> This series again has troubles running inside a directory with regex
> metachars in the path. Courtesy of Jonathan Nieder, I think this fix
> matches the intent a little better; but if we don't like this, the same
> lines could be diffed just to add --fixed-value instead.
> 
> Before this patch, the test said "Is there something configured in
> maintenance.repo that looks like $PWD?" and after this patch, the test
> says, "Does the config in maintenance.repo look like $PWD?" - so it is
> not quite semantically identical but I think may be clearer.

This appears to be a case of mixing up the order in which these
submissions came into place. js/t7900-protect-pwd-in-config-get added
--fixed-value, but that was simultaneous with ds/maintenance-part-4
which added more tests in this vein without including --fixed-value.

Looking at the history, ds/maintenance-part-4 doesn't have
js/t7900-protect-pwd-in-config-get in its history, which is probably
why you don't include --fixed-value in your patch.

Perhaps it would be better to have a --fixed-value patch on top
of the merge that combines the two topics?

> -- >8 --
> Subject: [PATCH] maintenace: explicitly test value of maintenance.repo

s/maintenace/maintenance/

> Make t7900-maintenance.sh easier to debug by printing and checking the
> value of maintenance.repo rather than using a search string. Since only
> one maintenance.repo is configured, this is fine; in the event that
> multiple maintenance.repo are configured during the test, instead the
> directory under test should be provided along with '--fixed-value'.

Here you mention --fixed-value as if you plan to use it. I'm all for
that plan.

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  t/t7900-maintenance.sh | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 2e0c8a4c31..0edad63227 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -487,7 +487,9 @@ test_expect_success 'start and stop macOS maintenance' '
>  	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
>  
>  	# start registers the repo
> -	git config --get --global maintenance.repo "$(pwd)" &&
> +	pwd >expect &&
> +	git config --get --global maintenance.repo >actual &&
> +	test_cmp expect actual &&

Sorry again, but this (and others) would probably be better as

+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&

Thanks,
-Stolee
