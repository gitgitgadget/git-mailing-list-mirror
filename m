Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE62AC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 10:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiLQKpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 05:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiLQKpO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 05:45:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A99EE1F
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 02:45:11 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m19so3389184wms.5
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 02:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2tZtJ1/4loyw+b/yDnETYsh7Xm2uZNE5H/c6i2giEI=;
        b=EZIEerM1YlUoumDC5WpTHi4tHs2kReXdXYzCH2/eDrwBq96EvYcPYeCcFgzOVsp0YS
         kF+6udazBsJ1n5M2U49b+U5ge7TpN5xSRAwLcv/Vasd9+bJyTB5QhoIzEA3Gt5wwkbx7
         wBhbXx514xxVPuHrJ56NWMcz50ZlG7R5J8j8t987KRcPx/vDhnkq5mil0XchacHeXYzL
         D1Hb+v2SHMei+8L0RF//caHvR/dOPpURqIzZ13zUk7T3t7MxFWFX9jn+bw4SycrZ/8Ah
         lK28NgH2YfZ0Y8BPlhPHh/m28FguHZuyJd6kUAg0+iMUcTCCm8Gb9Iumzw2HhV4Rzv+l
         AQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2tZtJ1/4loyw+b/yDnETYsh7Xm2uZNE5H/c6i2giEI=;
        b=bD0CRTcrW5zbJU+9lfnDPcvcBbMOtpzy2+vBRJ+Rfl6od3nhXajBwusNC7UGv5iXHZ
         mnE33wm1xHzbaMvdXoV5ZgrXplf8uw3LKzI7+Rc1+t1kLNszAtdoqBx8PIVaUXRtlr96
         sz6DPuJCDHgdetn41NxS+9c8To9F8ublunRAXhtIIPp/K1cKiYd4YIu2vgsko9DX7Y2w
         r6aSu2zJsCIyYHnGrZe+D1u0sCOQTm91Ebot/9kw4kRllEycxi1DEN2zmyx7Ed/JuoVu
         ecAjOEyL7UBRK2FxaxRF/Ix7E4ZCjg/1AtALonwPoExlLs1MB9SxPwo9rYbYj/8LutLZ
         5JIw==
X-Gm-Message-State: ANoB5plIH8KGi9If5OnnuZP17LrA4L7jFDvE7lZCWWHO0wonsMhowthJ
        3b4OymeMQKdUo7n/65z24K+WDchCK1k=
X-Google-Smtp-Source: AA0mqf7J++P3eJFyRL1LPrtzNMZU8lIrdLtVMJ/vlh2SH3n8UHsGO/BaUEb4rzazlu8rz0vXjyGIXQ==
X-Received: by 2002:a05:600c:1c0d:b0:3d2:3d7b:6115 with SMTP id j13-20020a05600c1c0d00b003d23d7b6115mr9872400wms.7.1671273910057;
        Sat, 17 Dec 2022 02:45:10 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c1d8d00b003d01b84e9b2sm5609086wms.27.2022.12.17.02.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 02:45:09 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a6476204-4837-a34e-67ea-74cb9255daf5@dunelm.org.uk>
Date:   Sat, 17 Dec 2022 10:45:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Strange "git stash pop" conflict (one chunk out of many)
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
References: <639B074B020000A100050792@gwsmtp.uni-regensburg.de>
 <ced6bacc-3d77-4d24-33f3-a93d2ae7a131@gmail.com>
In-Reply-To: <ced6bacc-3d77-4d24-33f3-a93d2ae7a131@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/12/2022 01:58, Bagas Sanjaya wrote:
> On 12/15/22 18:38, Ulrich Windl wrote:
>> Here is how the conflict looks (to me both variants seem identical):
>>
>>          # pre-allocate translations and accesskeys
>> <<<<<<< Updated upstream
>>          foreach my $attr (LD_SEARCH_ATTR) {
>>              $attr{$attr} = [translate_attr($attr), undef];
>>              $attr{$attr}->[1] = add_access_key($aks, 0, $attr{$attr}->[0]);
>>          }
>>          foreach my $attr (LD_SEARCH_ATTR) {
>> =======
>>          foreach my $attr (LD_SEARCH_ATTR) {
>>              $attr{$attr} = [translate_attr($attr), undef];
>>              $attr{$attr}->[1] = add_access_key($aks, 0, $attr{$attr}->[0]);
>>          }
>>          foreach my $attr (LD_SEARCH_ATTR) {
>>>>>>>>> Stashed changes
>>              @n = (P_P_SRCH_ATTR . $attr, @{$attr{$attr}});
>>
> 
> Both sides are identical? You can freely choose either side...

But if both sides are identical then there should not be a conflict - 
that is what Ulrich is asking about I think.

Best Wishes

Phillip
