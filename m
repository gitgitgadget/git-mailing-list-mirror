Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F539DB12
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112636; cv=none; b=m/LuHl9EzVLo/JC4/IuVKEHlmbdd+WnVUyLcH100OO5rE7v9HMlzHxfJXczh7gYP+POEsFK70hc1nz0BR7LtbH5MimNVxBrI82bcBn/FTatIrHYRNQt8Fscl44F0BQmQI2F+tXZIAMDvm91Hq38WQD0OZkK06tvrEW4IOXvG1Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112636; c=relaxed/simple;
	bh=hWhgYRlkZY0inhDPflLR4eHx7b/0ZMr7FOYZGBaurwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SlVGJDxy43fAdsEaZpQJyAID//erztqfIVOt+zaM7dPiAyXGrgLgaAGWTw980yDXmEmvNuOP+IwxvIZUmsfYfIxXrbzOSEsAgLd/S38G8w2soo60ZYjX63NimkiSgWdByg13iGUvr/2hYNI6+mrwnm/BHQCJ9cGQzU+UEqeblcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Czv9lMKL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tnI4NIgN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Czv9lMKL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tnI4NIgN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 487EFEC080C;
	Thu, 22 Jan 2026 15:10:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 22 Jan 2026 15:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769112629; x=1769199029; bh=CHT0288toN
	+CChs1OO9JMmIJ8ZFRNnj5ex+Rfelk/k4=; b=Czv9lMKLtwR6cQkinB0Cls/EEE
	eSRq1WspVWtZz0ZIQDBpPWIyTpaEdG8qRb5Q0pmbQq5b2+d9HW8i6s3oYLL6jRyE
	3ZdWfSm97R2V4fyEG/6MvX/sLRvdJo+DJeUj+hPQTJPVX3KA9a54qwNIbOjU1IsN
	ZpQEZw2kZ8WPxKaZh4xm7SLIoYdup01y61xPH9hoscIk1iDjH0LEZ1yfa0HiTd/Q
	y6aouKzIUvV/RzoKjezazaVql+/IkZ/GvsTCj1bSeN8IWbEflLqhJvmuP/OcTkqe
	QCnnb10JMdwZ81CUqDyr+dzc7IcvuL8vsjROJaoK3hcbMVZoIp+cryIAhEaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769112629; x=1769199029; bh=CHT0288toN+CChs1OO9JMmIJ8ZFRNnj5ex+
	Rfelk/k4=; b=tnI4NIgNQV/fDhOmIAWeNRCGbd92VyORMnhDuu921NcKUtwn27r
	BLna1jOhOwk7WeVEOJ6/I5IWU21IuVBxUa8/h1sKtxQDA6WYn4OcqUIDcdZnwcsF
	Ug8lV1RJmbFxwt3liyaD6wzOzCpWCyJMHXL0Qheiq6lFOtjNsj/fXhOWMwWFbt6J
	sbc/HwKbn7kIDre2GrWW4mwTJ2nBzH+QpAZN7dKk0iGu49PXJDQBrBC+aFDAhWjf
	TPAv/CYrz2HNwBlhRvZlMRYMwjDh4SqDCbD63kr9K+4zgeOhujg4LS97LMkCeuCq
	rR+M7NZfQjNE/yp0+TctgnKlgz/PkEh9bRg==
X-ME-Sender: <xms:NYRyaaIqKvIC4LXzFgfDLoHYevUQ3nSwMRveUR6FmwGpjOQu3hiWAw>
    <xme:NYRyaV30Cr-Nn6Z47IZFrX2-HhFHiUCNOWuVEzq6QoJnJMUmMJBZKzMrOcNxgo7wX
    nrCNgtkVsag1XxE99uNINzJq4MxPEmtCwDyCQ1sN54wZ-HSuAdOMg>
X-ME-Received: <xmr:NYRyaUj0tGOJpa0OSW7Iz9DFNHm2FDwv3ydI6klne9qwL1QIVYjw_nWLMs4IVWasqvVgwSe3pPq6-a3kJe2tJ7fm0BcrfxtrACvxWm4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NYRyaWUi0o08ceREGXQ0ZcOuQIBriHyFish9uogIZZTVj6Wzv_IdQw>
    <xmx:NYRyaTUy8d7Xd_CGIFTmvoEkVjSoYGUpPgr1Bk33hwfNc5sIL4Ap_Q>
    <xmx:NYRyaWgd2m31cf-I5K3z2CvtqGlM5voyaWJ7hhiGh14WLsrDV5Uqsw>
    <xmx:NYRyaeZrMhaNLc4stnywqlEMkGxaVMW3-rvUtY4AYn2mX9Za0_yhWg>
    <xmx:NYRyaX60FHT2Q6Kuu3A-hk2oRopcJ0MvZwchjt_WvRHFWqfY7DoKgYue>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 15:10:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  newren@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v4 6/6] fetch: delay user information post committing of
 transaction
In-Reply-To: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-6-2ddba0832440@gmail.com>
	(Karthik Nayak's message of "Thu, 22 Jan 2026 13:05:00 +0100")
References: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
	<20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-6-2ddba0832440@gmail.com>
Date: Thu, 22 Jan 2026 12:10:27 -0800
Message-ID: <xmqqldhpmmrw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> +struct ref_update_display_info {
> +	bool failed;
> +	char success_code;
> +	char fail_code;
> +	const char *summary;
> +	const char *fail_detail;
> +	const char *success_detail;
> +	const char *ref;
> +	const char *remote;
> +	struct object_id old_oid;
> +	struct object_id new_oid;
> +};
> +
> +struct ref_update_display_info_array {
> +	struct ref_update_display_info *info;
> +	size_t alloc, nr;
> +};

OK.  The ref_update_display_info structure is full of pointers.
They are of "const char *" type, hinting that they are borrowed
pieces of memory, and there is nothing to clean inside, other than
the .info member itself?

> +static struct ref_update_display_info *ref_update_display_info_append(
> +					   struct ref_update_display_info_array *array,
> +					   char success_code,
> +					   char fail_code,
> +					   const char *summary,
> +					   const char *success_detail,
> +					   const char *fail_detail,
> +					   const char *ref,
> +					   const char *remote,
> +					   const struct object_id *old_oid,
> +					   const struct object_id *new_oid)
> +{

This helper that consumes the structure is used throughout the
patch, and relative to the previous round it got easier to read.

> +static void ref_update_display_info_free(struct ref_update_display_info *info)
> +{
> +	free((char *)info->summary);
> +	free((char *)info->success_detail);
> +	free((char *)info->fail_detail);
> +	free((char *)info->remote);
> +	free((char *)info->ref);
> +}

This answers "no" to my previous question.  These are not borrowed,
but are owned by this structure.

> @@ -1965,7 +2090,17 @@ static int do_fetch(struct transport *transport,
>  	 */
>  	if (retcode && !atomic_fetch && transaction)
>  		commit_ref_transaction(&transaction, false,
> -				       transport->remote->name, &err);
> +				       transport->remote->name,
> +				       &rejected_refs, &err);
> +
> +	for (size_t i = 0; i < display_array.nr; i++) {
> +		struct ref_update_display_info *info = &display_array.info[i];
> +
> +		if (!info->failed && strmap_contains(&rejected_refs, info->ref))
> +			ref_update_display_info_set_failed(info);
> +		ref_update_display_info_display(info, &display_state, summary_width);
> +		ref_update_display_info_free(info);
> +	}

And after a fetch finishes and we consume the display_info, we call
_free() to release the resource held there, plus ...

>  	if (retcode) {
>  		if (err.len) {
> @@ -1980,6 +2115,9 @@ static int do_fetch(struct transport *transport,
>  
>  	if (transaction)
>  		ref_transaction_free(transaction);
> +
> +	free(display_array.info);

... of course the array itself, which makes sense.
