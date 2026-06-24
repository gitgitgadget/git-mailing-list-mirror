Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571371C84A6
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318481; cv=none; b=tpoG9AqjHmyFGY2yKrRBWAgjlOWNw/R1GwO3480Ayj/W27QEYqv5oFV5RK7NuySEWn7TTzA/HRQkY4BrbpLlRsMX2+k1vlVRMsS8bP/ljTLF/8RaHzHpQpKKrGvt4FR9IpQBs3idRmefMnZoMMVtJh5ZTxovrHwgak2f4Zg0WuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318481; c=relaxed/simple;
	bh=H94/5j0Rp1q5QkZWz6WFWo7c2v9QwDtB9s0skpGMGk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mz2fi4SRBvqSxtEzX2hkhsz4Ih8fBifSED0MBYwCGF3IwVo0ceeFiwnSvMQTJqdfHYqIWApP+Ayt5j4xQFpy5Ue3cjG/q694K3mEB6SNoqK5HCQYHdorTGn4wc8BIMQG1l6SEan+Yp8suYSg324QWfDS5y/BF5hewHLQK5bph34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H14G78iA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ar04XNNl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H14G78iA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ar04XNNl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8958F14001F0;
	Wed, 24 Jun 2026 12:27:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 12:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782318478; x=1782404878; bh=ZP+QAXOTTh
	F+u4nXsnnytyj0XQaq30hoO6XVvkdJ/jU=; b=H14G78iAEKS6AUkphtJT1jcUQP
	rH0+gHyLjwWUsv/N+McMf7i0J+S4/OMDyTeMaUPXFASSGyxlFvOTkqvAO/6F5BST
	Qt+5OSssMeQIL4FRP/jYnmF9dC1+kkp3kvFzA36kr/0WFsPjGBamKv6xgqpNtHrZ
	GnzNlhc7grGOsmPFwQtZr7s/81w+qsVF3XSn3dwEzEctQGGIWc32sOuaGil6Z4lJ
	YIZePTUkIoRzTy+CG3wOEy+dtS6p1/YRWIDqrBqPH+pilZ5gPd/32/05QZaMBYZ4
	RdR0wzoNPrgpqJN+iiGtqwKcLqTuxedj4qLDSk49H7xh3sh0vBnTal+6cD0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782318478; x=1782404878; bh=ZP+QAXOTThF+u4nXsnnytyj0XQaq30hoO6X
	VvkdJ/jU=; b=ar04XNNlisKpm4lOPqQJ+7fmt46DZIQW7/2dM2YG4nftsRgqQnN
	Du16PdIdNhQkm0P0IIfizUT8MW35airNic/oQn/qA9so1EAEeCfxfuXF4J2zcGCS
	OCJpbWjmFwod+f0KZt1iz8+juqqFgcK1Xx908eZBk2c5ikih4Ex9H+Q1Ooo6WBQT
	VmI8mw9NKkoiXkbXeVEN8R9sHOjZMxQ/oimF2nl4bANM6oPj81wcCX07hOf/RxG4
	+vD46RSc0gY+i/OnjD3c96wGcJ0MuuNiITSgQCmiPuWR9ZL+lSGspDI8mmxlnzHD
	8N9HUIIDCRYGk5JVvTFg8NmCYeumg20rI4Q==
X-ME-Sender: <xms:jgU8ardiIhFR0big9_op9lzIMS9ClcPQGmZKEMYW-w-WUJDNMe1Thg>
    <xme:jgU8aoMyN0Z7SwoUbhck8_X7k05gmsphlN8GyIgfXu1uY9G4khDvw5ZsciR1RR50X
    ffP3VWUurdjD13RF6s830Y1kun73biHrvdTgB7RH0s_ooT8LjXkYQ>
X-ME-Received: <xmr:jgU8aphBkBXuO8paX3sMEdXIokVqsm8qBaP2EmgsNUIQoeOzINDNIpQg0sEqfp9_h47ch5ET3CrowyKQSbAS49fdlgU1QTbp1p9bFW8>
X-ME-Proxy-Cause: dmFkZTFnZT6TfUfUvIWPUBBQmZghLDrecRuLgjHJl6gCenZWobECzG8rv4HDFAdtaUG73Q
    TV/mYn76DW4IGFqcJwzveRFgI+0l4ataNfTky6GZobO6qwVdtfkg8Iwukaa6/vLuX1yLTe
    jP/wGo295Rz2+XanTlcuR/Xcwla/Zs6+rDUkAhj6lzTxC46pNL9r0jMSs3IZZhHwTEm3iB
    uCBFM5zMioaxM/heOawcp/xPYNVgQ0wU1fBk7rbC+7zCcXu4IvTjy2nj2/18l3aWqhsCBL
    4AZI6u1OoI08wJBiqF2dUucXCumWOSqVez9XY9sv5o+Eol++z5Ch8MLFOa9o6PobqtNPlv
    vMrWxMog4lJ3biMazmIrFUKyo4cMl4FOgYsXjQQTOaFPbmpGX9kOP49/GpG77d+whGjyq7
    +2SVb4CzXrnjuOjyPglIkvo9VDZDlQ0TgcjKkd56uwGMFfnSi3T2Bn7yDqQH4A7qzy73D3
    M7jA2YQ9KLbVu9fOXc94PV+kVQqsimIPGDywDj5SbDSdh1fhviB5LGHZ0PD4osMgGasUOc
    9CQCk6TZbtqMjWLmrC8VrA+vnGQ+6DurGw+QeS1Fj4IeiwVNb4asKmPUX/42BA09mwJO8y
    Phqv0uwGCRLw8Qi0LaFDO5a20YrMRVZ1vwMTSBnUnvQ3Kxa7QL7MoLNiFDfA
X-ME-Proxy: <xmx:jgU8ar2LmupkKva4jOk14hRP5_W8TWljKxqgdIL5TGnwsyys4WQ_EA>
    <xmx:jgU8ajiD1iK4qr3NEXhA-vQdg0p7aZ8AS3D6h8Le10V9KF6O_GS2qQ>
    <xmx:jgU8ard8cGU4rWZtGTJ18KvMnHyyDijFOJHicn2r8TlLYu1xkXlgZQ>
    <xmx:jgU8ammXkHPa34J2Tu-iy7eVBEIuo63v-p4rbOr96dDrkbGecSkJSQ>
    <xmx:jgU8amck3SxwqQFZ-G8jxOrXXJkMf-XyxY9kmmNawteocmz5gW4bLEMM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 12:27:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/4] connected: search promisor objects generically
In-Reply-To: <20260624-pks-connected-generic-promisor-checks-v2-4-132d73ee47b9@pks.im>
	(Patrick Steinhardt's message of "Wed, 24 Jun 2026 12:37:06 +0200")
References: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
	<20260624-pks-connected-generic-promisor-checks-v2-4-132d73ee47b9@pks.im>
Date: Wed, 24 Jun 2026 09:27:56 -0700
Message-ID: <xmqqjyrnkinn.fsf@gitster.g>
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
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  connected.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/connected.c b/connected.c
> index d2b334173f..b557ff5db9 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -11,6 +11,13 @@
>  #include "packfile.h"
>  #include "promisor-remote.h"
>  
> +static int promised_object_cb(const struct object_id *oid UNUSED,
> +			      struct object_info *oi UNUSED,
> +			      void *payload UNUSED)
> +{
> +	return 1;
> +}
> +
>  /*
>   * For partial clones, we don't want to have to do a regular connectivity check
>   * because we have to enumerate and exclude all promisor objects (slow), and
> @@ -30,25 +37,28 @@ static int check_connected_promisor(oid_iterate_fn fn,
>  				    void *cb_data,
>  				    const struct object_id **oid)
>  {
> +	struct odb_for_each_object_options opts = {
> +		.flags = ODB_FOR_EACH_OBJECT_PROMISOR_ONLY,
> +		.prefix_hex_len = the_repository->hash_algo->hexsz,
> +	};
> +	int err;
> +
>  	odb_reprepare(the_repository->objects);
>  	do {
> -		struct packed_git *p;
> +		opts.prefix = *oid;
>  
> -		repo_for_each_pack(the_repository, p) {
> -			if (!p->pack_promisor)
> -				continue;
> -			if (find_pack_entry_one(*oid, p))
> -				goto promisor_pack_found;
> -		}
> +		err = odb_for_each_object_ext(the_repository->objects,
> +					      NULL, promised_object_cb,
> +					      NULL, &opts);

promised_object_cb() returns 1 without any computation since we are
only interested in learning ODB_FOR_EACH_OBJECT_PROMISOR_ONLY finds
any such object.

odb_for_each_object_ext() returns 0 (if it iterates all the sources
to the end), but if its call to odb_source_for_each_object() yields
non-zero value, the returned value comes back as "err" here,
terminating the for-each iteration immediately.

odb_source_for_each_object() is implemented differently per the
source backend, but taking an example of "packfile" backend,
packfile_loose_for_each_object() ends up calling cb (wrapped in
packfile_store_for_each_object_wrapper_data) via
for_each_object_in_pack(), which stops immediately when cb returns
non-zero and the value returned from there is the value given by cb,
i.e., 1.  So we will have err==1 when we find any object.

> +		if (err < 0)
> +			return err;

And err presumably is 1 in such a case, so this does not trigger.

>  		/*
>  		 * We have found an object that is not part of a promisor pack,
>  		 * and thus we cannot skip the full connectivity check.
>  		 */
> -		return 0;
> -
> -promisor_pack_found:
> -		;
> +		if (err > 0)
> +			return 0;

And this does.

I may be misreading the patch, but as we return 0 from here, do we
cause the caller to fall back to full connectivity check?  The
caller, check_connected(), sees a zero returned from here.

>  	} while ((*oid = fn(cb_data)) != NULL);
>  
>  	return 1;
