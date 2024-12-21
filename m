Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3752F5A
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734803499; cv=none; b=eTarSNG6Xffr/R5tlM8Ev8aSBA+5wlrXnabzz0zoZ9Vn8WCbXM3BCpwgDSUuZb0pOZpbfn9J5NyiwT17HSeHzTNCiB7pB7v1dOP6FL3Y6ZyAML7Tw/Sf42W5Ave9M/htbVUzjnORcWZY7QNC5qNHilOGmuxEWblDtVzaW5XpvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734803499; c=relaxed/simple;
	bh=5sL/ndo4Rh9tejnz4y950M5XGnAqR+9bu1dgz9+rsY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e5srfShN81LZUroHwLXWV6YV5MpjfxgOuBrd0tjObo9DLSWdrnyfr0FqgkqKxeFoGvk1Mwf2GCe03OtzxrCywaBLf+SqEyDW2a0qcyLTCCNDIiw3sDoo/PAPSY5ivlm1LRC7TMRUUNswc1zJxFbczAWDMSDUfgMsI9sMzRN41rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E1u2i3bz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v7FASDJl; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E1u2i3bz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v7FASDJl"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E82EE138015F;
	Sat, 21 Dec 2024 12:51:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sat, 21 Dec 2024 12:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734803496; x=1734889896; bh=sl4ouCD1Ed
	OXXoMNlfa4TpATcYs1O75xSUHzTDFYZNE=; b=E1u2i3bzo8z5FpfyxZQb8knGYH
	GmbM9sKw7/vNS3QtJYGPoV527NzIL34uUNvlGEa3C6/jLZ1uOrlT+UC65Wvo69V2
	UK4NpZ6aV3E9bvt2ODHVRxgbtl3misK23N86CPtCMQJtJSwZB/zw0gf8PL7Q5JXY
	dDJ5SPl3Z7S4pG6D8YB3gJpB7t001QylyAFbhvoYtVvAr8gIGT5iv9ABSkDUFHDI
	lrBYj0/HfpxWKyFz7uj4pE6TWd3G+0i9Dn8fcBYoECAZoyqM4muPrXK+P2RL4dPX
	yr1sVLUbjO0YORB0nY5QZMg0PRpEm1RGsJnn0T7y8sNxSjaw1wFNv7m/rNzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734803496; x=1734889896; bh=sl4ouCD1EdOXXoMNlfa4TpATcYs1O75xSUH
	zTDFYZNE=; b=v7FASDJlX15vUqLfn6XuSmEgniH8cS+oX7hOvmVjR3f2zNplJ5x
	EWy29DQfY1JjPSL8yZJl8Wk+d/zJALp/l7JD9ReQ/Fo8y9TJAejQ8qU38mpdFSV3
	PYm7if9AKDBjrjWPLuGOSblwuAIFt1qkIf5EhFzzqTBE2++27NYyQvYlsMLOHdwT
	ToAiq70P0bVoSz2mzs2bLG9ECqnjjxfU14pNeA51tidJmeYGDW50vKODNejNf+iR
	dDUe3d9V8mRGc3vOxkv/VK/JDtmT48k8Pra7s9C+Tcl80YZ/rt46ZFSdhni32QBo
	N/Souk5qIdZbE4rSWRI5iLdlNIbc8rbX9kA==
X-ME-Sender: <xms:KABnZ2lFeAwGAj2z5MyGFcjEnOtmwTZQbObVTiMo8WHiMHPUl3GASQ>
    <xme:KABnZ93_U7BEVSy64n3qWorJesa3hlakI-r8dA_QJxzXoplKGz47_gS3RfyoxTo-1
    Id_zFESM3GoSbbt2w>
X-ME-Received: <xmr:KABnZ0rXwAgevpdNRT97sMt2XfQT9SKbx7geZ1Yqeak-0I_nK-8gz-Z2NFG5Wjekc54iQaMCOW5q9zj-oioQ4ijyn-EoS9iEZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KABnZ6mSo-QWRtoaszaRU4AktjPbGTU4u7a1opDXG45Fw3kGjfEMzA>
    <xmx:KABnZ00MeU0-c5I0gCizFfXZgstTolZ0MGU6UMI8f8zbZ2-S1HtFtg>
    <xmx:KABnZxsHelsoGxeN-RKjJEJziNx9BI7x6wyQnsIry_zyBzIGHdB5ag>
    <xmx:KABnZwXa2P5rFwUq_1toh89qzAgyfji1cACwstWY5rMJU5isNPpJtA>
    <xmx:KABnZ3TEB3wEOtsdyN7S6oSciOj7geVumjt7C0slBfGG0zOSYsufu8Pw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 12:51:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 1/4] reftable/stack: don't perform auto-compaction with
 less than two tables
In-Reply-To: <xmqqmsgpc6bf.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	21 Dec 2024 09:08:20 -0800")
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
	<20241221-b4-pks-reftable-oom-fix-without-readers-v1-1-12db83a3267c@pks.im>
	<xmqqmsgpc6bf.fsf@gitster.g>
Date: Sat, 21 Dec 2024 09:51:34 -0800
Message-ID: <xmqqseqgc4bd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> In order to compact tables we need at least two tables. Bail out early
>> from `reftable_stack_auto_compact()` in case we have less than two
>> tables.
>
> While that is very true, bailing out on "< 2" would change the
> behaviour.  Where there were only one table, earlier we still went
> ahead and exercised compaction code path, but now we no longer do.
> The end result of having just a single table might logically be the
> same with this change, but if we were relying on some side effects
> of exercising the compaction code path, do we know that the rest of
> the code is OK?
>
> That's the kind of questions I would ask, if this were somebody who
> hasn't been deeply involved in the reftable code and came this deep
> in the pre-release period.  But since we all know you have been the
> main driver for this effort, we'd take your word for it ;-)
>
> Thanks, will queue.

And with code inspection, it can trivially seen that this change is
perfectly fine.

In the original, when "== 1", stack_table_sizes_for_compaction(st)
yields an array with a single element, suggest_compaction_segment()
gives back segment with .start and .end both set to 0, for which
segment_size() returns 0 hence we do not call stack_compact_range().
The original code happens to do the same when "== 0" (and 0-sized
allocation does not give back NULL).

So bypassing all of these when "== 1" is a no-op change, an
optimization to avoid allocating a single-element array and then
immediately freeing it.  Doing so when "== 0" is a strict
improvement on a platform with malloc that returns NULL for 0-sized
allocation.  So bypassing when "< 2" is totally safe and justifyable
change.

Thanks.
