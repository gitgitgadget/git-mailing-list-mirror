Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4DBC3A5A7
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 14:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLHO6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 09:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiLHO6e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 09:58:34 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAA6391C9
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 06:58:33 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a7-20020a056830008700b0066c82848060so1002757oto.4
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 06:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ysc0x3lsk1zAX1VVa8zb+X78/5R4hplgjs//Fo4+NY=;
        b=C18VoccBrB4hvjsE6hXuYm9dkkw/6LIRlCk4laiNnnpRneHR6xeHoNA3+ZU/mpEbAR
         AZOK+fILwwtwVb24TYOH7xuB82yUzYO0XZ2jrTtjMzl0HWC7x96RCv9EXvG9uVtbwj1d
         kDYAEeDgbeFCNB4s4x0NQx8MRqW4YJAk88F9ZAupFwYjmOoAXCsYBJQzTPrcLjzFDSOy
         CjUpJ9gL5HM3yjyopKoOcjKbckZwSkUlNDysAXplTXvEo/avdAQvJPkwVACEv1we1Y5U
         /A9fp2nc91q+7O9OKxqO0yHgSoimoHV3vCkvTpu9vn43N/w5BtGmcCWM78Pv0PyAyJwv
         wWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ysc0x3lsk1zAX1VVa8zb+X78/5R4hplgjs//Fo4+NY=;
        b=NoOubTz735ma6dTgH/05Pnt4PCokFBV9kK82hEMVPFHzUaNY9Ll4C2t8QqB37tjC07
         eS3yKmZBilN82YGvg5JZV3Q7zu6A7q1E6a6tkcD8pc9IHkNU6hZbz5Sh9vK0FQXVv9BW
         t8euIacMJB4NjHyEWtcTgcP518fYVuG7t9czSz5EcXILt6oUHNIHbBF7zXiUiGunOdK0
         FdrYEx/PxV77g26SURIC8NHHqrXVrHgB8BJMJpAuB3n+IZF0mUAqzsxi3vcG7SDIU7cp
         dx0n6Zylo+pFYSqs5FJBGx24ehju/8byXvpued31TKHAWX2V4qR4KI3TKFGSkLviI+/8
         GmCA==
X-Gm-Message-State: ANoB5plu6YFCawyOgD/HspF1FeVb0Gszrs8NAZjEBe69SigaMH8D6R1U
        fa+Vel+1e4m/K156RmRJldkN
X-Google-Smtp-Source: AA0mqf4yIPmBOBrchpSfrx6myuyTdBlTYAwJCFh1k0I95LJFYkc7GZ9MBx4P8kXy7JV36SnhrBQAUA==
X-Received: by 2002:a9d:833:0:b0:670:6d50:dc7d with SMTP id 48-20020a9d0833000000b006706d50dc7dmr1007614oty.14.1670511512292;
        Thu, 08 Dec 2022 06:58:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c5e5:e5dd:715:ac2e? ([2600:1700:e72:80a0:c5e5:e5dd:715:ac2e])
        by smtp.gmail.com with ESMTPSA id i6-20020a9d53c6000000b0066cacb8343bsm11748535oth.41.2022.12.08.06.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 06:58:31 -0800 (PST)
Message-ID: <5ba28171-ede1-8f47-8813-239f591c165c@github.com>
Date:   Thu, 8 Dec 2022 09:58:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 10/11] bundle-uri: download bundles from an advertised
 list
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        steadmon@google.com, chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <69bf154bec63a22df8e5eac89f975625ce73c8ac.1670262639.git.gitgitgadget@gmail.com>
 <Y5CNo5kyByIHDVYh@coredump.intra.peff.net>
 <affbc458-d4f5-525f-d431-5ec1d489afc8@github.com>
 <Y5GF8ams0k03kiVU@coredump.intra.peff.net>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y5GF8ams0k03kiVU@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/2022 1:36 AM, Jeff King wrote:
> On Wed, Dec 07, 2022 at 10:27:06AM -0500, Derrick Stolee wrote:
> 
>>> The "uri" parameter in this function is unused. I'm not sure if that's
>>> indicative of a bug or missing feature (e.g., could it be the base for a
>>> relative url?), or if it's just a leftover from development.
>>
>> Thanks for your careful eye. This 'uri' is indeed not needed. I think it
>> was initially there for relative URIs, but the given 'list' is expected
>> to have that value initialized. I'll make it clear in the doc comment.
> 
> That makes sense. I've queued a patch locally to remove it (since
> locally I build with -Wunused-parameters), which will eventually make
> its way to the list.
> 
>>> If the latter, I'm happy to add it to my list of cleanups.
>>>
>>> There are a couple other unused parameters in this series, too, but they
>>> are all in virtual functions and must be kept. I'll add them to my list
>>> of annotations.
>>
>> Your UNUSED annotations exist in my tree, so I'll try my best to update
>> them in the next version.
> 
> Sounds good (and again, I've queued something locally, but if you beat
> me to it, it's easy to drop mine).
> 
> Note that your series hit 'next' (which is how I noticed it), so there
> usually would not be a "next version". Though we will rewind
> post-release, so there may still be an opportunity (I didn't follow the
> topic closely enough to know if you might want to re-roll for other
> reasons).

I noticed that after reading this round of review, so I'll be preparing
some fixes on top. I noticed some UNUSED that would be necessary from
earlier parts of the bundle URI work, and you've probably already queued
those changes.

Since I no longer plan to re-roll this series, I'd be happy to review
your queued annotations, and I'll focus on the other fixups.

Thanks,
-Stolee
