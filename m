Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FA0C6379F
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 11:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjBULAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 06:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjBULAF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 06:00:05 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A144B233D4
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 03:00:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id az11-20020a05600c600b00b003dc4fd6e61dso3208590wmb.5
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 03:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7Ya8mK97PQVtIjvv5czqZPMWtyW7Jl57o6v5UMLTDg=;
        b=KtPurucPgnT+kQzlhkSRilZ04aQQQcTsjKBKRVHgaJhi12a7kp8sz9DK5ONucGOSI5
         PKkC3HJBC2aLP8KzeCaDssmah3SD0Tcrb4V5bEVHvxhfuJN1NnquYSzbRtlG3+MwkBKi
         AXFSO0qWqXVrCn8VhQFzTVr3kTB0eLyYPdLM3B3zZuJFqRMeZvqPcyE1fEK2tjraidpH
         o3d4z1Z3klObY43gcoV1Xapt4W+m5j5Mc3G866FTS47jsguActbW9AXVvSqDFcfoaDsT
         wy80CjN3BWFdkGayTImdKIdKcknTzWuTC7LnAfzu5NoZqoDVfWG5ZhLuTs9PVWas2gt8
         D0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7Ya8mK97PQVtIjvv5czqZPMWtyW7Jl57o6v5UMLTDg=;
        b=JpAjDzHN6VFJj7US73TlM5sTyjODIp1zJkJaJH0CEng1Ky6TYsjscOFeXy9YupwheV
         BvI9PlCW4LdQOQNXXxWU7Ve+hMy11h/x7aVPhaToqKbifubwXdJhR7Y2ndnV+yyRdOhY
         4SwB/AKp9lifa++qF9VdYsIdHxInjlvCFv4GglEzdD1iKZxGTckJTMovd013kezfoJl3
         E2vc3bHI92pOWR+trwxEB4otFwy0NhoB8tm8TTFditYJTSTKLG6gqgEWPaVpLEZ0ogzP
         FrWcfxyxLAFfqYBmyqSwIrYTxD+54nG9e94vshwp7yAKIeRaOeKw9IwbG91ykbUoRqmB
         lnCQ==
X-Gm-Message-State: AO0yUKVE3+uQQLAEK/yP7LOEDKy8q7n8swS4XcJBKk3d2ZIGiwK8OjPD
        YMOiWH0huvsE+5khCnAHfKk=
X-Google-Smtp-Source: AK7set92WgVA2UZNzBzrjYOFGcK7aBKn2B1gQXxoXea9SbeWGFbEULDmd2nrYfEoMKsYOuxdS+oZzw==
X-Received: by 2002:a05:600c:929:b0:3df:e6bb:768 with SMTP id m41-20020a05600c092900b003dfe6bb0768mr2388432wmp.24.1676977200079;
        Tue, 21 Feb 2023 03:00:00 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id k17-20020a7bc411000000b003dfee43863fsm3605559wmi.26.2023.02.21.02.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 02:59:59 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <24be0c50-9dfa-e9d9-9d78-1b993832884b@dunelm.org.uk>
Date:   Tue, 21 Feb 2023 11:00:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/4] rebase: add tests for --no-rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
 <20230221055805.210951-2-alexhenrie24@gmail.com>
In-Reply-To: <20230221055805.210951-2-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

Thanks for adding some tests,

On 21/02/2023 05:58, Alex Henrie wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   t/t3430-rebase-merges.sh | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index fa2a06c19f..e0d910c229 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -250,6 +250,31 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
>   	EOF
>   '
>   
> +test_expect_success 'do not rebase merges unless asked to' '
> +	git checkout -b rebase-merges-default E &&
> +	before="$(git rev-parse --verify HEAD)" &&
> +	test_tick &&
> +	git rebase --rebase-merges C &&

I don't quite follow what this part of the test is for

> +	test_cmp_rev HEAD $before &&
> +	test_tick &&
> +	git rebase C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
> +test_expect_success '--no-rebase-merges countermands --rebase-merges' '
> +	git checkout -b no-rebase-merges E &&
> +	git rebase --rebase-merges --no-rebase-merges C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'

This test looks good. I think we could probably have just this second 
test and squash this into the previous patch - improving the 
documentation and test coverage for --no-rebase-merges would make a nice 
self-contained commit.

Best Wishes

Phillip

>   test_expect_success 'do not rebase cousins unless asked for' '
>   	git checkout -b cousins main &&
>   	before="$(git rev-parse --verify HEAD)" &&
