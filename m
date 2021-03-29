Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9F5C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7744F617C9
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhC2KJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhC2KJB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 06:09:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868EBC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:09:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so12239528wrc.3
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yD1JYFl7Pfbr3BVA3/ZDsB92qajJsz0H6BXs3ActtpU=;
        b=d4LOTe9kT77JB2D1PukIcTL2FKpim2JZCFkU7YKK2kN6IWCJ+6b2G0saiFaqbpKtpx
         HzIBu2h04TtsHKzSN+sn9kQ7c/fzMPsw4lgFf8APebGnJ6sqnpHugz1wF/pwmYb156K5
         O0kr1M5EzAhL1gy7rUxiiXleKdXihwODG3bjbBXdBeAALIh1swjTpy5sjLlUdVK9IVJc
         +Egn6kPQiYlOYeK8Qq4ev3atTZ+aXFrTox6bys/9Oc1lk+zykNZUVq94KrfntRO0sEQH
         vIm6pYoN749tr6IV6cTHRvQbg0NZLhlIgTp0mm60Ez23FbOl13oHLpfzaXc2lzEGXN5y
         H4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yD1JYFl7Pfbr3BVA3/ZDsB92qajJsz0H6BXs3ActtpU=;
        b=AvJSblNZXWh27WviQI59Tioh6SVK+MOdCW+VLJ2YwjnLPmH8F3m1HdNAWv//bVXOUn
         dJeD/vMQYI1doJ0FXOYf6zeuqgk937eGOvJrmqud3GFhY4/3HHbfTBoE22wCvH77ykPX
         ix63H2WQ0vk1mAvl9yG8SZL2JaRU+5P4Vr2jVDy9jViWX61Ru7javxuAgZouZ/Nj35iN
         BuwAWpD8nnmKgSyQuLsQ9a2zegrWEDq0mHemJz4UQAwkgReiMzqBHRPt19r65XqDxgSQ
         AcGwHIiRsOGGQm3ZQjBWD8DnPDhkHEb/8LquIhrEnfqzV7GaaHnnfUk8a4y7fnxoZsCu
         xDgg==
X-Gm-Message-State: AOAM532nSe5b2rIQscbpGK8Eao4hob/XhR2XReJ98fEAYLIm/7BEl98O
        VsS3yZTbvy6pFpUVon6fgEdV1TXPu98=
X-Google-Smtp-Source: ABdhPJwAn82Pvv9f1rvw4bWhXfIKngvrnOVwItoT07CZtwmhn8zaf2xuMQTcYY4HH8yDAMbRA7yHJw==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr27800959wru.214.1617012538839;
        Mon, 29 Mar 2021 03:08:58 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id a15sm19045650wrr.53.2021.03.29.03.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 03:08:58 -0700 (PDT)
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
To:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <xmqq5z1cqki7.fsf@gitster.g> <xmqq1rc0qjn1.fsf@gitster.g>
 <87blb4nf2n.fsf@evledraar.gmail.com>
 <578FC14B-CB72-41CA-A8FD-1480EBCCB968@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <62695830-2f9e-c3b5-856c-01b97eb2c3af@gmail.com>
Date:   Mon, 29 Mar 2021 11:08:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <578FC14B-CB72-41CA-A8FD-1480EBCCB968@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva

On 28/03/2021 13:40, Atharva Raykar wrote:
> On 28-Mar-2021, at 08:46, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> The "define-?.*" can be simplified to just "define.*", but looking at
>> the tests is that the intent? From the tests it looks like "define[- ]"
>> is what the author wants, unless this is meant to also match
>> "(definements".
> 
> Yes, you captured my intent correctly. Will fix it.
> 
>> Has this been tested on some real-world scheme code? E.g. I have guile
>> installed locally, and it has really large top-level eval-when
>> blocks. These rules would jump over those to whatever the function above
>> them is.
> 
> I do not have a large scheme codebase on my own, I usually use Racket,
> which is a much larger language with many more forms. Other Schemes like
> Guile also extend the language a lot, like in your example, eval-when is
> an extension provided by Guile (and Chicken and Chez), but not a part of
> the R6RS document when I searched its index.
> 
> So the 'define' forms are the only one that I know would reliably be present
> across all schemes. But one can also make a case where some of these non-standard
> forms may be common enough that they are worth adding in. In that case which
> forms to include? Should we consider everything in the SRFI's[1]? Should the
> various module definitions of Racket be included? It's a little tricky to know
> where to stop.

If there are some common forms such as eval-when then it would be good 
to include them, otherwise we end up needing a different rule for each 
scheme implementation as they all seem to tweak something. Gerbil uses 
'def...' e.g def, defsyntax, defstruct, defrules rather than define, 
define-syntax, define-record etc. I'm not user if we want to accommodate 
that or not.

Best Wishes

Phillip


> That being said, I will try to run this through more Scheme codebases that I can
> find and see if there are any forms that seem to show up commonly enough that they
> are worth including.
> 
> [1] https://en.wikipedia.org/wiki/Scheme_Requests_for_Implementation
> 

