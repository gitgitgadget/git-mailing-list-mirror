Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C05239581
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293118; cv=none; b=ha+AQg0+8LNpEUp5+NJV7cSXm9e2LizPBd9DdLIyiQzt/eRCGvQLOhrlCRFCN8JwmCS6aJAAC5YvvplXtZ/bKCTgB4ODUqnhqhXAJf7zRgsjHhedseNiUER3S5IcsHgK/2+VcaqrUePQ7MQwNbqNOjkR98I0PUwPidZ/9JFyxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293118; c=relaxed/simple;
	bh=QNp3CKraZTObnOUwjpGsCC3PPLQOS/4Vc/u42gq9oYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7IJZTWzvIi2LOUmJSyxno9B01uUgl21deSLcRfv1udu1hXb5L5QyUcczCwVDH3/d/0MtrE8tmkbpyB7OptIYesbHAOU9zbzQ0WPUUmv0ftX3Laqo3AJD3htnVuTqVrT+ocsl+ckTDimybdcZBuUoI52tQzwaLsLhatjsnQgRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iPsgFam9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHAT8rbT; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iPsgFam9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHAT8rbT"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3D537A00BC;
	Mon,  4 Aug 2025 03:38:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 04 Aug 2025 03:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754293114; x=1754379514; bh=W8i/VnDAiT
	m1PmXjK1LEp1+RYtCcZ6WVvjzJlaZ1iVA=; b=iPsgFam95jMPqLsmcCCny2vrRv
	eoAZxoZAvOxHv/j7XlCGzxfCRo4EnDQLvvqKW45nNu5vENhV/my3Iwd2IvPrtXRr
	Fqw/WRF8zh17uEY2DpyhL6ACyvkQXz9jlqHIQgboPChTCRnAvmlKvw7FdltZZ7u3
	nCLB4QDXijv3ihdqMFXcSSqQwedxXNivISn944rGjq+Anh3xYnd+qLu3UJ6lcc+p
	R1zkfoPmC1li7VNhCH1+aOktokztgOkx2lVknaZ+SLRYe2LS4B7HGie99EyhwC7W
	BVbkd6EiEKkG4rv5+CNDViZzU//RFG9JZe8t443ljSxxr7iPOn682thy16fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754293114; x=1754379514; bh=W8i/VnDAiTm1PmXjK1LEp1+RYtCcZ6WVvjz
	JlaZ1iVA=; b=CHAT8rbTfFl6o8tWn7dNvFXkLqCEeK/6DFn43QYM9aY16RMAfFk
	15G3VJlNankU3SunwBluAMEarPwoF1b4jSCvT4zxuQujm1QQV0Yx7g3/CUnIw70n
	e/am3oVUpV8cf3cJtUPnTwNtnaG+IxXtGDVV6FzBE4UFY9Ma6U6IA5i2EB7RLG3N
	pBuS76pBt3K0vgQEPgwOrgLH7GTMnJI8e4M2GEP+3YVlIOcaZ0yr2NrBvNpOBP0F
	CWOBT9hqet1FqD9j3NBUh+dD86YW04h7ZBy/4R1jv4ypZjViH+eBh2Vh2yzFhGr1
	WD2mAGeaS955UiklHOyhq56fiSQMXiSz4cg==
X-ME-Sender: <xms:emOQaPH3GP-qJM6hl4xHvZC2qf8VsZ4cY8CxQyV7wDsLIH_ZNHefow>
    <xme:emOQaJPsrSNRSXRxIKCtuBNc5pl6_lj3_1FAQgCH_aD6yvqAEKFUT5QxhIQxIy96P
    yAu6iwn7J9bRacOjA>
X-ME-Received: <xmr:emOQaA6CqhK7VdGIjnZMWrq94yDGADyejNxxsXtqXjtK3Dc6cHM8oVC_Nof-PKCUoExiQqlufSW0_AoqqKKoFDauYQ95niSG_WNZYbdgWww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:emOQaMgj2q0AIRYXqPUfJZjoIjRO0imWJ0_y_xW05th4PA1ybLe4WQ>
    <xmx:emOQaFeiCIB1frXJti6sr4kkSbuR_kGAUDP9k1O2KTCJ0gDw0MRwnw>
    <xmx:emOQaExFwigVOFwoULI_Lh6azMUcsm7QiHhk9VYj2SN2XZHjgXf5cw>
    <xmx:emOQaE2w1SYHwBbrrnzYcfJ7mZul5m0njerDYTl-hI0XXKb3MQ8GWw>
    <xmx:emOQaNqW-VTteX72cjaFoQq6M-AwEnZESZvRQlIohq7e5DSei4VGjI-g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 03:38:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3737dd59 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 07:38:32 +0000 (UTC)
Date: Mon, 4 Aug 2025 09:38:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 7/9] refs/files: detect race when generating reflog
 entry for HEAD
Message-ID: <aJBjdWv9qUeBL25-@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
 <20250729-pks-reflog-append-v3-7-9614d310f073@pks.im>
 <20250802111128.GC1180347@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802111128.GC1180347@coredump.intra.peff.net>

On Sat, Aug 02, 2025 at 07:11:28AM -0400, Jeff King wrote:
> On Tue, Jul 29, 2025 at 10:55:25AM +0200, Patrick Steinhardt wrote:
> 
> > Unfortunately, this change only helps with the second race. We cannot
> > reliably plug the first race without locking the HEAD reference at the
> > start of the transaction. Locking HEAD unconditionally would effectively
> > serialize all writes though, and that doesn't seem like an option. Also,
> > double checking its value at the end of the transaction is not an option
> > either, as its target may have flip-flopped during the transaction.
> 
> I agree we should not always take a lock on HEAD, since most refs would
> not need it. But I wonder if we could do better by examining HEAD, then
> taking a lock when we think we'll need it, and then re-checking the
> value of HEAD. That is still racy, though (somebody could have pointed
> HEAD at us between the two checks). Fundamentally the files backend is
> not atomic across the whole namespace, and we are trying to update two
> refs. So I think there will always be some race.

We do that though. When queueing the log-only update for HEAD we don't
lock immediately, but we lock once we process that log-only update. And
that's where we now do the check whether HEAD has changed meanwhile,
which should be race-free given that it did change indeed.

> It does make me wonder if this race-fix is even worth it, then. We are
> catching the case where somebody moves HEAD away from the ref we are
> updating while we are updating it. But without atomicity, do we even
> know which happened first? That is, would it be incorrect to update
> HEAD anyway? I guess the outcome is observable because their movement of
> HEAD generated a reflog entry, and thus the entries would be out of
> order. So maybe that is worth it.

So with the above I think that we are race-free for the case where HEAD
has been modified after we have decided to write a reflog entry for it.
We aren't though in the case where we _haven't_ decided to write a
reflog entry, as HEAD might have been adjusted to point to one of the
updated refs meanwhile as you rightfully point out.

But I think that's an acceptable tradeoff. I'd rather write no reflog
entry than an incorrect one.

> Anyway, I had two questions about the code:
> 
> > @@ -2600,7 +2607,36 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
> >  
> >  	update->backend_data = lock;
> >  
> > -	if (update->type & REF_ISSYMREF) {
> > +	if (update->flags & REF_LOG_VIA_SPLIT) {
> > +		struct ref_lock *parent_lock;
> > +
> > +		if (!update->parent_update)
> > +			BUG("split update without a parent");
> > +
> > +		parent_lock = update->parent_update->backend_data;
> > +
> > +		/*
> > +		 * Check that "HEAD" didn't racily change since we have looked
> > +		 * it up. If it did we must refuse to write the reflog entry.
> > +		 *
> > +		 * Note that this does not catch all races: if "HEAD" was
> > +		 * racily changed to point to one of the refs part of the
> > +		 * transaction then we would miss writing the split reflog
> > +		 * entry for "HEAD".
> > +		 */
> > +		if (!(update->type & REF_ISSYMREF) ||
> > +		    strcmp(update->parent_update->refname, referent.buf)) {
> > +			strbuf_addstr(err, "HEAD has been racily updated");
> > +			ret = REF_TRANSACTION_ERROR_GENERIC;
> > +			goto out;
> > +		}
> 
> One, what happens with a multi-level ref (e.g., HEAD points to
> refs/heads/foo which points to refs/heads/bar)?
> 
> We've resolved HEAD to get referent.buf. Do we get "foo" or "bar" here?
> If "bar", then a write through "foo" will complain. But if we get "foo",
> then theoretically a write through "bar" will complain.
> 
> I _think_ we are OK, though. Constructing it like this:
> 
>   git init
>   git commit --allow-empty -m whatever
> 
>   git symbolic-ref refs/heads/foo refs/heads/bar
>   git symbolic-ref HEAD refs/heads/foo
>   git update-ref refs/heads/foo main
> 
> triggers the check and shows that our referent from lock_raw_ref() is
> the first level (i.e., "foo"). Which is good.
> 
> If we swap out "foo" for "bar" in the update-ref call, then we'd get a
> mismatch. But in that case we do not figure out that HEAD needs be
> written at all! That is, we only do a single level of look-back to
> decide whether to write HEAD at all. So as long as we keep doing so, we
> are OK.

Yeah, the whole code is best-effort only and doesn't work for all kinds
of edge cases. The mere fact that we only handle this case for HEAD is
already a limitation -- in theory we should do it for all symbolic refs.

> > +		if (!(update->type & REF_ISSYMREF) ||
> > +		    strcmp(update->parent_update->refname, referent.buf)) {
> > +			strbuf_addstr(err, "HEAD has been racily updated");
> > +			ret = REF_TRANSACTION_ERROR_GENERIC;
> > +			goto out;
> > +		}
> 
> And two, is an error the right thing here? The user asked us to update
> "foo", and we saw that HEAD pointed to it. So we decided to update
> HEAD's reflog, too. And when it came time to do so under lock, we found
> that HEAD did not point to "foo" any more.
> 
> Shouldn't we quietly drop the HEAD reflog update, rather than forcing
> the whole transaction to fail? The user never asked us to update HEAD at
> all. It was something we opportunistically decided to do, and now we
> find out that it is not appropriate to do so.

That's something I wasn't quite sure about, either. Honestly, the reason
I shied away from it is that it needs a bit more munging for an edge
case that is hard to test reliably. But I guess we can do something like
the below patch to skip writing the reflog message instea.

Patrick

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 905555365b..851b1b33f4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -643,14 +643,16 @@ int parse_loose_ref_contents(const struct git_hash_algo *algop,
 	return 0;
 }
 
-static void unlock_ref(struct ref_lock *lock)
+static int unlock_ref(struct ref_lock *lock)
 {
 	lock->count--;
 	if (!lock->count) {
 		rollback_lock_file(&lock->lk);
 		free(lock->ref_name);
 		free(lock);
+		return 1;
 	}
+	return 0;
 }
 
 /*
@@ -2557,6 +2559,9 @@ struct files_transaction_backend_data {
  *   the referent to transaction.
  * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
  *   update of HEAD.
+ *
+ * Returns 0 on success, 1 in case the update needs to be dropped or a negative
+ * error code otherwise.
  */
 static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *refs,
 						      struct ref_update *update,
@@ -2617,7 +2622,8 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 
 		/*
 		 * Check that "HEAD" didn't racily change since we have looked
-		 * it up. If it did we must refuse to write the reflog entry.
+		 * it up. If it did we remove the reflog-only updateg from the
+		 * transaction again.
 		 *
 		 * Note that this does not catch all races: if "HEAD" was
 		 * racily changed to point to one of the refs part of the
@@ -2626,8 +2632,16 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 		 */
 		if (!(update->type & REF_ISSYMREF) ||
 		    strcmp(update->parent_update->refname, referent.buf)) {
-			strbuf_addstr(err, "HEAD has been racily updated");
-			ret = REF_TRANSACTION_ERROR_GENERIC;
+			if (unlock_ref(lock))
+				strmap_remove(&backend_data->ref_locks,
+					      update->refname, 0);
+
+			memmove(transaction->updates + update_idx,
+				transaction->updates + update_idx + 1,
+				(transaction->nr - update_idx - 1) * sizeof(*transaction->updates));
+			transaction->nr--;
+
+			ret = 1;
 			goto out;
 		}
 
@@ -2896,6 +2910,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					  head_ref, &refnames_to_check,
 					  err);
 		if (ret) {
+			if (ret > 0)
+				continue;
 			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
 				strbuf_reset(err);
 				ret = 0;

