Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE2D20372
	for <e@80x24.org>; Wed, 11 Oct 2017 06:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932324AbdJKGdw (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 02:33:52 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51303 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752087AbdJKGdv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Oct 2017 02:33:51 -0400
X-AuditID: 1207440c-7fdff7000000143e-4a-59ddbb4e88f1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 11.26.05182.E4BBDD95; Wed, 11 Oct 2017 02:33:50 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCD9E.dip0.t-ipconnect.de [87.188.205.158])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9B6Xl9n001268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 11 Oct 2017 02:33:48 -0400
Subject: Re: [PATCH v2 04/24] refs: convert update_ref and refs_update_ref to
 use struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-5-sandals@crustytoothpaste.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9d4c3854-38fb-d5b4-0436-0eee707201ab@alum.mit.edu>
Date:   Wed, 11 Oct 2017 08:33:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171009011132.675341-5-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqOu3+26kwZdWEYvn60+wW3Rd6Way
        WPLwNbPFj5YeZou2mT+YLDZvbmdxYPNYfvMvk8eCTaUeXe1H2Dye9e5h9Pi8SS6ANYrLJiU1
        J7MstUjfLoEr4+P5Y8wFn0Uq9u69z9zAuJa/i5GDQ0LARGL/C5EuRi4OIYEdTBJLt3xh7mLk
        BHIuMEkcu5wFYgsLpEic+HQALC4i4CUx/9EMVpAGZoEpjBKnH75mh2ioljg0YzETiM0moCux
        qKeZCWQBr4C9xJeHciBhFgFVibn3/7CBhEUFIiQ2bOQHCfMKCEqcnPmEBcTmFHCWmLLpA9gU
        ZgF1iT/zLjFD2OISt57Mh4rLS2x/O4d5AqPALCTts5C0zELSMgtJywJGllWMcok5pbm6uYmZ
        OcWpybrFyYl5ealFuoZ6uZkleqkppZsYIeHPs4Px2zqZQ4wCHIxKPLwC1+9ECrEmlhVX5h5i
        lORgUhLlVZhzN1KILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG/1OqAcb0piZVVqUT5MSpqDRUmc
        V3WJup+QQHpiSWp2ampBahFMVoaDQ0mCt3oXUKNgUWp6akVaZk4JQpqJgxNkOA/Q8A6QGt7i
        gsTc4sx0iPwpRkUpcd7snUAJAZBERmkeXC8sPb1iFAd6RZiXA6SdB5ja4LpfAQ1mAhosmnYH
        ZHBJIkJKqoGR5350Ks/T51e9hBIm350i3+j4W1/1t8Z1mcPTvnQ/7VdcvufvVp2W7rU3I5a4
        qtWFMK54u/lJo7PP1SttMu98kiPnnzPcIc/w8K2m9Cbh9M6mPRNk4kVMTZ64uRmb5GxW4llx
        QuWTd9ObtbNu/ZbgPiedaLysKCmFJ8u0qHCF5YWrByouVk9SYinOSDTUYi4qTgQARuLxJCoD
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2017 03:11 AM, brian m. carlson wrote:
> Convert update_ref, refs_update_ref, and write_pseudoref to use struct
> object_id.  Update the existing callers as well.  Remove update_ref_oid,
> as it is no longer needed.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  bisect.c                  |  5 +++--
>  builtin/am.c              | 14 +++++++-------
>  builtin/checkout.c        |  3 +--
>  builtin/clone.c           | 14 +++++++-------
>  builtin/merge.c           | 13 ++++++-------
>  builtin/notes.c           | 10 +++++-----
>  builtin/pull.c            |  2 +-
>  builtin/reset.c           |  4 ++--
>  builtin/update-ref.c      |  2 +-
>  notes-cache.c             |  2 +-
>  notes-utils.c             |  2 +-
>  refs.c                    | 40 ++++++++++++++++------------------------
>  refs.h                    |  5 +----
>  sequencer.c               |  9 +++------
>  t/helper/test-ref-store.c | 10 +++++-----
>  transport-helper.c        |  3 ++-
>  transport.c               |  4 ++--
>  17 files changed, 64 insertions(+), 78 deletions(-)
> 
> [...]
> diff --git a/refs.c b/refs.c
> index 0a5b68d6fb..51942df7b3 100644
> --- a/refs.c
> +++ b/refs.c
> [...]
> @@ -1003,12 +995,12 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
>  	int ret = 0;
>  
>  	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
> -		assert(refs == get_main_ref_store());

Was the deletion of the line above intentional?

> -		ret = write_pseudoref(refname, new_sha1, old_sha1, &err);
> +		ret = write_pseudoref(refname, new_oid, old_oid, &err);

This is not new to your code, but I just noticed a problem here.
`refs_update_ref()` is documented, via its reference to
`ref_transaction_update()`, to allow `new_sha1` (i.e., now `new_oid`) to
be NULL. (NULL signifies that the value of the reference shouldn't be
changed.)

But `write_pseudoref()` dereferences its `oid` argument unconditionally,
so this call would fail if `new_oid` is NULL.

This has all been the case since `write_pseudoref()` was introduced in
74ec19d4be (pseudorefs: create and use pseudoref update and delete
functions, 2015-07-31).

In my opinion, `write_pseudoref()` is broken. It should accept NULL as
its `oid` argument.

>  	} else {
>  		t = ref_store_transaction_begin(refs, &err);
>  		if (!t ||
> -		    ref_transaction_update(t, refname, new_sha1, old_sha1,
> +		    ref_transaction_update(t, refname, new_oid ? new_oid->hash : NULL,
> +					   old_oid ? old_oid->hash : NULL,
>  					   flags, msg, &err) ||
>  		    ref_transaction_commit(t, &err)) {
>  			ret = 1;
> [...]

Michael
