Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B6DC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 13:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2AB23B45
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 13:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbgLINMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 08:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbgLINMp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 08:12:45 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5669CC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 05:12:05 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id cm17so1491549edb.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 05:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LVMU6FtCzZHwH6a5Wmc5QLnl0OufG+9D4W5jF3XQP9o=;
        b=k2YYF9LGJ6pVDl7s3T3vbsjyMgOgZsPrtukekWPq3X4mHrm2DBUQlVu5Yuf4AbqM/P
         yPSMybphT7Mw4kHkd05RHxIEhZuHDB0asMEpm4p8TVeuwaTHnQf67O34zrosbK2EBNP6
         1G7XIe+u2yOX4W+Yv7FX9NSaXD5EyfnMIoS1oJ84sStpWTCCB3lGg5DaXFZmVqfncRxo
         iabEvHNtpY3Yk8zRq8z9c76TY3GGp15lQ65fDVGAtMvevh7sMph0PR2spKxb3VDV2+9V
         KB2n5pdtTg55o2B7XynhzMMWwwMIz0qZ00cT5eV+6tnjgsxm5wz2x4aNahAqculs4VVl
         c4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LVMU6FtCzZHwH6a5Wmc5QLnl0OufG+9D4W5jF3XQP9o=;
        b=nkM2oM8lXxGLq8T+mVgQ4KhB+c0rEi7dlkSLhKuSN3psOcplUZclC0TLvaupvS69WT
         gCKHTFbw9XQy4J900ziq8gbRViDssxU34CkdSmlwOyB6vDhQ1I9/Tz11Y7dqe+r2n+Nv
         K/cvdHyqk2NiiTpUqIfs1eaEO92xEf0ey/8qY/PdR5Q0XxMLZZ4y6O/sN10J2wQrp3Hk
         OrFVDelJTJKDauHnN13pNAu6A5PpZkJHyMOt1J4rJDiwMqjip83VcOVgTR19Sod8o6FW
         z7as10om9cv/YFcCE65PlwEm+QxvUzoib1DuQ91qclvNcZNTFsA6OMnh8vpc04PIKH8c
         X87w==
X-Gm-Message-State: AOAM531nuyqwA2d7HsT7zh3PrVq83ydPjPiHiUdHUtkCm4l3uLHCVJju
        OZPqAXohYMgmEDTENR6DjvgrrAC35WI=
X-Google-Smtp-Source: ABdhPJwklM/Id/fallx51usQ1OF1qM5htPtLv2sII1wmnpMZqAcDkPw6jyLADJQE7P0Sm53vY3kQow==
X-Received: by 2002:a50:8d89:: with SMTP id r9mr1862800edh.144.1607519523727;
        Wed, 09 Dec 2020 05:12:03 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id l1sm1465763eje.12.2020.12.09.05.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:12:02 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 4/6] config: extract function to parse config pairs
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <63fb8ad99742d748dc00306be6d2e05bd0ed583d.1607514692.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <63fb8ad99742d748dc00306be6d2e05bd0ed583d.1607514692.git.ps@pks.im>
Date:   Wed, 09 Dec 2020 14:12:01 +0100
Message-ID: <875z5bxgwu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 09 2020, Patrick Steinhardt wrote:

> +static int config_parse_pair(const char *key, const char *value,
> +			  config_fn_t fn, void *data)
> +{
> +	char *canonical_name;
> +	int ret;
> +
> +	if (!strlen(key))
> +		return error(_("empty config key"));

We just did this check (just before the context of the second hunk in
this patch) before calling this function:

    if (!pair[0]->len) {
        strbuf_list_free(pair);
        return error(_("bogus config parameter: %s"), text);

I think just removing this is best, for such a closely coupled static
function we can just rely on the sanity of the caller, but it should at
least be:

    if (!strlen(key))
        BUG("clear that it's unreachable, and a translator won't bother with it, like _()...");

Aside: It's more C-idiom-y in this case to write:

    if (!*key)


> +	if (git_config_parse_key(key, &canonical_name, NULL))
> +		return -1;
> +
> +	ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
> +	free(canonical_name);
> +	return ret;
> +}
> +
>  int git_config_parse_parameter(const char *text,
>  			       config_fn_t fn, void *data)
>  {
>  	const char *value;
> -	char *canonical_name;
>  	struct strbuf **pair;
>  	int ret;
>  
> @@ -483,12 +498,7 @@ int git_config_parse_parameter(const char *text,
>  		return error(_("bogus config parameter: %s"), text);
>  	}
>  
> -	if (git_config_parse_key(pair[0]->buf, &canonical_name, NULL)) {
> -		ret = -1;
> -	} else {
> -		ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
> -		free(canonical_name);
> -	}
> +	ret = config_parse_pair(pair[0]->buf, value, fn, data);
>  	strbuf_list_free(pair);
>  	return ret;
>  }

