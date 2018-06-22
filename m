Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB961F516
	for <e@80x24.org>; Fri, 22 Jun 2018 21:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbeFVV00 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 17:26:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40498 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeFVV0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 17:26:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so3766010pfe.7
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gcl98DgyX3/6byo3S+wGuM+JlFgh7xJVmyHeWgiCZbY=;
        b=L438PhC098dY++WGbvk++WvYkvOyxy6nzZAvh2bHNpFcZ0sERV8Bj6GbP7q5dJ7kvw
         RPEM8YulAc7KKt7dkIdDGIVKoy9E+U5EElnydtbuu+DwegTlp8qgWLXGY/ejyPFJHTVT
         6wE+JNR38kdChmNnHTYwH1s3pGoj2enueBsg4qjjjaqzToRHFkWLYoQhH9eMxoaz+f/t
         8ADMTD2XPeageLprJVsPNi2IelU9FJAgCgVtxIzwUwzuQqk1lwuI06xQaraZ4k4Z8mDn
         PrnLyHgLXFvGCsiEDc0X8nqtUNmpoCACPOb2Eqo2f672pWQ9hoctUEF5m8RllLvgkrve
         e0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gcl98DgyX3/6byo3S+wGuM+JlFgh7xJVmyHeWgiCZbY=;
        b=nCsYLp29QyszgfiwFkxYFb/bJdvlRnunxYZLI5rqN5esMyh4rmnuFQu3xSa4jQ56a1
         yhqTNwwVLqA1VcttvdTpz7Djq+vFZeQLKvJCRgDiJn1SMepmP3x+e2FJ+kskhdykovgk
         gJaxYFExC7fWgfQ07bNX4uXDcwLXFgNTN0gaOVGXrYSFh9NfYJP4YH8VJaEYU3VB13cj
         h18eGh5/fp1y2DowL/RbSkMrnXFAhdBe63lceo7CwaVnA+BmsbeXllTKMnR69Cl8W9qA
         0ono3ujCIzWQGiWDskqUFihtcklG3r2jxpZVf+eoEGGTavFKLhOqHs55NsfJFfQ11tWy
         qKaQ==
X-Gm-Message-State: APt69E2nMHYE978ix4iIAeIqKd9a3++qqJYTH2lCCkGBLZ3AKR+wsYHP
        vdoCnrDCtwFF4OXzdBIwrw8=
X-Google-Smtp-Source: ADUXVKKvIyVJ95im13noK030xjA1IfyRTN3B1CN9ptMETnICfabuQPiy8o0js8KFEHQyQy0URQeLGA==
X-Received: by 2002:a65:4484:: with SMTP id l4-v6mr2772173pgq.378.1529702785129;
        Fri, 22 Jun 2018 14:26:25 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n83-v6sm24429336pfi.147.2018.06.22.14.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 14:26:24 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:26:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com
Subject: Re: [PATCH v3 5/8] fetch: refactor fetch_refs into two functions
Message-ID: <20180622212622.GI12013@aiede.svl.corp.google.com>
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

Hi,

Brandon Williams wrote:

> [Subject: fetch: refactor fetch_refs into two functions]
>
> Refactor the fetch_refs function into a function that does the fetching
> of refs and another function that stores them.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/fetch.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

It's hard to understand the context for this patch based on this
description alone.  E.g. is fetch_refs too long to follow?  Or are we
about to expand it?  Or are we going to use the factored-out subpart
for something else?

[...]
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

Paraphrasing the old code:

	try quickfetch
	if that fails, we have to fetch for real

	both of the above "lock" a pack using a .keep file to
	avoid races

	if the fetch succeeded, now update the refs

	finally, "unlock" the pack by rm-ing the .keep file

Paraphrasing the new code:

	try quickfetch
	if that fails, we have to fetch for real

	both of the above "lock" a pack using a .keep file to
	avoid races

	if the fetch failed, "unlock" the pack by rm-ing the
	.keep file.

Do I understand correctly that this is preparation for changing the
'update refs' step?

As a minor nit, I think this would be easier to read if we treat
the unlock_pack as a destructor.  Something like this:

	int ret = quickfetch(ref_map);
	if (ret)
		ret = transport_fetch_refs(transport, ref_map);
	if (!ret)
		/*
		 * Keep the new pack's ".keep" file around to allow
		 * the caller time to update refs to reference the new
		 * objects.
		 */
		return 0;
	transport_unlock_pack(transport);
	return ret;

> +
> +static int consume_refs(struct transport *transport, struct ref *ref_map)

The name consume_refs doesn't make it clear to me what this function
is going to do.  Maybe a function comment can help.

I.e. either the name or a comment would tell me that this is going to
update local refs based on the ref values that the remote end told us.

The rest of the patch looks good.

Thanks and hope that helps,
Jonathan
