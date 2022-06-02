Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56A0C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 14:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiFBOYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiFBOYW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 10:24:22 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84BA1A7
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 07:24:21 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n145so4949121iod.3
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QphnEX1yCm3h/zKEhJXwhDrzy5Vg6Hw5YMC8OA5f7R0=;
        b=gOlujCoxRRNFCLldtUMsqc9VnnuzZO4P0lfJ74+x7kCL4arQViJPfX5orNyHOLtiXp
         i21BpFDOesA+lkQRBwJSDGXg/cRtNoCeeVz6ihr43pTWZPHSc3m3UEbLPV5tO6P6hXOO
         sweDbLzKlN+I5gOpJ4BK/VD/1LyhmxW9NoIPh4wkz6vqD/NqH2csHnLu1B22CxrBdfq9
         KvchTcnBfjegEk2hESVgzhLVyZWMzyeA1h27wmlDMqVMTRII6P/Sb2n7pjAabEiRm5TO
         Ycxr40L7KW8qZdXAb6puhLN7n+c3Y8yv5TRFK87CiGGfEmIJVqz4pEihEn4kxr9SAiub
         QwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QphnEX1yCm3h/zKEhJXwhDrzy5Vg6Hw5YMC8OA5f7R0=;
        b=Pzq3V1eft2z8nRvLGMSbhnqIym+cz1AaJLCBPUzdI58u2qHr2OrWpyDsmJPUGkydku
         +CoohZd3TzZTzXwO+puYxwCjSqX5vqAOlDENWpS0W0w2A/kxIZsecXB205d3rVRoJYmw
         o2AAAw9DD2LXPlK4pz5X+ozSUjG4u07DZM0Z+WYEWArKELUZYo0CAYcTLk7ZzZmPcPZ/
         L4t2p6ZDbuSdwlpd2MfpIYctXdYS1gFefCVTs5ft4UxNbkNgIlGPkFFN6DJs/7iom6jD
         agx9NSF4hYOuAu2YbqaIvsxBvYO4P4VSBNRbf59kGeW961LY51TZG4JNPnQLpfJcLZRn
         IF9w==
X-Gm-Message-State: AOAM531Wc/gbnvvFvb6h4bbmDsbsSQv3WCqg6IrAE6/PyaeBeaaRe+Nr
        dUmk8nlM/UBOTxQ+2OyVFbD1wS2jud00/g0=
X-Google-Smtp-Source: ABdhPJxRqdDTtqjhivMdUVb/ORSMaL9Op4rt108/xNpZLDNKcXVBHTmStreuVAo+BnQmkXKXYY1JIA==
X-Received: by 2002:a02:5488:0:b0:32e:e4ec:4aae with SMTP id t130-20020a025488000000b0032ee4ec4aaemr3303665jaa.161.1654179860438;
        Thu, 02 Jun 2022 07:24:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id c8-20020a023f48000000b0032e1a07228asm1249372jaf.26.2022.06.02.07.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 07:24:19 -0700 (PDT)
Message-ID: <376e65b1-3001-9bf8-8d08-dcfd9c6a8caf@github.com>
Date:   Thu, 2 Jun 2022 10:24:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/2] usage: add warn_once() helper for repeated
 warnings
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        christian.couder@gmail.com, johannes.schindelin@gmx.de,
        jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
 <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
 <8e29ac807c6a0cf94ea3a44ee3304011c2ad159c.1654046173.git.gitgitgadget@gmail.com>
 <220601.868rqg1qo2.gmgdl@evledraar.gmail.com>
 <8f96563b-87c5-2a8c-fe35-19fd0cc3c7d2@github.com>
 <xmqq35gorv7c.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq35gorv7c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2022 4:21 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> We could certainly investigate this more, but it seems like a more
>> problematic approach than the one taken here. We could add a "is_valid"
>> bit to struct remote, but then could some code path modify that struct
>> after it was validated?
> 
> Two separate parser parsing the same string to produce (supposedly)
> equivalent parse results is a bit disturbing, and I am not sure if
> "is_valid" bit helps that.
> 
> Adding "user" and "password" members to the struct, and retire the
> existing "parser" (instead it would just use the pre-parsed
> components stored in the struct) would.  It would be a much more
> involved change, and it is something more than we would want to do
> in a regression fix patch.
> 
> But this series is a new feature development, so...

Yes, you're right. I should use the output 'struct url_inf' from
url_normalize() to construct the redacted URL. It has the downside
that the output URL can be slightly different from the input URL,
but a user should still be able to diagnose how to resolve the
situation.

Thanks,
-Stolee
