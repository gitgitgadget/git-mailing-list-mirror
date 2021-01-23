Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B609C433E6
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63ED2310A
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 18:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbhAWSgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 13:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWSgt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 13:36:49 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A74C06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 10:36:09 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 63so8597248oty.0
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 10:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q11YeaDPdMODaXHjuci94eEly/FuAMFOFO8/ObXc/PQ=;
        b=cjkStSxpIAofpCuUJDvtfjYxkJanEJHIrDy9SWY+zhLFLVA54sdShsibXRnoz1Z21t
         5gwqsH2YfyeApXPBkL714RydcLQdf40GsTwQ4Ls7lK/G+6fu0LTk2sKK3OB7YFfoUhLd
         57LdCU8U+Dxj2AEp1WTOMju2DkeY+yeNyWnWcGBigZF8uUh4gXGG9wukLp321LovmD9R
         dTzSG9lDFU4dxgDgq43n1Fhk4Oa4rqDd+I3683TKjC3sJ9j8K2HFRn7/2C42CiKNvbnB
         vUPE8VmNd38yYeF2B3bDSSyQisGQeUL1PJOtD1ZToZ7aXG70yYMxOasoD20+H2dfyJdf
         nIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q11YeaDPdMODaXHjuci94eEly/FuAMFOFO8/ObXc/PQ=;
        b=lKV5456ujffcqp0df6iBHT2aDHBcY36hhKnF53UV/Y8HXA0Fvvc1G8tsn+tnpgsH4N
         5EDKs2HH+A7bKm8fREsrrf7B0noMnCnmd4vRlqxv6PCU6XC/miuKu3Groz9M5Vpu6sIy
         oYaOMVC5ZO3CL55RXT39NGL2dljj2pNxjiFCpOaNkbm307VS3IKN+4TgFbkL89Yp9Jh6
         NdN3MgvpynROR7mUFpWXBOk06lEg5Cgl+GHD8DwtCO+eVzrVwMiO2wDNz2BQ2V1/muuw
         /DS4MjtueiZHBjrosn+AlkhCqVOjhR/zKPFF4AdqUP9/MEA9Cjp8UX3ztV8Nys49jnly
         Uazg==
X-Gm-Message-State: AOAM5305Va6SJ2gbpOpWla016u0C8bhhVn4YATgJu2FGUTfgeXPb5aKY
        JrNLJpRrpRXP4YR9cM8Z1GE=
X-Google-Smtp-Source: ABdhPJwjh6+JkLyVzH+QdZI9IcLS+aA2d/5Qaz69j1Y27NphTwLrHO6801OJ33VHVM+QVUDP9bkpSA==
X-Received: by 2002:a9d:8c9:: with SMTP id 67mr10261otf.29.1611426968212;
        Sat, 23 Jan 2021 10:36:08 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:98e8:103:e6ee:9536? ([2600:1700:e72:80a0:98e8:103:e6ee:9536])
        by smtp.gmail.com with UTF8SMTPSA id d17sm2477506oic.12.2021.01.23.10.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 10:36:07 -0800 (PST)
Subject: Re: [PATCH v2 7/8] test-lib: test_region looks for trace2 regions
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
 <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
 <8832ce84623e9c74a88b14a05b1c303ed8aa809b.1611320640.git.gitgitgadget@gmail.com>
 <xmqq7do492sh.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8406512b-3d9f-e899-24fd-8a09c4af3569@gmail.com>
Date:   Sat, 23 Jan 2021 13:36:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqq7do492sh.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/22/2021 2:42 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +	grep -e "\"region_enter\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"
> 
> ... this makes sure there is enter/category on a line (and
> leave/category on a line with another check).  Makes sense.
> 
> But...
> 
> 	test_region '!' '\(unmatching capture)' 'two' 'three'
> 
> would try to use an invalid regexp and cause grep to exit with 2,
> which would mean ...
> 
>> +	exitcode=$?
>> +
>> +	if test $exitcode != $expect_exit
> 
> ... this will not trigger and we return "success" (i.e. "failed as
> expected")?

Am I misunderstanding something here? If exitcode is 2, then this
will always trigger and return 1, signaling a failure. That would
propagate to the parent test and cause the test to fail. That seems
like the correct intention, but I'm not 100% confident about that.

> 	Clarification.  The point is *NOT* that the grep pattern is
> 	not robust against funnies in $1 and $2---after all, these
> 	strings are under our control.  The point is what should
> 	happen when "grep" exits with an error when asked to ensure
> 	that there is no region detected.

I'll be more robust to these in the next version. We'll expect
exit code equal to zero or _not_ equal to zero, depending on the
presence of '!'. This has the downside of returning success for
bad input strings when '!' is specified.

Basically, the approach I'm taking for v3 is here:

	if [test $expect_exit = 1] && [test $exitcode = 0]
	then
		return 1
	elif [test $expect_exit = 0] && [test $exitcode != 0]
	then
		return 1
	fi

>> +	grep -e "\"region_leave\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"
> 
> The same comment on "what about an error from grep" applies to this
> one.
> 
> It might be easier to read to avoid having to say too many
> backslash-quoted double quotes:
> 
> 	grep -e	'"region_leave".*"category":"'"$1"'","label":"'"$2"\" "$3"
> 
> This comment applies to the earlier "grep", too.

Thanks. This does look a bit cleaner.

-Stolee
