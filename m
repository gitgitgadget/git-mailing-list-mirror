Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E931F516
	for <e@80x24.org>; Fri, 22 Jun 2018 21:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933391AbeFVVmo (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 17:42:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36571 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeFVVmn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 17:42:43 -0400
Received: by mail-pg0-f67.google.com with SMTP id m5-v6so3506473pgd.3
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Z+J+FJk8nfTEPPkyfJK41hyvZotpYhglCKoqoP37ig=;
        b=H8TIwXDIJuTN++hWmOrSyN1yqE+8ZJD5RKFIc8AV6e2gyhnfrMkFfE1gnvnPA7OVB5
         PIsIsdvs2JjGcFsu0UgWakkkafIsRc1fSkX8/84dAXy6amjMLkuZkNZyJu3C6hh92Vvs
         x9S89K3PkYQEajAIQeHxNVCtpWIEsjJ8R3OCFrelJWKFXTmpHz6dTtUtH6YTKOSf2jYL
         AC+Dp5XCjbVOQWjDEbTeOFNijR0PEfWXtqmgOsYr6qZzBdGufc6/po9h8gDzRLPHcDC+
         XHorAp2vEPNxrOSZO8n1PxYHBGwXwZZ9WgLO12Y5C0ixvW7RpYctZZOsKPKjMyywX0Uq
         JOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Z+J+FJk8nfTEPPkyfJK41hyvZotpYhglCKoqoP37ig=;
        b=odEV5M+cohtJLWH4DM6Z+eEAaIAw/ZS6LdKDLkPToOYjW2tQIQs0NpOGXlG+7f4hHm
         fBQjbUT3qiCWz1EHCft9cz057eW5bPk1bu6vFco7b29VThEjOFgvMctpHYD+kBfF/Akl
         rcsJRP9R+6dcF8qbQ4Bivba73BREPYRzd6m+sUT1L8vx+smNvdLQlnrfNUgFn02Kcgwq
         KXT+Yd8zxjpU0OJa6NAweOS0FwcSqZnS8PYeASmJd1H+lQiBrNTjJmXEaZY1vOxpjcaR
         QBW+n6JDG/7JZ01KyzVsSQHac5hS+v5IgJZwDYr3qk94zlvpWZqAvl6samJoay6mcNxn
         6YDQ==
X-Gm-Message-State: APt69E1Rlm5NFs0tdgyp8vE3W4awWIn4q5tkc7flUuAmVXcdaAnXki/e
        xKbOYFW0M65PkpqS5OFYhng=
X-Google-Smtp-Source: ADUXVKKtV5tfPr0WshjCzJB2yb/UJRZa15g9MJxgJOo/x3HuQjk3EHIzRfrtmL6xOqklMVINs+EAfQ==
X-Received: by 2002:a65:4ecd:: with SMTP id w13-v6mr2854777pgq.214.1529703762964;
        Fri, 22 Jun 2018 14:42:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q77-v6sm19564531pfk.152.2018.06.22.14.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 14:42:42 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:42:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com
Subject: Re: [PATCH v3 5/8] fetch: refactor fetch_refs into two functions
Message-ID: <20180622214240.GJ12013@aiede.svl.corp.google.com>
References: <20180613213925.10560-1-bmwill@google.com>
 <20180620213235.10952-1-bmwill@google.com>
 <20180620213235.10952-6-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620213235.10952-6-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -967,10 +967,16 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
>  	int ret = quickfetch(ref_map);
>  	if (ret)
>  		ret = transport_fetch_refs(transport, ref_map);
> -	if (!ret)
> -		ret |= store_updated_refs(transport->url,
> -				transport->remote->name,
> -				ref_map);
> +	if (ret)
> +		transport_unlock_pack(transport);
> +	return ret;
> +}
> +
> +static int consume_refs(struct transport *transport, struct ref *ref_map)
> +{
> +	int ret = store_updated_refs(transport->url,
> +				     transport->remote->name,
> +				     ref_map);
>  	transport_unlock_pack(transport);
>  	return ret;
>  }
[...]
> -	fetch_refs(transport, ref_map);
> +	if (!fetch_refs(transport, ref_map))
> +		consume_refs(transport, ref_map);
>  

Ah, I missed something in my previous reply.

If transport_fetch_refs succeeds and store_updated_refs fails, then in
the old code, transport_unlock_pack would clean up by removing the no
longer needed .keep file.  In the new code, that's consume_refs's
responsibility, which I find much nicer.  It's probably worth
mentioning that in the commit message as well.

Thanks again,
Jonathan
