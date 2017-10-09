Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9885D20405
	for <e@80x24.org>; Mon,  9 Oct 2017 22:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755424AbdJIWnN (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 18:43:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34385 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754908AbdJIWnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 18:43:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id b85so10547656pfj.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0rNy8nOQ0ZiCVcPmfjN+IEKRw8dRUoJN0HxeZ8Y47Q=;
        b=KNC/aNaDBuUKdJxQeH9jEEGRSAUh6zlX6DWVspjnnwD8Eaib09Azau0VE8Sk0G3jcS
         lj8gMBNLTvvZ3E1nETLgTitS/6xmfWvLo7EV9UgtdEMd6Ugk+HIs7ZiA9QKDFMClJeJv
         zBYvdzSjT0ak0SDRxSCh2cQMaKkRzCJhitML/cfkeaILgr+XuAfXiu6MBz8duyNlfG8X
         nXC2AQtnsx2mtD1eS4ofzRKTH+9a/ru9+1NcnFf22MxhPnBoo26CT51A2NoPnS7AHOHB
         0b4VzBdhjjKD5VP6wg1buUtBaBPzMjgFG2uPkXHw6DEUkieZuBghGt9s2mo6NyRbAeCT
         5DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0rNy8nOQ0ZiCVcPmfjN+IEKRw8dRUoJN0HxeZ8Y47Q=;
        b=jjvqrEQinLV9DMqilOvGY1AvZrD66dSgVL/tnvwfplqzuwDlEb/topvs325OL6pvhK
         mL+A0wmvHhcmz4nBWftS+jpPEbq8V5jArDSxiFkMfLIKBUPeX6QoWgxHcp4SCdFgrJeK
         3X9khfHhuxmP/yXGyOrOsJV+pS9C5NPfz2M306U+cKfc9lnns7usVJ9bZIlmbmORscVe
         zZ+fFKiTspt6wBegP4k+fDcnWihTbLCyHaGjKm0S6iyuF5Onq4GPFDpw5Hcqx3liDAoc
         GQIi3gwg/HLYSyGzRFXVIyEdxRbRupMP8ju7/QiXT+hE2i99ZlUNIW/iicIurLqc3dX7
         49FA==
X-Gm-Message-State: AMCzsaVTBzLmZgHx7HvZa5iVxhoId/19ZCLcd53r7s6WoVXtYCF3Ueai
        DpRR/fv9pUkZ+QtPZCwrK7Q=
X-Google-Smtp-Source: AOwi7QCQRuQoo74Jm+rOW8uMSuLgxGgOmvJmyRoAg39I2LYVus5QbtsEnBgYhYRVSQWCPi8klzzY0Q==
X-Received: by 10.99.114.93 with SMTP id c29mr10476947pgn.421.1507588992043;
        Mon, 09 Oct 2017 15:43:12 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:14f3:fccd:46cc:9e97])
        by smtp.gmail.com with ESMTPSA id u66sm19992791pfd.33.2017.10.09.15.43.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 15:43:11 -0700 (PDT)
Date:   Mon, 9 Oct 2017 15:43:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 03/24] refs: convert delete_ref and refs_delete_ref to
 struct object_id
Message-ID: <20171009224309.GG19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-4-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-4-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> Convert delete_ref and refs_delete_ref to take a pointer to struct
> object_id.  Update the documentation accordingly, including referring to
> null_oid in lowercase, as it is not a #define constant.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/branch.c          |  2 +-
>  builtin/replace.c         |  2 +-
>  builtin/reset.c           |  2 +-
>  builtin/tag.c             |  2 +-
>  builtin/update-ref.c      |  2 +-
>  refs.c                    | 21 +++++++++++----------
>  refs.h                    | 12 ++++++------
>  refs/files-backend.c      |  2 +-
>  t/helper/test-ref-store.c |  6 +++---
>  9 files changed, 26 insertions(+), 25 deletions(-)

Was this prepared using coccinelle?  (Just curious.)

[...]
> @@ -663,12 +663,13 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
>  
>  	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
>  		assert(refs == get_main_ref_store());
> -		return delete_pseudoref(refname, old_sha1);
> +		return delete_pseudoref(refname, old_oid);
>  	}
>  
>  	transaction = ref_store_transaction_begin(refs, &err);
>  	if (!transaction ||
> -	    ref_transaction_delete(transaction, refname, old_sha1,
> +	    ref_transaction_delete(transaction, refname,
> +				   old_oid ? old_oid->hash : NULL,
>  				   flags, msg, &err) ||

musing out loud: Distinguishing contexts where we need this kind of
change and contexts where we can use old_oid->hash directly can be
subtle.  Do we need some kind of annotation to mark which parameters
are nullable and which aren't?

[...]
> --- a/refs.h
> +++ b/refs.h
> @@ -371,19 +371,19 @@ int refs_reflog_exists(struct ref_store *refs, const char *refname);
>  int reflog_exists(const char *refname);
>  
>  /*
> - * Delete the specified reference. If old_sha1 is non-NULL, then
> + * Delete the specified reference. If old_oid is non-NULL, then
>   * verify that the current value of the reference is old_sha1 before
> - * deleting it. If old_sha1 is NULL, delete the reference if it
> - * exists, regardless of its old value. It is an error for old_sha1 to
> - * be NULL_SHA1. msg and flags are passed through to
> + * deleting it. If old_oid is NULL, delete the reference if it
> + * exists, regardless of its old value. It is an error for old_oid to
> + * be null_oid. msg and flags are passed through to
>   * ref_transaction_delete().
>   */
>  int refs_delete_ref(struct ref_store *refs, const char *msg,

Thanks for updating the comment.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
