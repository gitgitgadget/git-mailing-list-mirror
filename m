Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E27A22047F
	for <e@80x24.org>; Mon, 18 Sep 2017 16:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbdIRQiO (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 12:38:14 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:49157 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932705AbdIRQiN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 12:38:13 -0400
Received: by mail-pf0-f178.google.com with SMTP id l188so505617pfc.6
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=npa8itKouv9EKtanGUdjHek281iJ0FKif1bQKsBryIk=;
        b=aZ7oXcjKYgCactEpEZw0iiO1gODX6hj0gfpxKB7juOwIcet7mZMQzxIQKJCMSeyUoM
         E5dU1P34uA0MNl5SJ9rR9+D/90r84q63VTTwFrm9ps/ZGDUH0UsZEiJq1sYkn4eBmLZM
         +xgL1ER26hjUvwaeoaPMGEFzWEh/oV3VzCPq4kTLuLxPhhGtpsGoBNUPuiXAaM9qBAKE
         s5GPhQ643DszNm441LjCNv+NdraE6N2RFcnMnHO0MlIMs04W9OlHvitwP+VEcryKt38o
         oWVdc6gNSGdA1vXTcfB4OWrsVpawqCQDVsA0Ip31ZUjr+oJ37Y8iQJFEN6/c1MWwL/gq
         2BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=npa8itKouv9EKtanGUdjHek281iJ0FKif1bQKsBryIk=;
        b=lI4BKPK2kLjzDY9IgDulm7ibej6MYQLChuD15tcXWqAa/gv/tWy/4rZrz68W10+IJV
         2mYOerGT07R0GE7dkr20JYAl05YqCVVBE6cnpzfkbjQM7ov26mwiTExGWbTIDXx3XDiE
         GKX+pKhRzeCs0HRi2tVb5WXObHu6/QyKqYf0ruEVGnuGxcNjQ/bz0qi2Ot3QmQpx+I6I
         6H6YtUDvQQk3yOhDUGMxwWl7Utt8qhL5ssgY8+UlAoEKC+xbwrdb0tQpwLDqUM0pQvqk
         mOBG1kIKdxODZutI3XhOwz4cgpcHqv6lXPu6OtCjpqevBlqZg9yLsS6mVTdU427f8cV2
         1UMw==
X-Gm-Message-State: AHPjjUjrB7dyJRAMk6Szpw0kEd1XpChNU3j/ehoxYSZSpKfphsp2Zdnk
        AQiRE5vB/eIdNENv
X-Google-Smtp-Source: ADKCNb4bumcRT6lyaa52XFDC7TbWbK7jnGF1nYJE+e8OMW2LejV7uXZslClCi9LNtF9ITBCcayRN+g==
X-Received: by 10.98.35.210 with SMTP id q79mr32844596pfj.340.1505752692574;
        Mon, 18 Sep 2017 09:38:12 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c140:486c:cfb0:5862])
        by smtp.gmail.com with ESMTPSA id s186sm16329082pgb.89.2017.09.18.09.38.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 09:38:11 -0700 (PDT)
Date:   Mon, 18 Sep 2017 09:38:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] protocol: make parse_protocol_version() private
Message-ID: <20170918163810.GA144331@google.com>
References: <1cb7d40d-3f11-71a0-6e53-dced7810a0ca@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb7d40d-3f11-71a0-6e53-dced7810a0ca@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/17, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Brandon,
> 
> If you need to re-roll your 'bw/protocol-v1' branch, could you please
> squash this into the relevant patch (commit 45954f179e, "protocol:
> introduce protocol extention mechanisms", 13-09-2017).
> 
> This assumes you agree that this symbol does not need to be public; if
> not, then please just ignore! ;-)

Thanks!  I've updated my local version of the series to reflect this.

> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>  protocol.c | 2 +-
>  protocol.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/protocol.c b/protocol.c
> index 1b16c7b9a..369503065 100644
> --- a/protocol.c
> +++ b/protocol.c
> @@ -2,7 +2,7 @@
>  #include "config.h"
>  #include "protocol.h"
>  
> -enum protocol_version parse_protocol_version(const char *value)
> +static enum protocol_version parse_protocol_version(const char *value)
>  {
>  	if (!strcmp(value, "0"))
>  		return protocol_v0;
> diff --git a/protocol.h b/protocol.h
> index 2fa6486d0..18f9a5235 100644
> --- a/protocol.h
> +++ b/protocol.h
> @@ -7,7 +7,6 @@ enum protocol_version {
>  	protocol_v1 = 1,
>  };
>  
> -extern enum protocol_version parse_protocol_version(const char *value);
>  extern enum protocol_version get_protocol_version_config(void);
>  extern enum protocol_version determine_protocol_version_server(void);
>  extern enum protocol_version determine_protocol_version_client(const char *server_response);
> -- 
> 2.14.0

-- 
Brandon Williams
