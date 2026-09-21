Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B43AEF4E
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034908; cv=none; b=PqpOmwQguIl679Lqr2vnVPSZuYzf7723ny3q7Cnd3VdcthH1bmSDaH/QEAi+Yqy+Cp4I9ej7yfpDdD9WJ7rnrJohFoN9GvEfRYKXMJYrVMX7yXAZ1gV0etmDgtE/5jeTh+0W07GgdlPqJUXeXql8T/4JUmQNIFb5+LU0ligqSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034908; c=relaxed/simple;
	bh=Zcd0tIhFVWBvnAcMP6c2lQro19xkRCGVUDB16wT1Ts0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QM8eBQ4IDVYlQcwH1VFvzUsR1SVTvFransZCZsJNIlIJaQcO012MOfz25ZqJccM05H3StQimrzvkifyzPPA3QdfjwfArY2UOmAz4Hxz8qvPwTEmKQuFhMUyC9EX6nRfLSUAtgrf09WGdB2CKZDWyxb5pwQA3geWaFMM8FdHp/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rgllev+h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ntl9o/bU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rgllev+h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ntl9o/bU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C598814000AD;
	Mon, 21 Sep 2026 19:55:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 21 Sep 2026 19:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790034905; x=1790121305; bh=YFwpbodWFb
	1HdQ912a7XKm0aCVlwbKbulVbq1KmYidc=; b=Rgllev+hxa/TuN1WKWJEpOevIY
	9+o3oE6JIfJiDZYRFYpCzAjeYGvEFSCOA/8P8fnVPSOx74DbdkALwMBw/U24v7TR
	ojPg9t9lgGD58KX3YrJhTuIIjmEUv9mkJVGoFEgOL2guPGauPtMSRCfLm1VVY1Uc
	2eBWSMrTckqikRqGFtCq6fJv77V6NHMu44f8MDLl8YwTG6kwUaEcFOG9XKYdi6t3
	iwYg0c35wMXeuh8aF8VN6nNEKQ0UhzaQI4ooZYzuYi2Lk4mtm10+rARkzuBonAqu
	rQ/XhO1hWdCwo38EPvjIqE98NHqNLu59CJBvlc/tn/fU8+bOtTPEUzP6mKMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790034905; x=1790121305; bh=YFwpbodWFb1HdQ912a7XKm0aCVlwbKbulVb
	q1KmYidc=; b=ntl9o/bU+9IMg8hEGzpCI2dPWfy30i93GPSKk49MrlUoecsmQ1n
	m/nOelaa8W/+Ov+6qjPBC1aQGhOtWAQtZdShcPmx25S91gyZRqA+JmxNZwE7VPYb
	bK2muKzfvfPBFP+BvtQT/hue6J2n/nsjagrp+j3FXuLSFbpgqb2urvpNxmh+38mv
	cOiX5I/ZRH/7g+CWT+knapF6PJyGU5vrXVc91lEIpiVfU2fb2ItY+8ecVeQOahW8
	P2i3D5XiiP4CDr+loe/yciV0cFlX5BVOGHds7BJ8AlZ3jMijebD6ev377+nQz7/k
	x0CfU2XLQKQzjXLhtEajUtqGJFO4oeMLNFA==
X-ME-Sender: <xms:2cOxapLMCkTraANGBRwmI2ixlyUdriXYFlDhTSCqtL0K2ebEF-e-Jg>
    <xme:2cOxansmsBGxnr4boRQ4TOMNE_aY686PW0eZD5Pc1QXx1Z0ONk-zGwK2-7jyA2Wsb
    UYCuMKiR_IrcZx0bk7ephQLdIzc7vUBl3kJL3-Y0X5hi23WFv5jfA>
X-ME-Received: <xmr:2cOxalW5FHWpcd2LnU0I7am3eW3Z_jA8etZKwodXTdWtwbu2X0hadmC5o5Q7ENRlGdyz7VuzfGV9Z64PS8bHdWRB5TT0fmAVhpyd>
X-ME-Proxy-Cause: dmFkZTEO1hsYJqueJpR2+ohcd6AmT8KAN2SpUKXUh096lwq5OWDdTYY1XVDE4G28Ooa1iX
    VElGgOlngZs5MP0dv0QBQXMZbaB8FdQZz2z0vOElVZgmB+29BFGEKataybAAVri6/ZVntN
    BJn/0YIZdjTxAg+qTvD43lgdVcMxa9cmIteIg1gUOpDO5wuTAL6fVs/0KK3BiFTBiDrMLr
    8sg+xlQG8AyZ9mKZZMgC3UgYkt5lwiFgAOzzgiVIINHaHpKWRCj1TW4H7kv1xXHDeEB71W
    qPGmr36XGxbiV3v1hmIxHx3Q1kiOH7sdVKVx2p0hdGT83kH5bVRMM30wzVPy71k4ebd1Ap
    AKaWEbrtezfZCN5NnVuVVn4Bjqhf3x7US+R9HTd3EpjKCFoBmq5frpxhAJ4yILWrxQh1t6
    MqJSDoS1TG4ulbehyY9jqH5t228oRAA5znrd2oUW3m0yAqJVHvm+57Jovq99QjCF/NX5JM
    dMja1fTa0mrZF/WMZULiPHY2P9qCVQXovbSpnasiJH8zQLcwubsK55lB3YVzxpLgL0RESf
    9Ag2aCEyeLjH/Yok5Qc9XhNIxVVBSVPhwJFFD93U3sLJMxkRS79mAqjJZfiN4ICHDP0Q5A
    jI54Fa9Lw6AU7XHu7hx9+1Lk9YjpaQkd1fpxgomalAPcgy9tOQaIM6Mqmgwg
X-ME-Proxy: <xmx:2cOxaqj8PRYo7sLqUR8OkMfN2pWxHZVst8gzfLEcixK8Fp_3ShGACQ>
    <xmx:2cOxalqzw0WQQK818qIUhvMFHBd5aoJE3iISeFI7JAJYNUchsV9bTA>
    <xmx:2cOxaoHvD_wLXUZzPOoNImy698A-elaPgPT8AUf9y-6YhAwWH49I7w>
    <xmx:2cOxai7c6RVgfCDCcA-nuscfFc4I-JLe79d_EPhqVKaKiAXBfaTZ4g>
    <xmx:2cOxavVng6wDSfYnV08B1bMoLtKX3iivvzbhyo3NBjrEmdzuVv_sBrCf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 19:55:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phil Hord
 <phil.hord@gmail.com>,  Elijah Newren <newren@gmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  "D . Ben Knoble" <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/3] refs: allow callers to supply old OIDs for batch
 deletion
In-Reply-To: <5c96a5a1ebafd49a301c5c1dc77a2e19d6677ab0.1789901584.git.maciej.ciemborowicz@gmail.com>
	(Maciej Ciemborowicz's message of "Sun, 20 Sep 2026 12:54:20 +0200")
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
	<5c96a5a1ebafd49a301c5c1dc77a2e19d6677ab0.1789901584.git.maciej.ciemborowicz@gmail.com>
Date: Mon, 21 Sep 2026 16:55:03 -0700
Message-ID: <xmqq4ifijh2g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> refs_delete_refs() currently performs unconditional deletions. Thus callers
> cannot preserve old values that they have already resolved, and
> reference-transaction hooks consequently see a null old OID.
>
> Add an optional oid_array whose entries correspond to the refnames.

I had to read this sentence three times and still couldn't guess
what it wanted to say.  I _think_ the code is passing a list of
refnames, and your new parameter that is oid_array serves as a
parallel list, where the ref, identified by the Nth element of the
list of refnames, is protected from deletion with the Nth element of
the list of oids in such a way that ref is not removed unless it
points at the specified object.  You'd need to find a concise way to
tell that story instead of the above sentence that does not give
readers any meaningful information.

>  int refs_delete_refs(struct ref_store *refs, const char *logmsg,
> -		     struct string_list *refnames, unsigned int flags)
> +		     struct string_list *refnames,
> +		     const struct oid_array *old_oids,
> +		     unsigned int flags)
>  {
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
> -	struct string_list_item *item;
> +	size_t i;
>  	int ret = 0, failures = 0;
>  	char *msg;
>  
> +	if (old_oids && old_oids->nr != refnames->nr)
> +		BUG("refname and old OID counts do not match");

OK.  So it is not end-users' but calling code's responsibility to
ensure that the optional list of object names have exactly the same
number of entries as the list of refs.

>  	if (!refnames->nr)
>  		return 0;

And this is as before.  Shouldn't the new test above be placed below
this?  After all, if we are removing no refs, we really do not care
what garbage is in the old oids array---we won't even look at it.

>  	msg = normalize_reflog_message(logmsg);
>  
> -	/*
> -	 * Since we don't check the references' old_oids, the
> -	 * individual updates can't fail, so we can pack all of the
> -	 * updates into a single transaction.
> -	 */

To me, this reads more like "We want to make sure that each deletion
is independent and philosophically each of them should belong in
separate transactions so that even when some fails the rest would
proceed.  Luckily, the current API does not allow you to check the
current value to protect refs from deletion, so we can cram all
delete operations in a single transaction and still claim that we
are not making it all-or-none!".  Natural continuation of that
argument is "If we ever extend the API so that refs are optionally
protected from deletion, we can get into a situation where some refs
can be successfully removed while others cannot.  Keeping everything
in a single transaction WILL BECOME A WRONG DESIGN CHOICE when it
happens."

And this new code is doing exactly that, making all the deletions,
of possibly unrelated refs, into an all-or-none matter.

Don't we need to have separate transactions to delete each ref to
retain the "delete them independently" semantics?  If the caller
(e.g., "git fetch --prune" without "--atomic") wants to delete 1000
refs, and a single ref fails its old-oid check due to a concurrent
update, none of the 1000 refs will be removed and the transaction
would be aborted.  <refs.h> explains this function like so:

    /*
     * Delete the specified references. If there are any problems, emit
     * errors but attempt to keep going (i.e., the deletes are not done in
     * an all-or-nothing transaction). msg and flags are passed through to
     * ref_transaction_delete().
     */
    int refs_delete_refs(struct ref_store *refs, const char *msg,
                         struct string_list *refnames, unsigned int flags);

because we want to avoid exactly such a failure mode.

I do not offhand remember if our ref transactions have a mode where
it acts more like a glorified "batch" job and commit does not
necessarily require everything succeeding, but if it do, then it is
OK to keep using a single transaction but to run it in such a "best
effort" mode.

>  	transaction = ref_store_transaction_begin(refs, 0, &err);
>  	if (!transaction) {
>  		ret = error("%s", err.buf);
>  		goto out;
>  	}
>  
> -	for_each_string_list_item(item, refnames) {
> +	for (i = 0; i < refnames->nr; i++) {
> +		struct string_list_item *item = &refnames->items[i];
> +		const struct object_id *old_oid = old_oids ? &old_oids->oid[i] : NULL;
> +
> +		if (old_oid && is_null_oid(old_oid))
> +			old_oid = NULL;
>  		ret = ref_transaction_delete(transaction, item->string,
> -					     NULL, NULL, flags, msg, &err);
> +					     old_oid, NULL, flags, msg, &err);
>  		if (ret) {
>  			warning(_("could not delete reference %s: %s"),
>  				item->string, err.buf);
