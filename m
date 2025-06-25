Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F593074AC
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873439; cv=none; b=JKP1zRnQ+uiRg1ZydstX9MAnWoDk2X03MdiDsEmjMW1Ecd9btlZMqen2fFW5zzmRrOkm9v7FSuQj9OYkgtFIFdAR44t6eDhkbCQ4uxHHZu9j3R6DB76cSNh+pKwepyWuPlRaZ7MDf1LdTA5iHvUVY7upPlAcvuhA2IYXtYQQzmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873439; c=relaxed/simple;
	bh=vdc6g2QwHqP440nr7I8XdlWp+1IN1wM8uikfVQ9znK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uf30nolE+7YHjA4khit4sK44yvnQXHEPsnv7KblxRC/KErQ8iWfQMooUGR0v+ag+bGFGq7iF1MxzEeDNgp1cLAsMddEZsgbyQykCmNLvs83QHgx5Z7ah1XfgZ3hiPK7jkpjYqPtHTxMNrRQMj5p9HtpobkhOeQGMLj2Q1ZY1KJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ShKUtnbD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H36hH9QL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ShKUtnbD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H36hH9QL"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 42D6EEC00E2;
	Wed, 25 Jun 2025 13:43:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 25 Jun 2025 13:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750873436; x=1750959836; bh=U3NVaEek4N
	hzBOWneg/0F5RYStRfNfvGBCJW7a/MRMk=; b=ShKUtnbDftNP8+kV5C6ziAF15L
	3P8tBgyOW+tlwL7xra26GaIdUF9Pyb3XoMsDA+nvTgvppMewOanye4LKDMzlSRGO
	kCzFCI0roQNKsXZHbkN8qOR94Ya1eCo/jaH2qkUJArorPvvUaNC/L9dUMPP5naNy
	Dh0XS+DWSctIHTLlZ6qQGn0FEZzOjruyxuZmReR0GYJyf/3BxnbwvRsjhdhQJ/PY
	BOvsemdbsSXD/4+BRdmILR8y4hUWZv1Xk5LDmvbQSVMKoYVLjFe0EzSYbRKFMldz
	whNVasSXouffuQgjTMY3DeXKaojtEhG2ORWej3xW7bMuFZJkdU0QHzlPlLhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750873436; x=1750959836; bh=U3NVaEek4NhzBOWneg/0F5RYStRfNfvGBCJ
	W7a/MRMk=; b=H36hH9QLnBYDVl9w7iaOOLUrdkKNqGcnC7KMAqTTADkGE4e3uGh
	iH9wDsUzN2eF+gKcCSZt8AT+fUGJmt9V+HVFWOqLhbgon/G9tNuqdCtpJaaBAe55
	/DefsvWbYPsnff4htB0my+MLmWt4YxkK0ZVtt/yxOuFonkcJWniup/JBKHlLQaRI
	8dXMzIKh62Qu9pE5ilRujCNcH1nIk1XC1XU4ankAc/PLGz1ddaPEm2VeL0Xw6otL
	/919ZeaEgbW6BUr3JrUODVjablN3qW9UzbWd2oPjLL9sQ9sW8fMeF1tYy5QUgqjV
	onSAelQpaib6bTy69XV9SatvqRp1090THPQ==
X-ME-Sender: <xms:XDVcaAaI5YarbforePCyEJShN3k4QHL2UNqsF7AX8yH9hdPjQUPGOw>
    <xme:XDVcaLZqbokpGs_WTgxv6RGRD7qBjtsDNtkbpjG4WAHJTlNFRJRHGExhL8QJvCPPW
    HO-sc7_HuEhkAlcxQ>
X-ME-Received: <xmr:XDVcaK9LC-Nv1wk3dg3ibSfk53380PFxoRv_vtQ-J1zmcp6v1zunRajxlZwV_LbIw-bFbCpToxGdK-5mSDiXgpPdszUci7z1gpnqr-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihlughhohhm
    vgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhj
    uhdrvgguuhdrtghnpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XDVcaKrfBZ7bYuqnDY6bYVMJSQmQRpzAEmkcAiff9UCztbx-E36yoA>
    <xmx:XDVcaLq7bmjESzidk5oM5BG6ljUtmlUnZiHfqa1Km8t8KR_BMIPUGw>
    <xmx:XDVcaISmLdAnJYV-RGyXNGRMnlbR2aKUwh_4CK26UJtypF9otXgmwg>
    <xmx:XDVcaLoPWBNWSocaWgJ4we1WOhOST07F8i2V6c0HHJxsftdM-Ox7Lg>
    <xmx:XDVcaAuixKS_UFn0e7_GwMqNFpftfyGJV6nTacaPa5BXT_NCkaY_-MQT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 13:43:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH 1/2] bloom: replace struct bloom_key * with struct
 bloom_keyvec
In-Reply-To: <20250625125541.3048632-2-502024330056@smail.nju.edu.cn> (Lidong
	Yan's message of "Wed, 25 Jun 2025 20:55:40 +0800")
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
	<20250625125541.3048632-2-502024330056@smail.nju.edu.cn>
Date: Wed, 25 Jun 2025 10:43:54 -0700
Message-ID: <xmqqtt43u36t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> +void bloom_keyvec_init(struct bloom_keyvec *v, size_t initial_size)
> +{
> +	ALLOC_ARRAY(v->keys, initial_size);
> +	v->nr = initial_size;
> +}

Hmph, does this ever grow once initialized?  When I outlined the
solution in the earlier discussion, I was wondering a structure that
looks more like

	struct bloom_keyvec {
		size_t count;
		struct bloom_key key[FLEX_ARRAY];
	};

Also when your primary use of an array is to use one element at a
time (as opposed to the entire array as a single "collection"), name
it singular, so that key[4] is more naturally understood as "4-th
key", not keys[4].

> +void bloom_keyvec_clear(struct bloom_keyvec *v)
> +{
> +	size_t i;
> +	if (!v->keys)
> +		return;
> +
> +	for (i = 0; i < v->nr; i++)
> +		clear_bloom_key(&v->keys[i]);

By doing

	for (size_t nr; nr < v->nr; nr++)

you can

 - lose the separate local variable definition at the beginning;
 - avoid confusing "i", which hints to be an "int", to be of type "size_t"
 - limit the scope of "nr" a bit tigher.

If you make keyvec an fixed flex-array, the below would become
unnecessary (and the check for NULL-ness of .keys[] array).

> +
> +	FREE_AND_NULL(v->keys);
> +	v->nr = 0;
> +}

> +struct bloom_key *bloom_keyvec_at(const struct bloom_keyvec *v, size_t i)
> +{

Ditto about abusing the name 'i'.

> +			return ret;
> +	}
> +
> +	return 1;
> +}
> \ No newline at end of file

Tell your editor to be more careful, perhaps?
