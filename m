Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAA7C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 13:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FED60E05
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 13:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhKBNpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBNp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 09:45:29 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D1FC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 06:42:54 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id br39so6460147qkb.8
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0p2VrnNYzGuxwf5p5WgiTf255cHPMcEdjBSDFIJxkd0=;
        b=ajnp/GgpGdcq0sD7AGvK+8PE9inOSlmolZr5yEQRIwxcyilB5wrLF9RO6RtVS5JNtO
         WeaSbfjwF0zmrgoIdjd/PpT1Dt7TVbhlVCCtzAyEk3Ud1RYDpSqZ4+V39oKHzL4pPmM7
         ggyA47zud9bIJh0qhProHtZkACLaW6Q6AS5a3brhz5K4EcUaqE/2O7a9zCqq2o4u5KjF
         Z4lojA5jgvKff9pQVkuD9GdSvb63DRGAGDbpPLpJP4OAOB+ToC4ZQn7qJRVNfbaxMq1G
         07Cgma2LI7frpoAPXmL900oBlH7JKV+8w4g+9z+GVVMs8zPxnHwDqGhmmPVt0gyjWC7M
         lFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0p2VrnNYzGuxwf5p5WgiTf255cHPMcEdjBSDFIJxkd0=;
        b=y38j7SdQCFJBxN8QERy4cYrqMrI666IoLoKO/yxUlLzW0Qf0MqfGFWsuxQ45NscbAU
         OnqaqWq39FSB/4et8fRpdmEp/Ixom510GpHEXuuqv9dQVqo2/MHIbDUkiSGueQgVVWHP
         BJttaGYQLKrlDhMVesxILNj7L+7qW8MeKtFDpki+f7TnvJ4JarucA5D0Yqd1DKNONNo3
         q8F8ZsiIlcIN46TeIMpGPtnzHZd5jn5vn2F96C0+kdXO94UiQajeZ8/5ykTPviCGJ2bi
         uyAUEYp594YbbY5N1X3J1Gqq7Pz14xb04TtP2T5pmAvpNDU/eTJvrTqbw0maPtIdLcyH
         Kyzw==
X-Gm-Message-State: AOAM531dzr73ihnEae206nlSa1msnzY3tFqheQW73hmc7BrYUk+PzpfN
        mUgMth3jNFqnQXQAgoUsH/bDdKKdHBo=
X-Google-Smtp-Source: ABdhPJyM8aXRKR2jWy97lO5LmuOj6Ucbk1+BDfXLmNgsQ4qdhiWQ+OKqSCqakCHbeU0dtZ6wkdbHSg==
X-Received: by 2002:a37:58c4:: with SMTP id m187mr29209953qkb.481.1635860573990;
        Tue, 02 Nov 2021 06:42:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d138:db8d:4df:dd6f? ([2600:1700:e72:80a0:d138:db8d:4df:dd6f])
        by smtp.gmail.com with ESMTPSA id o6sm13310097qta.2.2021.11.02.06.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 06:42:53 -0700 (PDT)
Message-ID: <2f1d2e09-faf5-0caf-6be8-7bcede9fe8d1@gmail.com>
Date:   Tue, 2 Nov 2021 09:42:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 04/13] dir: fix pattern matching on dirs
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        vdye@github.com, jrnieder@gmail.com
References: <kl6lzgqnv2dn.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq7ddr9z0i.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq7ddr9z0i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/1/2021 8:34 PM, Junio C Hamano wrote:
> Glen Choo <chooglen@google.com> writes:
> 
>> This patch changes the behavior of .gitignore such that directories are
>> now matched by prefix instead of matching exactly.

Thank you for pointing out an unintended consequence.

>> The failure that we observed is something like the following:
>>
>> In "a/.gitignore", we have the pattern "git/". We should expect that
>> "a/git/foo" to be ignored because "git/" should be matched exactly.
>> However, "a/git-foo/bar" is also ignored because "git-foo" matches the
>> prefix.
>>
>> I'll prepare a test case for this as soon as I figure out how to write
>> it..
> 
> FWIW, reverting this commit (and nothing else) from 'master' does not
> seem to break any test.  That does not necessarily mean much (it may
> be indicating a gap in the test coverage).

Hm. I definitely seemed confident in my commit message that this change
was important for a test I was introducing at some point. Let me revert
it in microsoft/git and see if our Scalar functional tests find an
issue.

In the meantime, I'll try to create a Git test that demonstrates a
problem one way or another.

Thanks,
-Stolee
