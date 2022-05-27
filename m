Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA29C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 14:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245525AbiE0Ono (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 10:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiE0Onn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 10:43:43 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E340313FD67
        for <git@vger.kernel.org>; Fri, 27 May 2022 07:43:42 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id l1so4217042qvh.1
        for <git@vger.kernel.org>; Fri, 27 May 2022 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T+TDNkHIsOgEWAoZjLxiXSsbEpgE31yXX0Fc/DVUh48=;
        b=CnDGSEKmkd79mo0n7H4McsHNjn9tre6kNlEU4Uw9XStOvH1VI0ETKS7KU4Ycjj5U+6
         1X90c03afd84cRcJSbdIqfD82EmqIAZwXqDjEmCT1NwALGh3xvnKMYd8wsDxi/b6gYnQ
         GokFL9taaGJ2DLmk42wAvw6E/rknhDdXuGclMPXLDDMrjNs7cylgexxHustETDs3/b1v
         7obCOsdd9fT68mj1XMek3GPN/bzgjrYTLcuTwrX9ADwxkJt20nmiKFeius/5wCLVluNs
         /qB0l8mw8dFLS5IN4RhJ+Y19VlSWkiDjFkIRObszubofAtHt3WQcH0O/7DAHz213SxrD
         /vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T+TDNkHIsOgEWAoZjLxiXSsbEpgE31yXX0Fc/DVUh48=;
        b=KtESM1xu27vtuofSsI5VTWYq/yiZc+6VU69hHkq6Z8JUCi7KNpttjnIGEBWgWNWefU
         qDj92jN/DUcP/VsDG3RbEmNiM8LMuJP5va3be72wYyugYiMpxnbzHXsufM5CzIKlIYZM
         RETxdcUBuwHvSbcp7wKSz8S7o2fbLCrmH8Ba8OyvwxR8+n1tpJ9xbMsn6XhcupdN5fdB
         lRERSaGS78nSt+0Yk/WVa0YOHx16DTw6nhF7GVr1x+cLaZN2UiMe7l/koufo4jpbED7m
         yFhFLI5vpzsEAInvjy0PNArO5QE+A4/MEOq8coj1hi+puR09bkxedp3UxcuTLuThDDH8
         pLUg==
X-Gm-Message-State: AOAM532YnOGTmKEsE3UFjtHujQ9Qi6k6ipYSBd1yEf0UlS8mdrWd0NBZ
        wzqh0PrvVXQ8S7YBM4itInEu8CTwnMZX
X-Google-Smtp-Source: ABdhPJzPGDacv0R3JnubeMph+Ab7i67M7RXQHgMtL+CMtEL+fqcMDwcCyJAyNB3nSPin5BSzfP53pA==
X-Received: by 2002:a05:6214:d46:b0:45a:e9fa:c33c with SMTP id 6-20020a0562140d4600b0045ae9fac33cmr35472647qvr.93.1653662621980;
        Fri, 27 May 2022 07:43:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9d56:33a:55eb:168? ([2600:1700:e72:80a0:9d56:33a:55eb:168])
        by smtp.gmail.com with ESMTPSA id y1-20020a05622a004100b002f39b99f69esm2828450qtw.56.2022.05.27.07.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 07:43:41 -0700 (PDT)
Message-ID: <0cf130d2-464b-8661-d53a-723041f32fc6@github.com>
Date:   Fri, 27 May 2022 10:43:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] urlmatch: create fetch.credentialsInUrl config
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
 <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
 <220527.86fskv2g50.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220527.86fskv2g50.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/2022 10:22 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, May 27 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
> 
> Just real quick, I hadn't taken notice of this before (the rest looks
> good at a glance):
> 
>> +	/*
>> +	 * Let's do some defensive programming to ensure the given
>> +	 * URL is of the proper format.
>> +	 */
>> +	if (!colon_ptr)
>> +		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
>> +		    url, (uintmax_t) scheme_len);
>> +	if (colon_ptr > at_ptr)
>> +		BUG("input url '%s' does not include credentials",
>> +		    url);
> 
> So the function is renamed to detected_credentials_in_url(), so as a nit
> I'd expect some verb like "strip", "redact" or whatever inthe name or
> whatever, to make it clear what we're doing.

The name means "Do what needs to be done when creds are detected
in a URL".

If we decide to change the response to creds in a URL, then we
would change the implementation without changing the name.

>>  			colon_ptr = strchr(norm.buf + scheme_len + 3, ':');
>>  			if (colon_ptr) {
>> +				detected_credentials_in_url(orig_url, scheme_len);
> 
> Has already done the work of finding the colon_ptr (and at_ptr) why
> re-do that paranoia since we have a static function,

Unfortunately, at this point 'url' is not equal to 'orig_url' and
'colon_ptr' isn't even within the 'orig_url' string. It's been
copied and mutated. It was my first instinct to share as much as
possible, which is why 'schema' is reused.

Thanks,
-Stolee
