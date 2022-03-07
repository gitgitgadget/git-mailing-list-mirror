Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84433C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 13:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiCGNqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 08:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiCGNqE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 08:46:04 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73EF8BE2C
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 05:45:09 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w127so4762501oig.10
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 05:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nqSKMzKUs4jyJSFcbV4wi5aQPGqjgIH8RI+3mRlm+x8=;
        b=D5hANk/LsPrEXcTfI5NYH9uJCclI7Kz2ImgK2s+EdUqoV+iyziw83ukG1ICtMRYnBB
         ehou/UtLu9Qh1JmMi9v+TGU1XcW4k0tfwABCrUpHpwl/uXk/HGnO1teQlBiaeEMg4BIc
         yMmQeLD5YU3kxgH8Y0iTbHmFJi5vhUiOyHJ3BE9yX/5DSzKfwL2o1AYJnGByVhHHvSSB
         WSxfs2AG6sjaS83UH80UmS3NzdFvNocybJUa+jysO78kXhcWmmb1BPM4VGnvD9MTssv8
         WoQ2ozSV492Ase36rHwRh7dVBh1swp/NoPrCBFvZmAG+Az0HmErfhMp3OtrwUBlmYyXF
         0eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nqSKMzKUs4jyJSFcbV4wi5aQPGqjgIH8RI+3mRlm+x8=;
        b=XgA5Tkd5AcX+E6yh/1B5AaXWdU+/3veeUQm4wH0mTltpVLHclCdWGW0pkstRPR5chG
         R75YPZpKLugGXsp5cKb4xfK5fPd5wbbHnjdlNgFQPv2v6abKYomGIjKAM4tt9OG+avHw
         noWSqDZ9YAoxUlOT6TiDUTOQmhAzdqcxYAq4kUhSdT5uVGTprBrHPTEkgAPfhf9Mc4Y1
         zOSLE8SWJhDplcXlcYFh/icJ8zFGIOp8rD95tS5QF2LDiFLDZiqTArg41awlZjWzWaP+
         IhmE0LfSiZh/JkFuj+0Fv+u4AwtnPXOz39ueQCoV75R9z16zNg2MvxmdzprLPZfRZ/cu
         K8bA==
X-Gm-Message-State: AOAM53258DMPFJnCfmjqFr2/ILAHRP5YetRljfot6/NCOFbZ/ETMvx2i
        jrc7GzCQekbhMb4NC+0fwlkH
X-Google-Smtp-Source: ABdhPJyJJ5DvHJNF+BRSp0ovEtWhrb04JWirr11ziJ0AwrKo8KAVXSxdhNLFlVhnHyQCc/pNrwgCsQ==
X-Received: by 2002:a05:6808:1283:b0:2d9:a01a:48cd with SMTP id a3-20020a056808128300b002d9a01a48cdmr7925705oiw.280.1646660709113;
        Mon, 07 Mar 2022 05:45:09 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s4-20020a056808208400b002d54070f170sm6505087oiw.37.2022.03.07.05.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:45:08 -0800 (PST)
Message-ID: <94ed6a1e-327c-3f94-b98b-db019a6f5ada@github.com>
Date:   Mon, 7 Mar 2022 08:45:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <Yh3rZX6cJpkHmRZc@ncase> <Yh325v3RBDMxjFnD@ncase>
 <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com> <Yh4zehdSnHLW1HuK@ncase>
 <1b9912f7-87be-2520-bb53-9e23529ad233@github.com> <Yh93vOkt2DkrGPh2@ncase>
 <db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com> <YiCkRLFxn8Pok7Kc@ncase>
 <33deae83-1afd-1645-82f3-5af14f14094d@github.com>
 <06ea3190-32d0-c792-0ae9-c5600305f158@github.com> <YiXfnsbGzPXffdgV@ncase>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YiXfnsbGzPXffdgV@ncase>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 5:34 AM, Patrick Steinhardt wrote:
> On Fri, Mar 04, 2022 at 09:03:15AM -0500, Derrick Stolee wrote:
>> On 3/3/2022 11:00 AM, Derrick Stolee wrote:
...
>>> I will continue investigating and try to reproduce with this
>>> additional constraint of working across an alternate.
>>
>> My attempts to reproduce this across an alternate have failed. I
>> tried running the following test against Git without these patches,
>> then verify with the newer version of Git. (I also have generated
>> a few new layers on top with these patches, and they correctly drop
>> the GDA2 and GDO2 chunks when the lower layers "don't have gen v2".)
>>
>>
>> test_description='commit-graph with offsets across alternates'
>> . ./test-lib.sh
>>
>> if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
>> then
>> 	skip_all='skipping 64-bit timestamp tests'
>> 	test_done
>> fi
>>
>>
>> UNIX_EPOCH_ZERO="@0 +0000"
>> FUTURE_DATE="@4147483646 +0000"
>>
>> GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
>>
>> test_expect_success 'generate alternate split commit-graph' '
>> 	git init alternate &&
>> 	(
>> 		cd alternate &&
>> 		test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
>> 		test_commit --date "$FUTURE_DATE" 2 &&
>> 		git commit-graph write --reachable &&
>> 		test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
>> 		test_commit --date "$FUTURE_DATE" 4 &&
>> 		git commit-graph write --reachable --split=no-merge
>> 	) &&
>> 	git clone --shared alternate fork &&
>> 	(
>> 		cd fork &&
>> 		test_commit --date "$UNIX_EPOCH_ZERO" 5 &&
>> 		test_commit --date "$FUTURE_DATE" 6 &&
>> 		git commit-graph write --reachable --split=no-merge &&
>> 		test_commit --date "$UNIX_EPOCH_ZERO" 7 &&
>> 		test_commit --date "$FUTURE_DATE" 8 &&
>> 		git commit-graph write --reachable --split=no-merge
>> 	)
>> '
>>
>> test_done
>>
>>
>> My testing after running this with -d allows me to reliably see these
>> layers being created with GDAT and GDOV chunks. Running the 'git
>> commit-graph verify' command with the new code does not show those
>> errors, even after adding commits and another layer to the split
>> commit-graph.
>>
>> I look forward to any additional insights you might have here.
> 
> I don't really know why, but now I've become unable to reproduce it
> again. I think we should just go with your patch 5/4 on top -- it does
> fix the most important issue, which is the `die()` I saw on almost all
> commands. The second part about the warnings I'm just not sure about,
> but I don't think it should stop this patch series given my own
> uncertainty.

Thanks for following up. I agree that with 5/4 we should be safe.

I'll remain available to quickly respond if anything else surprising
comes up in this area.

Thanks!
-Stolee
