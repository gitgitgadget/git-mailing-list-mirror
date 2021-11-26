Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB1C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 07:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359308AbhKZHoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359156AbhKZHmP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 02:42:15 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A0FC061746
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 23:39:03 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n26so8127810pff.3
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 23:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p2HUpPOAzyKanI82AEWcB9T5tlntHbEo2vWX4S2WKmY=;
        b=LH2YIlatQeaoJGRRvWAXFSpqBUmwhDUtIbq5WthzZeC13yaWN7sbW95X3qm3CkKIWN
         +HbQ8cooUyu3xtAkewzBhQ44za/fpq6u5P/CuV9169ZUxnviemiiPoncyuql45yWHkWI
         Nw65SrUoO4zFk8zQGE3akyVLFZIxOo0EBzk+4LEXMtrrP1ZBgJJjwS7+BLtRgqPs5K0t
         mbbUCORITgZkct0KIOpjdl9XHJGlztl0ArtNzUEnFnkitketRlhOFqKZsQDrvJvTCa9N
         pOOxZbu8nLIMbaWowZzBlMLSmGvsnQEHcW6A1RJ0uulrP1846gSCirJuiLL7Lko89gjs
         BnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p2HUpPOAzyKanI82AEWcB9T5tlntHbEo2vWX4S2WKmY=;
        b=fHoPACiSEeq7b0AxHRXxdBhjZytyOKOmC7/kRgWnGN1i3m8lBA5dYRhzs28FeqYCrB
         B1f1m+bzj616RLeTyPc2miamPrYIq6rZme1TAU2iIQ8ZdqlwFOmMW+YR8WZ8YE6EKuPT
         GWHsIJUTNt0+0dg2Y/QXF7DRwm5qmRJqXPbdGXdWXEol9KWAIiQb/yy+smIgL/A9noL8
         g4gPnYA9uefcySjKWA33Ujlm7NbcURwFQIuVl7s4n0D3l4Ovf3+Dp/q4y2idq4JHCj0e
         Z0p3YQ8Nu0FgETL4L3TCGQnX/A28Sd9ySiIxTGZceLfJ54cG/Py5tJnW6TB/CMVMK71x
         SusQ==
X-Gm-Message-State: AOAM530H7ogcOuHS88PKMjxi7DR2frNmf4u1t1zRpxrH2eNJ76yWlK0n
        ViGt9HlzMu7fKRZfLghkP/YhrawelWA=
X-Google-Smtp-Source: ABdhPJyuA9uFMfN/9njBSdPKcjkGAMa62t8l7EeUBU3tEjwntRqzjg2uirZqzhBLn9eaBLNI/H8hKA==
X-Received: by 2002:a63:89c8:: with SMTP id v191mr20197724pgd.268.1637912343139;
        Thu, 25 Nov 2021 23:39:03 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id d7sm6268555pfj.91.2021.11.25.23.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 23:39:02 -0800 (PST)
Message-ID: <c057b7fc-54b3-4946-16ad-8fbd548b505d@gmail.com>
Date:   Fri, 26 Nov 2021 14:38:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] Makefile: error out invoking strip target
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20211125122607.26602-1-bagasdotme@gmail.com>
 <xmqqilwf8je9.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqqilwf8je9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/11/21 14.29, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> Now that $INSTALL_STRIP variable can be defined since 3231f41009 (make:
>> add INSTALL_STRIP option variable, 2021-09-05), it is redundant to have
>> 'strip' target when $INSTALL_STRIP does the job. Error out when invoking
>> the target so that users are forced to define the variable instead.
> 
> It is not exactly redundant for folks who like to build and use in
> place without installing.
> 
> What is the reason why we might want to eventually remove the
> "strip" target, making "make strip" an error?  I do not quite see
> much downsides for having just a target with a simple one-liner
> recipe.
> 

I think we have two ways to do the same thing (installing stripped) and I want 
to push users to go with $INSTALL_STRIP instead of strip target.

Regarding deprecation, making $(warning) message instead of $(error) is better 
option, because users can still use the target (albeit it is deprecated) and 
they can update their build recipe to use $INSTALL_STRIP before we flip to 
$(error) or remove the target.

-- 
An old man doll... just what I always wanted! - Clara
