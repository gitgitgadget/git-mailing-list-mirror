Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF0211477
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527206; cv=none; b=dz2KMmc9wSWbxOjnku7p7uhWpf0uIzRVvqgdGVciSu+ElduDqXhza8fSYUzySCb4RlZrkLb16Vgc3nkwWRQV6hjJ81FpnIn4LFqS7wCq42qzMZFG6wUy+F4NHc+d0S+qvsCsEDsIJXs2ZKVpcthi5y/WdhvtmNxPqFyY2iswOxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527206; c=relaxed/simple;
	bh=kkqt185Hae8hvrwXNVGYj59sChwq+KYi4rcP/0rhCKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t4VQEMtZbMN+fQXbkEAES+iTkKZ/MubOSBfvGDep+2Kt5Q5pKozpl6T2POiXqHLJ/VB9UzmE1yq6R8NHUuQz7ibdqAuN215YXh3ivbaQsmYr32mHZuCcUPSjb2i2z24z51bFJTxWe7MI7XNwAPcXa8rNX4vPoKD72LxMR5BmJJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ViYbmsi/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ixe/OVrV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ViYbmsi/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ixe/OVrV"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C534E254018E;
	Fri, 10 Jan 2025 11:40:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 10 Jan 2025 11:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736527203; x=1736613603; bh=Fza6MLE6mo
	X6c70N6ZC431/Tnga416iWYH952GCEVsg=; b=ViYbmsi/L3dm/6GG4A74Bg2zKJ
	MtGinbOmNQxCRzZZ0v1uFj0SI4JyoZrpKWWTeZrda9gLf5/I1JyGE+vUTM/gsulh
	1j7opGYGqk5GQjgZd8jMnlKHalTfPpFo4gJfxHUvOEmKDeYw2rV+WmJhrTAHp+Wc
	JUIfe9tGYFA1CMWt5oMSR8Dl0lIBuy5S0qSvAUjlZZqO4N4r4vfpO9F/KW/taN0f
	3gN6HrfBosdp68MnUUp4KHCH5y11jeAMj51NGrfCg5tRZ7l1TfyVEzhBcHtweJxn
	jTdfnX0DQm3o6EqJbrWx5hvZxWqT3lpFKjZrgKGcuOK9X84gk68mq4b7VpPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736527203; x=1736613603; bh=Fza6MLE6moX6c70N6ZC431/Tnga416iWYH9
	52GCEVsg=; b=Ixe/OVrVfUiL1cgQfznudjZn0ayqsFPlDTSfijfz6jFe0OEv4o+
	3RehBtvBhow4SyRv3GktNzjNCsX435lEVOFpblptt3pD/tRA5yghpgiPIqRqAI3e
	xINmUslwy9PW9ve/twpK7DYIONAwZWNEOvMQ1oq06Qugj4ZBD+6HEGcV1PlFqjFF
	akaJZHN+uH0JQrzGQmxpfdlAP6zuuM9jTSXTaDWtesqts959Lz/1lBzHwEZtjmZX
	UbRhTB2h18gXAbvR3aQFaSnyP4pZ/OUxPuiQqwxqWjkU2KehI16prY09f0znhFd9
	LMg74N8ftXxvLxo4QeQ5aZWqNd7T1xzsazg==
X-ME-Sender: <xms:Y02BZ_GiuVGRUydTjosa8Nt7j_swU1elGRuguoWGS_0DThAXEtptOw>
    <xme:Y02BZ8UCkRC-X69fnH63cXLIk7fpSt-uCJucRPWhdIFn9QpRFgWZ8DJGr6qh9duNX
    isLajNz_WUXESPUaw>
X-ME-Received: <xmr:Y02BZxKEN7Fedc_I55JRdYFqOJwe3WjQt5j-SvhDy5PeeptBx5rcYYBFchXZ23yjGnKVKqWAqKS6cudf8nUe-P7d_5mISyQaJGG5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepfihinhhksehsrghvihhllhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:Y02BZ9HTxvbeYToyfyNXh57mh3OQuzcV5mX3uq9pJ1Bt4yKLwQZ54Q>
    <xmx:Y02BZ1W65XP5L9QsfFaR2X1ngPI6eaGNPlYrtMwx2ZQ5u10tY5E1tA>
    <xmx:Y02BZ4NQe7uxKnNwG6PLp61doDyHBM7BQKr3OndYbQQUzuGyDa2o6A>
    <xmx:Y02BZ02LOOOaPL_Nyk-GMlOHH7tB64eu_msjDz6q3VF5JrlhKvu-Ig>
    <xmx:Y02BZ7xW4bKbC88H17ySXgfQEuyfeZsXZQqwS-7OC-6bdu-JPZHGfcIU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 11:40:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>,  Wink Saville <wink@saville.com>
Subject: Re: [PATCH 06/14] run_diff_files(): de-mystify the size of
 combine_diff_path struct
In-Reply-To: <20250109084421.GF2748836@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jan 2025 03:44:21 -0500")
References: <20250109082723.GA2748497@coredump.intra.peff.net>
	<20250109084421.GF2748836@coredump.intra.peff.net>
Date: Fri, 10 Jan 2025 08:40:00 -0800
Message-ID: <xmqqplku8vxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That 4 comes from the earliest code in ea726d02e9 (diff-files: -c and
> --cc options., 2006-01-28).

Thanks.  I have no idea where that hardcoded constant 4 came from,
but I think you are right that 2 would have been the correct number
ea726d02e9 shoudl have used there.

> +			/*
> +			 * Allocate space for two parents, which will come from
> +			 * index stages #2 and #3, if present. Below we'll fill
> +			 * these from (stage - 2).
> +			 */
>  			dpath = combine_diff_path_new(ce->name, ce_namelen(ce),
> -						      wt_mode, null_oid(), 5);
> +						      wt_mode, null_oid(), 2);
>  
>  			while (i < entries) {
>  				struct cache_entry *nce = istate->cache[i];

Perfect.
