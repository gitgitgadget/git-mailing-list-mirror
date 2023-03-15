Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E976AC61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 13:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjCONyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjCONyg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 09:54:36 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C02CC6C
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 06:54:33 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so449487oti.13
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678888472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=roah1uN7P+xAJCPKKB67PqDbtT6d7jwdjeCfj3eqVVI=;
        b=U3HzLxXyemFN8AsBqQDUyv/jmSU3BQ/c8XH64DnpRAsV/+xZXHc7xSxssIQF2ZbPQP
         eJ2KRNKMNgY9hAfWW/UzHcTN4u9rG2iKzxCK/zX9hQDYXdNMQEztOdq58WUMNJbJRe13
         rjOUdza3Y3cBvzISZBEtfePSHIqBMwB278GVzjUmGMSEzhwDQH6sjUsFv5kBYk6ZRo8F
         wnH7h0THIfgBAK4zq4DqTH3OBrW9POayUnhEZlTzgAv7mnV4/x31iF7uUHMaV83QUAE3
         gAhv3Uxc4aP0SKdXrPareva0rkzQDKrmKKptXw/OyrzVNcSe8vI1TcSsOONF/9wkrxy8
         EEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=roah1uN7P+xAJCPKKB67PqDbtT6d7jwdjeCfj3eqVVI=;
        b=jYehcMI2tuXpnTx5Z3bbk8bn4az3emIEAOyhRbEFz1PDxAmOhwnosbPXxfpT7BSIRn
         rWSwwXi9nTSyfF4euhPIsfFsziNIGxqZ6kF7NXxzCmiM1cQh6m6t00uVyaA49DzIi2LQ
         K+YFvfdWb5ETlELMh5Z5pERyrnV95uIypgK6+WSIZMkGvhzH6xEhoBzIKMZrHZmdv60F
         khsE5ip/6aNk9w/SADuUw3zbCt8aSe1cyApwDAisKvt5rSw/jimvjNVVS102YyxWQxG3
         N3Ux7L7tPbXSbYUTjLr98LlaukOUzKvcFM0MLBATdxOFbuogEOWw9i+SF94JsEpO/Npo
         XaGA==
X-Gm-Message-State: AO0yUKU6vLKpFvD53VJ2fMtygZg8BKPYr0l2kFlg7qxc/JQhtR/5tmOP
        RADYmghngvJEszuptBCQOLT6
X-Google-Smtp-Source: AK7set8S7QU7o3CCCOsCfm6E36nIRUY+g6OPcRJYUGjQs4CNbRhfFP/4wPPeK0HSF4Um9sTKKHlTaw==
X-Received: by 2002:a9d:178:0:b0:699:dc4a:1b35 with SMTP id 111-20020a9d0178000000b00699dc4a1b35mr1224324otu.18.1678888472503;
        Wed, 15 Mar 2023 06:54:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b4dd:42a2:285c:8312? ([2600:1700:e72:80a0:b4dd:42a2:285c:8312])
        by smtp.gmail.com with ESMTPSA id p129-20020a4a4887000000b00524fe20aee5sm2193877ooa.34.2023.03.15.06.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 06:54:32 -0700 (PDT)
Message-ID: <bfade752-6468-95a8-433b-44dc1d13413d@github.com>
Date:   Wed, 15 Mar 2023 09:54:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/8] ref-filter: ahead/behind counting, faster --merged
 option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Jeff King <peff@peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <230315.86lejyxi13.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <230315.86lejyxi13.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2023 9:22 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 10 2023, Derrick Stolee via GitGitGadget wrote:
> 
>> At $DAYJOB, we have used a custom 'ahead-behind' builtin in our fork of Git
>> for lots of reasons. The main goal of the builtin is to compare multiple
>> references against a common base reference. The comparison is number of
>> commits that are in each side of the symmtric difference of their reachable
>> sets. A commit C is "ahead" of a commit B by the number of commits in B..C
>> (reachable from C but not reachable from B). Similarly, the commit C is
>> "behind" the commit B by the number of commits in C..B (reachable from B but
>> not reachable from C).
> 
> I have a local change to get rid of the various "the_repository" macros,
> which a merge of this in "seen" conflicted with (semantically).

Thanks for doing that important refactoring.
 
> The below patch on top of "seen" will fix it, could you please squash it
> in in the appropriate places?

Got it. Thanks. v3 will arrive later today with those changes and
the recommended strvec changes.

Thanks,
-Stolee
