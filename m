Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E02220372
	for <e@80x24.org>; Tue, 10 Oct 2017 02:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755564AbdJJCDP (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 22:03:15 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:57240 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755457AbdJJCDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 22:03:14 -0400
Received: by mail-pf0-f171.google.com with SMTP id b85so4465824pfj.13
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 19:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b0OYGOlVPauEqEbANFS1A0aEM6WpR9J6dIazhA30W7E=;
        b=lldliI2bnuq5demWcKKGpRjIdre1k5K6/78k4HcOoS2asvdH/67//fJNJcKUS97BdN
         ZBI5Ijsgjtl2Xq7CTSHrBCKSalNk+vZKGF4tsqd1QIto/6VqDPtciQPsQTOO3EqlLOJu
         nl8t4pU/3JN3tMaGTjhOVxJRERpupZ4MgTY6jIgKMDp7SaZGPTBnC9mcQNSK+mpRX6tQ
         lsvorYnFhrbr07FPnly6gn+T8zvN51u5pO7aYOcMZSgcKmlO8mbIwOBX9VivSJXwRQ99
         bX74ovflHHAZwplFddfnRY0PRS+J+B2KRhC6CP89Iy4qjVkIzbuE/AxLVjXrn0TaiyIl
         85Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b0OYGOlVPauEqEbANFS1A0aEM6WpR9J6dIazhA30W7E=;
        b=E/T8eMg6KaEk4UaFJC81BEhEad0UQI1x38KhIvAC2x2b9h6b58KGVU4+XM36793trE
         bE9PUM9gw8K0XObiceH8yUyAxx4QltqGZke0ngJ2Mkzka2oE49vHl2h93Rakl31yovkc
         d4rAX9xH2MPy79x1xaNCCWr+jqz2MMyOUOISR/HYeSuGqkb5taXfW+hPE+jBcNVIKRkh
         KeZIg4V9hQPkfCUFHbq6KTfel8VjnjHGuNMVwkxu9AOp3YaBE/OQ4d1WCJq1CrlXcAY6
         r74Ev3fgLtOOVphbJW5L/230vAqde7H1t4qTZHzfwE9iatoC4mWNLagQ0kh8a28LeeDA
         wW3w==
X-Gm-Message-State: AMCzsaU1q5HZkw1qdKDm13edQNuxKxf3c8qN8rYAOQqSsSzkODmeCRJk
        51X89oD1q3keqL8sGgc9FxA=
X-Google-Smtp-Source: AOwi7QAfzfAVNvhuP7t0Sj8+jg3P+sZXULJDoD1CEn4R2QzUU1m3pamApoPibWQqZJpaYmb9Vn8J+g==
X-Received: by 10.98.238.16 with SMTP id e16mr11558116pfi.157.1507600993456;
        Mon, 09 Oct 2017 19:03:13 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id q62sm14335205pga.75.2017.10.09.19.03.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 19:03:12 -0700 (PDT)
Date:   Mon, 9 Oct 2017 19:03:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 09/24] refs: convert dwim_ref and expand_ref to struct
 object_id
Message-ID: <20171010020309.GQ19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-10-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-10-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> All of the callers of these functions just pass the hash member of a
> struct object_id, so convert them to use a pointer to struct object_id
> directly.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  archive.c             |  2 +-
>  branch.c              |  2 +-
>  builtin/fast-export.c |  2 +-
>  builtin/log.c         |  2 +-
>  builtin/merge-base.c  |  2 +-
>  builtin/merge.c       |  2 +-
>  builtin/rev-parse.c   |  2 +-
>  builtin/show-branch.c |  2 +-
>  bundle.c              |  2 +-
>  refs.c                | 14 +++++++-------
>  refs.h                |  4 ++--
>  remote.c              |  3 +--
>  sha1_name.c           |  6 +++---
>  upload-pack.c         |  2 +-
>  wt-status.c           |  2 +-
>  15 files changed, 24 insertions(+), 25 deletions(-)

One worry below.  I might be worrying in vain but thought I might as
well ask.

> --- a/refs.c
> +++ b/refs.c
[...]
> -int expand_ref(const char *str, int len, unsigned char *sha1, char **ref)
> +int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
>  {
>  	const char **p, *r;
>  	int refs_found = 0;
> @@ -472,15 +472,15 @@ int expand_ref(const char *str, int len, unsigned char *sha1, char **ref)
>  
>  	*ref = NULL;
>  	for (p = ref_rev_parse_rules; *p; p++) {
> -		unsigned char sha1_from_ref[20];
> -		unsigned char *this_result;
> +		struct object_id oid_from_ref;
> +		struct object_id *this_result;
>  		int flag;
>  
> -		this_result = refs_found ? sha1_from_ref : sha1;
> +		this_result = refs_found ? &oid_from_ref : oid;
>  		strbuf_reset(&fullref);
>  		strbuf_addf(&fullref, *p, len, str);
>  		r = resolve_ref_unsafe(fullref.buf, RESOLVE_REF_READING,
> -				       this_result, &flag);
> +				       this_result->hash, &flag);

Can this_result be NULL?  Can the oid param be NULL?

Since both this and dwim_ref are non-static functions, I'd be comforted by an

	if (!oid)
		BUG("expand_ref: oid must be non-NULL");

at the top so that mistakes in callers are caught quickly.

[...]
> --- a/remote.c
> +++ b/remote.c
> @@ -1628,8 +1628,7 @@ static void set_merge(struct branch *ret)
>  		if (!remote_find_tracking(remote, ret->merge[i]) ||
>  		    strcmp(ret->remote_name, "."))
>  			continue;
> -		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
> -			     oid.hash, &ref) == 1)
> +		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]), &oid, &ref) == 1)
>  			ret->merge[i]->dst = ref;

Long line (but as discussed earlier in this series, I don't mind).

Thanks,
Jonathan
