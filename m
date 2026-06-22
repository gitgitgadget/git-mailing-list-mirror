Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593371C5D5E
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151034; cv=none; b=X12+BnOy5pX/7wm9IF0aeeY+TPidgOSagwGoanLeBE+s5CM2Of6Rj8DQqAp+q6o/U1bS4qe46qNYzlDr+Te12vSaXQDsqRMkn01GVjh1pTFEBClaBt+vCQgdizp05/s1gBvGIc1GkzuW7YQy3g+D2C3H3ytFiK0+DVk/0euJaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151034; c=relaxed/simple;
	bh=UUR7KeMduY6Mu0XJl4KAlCwRCuVrS24HAGYo/W0We68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIgnlePztCbVQWqYOtm5J4qKx/w0rfXBGLFo+jmM7FsOOEGhJxfsoD8jkk+frhrtaQ3fqrSC3D6EkPhZm9mexVVo4AU1VgACaMRln1wGbI085oXnKLx7DoOdd+yBfrTujlF62ASvcuyGxrwOqGK4bJYPeg+awVDESa4TREzxBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eTo7Sjlp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cEbtFt/7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eTo7Sjlp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cEbtFt/7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96CE31400162;
	Mon, 22 Jun 2026 13:57:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 22 Jun 2026 13:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782151032; x=1782237432; bh=qL43brIOou
	zPgfbMpIRWC4gIVZFh3iqjkmhCvPhHuyE=; b=eTo7SjlptY/evo+kR4xNV/wjRY
	k/Q+NdlTSG8xFVRDSp1+jWqDt/tOJrXArdnnEWevan4KVgwhzEKFIFL3GvyOOmV7
	Xzrtip5Jq9uiFH5vGw49KHmeeCelScx2vN4+7nwYL/5ZNadvLr1kiT9eELKVyb1z
	csM0g36PX8jGQxQikOtn39t3XfoqNoDWvVCX3Au/BUT9hXUg67vh9g/oNDgxEUok
	dpW2TnNd7F0AQTiBrgFk0rUP50AfkuFw430SskkEOfd0iXpUx8x6KIZBDqWFfyfq
	DXDSUDzqALrLylgu8G3fRuaKx06YrveUVI9H7n357UPwW6ZT1/LQ3hbtr3pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782151032; x=1782237432; bh=qL43brIOouzPgfbMpIRWC4gIVZFh3iqjkmh
	CvPhHuyE=; b=cEbtFt/7cuU8MGO4tZQdD6TY5Hilv1Amf1TXRGD04s8/yjVcJ3z
	VOwJwbjJ9kSMXIyjXKQCctXC6mBDnmpYCH/+2fkkAzc1nixYoDNiQgPdYWqXb+i8
	9+Cc+f7R4X5a3YK/qsmvubILIH1Xui1ZrYb+jgke9eI4GCGWRwPff1elAy48HP8U
	fewqjWNgPTC5dRGpqlcqKPnSzJWSCjnVz7bMRDL/pLfJ0FYxn3X/Z0yLhrh1fnoN
	bnfl63cm8Jf/u8U/zed2/u449y2PBuckRdTqbbTiRlicqgZR3bIqUBhOboUh5II0
	O0EpW37283gEJQ6y7NDi4W2VZ1MK5gOnI2w==
X-ME-Sender: <xms:eHc5atjo_IzYLzBGwBdTpp64-hfiUc7pllpqCqd5RdiEIOc9cwx0KA>
    <xme:eHc5apcr0-kkx-90YS9CabDafcTkZGnaVFfx7W0Js_muYW6liNKu653DLFEloSr23
    XKeQodRk-5rJHTD2futdhPvvZ_MgHGN31JBts3vYbca58qIecs9Vg>
X-ME-Received: <xmr:eHc5aqdBxZ0YhWtcR6fAHQ_itR21-ZM8PaWzaHnzGyvZcesWLB_bvS5CyiMRDLnY_OKda_1RPU8j0mRr5rg9YJEFvVwSXjWUgu0Cy6g>
X-ME-Proxy-Cause: dmFkZTGOuPBnz/030DTsbUmNb1ai6uir3XV/1hEhLG/KJLZv6y4/i2HHOXXE0EKN/wqXUY
    K0FeVvKDW4U/H0rm0q3ZmSJ6QEQQZJ0YWPOBebI9B5w8eJ/DWVAzDC228rI32rctedgqqh
    tJDqyHMC+P1EYwoAhPBWcJtXA2brenARPthLCtKLiOywwQYPaGRv/WTgFjJ9EiXymRHHtK
    AKOdLDel2fuS5thWA9ljCZP53KrCq96tBN5eexsjwBXXPqIroiRu9EKn4nHY9qo7RgSJ6O
    cae5JAEWpvk5/cf8OBqVNVzC45RN/qo+HhOPDI+mFNt5vNsa01xH/qGchU2dknyYAtq8h8
    fJVOZ4j6l67RxhdmWnbQkw25WrmIgCKvBkTAUzyIi7fP7tnyte4rfAB9pP8OyTDk42Qoei
    RKm5ZyVJpil+oXiktW6LY8Nk66pnFtUFPZCDik2JeeAUH1azP2OsXJU4fYgjg/QAzF3XIJ
    Fkq45yZtr25ivphPbGNi7rdtTvB3WwSdp/KcpVn02WmTkoT+3C+Z5/8WT7SM4VBz6KdbkS
    D82YnZPUnIVV9IH9rRUyVYmRI3ctr3b9xASIzJ4Gc8QcW6mPMr7zzaZuiROxvAl/SWlAtC
    I62dk3bLvTxSU+ukN55xvlunnc7K3c3WAFbFPJiPfwf34Xrra/CZX1PyKGkg
X-ME-Proxy: <xmx:eHc5ar-Bt6bln_IFd8Xsr1eB5_sa1Ng0k6IVjjeiJ19SL9-uBHgjRA>
    <xmx:eHc5aulTKYMiYuA8pCg0BDfe-rudeGrIlOXBNe8DKf4qpCwrynVgvg>
    <xmx:eHc5al-RWW3iGyvRwrEVGt96_HNRj741sA-s18xoVxC6o3KdQqGgwg>
    <xmx:eHc5aklJJdsZ4IHaB26nZvarSm0DKSpSuwzbkHR2js5N2uMvX9nw-w>
    <xmx:eHc5ahkx13dBKSerVZoXRZDq1_RabbO3NISrtiHbSyCFv9jPQ1eDaYXQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 13:57:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] connected: search promisor objects generically
In-Reply-To: <20260622-pks-connected-generic-promisor-checks-v1-3-25eba2698202@pks.im>
	(Patrick Steinhardt's message of "Mon, 22 Jun 2026 10:49:29 +0200")
References: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
	<20260622-pks-connected-generic-promisor-checks-v1-3-25eba2698202@pks.im>
Date: Mon, 22 Jun 2026 10:57:10 -0700
Message-ID: <xmqq4iiu1mrt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When performing connectivity checks we have to figure out whether any of
> the new objects are promisor objects, as we cannot assume full
> connectivity if so.
>
> This check is performed by iterating through all packfiles in the
> repository and searching each of them for the given object. Of course,
> this mechanism is quite specific to implementation details of the object
> database, as we assume that it uses packfiles in the first place.
>
> Refactor the logic so that we instead use `odb_for_each_object_ext()`
> with an object prefix filter and the `ODB_FOR_EACH_OBJECT_PROMISOR_ONLY`
> flag. This will yield all objects that have the exact object name and
> that are part of a promisor pack in a generic way.
> ...


> -		 *
> -		 * Before checking for promisor packs, be sure we have the
> -		 * latest pack-files loaded into memory.
>  		 */
> -		odb_reprepare(the_repository->objects);

Hmph?

>  		do {
> -			struct packed_git *p;
> -
> -			repo_for_each_pack(the_repository, p) {
> -				if (!p->pack_promisor)
> -					continue;
> -				if (find_pack_entry_one(oid, p))
> -					goto promisor_pack_found;
> +			opts.prefix = oid;
> +
> +			err = odb_for_each_object_ext(the_repository->objects,
> +						      NULL, promised_object_cb,
> +						      NULL, &opts);
> +			if (err < 0)
> +				break;
> +			if (err > 0) {
> +				err = 0;
> +				continue;
>  			}

So we used to manually iterate and stop when we have a matching pack
entry, but now "stop when we find" is done by promisor_object_cb
callback that returns 1.

What is the reason why we no longer odb_(re)prepare() upfront before
going into the loop?  Would it make us miss a newly added promisor
packs?  We will fall back to rev-list for correctness, so it may not
matter, though.

> +
>  			/*
>  			 * Fallback to rev-list with oid and the rest of the
>  			 * object IDs provided by fn.
>  			 */
>  			goto no_promisor_pack_found;
> -promisor_pack_found:
> -			;
>  		} while ((oid = fn(cb_data)) != NULL);
> +
>  		if (opt->err_fd)
>  			close(opt->err_fd);
> -		return 0;
> +		return err;
>  	}
>  
>  no_promisor_pack_found:
