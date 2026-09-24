Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC947535E
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248081; cv=none; b=IMTJxPvF2pkEYcWUpaw0z5exhMWJZumVMa9c4zPzDCwE9cXtVyRHF4xIgn9jwnwf1h/G2sANoIatqCN0io2y8OhLLKSgIkJn5/pDP4ySPvNVx6K36n+AqBtFr3sEbcyMGaMQVvEgMY160C8OETBb8KFo7WJoxcrVQ7hDDBgJfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248081; c=relaxed/simple;
	bh=4UZnlVHvQvHWzMO9eLg+a20U4B6ytGX+zgFqR/MDryg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIKQArd44odWDnwfdZKd55SHNd9BhfuT+HPKgVmoiIZHERybEtYdPSv7C8TXVmEWDyKRqjha6ZZuHFIBiM6CE0k3WhHKQeG1lztRPE1TQmUVFfzC/R+AtlaC+kipDTZoO+2y/ihfXlFvSk8L87IzLz/OqiuwjnRBhHiPV/4tjPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AA+JJg8Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D3GaZZm9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AA+JJg8Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D3GaZZm9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DCE36140006B;
	Thu, 24 Sep 2026 07:07:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Sep 2026 07:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790248075; x=1790334475; bh=Y5RZ2rVHkM
	hTZN3PHl2rCPeVSgro0ro+gepDpmxVfTQ=; b=AA+JJg8QSqpbuyXsM/DliyiMh0
	s3kOIWQv4dx80CiNKAOaYSsBq80oxG+nhA1K1RTVDrp+chx2/Tc8uoQFNyxBc9wh
	yw+3wwnU9ZdyPNblaHx11K7fV1BUIKFbqBiGDxeKJ4UxmFZPb9WZJEpI4cKC4Tme
	/LHNIdIhyxRn3tstceYTAJJn9Aj7OMLt3k71qky9px5zGvHo8vhz/iLyrH2nVJtu
	SKucLE8louF9y0374R2P70Fyn/PFrrXby6PjqiXIiRzuDKApi6QI055ngj495U4e
	NpFRmGi0RvZo5yF21DmXnUKNhfAncae+MRJkVu4kDdrKQ5gibCY9jtKsN/0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790248075; x=1790334475; bh=Y5RZ2rVHkMhTZN3PHl2rCPeVSgro0ro+gep
	DpmxVfTQ=; b=D3GaZZm9Q8Nlla2X4ZyvKORi5jqFJqJvO/5RbjSKcGzBc40bk/h
	Iz3te5v/rAq8iqVifXoM9wlRss97OeQHq1RJZq7a/R8hAR2TB1RxEvQATFFpRpX8
	mNxX1Ug8Y2IIqB/QMs4jEZs89dQ1qna5C9sbuNcLyIZESZC/1vREzv7kwtkwnnOC
	XEDJMIvnfSTtHUUkCL0Kqf5DObluK+UmT7aXaX68VTeXHYOeAqeQgque35fGfnH9
	ars43OTC8nZspAfqq5fzLB9y3T4vio+GiGW5QKv052I0FfLu6pVulE58D3lDIIDC
	9lVcusGNXNRWqJLfI/ClvpE12BmDZmOzNVg==
X-ME-Sender: <xms:iwS1auFN70Vx_Em3uO2RfxaUtx2Qo5vwuoqQoOfPByIcLGLyxvRRPA>
    <xme:iwS1auZJsT4i2IV02DpMsq_rxfJVK5ecFSpa1w-vMM26KxI84PdV1gU-DOIMVladK
    uIsp94diApP026-d4t5Dnd0vL4VEKb5YRB05L1KW9QTftIQwxStb7k>
X-ME-Received: <xmr:iwS1auXYdSFq93LXt5hgf7-1WgglKdnfJisLv-tvAvO0vKsv4VJ1mHx89g7RmWqKXZ9qWKA>
X-ME-Proxy-Cause: dmFkZTF9ZstuWnVK3T3YLcc/btfUebBraXLVBvkiNGmd9FqPI3ZcLYgqNm3Gu/VV/4VFK8
    3E8li1+Yb2AIQTqM3qLS4LkUmH/nXULFY5HWg3BTyrX0E1B25AGSDzw9KQ+ZyPH6EqunL6
    wjvZtXeeNZWf0OdU81HUlp72NCYcCVF6qNT7QDKfrcXr355OyDvQHumDf9AsEY2Jdx5GP0
    TvIJB0KJwJi0c4ghsUwLuSD8OkteHIsq/vc4BPLTib8cIe+pkrLGnyq0tdv9Q8hdKjIFnR
    hequYQfaLDjapWu27vhO2wJeIZOtm5NDehb3eCrhlPaLiQNlwtCzZ75R2jmazdDrHWJOS1
    aURxDOEqkZeYD6uAXTEyrat5bg+npciDg6iWAvq717aeL+PamR3WUF5uCVhWFfbH6yal43
    iUOGWH6EV/d1V5P9How8LZOmqsbqFcbEp92dIQILByU2oPhiVX6XUaBr6eEur/3BMRLkG3
    TLFenv5NJjkb6wJFH9ttQFILHQ4wuqGwoIG4fJNvSBJqdwu4BzXu4+YQo3rtP/1T6iKM+E
    bw+f1rdlfwX3iIQMVnwCl/VuLDtQCVutfXU53yDkkVV+sTiShA5aN40RhiwpYksBOeABAT
    ACuxYfXoXA5WopS9YWzjQOBlDZQW1TR5bT3q+3r+9A8EHIRTCls1cQRV5sag
X-ME-Proxy: <xmx:iwS1akk1EB4FRo8JKLTEiYgzuFnIcRcMug2pB6yYoB5EYto2RI9vHQ>
    <xmx:iwS1apDUUPLFSqMUwFr30aTat0x4rvlTqXfEmZHQ49nXDnQSBSkmXQ>
    <xmx:iwS1ajjf24D280trZNtm6EpRCFfkjR1okk9bDpcS7vbqavVfaTrxwQ>
    <xmx:iwS1amyrjULFsQbD_n1dZ-tFuxiQQgLn3E22rXdLmPGgBvun4WGBQA>
    <xmx:iwS1aumQ2VI3n4YbHes6E_0xVD66e_1JTXYL7rJn0KHTAKuXa5-aC5rz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 07:07:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7783aa31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 11:07:53 +0000 (UTC)
Date: Thu, 24 Sep 2026 13:07:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 1/3] refs: allow callers to supply old OIDs for batch
 deletion
Message-ID: <arUEhkuC448hUTCw@pks.im>
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
 <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
 <9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>

On Wed, Sep 23, 2026 at 11:04:40PM +0200, Maciej Ciemborowicz wrote:
> refs_delete_refs() performs unconditional deletions, so callers cannot
> preserve old values that they have already resolved. Consequently,
> reference-transaction hooks see a null old OID.
> 
> Let callers provide an optional array of expected old OIDs in parallel with
> the refname list. Delete the ref at position N only if it still points at
> the OID at position N. Treat a null OID as an unconditional deletion in
> ref_transaction_delete(), allowing callers to include broken refs whose old
> value cannot be resolved.
> 
> refs_delete_refs() has always promised best-effort deletion. Always use
> REF_TRANSACTION_ALLOW_FAILURE and report rejected updates so one failure
> does not prevent independent refs in the batch from being deleted. Let
> callers request the exact set of failed refs when they need to report
> partial results. This also completes the conversion that was missed when
> batched transaction failure support was introduced.

Taking a step back though... the only reason that this function really
exists is to provide a convenience wrapper that deletes references while
we don't care for the old state. If we want to not do that anymore and
instead want to expect a specific old OID, is this function still the
right function to use?

In other words, shouldn't the callers instead be updated to drive their
own transaction if they want more complex behaviour?

> diff --git a/refs.c b/refs.c
> index 92d5df5b7..13ee2d459 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1523,7 +1524,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>  			   struct strbuf *err)
>  {
>  	if (old_oid && is_null_oid(old_oid))
> -		BUG("delete called with old_oid set to zeros");
> +		old_oid = NULL;
>  	if (old_oid && old_target)
>  		BUG("delete called with both old_oid and old_target set");
>  	if (old_target && !(flags & REF_NO_DEREF))

I'm not a huge fan of starting to treat a null OID as something other
than "this branch should not exist". Everywhere else it still does, so
mixing this feels fishy to me.

Also, this change wouldn't have to exist if we instead started to drive
a proper transaction.

> @@ -3069,39 +3070,73 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
>  	}
>  }
>  
> +struct delete_refs_rejection_data {
> +	int failures;
> +	struct string_list *failed_refs;
> +};
> +
> +static void delete_refs_rejection_handler(const char *refname,
> +					  const struct object_id *old_oid UNUSED,
> +					  const struct object_id *new_oid UNUSED,
> +					  const char *old_target UNUSED,
> +					  const char *new_target UNUSED,
> +					  enum ref_transaction_error err,
> +					  const char *details,
> +					  void *cb_data)
> +{
> +	struct delete_refs_rejection_data *data = cb_data;
> +
> +	warning(_("could not delete reference %s: %s"), refname,
> +		details ? details : ref_transaction_error_msg(err));
> +	data->failures++;
> +	if (data->failed_refs)
> +		string_list_insert(data->failed_refs, refname);
> +}
> +
>  int refs_delete_refs(struct ref_store *refs, const char *logmsg,
> -		     struct string_list *refnames, unsigned int flags)
> +		     struct string_list *refnames,
> +		     const struct oid_array *old_oids,
> +		     struct string_list *failed_refs,
> +		     unsigned int flags)

And here we also have to yield failed refs now because we don't have a
better mechanism. Same as before though, if we used a ref transaction
we'd already have that mechanism.

So overall I'm not quite on board with this change, as I think it's going
down the wrong route. If you want more complex behaviour when deleting
refs you should use a ref transaction, as it would already handle all of
what you're trying to do here.

Patrick
