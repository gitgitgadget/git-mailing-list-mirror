Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9041F464
	for <e@80x24.org>; Wed, 25 Sep 2019 13:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405886AbfIYNMP (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 09:12:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39545 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbfIYNMP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 09:12:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so6456053qtb.6
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ulCKfnLZciDBDEuQKy5DJZIKEF/8b4Ykc3AMjslGYT0=;
        b=SCvRL7KrHlmoOR5NMCJCkzyZ8Oa4oiGFDi52mzidIlyuL/7svv07A2lPgsXk3CmViX
         nv1mlqktQAxqT+teVsMOkKPMJTlQAkEnoJ7uWQBxjCmihT2rv074CduDD5fe4ycZtW6U
         N5D88ERHEFcDWQlDPmR9iBMyxIhVeqAnO1COYNiOew52x6i/x4QNmwZpLABe+C3zWB76
         6aPuIfPGQ56hOeR3vIWPmn6ptLutNoCglk81ngSFZrCq3CmKOCMDUCidUnpqig8uwzNk
         /JbWlAJlLJMXdUAJ8+It3hJr4KwPVyvxvCQR+LfQvZHnEC5wYhM38/a6rzBorlxDCYr8
         O13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ulCKfnLZciDBDEuQKy5DJZIKEF/8b4Ykc3AMjslGYT0=;
        b=TNw3SXNs01fv4yTi5FA6fTeNX9S0Vl6BeEAO3ZXspPBvhGkqY1hQl7fOTZoEDau10a
         IL0PZ4pTs7xC3yCqowb+I3sKhAF9JxpOvefH8OJGqZsbnv/H6R0Kod+Pkh1fUoe1aLEd
         4dZIAE4wK8s11dAYo9xbi4fdW/4RtW0tPDJtLosMAWLqnX+w/FBEbjhmFosHQ6Q1pwaX
         EjAgYuqKpZfjbys7EquiUhosoyl8cl9Auy3x6htx7lZlLklThiI9qr5DJdp1Pd23u/xr
         ZIOPzSMD7aoe3G0DwuRQUh3JB3lOjlbgnTWDhevEslgehz0cHgWPA2OQmMzj9nDwviUl
         iiWA==
X-Gm-Message-State: APjAAAU088dgQFAHu/LoGTVUtWGOAr7wGi7dnh+hHHDxC79XzW9qtuJn
        cXtIfjcxepWmsOjkFQ0j8ccDn0ktu7E=
X-Google-Smtp-Source: APXvYqw5pbDFIAdXwDWxeQ7N22HJisP/+tJgmxjvUgmk4m6nwqf2+jDwmFmygHHMxIForDQf6Pm/Mw==
X-Received: by 2002:ac8:2f81:: with SMTP id l1mr8718940qta.269.1569417134074;
        Wed, 25 Sep 2019 06:12:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4cc1:b74:5d5b:b0b0? ([2001:4898:a800:1010:fdf6:b74:5d5b:b0b0])
        by smtp.gmail.com with ESMTPSA id m63sm3040757qkc.72.2019.09.25.06.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 06:12:13 -0700 (PDT)
Subject: Re: [PATCH v2 10/19] introduce container_of macro
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-11-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <059c05bb-685a-7933-55ff-f18ed271ac3a@gmail.com>
Date:   Wed, 25 Sep 2019 09:12:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190924010324.22619-11-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2019 9:03 PM, Eric Wong wrote:
> This macro is popular within the Linux kernel for supporting
> intrusive data structures such as linked lists, red-black trees,
> and chained hash tables while allowing the compiler to do
> type checking.
> 
> I intend to use this to remove the limitation of "hashmap_entry"
> being location-dependent and to allow more compile-time type
> checking.

nit: I don't know why the first-person singular language caused
me to stumble during this message. Perhaps the following rewrite
would convey the same information:

  Later patches will use container_of() to remove the limitation
  of "hashmap_entry" being location-dependent. This will complete
  the transition to compile-time type checking for the hashmap API.

> This macro already exists in our source as "list_entry" in
> list.h and making "list_entry" an alias to "container_of"
> as the Linux kernel has done is a possibility.

If it is the same code, then I would prefer you do this conversion
now so we can see that equivalence in the patch AND we know that
existing code will test it.

Thanks,
-Stolee

> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  git-compat-util.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 83be89de0a..4cc2c8283a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1312,4 +1312,14 @@ void unleak_memory(const void *ptr, size_t len);
>   */
>  #include "banned.h"
>  
> +/*
> + * container_of - Get the address of an object containing a field.
> + *
> + * @ptr: pointer to the field.
> + * @type: type of the object.
> + * @member: name of the field within the object.
> + */
> +#define container_of(ptr, type, member) \
> +	((type *) ((char *)(ptr) - offsetof(type, member)))
> +
>  #endif
> 

