Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF9C433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 13:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350192AbiEBNqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 09:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbiEBNqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 09:46:37 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A5A288
        for <git@vger.kernel.org>; Mon,  2 May 2022 06:43:07 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id f5so7902141ilj.13
        for <git@vger.kernel.org>; Mon, 02 May 2022 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=at78XiEPN5iO2Jlho77cb+/aMPSlh5QEvDPaxA1K7lY=;
        b=Xv+s7Mgk+uUAGUWNBrfejrTOioD6qrizlwvxInt4B0STcvY1nCIraXVVOSWBTxI65J
         +oPbgabEAJZWpBImwP5Ert2b5kjsMxrr6hkbcpJbz7D603/GsaXYm6s8HS5RPnw3GsO4
         Lh1sG2xdZx61ny85SC19yOm1orEtMZIpvykn/fcd2uTM9n0U2aofFqU4iXDPAxwtX8Hd
         Un/jWC22EzEIq8pYjKkohpi9rulY2U5bQ7zzhLne6qwSgUGqqQikML8dceGj38jTiEJo
         qNaend0aRG4RR4tfh5akOOigTWtQqSJxuAqRVI3914eT4LR1AdWClXzq8Ani+ZxY5tEk
         II2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=at78XiEPN5iO2Jlho77cb+/aMPSlh5QEvDPaxA1K7lY=;
        b=WfDVJ5fBUukhxe7SEPdsT3UWJyeFbUykwUwai2AvVJvJjMag/yarurm5uKsV/ntbFt
         6O++AtKY6mZDV9PwRcx2WLt4SZM5BOux7/LILf6XW33i/tZz3cC3qV+ZNclQ3pOCX3F0
         a/roTcobNEEAKxAXXAE0+HqW/9Q9JwNtQDM2R0gB6QQcna6Rqp6Ahuni2eYNwkknMDVi
         G768uP76kM2YoNaZVQFBjXJS27E/Lii0EZoOwKfC675t88NFXuXmTjg1lR/Xw/FrG+g2
         a9V7sGQvwfMAymXqwZBpbiNZil5IAtsDP1EKlk4J5YWHgMu/GFihY0YwvBzEUaYNzoF0
         nJnQ==
X-Gm-Message-State: AOAM532ZyrV2nGPYkJvLvghtKrpBiBKhN4uEOHPmqFypo4rAZG42gWRG
        NGyKiqoduwZwEhcY2MMVK/1iWTVuzOGC
X-Google-Smtp-Source: ABdhPJw8UwpAjqweYxL/BKCv0sUt6RCQMt+tYbsg0Vryghbl6t0K7st0h6b1N7pb0yqOWDkloU3iWg==
X-Received: by 2002:a05:6e02:12e2:b0:2cd:9d74:1523 with SMTP id l2-20020a056e0212e200b002cd9d741523mr4667964iln.284.1651498986865;
        Mon, 02 May 2022 06:43:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8514:dee2:f0b:81ca? ([2600:1700:e72:80a0:8514:dee2:f0b:81ca])
        by smtp.gmail.com with ESMTPSA id p25-20020a027819000000b0032b3a7817e7sm3056765jac.171.2022.05.02.06.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 06:43:06 -0700 (PDT)
Message-ID: <5e8eff95-d768-439d-e2df-d575a0038ffd@github.com>
Date:   Mon, 2 May 2022 09:43:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] clone: plug a miniscule leak
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlevl4ysk.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqlevl4ysk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2022 1:17 AM, Junio C Hamano wrote:
>     Perhaps a Coccinelle rule like this might have caught similar
>     leaks:
> 
> 	@@
> 	expression E;
> 	expression V;
> 	@@
> 	- if (E)
> 	-   V = xstrdup(E);
> 	+ if (E) {
> 	+   free(V);
> 	+   V = xstrdup(E);
> 	+ }
> 
>     The fact that the result of xstrdup() is assigned to V is that V
>     is meant to hold a pointer to an allocated piece of memory.
> 
>     With the preimage of the above semantic patch, it is reasonable
>     to expect that V may be initialized to NULL or may be holding a
>     pointer to a piece of allocated memory when the control reaches
>     here, because otherwise, V will be either need to be freed (when
>     E was not NULL, in which case we assigned the result of
>     xstrdup() to it) or V has garbage that cannot be freed later.

Initially, I did think "what if V is not initialized to NULL?" but
you are right that the code would already be broken in that case.

> -	if (option_origin != NULL)

This technically wouldn't hit your rule, since "E" isn't just the
variable name, as we typically do with our style. Is that something
that Coccinelle automatically simplifies?

> +	if (option_origin != NULL) {

Do you want to take this opportunity to drop the "!= NULL" here?

> +		free(remote_name);
>  		remote_name = xstrdup(option_origin);
> +	}
> >  	if (remote_name == NULL)

Or do you want to keep similar style from the surrounding code?

Either way, looks good to me.

Thanks,
-Stolee
