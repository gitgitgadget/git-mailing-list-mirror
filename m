Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C5AC433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D592224BD
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbhAKL5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbhAKL5n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 06:57:43 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65370C061794
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 03:57:02 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id h1so3141378qvy.12
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 03:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xhixN/NPH0aPU1Ubj8oOuhyq4An3soAUjIz+AcqZEsE=;
        b=XlcyNcWl1CK2BD6g4nYm8K1IwGhNMjZyPdZaruK5VfXKjac+f+dnNdh7osUmmr9kjr
         uT7i74dUizVduiNWX+No7x01G5HkFCKNNJB7HnWVMybovvKqf9+Lsa6AgSyPhHI7kHpJ
         1bNinwIE9b0mCzD+qGjEeEPjVZahZEjR74DTtM63vrmpLWPa8N0UeogY6aeEnbUck1B0
         UklfNUmkyGWE6b9sAoEDt27JdtopxQoL8PnXAssERCL68xPuTsoa0ojYq2ReEglz4o3U
         cmU6+FPTq7U42pR156k/CNxM2fdL+chVN5s8xirUFzijP3YJT0WrdiVHAPsNt3kGCE0a
         T0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xhixN/NPH0aPU1Ubj8oOuhyq4An3soAUjIz+AcqZEsE=;
        b=bpJxJrqmJfH8SGgP8JTwUymLBY0K2PSP01xDngI4GEFNul9x6PwC2l/fX2I9D/ooRI
         yDQWYQiwmyzPjfKJyhFFXL07qbN0KBRLDtgX2WmxSULbIM48FP5A5EBAQTWQNiilR47X
         m0sG9J1WW9tVIeWoZTDwMf5+QxFEzwlqQs9HSTKfzRVjm9+sSUt2hNLhB8/oskTwp7VV
         8FKVgOLtXIeTpgyiGQ14Bn4GAF/rmpgannmdJSuEqPWV4FR8+cC12XWzmR7dIiUAoNGd
         aTyvXSjzR6/xSXDH4rhkE3sYsqlFbN0lle4VhTnwjy6YAaTrlqWZ3VJlfcIdFKZkO1fW
         rxvg==
X-Gm-Message-State: AOAM530JPVPAkJCWAu0+ObS0GpxOFw3U1VWT+7T6PkbMTTkASNkilrQ9
        CjDKsgKzDXTOsL+O50VPlNe1uJ9qDIQ=
X-Google-Smtp-Source: ABdhPJz5KCgvoS/Uj6TGLXshgBGDj7FwE63ZMh0GH+GSPKm+Dd+vTgbcXNJZvsZXNxwNbvxby9v6bQ==
X-Received: by 2002:a0c:a789:: with SMTP id v9mr14910562qva.41.1610366221542;
        Mon, 11 Jan 2021 03:57:01 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id t5sm7921107qte.20.2021.01.11.03.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 03:57:00 -0800 (PST)
Subject: Re: [PATCH 18/20] pack-revindex: remove unused
 'find_revindex_position()'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
References: <cover.1610129796.git.me@ttaylorr.com>
 <d60411d524656f4680ac578765b2a8704325a060.1610129796.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <624d0642-b6c9-7c76-aeb6-d7e18b0aad1f@gmail.com>
Date:   Mon, 11 Jan 2021 06:57:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <d60411d524656f4680ac578765b2a8704325a060.1610129796.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2021 1:17 PM, Taylor Blau wrote:
> -int find_revindex_position(struct packed_git *p, off_t ofs)
> +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
>  {
>  	int lo = 0;
> -	int hi = p->num_objects + 1;
> -	const struct revindex_entry *revindex = p->revindex;
> +	int hi;
> +	const struct revindex_entry *revindex;
> +
> +	if (load_pack_revindex(p) < 0)
> +		return -1;
> +
> +	hi = p->num_objects + 1;
> +	revindex = p->revindex;
>  
>  	do {
>  		const unsigned mi = lo + (hi - lo) / 2;
>  		if (revindex[mi].offset == ofs) {
> -			return mi;
> +			*pos = mi;
> +			return 0;
>  		} else if (ofs < revindex[mi].offset)
>  			hi = mi;
>  		else
> @@ -189,20 +196,6 @@ int find_revindex_position(struct packed_git *p, off_t ofs)
>  	return -1;
>  }
>  
> -int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
> -{
> -	int ret;
> -
> -	if (load_pack_revindex(p) < 0)
> -		return -1;
> -
> -	ret = find_revindex_position(p, ofs);
> -	if (ret < 0)
> -		return -1;
> -	*pos = ret;
> -	return 0;
> -}
> -

Not that this is new to the current patch, but this patch made me
wonder if we should initialize *pos = -1 in the case of a failure
to find the position? A correct caller should not use the value
if they are checking for the fail-to-find case properly. But, I
could see someone making a mistake and having trouble diagnosing
the problem because their position variable was initialized to
zero or a previous successful case.

Thanks,
-Stolee
