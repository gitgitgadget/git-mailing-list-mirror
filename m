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
	by dcvr.yhbt.net (Postfix) with ESMTP id 19FF41F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbfITPSb (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:18:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38665 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbfITPSb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:18:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id u186so7676725qkc.5
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RB2iq/tTUxhurr5OQibI28KPns8T9SjwMwMEUW5gbGA=;
        b=eYNCEYHQnbsFzw7kmVLoZvtFjnql6V8lTUr+HAIDvzOGBw0rVHwC4+G+9quIvuwqMv
         h3xc50xBSWdOVnimRlgkGorA7XmYEScYWMK/2z8nOdOUk8nnScde7yXykrbW6zEKVwnV
         5RDeVZgFHWH/zbMB7I+9gQhMv63G9lsYyWctnu63+YuzlQjHRY6K0ORmOUzkRhpJyLON
         VyU9mYYLhq6D6BOsKVFJrKL5H7jqWNo001dZmMbWCdyTCzwuV2qmBtW7HHpmr6ja7wYx
         0Ofe3bWjUlW/k2bYUc2xSje1m0i7wNwWOUDseWRtMbkKzquvvNBeZVlyK0WrzYkPx3+b
         NBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RB2iq/tTUxhurr5OQibI28KPns8T9SjwMwMEUW5gbGA=;
        b=U+GleBbL5R790oziKQIRY1RxY4OoExgsy1aZBDYNhXEsQSGJo3B1GivMZLMZkVavWC
         Xme4S1C5O4EbspCzcf0xNpnEfwkhZMdXGLwncXBrWKzxJ0PHIu3o4By8UipT/VbcXLiG
         mgTR7kibTF7ImgFcjq7un4H0d8HsuHROrTR5bjTGyRtmqMP6EcFhHwXomt1DWHXKJbHq
         km6JJS2Subqw8lMjOoZxOnUe6F7scikHSSHHGxlIPxGbI6XJF8/fQw+Mno/uOybxLQUm
         nDQk5w2jFYe4q/Iy4fHdUOIbD6F/UaJBKqB7fn5MtEoiyVbNglBZCzuAfxDUpfr0XFjt
         JY8g==
X-Gm-Message-State: APjAAAWL2hexBsbRiBdZVAiNzQPkdqgvRuW656In2dIYLIAgFi5dMTOg
        iWOz88X3UnCcw8Iu7axctFjCPBs30/o=
X-Google-Smtp-Source: APXvYqwBhcxiqB3fF6SYrVk20qcayIzhqcktG4oRDg9bRgUAakArGZgI9Tpn/fS4jhMdQyLnQm3O8w==
X-Received: by 2002:a37:e58:: with SMTP id 85mr4210984qko.403.1568992709986;
        Fri, 20 Sep 2019 08:18:29 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:142:491c:a46c:6a48? ([2001:4898:a800:1010:89d8:491c:a46c:6a48])
        by smtp.gmail.com with ESMTPSA id 62sm1200302qki.130.2019.09.20.08.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:18:29 -0700 (PDT)
Subject: Re: [PATCH 07/15] name-rev: extract creating/updating a 'struct
 name_rev' into a helper
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-8-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <84295cdb-a9f1-53b5-c826-27fd92e8ff06@gmail.com>
Date:   Fri, 20 Sep 2019 11:18:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-8-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 5:47 PM, SZEDER Gábor wrote:
> In a later patch in this series we'll want to do this in two places.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  builtin/name-rev.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index dec2228cc7..cb8ac2fa64 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -75,12 +75,36 @@ static int is_better_name(struct rev_name *name,
>  	return 0;
>  }
>  
> +static struct rev_name *create_or_update_name(struct commit *commit,
> +					      const char *tip_name,
> +					      timestamp_t taggerdate,
> +					      int generation, int distance,
> +					      int from_tag)
> +{
> +	struct rev_name *name = get_commit_rev_name(commit);
> +
> +	if (name == NULL) {
> +		name = xmalloc(sizeof(*name));
> +		set_commit_rev_name(commit, name);
> +		goto copy_data;
> +	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
> +copy_data:
> +		name->tip_name = tip_name;
> +		name->taggerdate = taggerdate;
> +		name->generation = generation;
> +		name->distance = distance;
> +		name->from_tag = from_tag;
> +
> +		return name;
> +	} else
> +		return NULL;
> +}
> +
>  static void name_rev(struct commit *commit,
>  		const char *tip_name, timestamp_t taggerdate,
>  		int generation, int distance, int from_tag,
>  		int deref)
>  {
> -	struct rev_name *name = get_commit_rev_name(commit);

A perhaps small benefit: we delay this call until after some
other checks happen. It's just looking up data in a cache, but
it may help a little.

>  	struct commit_list *parents;
>  	int parent_number = 1;
>  	char *to_free = NULL;
> @@ -97,18 +121,8 @@ static void name_rev(struct commit *commit,
>  			die("generation: %d, but deref?", generation);
>  	}
>  
> -	if (name == NULL) {
> -		name = xmalloc(sizeof(*name));
> -		set_commit_rev_name(commit, name);
> -		goto copy_data;
> -	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
> -copy_data:
> -		name->tip_name = tip_name;
> -		name->taggerdate = taggerdate;
> -		name->generation = generation;
> -		name->distance = distance;
> -		name->from_tag = from_tag;
> -	} else {
> +	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
> +				   distance, from_tag)) {

Otherwise this method extraction looks correct.

Thanks,
-Stolee

