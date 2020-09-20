Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A000C43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 16:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2AE520EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 16:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsVhnB8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgITQiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 12:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITQiX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 12:38:23 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84111C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 09:38:23 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q63so12485090qkf.3
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mZWB+9GQDZbUKqQebK1Mqpc61bR/82XmGwqw+AZ0Jjg=;
        b=DsVhnB8YWn4vEkFlBCYkyeNBxgxfrdeatg1FSD7f17CxQ/0q6NC4QZl17r12Kjgp7W
         cK6sfUerP919eVgXxJ4ecTmvsbKZRSpzgm3zX/gUfG6kokUOgH3ek5fi8laecD8qpYPI
         xkf4mH+E/85/AswoEvvL1s60LrogVFK3tmU74BMjwPEMKUHE09pax6MNPg8vHFtkqRE0
         uKsnXKfRxk8nGGFALgYHpn2gXeFN3v0QzlJV17chTPXbdZ0nkXr0uWVovD4jVJj2AuvN
         Qa1v3j1zRlAsYmg+NGnulDrFrGkLeNrXOXbhOE4GQolt4CEKVjvNSlNGUC1YPV20Qk1A
         Vnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mZWB+9GQDZbUKqQebK1Mqpc61bR/82XmGwqw+AZ0Jjg=;
        b=iBz1IsXNlK5JXFvnN+047rQb1qXC13E9ZkDISowPVNUdhq8DXNl6D30NlrJZS+hYc3
         f+X0WhuMHye2a0JyStTpY0DK9+6RUwzcX7DpvKz0a02YdKMqQwymPI67PwZYoUaMsnas
         UHI3d3f/J85eIX9DKQQX5R9jtlLKWQVUNH1JLbXKcqaAbPklti8AjHAPr7qYqgB2oBin
         v0szW2ogWC3RIcjrfTWmJKy/xrWeGdXifbuvqc+z//h2DGHlhcsNB+grla6IJu+QmduK
         WCsWJCMd/YMB7Rehfp5VeoKg6QoGDan1QutkjtohfTaSIttBJlG6Eh9K1ZvSk3YzYf4C
         0SGw==
X-Gm-Message-State: AOAM531G+YCyUsPKrhiVpU3XEMjTNzAX6P2dbgUQrB5ifi/P6cb8Lwd6
        0Atov7v4HzLHfag9RaNKYf4=
X-Google-Smtp-Source: ABdhPJy/iE0Yy72oCJ3BZ+P2pG42yEirq8GZ/ArLIrc0iVFRpc2rM6axTt1QE4neTjh8kaK/n5+oNw==
X-Received: by 2002:a05:620a:1473:: with SMTP id j19mr43423965qkl.369.1600619902330;
        Sun, 20 Sep 2020 09:38:22 -0700 (PDT)
Received: from [192.168.67.200] (dsl-216-221-52-235.mtl.contact.net. [216.221.52.235])
        by smtp.gmail.com with ESMTPSA id o2sm6736643qkk.42.2020.09.20.09.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 09:38:21 -0700 (PDT)
Subject: Re: [PATCH v2] diff: Fix modified lines stats with --stat and
 --numstat
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dermoth@aei.ca, peff@peff.net
References: <20200918113256.8699-2-tguyot@gmail.com>
 <20200920130945.26399-1-tguyot@gmail.com>
 <20200920153915.GB2726066@nand.local>
From:   Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a126bcf6-13f7-48f0-95d9-d934d042d7fd@gmail.com>
Date:   Sun, 20 Sep 2020 12:38:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200920153915.GB2726066@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-20 11:39, Taylor Blau wrote:
> On Sun, Sep 20, 2020 at 09:09:46AM -0400, Thomas Guyot-Sionnest wrote:
>> In builtin_diffstat(), when both files are coming from "stdin" (which
>> could be better described as the file's content being written directly
>> into the file object), oideq() compares two null hashes and ignores the
>> actual differences for the statistics.
>>
>> This patch checks if is_stdin flag is set on both sides and compare
>> contents directly.
>>
>> Signed-off-by: Thomas Guyot-Sionnest <tguyot@gmail.com>
>> ---
>> Range-diff:
>> 1:  479c2835fc ! 1:  1f25713d44 diff: Fix modified lines stats with --stat and --numstat
>>     @@ -20,8 +20,12 @@
>>       	}
>>
>>      -	same_contents = oideq(&one->oid, &two->oid);
>>     ++	/* What is_stdin really means is that the file's content is only
>>     ++	 * in the filespec's buffer and its oid is zero. We can't compare
>>     ++	 * oid's if both are null and we can just diff the buffers */
>>      +	if (one->is_stdin && two->is_stdin)
>>     -+		same_contents = !strcmp(one->data, two->data);
>>     ++		same_contents = (one->size == two->size ?
>>     ++			!memcmp(one->data, two->data, one->size) : 0);
>>      +	else
>>      +		same_contents = oideq(&one->oid, &two->oid);
> 
> After reading your explanation in [1], this version makes more sense to
> me.
> 
> Thanks.
> 
> [1]: https://lore.kernel.org/git/f4c4cb48-f4b5-3d4d-066d-b94e961dcbb5@gmail.com/

There's a little bit missing... Just before the new code example:,
previous to last paragraph:

> it's assumed [we can just call oidcmp()] and I won't make complex

--
Thomas
