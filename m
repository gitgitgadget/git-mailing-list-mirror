Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7D1C77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 15:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbjDZPAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjDZPAS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 11:00:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF08AA1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:00:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f18dacd392so44785585e9.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682521216; x=1685113216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qj66YmFkfqRIdoDTy97+9D6sx+UhqwLAHRrYH5jhA0=;
        b=W15Ns2jIfXavvBwhS+FEUWH63ykFyt+ZMXHEHRrZlLKAjxnOD1QuEgFMX6a59w8sMn
         HkPI5f4zh0f0Gw1dFsOr2glxqaZaAT2B6iyXI5bHHJy6hemq8N08qZc6DVwVrrhkNPWd
         cUyamGNiHN2aFz6uT0z2hp6TnuqPAlWhLemqSPObkuWN5ogfBXq2VYoKsJzHZ786oNqk
         E5x10g3BEQ7E7uQyteDJYiSzSb+ONiFMWpS/e1a6fyFdZ+eOOepe+3GhwwnHVPA6lbIN
         4g8AdJZAIbmnmL5XuS7hjk/TouThP7+bKHwXCZISAZdamjwwRaF587xCzxyLrRD/FruF
         j8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682521216; x=1685113216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Qj66YmFkfqRIdoDTy97+9D6sx+UhqwLAHRrYH5jhA0=;
        b=TZtmPAAoZ3JaRecCOSQ7LRTRNd8G14rU1RmyWmOqOuwqxzetnR6xJStW/Arf8R+JFI
         xW3cOl44Mkj1IAPwOPJDefaCwpi2PFWs6WuJTxb/NQ6al+XRbU9cxpsq4ucJMe1PttzU
         Lo3u4As0bxcQXWmjcPIR7fc/vOuRhRWI8ZtKVmqGwfg4iTZpjyJT+eYUcRBecbrXMaqn
         7mOJIvk5v52xC2vq5dTBKzV6wTiq2EfZ8WiuQSY0+9L45RuB4hqxzf13myJyiLAvqD60
         OQVBQ2roDvVV0aTlJkiucwSxY0UTsJ1fFZUzbkUX/RkwDeiXAo1yA5GuJyNfyX9KqKxq
         VG0g==
X-Gm-Message-State: AAQBX9fcQ/9o6k29CEpj/LkfCBRZq3o5tmLjRNYj73iGjBoec+ZFgLcV
        EF0s4Wr2UDflBdsc5hYEoF0=
X-Google-Smtp-Source: AKy350ZDw9ocJ18nxIw6k13JugH3XWxzHRLCVBeaW2hsy8/xhWV5ZrkT8On2ud1M5+XEMEBRmLKZOw==
X-Received: by 2002:a05:600c:3794:b0:3f0:a785:f0e0 with SMTP id o20-20020a05600c379400b003f0a785f0e0mr12247375wmr.40.1682521215616;
        Wed, 26 Apr 2023 08:00:15 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b003eddc6aa5fasm17963875wmb.39.2023.04.26.08.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 08:00:15 -0700 (PDT)
Message-ID: <bf10fce3-b4bc-e5db-e2c0-651d70a8a1c8@gmail.com>
Date:   Wed, 26 Apr 2023 16:00:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] developer: remove gcc 12 workaround
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
References: <20230426013428.53206-1-carenas@gmail.com>
 <CAPig+cSN=DYXuCmO4-ewN20mibqH7o+zESDbwXG8c0QW0TVVrA@mail.gmail.com>
 <CAPUEspgqGFHg-a2gZ+j6pRLQSZwVuVR9Sq3j3yvcK1LtAi1VHQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPUEspgqGFHg-a2gZ+j6pRLQSZwVuVR9Sq3j3yvcK1LtAi1VHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 26/04/2023 07:41, Carlo Arenas wrote:
> On Tue, Apr 25, 2023 at 8:45 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> On Tue, Apr 25, 2023 at 9:47 PM Carlo Marcelo Arenas Belón
>> <carenas@gmail.com> wrote:
>>> Since 846a29afb0 (config.mak.dev: workaround gcc 12 bug affecting
>>> "pedantic" CI job, 2022-04-15), DEVELOPER mode has this workaround
>>> for the version of gcc that was released with Fedora 36.
>>>
>>> That version of Fedora is about to be EOL and latest versions of
>>> the compiler don't have that bug anymore, so remove the workaround.
>>>
>>> Tested not to trigger with latest gcc packages from the last 3
>>> Fedora releases, including gcc 13 from Fedora 38.
>>
>> The commit message doesn't explain the benefit of removing this
>> workaround. Is it because it's a maintenance burden? Or is it
>> preventing some future planned improvement in this area?
> 
> The workaround was added for the benefit of the CI and to prevent
> failures because the buggy warning will otherwise make it fail because
> of -Werror when Fedora 36 was released and our CI started using it.
> 
> Our CI doesn't need it anymore to avoid that issue.

Our CI may not need it but what users of other distributions using gcc 
12? The link[1] in the commit message for 846a29afb0 suggests that 
debian was also affected at that time so the bug was not a fedora 
specific. We could perhaps tighten the check if we know which specific 
versions of gcc 12 are affected but it is not clear that removing it 
entirely is a good idea.

Best Wishes

Phillip

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2075786

>> What is the
>> justification for penalizing users who might be stuck on Fedora 36 for
>> some reason or another?
> 
> I certainly didn't intend on penalizing any users, but I frankly
> suspect there aren't any, as the bug was fixed long ago, and it
> wouldn't affect them unless no gcc updates were ever done on their
> systems.
> 
> Carlo
