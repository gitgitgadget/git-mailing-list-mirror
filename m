Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD125D208
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188027; cv=none; b=u6nGWHZCSAkJ21v4Mus0IaI2+6yopNyQo4fxqzHWd8u87CVidszmNWkM5LpPsArH5j+FygpUMkDoShBXZF5rXC97fZg+C/jKK1AYk0d9+Advpk0BhUW29k+fpPaSE0fs6TpvxsnfNcDTMtxTFUddfX2qfixDWL6v2PTgv1AXAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188027; c=relaxed/simple;
	bh=7rrNCGYtOBdxP8Y3RlT3mPBlEGE4h+Ext2zqXeDpWsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IcvgI7QtAaAiIq1MX8RIpcoiOi+R9YbUkhhWvohkbgd9bB7ig/U1mHF2UNJ9tHTpPu4UmyFqHSR59m1ILPbyAcsxoYC6xaNhP2+oTFb/8UjL+LcZoB+SE+Pz/BMCXXwzc/S67wz2r0LbVrZ1DEz/bwcVSRb5Vm6OjEkHAPw2mng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OTt7r2y+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SneWIpaC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OTt7r2y+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SneWIpaC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 890B57A0026;
	Fri, 23 Jan 2026 12:07:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 23 Jan 2026 12:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769188025; x=1769274425; bh=Oa7lAuNpRE
	Cqcv2v17sxTe0muXpmz6vjj9737DZF4HE=; b=OTt7r2y+4/ilOlww9KyX3Sc1OH
	nE0mOzxcBHXDX6ZSIsmVh6p4Ko/PylOd9ZpNSoqo+8qqJXlzhPOjIlpSE7RMGE7V
	zNqCUrdHHBUaNfduTXQL7yAH1kV1nTwh3mSoEuMuVtUqukqf72U9Yur6XcUk2v/5
	cqZDh8psscZgyL3kjiVpK5qD9qTmsHZKmolNYBV29vU2nIWjjSEYW56YumcEuSdb
	dRMRLisnFTIkq2bjOL4/9uV0OLRr7jNW1e3hcYaPOzTpvD0UWptXrIHuxHokAm/T
	IxTOUXFNcLMZJB8oGO3Qonth0zpktAlR2GoJ07ioOrrhcu8IUVB5KOYBv4xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769188025; x=1769274425; bh=Oa7lAuNpRECqcv2v17sxTe0muXpmz6vjj97
	37DZF4HE=; b=SneWIpaCH9iZEBKKQIRFntieTTNykhRt0ppWNEA9cJFTkV9e9oF
	Dd2vjtuAj4P1SZ/AZ+XmVHyXLTMBITjE8L3do7K6tY2yCQaRjIVW3EFkUPVm16wl
	kOduVn12bczBwn9tRQ3wm2+tEHFBwhXTMP/VKr2VcBv46SiS7/8f/pN+VFQETmR+
	sKr3tDueT2BoOMmvTzRbfbgd6Z5+TicGkhImaQPjdpNV5nMKgU3AYp6JrLwL9tWL
	DNd6Xkg8Ye3zUM5W5YJEKhobnRiLOH+kaw5VL7LCoroy12UV0LKNQk+FlA0oJtvl
	HU4jf4cQESVM8+ku4cnco+cJPqCUh/hX+SA==
X-ME-Sender: <xms:uapzaYCjHjnoLZl4W8fMizkM_0E9OCSBpm_kEZPuL8BWSiG7SEKFgA>
    <xme:uapzaRaEHa4j0jCbuXdc3bH1UXOymKDlQX5nOn8nXKxqP31dJCMPD84t3kfWALbfI
    vJOjE0jhEKHjNiPjRbdenxB6qALT6jjNyYqJirstvJbKCk_c_kSMA>
X-ME-Received: <xmr:uapzaT6UlyL6wbiIrQ_km1CiuSCRktkhMGTzEUtjBcnaZRE4tfX2qxO8kA85Rm4WyFcwNkyv08kx4YZnEHVShfFBEQAKCZ-WBIUNVWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeliedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uapzaab8gtwxn62MY8bDOPB8bA_uafmgfXiS9Ukx6NtDGz4k7wnLtw>
    <xmx:uapzaahz4KSv-OibPqemUY4jLhWV_anEl32cDBFFYYl4ksBNR46_Xw>
    <xmx:uapzaT-IVi6JrU2EDAYX7E4OBxCzyzKeuelQ7PIPeGP9E1lHeWAklg>
    <xmx:uapzadrkjQtguIIdUVSayG-4SfxTXdGXwKILTd5EMhcBSwsB9_-08A>
    <xmx:uapzaUnVxYu-wUdBRDDkRXuj9gfll0S50orY2n2FQCb182tiMVBhhrPo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 12:07:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 3/4] last-modified: remove double error message
In-Reply-To: <20260123-toon-last-modified-tree-v4-3-86bf97bad4e2@iotcl.com>
	(Toon Claes's message of "Fri, 23 Jan 2026 15:33:03 +0100")
References: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
	<20260123-toon-last-modified-tree-v4-3-86bf97bad4e2@iotcl.com>
Date: Fri, 23 Jan 2026 09:07:03 -0800
Message-ID: <xmqqh5sci7go.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> When the user passes two revisions, they get the following output:
>
>     $ git last-modified HEAD HEAD~
>     error: last-modified can only operate on one revision at a time
>     error: unable to setup last-modified
>
> The error message about "unable to setup" is not very informative,
> remove it.

We can see that an error message is always given when
populate_paths_from_revs() returns negative, so this change is safe
(i.e., if there is a code path in the function that returns negative
without giving any message, this change will lead to a silent
failure in such a code path).  Looking good.

Thanks.

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  builtin/last-modified.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 06e3f79aec..0df85be318 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -495,7 +495,7 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
>  	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
>  
>  	if (populate_paths_from_revs(lm) < 0)
> -		return error(_("unable to setup last-modified"));
> +		return -1;
>  
>  	CALLOC_ARRAY(lm->all_paths, hashmap_get_size(&lm->paths));
>  	lm->all_paths_nr = 0;
