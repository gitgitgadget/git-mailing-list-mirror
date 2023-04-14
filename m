Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C644C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 13:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjDNNXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 09:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDNNXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 09:23:51 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C0A49CB
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 06:23:50 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id ec6so5286258oib.8
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 06:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681478630; x=1684070630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+Iqa+mkkrScysX0sSkxiJukJrdR8tn+b5pK29zR/7s=;
        b=Bl8VwiL2Kfab1Kk8H2EE+yY1EcwPhGHMsWrh9SK8yBJwXVsHb+jKRFDbEbWZaEF2aA
         zLFMnDDTdonpFUAYXJHaLN0KjAGXPMJ9cE2Yz5Tz+eYVJdvFjHx3MtgA3f746MRFAjfx
         pi+XNUcbiQAG/IeaNHL4/7W/sjHPbSCPGSlDuMuH3oP02Udbq6T+HuKlLGBOSZ1/Gm27
         AXXErb3jrF4yQNqfCi2dm6ldyIB3gJfIGnwUmqz8nFhWPLrGBD0o1KuUJQZem/cmXjk/
         RF0jOkykBTn0gSl7Q67/pqmTA9S9uX1B/uFSiveZs1xHggwZK+9Y3qLVMzlvyM+PM8pG
         1wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681478630; x=1684070630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+Iqa+mkkrScysX0sSkxiJukJrdR8tn+b5pK29zR/7s=;
        b=Flt11agBTNK43teuKaXmkNm72ZSxipUy+krlSsDmfXkNvl8PynpGnkY3CKDSdaPvSy
         qZn7bYFXlXpo8b5HYEawLKx97jtgoBcH+WQB75JpF0gdIv/UOkXSuMAXklj6UAZIMST9
         OtXwwcfO6LkzJqQ/JDVfTEBhhlykMRM6s/ZPj1CtvuGVmosyC+OHFUK87UcsCbPU4cVB
         6E5/swqfcLbNb1vK2q0Fi7eZUIAJSntMmyJu3WPj6XfZE9VSYP8mJkXsB196dEwtdqzn
         Lwqkbv8kFQFzwW3o/4b9RoRLsGBRRLv3mjFmHS/wKMqeCovuqAa1aK6iNhmdEzRtkU8Q
         Hqgw==
X-Gm-Message-State: AAQBX9d9aOfz4bru8TuN1T1SRLVmR7gba021NDC35MzITWiKIqkfxV8L
        fspfZ8oR3TP1JORWuG/37drca+kaFTXnQQzguQ==
X-Google-Smtp-Source: AKy350YzcLb7jT7v/lFLQ2iWv7vyDjrCaxN1oyfsCgAQBsNBGZQzhW/qCjIz4ETkilO4MIWEVh3d/A==
X-Received: by 2002:a05:6808:2798:b0:389:4ea4:7a40 with SMTP id es24-20020a056808279800b003894ea47a40mr2735348oib.6.1681478630056;
        Fri, 14 Apr 2023 06:23:50 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y62-20020aca3241000000b0038c233d05cbsm1366382oiy.47.2023.04.14.06.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 06:23:49 -0700 (PDT)
Message-ID: <15437c50-d3a1-1e34-b854-dc553e835cce@github.com>
Date:   Fri, 14 Apr 2023 09:23:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/10] repack: fix geometric repacking with
 gitalternates
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681452028.git.ps@pks.im>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1681452028.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2023 2:01 AM, Patrick Steinhardt wrote:
> Hi,
> 
> this is the fourth version of my patch series to fix geometric repacking
> with repositories connected to an alternate object database.
> 
> This version only addresses some issues with the tests, the actual logic
> remains untouched:
> 
>     - The test added in t7700-repack.sh that verifies that `--local`
>       causes us to disable generation of the bitmap index was failing in
>       the linux-TEST-vars CI job. This was because it sets
>       GIT_TEST_MULTI_PACK_INDEX=1, which causes us to disable the bitmap
>       logic in git-repack(1). I've fixed this failure by explicitly
>       overriding the environment variable like other tests in the same
>       file do.
> 
>     - I've converted path checks to use `test_path_is_missing` and
>       `test_path_is_file` instead of `test ! -f` and `test -f`.
> 
>     - I've fixed a typo in t7703-repack-geometric.sh and shifted code
>       around a bit to make the test more readable, following Derrick's
>       suggestion.

Thanks for these updates. I'm happy with v4.

-Stolee
