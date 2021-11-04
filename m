Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC4AC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B383561076
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhKDRW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbhKDRW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 13:22:57 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B165EC061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 10:20:19 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso9227308otv.3
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=20MIUWIc9wE49u6FVpehZH8fGmfwlWnSzQiTXCNdNVE=;
        b=bNRRr2m5eMRUrlHZN3BMO15+J43OW7GQOzB98NR3rO6oMkfCF2g/E7pY7H1xJC4aC+
         3fc4cU2jqCDQAxjRu2XGpuf0MCP+vCN7PCFg2r4BfY6VBss1Wpg4v/Cowv/I7jq9RKJF
         NCNz9di9vJXPWGLaiWWfjTnG6A3vce1z1WZa0LFxyhuGyz+eOC/2s1b7q/YJbJp5MIw+
         0T0ubLFwU4kIC8V9dqXRTDrudQx9KbKaAwdQCY4MUzZezlwvQ8wMF+mOAEibauLsb9Gm
         XWdc05dKMADFAnTXZhQr1vcOHdQniy8AxGUB0IKShZVvVwdEZxVjwxgqo2FrtWk9ehAZ
         HwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=20MIUWIc9wE49u6FVpehZH8fGmfwlWnSzQiTXCNdNVE=;
        b=7eC1XYonjDUSe3566mQ+yfdVCRRJhNziuwhDPZVbRe7pPZPxFTQvcBqs34VJgQSLmK
         heLoJ2jlpmZLGM2bv36vXW5GjZ4uacz3BcxejjWgoAb4ee/jRFv9ddphl4kh9iT+dVYx
         8tHdm28cuoq5wbBBElympporX9jjMxZ2yYOm4IFk3R7637tX0NztIb7G2DWZTVMYbN5/
         oT/0PslrVzRNqj+Clx3hL1qiw3/+WLBIKJNbnFO4Y0eB0vTK+rHYNKk6c4bMgexmk1O6
         BeTxZOhIkV4yahSC00ITtaS2/GD5Ksb3x/QOZ1rfZ3CIhIyXYxHgw2fvOMIwUIY8tUpi
         UXqg==
X-Gm-Message-State: AOAM530df7gq3a5ZhYOJKPOqItXzA+CPlvrL8KEUXsCZ+Cg+go1ej7nR
        FA4yj+esrEIMGhT0N6ydjkFo+3NmGZg=
X-Google-Smtp-Source: ABdhPJzaJeiUviUYNB8QBVFK5AhRDOkYB0WEYWlZtZRMaGhz0rJ+NL4pIw71qzInxd4OLV/8JIZZSw==
X-Received: by 2002:a9d:1927:: with SMTP id j39mr37732198ota.317.1636046417623;
        Thu, 04 Nov 2021 10:20:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e4fb:2d12:6454:4b36? ([2600:1700:e72:80a0:e4fb:2d12:6454:4b36])
        by smtp.gmail.com with ESMTPSA id y10sm1525456oti.40.2021.11.04.10.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 10:20:17 -0700 (PDT)
Message-ID: <9eb8fd45-c8a5-0320-6d38-56389bef193d@gmail.com>
Date:   Thu, 4 Nov 2021 13:20:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [Discussion] The architecture of Scalar (and others) within Git
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Victoria Dye <vdye@github.com>, Theodore Ts'o <tytso@mit.edu>
References: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com>
 <211029.86k0hww317.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211029.86k0hww317.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/28/2021 2:58 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 27 2021, Derrick Stolee wrote:
> 
>> I'm starting this discussion thread to create a new area to consider these
>> high-level concepts. Specifically: how should a new component like Scalar
>> be included in the Git codebase?

Thank you for your thoughts on this topic. I wanted to specifically
reply to a few items while the discussion continues to simmer.

> E.g. the scalar series is now at v6, but apparently it hasn't been
> noticed that some of the tests were broken on OSX due to apparent errors
> with launchctl integration. That's because the patches had the code
> compiled, but didn't run the tests.

These failures are due to changes to Git maintenance during the 2.34
cycle, and we've noticed and fixed them in microsoft/git as we rebased
on the release candidates.

This is one of the things that we expect with one extreme side of Git's
"ownership" of Scalar: things could break Scalar that we won't notice
until manually running the tests or taking upstream changes into our
fork, but then we will fix them. Right now, that fix would be in a
future iteration of the patch series.

>> [...]
>> **Option 1:** One-directional coupling in `contrib/scalar/`
>>
>> This option was our initial choice because it minimizes the responsibility
>> of the Git community. While `contrib/scalar/scalar.c` depends on code in
>> `libgit.a`, the implementation does not require that code to change to
>> accommodate the needs of Scalar. The test suite and documentation is
>> separate.
>>
>> This does mean that changes to `libgit.a` could break Scalar without any
>> feedback to the developer that has not compiled Scalar. The Scalar
>> maintainers would then need to watch for this and send separate updates to
>> Scalar that fix these dependency breaks. This reduces developer friction,
>> but might cause some extra burden on the Git maintainer. If these "catch
>> up to dependency breaks" updates happen only after a release candidate is
>> out, then maybe this isn't too much of a burden. We don't typically have
>> release candidates for minor releases, so there is some risk there that
>> minor releases could include breaks.
>>
>> If we make our CI builds include Scalar by default, then the previous
>> paragraph about developer friction is negated.
> 
> Without going into exhaustive detail I'll just note as above that much
> of this describes a state that's got little or nothing to do with the
> contrib/scalar/* patches on-list, which are thoroughly
> bi-bidirectionally integrated, build (but don't test) by default etc.

You're right that I am describing a theoretical extreme that is not
realized by the patch series in its current form. The extreme I'm
describing is where we could revert Scalar out of the Git codebase with
a simple 'rm -f contrib/scalar' and as minimal remaining work as possible.
Johannes relaxed that condition in an attempt to reduce duplication in the
Makefiles, but there is opportunity to redesign and get much closer to
this extreme, if that's the consensus we reach.

Thanks,
-Stolee
