Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304B1C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E1920797
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQi6h0dD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgKKUsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKKUsH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:48:07 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE838C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:48:05 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id n63so2356248qte.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sr/XCOcObO2CVBb09AL+M3azC0ocv+0oGM6vL+HrHIg=;
        b=IQi6h0dD96z0iu5R2UlkB723wiZpd9Qu5PKTtuwog9BoEagI6yv0Mn9B7tqAkczj39
         VTZ8md5AKcg2O5SiVz0VHj6ItDqEC9ReXCNyzFoQi/YIy/8HpFGY3pPq8z+LqT7/4t0v
         vh0CouU6Tukp10VVY4iWLOsAV2OFbKGzuubC6BDGV2oTZsBsKueVmnqH2Yg+4IZcTx9z
         gTJIavRNS2Dt8jiPcRjRSjVw5A2PchR7bfHpBvfDwKYrln0zG9P2l9+bWr2g3h6+sKfr
         JGy69EU52ACJ8Ejlg7Ren70ivbCrElUhzaVSnDDUZBpogDXeMHDvbJXLyDe7Clv0I90q
         wFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sr/XCOcObO2CVBb09AL+M3azC0ocv+0oGM6vL+HrHIg=;
        b=WbAjPpKA9DNVxLPWmlr2AkQIfMU4uDprgUMXjRLxA2/8DuhXUmfdwLDmyf8uQ8PbZ2
         1AHnt0A0w0ccwG/SCn4zN8TKd5noRNuxE7vAQPz1PeiX1kLqxBN/vMJpZemDmYJpHTuF
         W1cboFDpmX0zyWs15D8GwlSruwwcMoJHKvEsnMWdoz8IEbSy7xYZP8FklTpnICVohRjf
         gkTeGlY9jHXpJ8wwbC58EQrDre1l3UEn+yEzGl3HjOYqPjC4NQ8791wlOMJnHJ8pqEQT
         vagOzP4237DrNWJxskQQB1TEErEAbQi8OHiJc/nAdvzvVK8TNfySi3XGkWKKU+dGQukQ
         Tn9g==
X-Gm-Message-State: AOAM5319UIjGhlxVaEH9BWqMDOz01THJNsGIUS1pBTD91sX6NEjhIaDR
        UC0a2dEtif59aGuUvoV1Q++cquHOtPH4Bg==
X-Google-Smtp-Source: ABdhPJweBwPYh5ne6bH6DoEYym67kitpzmR/oksBCf5Dph8H4Bi349IsYEvckFlncCFnU+PzMF7kFg==
X-Received: by 2002:ac8:641:: with SMTP id e1mr19995416qth.226.1605127684124;
        Wed, 11 Nov 2020 12:48:04 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id h4sm3417200qkh.93.2020.11.11.12.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 12:48:03 -0800 (PST)
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20201102204344.342633-1-newren@gmail.com>
 <75170ee7-525e-31fc-f6bd-6dfac12b00c8@gmail.com>
 <CABPp-BF=+-ieP8fCxWWuvhe2dTTMKVGnYSTJuV6H9Z+zYs0SNg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e3fcaead-8bee-bcda-aee0-459ad9774f9e@gmail.com>
Date:   Wed, 11 Nov 2020 15:48:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF=+-ieP8fCxWWuvhe2dTTMKVGnYSTJuV6H9Z+zYs0SNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2020 1:35 PM, Elijah Newren wrote:
> On Wed, Nov 11, 2020 at 9:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>> For the series as a whole I'd love to see at least one test that
>> demonstrates that this code does something, if even only for a very
>> narrow case.
>>
>> There's a lot of code being moved here, and it would be nice to have
>> even a very simple test case that can check that we didn't leave any
>> important die("not implemented") calls lying around or worse accessing
>> an uninitialized pointer or something.
> 
> We absolutely left several die("not implemented") calls lying around.
> The series was long enough at 20 patches; reviewers lose steam at 10
> (at least both you and Jonathan have), so maybe I should have left
> even more in there as an attempt to split up this series more.
> 
> However, if you run the testsuite with GIT_TEST_MERGE_ALGORITHM=ort,
> then this series drops the number of failures in the testsuite from
> around 2200, down to 1500.  So, there's about 700 testcases for you.

Sorry that I'm jumping in to the series-of-series in the middle, so
I am unfamiliar with the previous progress and testing strategy. This
"number of test failures" metric is sufficient to demonstrate the
progress provided in this series. Perhaps it was even in your v1 cover
letter.

Thanks,
-Stolee

