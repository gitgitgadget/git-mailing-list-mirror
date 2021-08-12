Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF09C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 10:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2FE8610A4
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 10:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhHLKEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbhHLKEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 06:04:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAA6C061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 03:03:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u15so4069538wmj.1
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ixkeFVnNSe7R9EaKeuDZhFNvDymjpAyapC4gpAKdPNE=;
        b=Mwb7kwyLC8wCS7WnArwmtUIaLsagEp/pKkmOnMT7mRn2Lyo8Pp/FiPlKAmuQ9cDYBb
         rUCrXvdxoG5Ff4tdDNPcN1F0p70qchbdiqwhbwXDi5ssHaBhnHZ835QLO2WdR1ZxtSq5
         DVgrZTFWxljOSo5vEucSwNYtEh8zzNMFyq2kxNNj9OAsMimM5oEt2PhdDdp9OJpz01W7
         wa6XZ1EzER2oCKU5jPtZs2fJxKY8VPGleznORPBnpFd5NDm1aeO+ZmH8TtZlTyMISJgy
         MQ8BWwU4XGBG//02y3px+vzUdBIG41+ug1CrpUr5+pZeuGq/WljwMT2gQURjn0+DuPAO
         5UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ixkeFVnNSe7R9EaKeuDZhFNvDymjpAyapC4gpAKdPNE=;
        b=EQvyAVBxRtkJPp5W7hHsYjGYvGd8U7JoeoSk6oy2r8P2NZzRrXVkrB9JDL0bw2+bve
         B6hPamRh3bIhl8zy/MJcnktYkdz7wxAjvXm/v03YQrY0/IBE7MYWrJAa4+DuITXWt1Lw
         1442zR1OZrH+e6rCRcNHIjoXRpOL3CkJ7Kh256Wm1KajvNKViWh9syIYVr28QQMxan3Z
         HtLZxhXdIx7Y7UV52wJRoE6imffHqKkuVMMOKpqzO1Tt1bTuMG8Tz+o3T0BWu7EHbFtB
         JuJ8QKXIvjX+HenQlBdtI6Yal2c+zTjfWzCDqosxxGX8KR816+3p8oFQCSmutcamW16o
         fwkw==
X-Gm-Message-State: AOAM530wQmbapldWv7tCIouvRpY8dWIwZ4a/jzVwppITCaKkCTjEoKrY
        eeX6csLLtUTLW6u69G2FfTg=
X-Google-Smtp-Source: ABdhPJwCwkZctdzIjcPLgu3HYXtIzcnfbA1RoCr1Xsw4oI9hTOr0m8wSifd6SfYkdQueESQXG90dwQ==
X-Received: by 2002:a1c:9852:: with SMTP id a79mr3212551wme.2.1628762636794;
        Thu, 12 Aug 2021 03:03:56 -0700 (PDT)
Received: from [192.168.1.201] (188.96.189.80.dyn.plus.net. [80.189.96.188])
        by smtp.googlemail.com with ESMTPSA id x18sm2115963wmc.17.2021.08.12.03.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 03:03:56 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] rebase --apply: restore some tests
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Victor Gambier <vgambier@excilys.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
 <f7722dab21dafb73e64754b1286913eaa826f865.1628587917.git.gitgitgadget@gmail.com>
 <CABPp-BFJD77wkroL5NFsH++a-yn0h6s6KM=Xfr2Ad_PfPQrUuw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <dc7b7943-a0c2-241f-63ed-417378b30224@gmail.com>
Date:   Thu, 12 Aug 2021 11:03:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFJD77wkroL5NFsH++a-yn0h6s6KM=Xfr2Ad_PfPQrUuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2021 17:58, Elijah Newren wrote:
> On Tue, Aug 10, 2021 at 2:32 AM Phillip Wood via GitGitGadget
>>   test_expect_success 'rebase --skip can not be used with other options' '
>> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>> index f4c2ee02bc9..e4cb8be0418 100755
>> --- a/t/t3418-rebase-continue.sh
>> +++ b/t/t3418-rebase-continue.sh
>> @@ -36,7 +36,7 @@ test_expect_success 'non-interactive rebase --continue works with touched file'
>>          git reset --hard &&
>>          git checkout main &&
>>
>> -       test_must_fail git rebase --onto main main topic &&
>> +       test_must_fail git rebase --apply --onto main main topic &&
> 
> I think the point here is that you're noticing that "git rebase -i"
> and "git rebase" are both built on the same rebase backend (the merge
> one) and thus that testing interactive vs. non-interactive isn't much
> of a test.

Exactly

>  The real test we are interested in is merge-backend vs.
> apply-backend.  Your code change here is the necessary one to do that,
> but it least the test descriptions still talking about interactive vs.
> non-interactive even though that's not what we're concentrating on
> anymore.
> 
> I'd say we'd at least want to change the description for this test,
> "non-interactive rebase ---continue works with..." => "rebase
> --continue with the apply backend works with...", but that we'd
> probably want to change the description of the test before it and
> maybe even just use rebase --merge rather than rebase -i.

Rewording the test descriptions is a good suggestion

Thanks

Phillip

> 
>>          echo "Resolved" >F2 &&
>>          git add F2 &&
>>          test-tool chmtime =-60 F1 &&
>> @@ -254,7 +254,7 @@ test_rerere_autoupdate () {
>>          '
>>   }
>>
>> -test_rerere_autoupdate
>> +test_rerere_autoupdate --apply
> 
> Looks good.
> 
>>   test_rerere_autoupdate -m
>>   GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
>>   test_rerere_autoupdate -i
>> --
>> gitgitgadget

