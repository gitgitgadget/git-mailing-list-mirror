Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A813209
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805816; cv=none; b=tQxHk9kGyXeqBRcehVeoRn2/38OKbejz0m0V9NLmAqvPw/9YUv4k44uL3RJBiCyZ3QB6+RIK6rtg8cV5QqTl6D7mztROD5ICbSlsDV4514s/ARA+hcaEvzosPrfk3alRuFzeGszOr54/BenSnz0zjPbx3HmMKsDhxeHJ82ZWZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805816; c=relaxed/simple;
	bh=7dQNjuI4KeKa7WfbEEtb7ZBsQOzsPsQIvXtGCYBbE7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BlqUZjCwU70p9q/IO7mhoRcCX6/ESzezBObsmnHme+sLNfkyieHCOM4y+ND6l9SqNGLCCp4O5ktcSnNeUZkKwRTYxfVv/8mFDUhZNot1HI7o6uFCpqTD4VGJ1p/X78nDvzi7C1Ymobp8bBnw6xRPq4Q4ZkV7nvyxzr3NkJXNpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P9cCFEhm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FmC3hcNb; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P9cCFEhm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FmC3hcNb"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 658027A085C;
	Tue, 29 Jul 2025 12:16:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 29 Jul 2025 12:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753805813; x=1753892213; bh=WenCbtX+dO
	YgY192E0ruCv7Il57ydDc6xGE1ij8BJdU=; b=P9cCFEhm0d5Nart1vf60zJk9RS
	FnUtS3E7r+9YMBEfH+s08JhMM/VW1HkoKnnU3+ih75LRTMaN6ODuPW2NsfhA994N
	FIMXsiZUaH9EAD7TsCsNcoOJdl1yfuzp1uYXAnUUmvwqqfer1iEg2/0/ZppYz6tY
	a7bkXLPG+HCZGG+VXm9zetNvQPudaHnVt6MVzEfL2oh8ZukOb61l+utzvHYRwJq0
	Lj5jOENrcGOFDeT3QqmgKfekX1CH4DlIsT40BbPM2nMcJX/vZNu1U1T+BV8JpCJk
	Ty2pnjWvEDIH8ekMabCEUniOxrjc+XKk0mLXutsXGygW9zm2nysXMRjCH0jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753805813; x=1753892213; bh=WenCbtX+dOYgY192E0ruCv7Il57ydDc6xGE
	1ij8BJdU=; b=FmC3hcNbjtEF4kA+r6a/c/jPfA36xHeB0BaGagG/r/TWZKmhYdv
	1vchQvvQyg7dC7QBqdbq4dR1zZfW2kifsKu3xLzdnB7xu0yjO2k1xSYX6eK4L7P8
	VVmqX8qctSKJ4EfMuylAzbhDyV8IWnLL/bmvZFpg6mzQGRX7YrWKvMQtMTIqbRpj
	nS20jhHthwB1Te1b2tpkJJvTHlTw43UK9yRlYbJT8V685AJad7Xc5ZzbCdqkQx1K
	dsKwWTTOtwyoxNDeJDR8SlJ1fGK35m51NQCmG3n8IH89O59vdrF+ij6hd3n7uRVe
	u2elLOPLfP30ITZMRtG5FRDCiUvicvVdWww==
X-ME-Sender: <xms:9fOIaFkRny94WJsUIw5kw4KOu8Jyx-FCfEywaD_FbSCLZt4UatFbLw>
    <xme:9fOIaMiRAtCjLf7fyQWluZSJO9zLJikUEOOReLPqvhvC5UjnP_fhOtj9nUhJ6lRq9
    -TfMfXZmz0fI0QuVQ>
X-ME-Received: <xmr:9fOIaIHD5uQ6bQVWM5LiyZccUnd8_XBuLjSYLPJPGO968-m6N5z6xqeG3AXbQySQ7K3zJVx9Gs0gVv9UGYp-tbIzerRbgHh7lg-rE8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelheehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:9fOIaOv78D4EdvkLmhTmnJtjlHdLUSBsXsbjgQ7L1lJcyfYnV8n3xA>
    <xmx:9fOIaJfcli5RaFdHzKgnZV-ukEQA-zWIIJCLzGNZekOMXwOwDrpP7g>
    <xmx:9fOIaEn_X0H3rcAw9OEzK4cG4rO8xIf-KlI-Zzn8LMXoy5Tn3xRKoQ>
    <xmx:9fOIaMBY-Xx7RzWuyC8hZHRCLqCHKONVSSRrGS0RQpkERXvZTmEI4g>
    <xmx:9fOIaPKVCskOPxzAcc662ehqcPnGI4cAe4cwd3KVWEp1t1WWN7qtVpPl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 12:16:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Toon
 Claes <toon@iotcl.com>,  Jeff King <peff@peff.net>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 7/9] refs/files: detect race when generating reflog
 entry for HEAD
In-Reply-To: <20250729-pks-reflog-append-v3-7-9614d310f073@pks.im> (Patrick
	Steinhardt's message of "Tue, 29 Jul 2025 10:55:25 +0200")
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
	<20250729-pks-reflog-append-v3-7-9614d310f073@pks.im>
Date: Tue, 29 Jul 2025 09:16:51 -0700
Message-ID: <xmqqpldjotu4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When updating a reference that is being pointed to HEAD we don't only
> write a reflog message for that particular reference, but also generate
> one for HEAD. This logic is handled by `split_head_update()`, where we:
>
>   1. Verify that the condition actually triggered. This is done by
>      reading HEAD at the start of the transaction so that we can then
>      check whether a given reference update refers to its target.
>
>   2. Queue a new log-only update for HEAD in case it did.
>
> But the logic is unfortunately not free of races, as we do not lock the
> HEAD reference after we have read its target. This can lead to the
> following two scenarios:
>
>   - HEAD gets concurrently updated to point to one of the references we
>     have already processed. This causes us not writing a reflog message
>     even though we should have done so.
>
>   - HEAD gets concurrently updated to point to not point to a reference
>     anymore that we have already processed. This causes us to write a
>     reflog message even though we should _not_ have done so.
>
> Improve the situation by introducing a new `REF_LOG_VIA_SPLIT` flag that
> is specific to the "files" backend. If set, we will double check that
> the HEAD reference still points to the reference that we are creating
> the reflog entry for after we have locked HEAD. Furthermore, instead of
> manually resolving the old object ID of that entry, we now use the same
> old state as for the parent update.
>
> Unfortunately, this change only helps with the second race. We cannot
> reliably plug the first race without locking the HEAD reference at the
> start of the transaction. Locking HEAD unconditionally would effectively
> serialize all writes though, and that doesn't seem like an option. Also,
> double checking its value at the end of the transaction is not an option
> either, as its target may have flip-flopped during the transaction.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)

This is a step new in this iteration.  I sometimes wonder if the
world were in a much better shape if I didn't record the updates to
underlying branch in the reflog of HEAD (and limited only to record
switching branches), as this is a fallout from the (mis)design.

Anyway, I agree that the change in this patch matches the above
description and takes us in a better place ;-)

Thanks.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index bf6f89b1d19..ba018b0984a 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -68,6 +68,12 @@
>   */
>  #define REF_DELETED_RMDIR (1 << 9)
>  
> +/*
> + * Used to indicate that the reflog-only update has been created via
> + * `split_head_update()`.
> + */
> +#define REF_LOG_VIA_SPLIT (1 << 14)
> +
>  struct ref_lock {
>  	char *ref_name;
>  	struct lock_file lk;
> @@ -2420,9 +2426,10 @@ static enum ref_transaction_error split_head_update(struct ref_update *update,
>  
>  	new_update = ref_transaction_add_update(
>  			transaction, "HEAD",
> -			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
> +			update->flags | REF_LOG_ONLY | REF_NO_DEREF | REF_LOG_VIA_SPLIT,
>  			&update->new_oid, &update->old_oid,
>  			NULL, NULL, update->committer_info, update->msg);
> +	new_update->parent_update = update;
>  
>  	/*
>  	 * Add "HEAD". This insertion is O(N) in the transaction
> @@ -2600,7 +2607,36 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
>  
>  	update->backend_data = lock;
>  
> -	if (update->type & REF_ISSYMREF) {
> +	if (update->flags & REF_LOG_VIA_SPLIT) {
> +		struct ref_lock *parent_lock;
> +
> +		if (!update->parent_update)
> +			BUG("split update without a parent");
> +
> +		parent_lock = update->parent_update->backend_data;
> +
> +		/*
> +		 * Check that "HEAD" didn't racily change since we have looked
> +		 * it up. If it did we must refuse to write the reflog entry.
> +		 *
> +		 * Note that this does not catch all races: if "HEAD" was
> +		 * racily changed to point to one of the refs part of the
> +		 * transaction then we would miss writing the split reflog
> +		 * entry for "HEAD".
> +		 */
> +		if (!(update->type & REF_ISSYMREF) ||
> +		    strcmp(update->parent_update->refname, referent.buf)) {
> +			strbuf_addstr(err, "HEAD has been racily updated");
> +			ret = REF_TRANSACTION_ERROR_GENERIC;
> +			goto out;
> +		}
> +
> +		if (update->flags & REF_HAVE_OLD) {
> +			oidcpy(&lock->old_oid, &update->old_oid);
> +		} else {
> +			oidcpy(&lock->old_oid, &parent_lock->old_oid);
> +		}
> +	} else if (update->type & REF_ISSYMREF) {
>  		if (update->flags & REF_NO_DEREF) {
>  			/*
>  			 * We won't be reading the referent as part of
