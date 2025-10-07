Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00548182B4
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759870830; cv=none; b=mosxQ35phC+1a7wTfNgqSWez1a8qmT00j/RuJlegBVttYpVzyYNRDdHKT6VTtxdhk4PFxXo2qzRoHhEkJarnZE+CQkNWLEJ2PSbFQf/17ThUYbMQleNQhOKdir6IzNob0KGtBums21dXPcsKTTBZ6/NrdaTaJFbgPZpC3CLCp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759870830; c=relaxed/simple;
	bh=2tfoVbbK2SDeffjqj+QP5NWLf9s9J8cBDnj47+KTPjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A9dNxkMP2bYwdLQjAYWhP3EmHZrXkUo9J20VooQgIrnimfJrkQn/GDGOgi8mWJymB7EEPa8OQXPPaU0KFhYJ58qlJWY7gJ/74/3r3kpQh1WReU958NVBlgxy139NAFAOCynOuyzz7QJFOffePjtTe6Wpg9Mw+KHHkhBb0KX+mu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GUyF+kcd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fodtmz2/; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GUyF+kcd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fodtmz2/"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 34E0B1D000B7;
	Tue,  7 Oct 2025 17:00:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 07 Oct 2025 17:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759870827; x=1759957227; bh=Si74gThj+K
	UhZFvqmQZLykN33NgGKzDzFbymqBZZNCQ=; b=GUyF+kcdK/urCVlsOOAkAT8Cd9
	RfqN0CfEspwQA5TjMwcZkGEZoPIlE3Tkb9lczW5YlxWwVEVnc3ZWWZFbyuu1zkGo
	aLmxL3xWarSz//X6ZCVYd6ffVDr/lBiSmdxZUAz4fW2iGofmlYeSPiCtfXoq7Fwi
	Rf5d05fX44Hf1FUENpyhnVzxVH6W6Dk1SWUYM7tfel93OMyWfixUXCNWu5VCH5/v
	geAEgpzTvuz0gPOpR2xA5l8+XqWjT43JEbeG0VNrih0dTfrM5yr21d9t0uFn6tNd
	YJoScbAN85355fTNMvzcYqg1Ct6FcFP76uF7T/xnILSdhlW1yWB4aX97eCFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759870827; x=1759957227; bh=Si74gThj+KUhZFvqmQZLykN33NgGKzDzFby
	mqBZZNCQ=; b=Fodtmz2/diG9R0DgKoKtWxhyPcFLnywlIQXRMut+mdWK3+Ae/sC
	qJ9242MFA30JO3kZK2BmJS/LU3eX/VI2EaPiFfZHLoqh4ZQd00sk01YtO2qNVwQz
	6R04VTXZ+DYjZWcC3LNdDKsReaBfqkUTVYv5Hdi643Stq4pWBVfmUwmFGO3KWnfL
	ChUVC7i8UgxChhRs4wMrAJUSynYuP4BSarcP+jp2h42Qw+/SHOMzxyp0PBF1yjER
	BHAnnKfZ5AE3ozxT+9NQR6pN2zf9vpDNaTcdVTkhnojfy/nO/SN+OxKuCyKzlqbD
	9j5nibVPno82JrZAyC1PNEF/B6ZCqAzEfyw==
X-ME-Sender: <xms:an_laAfgX9_DWLfVH_imtPShXPNAX5VpeI04tJsF5j6vW9JgBskT8g>
    <xme:an_laJqkXomcMck2z2bX3evS2JN9QPqscnm7ConJgiJFLIs35luzKx5dKKWQCyOKE
    Zx77myb_8idM7UXGWK0_I3jmg2lJWbk19SaaX1Ct98NB2CEnY1H>
X-ME-Received: <xmr:an_laO55pAN1JVZjze97ULmdcHOexnhbhNzmVrfWXv7bRenCBR2DgQInTpfGB_ZuplbJwqDHgcmZMQISkISrMx_ZfOz7pkK0XwfR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:an_laPpBxgadsFWcaTA_ONV369LRbmZMhM-uuTDk0evgbCM1ndxqGg>
    <xmx:an_laAgvigpHdDcOXVpW-7aQG-0VpekDxUTaALmCd9slHzLI32Xr0w>
    <xmx:an_laJK3CPnhsvgPq-UBX8WefwkMRYzBxGmtiAwvTe_EgwOL8MbqKw>
    <xmx:an_laABfDiKK5A_m-M0VI4D9Btzu2mi9ELMBDhpwHIKgJ3qMX5ePMw>
    <xmx:a3_laJxnWihA6s0FpL-j9n__KtqaIRhK5_G8VSDzCzP8Mbt9daXSfFlZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 17:00:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/13] refs: improvements and fixes for peeling tags
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
	(Patrick Steinhardt's message of "Tue, 07 Oct 2025 12:58:37 +0200")
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
Date: Tue, 07 Oct 2025 14:00:24 -0700
Message-ID: <xmqqsefuig0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --cc builtin/repack.c
> index 873e21c35d,ad60c4290d..0000000000
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> diff --git a/repack-midx.c b/repack-midx.c
> index 6f6202c5bc..74bdfa3a6e 100644
> --- a/repack-midx.c
> +++ b/repack-midx.c
> @@ -16,25 +16,23 @@ struct midx_snapshot_ref_data {
>  	int preferred;
>  };
>  
> -static int midx_snapshot_ref_one(const char *refname UNUSED,
> -				 const char *referent UNUSED,
> -				 const struct object_id *oid,
> -				 int flag UNUSED, void *_data)
> +static int midx_snapshot_ref_one(const struct reference *ref, void *_data)
>  {
>  	struct midx_snapshot_ref_data *data = _data;
> +	const struct object_id *maybe_peeled = ref->oid;
>  	struct object_id peeled;
>  
> -	if (!peel_iterated_oid(data->repo, oid, &peeled))
> -		oid = &peeled;
> +	if (!reference_get_peeled_oid(data->repo, ref, &peeled))
> +		maybe_peeled = &peeled;
>  
> -	if (oidset_insert(&data->seen, oid))
> +	if (oidset_insert(&data->seen, maybe_peeled))
>  		return 0; /* already seen */
>  
> -	if (odb_read_object_info(data->repo->objects, oid, NULL) != OBJ_COMMIT)
> +	if (odb_read_object_info(data->repo->objects, maybe_peeled, NULL) != OBJ_COMMIT)
>  		return 0;
>  
>  	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
> -		oid_to_hex(oid));
> +		oid_to_hex(maybe_peeled));
>  
>  	return 0;
>  }

This seems to match the manual resolution I just made, except that I
line wrapped overly wide line ;-).  

Queued.
