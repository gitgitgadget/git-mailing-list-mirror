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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E04D1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391703AbfITP1w (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:27:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38204 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbfITP1w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:27:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so9119720qta.5
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gq+y/R1dUTCaH9UmtoKVLgYI130yuodYnKk08Rmnygw=;
        b=i0HmjTcCjXQo8fkm3P8dsQmTfV5HnpHDj5klAsXO41PczOuSjaaKGFOM8uCTaFQ1Gn
         5R486w41M071gSNvsnaAvzotzS7dEr8Ssv62TV+zHISy8wlD1vqYZQc4vUGmbZKXNJzq
         PS9GypycoAjRJwMKvcs1dsEsxTG7Q+NPs8EL6cVoGUv10e7s+kpbIs13uSOwi5qMkAGv
         N0o5wKy0btyuHXY1sGIn2+zaRB8woLATdmD77tbtmQXXe2UyoF2ttyGlepRtQ+XJ3MfH
         yFnetpirXlLJx1xJ/Or03DoIzFOSYAYJeE2iEUzFP5i5DZrWKIUwc8Ju3UhsV06EJ/tb
         UFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gq+y/R1dUTCaH9UmtoKVLgYI130yuodYnKk08Rmnygw=;
        b=P8/2xoWA422BFT94wHb0/+U8TMBD1rReabpuBFszNxacmoQKt2Z4AiwfYu1g8+II/d
         O9R6cxEPpoznzOK/GarAQJHkG4+y6ZlgM40/uAyGeUPHQkr390FVma1bhMRTT95vxtTe
         UksNrEr1ne56YNnK6qlAdWhLKjRgmfyvxL8n0QBGYdwG+Nrmk0t6T2/zB+HNRglYtV6L
         AkF7C35cxn5/6u08e9nkAHDlNqwSzcEMRVG5kpTncQGLITFyItc2nNR3nTOR0IhH89Uo
         U27Ywq2CP9e5X0SXErAJkKxpVm72lMnRy8NSR+O4AzlrInI2lBlyVjzrqF3kHZVwV+dC
         T0OQ==
X-Gm-Message-State: APjAAAV3H/LMqz6R9tPffD58gWYIpKcLVj3CI3qzvr3kY3yToCZZHr5Z
        LpLYpHpN/FufPxS6zBb+WT5JVZe8hmY=
X-Google-Smtp-Source: APXvYqyYc1B99Augt8ym4aq5y7evkyG0aZcuKM7jFl81h+3vJOG1UESZkIIerXsY7Rv00jkqpAAtWA==
X-Received: by 2002:a0c:f3c1:: with SMTP id f1mr13552655qvm.165.1568993271226;
        Fri, 20 Sep 2019 08:27:51 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:142:491c:a46c:6a48? ([2001:4898:a800:1010:89d8:491c:a46c:6a48])
        by smtp.gmail.com with ESMTPSA id i1sm1085197qkk.88.2019.09.20.08.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:27:50 -0700 (PDT)
Subject: Re: [PATCH 10/15] name-rev: restructure creating/updating 'struct
 rev_name' instances
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-11-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <515a4590-47e8-fe95-833b-307364fc8fa4@gmail.com>
Date:   Fri, 20 Sep 2019 11:27:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-11-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 5:47 PM, SZEDER Gábor wrote:
> At the beginning of the recursive name_rev() function it creates a new
> 'struct rev_name' instance for each previously unvisited commit or, if
> this visit results in better name for an already visited commit, then
> updates the 'struct rev_name' instance attached to to the commit, or
> returns early.
> 
> Restructure this so it's caller creates or updates the 'struct
> rev_name' instance associated with the commit to be passed as
> parameter, i.e. both name_ref() before calling name_rev() and
> name_rev() itself as it iterates over the parent commits.
> 
> This makes eliminating the recursion a bit easier to follow, and it
> will be moved back to name_rev() after the recursion is eliminated.
> 
> This change also plugs the memory leak that was temporarily unplugged
> in the earlier "name-rev: pull out deref handling from the recursion"
> patch in this series.
[snip]
>  
> @@ -276,11 +277,17 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
>  		path = name_ref_abbrev(path, can_abbreviate_output);
>  		if (commit->date >= cutoff) {
>  			const char *tip_name;
> +			char *to_free = NULL;
>  			if (deref)
> -				tip_name = xstrfmt("%s^0", path);
> +				tip_name = to_free = xstrfmt("%s^0", path);
>  			else
>  				tip_name = xstrdup(path);

So this xstrdup(path) is not a leak?

> -			name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
> +			if (create_or_update_name(commit, tip_name, taggerdate,
> +						  0, 0, from_tag))
> +				name_rev(commit, tip_name, taggerdate, 0, 0,
> +					 from_tag);
> +			else
> +				free(to_free);
>  		}
>  	}
>  	return 0;
> 
