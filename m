Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335A820188
	for <e@80x24.org>; Wed, 10 May 2017 18:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbdEJSBg (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 14:01:36 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36163 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbdEJSBe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 14:01:34 -0400
Received: by mail-pg0-f65.google.com with SMTP id 64so328577pgb.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wjCwqj3DvEWki09ONFO8Ie9IQ06yQL9jDKOvCv+yULU=;
        b=fg063LLUT4r8q3DGB0GTsSeOWCZBWqd4mGd5s5lM1Gvs0nv5MjLvRX7wmirqSAsntO
         H175EWbJZ+S9vPmEIgcnawCpkj9bsNz0RgHbXe99ev+Uowcq1qu5kT33PGtJLSzqzY9N
         AyqzWBlhDzM9rwQ7UVCokngn3KgElCIemAjcIAKqnUNs0LMWQRUEFtzPfOGtPKNsCLtQ
         huVDdzRgGr3DcduYjRNXn10+TqDT4uDmit09kKTkszuZpiksV6xIF5N005H3HIlb9xTo
         FsTAxDf36YH22+D+l2FegRStx5fpWo7v6YzmVSsuf2zHgiMrOmxXDT96f9IVca65EMyL
         SXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wjCwqj3DvEWki09ONFO8Ie9IQ06yQL9jDKOvCv+yULU=;
        b=eVqWMWcguCnPFpG2Gu/TFwdvp94gwPzATeAadhvhaAt8N/PFmj9TWfSQkXAHiYDUpr
         MuRq0OtZlGv5oalZuHVwDg8NPdoeoqjL23tP88RezOzRLVZSU22DLhafmVfldEfCC9F4
         FOfuDanh2rOJgjIfHNwzzwcOdsJMKkohcWZjm1bSXn50JAttZkn9nLwzzFBU3r/UF1to
         1Ui9Nw8Wibh2CS6w+36HHLCENy37ylIzbFT1T70EkCGg8O12dkBqn8KVrszGJjbBppve
         Xr7/GMaNNeq/PgX55xji0L5AKBxTpetZzVH709x21OL0uFbW9rqhIVi1p49oDpwmceHv
         K0Dg==
X-Gm-Message-State: AODbwcAFlPpF/ZY5PCVsZ5VV/ELmkC9EdZIhfoLEHNhSuCuJWPqC+/bA
        6HxIV98oc9N88ZmAn+k=
X-Received: by 10.99.164.26 with SMTP id c26mr7911249pgf.89.1494439293680;
        Wed, 10 May 2017 11:01:33 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:55dd:a079:3f06:9176])
        by smtp.gmail.com with ESMTPSA id s7sm7247291pgs.52.2017.05.10.11.01.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 11:01:33 -0700 (PDT)
Date:   Wed, 10 May 2017 11:01:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, peff@peff.net
Subject: Re: [PATCH v2] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170510180130.GY28740@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170510164432.5447-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170510164432.5447-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> fetch-pack, when fetching a literal SHA-1 from a server that is not
> configured with uploadpack.allowtipsha1inwant (or similar), always
> returns an error message of the form "Server does not allow request for
> unadvertised object %s". However, it is sometimes the case that such
> object is advertised.

Thanks for fixing it.

[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -592,6 +592,15 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
>  	}
>  }
>  
> +static int is_literal_sha1(const struct ref *ref)
> +{
> +	struct object_id oid;
> +	const char *end;
> +	return !parse_oid_hex(ref->name, &oid, &end) &&
> +	       !*end &&
> +	       !oidcmp(&oid, &ref->old_oid);

When would a ref have its name be a oid and its value be a different
oid?

Ah, this check comes from

	commit b7916422c741b50925d454819b1977449fccc111
	Author: Jeff King <peff@peff.net>
	Date:   Thu Mar 19 16:34:51 2015 -0400

	    filter_ref: avoid overwriting ref->old_sha1 with garbage

which explains that the answer is "never" (leaving me even more
confused).  Anyway, that's orthogonal to this patch.

> +}
> +
>  static void filter_refs(struct fetch_pack_args *args,
>  			struct ref **refs,
>  			struct ref **sought, int nr_sought)
> @@ -601,7 +610,6 @@ static void filter_refs(struct fetch_pack_args *args,
>  	struct ref *ref, *next;
>  	int i;
>  
> -	i = 0;
>  	for (ref = *refs; ref; ref = next) {
>  		int keep = 0;
>  		next = ref->next;
> @@ -610,15 +618,14 @@ static void filter_refs(struct fetch_pack_args *args,
>  		    check_refname_format(ref->name, 0))
>  			; /* trash */
>  		else {
> -			while (i < nr_sought) {
> -				int cmp = strcmp(ref->name, sought[i]->name);
> -				if (cmp < 0)
> -					break; /* definitely do not have it */
> -				else if (cmp == 0) {
> -					keep = 1; /* definitely have it */
> -					sought[i]->match_status = REF_MATCHED;
> +			for (i = 0; i < nr_sought; i++) {

This resets i each time this code path is encountered.  Doesn't that
make this more expensive e.g. in the case where there are no sha1s
among the refs to be searched for?

Should this be conditional on whether there are any sha1-shaped refs in
'sought' to avoid that performance regression?

It's tempting to split 'sought' into two lists --- sha1-shaped refs
that have to be processed in full every time and the others that can
be processed in a single pass because they are in sorted order.

[...]
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -547,6 +547,12 @@ test_expect_success 'fetch-pack can fetch a raw sha1' '
>  	git fetch-pack hidden $(git -C hidden rev-parse refs/hidden/one)
>  '
>  
> +test_expect_success 'fetch-pack can fetch a raw sha1 that is advertised as a ref' '
> +	git init server &&
> +	test_commit -C server 4 &&
> +	git fetch-pack server $(git -C server rev-parse refs/heads/master)
> +'

Is there test for the error case, too? (I.e. the server does not advertise
fetch-by-sha1 and the sha1 is not among the advertised refs)

Thanks,
Jonathan
