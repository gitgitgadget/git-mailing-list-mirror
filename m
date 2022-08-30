Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268CBECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 15:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiH3PWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiH3PWP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 11:22:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A583B7EFE
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 08:22:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v16so11962047wrm.8
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=2b0kGySp0fGsX6KA7kT7XWW1yd9vyCd3DmlBRx1tZfE=;
        b=kmijdV8iENNMiDxscww2TYZdR5oZ2O4mgLaD+VXV71bBzK8cParsdv0NvdAPmzIVS2
         T7bxBD81MplwplfUC1l3153dCefZ9NgO9dnu5QG998m8uPaGK2ESlpJQ014I/gL6O2K4
         UobRW/hXRlnrEr9/WcvXeGE2d88Yhl5MckFYklqh8jgjmouKfxaJUSaTBH6/Dfy+98ni
         V3uIQc43rVogBPwoH1/yoPD+o7a82M0w+pb5lnuYm7S29kzWQMko/IEiRBzxkuI49OtH
         oHzHaXZW1Z9pucbVzAevqEt8qbXJDbcNAAnwzLKGGhh+xalIu7NQWSCy56gAXTgt8Tso
         AVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=2b0kGySp0fGsX6KA7kT7XWW1yd9vyCd3DmlBRx1tZfE=;
        b=MxgA3RXqOVzdevcShrck9HCRB3hRQrrNT9wRo8gPXzvHkxP4pHsA/nqPxB7DFvkVtL
         8ECkNQ2Kh1ZttzHGoCRbuYKBEe7HTvYF5MZl/ymxF55hWEuoGYp62Zgk+uDz/UZLpSLf
         cqdNohMT7d9q0cDSeHuom/pem4H7JfCjxl5X7MBMNZTc2haOOrwYDe7XLCpQQM5Hi5Ne
         UtR5LPstpICWkh1htVgnRP2QebjqOeRyyWzOzZ4NUGcZeLYut21GAc1GMwlb3i9B/22K
         GBzRQE+IqY8IMayTR1Eg/XV7Y/tHWPHX2Ip9xE/n7T7PcV9cgkMTNyzxxP4L/ev0K35I
         gakw==
X-Gm-Message-State: ACgBeo2baE97tDtUEHayaVmlxi5M492Gfq2bGEp6PAIqEInLUtNz1ufw
        cBRyjuK3dqeT5BIrgCLAE8w=
X-Google-Smtp-Source: AA6agR713s08XMWN4W1X0liL8FQvbjDX4NwXWhci4O5Ry/D8rOaX91MXgJMPn3rG45jCWQujTloCHg==
X-Received: by 2002:adf:f647:0:b0:226:1c05:933a with SMTP id x7-20020adff647000000b002261c05933amr8943973wrp.121.1661872924175;
        Tue, 30 Aug 2022 08:22:04 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id p18-20020a056000019200b00226d13a25c7sm9686705wrx.17.2022.08.30.08.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 08:22:03 -0700 (PDT)
Message-ID: <dc48ce59-530e-da74-93ad-9eb4a17e391c@gmail.com>
Date:   Tue, 30 Aug 2022 16:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: validating signed/unsigned comparisons with Coccinelle, was Re:
 [PATCH 0/3] A couple of CI fixes regarding the built-in add --patch
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
 <p9p431r8-nq64-02sq-3049-n10rrn1o89o7@tzk.qr>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <p9p431r8-nq64-02sq-3049-n10rrn1o89o7@tzk.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 30/08/2022 15:19, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 30 Aug 2022, Johannes Schindelin via GitGitGadget wrote:
> 
>> Note: This patch series is based on ds/github-actions-use-newer-ubuntu (but
>> probably applies cleanly even on maint) because I tried to develop a
>> semantic patch to fix similar issues in the code base. However, I've since
>> run into what looks like a bug in Coccinelle
>> [https://github.com/coccinelle/coccinelle/issues/284]. My latest version of
>> that semantic patch looks like this, but I stopped when running it on Git's
>> source code triggered the bug for 66 of Git's .c files:
>>
>> @@
>> type T = { unsigned int };
>> T:n b;
>> type S != { unsigned int, size_t };
>> S s;
>> binary operator o != { &&, || };
>> @@
>> -s o b
>> +s o (S)b
>>
>> @@
>> type T = { unsigned int };
>> T:n b;
>> type S != { unsigned int, size_t };
>> S s;
>> binary operator o != { &&, || };
>> @@
>> -b o s
>> +(S)b o s
> 
> The bug in Coccinelle is already fixed (are you impressed? I certainly
> am at the incredible speed and at the wonderful conversation I had!), and
> I verified with this semantic patch that our code is clean:

Wow that's fast, I wonder if they would be interested in fixing the 
parsing bug we found with Peff's UNUSED() series. It's good news that 
the patch does not find any other problems.

Best Wishes

Phillip

> 
> -- snip --
> @@
> type T = { unsigned int };
> T:n b;
> type S != { unsigned int, size_t, float, double };
> S s;
> binary operator o != { &&, || };
> @@
>   s o
> -b
> +(S)b
> 
> @@
> type T = { unsigned int };
> T:n b;
> type S != { unsigned int, size_t, float, double };
> S s;
> binary operator o != { &&, || };
> @@
> -b
> +(S)b
>   o s
> -- snap --
> 
> I do not currently plan on integrating this into `contrib/coccinelle/`,
> though, because it will take a while until we can benefit from the fix in
> Git's CI/PR runs.
> 
> Ciao,
> Dscho
