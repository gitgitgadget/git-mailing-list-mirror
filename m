Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE2D1F51C
	for <e@80x24.org>; Tue, 22 May 2018 18:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEVSz2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 14:55:28 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44863 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEVSz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 14:55:27 -0400
Received: by mail-pg0-f66.google.com with SMTP id c22-v6so7585525pgn.11
        for <git@vger.kernel.org>; Tue, 22 May 2018 11:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FnjwPEm1onSukdr++VNhwL3EORISQbOhfF6d06J0mNw=;
        b=lco3qTG9YolutNGKlBc9tj4IviPZGVRcu+tUihw1HipHwmgtK6pxXgg2yrUCQHadNh
         A0qWUNPo01w032GxJboxFK2ZVYKn1P4pSUmge9BtUmpVJ7u5YWW83EMs7s2091rCbuZ+
         u6ntx5w5/ijZMjckOdhyogW7d9KGeTWQu1iA/FKjKUQknDGxOGVnbXgRzeZ7NGWgRpzW
         HwDE7EqoW+YYgXPFWIGlWH0BfRE7MWl6UduvX3EM2MlEC8ECRk2GbxUnlHHObB4WatxI
         wGK7gAPyGak3r7gAvlmNgX/nl9zwL7ppiby+ElECOHVBMLXP//KvkDGsFTHp2+G1T3lM
         TLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FnjwPEm1onSukdr++VNhwL3EORISQbOhfF6d06J0mNw=;
        b=ftAhCp34A5ARSFvid8d/14oOCvFitFKRJK53y60P+wjupay5SR5v8SuJsOmq8ashLh
         srDq4QEOQueOkrPHK233/52sghQtyGHMSXPskzwBAfIiUfY2wkal3F8UEVJRyNvGJATP
         4AKhGr0VhxTT66ugxZIQ6yoEAh7s8sHARV1PLSbJu1QWlRqevk+VkiVG0uc3k9ZhX4G3
         MEc536zCPxHN8U3mWBceaVXzJKaSxp7knZUGKvDcpKh5OZ9Xc8XXmCHvl6YhL33P24Jh
         gqhJd9ZW+jPLL6HCzj8nrLNpuqDSC5XQ3rFhRuZxwtunbmMFcz86Cw1WXOQEcEOPTgft
         IRhA==
X-Gm-Message-State: ALKqPwe8M61FAcDaTM2M1dB7U1l0rSujexELcagb1r8edUlwUtpc9olo
        x5plJQW6PmFO3H3gUVsG0mwGytjd
X-Google-Smtp-Source: AB8JxZrq6UjPSYME8iq6I4zLNvwuLNvrG6VE/6YdYHr156dZmW3lI1w1QgOQtyQfwj8jiZLiQI/gQQ==
X-Received: by 2002:aa7:8084:: with SMTP id v4-v6mr25350706pff.105.1527015326961;
        Tue, 22 May 2018 11:55:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v5-v6sm27032413pff.130.2018.05.22.11.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 11:55:26 -0700 (PDT)
Date:   Tue, 22 May 2018 11:55:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v2 2/2] remote-curl: accept compressed responses with
 protocol v2
Message-ID: <20180522185524.GM10623@aiede.svl.corp.google.com>
References: <20180521234004.142548-1-bmwill@google.com>
 <20180522184204.47332-1-bmwill@google.com>
 <20180522184204.47332-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522184204.47332-2-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Configure curl to accept compressed responses when using protocol v2 by
> setting `CURLOPT_ENCODING` to "", which indicates that curl should send
> an "Accept-Encoding" header with all supported compression encodings.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  remote-curl.c | 1 +
>  1 file changed, 1 insertion(+)

Yay!

> diff --git a/remote-curl.c b/remote-curl.c
> index 565bba104..99b0bedc6 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1259,6 +1259,7 @@ static int proxy_request(struct proxy_state *p)
>  
>  	slot = get_active_slot();
>  
> +	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
>  	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
>  	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, p->service_url);

Can this get a test?

I'm particularly interested in it since it's easy to accidentally
apply this patch to the wrong duplicated place (luckily 'p' is a
different variable name than 'rpc' but it's an easy mistake to make if
applying the patch manually).

With or without such a test,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
