Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5370CC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 14:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjDRO2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjDRO2B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 10:28:01 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5588A270
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:27:59 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id n17so2204955ybq.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681828079; x=1684420079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NW1FW/+RQsU7okP47BHcgDwnoMeBrx18FfHy/m+4gh8=;
        b=ZqM2LX4thEcq41SrXKP/ojg+ZGu67nQYpVYc/xEibmVleTYcPPmf3MXANcGqxU8IYw
         jsXq9pBTQcS+2kVcwbNyw+TtPnfoxhsnGfds4GTIT3q2YyTDorbB7GCiks+HQj2SvNWy
         LXwgO2Pyi2BnnyUbs9cY4/bHzFw2oQU2aROdY6GJgIbp/05QrHIm64npS+Ww9y42w5Kk
         woiqX8WKfO26MGi8ep5rdgAKTZmSkxSOv8VOJub9quq2jx6QuyKqneA/kQw7ErDerkDM
         82r4TejEEjIb6y4hoCbvUZAsy77qkTFgQZWR66gicOzElWx8izyObGU6qSFltJgCRxm7
         qAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681828079; x=1684420079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NW1FW/+RQsU7okP47BHcgDwnoMeBrx18FfHy/m+4gh8=;
        b=BBtjw4KK6FBGpzli3AkrREyv9+HOSVPeEJ6VNMpsz3ECPFlqfS3cVru2B6QF5Ap72s
         ebfrTHchDwf2ceboDXJEcE7od0A1K+YG1qiOAeKCPzmCgQ/h+i9ndeHicC7Es3J8CxUe
         nd/VfdW9CJdRV+zlxEnciYUKozyuKvxS0TJ/YlLYbtZuFc/zkPH23iBNO1HKx4hr5S7b
         s7d50G+i8euxtFgV2UG4YyZ3nyQakDnMfAyqhwXr2w3E59WUKuTqJUf57VugbmyHFzP8
         lfX35iMRCdt8Q+s9o7TnUIjGH9aI6TK/Hc8jNHdpxLHWLWMZcsWYqfoiIjw5/X5jVcQx
         vHWw==
X-Gm-Message-State: AAQBX9d3XH9gLlhNdHvVVc71RgqKo9PQnPrJ01JI/haLAynizeRcFkY1
        1HF58J17Oy7kShTkPR8n6MVEHolZFZPHG7sWAg==
X-Google-Smtp-Source: AKy350axtwkjUa7Uu3jpsU2BF0q8b1WWIewviS3q1tWx7Jel+anLshQ3T9cSOmiorOP9vDgjNf8MLQ==
X-Received: by 2002:a05:6902:18cc:b0:b8e:ddde:200a with SMTP id ck12-20020a05690218cc00b00b8eddde200amr19169462ybb.28.1681828078824;
        Tue, 18 Apr 2023 07:27:58 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f188-20020a256ac5000000b00b923f7a98a9sm1811038ybc.7.2023.04.18.07.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 07:27:58 -0700 (PDT)
Message-ID: <2628249e-fe9a-d15c-5414-33d815b35cd1@github.com>
Date:   Tue, 18 Apr 2023 10:27:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] fsck: check rev-index checksums
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
 <7db4ec3e327ed3695f4f5409cb2dc80c72688758.1681748502.git.gitgitgadget@gmail.com>
 <ZD3HI/LIXVv6Pacn@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZD3HI/LIXVv6Pacn@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/17/2023 6:24 PM, Taylor Blau wrote:
> On Mon, Apr 17, 2023 at 04:21:39PM +0000, Derrick Stolee via GitGitGadget wrote:

>> +test_expect_success 'set up rev-index corruption tests' '
> 
> s/set up/setup for easy `--run`-ing (e.g., ./t5325-*.sh --run=setup,fsck).

Makes sense.

>> +test_expect_success 'fsck catches invalid checksum' '
>> +	revfile=$(ls corrupt/.git/objects/pack/pack-*.rev) &&
> 
> Would this test be tighter if we introduced a sub-shell and cd'd into
> "corrupt" here?

corrupt_rev_and_verify does the subshell thing. Why should we do that
here in the test?
 
>> +	orig_size=$(wc -c <$revfile) &&
> 
> I'm nitpicking, but we may want to use `test_file_size` here instead of
> `wc -c`. The latter outnumbers the former in terms of number of uses,
> but I think we consider `test_file_size` to be canonical these days.

Makes sense.

Thanks,
-Stolee
