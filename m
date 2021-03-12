Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ADEC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB3064F86
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhCLXaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 18:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbhCLXaD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 18:30:03 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C1C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 15:30:03 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so11809180pjv.1
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 15:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ed9xZATfsLLbV3xyyLU9GJioF6Js3qvOkOGg8gAXWs=;
        b=QVeOQDDVhQXq2wE7lMQfoSN6mUZB34Mbl3TMQ3TEdMQrgmiNY5mOcdHAe8u4JxAmGO
         dfnS1BcYeJ+AxAo4Sd4RNo7gOqj76BDKhbal84tWwD3LwtiCRO6tDsUQdoSfQoO8jC7n
         maI2x/5A2ZpPNXnmxRTmLZoE98/zqjodOzW5ULQVwhzis4q8fCcKmR6N77FuSd5BxlBR
         LnoOWv6K+AzS7g8fWDKBCgiepWFtG6ZQcV2w6yD5Y6rgv74plLfkIrOtfPN6kMSooiAT
         sU7gZEOumKhNPpZnigSUDh4zEev/+7NqveI9kYQUDugD8JVaMXGBl4Q8I+A/ySEsT0zw
         0MuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ed9xZATfsLLbV3xyyLU9GJioF6Js3qvOkOGg8gAXWs=;
        b=AUL9i4uIlGSvvmWg6ewEz6wIgPOzy6TpxDNbXF6JaXOP7ODkKH3VbPOqv4l8jDzMuF
         uX8pqC8+G+/P4NsxrVmIL3KI3oTUKjI7VX1ri5W3CeyL5K2h+UTiy7Keoap1RSN/NX2n
         FaioWiqslq3dZC5g9xLvhsjsmK3E8CDjv1HaKTzqGv+hvXzQFZXFC/cE4tOZkXhDHiI7
         7zRtLarij8ymKHSx0ZjMjX1PJiBc1YPeQPyMQszqp1vDqa/93f1pljgEXMD2sFjHkLlQ
         3+p2FZMTg1HipV39tHCVh9S0AkNda3SJ49jsGh/tus4yoJosdJDmK9dafcLnpKz4SBeU
         aRgQ==
X-Gm-Message-State: AOAM530irxxpKYy/ekpaiAyBricTqg5xh8rdXSzzAoMwV8RmojZCK4f0
        mCP3RFxBR5IEzJzpJdRn0CsKzXGm0qs=
X-Google-Smtp-Source: ABdhPJwn1slDN1xyEua3ww+G5SU2JQY396cIyTB0LqZBZ/W8Tnnz2NXyCCQzv5gf+qsA24KvxTekrA==
X-Received: by 2002:a17:90b:1082:: with SMTP id gj2mr642632pjb.155.1615591802606;
        Fri, 12 Mar 2021 15:30:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a1e7:6707:cbf6:696d])
        by smtp.gmail.com with ESMTPSA id i14sm3251933pjh.17.2021.03.12.15.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 15:30:02 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:29:59 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: Re: [PATCH] mergetool: do not enable hideResolved by default
Message-ID: <YEv5d0pGvEVpepoY@google.com>
References: <20210130054655.48237-1-seth@eseth.com>
 <20210209200712.156540-1-seth@eseth.com>
 <20210209200712.156540-2-seth@eseth.com>
 <YEbdj27CmjNKSWf4@google.com>
 <xmqqmtvbjuvl.fsf@gitster.g>
 <xmqqzgzafo5o.fsf@gitster.g>
 <xmqqlfas55mk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfas55mk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Junio C Hamano <gitster@pobox.com> writes:

>>> As we want to disable the feature for any backend when the user does
>>> not explicitly say the feature is wanted (either in general, or for
>>> a specific backend), the change in the above hunk is exactly want we
>>> want to see.
>>>
>>> Looking good.  Let's not revert the series and disable by default.
>>>
>>> Should I expect an updated log message, though?
[...]
>> For tonight's pushout, I'll use the patch as-is and merge it in
>> 'seen'.
>
> Any progress here?

Sorry for the delay.  I should be able to send out an improved log
message (more concise and summarizing the supporting info from this
thread) later this afternoon.

Thanks,
Jonathan
