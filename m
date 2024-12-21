Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AF170A37
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734805848; cv=none; b=W7jkxcWCZihf2+AXCAmyR5pp/mgXPSmIUN18IaE+b5UPg+FkCjp4inEQoWtx811YBxM+iJ9MxQzwHy/cadOtamun9KFzhlNKMXCSI46AzJr9RQuS6ozy2k7dpMz0TVWX9GbpaNgFQQkqbfUZxQ/zSSfILaN6vqlqVdlMcgRNRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734805848; c=relaxed/simple;
	bh=uO4z068KnzUcu0VnPJDXSKDKLngsfgXeYsLErXyO2v0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDTQlSGqyQiMXp+HcErunO4pfFfneEqYQHOTO76Uq33ya8UttGjQ4aBsyZVEbl/oQj+fIvOwwkBKhX3plBgkItCqoWCn1CheHw/9CFLbPiqtYlfrH+Ey9lBes5EFE5NZsFye6XjtZk+mA42xRPJ7Vh6STAdudTosapS/NwwYfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DOsv2pSY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NotUYWjg; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DOsv2pSY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NotUYWjg"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E537425400EC;
	Sat, 21 Dec 2024 13:30:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 21 Dec 2024 13:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734805844; x=1734892244; bh=Xi62mKhirk
	Z/XnHAnPukh/cNBtWD1KBT2ZuxUESu0ug=; b=DOsv2pSYR8wWRkjmpT8OUolTeR
	0VK9/C1U4IMzSHcc8q9PtTbRiiDwUzqDD6GXMP7QAN2oHw5Ax0Ma805onHpK0m5e
	E7e+IX2Qga605yrwbuM7D/NCIc0Hxtbq6ZCcJZg4SEeVPs1QrbM+kbQzBrKAJ+kv
	e5AHmWllUIApHGK4kfYh+atg7jSllRKlJjIqBUlCwrg5vsox6BJnFlFSRea9OtP8
	kh1A80jBLc8P1+Xe89gTcCV9ohqLGjSn4x6PrqVH7Fe1n6bVD5RpfIwimfEVW0NG
	zzoquPLywN7DM1poUxVlsSuxOcmwW3moTGTbVhlWLAbD398pgcYgwdjNA0oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734805844; x=1734892244; bh=Xi62mKhirkZ/XnHAnPukh/cNBtWD1KBT2Zu
	xUESu0ug=; b=NotUYWjgGVffU/E0uNO5fDeQcxfrDYe1dVk5FjgognlxQXxjpQe
	TOzci1sk+c4o/oa3OREi8dvkp5VllM1nO17i/kVbFu0fKxAfx6cb6EYtEP5Un8VO
	WvPOk1mGg2mX1bsefOiuPNY/12udcWW4HgU+PsRjkRJafPjbjAhsWaRiMyt/hhCE
	LMRNzIjNz/Za54Y/Nq7dQ8WnWlpqOUhrsI1DGlIhZsoHukNo0LUUdmQTA4NZKLH5
	uvMt0w7X3WUeMvmkKcqtcSot6s3pAg8vbDz1Z/B0pWFw9adw2WrJ+tO41Uw1KXte
	r3D+f+OnrTxwFV40ATKSEx1PyrQfoHUrtoA==
X-ME-Sender: <xms:VAlnZ-3RR_ctjvY1aQPGe_jqw3Zu_86PJNVK1MciPdBMInq2ygt35g>
    <xme:VAlnZxFsoSRFU_QUIIIbp-sB6pkNqgfPOWLwuo0CiURgKorV2zCreV0GCbS0EWwRE
    qXBW81B4J5wFDKmig>
X-ME-Received: <xmr:VAlnZ26h3vQ6V06aE-LhbVOqodc9z5VvXM43UWDIqkqL_ZIo-erOEMVIMpgUdH9f_mcHSdSnxgnVyKJVRULd_lBQLJ1uiOERxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrse
    hnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrnhgurg
    hllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VAlnZ_37HsKmNZys_Re6baTVxc8aD0e_UIyCFHZzKgi5gGDYQ-b00g>
    <xmx:VAlnZxFdFm2iErqf6PDETqy5378PkcK0zAeDHmAgPxzsxlAXE3mZAA>
    <xmx:VAlnZ4-CtZSgh-qOj6-gA_ebenBj_8HfYogCJHFm2sG7yl_gCsbKJA>
    <xmx:VAlnZ2miBjVVElysu1Oh3k41yhjrmMUv9Cn1iMpQ4JeJ_zO8q0zA7w>
    <xmx:VAlnZ6M8m8Ui0cg7Rstx1926M-tbsV9TNmm_Z_5zCxOQGtvfof1vBAld>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 13:30:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Patrick Steinhardt'" <ps@pks.im>,  <git@vger.kernel.org>,  "'Randall
 S. Becker'" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 3/4] reftable/stack: fix zero-sized allocation when
 there are no readers
In-Reply-To: <01b201db53d3$0b5953d0$220bfb70$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Sat, 21 Dec 2024 13:06:17
	-0500")
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
	<20241221-b4-pks-reftable-oom-fix-without-readers-v1-3-12db83a3267c@pks.im>
	<xmqq34ihc4zt.fsf@gitster.g> <xmqqmsgoc42a.fsf@gitster.g>
	<01b201db53d3$0b5953d0$220bfb70$@nexbridge.com>
Date: Sat, 21 Dec 2024 10:30:41 -0800
Message-ID: <xmqqikrcc2i6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

>>Applying these on the author-supplied base (ff795a5c5e) yields the same
> tree as
>>the result of merging my manual application of these four patches to
> ps/reftable-
>>alloc-failures into the same base.
>
> Ready to test this. Please let me know when and I will report results.

If you want to start sooner

    $ git checkout -b test ff795a5c5ed2e2d07c688c217a615d89e3f5733b
    $ git am ... these four patches ...

should give you the fix without anything else mixed in.  I'll push
out the usual four branches after integration testing, but it will
be queued in 'seen' (just above the point that corresponds to
'next') first, before merging it to 'next' (and then down to
'master' before -rc1).

Thanks.
