Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED80721841
	for <e@80x24.org>; Tue,  1 May 2018 10:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754482AbeEAK0p (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 06:26:45 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:43212 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754477AbeEAK0o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 06:26:44 -0400
Received: by mail-lf0-f54.google.com with SMTP id g12-v6so15747143lfb.10
        for <git@vger.kernel.org>; Tue, 01 May 2018 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2v/K6t63NQJVPX1Fbs5Lw4OaspQ7KIqzg8AF7+Gj6qk=;
        b=alZAL8wAv+Ahl2vfDXtdR5GS5NidsR0v/ZN+SKpKnD5IX2GTxZY0An1cLlobEQXm4q
         kb7zdYFyt4wp2aO5m5lhVQPWDwsXaEUrnqg9bCcVGx47RyqCOS6k7XOgFCoqF/q6J6X1
         Vf0IbyMalmxvhHqwsvtd10JvkRhMCWVkDxga2CGnlsSDyQ0cWJS0ylR2AlrTNM00SgGj
         FiOrbdGmLX+RqoiGkqvQ8kwAsC+PdyJMWmU9478Daih+9GRKjMcCW+hWvKfTRooBYrPP
         O5YNMH6soMLhkgwxR/mORoG8bfHknXbnHJLs2P9W0jv2pqReamvo5mJM1NArmvN8KjVQ
         Kjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2v/K6t63NQJVPX1Fbs5Lw4OaspQ7KIqzg8AF7+Gj6qk=;
        b=E9BHVy/+aNpzE3knuG5OGuKtc4tIlbFpKa0vsdgsLAzOYJScvQrnzukpNVnR1Jdm7A
         qrOVxD7uXJQSQNj6FRgP9arE806oV/dcFlkBe1ahsB/0ajRHxBFcpgzrrWjbFpRdkYCH
         tBMmZaA/mQK9fS1A3pIe7Rj/NVHn4GS+IAYbkOq9DQ8Wmo5WvLikXP9rK9wGDexoo0fa
         rDhjZ+Bwu4GaBTH7jJSGWAPvrZk9kr+5CRajTCjs74mt28J65WxAcc71Isz0d55FEhli
         3rfAsWPl51r4xonUX07+1OC93bLfCM0Oz1go5IPegSwD0NaVxhZ+MU8Xrwu5cBUM25Yf
         3c6Q==
X-Gm-Message-State: ALQs6tDrUJcbhJoU32Ma5zQbeS/ynoofs6Ti6ES7XkckJhP/3gM+Pzle
        SBkgLpahxvyCUz/Cwzaogf13sg==
X-Google-Smtp-Source: AB8JxZqSv412roBolwy4D3X++WVPDg4mvrOU3GIvTJDyahXhtzqOcHKK7gemIdK9Z5BLh/+VULTVNw==
X-Received: by 2002:a19:a401:: with SMTP id q1-v6mr9693550lfc.55.1525170402663;
        Tue, 01 May 2018 03:26:42 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b202-v6sm1936603lfg.83.2018.05.01.03.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 03:26:41 -0700 (PDT)
Date:   Tue, 1 May 2018 12:26:40 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/41] pack-objects: abstract away hash algorithm
Message-ID: <20180501102640.GF15820@duynguyen.home>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-10-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423233951.276447-10-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 11:39:19PM +0000, brian m. carlson wrote:
> @@ -1850,7 +1852,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>  	/* Now some size filtering heuristics. */
>  	trg_size = trg_entry->size;
>  	if (!trg_entry->delta) {
> -		max_size = trg_size/2 - 20;
> +		max_size = trg_size/2 - the_hash_algo->rawsz;

This may be questionable. Note the "heuristics" comment above. I'm not
even sure if this is hash size or some magical-yet-randomly-good
value. Just wanted to bring the attention for other people with better
understand of this code to see

>  		ref_depth = 1;
>  	} else {
>  		max_size = trg_entry->delta_size;
