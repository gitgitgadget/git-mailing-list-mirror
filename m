Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 171991F403
	for <e@80x24.org>; Tue,  5 Jun 2018 23:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeFEXfI (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 19:35:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35417 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbeFEXfH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 19:35:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id i5-v6so2543142plt.2
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 16:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mGMwz4kkkp0+v75SVHxOOF/X6QKX2EpkzYifmK0gjio=;
        b=mwX+KgAIOgjMcC3kc8gfGmBvmKKHcNaW/4840v5RzZAuj87zb3QuvP5del1mquffPZ
         jDOcyqyAJB1SxCw/WPYmwl4SpOP6h4M/cQMoSu4Y4nrz0ZOJHV6SV+2MqpjcLlsmHoUA
         MJ3MhZpwPmRTaZDWKTWH8D8HfXY+lzoQO1Y7lwHG4AQc/nbtfXhYe5fnFh0E37xqn0Gd
         6+VgSTn9WjwiqAK8aFuixrnna9c5zIkDozaw20sJiGFUvjBnMhs/EZckxW7QWAi6/kUH
         Xh6faC6kL65vcEwUo1VEWhxQLa2lKZt2nm7OsvasBKCk8FO/mTq43E5PM2f0XbxFLgJS
         fvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mGMwz4kkkp0+v75SVHxOOF/X6QKX2EpkzYifmK0gjio=;
        b=SaDABmnzX7vDw4rggji12R/v3bX481/MPYcBf5yq/AkX6fOTfE2IVGJh0WG8qy5CQD
         A055GZqhGCRN27H8tdTYZNQ7BUj77SISVKzaLNgIU8ULwrmeWr82yStBgOuBgSZGH7fe
         JYRwvm78iHothqQp1En1XCt4f+12ocKJXIIzGtCbXx+Hk2Yk37yQXWhHpMovReM9tJs8
         gsOHYM0WGomvsoSsDg81yAATF6Sanw7g1Za5ZaMm49xvhLhA9LRytDEsp8CWg2nCTsav
         DC6EWy4s64Pzg/lWQdoS+FXGKYq16zLCv1aKgdD/tHv7vPycW+bD/M6tyYnGwlrNX9w5
         eYdg==
X-Gm-Message-State: APt69E2k2uWF3Xvp+gzQsa1+Eew3c8V9CBWVo+6Evpd4iu7KSSZ+TZ7W
        tXpwRB5wHS/QW4VEIx6hzEU=
X-Google-Smtp-Source: ADUXVKLXx4Y0e3qDb9h84vHNw5CeVmkJSw/Y3HkFYTaib1LEMliZNFkGdQU38llAT046HsJtTMtGOQ==
X-Received: by 2002:a17:902:8a87:: with SMTP id p7-v6mr659832plo.278.1528241706887;
        Tue, 05 Jun 2018 16:35:06 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 4-v6sm17900245pfi.78.2018.06.05.16.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 16:35:06 -0700 (PDT)
Date:   Tue, 5 Jun 2018 16:35:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Subject: Re: [PATCH 4/6] fetch-pack: make negotiation-related vars local
Message-ID: <20180605233504.GG9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <8bda254e73fb00ff8448031002c7619bbe1dc285.1527894919.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bda254e73fb00ff8448031002c7619bbe1dc285.1527894919.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Reduce the number of global variables by making the priority queue and
> the count of non-common commits in it local, passing them as a struct to
> various functions where necessary.

\o/

> This also helps in the case that fetch_pack() is invoked twice in the
> same process (when tag following is required when using a transport that
> does not support tag following), in that different priority queues will
> now be used in each invocation, instead of reusing the possibly
> non-empty one.
>
> The struct containing these variables is named "data" to ease review of
> a subsequent patch in this series - in that patch, this struct
> definition and several functions will be moved to a negotiation-specific
> file, and this allows the move to be verbatim.

Hm.  Is the idea that 'struct data' gets stored in the opaque 'data'
member of the fetch_negotiator?

'struct data' is a quite vague type name --- it's almost equivalent to
'void' (which I suppose is the idea).  How about something like
'struct negotiation_data' or 'fetch_negotiator_data' in this patch?
That way this last paragraph of the commit message wouldn't be needed.

[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -50,8 +50,12 @@ static int marked;
>   */
>  #define MAX_IN_VAIN 256
>  
> -static struct prio_queue rev_list = { compare_commits_by_commit_date };
> -static int non_common_revs, multi_ack, use_sideband;
> +struct data {
> +	struct prio_queue rev_list;
> +	int non_common_revs;
> +};

How does this struct get used?  What does it represent?  A comment
might help.

The rest looks good.

Thanks,
Jonathan
