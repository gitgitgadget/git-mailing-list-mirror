Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C9C1FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 16:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbdF1QXj (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 12:23:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33715 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdF1QXh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 12:23:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id e199so9646671pfh.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nJJdfUKRFsPtNnuKWU2FX5iZfTpPNlRzIpMQ1Gj+tNI=;
        b=LpVaCj3tZXn4Qgt9+ayHxYUW/ZLmrFR10v1WtJldPjIGIoztMuCo97LcYdVbiyzfJB
         h8w1dWwn356WaH5v6trLTTT6EFdos113EMj1WHgu8iqjAsB+zVXO3iqfvvD/61Trde4f
         4+IgBrglsFGncX51zMqRVU8tMgiPh3dTI+AL6E3IHSa/NsimnOCfKQEainbwWiGyRTDG
         DkXojfS9SLftzoP4ohtPE8WbDM3dZUEvVroOjGn0MfAXk2X0ZxoKB5VZAFiQJ7P0YFzZ
         kK7udiZcVHDNrtl6uKXbiuEbegJLcFu9LOrC1hkCKaTnBS8FQev8JwupqOVZaKzXsAjI
         iErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nJJdfUKRFsPtNnuKWU2FX5iZfTpPNlRzIpMQ1Gj+tNI=;
        b=SVqEhRX8p0gTDXj8lxSLTcO/LVAdSlPAasN4HZx8DJTEf562oLUXFfMs9DU/vKXLSh
         T2QhIEJJEJU2LWolwVCVQPO2eh+9hfGxHIrEKSFdU98orCWaNgV8Nfs/Vvf72eCuI/8x
         cGCXEaykR10YVWtZZzlUn5ry9eM5PxqveIHzlf9SkFBiZCv3YaCY3KPSuySK+xQVpjvp
         +OFEWnxalwvvYwDyp5ZPP/TMG873YZsoyHEE+e32LF+DLkAScjx6M0CyPGKTp+tJnxq2
         84VmHmvHjqvA4Epphg5MM7XCF+pGZ+mfhI/T0IJ3oemfn/Sf5zl5MI4dHVtiYbyJKCeX
         /JmA==
X-Gm-Message-State: AKS2vOyeGH68X2P/uOgAvhIwYLMz0wYHpY4fJbuUka6kExAsK3PxCpaD
        rQhysPoXna61TQ==
X-Received: by 10.84.217.26 with SMTP id o26mr12889923pli.223.1498667017089;
        Wed, 28 Jun 2017 09:23:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id a4sm6823117pfc.22.2017.06.28.09.23.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 09:23:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/3] list-objects: add filter_blob to traverse_commit_list
References: <20170622203615.34135-1-git@jeffhostetler.com>
        <20170622203615.34135-2-git@jeffhostetler.com>
Date:   Wed, 28 Jun 2017 09:23:33 -0700
In-Reply-To: <20170622203615.34135-2-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Thu, 22 Jun 2017 20:36:13 +0000")
Message-ID: <xmqqy3scw06y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> diff --git a/list-objects.c b/list-objects.c
> index f3ca6aa..c9ca81c 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -24,11 +25,28 @@ static void process_blob(struct rev_info *revs,
>  		die("bad blob object");
>  	if (obj->flags & (UNINTERESTING | SEEN))
>  		return;
> -	obj->flags |= SEEN;
>  
>  	pathlen = path->len;
>  	strbuf_addstr(path, name);
> -	show(obj, path->buf, cb_data);
> +	if (!filter_blob) {
> +		/*
> +		 * Normal processing is to imediately dedup blobs
> +		 * during commit traversal, regardless of how many
> +		 * times it appears in a single or multiple commits,
> +		 * so we always set SEEN.
> +		 */
> +		obj->flags |= SEEN;
> +		show(obj, path->buf, cb_data);
> +	} else {
> +		/*
> +		 * Use the filter-proc to decide whether to show
> +		 * the blob.  We only set SEEN if requested.  For
> +		 * example, this could be used to omit a specific
> +		 * blob until it appears with a ".git*" entryname.
> +		 */
> +		if (filter_blob(obj, path->buf, &path->buf[pathlen], cb_data))
> +			obj->flags |= SEEN;
> +	}

This somehow looks a bit surprising organization and division of
responsibility.  I would have expected

	if (!filter_blob || 
	    filter_blob(obj, path->buf, &path->buf[pathlen], cb_data) {
		obj->flags |= SEEN;
		show(obj, path->buf, cb_data);
	}

i.e. making the filter function responsible for only making a
decision to include or exclude, not giving it a chance to decide to
"show" anything different.

> @@ -67,6 +85,7 @@ static void process_gitlink(struct rev_info *revs,
>  static void process_tree(struct rev_info *revs,
>  			 struct tree *tree,
>  			 show_object_fn show,
> +			 filter_blob_fn filter_blob,
>  			 struct strbuf *base,
>  			 const char *name,
>  			 void *cb_data)
> @@ -111,7 +130,7 @@ static void process_tree(struct rev_info *revs,
>  		if (S_ISDIR(entry.mode))
>  			process_tree(revs,
>  				     lookup_tree(entry.oid->hash),
> -				     show, base, entry.path,
> +				     show, filter_blob, base, entry.path,
>  				     cb_data);
>  		else if (S_ISGITLINK(entry.mode))
>  			process_gitlink(revs, entry.oid->hash,

I wonder if we'll need filter_tree_fn in the future in this
codepath.  When somebody wants to do a "narrow fetch/clone", would
the approach taken by this series, i.e. decide not to show certain
objects during the "rev-list --objects" traversal, a good precedent
to follow?  Would this approach be a good foundation to build on
such a future?

Thanks.
