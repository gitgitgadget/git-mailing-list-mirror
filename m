Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083A19D06A
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664852; cv=none; b=cLcSvDibi41XlHu1j2tzdXuoeo0EyZsf3avTN69LAt6H2sZaXjE/+FwSQfItu+7Pci/3RM8GjwgvTVz0MMELo1Q7UMPvxifFJlNeELRtvgLHpDyOBOKmjNKFhgeWAqRoyzjpN5gSG5AFBTQsQ9mQE7KFHg6cp2bAmMR6zJ+HaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664852; c=relaxed/simple;
	bh=rJH4vYC5vAnjcqL+HCnKIbzIZjzKCQaJ3EPgI4hupX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XIsUP5nMfO+OT8ioqfQNsyuuBZRMbL0ewocm3ubOcbQx6MX+5f9XmpmpdiWxtlJ8Hk3/UGpn3x9BUz0BhD8lmDblc4Xythq2Nv9x+PN2koXz3u3BnQxFwbiroHBwxr2hbrh/6Rmn3t7hVDXhfxVHFOssMdyNU+ZYwIgkpeDMXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zq26Jgu7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NXKBRn5W; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zq26Jgu7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NXKBRn5W"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C7DC1140317;
	Mon, 14 Apr 2025 17:07:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 17:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744664849; x=1744751249; bh=/kBot1nhRH
	6yd1NU7KoLCbZyfVIooQJEMCM0pOtSsCI=; b=Zq26Jgu7paC99va5axw8aV7Caa
	NgKwGKHeMuOdT8NgaXtapJryEFNTgayJlP6PQxgJ9mHupo1fzwUIMCTZlR/fVodj
	vS/DnwPdaf3Cch0GvFf3bBga3INvk1YQQnyIFYeREwQNk18a9OP09NHYcruH6gNz
	k6mPMZ2dJXGyY7/lFU84k8Bzoo9sUNBGv1/B2+c9jxPlrJCxN2oh9Vudn43hq4hh
	8ssoqm6sECunP8YKMw/BSbocFaRzbA/QnceBtDQGd6BpiJcQjCVRCOABhtt16YS5
	I9FHw8aMMKIOMefYwlaozs7XtDxc1sbJBROqNZHWyuNGeVwiiWQvjiEmpxFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744664849; x=1744751249; bh=/kBot1nhRH6yd1NU7KoLCbZyfVIooQJEMCM
	0pOtSsCI=; b=NXKBRn5WY6nuuYOGKuEI3o/DOqFiRqsnSOKkzg6Lvttq7DRUKA/
	J4Xm54ScnxyyNh/o0NbqS5sY80QaKRtyE+V5JomrnKBMsO2RxfAlZwvxzPiw1zN9
	Oq3XX2Mm20pmUfqKPABYtb7kGxlVIto/uSixNpPi9QcU4mRdfUmmhB5ldg29nO4c
	bvi+Q4ERpYxIGabNXghPDrrAXIksjAS1m1WiOYAvEXfd0n/IB/Xp2ZwtAcarIe7m
	uW4EDzxZKIZKb/BQ/G48upMT169iRCt/YdY4N/kvQ7q6+Qc53JgOJ5BQy1SR6EaV
	hJi8pUhbIV06MjWzKbPOeVtLvJOIn0oN2Uw==
X-ME-Sender: <xms:EXn9Z7ppAAfIWEw5bYYUhEqN9en_6yoDbSo7XiYtsudfVdEEuGXBEQ>
    <xme:EXn9Z1o8mGVU0A69UHHThOPvAkRIdHyVWmkvbLjVGk_Fix4qb7U9Qe29HN15Kx1Wi
    l5J7Yj7vqDvWV3zgw>
X-ME-Received: <xmr:EXn9Z4PmYq7X3M4pmaLjxgaFPsij10yivK2yc_WECovnz016vcr3rC4BbTACdb-idlItUDSOjRtZ1bGgOvMp_Kam1jZRW4SoOP5T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdduheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EXn9Z-5D3XrhwpLt99BEptvz1FQ3uTR29GVu-gzCnZLHJXrPuF_xpQ>
    <xmx:EXn9Z66E6Vo1O0RK2lCVvxqitQrYmSlQvRPFLINzWlY3a2QWXpV_Sg>
    <xmx:EXn9Z2hu8DcZEsyB6zMQ_mq2wgbBq5zeUosNRdcYQwJ_YVyZzOtglA>
    <xmx:EXn9Z84DDj8x69wG3f6RCJRP4xrHoM6yiDs3bd4Z_hYO0CHgEnYgvw>
    <xmx:EXn9Z1MRktwP8WvV3uCXeL2dPv2yYW1EQpjiHlgRKmPurupuTwNw8yw6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 17:07:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 2/8] object-store-ll.h: add note about designated
 initializers
In-Reply-To: <920c91eb1e5a1b6d5faa54240dd9c85f72968edc.1744661167.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 14 Apr 2025 16:06:14 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1744661167.git.me@ttaylorr.com>
	<920c91eb1e5a1b6d5faa54240dd9c85f72968edc.1744661167.git.me@ttaylorr.com>
Date: Mon, 14 Apr 2025 14:07:27 -0700
Message-ID: <xmqqsemapi40.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> @@ -337,6 +337,14 @@ struct object_info {
>  /*
>   * Initializer for a "struct object_info" that wants no items. You may
>   * also memset() the memory to all-zeroes.
> + *
> + * NOTE: callers expect the initial value of an object_info struct to
> + * be zero'd out. Designated initializers like
> + *
> + *     struct object_info oi = { .sizep = &sz };
> + *
> + * depend on this behavior, so consider strongly before adding new
> + * fields that have a non-zero default value.
>   */
>  #define OBJECT_INFO_INIT { 0 }

Hmph, after thinking hard enough, if a developer cannot come up with
a way to avoid non-zero default value, the callers could just work
if they instead did

	struct object_info oi = OBJECT_INFO_INIT;
        oi.sizep = &sz;

and the member of non-zero default value can be delat with by
updating the default initializer, perhaps like

	#define OBJECT_INFO_INIT { .enabled = 1 }

So I am not sure how the advice in the new comment really helps the
intended audiences.  Shouldn't the advice be more like

    NOTE: when a structure foo has FOO_INIT macro to initialize,
    *never* use your own initialization like so:

	struct foo foo_instance = { .member_i_care_about = 13 };

    Instead, use the _INIT macro and then assign to the member you
    care about, like so:

	struct foo foo_instance = FOO_INIT;
	foo_instance.member_i_care_about = 13;

    This is because there may be members of "struct foo" whose
    default value is not zero, or there will later be added such
    members to the structure.

perhaps?

I can buy a counter-proposal that does not forbid a custom
designated initializers that depends on "all zero" default IF it
gives a piece of advice to the readers that is more usable than
"consider strongly before adding", as "consider strongly before
adding" there smells like just an euphemism for "never add", though.

Thanks.




