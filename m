Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE33CC4741F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90379208B6
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd/49QdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgIYSnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYSnN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 14:43:13 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D76C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 11:43:12 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id y5so3249902otg.5
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 11:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=634xwWWexrbyuLU8HQvwIkrvUOdCaIAqINzfUKUowhE=;
        b=kd/49QdD5AYUgx5/r2cOOw/4vWGEaUaSSwngZVyvVX0E9L3APJwZrJhEvG+drOk9o9
         5jlcxftmvk2RtS29uFo4AB8nHyNUdExsXOOux7Xm0ETU/NNkavxEAsvRwHz+MEOI5rtS
         KYapC6bhtTvlIuRuSuibZ9aQ7QH/dS/ArpVaS+C267UugBqnWz7ynkP2s3Gl1MJgYlW4
         3crSawNac/VVtACkZiNm6mGBMwX5zF+0tYwn+baEqPtgoaP7hYmIvcmodibFSjs4yFnM
         P26U5vmSp7MKqvFznHqY1CO1aMwjKhaSO6mpK6UcZ3YQ4kBzOilKhK/rUZa3sHUFYjzV
         MsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=634xwWWexrbyuLU8HQvwIkrvUOdCaIAqINzfUKUowhE=;
        b=kOx3hwGux2hzkqorqjRspRX57/TN3Ba/2de+2aWG5ir3yZNQVfTmyDefAKEKrcjy1b
         npYwPHsy7VnFVUvs/2oYiKGEcilEsycOOETyx4/4VuOWS79MStW4PZCqs4AZcqMaOQdo
         OkRn8C0JaCHdlZz0NRiiVuntJu1lz2PZkbFVlJb1uCexnsT0y1+bmRk9Bu2NjmtW0YaF
         s8E9nbdxoRIrxE1yA5xRMRabygeE4nurQ6y8qqOgAxJ8kTkbLekx3QoVnPGUwOs1WjtB
         9J3zD73SWuFRgu7c89x5dBiOtukZhXDEj5bzMRYhMqyQWzp6iMCWj2+CaI4Fu+04aVdo
         10Og==
X-Gm-Message-State: AOAM531W69g3TqoiM/xSaaPlMKw7Xpg9QePs35Sd7JUfkuCs/GNHgGNU
        uPPto+8ITqC2hE9lTsysDAxYXwpS+Jw2CWY7
X-Google-Smtp-Source: ABdhPJxhi5hVQKoQ8KzZ6IPQGenHOg0L2oBphFzmX5o5pO4pyV2knQx33NhtL/dhT7O7fQtj39RZFQ==
X-Received: by 2002:a9d:7856:: with SMTP id c22mr1249398otm.153.1601059392144;
        Fri, 25 Sep 2020 11:43:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bdc6:8b77:8b68:f0f3? ([2600:1700:e72:80a0:bdc6:8b77:8b68:f0f3])
        by smtp.gmail.com with ESMTPSA id k51sm828968otc.46.2020.09.25.11.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:43:11 -0700 (PDT)
Subject: Re: [PATCH v4 3/8] maintenance: create auto condition for
 loose-objects
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
 <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
 <931fff4883a3da26a296af69a9c5ccc3a5037d71.1601037218.git.gitgitgadget@gmail.com>
 <xmqqh7rllos3.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d9b60edf-a06a-85ec-6676-a2e6b1a9a506@gmail.com>
Date:   Fri, 25 Sep 2020 14:43:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7rllos3.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/25/2020 2:00 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +	printf data-B | git hash-object -t blob --stdin -w &&
> 
> Is it essential for the purpose of the test somehow that the data
> used for the test are all incomplete files that lack the end-of-line
> at the end of the file?  Use of 'printf' sends such a signal to
> confuse readers.
> 
> Use of test_write_lines to write a single line may feel overkill,
> but it may be less cryptic, as newer parts of testsuite are
> encouraged to use it over 'echo' and raw 'printf'.

I suppose it could be more standard. It's not particularly
important what the data is here, so lacking a newline seems
innocuous enough to me. I'm happy to agree with standards
elsewhere to avoid being a bad example.

A simple s/printf/test_write_lines/ appears to do the trick:

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index f259485990..a1bd0029c6 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -147,12 +147,12 @@ test_expect_success 'maintenance.loose-objects.auto' '
                git -c maintenance.loose-objects.auto=1 maintenance \
                run --auto --task=loose-objects 2>/dev/null &&
        test_subcommand ! git prune-packed --quiet <trace-lo1.txt &&
-       printf data-A | git hash-object -t blob --stdin -w &&
+       test_write_lines data-A | git hash-object -t blob --stdin -w &&
        GIT_TRACE2_EVENT="$(pwd)/trace-loA" \
                git -c maintenance.loose-objects.auto=2 \
                maintenance run --auto --task=loose-objects 2>/dev/null &&
        test_subcommand ! git prune-packed --quiet <trace-loA &&
-       printf data-B | git hash-object -t blob --stdin -w &&
+       test_write_lines data-B | git hash-object -t blob --stdin -w &&
        GIT_TRACE2_EVENT="$(pwd)/trace-loB" \
                git -c maintenance.loose-objects.auto=2 \
                maintenance run --auto --task=loose-objects 2>/dev/null &&

Thanks,
-Stolee
