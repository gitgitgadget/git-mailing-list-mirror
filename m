Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ADE71F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeBIWef (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:34:35 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39599 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeBIWee (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:34:34 -0500
Received: by mail-wr0-f196.google.com with SMTP id f6so9694040wra.6
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 14:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TW0PuMe2HPzpRO5mE0VmF11BkjYOnHkCOBL1sC4mE38=;
        b=SvffGdG6wtR1H8zWFcLH4KR0Jq4X2zoD7h038SrnT9yMiaFGs6I5NpWWu1PVPWAkor
         +P7oqIZAJbMGSWdN6YwQbTrn2SgEfyJbLldokcQkmAIxs52iufMB+FuVFtAfjDMthF35
         TyXYs8RpzlyLEvvCNKiIhyxmRino4m+Jx56c7eHUDrjscgJGa8771oh59ek7Rs/FGelG
         a0Ebq2HHNplnhe5z6zqMgTVR82B5Jq9nBveaIj5r8UU6RMyOzmAJLUp0hNfzUolsg2J6
         6krHYKt7mpPGA20F6HuTPDb0kzBoJR22YqS7z8EqXhFhu5aRCBIxT8yC/wcXYG8hMnA/
         pN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TW0PuMe2HPzpRO5mE0VmF11BkjYOnHkCOBL1sC4mE38=;
        b=bnXDPsrdSqCZJplM7xN9KPfrNZC+GYlBHLhPH5rgfGR5lIcS2G+sTCitLYeosT00IV
         gdTwltz41RGWolOC+weBjHSHyVXhxUkT5A9HUGu5sSSUeSUHU4piwRBjtUbuc4iEyhyO
         SQ9xbBUVcMkc1nPuKtVl02XjJD3bF5lLUCJdMX6DaT/hLsAdCWP37rupdaPPV9tcMaJn
         uoJP7KXplsFJFd3q2auzxikdmdCe7ufjstItxwe4bKWkP7ajr08EMmOly2pmf7cZtkvX
         Ci/58/QIOB92wySIQQmMuZ9XuVaX7S6VI3NFFOEgS5TOE+URmNIgLsgzow9D6tauHXov
         AVCQ==
X-Gm-Message-State: APf1xPApEpdJuLhzrHCnNUj4j1grj2ATPY1haLEzr70bil14ZTYN0K3x
        8YD+j6C/SGffZtl/o5J2KdNTLjhS
X-Google-Smtp-Source: AH8x226dj3jJ6FuZCJnFh0vG//Eakx9cXnr8Q6KVrHWJbHZbvRTsyC91my5xfvsBoJTBUAYypQi6xw==
X-Received: by 10.223.166.176 with SMTP id t45mr3493676wrc.221.1518215672495;
        Fri, 09 Feb 2018 14:34:32 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b65sm5371073wrd.26.2018.02.09.14.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 14:34:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     git@vger.kernel.org, Joey Hess <id@joeyh.name>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] fetch: preparations for tweak-fetch hook
References: <30753d19-d77d-1a1a-ba42-afcd6fbb4223@gaspard.io>
        <20180209214458.16135-1-leo@gaspard.io>
Date:   Fri, 09 Feb 2018 14:34:30 -0800
In-Reply-To: <20180209214458.16135-1-leo@gaspard.io> (Leo Gaspard's message of
        "Fri, 9 Feb 2018 22:44:57 +0100")
Message-ID: <xmqqo9kxvll5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leo Gaspard <leo@gaspard.io> writes:

> From: Léo Gaspard <leo@gaspard.io>
>
> No behavior changes yet, only some groundwork for the next change.
>
> The refs_result structure combines a status code with a ref map, which
> can be NULL even on success. 

Sorry, but I have absolutely no idea what this sentence wants to do
by being here in the log message.  "even on success" makes it sound
as if it is normal to be NULL when status code != success, but it is
not even clear why it is the case, and "can be NULL" implies that it
is not always NULL, but it does not make it clear when it is NULL
and when it is not NULL when code == success.  If you find the need
to explain what each field of a new struct you are introducing to
the codebase means (and it probably is a good idea for this one),
perhaps the right place to do so is in in-code comment next to the
struct definition?

It seems that you also moved add_existing() in the file, for no
apparent reason.

> This will be needed when there's a
> tweak-fetch hook, because it can filter out all refs, while still
> succeeding.
>
> fetch_refs returns a refs_result, so that it can modify the ref_map.

The description keeps saying "ref map", but it is unclear what it
is, why it is a good thing to allow the caller "modify" it, and what
kind of modification the caller wants to make for what reason.

Also, in C, we tend to avoid passing structure by value.  It seems
that the patch makes a callchain involving backfill_tags() return
this struct by value, which goes against the convention.  I suspect
that it should be trivial to have the caller supply an on-stack
instance and pass the pointer to it down the callchain, though.

> Based-on-patch-by: Joey Hess <joey@kitenet.net>
> Signed-off-by: Leo Gaspard <leo@gaspard.io>
> ---
>  builtin/fetch.c | 68 +++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7bbcd26fa..76dc05f61 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -34,6 +34,11 @@ enum {
>  	TAGS_SET = 2
>  };
>  
> +struct refs_result {
> +	struct ref *new_refs;
> +	int status;
> +};
> +
>  static int fetch_prune_config = -1; /* unspecified */
>  static int prune = -1; /* unspecified */
>  #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
> @@ -57,6 +62,18 @@ static int shown_url = 0;
>  static int refmap_alloc, refmap_nr;
>  static const char **refmap_array;
>  
> +static int add_existing(const char *refname, const struct object_id *oid,
> +			int flag, void *cbdata)
> +{
> +	struct string_list *list = (struct string_list *)cbdata;
> +	struct string_list_item *item = string_list_insert(list, refname);
> +	struct object_id *old_oid = xmalloc(sizeof(*old_oid));
> +
> +	oidcpy(old_oid, oid);
> +	item->util = old_oid;
> +	return 0;
> +}
> +
>  static int git_fetch_config(const char *k, const char *v, void *cb)
>  {
>  	if (!strcmp(k, "fetch.prune")) {
> @@ -217,18 +234,6 @@ static void add_merge_config(struct ref **head,
>  	}
>  }
>  
> -static int add_existing(const char *refname, const struct object_id *oid,
> -			int flag, void *cbdata)
> -{
> -	struct string_list *list = (struct string_list *)cbdata;
> -	struct string_list_item *item = string_list_insert(list, refname);
> -	struct object_id *old_oid = xmalloc(sizeof(*old_oid));
> -
> -	oidcpy(old_oid, oid);
> -	item->util = old_oid;
> -	return 0;
> -}
> -
>  static int will_fetch(struct ref **head, const unsigned char *sha1)
>  {
>  	struct ref *rm = *head;
> @@ -920,15 +925,20 @@ static int quickfetch(struct ref *ref_map)
>  	return check_connected(iterate_ref_map, &rm, &opt);
>  }
>  
> -static int fetch_refs(struct transport *transport, struct ref *ref_map)
> +static struct refs_result fetch_refs(struct transport *transport,
> +		struct ref *ref_map)
>  {
> -	int ret = quickfetch(ref_map);
> -	if (ret)
> -		ret = transport_fetch_refs(transport, ref_map);
> -	if (!ret)
> -		ret |= store_updated_refs(transport->url,
> +	struct refs_result ret;
> +	ret.status = quickfetch(ref_map);
> +	if (ret.status) {
> +		ret.status = transport_fetch_refs(transport, ref_map);
> +	}
> +	if (!ret.status) {
> +		ret.new_refs = ref_map;
> +		ret.status |= store_updated_refs(transport->url,
>  				transport->remote->name,
> -				ref_map);
> +				ret.new_refs);
> +	}
>  	transport_unlock_pack(transport);
>  	return ret;
>  }
> @@ -1048,9 +1058,11 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
>  	return transport;
>  }
>  
> -static void backfill_tags(struct transport *transport, struct ref *ref_map)
> +static struct refs_result backfill_tags(struct transport *transport,
> +		struct ref *ref_map)
>  {
>  	int cannot_reuse;
> +	struct refs_result res;
>  
>  	/*
>  	 * Once we have set TRANS_OPT_DEEPEN_SINCE, we can't unset it
> @@ -1069,12 +1081,14 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
>  	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
>  	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>  	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
> -	fetch_refs(transport, ref_map);
> +	res = fetch_refs(transport, ref_map);
>  
>  	if (gsecondary) {
>  		transport_disconnect(gsecondary);
>  		gsecondary = NULL;
>  	}
> +
> +	return res;
>  }
>  
>  static int do_fetch(struct transport *transport,
> @@ -1083,6 +1097,7 @@ static int do_fetch(struct transport *transport,
>  	struct string_list existing_refs = STRING_LIST_INIT_DUP;
>  	struct ref *ref_map;
>  	struct ref *rm;
> +	struct refs_result res;
>  	int autotags = (transport->remote->fetch_tags == 1);
>  	int retcode = 0;
>  
> @@ -1135,7 +1150,10 @@ static int do_fetch(struct transport *transport,
>  				   transport->url);
>  		}
>  	}
> -	if (fetch_refs(transport, ref_map)) {
> +
> +	res = fetch_refs(transport, ref_map);
> +	ref_map = res.new_refs;
> +	if (res.status) {
>  		free_refs(ref_map);
>  		retcode = 1;
>  		goto cleanup;
> @@ -1148,8 +1166,10 @@ static int do_fetch(struct transport *transport,
>  		struct ref **tail = &ref_map;
>  		ref_map = NULL;
>  		find_non_local_tags(transport, &ref_map, &tail);
> -		if (ref_map)
> -			backfill_tags(transport, ref_map);
> +		if (ref_map) {
> +			res = backfill_tags(transport, ref_map);
> +			ref_map = res.new_refs;
> +		}
>  		free_refs(ref_map);
>  	}
