Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCBBC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AFD613E3
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhE1Ekm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 00:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhE1Ekm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 00:40:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B609C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 21:39:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5so1832209pjj.1
        for <git@vger.kernel.org>; Thu, 27 May 2021 21:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4MxlK/D16elbVS1UR45BGr3NhFPIedlhz/+Qbg6DgNI=;
        b=rshO8Y420QMzHnaBMgNX8kQqC5gdpKOZsjbmNVTwJ1D+b5PH5n2zbdlzbPZv9sjbfQ
         L/X5qmogYGgW1ObCabHLRxWJmEXUF9tih6BAX2hrB3hU/6fpQiEeilSZqIC0m2aib34x
         TTW9S9+0ActnFoIzqG71uN5LX9EN/iGN8iN1gIxN5fCCxiXUzx7JyopxuNYWI1yegfUv
         IbPU+HxM390jceJk4auj+kAQq7bVA1o/VQCGHrlPY78k0j58CFSqu6C9lJgt+Wppy3oc
         G124Urxv7NyzKKxylIoA3EWhXr8cIgeLU8y73l+B4iej0iuZK1qSI+to2yZ40zBgEW9p
         RfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4MxlK/D16elbVS1UR45BGr3NhFPIedlhz/+Qbg6DgNI=;
        b=JUPv1LS9hpBuMFRFBQkUTwDgw4utZ4f5BTH77ZB3YcNGoMlqwXlo2clgWpPiaCiGBZ
         HCkIiawKsJUsmDcXQsJsMPzBm/NEAUIIsTiG9zl/oaf7Za2U9kHS9ar6zu9ETtg2NlST
         XMg3nm4t3fJVr+uCxRGGs5Hno7q9S7VaxeHlrQVv32JsUM/SQfRYho8adYhrJ+QNaoVw
         q+6vrvMkAdtnVOeykTfCJLCdWvFqLs/JGSwEBxDgDTjFldui1fsbQVCACW4TcF8bOhna
         kFujJN35+MIP4D+VhxBlU7XkF+KObmoqkOP4vkfYZ5WhDmgvxPlefmH2fKlpkKuJGyQQ
         F69w==
X-Gm-Message-State: AOAM5300gNUu993iOQqX0WcXXKeGQStT2BmxvvR6+MGNSqE4W1mVnMMv
        UrIqNa/LGqqiZts/h9aFhFDuzbn+Ei6KTg==
X-Google-Smtp-Source: ABdhPJw3A88XiHqR5XSzSJ9ImmXsztPPYnjL0pK78ibJfOHGr6V9Uq6eP307j7V6oXq3joel7/jzGA==
X-Received: by 2002:a17:902:8645:b029:fd:25ef:3df7 with SMTP id y5-20020a1709028645b02900fd25ef3df7mr6317513plt.48.1622176747244;
        Thu, 27 May 2021 21:39:07 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-92.three.co.id. [180.214.233.92])
        by smtp.gmail.com with ESMTPSA id y194sm3111279pfb.193.2021.05.27.21.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 21:39:06 -0700 (PDT)
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
To:     Yuri <yuri@rawbw.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
 <xmqq35u9ax5j.fsf@gitster.g> <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
 <20210527045628.uvesihyhtqrfyfae@tb-raspi4>
 <YK+mWZP+sl3zXECx@coredump.intra.peff.net>
 <4dd22f16-72f0-a28a-8be0-aec622acf0d3@rawbw.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <50e2780a-21f3-499f-7960-76bf24f550f0@gmail.com>
Date:   Fri, 28 May 2021 11:39:03 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <4dd22f16-72f0-a28a-8be0-aec622acf0d3@rawbw.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/05/21 03.50, Yuri wrote:
> It's not clear from the conversation if git reads terminal capabilities 
> at all.
> 
> 
> But the default behavior, without any options set, should be to read 
> terminal capabilities, and write non-ASCII characters verbatim when 
> terminal supports this and escape them when terminal doesn't support them.
> 
> Current default behavior appears to be to always escape non-ASCII 
> characters.

So the current default is only supports ASCII, and escape other 
characters, right?

-- 
An old man doll... just what I always wanted! - Clara
