Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D1CC2B9F7
	for <git@archiver.kernel.org>; Tue, 25 May 2021 00:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781116128D
	for <git@archiver.kernel.org>; Tue, 25 May 2021 00:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhEYAl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 20:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEYAlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 20:41:25 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44818C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 17:39:57 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso27015267ote.1
        for <git@vger.kernel.org>; Mon, 24 May 2021 17:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PmSHNzzYw9n6T5XLlZRcLB2RRpXenoFe/r8Y1yumozo=;
        b=VBzqcdURkH5e/LtI26qfcWmYPi+2U8IVqz1oXiVU9ozaDQjOZt9xBdP4L4r0/JpGtZ
         J5wr5OEOpdUqgfXaJKy81sY1bWSDIqgeLeOEm9aLVgmW5OwmalXQlK99uxIp7yKqXcTE
         pkhOJVqKPGOm1sZHKgDOnNuIAfRkxjQyZWTagtvZvrS1ZdSTTJ84cH8Myspis7yL7n9E
         DVFki7aesIWHDQzsl4TxaH4X0aP0hoUeL5nJtFNbtgEZhZjIPB5WUMICVcy7I1jBcxZc
         9P7RjJhuc2HqDP+cPy2T3vhqdkHbeR4EmT0R85uNMl2vGl+wH8aFJ61nlU5LsUCqkgGB
         D7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PmSHNzzYw9n6T5XLlZRcLB2RRpXenoFe/r8Y1yumozo=;
        b=AzN3Eu4juQNKvLDiCYF1mGiqjRUZ3KtRUJhvlVsnbOmh5xgfzDc9inOxZHzgS570+x
         e1NecGfEdOr8kIZE3N/OU+RRVk9y2G3h2ryTDhuGat3RY2VbDv6PSRzcyLubcUvJ4clp
         oVAYEAXmoKpLXWpxGK/yoRV2pdbMYhBt+jWK9u8HYhw65YPMLn//z/IQ9vRKAd/OhrwK
         5a0bk3YOg6vgVideZCuJGiJhJmTtgJkFDOGFJq+heN/Dn2YJYclWFVv1Ayi3RJjOupRp
         ARU+AQsrtGxP1WPW1eLyLjoJ0uKx5f2fEz1rw1QH+vSDFxj4qbOQsYSZudK0un1wewGZ
         DbpA==
X-Gm-Message-State: AOAM531dLBOLHwJHpFlHp2BVt+725igKME6cKuZaONxHApVTrxinamO9
        n4uqdxHuxCTFmtXM/Ow1J78LESfDQ1iLyg==
X-Google-Smtp-Source: ABdhPJxlAFJhLq4K08CloY0p4NoURgfVJmGP2hUoUDZoTzHZIfICPn4cauoHd8lx0gSthp/+lDiBFg==
X-Received: by 2002:a05:6830:905:: with SMTP id v5mr20586595ott.214.1621903196560;
        Mon, 24 May 2021 17:39:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:21ac:f4cd:5fd4:3840? ([2600:1700:e72:80a0:21ac:f4cd:5fd4:3840])
        by smtp.gmail.com with ESMTPSA id x65sm3423474otb.59.2021.05.24.17.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 17:39:55 -0700 (PDT)
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
 <YKwMU13DOtTIgaeP@google.com>
 <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
 <YKwd2e5VxVmU6zqj@nand.local> <87fsybohy5.fsf@evledraar.gmail.com>
 <YKxBIP4lkoPeCYvb@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <68a2bf8f-07e8-b117-a3f4-862654c781b4@gmail.com>
Date:   Mon, 24 May 2021 20:39:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKxBIP4lkoPeCYvb@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2021 8:13 PM, Taylor Blau wrote:
> On Tue, May 25, 2021 at 12:57:52AM +0200, Ævar Arnfjörð Bjarmason wrote:
>> On Mon, May 24 2021, Taylor Blau wrote:
>>
>>> But I don't think this isolated instance should push in the direction of
>>> adding support for either of the above, regardless of how easy it might
>>> be.
>>
>> I don't see why we wouldn't just tweak GIT_PROGRESS_DELAY to support -1
>> or something for "inf".
> 
> Ironically, I think that this already works, since we parse the value of
> GIT_PROGRESS_DELAY as unsigned, and don't bother checking for if the
> input is negative (since we eventually call git_parse_unsigned(), which
> doesn't have any extra checks other than for overflow).
> 
> So we silently convert -1 to 2^64-1, and call it a day.

That works for me. I'll send a v2 with that tomorrow unless someone
presents a better option.

Thanks,
-Stolee
