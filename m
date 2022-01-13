Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A9C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 12:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiAMM4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 07:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiAMM4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 07:56:02 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD76C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 04:56:01 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id t24so22636680edi.8
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 04:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jcbWo8xnQYSkFIdjo/PrsptuoUXsiESzNTqHt37N3SM=;
        b=Gp40gCKjEUa6z97fHh0p4KA5SGtPRbJYBkD0SvqfN2yA/lomN6TkwkFDfuxXH/D50X
         QUDXcaW2TWU8i/x5c6uIYUvWsvSLKAoSmu7sZB0PS+I5G4e/DbKn+LTgfZ0OA6Y5aUAX
         GZsKDZHwJ7TepMk2LyIqApYzOqS1ZiV0hM2W+Qsp+T/nrt1EfeYEsXeTYPMzHYj8J6pz
         Td1bNYaYkYfaXM5Y1dzJ22aA1DmA+/l70hv9S67TJ2DKIDb1U5Nar8Skcu7VH1Qll7Vt
         +2qWF0eEF1FMShbRqM5Elw4LJeUDS5bFb/tv5QOogSWgA+Uw54Wp5KmN2S9+7jhu9PQy
         0Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jcbWo8xnQYSkFIdjo/PrsptuoUXsiESzNTqHt37N3SM=;
        b=qG+T2aCSxPy6Y8E9uXfgJ8/aKmchtRRvbOG2I/4eJSwbqViRWQzZXL4d1+1IYTxvF0
         xUcPxuDanu8YCyVz1pxWqZpWByNQDUo1CPTdaIusL0mPytqLrWljjL02j4aDuRfhFBA1
         JAmUfzzOHGirCBJ/Ms8k30US+So/hU6ffPhoFP7Mky4OclnEYUhZXUkxiTpBZvFMyXbd
         WqWI2ucOGwW2rAkVzYHG2Cxl14+JM/CvgFqy9Pv3jVwic108M8veMFASpbYqVBCy1+4r
         G+LcJaL/qCMA/czr7iPdfwTloSJX8EyTIijfhuFGAW4P0M6w2c7q1chlZcyCxCGiyGay
         QoWw==
X-Gm-Message-State: AOAM531lu8JgX/BWpyYHBaNR6f5pue2N63qP0dNHNGWF3slnHW0sjwLA
        ivvavpcO5Qu0a4e4zSkLp8+LAVyWVGkrhg==
X-Google-Smtp-Source: ABdhPJwHrTnOQm1GE5puTcf8Nh/ReMjG7Gxo+J7bs1t3TcKTsOiasjHZtKOqWxYQodJkyg6K04Krag==
X-Received: by 2002:a17:907:8694:: with SMTP id qa20mr3532638ejc.378.1642078560262;
        Thu, 13 Jan 2022 04:56:00 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 5sm861714eji.104.2022.01.13.04.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 04:55:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7ze3-000vLI-Ad;
        Thu, 13 Jan 2022 13:55:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 1/6] refs: extract packed_refs_delete_refs() to allow
 control of transaction
Date:   Thu, 13 Jan 2022 13:43:18 +0100
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
 <abbc28822b8fde78976422c775afa83bef76ca6c.1642054003.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <abbc28822b8fde78976422c775afa83bef76ca6c.1642054003.git.ps@pks.im>
Message-ID: <220113.86h7a7vlpc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> When deleting loose refs, then we also have to delete the refs in the
> packed backend. This is done by calling `refs_delete_refs()`, which
> then uses the packed-backend's logic to delete refs. This doesn't allow
> us to exercise any control over the reference transaction which is being
> created in the packed backend, which is required in a subsequent commit.
>
> Extract a new function `packed_refs_delete_refs()`, which hosts most of
> the logic to delete refs except for creating the transaction itself.
> Like this, we can easily create the transaction in the files backend
> and thus exert more control over it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c  | 12 +++++++++---
>  refs/packed-backend.c | 28 +++++++++++++++++++++-------
>  refs/packed-backend.h |  7 +++++++
>  3 files changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 90b671025a..5795e54020 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1249,6 +1249,7 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
>  {
>  	struct files_ref_store *refs =
>  		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
> +	struct ref_transaction *transaction = NULL;

nit: "NULL initialization never needed?
(re: https://lore.kernel.org/git/220113.86bl0gvtq3.gmgdl@evledraar.gmail.com/)

>  	struct strbuf err = STRBUF_INIT;
>  	int i, result = 0;
>  
> @@ -1258,10 +1259,14 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
>  	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
>  		goto error;
>  
> -	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
> -		packed_refs_unlock(refs->packed_ref_store);
> +	transaction = ref_store_transaction_begin(refs->packed_ref_store, &err);
> +	if (!transaction)
> +		goto error;
> +
> +	result = packed_refs_delete_refs(refs->packed_ref_store,
> +					 transaction, msg, refnames, flags);
> +	if (result)
>  		goto error;
> -	}
>  
>  	packed_refs_unlock(refs->packed_ref_store);
>  
> @@ -1288,6 +1293,7 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
>  	else
>  		error(_("could not delete references: %s"), err.buf);
>  
> +	ref_transaction_free(transaction);
>  	strbuf_release(&err);
>  	return -1;
>  }
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 67152c664e..e97d67f932 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1522,15 +1522,10 @@ static int packed_initial_transaction_commit(struct ref_store *ref_store,
>  static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
>  			     struct string_list *refnames, unsigned int flags)
>  {
> -	struct packed_ref_store *refs =
> -		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
>  	struct strbuf err = STRBUF_INIT;
>  	struct ref_transaction *transaction;
> -	struct string_list_item *item;
>  	int ret;
>  
> -	(void)refs; /* We need the check above, but don't use the variable */
> -
>  	if (!refnames->nr)
>  		return 0;
>  
> @@ -1544,6 +1539,27 @@ static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
>  	if (!transaction)
>  		return -1;
>  
> +	ret = packed_refs_delete_refs(ref_store, transaction,
> +				      msg, refnames, flags);
> +
> +	ref_transaction_free(transaction);
> +	return ret;
> +}
> +
> +int packed_refs_delete_refs(struct ref_store *ref_store,
> +			    struct ref_transaction *transaction,
> +			    const char *msg,
> +			    struct string_list *refnames,
> +			    unsigned int flags)
> +{
> +	struct packed_ref_store *refs =
> +		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
> +	struct strbuf err = STRBUF_INIT;
> +	struct string_list_item *item;
> +	int ret;
> +
> +	(void)(refs); /* We need the check above, but don't use the variable */
> +
>  	for_each_string_list_item(item, refnames) {
>  		if (ref_transaction_delete(transaction, item->string, NULL,
>  					   flags, msg, &err)) {

I see you're just moving this code around, but FWIW we can just do this
(also in the pre-image):

	int packed_refs_delete_refs(...)
	{
		[declare variables]
                
                /* Assert ref store sanity */
                packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs")

                [...]
	}

Not sure it's good to change it around just for this mostly-move, just a
note...

> @@ -1554,7 +1570,6 @@ static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
>  	}
>  
>  	ret = ref_transaction_commit(transaction, &err);
> -

Stray whitespace change.
