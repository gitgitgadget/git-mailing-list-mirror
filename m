Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6EDC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 13:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhLJNzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 08:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbhLJNzb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 08:55:31 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F9C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 05:51:56 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id be32so13251840oib.11
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 05:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OSkRpLkI9W5zNwTj+UQOaQ7gcVhI3pbnO9jWfCvUtDc=;
        b=q0tw27lqyZF1QHl7klQ6xwxetwuf2xxAohxK8Xc2tudS9P/Q3gNvrkOdvqUn9As7QY
         yeSrL35gudMVBOR5kwZUxQp68NdEAavyzS9cinC2w2RAq2hH4FphqW5Ki4E97zOv66j7
         UuBSzuwaLLn6NIAFPd2ZBUfjarF5cfiRCxZr0jDpairKiDrkMtclo6n6s1dBjduZsU93
         9kGOmFwQuMPn9jPu9j3B3wt8f46smEtrSZglegdSXw77hSn98WsIrMJNRN3zZBdkRuyV
         SfdipCFYPhyHLkv3zgPN+KFVflKBvCwy4MjN2QugtIfxI+Jjy+X3qJf8KE5zPCZ6ZEW1
         2f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OSkRpLkI9W5zNwTj+UQOaQ7gcVhI3pbnO9jWfCvUtDc=;
        b=XIrz5fhzGjDfu3VyghAkLwObXQC9LJYvpcbruhIELlV7dXnHnpT7ksG+5z/4+DgKFP
         qdvbY5KInBIn8KTke6PLKzZrdO+ssIgb0D/VNp9aevDbNVMFlbo3m6xhP2NMQhZfnb04
         V4yXMRPDMbf0zLaIc1tNY0KZnyMQiiFvfNHkM7papBWbe8US4BDwBVTdpcaiWxLgMEgn
         l8OkzTXqTNWwghO+DKlTmFzDKGiogE+61iamW8ZyQP0ejOj+vsdjEPf4CVWPkt/NEd9e
         ORsW11wi143t7XpS1X1Ib5iNag3JG2E/C7edfDQ4hpd14iCEl8/cTVsk9s1e9pJx2NkX
         G5Kg==
X-Gm-Message-State: AOAM531e7DXy94TJLo4nG73GyR5wpNrHCEsuOdzFf5i5cmkHo1d3CmrL
        VkiR14PBfIx7IYXfFBG+Ut8=
X-Google-Smtp-Source: ABdhPJzUmcsmuc2ZefqJf7a67zKEp1AY6fEAELnuUs5EdqiNL70tYpWh4tJr5hW67boS8Ior8NDjpQ==
X-Received: by 2002:a05:6808:1c5:: with SMTP id x5mr12335259oic.144.1639144316008;
        Fri, 10 Dec 2021 05:51:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:38d4:1ef3:99bd:2950? ([2600:1700:e72:80a0:38d4:1ef3:99bd:2950])
        by smtp.gmail.com with ESMTPSA id k1sm523025otj.61.2021.12.10.05.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 05:51:55 -0800 (PST)
Message-ID: <e2a39196-5ee6-fbe7-a24c-c14c809f707d@gmail.com>
Date:   Fri, 10 Dec 2021 08:51:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/5] ls-files: add --sparse option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
 <58b5eca483502b0d45601490f6b4255f6419e6bd.1638992396.git.gitgitgadget@gmail.com>
 <CABPp-BF5kw69ioheMvRPoVso8FJf45Fdm_Cf-P7PfqWsqHz9Gw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BF5kw69ioheMvRPoVso8FJf45Fdm_Cf-P7PfqWsqHz9Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2021 12:08 AM, Elijah Newren wrote:
> On Wed, Dec 8, 2021 at 11:39 AM Derrick Stolee via GitGitGadget

>> +       # With --sparse and no sparse index, nothing changes.
>> +       git -C sparse-checkout ls-files >dense &&
>> +       git -C sparse-checkout ls-files --sparse >sparse &&
>> +       test_cmp dense sparse &&
>> +
> 
> I still believe this next section deserves a comment; something like
> 
> # Set up an erroneous condition: folder1/a present despite SKIP_WORKTREE.
> # We do this just to verify consistency between sparse-index and
> non-sparse-index
> # with such files.
> 
>> +       write_script edit-content <<-\EOF &&
>> +       mkdir folder1 &&
>> +       echo content >>folder1/a
>> +       EOF
>> +       run_on_sparse ../edit-content &&
>> +
>> +       # ls-files does not notice modified files whose
>> +       # cache entries are marked SKIP_WORKTREE.
> 
> I also believe this still deserves a slight change, e.g.
> 
> # ls-files does not currently notice modified files whose
> # cache entries are marked SKIP_WORKTREE; this
> # may change in the future, but we test here that
> # sparse-index and non-sparse-index at least match.
> 
> 
>> +       test_sparse_match git ls-files --modified &&
>> +       test_must_be_empty sparse-checkout-out &&
>> +       test_must_be_empty sparse-index-out &&

Ok. Sorry I missed these in the gap between v1 and v2.

Thanks,
-Stolee
