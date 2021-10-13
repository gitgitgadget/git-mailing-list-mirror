Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6DCC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7BB5610EA
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhJMNHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhJMNHP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:07:15 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17230C061746
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:05:12 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id m67so3723252oif.6
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LMXhv4BKo0159+XPcHcPq56VFs4g1DmLDCMvDkaDKKE=;
        b=M9B3UjUzFDTyOWKmer0AOs14tCzQAFw//Bw0sVZB48S/kRV8ddiRIjGjoV4Nohc/aO
         uuHRIou03OuhDT4vgiXU2GYAnU4k3/WwIek8+4pFE3qhL5B8zWWjrf8YFHdkfEuk/Bs4
         vF97C6q7OYkGr4roqGoQgFh0F5WQdyxmOapxSiAaOBMzkfIqFbjqlrYjUtmIEEVUeyR5
         ZVVv0XJq4+ePD+adhCVxRBTIVL12LhhdYMK02zjezQvIiyjM0uFvBvykl8OB3mGSUvAL
         dQe4wZEYZzSfvnbvrcHhigsMJPek6uTTnc/rhI3p2k/elbhOcFU+FaV+ht48jarXPgq+
         2iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LMXhv4BKo0159+XPcHcPq56VFs4g1DmLDCMvDkaDKKE=;
        b=oeai/Amkli59AjWfjN1s7pI9ujIaqUpBYkZfr4Uz9bVhyujFYJwlFhm8bNcOSCcKUp
         VHwPTkjnLfl8czW+pmGpzR/fslnL4sJzqCpzlw5H1uPdvdKSOcmdpgwLrsb0j0WUeU6Y
         CNNq1XFkXZh0IrRpOA/6oq86xvqz39pCcnfZj8YTLu2slehkjtXbL/Efxs3Tb6GivB9r
         229XWubvM3dKROOaO8zEcOqLKQJ0cElSt30uEJ5PRjVzTu4WcQcSWkFby89emKJq6RqG
         ZFE2Gl/uUA7be2WezljRhLnDxvkmHoN6Zvg2+chiWUEIwo2jfsiGFyt7/1SBePatroOV
         dxLQ==
X-Gm-Message-State: AOAM532+aKI9u0V5MB//uoaFU8GU+W3JeQjygZ9/6zg4UAtryqqaJOuJ
        1V/mCNDWIadqfkzQPMVkB58=
X-Google-Smtp-Source: ABdhPJwb2u0I6Z+qos59nrykhAVI8I4/umLOnN2n43XcIdP1JnaGca9qGKQ6Rm2ir4aBDv4Tv7p9FQ==
X-Received: by 2002:a05:6808:22a3:: with SMTP id bo35mr8313305oib.66.1634130311301;
        Wed, 13 Oct 2021 06:05:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4c86:317:426a:54d0? ([2600:1700:e72:80a0:4c86:317:426a:54d0])
        by smtp.gmail.com with ESMTPSA id k6sm2953502otf.80.2021.10.13.06.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 06:05:10 -0700 (PDT)
Message-ID: <d643863c-7683-fe4b-e4f2-3fefc475006b@gmail.com>
Date:   Wed, 13 Oct 2021 09:05:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: test-lib.sh musings: test_expect_failure considered harmful
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>,
        Elijah Newren <newren@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <87tuhmk19c.fsf@evledraar.gmail.com> <xmqq4k9m6vkw.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq4k9m6vkw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2021 12:45 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>> On Mon, Oct 11 2021, Junio C Hamano wrote:
>>
>> [Removed "In-reply-to: <xmqq5yu3b80j.fsf@gitster.g>" with the Subject
>> change]
> 
> Please do not do the former, although it is welcome to change Subject.
> 
>> Presumably with test_expect_failure.
>>
>> I'll change it, in this case we'd end up with a test_expect_success at
>> the end, so it doesn't matter much & I don't care.
> 
> I do agree with you that compared to expect_success, which requires
> _all_ steps to succeed, so an failure in any of its steps is
> immediately noticeable, it is harder to write and keep
> expect_failure useful, because it is not like we are happy to see
> any failure in any step.  We do not expect a failure in many
> preparation and conclusion steps in the &&-chain in expect_failure
> block, and we consider it is an error if these steps fail.  We only
> want to mark only a single step to exhibit an expected but undesirable
> behaviour.
> 
> But even with the shortcomings of expect_failure, it still is much
> better than claiming that we expect a bogus outcome.
> 
> Improving the shortcomings of expect_failure would be a much better
> use of our time than advocating an abuse of expect_sucess, I would
> think.

I agree that test_expect_failure has these drawbacks. I've recently
been using _expect_success to document "bad" behavior so we can verify
that behavior changes when that behavior is fixed. But it does have
the drawback of looking like we claim the result is by design.

One possible way to correct this is to create a "test_expected_failure"
helper that could be placed on the step(s) of the &&-chain that are
expected to fail. The helper could set some variable to true if the
failure is hit, and false otherwise. It can also convert a failure
into a positive result. Then, test_expect_failure could look for that
variable's value (after verifying that the &&-chain returns success)
to show that all expected failures completed correctly.

This could have the side-effect of having a "fixed" test_expect_failure
show as a failed test, not a "TODO" message.

Thanks,
-Stolee
