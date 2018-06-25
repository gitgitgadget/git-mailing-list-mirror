Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF541F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964899AbeFYSEB (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:04:01 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:46029 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934041AbeFYSD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:03:57 -0400
Received: by mail-yw0-f202.google.com with SMTP id z64-v6so10767904ywd.12
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=lgB01FHQxI4GvA83VSQo3nchHSW7CCMbMbrI5V3Qnjw=;
        b=KTgwZFdvd+bmmLQp0QwyahfGCbC8h1XcJ2ULUG2VPT9g5gGan0J2Vu+c0sdXrk97mX
         okLMydcFrQRTSmgXl32GpVpanEYSW7wk1qLGv5OE5AilXZlpUMyXV6fzax1Gua3eUrod
         YgeAgYHvL6zeHh03V3dYWYCdOLglcS4A1PwIohffvxwlnIFx3mmzyyxB+M5kokrQ46Yp
         7OoOyyLajadaKBTHNNCk08re0/JPunpj/zUvo98ZgJWNOtvxeTTNaVCBQps9IrZ7EUkA
         CL4KTcsPa+KBHtOY1PRqyOvqM8Vh8dUuDt7cEVKiO+VUqJnCqp8JlJu6tTkav7hOROeH
         L6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=lgB01FHQxI4GvA83VSQo3nchHSW7CCMbMbrI5V3Qnjw=;
        b=jj8F9yQ3uPyba0SBS5HRcOHt1FrD/DaMK9YavpxKZpEbXm9Q2UYLnt2fDGs2lwLLrk
         03AMM5Uznh5cwdlHuPR6xSUr35LOohLLwSkZtqUTnW7I05DpZUpwTPddW3ndPt7nw4oQ
         0eUnw/yNMme8Dt2D0zkgc6HiCjWHjVV/6wbPmSxM0flr/Qxb2/jAvOu9JzmSq0AQZYTg
         GKkKj7Syv4z7UzpUjyAamgunCDxAIMSW+43xWAex27WfMhUcD4brt20x5taadaAOCdws
         DRRzXq+J/F3MGDteZnAIojLzk/ZCnan8u42HYy6T9C7zJ95u3Ctea4W8kOhawTcvZNwq
         mkzw==
X-Gm-Message-State: APt69E35b78HURQLgPgI4CiEArjxLeZh/tb94tuFpB4rfqxcAQXhU7Vu
        iZ7xrWpjX9mJpkQ4xiCsZtmY593DTueNsh2LgbE2
X-Google-Smtp-Source: ADUXVKIjZZnP2zFFn2VB/RqcP9VTlUWaaaElHElVqYNXaU5DPzA2AWHwhhM+TjCPKxvsaeCsIC4jxw7iaWSD1/PZg9aV
MIME-Version: 1.0
X-Received: by 2002:a81:a415:: with SMTP id b21-v6mr3516831ywh.218.1529949836816;
 Mon, 25 Jun 2018 11:03:56 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:03:53 -0700
In-Reply-To: <20180620213235.10952-8-bmwill@google.com>
Message-Id: <20180625180353.227420-1-jonathantanmy@google.com>
References: <20180620213235.10952-8-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH v3 7/8] fetch-pack: put shallow info in output parameter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  static void update_shallow(struct fetch_pack_args *args,
> -			   struct ref **sought, int nr_sought,
> +			   struct ref *refs,

update_shallow() now takes in a linked list of refs instead of an array.
I see that the translation of this function is straightforward -
occasionally, we need to iterate through the linked list and count up
from 0 at the same time, but that is not a problem.

>  			   struct shallow_info *si)
>  {
>  	struct oid_array ref = OID_ARRAY_INIT;
>  	int *status;
> -	int i;
> +	int i = 0;

Remove the " = 0" - I've verified that it does not need to be there, and
it might inhibit useful "unintialized variable" warnings if others were
to change the code later.

Optional: I would also remove this declaration and declare "int i;" in
each of the blocks that need it.

>  static int fetch_refs_via_pack(struct transport *transport,
> -			       int nr_heads, struct ref **to_fetch)
> +			       int nr_heads, struct ref **to_fetch,
> +			       struct ref **fetched_refs)
>  {
>  	int ret = 0;
>  	struct git_transport_data *data = transport->data;
> @@ -354,8 +356,12 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	if (report_unmatched_refs(to_fetch, nr_heads))
>  		ret = -1;
>  
> +	if (fetched_refs)
> +		*fetched_refs = refs;
> +	else
> +		free_refs(refs);
> +
>  	free_refs(refs_tmp);
> -	free_refs(refs);
>  	free(dest);
>  	return ret;
>  }

Instead of just freeing the linked list, we return it if requested by
the client. This makes sense.

> -int transport_fetch_refs(struct transport *transport, struct ref *refs)
> +int transport_fetch_refs(struct transport *transport, struct ref *refs,
> +			 struct ref **fetched_refs)
>  {
>  	int rc;
>  	int nr_heads = 0, nr_alloc = 0, nr_refs = 0;
>  	struct ref **heads = NULL;
> +	struct ref *nop_head = NULL, **nop_tail = &nop_head;
>  	struct ref *rm;
>  
>  	for (rm = refs; rm; rm = rm->next) {
>  		nr_refs++;
>  		if (rm->peer_ref &&
>  		    !is_null_oid(&rm->old_oid) &&
> -		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid))
> +		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid)) {
> +			/*
> +			 * These need to be reported as fetched, but we don't
> +			 * actually need to fetch them.
> +			 */
> +			if (fetched_refs) {
> +				struct ref *nop_ref = copy_ref(rm);
> +				*nop_tail = nop_ref;
> +				nop_tail = &nop_ref->next;
> +			}
>  			continue;
> +		}
>  		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
>  		heads[nr_heads++] = rm;
>  	}
> @@ -1245,7 +1263,11 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
>  			heads[nr_heads++] = rm;
>  	}
>  
> -	rc = transport->vtable->fetch(transport, nr_heads, heads);
> +	rc = transport->vtable->fetch(transport, nr_heads, heads, fetched_refs);
> +	if (fetched_refs && nop_head) {
> +		*nop_tail = *fetched_refs;
> +		*fetched_refs = nop_head;
> +	}
>  
>  	free(heads);
>  	return rc;

And sometimes, even if we are merely simulating the fetching of refs, we
still need to report those refs in fetched_refs. This is correct.

I also see that t5703 now passes.

Besides enabling the writing of subsequent patches, I see that this also
makes the API clearer in that the input refs to transport_fetch_refs()
are not overloaded to output shallow information. Other than the " = 0"
change above, this patch looks good to me.
