Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C621FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbdBIVTU (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:19:20 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35232 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbdBIVTT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 16:19:19 -0500
Received: by mail-pg0-f66.google.com with SMTP id 204so1248593pge.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 13:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=18sMYG/8DAqFQPE9hfuc/derwDy1T86QtiLDxnBt0S8=;
        b=efJMm0q+GWgY483h/QRZd2Q1wTM/V99dovMslsqI7CK9kK1dTtefJud6qU/MCnh//L
         HPRDn0H0nv0htegIZM7JyqvSEF46UEi3jcLCjcsTxj4RhrpTuFy+coJmrf1kBhj4q9MG
         7m9bF8jCPTAe9RZC/9xl5rdfUq0vjOmwgXsxDthhEmK+yDv27QEoFwrZJbujAnFmxhUu
         eWj//zVzC+nyNF5Ic9RGRMbuy9bKMNV0LbGrLFrWsvILjsSXC2y6+zNSvPDZz5Wg8s3O
         doI5Z+HzUPI6I7GDEz6NJA6mzoBIN2RUu0zm76RcWM4cmjnag0kOR0gmwG4AS2ODYWmr
         73nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=18sMYG/8DAqFQPE9hfuc/derwDy1T86QtiLDxnBt0S8=;
        b=F9RqbGgHNYVzHpTb50mUUHjYtxsRtbayYK4rtTFPZfFNI0RaB9V3+zoLeyDmOvj2JJ
         sEwjwvmTkHUoWDlN+DkVsXQCt30XtMV2DqwdUf48/NFIzIGB16FiM3Rdh4M1Lg79t9qy
         3C5CqrVICZkxt3wER8uruOKnWcJ4Sbcp2oIzJq2LMnKCbmmAO+6c40c2HbaCfrvzip5m
         0yeKMNmn3fBA2lceUh4qhn775VxIEyqbdVWjjpNTdRjmbKDxjn9fvsXFsqFH92KZpF4u
         Ci7Yz+rmpqYcri8lKg47FiYhG2nltIZHisl2iFGnELdnWydDuIEsa4/hkG/qSNmCnT5J
         avSw==
X-Gm-Message-State: AMke39lYX34AhGlyZxnnXOELt+Oy4AmEt4RBxDivJ1ir6Y7cPd5r/m9aaqu6qXujCqBGVg==
X-Received: by 10.99.64.4 with SMTP id n4mr6358198pga.71.1486675159029;
        Thu, 09 Feb 2017 13:19:19 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id i10sm31281941pgd.37.2017.02.09.13.19.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 13:19:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] files_ref_store::submodule: use NULL for the main repository
References: <cover.1486629195.git.mhagger@alum.mit.edu>
        <111d663c0fd3e9669e7c28537f581833488ca4a6.1486629195.git.mhagger@alum.mit.edu>
Date:   Thu, 09 Feb 2017 13:19:17 -0800
In-Reply-To: <111d663c0fd3e9669e7c28537f581833488ca4a6.1486629195.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Thu, 9 Feb 2017 14:27:01 +0100")
Message-ID: <xmqq1sv7oyei.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The old practice of storing the empty string in this member for the main
> repository was a holdover from before 00eebe3 (refs: create a base class
> "ref_store" for files_ref_store, 2016-09-04), when the submodule was
> stored in a flex array at the end of `struct files_ref_store`. Storing
> NULL for this case is more idiomatic and a tiny bit less code.

Yes.  I noticed this bit in 3/5 and wondered about it, knowing this
step comes next:

>  struct ref_store *ref_store_init(const char *submodule)
>  {
>  	const char *be_name = "files";
>  	struct ref_storage_be *be = find_ref_storage_backend(be_name);
> +	struct ref_store *refs;
>  
>  	if (!be)
>  		die("BUG: reference backend %s is unknown", be_name);
>  
>  	if (!submodule || !*submodule)
> -		return be->init(NULL);
> +		refs = be->init(NULL);
>  	else
> -		return be->init(submodule);
> +		refs = be->init(submodule);

Can't we also lose this "if !*submodule, turn it to NULL"?

> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -980,7 +980,7 @@ static struct ref_store *files_ref_store_create(const char *submodule)
>  	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
>  	struct ref_store *ref_store = (struct ref_store *)refs;
>  
> -	base_ref_store_init(ref_store, &refs_be_files, submodule);
> +	base_ref_store_init(ref_store, &refs_be_files);
>  
>  	refs->submodule = submodule ? xstrdup(submodule) : "";

Also, can't we use xstrdup_or_null(submodule) with this step?

