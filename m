Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6151F45F
	for <e@80x24.org>; Mon,  6 May 2019 21:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfEFV6h (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 17:58:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45786 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEFV6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 17:58:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so7456570pfi.12
        for <git@vger.kernel.org>; Mon, 06 May 2019 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VuDRSUbUzNOCLpq6o0UD+vLSySu4ErTTzfGPistrAyY=;
        b=kbC/8a+GVGHIinyZIJLP7pfp+B3MoR4V9QmNgfEOoy9rWLdasQK0K8L7bg+diRa1sz
         QslJrOWy8Eq9q58AVN9gwZOR88lWrBaTmh95pCu5IcKrcgiPQUIgP+Jvry/DPIVivpnv
         e7yw+W1/ODOfoKUCKmAQcny3XYGYtKvL9eOPOAT0D7ehk+M6B5gsEfEUOpoxFhjhFLvM
         6ON69S1z3EOPk5sRApY+Zq++szm9n9gVw4AOKWKX2KDRAvM2YaO/Rnc6jI/llt1XBNAf
         rQ5okzLNRIJJg5pMllLzcWrzpcNqOUukSx2v75ko9qIUnjhVR8xaJ41c2gMIiqVADxjO
         tcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VuDRSUbUzNOCLpq6o0UD+vLSySu4ErTTzfGPistrAyY=;
        b=e2jhXOC3+S0W0uQLqVN5v+SvicpggxUjYmYaDzwcnTPOGH6wQ6QCBK9Q+hf+/Sv319
         ixjhIne3Vmvv9fq5/R32SN79iVQ5laGVas3HEPZktJr7fpKsls/y3LxNBu96XgzUANIh
         TEPm+D5dV6HglXvwux78P4xBOOpMoshpCfEvtGC8MNbRlYthMrWMt9x/yuLW0TRGPKS6
         gUE30f2rpSje1vwqKz29O97P4kWT/2rhDjPxyBqxAMdud+LEXe+VXnKTtgyaBO5D9BiK
         G5afnT0GSjHgfNCOCbhLfF9bXdiaznzm3MKkkP2q6pmlfjgiRTVL4hjAItrZ3o1JMzT6
         mXDQ==
X-Gm-Message-State: APjAAAW6dfqzbp+OZ4YGOPolygOmr0mXpcAh10LKdlpmC1gc5U8ur5ik
        F+0t4PyJH0dLZiPFFV0Llm5ftg==
X-Google-Smtp-Source: APXvYqz2sV1sJ7K1DDKy/v1uFxOdSmoXPIs6YYLDa9gqKIK5nJQR+krj93M3nMHkYicDGeCetaC5Hg==
X-Received: by 2002:a63:6ac3:: with SMTP id f186mr35004942pgc.326.1557179916325;
        Mon, 06 May 2019 14:58:36 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id w125sm18702706pfw.69.2019.05.06.14.58.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 14:58:35 -0700 (PDT)
Date:   Mon, 6 May 2019 14:58:31 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, stolee@gmail.com
Subject: Re: [PATCH] commit-graph: fix memory leak
Message-ID: <20190506215831.GB85211@google.com>
References: <f4ab2a50873b2fd91926d7401f784479504d1b10.1557178485.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4ab2a50873b2fd91926d7401f784479504d1b10.1557178485.git.steadmon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This change looks good to me, and like good evidence for the benefits of
automated tooling :)

Thanks!
 - Emily

On Mon, May 06, 2019 at 02:36:58PM -0700, Josh Steadmon wrote:
> Free the commit graph when verify_commit_graph_lite() reports an error.
> Credit to OSS-Fuzz for finding this leak.
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  commit-graph.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 66865acbd7..4bce70d35c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -267,8 +267,10 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
>  		last_chunk_offset = chunk_offset;
>  	}
>  
> -	if (verify_commit_graph_lite(graph))
> +	if (verify_commit_graph_lite(graph)) {
> +		free(graph);
>  		return NULL;
> +	}
>  
>  	return graph;
>  }
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 
