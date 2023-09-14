Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130F2EE021B
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 03:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjINDTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 23:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjINDSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 23:18:42 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D982119
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 20:18:27 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c1fe87fc29so4562275ad.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 20:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694661507; x=1695266307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWx946erer/49jcliWifiBx4JpSVTufjjSRFkib3uMU=;
        b=x4TC/P62dsFnaSkEmu7M43n+VUkssqVXJ49dsFbXGRx1uiJqIqIWIkUsxbWamj+2TW
         Q69Jmm6P+lTOT0U+Ks8mLTUjmn58npXRKkyoeIt6RJ0bbvZDIkbVXAmYZtqzFf/Fp0AO
         v3A8mlvagfZoCEYcrIXZY9n898Yxl4c25F/9CZGyXe2Vh4jrnx0qCq1ecDBSnhEIM5XR
         iNk8X+RZqeGLdSgOE/WqearyJqupTjYevsNX2kBG+zX8IUkRz7mhEqvDLbz4ppO9Ujpt
         yWIOQ0uW/53obvJb36/aSBSjn7Dcr2wI23YbAQt+CqhBI29Aj/Hg67MS3UaEGGtplWJY
         H8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694661507; x=1695266307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWx946erer/49jcliWifiBx4JpSVTufjjSRFkib3uMU=;
        b=MMrBVfviujTfkkY/cLr+ptg6YD9ZKZxhbALpM9VGADvluIk2txcqJFEtGj9YLYOKQA
         slI2kwrrzzuB586Nf+OF/ZUG5+9CsHbVJMJVTGfItYv4d4DgnpxRM+FDq8SmbRFcdvzT
         UWtt1w4dmdHE7Wv+8JQYrY9DmzVGLXTi6Y8QKGZu8OTI66WTLIkZMHDKci5iItZGqCza
         SIcTDDtx4O4QGEqFyQw0zO0walIwQRozZVgip5bjG7st0y0CDzoQt7SqkMEElfQi8CHR
         3FNAl0prwTbxqA7SrfdZ/orwp538iLmpc5WMhmGlnSfklYWA+1sMAmMLGcOh+MvvGdkR
         U2pA==
X-Gm-Message-State: AOJu0Yxpl0lKSmh0YmRFR+MbX6XWm+uk1aNCW5i2dSzzbTVxrLdXKkUz
        wemHpQ5r/3MQFyOOBaXRHYnK+4Ct8IU=
X-Google-Smtp-Source: AGHT+IHEJ1DlbUEvcCHK7+20MwMWcf+uYdzM9TXenGEy6be5lf9uemNas5sOve3Z4DZW0lvT3eEr1Abm3yk=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:e551:b0:1c3:a4f2:7c85 with SMTP id
 n17-20020a170902e55100b001c3a4f27c85mr213978plf.6.1694661506945; Wed, 13 Sep
 2023 20:18:26 -0700 (PDT)
Date:   Wed, 13 Sep 2023 20:18:25 -0700
In-Reply-To: <owly5y4dlfcg.fsf@fine.c.googlers.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com> <0463066ebe0889b72b6a1f6c344f2de127458391.1694240177.git.gitgitgadget@gmail.com>
 <xmqqmsxsv8ik.fsf@gitster.g> <owly5y4dlfcg.fsf@fine.c.googlers.com>
Message-ID: <owlywmwtjvcu.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 6/6] trailer: use offsets for trailer_start/trailer_end
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Linus Arver <linusa@google.com>
>>>
>>> Previously these fields in the trailer_info struct were of type "const
>>> char *" and pointed to positions in the input string directly (to the
>>> start and end positions of the trailer block).
>>>
>>> Use offsets to make the intended usage less ambiguous. We only need to
>>> reference the input string in format_trailer_info(), so update that
>>> function to take a pointer to the input.
>>
>> Hmm, I am not sure if this is an improvement.  If the underlying
>> buffer can be reallocated (to grow), the approach to use the offsets
>> certainly is easier to deal with, as they will stay valid even after
>> such a reallocation.  But you lose the obvious sentinel value NULL
>> that can mean something special
>
> True.
>
>> and have to make the readers aware
>> of the local convention you happened to have picked with a comment
>> like ...
>>
>>> Signed-off-by: Linus Arver <linusa@google.com>
>>> ---
>>>  trailer.c | 17 ++++++++---------
>>>  trailer.h |  7 +++----
>>>  2 files changed, 11 insertions(+), 13 deletions(-)
>>> ...
>>>  	/*
>>> -	 * Pointers to the start and end of the trailer block found. If there
>>> -	 * is no trailer block found, these 2 pointers point to the end of the
>>> -	 * input string.
>>> +	 * Offsets to the trailer block start and end positions in the input
>>> +	 * string. If no trailer block is found, these are set to 0.
>>>  	 */

I've just realized that the new comment "If no trailer block is found,
these are set to 0" is perhaps not always true in the current version
of this patch. This is because this patch did a mechanical type
conversion of the old fields from "const char *" to "size_t", and we
still run

    trailer_end = find_trailer_end(str, trailer_search_boundary);
    trailer_start = find_trailer_start(str, trailer_end);

inside trailer_info_get() (not visible in the patch context lines). I
will update this patch to make the comment "If no trailer block is found,
these are set to 0" true.
