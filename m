Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2131C2FC0E
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 09:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349273AbjHQJGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349321AbjHQJFq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 05:05:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF62D4F
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 02:05:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso75801635e9.1
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692263143; x=1692867943;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u0dKgJZAKp2S69INEM+ZXNL4BNX2su9B/wgRsSDqcUc=;
        b=hifMRi4hOo2n7JzOMSA3FQZEReXuNDElVU10PSI2BkgW9pUdRUS25h5UeOuzt1mhFm
         LprIqAPiLtHMzB907YTmF4iq2zBJzYYIcpRH4GBej908o/DkVTyVtyWevmT1z7BwFSXW
         2V/o1zM9ZxcDspm1b2H5v/iIhGQ6yzA2E/haim17mCvZ/jiI3IxZrvt2ixfhnHGNZass
         4c79bD0EuTb5iIV8uxxvl5WXuK42ZOJtLNwRt32CyruMBqdf4yE2E7Cd+78U5mQgCz4u
         3KDCx05lbAzf+2QKK+NmCm/dLx5ENts7o11bJkDWoKq5zBOr/5ZmRDg0Rl9YNY/EQbYO
         +AYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692263143; x=1692867943;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0dKgJZAKp2S69INEM+ZXNL4BNX2su9B/wgRsSDqcUc=;
        b=Lj6JLut04/stE3E+ZYsj4ZwNxndPYzMQLMB2Sfw8ajfsmR+9CQeG+FEK9UvXV617Ze
         dXU/g/gU9jHeyXKH6Fyv1KA8dsVh0OqDdhbogCBujnUs9plfDKySurXQqj16qcJYbG4X
         NWXE5cZdCEWZGdLqIJVlk9B/Vu734OAFqkzajqYonP/ffn42/jlHXlj5twLWN++EwNe7
         nCDTJHsucc75HSlE4M72rYAocUbLHDFitRdLihk31rGENF7Zkv6LgJiSwreqn9KYWF9L
         OazLLWdaHTCknDMIO2lceIfuFvm9Y6+M9G1fwCtbZ2YHd3d5Nil0GoU9SOYm3MGqGyjK
         n0Tg==
X-Gm-Message-State: AOJu0Yze7tyHKCPCDQq8PRGmVCU0mF3tFDo6jpOPNKKG977gqX8NH+LA
        WyAXQROyqwYlVB9ch87RHOk=
X-Google-Smtp-Source: AGHT+IGLdXRKTGDhbk5zGsS9nj/MIWRvNNBnsVKPLMitLhcJ/RWQVr9CRxPKlIh0pKy2KtuXXYbKkw==
X-Received: by 2002:a05:600c:3787:b0:3fe:4e4e:bee8 with SMTP id o7-20020a05600c378700b003fe4e4ebee8mr3485972wmr.2.1692263142551;
        Thu, 17 Aug 2023 02:05:42 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003fba2734f1esm2225103wmc.1.2023.08.17.02.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 02:05:41 -0700 (PDT)
Message-ID: <e4a91a8f-0157-4b75-b864-31e37741d9ac@gmail.com>
Date:   Thu, 17 Aug 2023 10:05:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5] unit tests: Add a project plan document
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org, linusa@google.com, calvinwan@google.com,
        gitster@pobox.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <c7dca1a805a16fd4fd68e86efeec97510e3ac4b8.1691449216.git.steadmon@google.com>
 <90651b2b-6a7a-2ed0-716a-fc87adc957ba@gmail.com>
 <ZNwCSdrbuG3K/iMP@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZNwCSdrbuG3K/iMP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josh

On 15/08/2023 23:55, Josh Steadmon wrote:
> On 2023.08.14 14:29, Phillip Wood wrote:
>> [...]

>> I don't have a strong preference for which harness we use so long as it
>> provides a way to (a) run tests that previously failed tests first and (b)
>> run slow tests first. I do have a strong preference for using the same
>> harness for both the unit tests and the integration tests so developers
>> don't have to learn two different tools. Unless there is a problem with
>> prove it would probably make sense just to keep using that as the project
>> test harness.
> 
> To be clear, it sounds like both of these can be done with `prove`
> (using the various --state settings) without any further support from
> our unit tests, right? 

Yes

> I see that we do have a "failed" target for
> re-running integration tests, but that relies on some test-lib.sh
> features that currently have no equivalent in the unit test framework.

Ooh, I didn't know about that, I think we could add something similar to 
the framework if we wanted.

> [...]
>> It sounds like we're getting to the point where we have pinned down our
>> requirements and the available alternatives well enough to make a decision.
> 
> Yes, v6 will include your TAP implementation (I assume you are still OK
> if I include your patch in this series?).

Yes that's fine. I'm about to go off the list for a couple of weeks, 
I'll take a proper look at v6 once I'm back.

Best Wishes

Phillip
