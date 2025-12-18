Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1728371
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045365; cv=none; b=U/I8J4ykFZ8Uq9aM51kpXyYzqShVKXx5gh3T/ERsMvPBngDyGXIeLKgjlTxFzpWplbxZpA4dYVcI3d6+a4UWhHgxWZrUh/y1JCvmaZFYKOqaPPFnZDqI+5IWcXAIx8lmuw6oSf2FAgou/LwFA3t5IaprK58nBcMfrlCjq8ZhXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045365; c=relaxed/simple;
	bh=GGd+HV60ZEahXplX2cBOKP7aoiD/53gn2XBbxT0yLWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OnSs44OFga03muHdCDbUhOwD+5mNmIB14o1ZTSwxmjdN9O1Z09i908DaYA8yzTVLWZjvzi38qMqtnq8VFURX2Dw9P06IegAdRc+8QqKywy2rNuViTlkHRwrUAGenAn5gxBCCPEV/5o1N15ksm9JVW9DM+k4AFKJCy7KIQxqnq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YfAhBfRA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pqal+yYQ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YfAhBfRA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pqal+yYQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0392F140024A;
	Thu, 18 Dec 2025 03:09:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 18 Dec 2025 03:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766045362; x=1766131762; bh=wsg2Vs/3lV
	b39mBxsqau9xaiK4Y209tRpuUml7u4aog=; b=YfAhBfRA13LE+IB/e0I+RTfMKy
	3WpaO4y9vCnA3I3zAzOygphAzcyIh+eU+pfkYtmXnM28uaIliJR9TPWpGOpCPzKQ
	47nEc3DPkz7cQAaex1wSx1Uial2FcpZwVL6tomaBufiwMiEaS1G9/XHuI0POB/6u
	jIJXD5u2NtIfFt9Tek78GRt3AtcafzNkhtAupPuM7BynctgKfNJvWhRN7BL58rc/
	U1DCEulNxC1YcX+zAt2qiMEjwNrRZ4Q5H59or2CwZRmSYE31c/NGqSLLP46Gbdpr
	1A2Twu+Ju/cXIFJ9TYKBPkW80Ffq8lXg3Po4NgDToo8/iM4bGt1CZZAw5mrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766045362; x=1766131762; bh=wsg2Vs/3lVb39mBxsqau9xaiK4Y209tRpuU
	ml7u4aog=; b=pqal+yYQUHZQy9811tDObRmyCgFtg/eAEZtPqIsUKrr7pA8Md/g
	OTLE18PZG9uKTy9xRQ8siPWeXrltGuo6ye7+ySnqxgUVneDAaKuM1SPoDtdOMZef
	HVAhON+qqa8hn2sjwIqiAX1EeylhhA2G+42TTk45YXRODpjkQmiz6j/l54edDTR4
	FCaHqlZNXPAbdQK2Pw822Yoos7mG1JOJlpJ6Zcop+txNDHm3s0bqVtS1OXliMFmc
	L9LPUOGXC+lXjP5pY0/B5EIh+KFliSq5GrdopbE3uFPEhfCk/1S1GRiSxh9JSdQ4
	OdlS3MPTtko8+MffX8nDQHbBwaOwShDjaAg==
X-ME-Sender: <xms:srZDaU8bLV4m48DTPLrn1OXgMYkvi0WKkr2Okht6BiPwwUfNfpfqAA>
    <xme:srZDaTtbwLFtFF_id8cXJDexMs0DOR7c7WIyV1hfSwJK756Q-iG-uoZhdCwfH5XQA
    CPPi8xnfwG0B-ZY5L34YOm6hNNV0-wC1WoDC7a81Q5fybXDQKnscA>
X-ME-Received: <xmr:srZDafDnKzNuyukf_4gpZ3--bHv1g5m_YZQzqb2mPpbfrvrmApY1g1SU22D7dy-2CJshsBEp7RdJJkMQF0S577H0CYpqOCjg2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeduffeihfdvfeevfefhieegtefgjefghfdutefhheduieefvefgiedukefhjefh
    vdenucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:srZDaTVvcwYhKOorr17NMhUNUWWx0IDFb_G6sz36KeSDUiPPT3MJmw>
    <xmx:srZDaVAtLZ39HmqPS7GbVRxRi18C-CCa5NVAToeZ3JOVz6aUSNXJBw>
    <xmx:srZDae94SPeLY23sP1V5r2-Aq9crOm2z8lrwYu_vUbXifMj77se-EQ>
    <xmx:srZDaUFLway81bAGdXOIldIPfXgm7TA1tMGbWjmFyv3-K4y5Dogl5A>
    <xmx:srZDackcgg5b3VvrxUZYt9c30vJAlXp_NdxoGi_vvJPd6rfPXR7F1kFS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 03:09:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH 0/8] Improvements for reading object info
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
	(Patrick Steinhardt's message of "Thu, 18 Dec 2025 07:28:10 +0100")
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
Date: Thu, 18 Dec 2025 17:09:21 +0900
Message-ID: <xmqq8qf0xlce.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This series has a conflict with ps/packfile-store-in-odb-source. I
> decided to not make this a dependency though because those two topics
> are independent from one another, and I expect that this series here
> will be merged down faster than the conflicting one. Furthermore, the
> conflict itself is quite minor:
>
> diff --cc packfile.c
> index 8daa5a5ee7,ce6716fbea..0000000000
> --- a/packfile.c
> +++ b/packfile.c
> @@@ -2157,10 -2132,11 +2151,10 @@@ int packfile_store_read_object_info(str
>   				    struct object_info *oi,
>   				    unsigned flags UNUSED)
>   {
>  -	static struct object_info blank_oi = OBJECT_INFO_INIT;
>   	struct pack_entry e;
>  -	int rtype;
>  +	int ret;
>   
> - 	if (!find_pack_entry(store->odb->repo, oid, &e))
> + 	if (!find_pack_entry(store, oid, &e))
>   		return 1;
>   
>   	/*
> @@@ -2549,9 -2555,8 +2571,9 @@@ int packfile_store_read_object_stream(s
>   	oi.sizep = &size;
>   
>   	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
>  -	    oi.u.packed.is_delta ||
>  +	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
>  +	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
> - 	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
> + 	    repo_settings_get_big_file_threshold(store->source->odb->repo) >= size)
>   		return -1;
>   
>   	in_pack_type = unpack_object_header(oi.u.packed.pack,
>
> I'd thus propose to merge this series via an evil merge, but if this
> proves to be burdensome I'm happy to defer it to a later point. Just let
> me know and I'll adapt accordingly, thanks!

Indeed the conflicts above are miniscule that it does not even need
any evil merge.  The surviving lines are all from either ours or
theirs, that changes are close enough to be shown in --cc.

But let me first concentrate more on fixing performance regression
that already made down to 'master'.  It is a shame that nobody
caught it while it was cooking in 'next'.

Thanks.
