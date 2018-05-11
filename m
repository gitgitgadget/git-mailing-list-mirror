Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C8AA1F406
	for <e@80x24.org>; Fri, 11 May 2018 23:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeEKX2p (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 19:28:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46814 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeEKX2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 19:28:42 -0400
Received: by mail-pg0-f65.google.com with SMTP id z4-v6so3021374pgu.13
        for <git@vger.kernel.org>; Fri, 11 May 2018 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TDeaJoDXJ8iLEx8y4kmnX9WoxTQz6npk6VfFvN0bxss=;
        b=UOKtJrOc4+YBrhHqrIfs9S4DW2a2ITuLDQXsssEq1Ck4NjP/4ljgI6DQ4wSe/HYvhz
         J3iGngrNPj2G9keADjgryhTNgjmf+CGkMZ2zKRc0ojPYc0DCx1casc9Lo3U4dEfRbRqU
         mxv6YX6343/4dgQxWFj/T9F6pKpJ9osqHJwrL9usDkoAn1YjmpSANKUXOeGwA25BtHLm
         RzLHZ2s8Dxtlhk9O3FNplDUe12N4c161pui13QXnXeBe1UnbwXWrcXPEf2tW9AZz04Yu
         zzqJY2rpfR8tMQPe4W1JH19DgDpDBvSpRh1lWIOBrHXee9v76f1BhGQYT8cPD0Viv1Bf
         T1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TDeaJoDXJ8iLEx8y4kmnX9WoxTQz6npk6VfFvN0bxss=;
        b=tDOsvDC+gQY0ctXIbwFdcEuOHmhhsl+X1hxHVyMrUph9QUkKK1sw+yFdsd2vRzMMUx
         9Dn6XTNnHNiy+TwVmVold7WawsS97fy6P7C0lvc2aPRKefC2k/t9cZhhFfPJOp3dUeIm
         6KL5EVfV5P/nzEHUYFdQj8cFLJ9YrW+D6kZ4GqNmBOGR/IKYBvjZH0qErp+e1wCaJ8U/
         EmK5Nr1uYH1P62Cog64Lx5FYAvOIgCXcO4Ugf7+XAqVq9NV3OC+tX7dYCDVf4TqDC4Gz
         E+eH4D02yPuJDepT57ScpKMvE+TWopn37viLe7sd5LQ5Mdu0xZ0zeNUeS45MuCIY+yP/
         x7OQ==
X-Gm-Message-State: ALKqPwfnCZ0pHnLwo1e8Re6jKVVNmi7ka/6zqa2ZmT751S9pLnjvMEla
        dN+1KMYo6/FB/jyD++zVA9Ul2G6A
X-Google-Smtp-Source: AB8JxZrS5+xHfU2zztawfSe6n2m//0erTDeAEcmbwi+EJgdU9m2feS4+yAZALBD+j8zcSeQCFwpKqg==
X-Received: by 2002:a65:4a02:: with SMTP id s2-v6mr816167pgq.265.1526081322216;
        Fri, 11 May 2018 16:28:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s88-v6sm10828483pfe.43.2018.05.11.16.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 May 2018 16:28:41 -0700 (PDT)
Date:   Fri, 11 May 2018 16:28:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] git-submodule.sh: try harder to fetch a submodule
Message-ID: <20180511232840.GB41222@aiede.svl.corp.google.com>
References: <20180511231751.162855-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511231751.162855-1-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> This is the logical continuum of fb43e31f2b4 (submodule: try harder to
> fetch needed sha1 by direct fetching sha1, 2016-02-23) and fixes it as
> some assumptions were not correct.

Interesting.

I think what would help most is an example set of commands I can use
to reproduce this (bonus points if in the form of a test).

> > If $sha1 was not part of the default fetch ... fail ourselves here
> assumes that the fetch_in_submodule only fails when the serverside does

I'm having some trouble with the formatting here.  Is the part
preceded by '>' a quote, and if so a quote from what?

> not support fetching by sha1.
>
> There are other failures, why such a fetch may fail, such as
>     fatal: Couldn't find remote ref HEAD
> which can happen if the remote side doesn't advertise HEAD. Not advertising

nit: it can be useful to have a blank line before and after such
example output to help both my eyes and tools like "git log
--format='%w(100)%b'" to understand the formatting.

> HEAD is allowed by the protocol spec and would happen, if HEAD points at a
> ref, that this user cannot see (due to ACLs for example).

A more typical example would be if the ref simply doesn't exist (i.e.,
is a branch yet to be born).

> So do try even harder for a submodule by ignoring the exit code of the
> first fetch and rather relying on the following is_tip_reachable to
> see if we try fetching again.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 24914963ca2..13b378a6c8f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -614,7 +614,6 @@ cmd_update()
>  				# is not reachable from a ref.
>  				is_tip_reachable "$sm_path" "$sha1" ||
>  				fetch_in_submodule "$sm_path" $depth ||

Is keeping the '||' at the end of this line intended?

> -				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
>  
>  				# Now we tried the usual fetch, but $sha1 may
>  				# not be reachable from any of the refs
> 				is_tip_reachable "$sm_path" "$sha1" ||
> 				fetch_in_submodule "$sm_path" $depth "$sha1" ||
> 				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"

Should this error message be changed?

Thanks,
Jonathan
