Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753734FF71
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680018; cv=none; b=KaHflNTTkXdBw/ThroHYE997Swvsj+YU4GwAiV7AV+TENYXQ2Z166UvcJvj/6L0Gsr/V00TP9ZHdGD+ldQ//Hp3e6wPNT4BiXNgBuuSi0JzZepINqaoLKYfgl9gFroN/71I/JHVWJZa97HgkSuh/aONwuT+clc1shvKYi6iRfrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680018; c=relaxed/simple;
	bh=qxOl3Zzkl7zSAmf32Yznsw8cl8rjfEQmwNfeZLJeWiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QVixV26OW2KNC1k17+IRQX9pLfNZWoubBUL9i8CxeEEEIBtaTVnhzAJmUXTtkTlcfOnxOin6ZNjBSi3DJrL8luvXt+EBJrS/a+nIWvgJyqJ39wWFYuzux8W9Kp6mzPiNysTk/gPvJTiOYoa1kJKyyMSG9w2M1fmvbkeZ+oBVtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mFcU1Zzq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2aJEBgS7; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mFcU1Zzq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2aJEBgS7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2CCE07A008E;
	Tue, 28 Oct 2025 15:33:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 15:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761680015; x=1761766415; bh=3t6JS93kRc
	roBs3+cx88oiVTY6Wvwt7GEFQ9WRrHapU=; b=mFcU1ZzqX/UgW2KMBWaKx8G9xz
	ewENQ4Qh0L5iuW5qZR42PsdJG2N8vUx7V1n8t3RfzrYQkA3rlVYtQhxGrODCADTA
	7/t+Z/ge/i5NDfapn1LYFCaDm/AknO9AC4jx+0Wiwou2L5qkIWJfuAtakKOWXWp7
	3TFYygB5wUYCxHqdGevjCk0e+ehT4OhkaKEUAk7f4oNU1fwB5MdEV59Tp4N7t1zo
	kHgoWtWA74TGws1JQMdqQRAu+55IpN0faekWo+iqWGPmUwqKWlvXMWexxO/XMyd/
	/JSkQc6g4j4vMGks3NvVxSQFUlUYM0PqC7Yw7PKCHSTWGzbA2xX4ndGhdQSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761680015; x=1761766415; bh=3t6JS93kRcroBs3+cx88oiVTY6Wvwt7GEFQ
	9WRrHapU=; b=2aJEBgS7UbNdQxbn+Wd92auVWxJs3HMb/hFtRqdIErZ86wBSrFF
	jjWjIwgDfvLH0QoSeN64PyNgXXotxyD+xFlXkSX9ajqP8HFER8gUs4W8aMjotSgT
	n7bZ7Gz4KTcqzhcibBnzMSp4TyLn7HFao0+YRbE7SX617ERdggoOlREJn2w/8ldi
	/S/THT8DZO9GouNx/fOzAX5sWjBxMEbxAVwPbNCKH+sx1Af1NgCwSuEqX+fqtQ5+
	/mPC9NpMmAtq48Q0HHj8mBqb8lQWy7FKo1ezXkmUc1Kq5RcWUV4B6ZzA3afsWf+z
	j887/IkUzdVlVT+IDOxGBBmemmhKlhoUTLg==
X-ME-Sender: <xms:jhoBaX-IXfbWRig4921kuDv-fqaX04dJyVlMGYbSWYxmgot81yvUBQ>
    <xme:jhoBaaketgA53EMbYY_zDR0KkdMuZagJgPaQgvpJjkaa0SCb2MIO6H1bctv7m9D7K
    1BJN-S59TBaeNsOu4lp669suxh2Op5lGc3rnmLP_llDAtGMlHNImxE>
X-ME-Received: <xmr:jhoBadV29WGo2nkZtGePl35u0xxKuXMnAnzs_dMdApMaoxrU1zPEinMA_OL4S4wVKJTBnZpIO_2oVztcSiJHihGelk5xODyJCgS5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:jhoBafEgRAYljfaFK9QeghX7IdT03mP3m_nhD2eMkvLOl5I3OAafug>
    <xmx:jhoBaZdJ3HFOttbo7r5XW9zysE-iHVdt11-BerQ5eEoM4F1nF-n_sQ>
    <xmx:jhoBaQJZGTI-F14kM-Hc2a1gCVeyn1a2E_JE4bKPCHzJRjEG0rElIw>
    <xmx:jhoBaeH50zqghObLiTc8btPFifq6aE35gaA7kkr4k3es9IVDbdPsiQ>
    <xmx:jxoBaT1muMzbtV0F4aaXLM7mOaN8mKLbkUpJhwzbWoCO_ASKq6kHBPko>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 15:33:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 03/14] hash: use uint32_t for object_id algorithm
In-Reply-To: <aQCKCfuaEKBArD-g@pks.im> (Patrick Steinhardt's message of "Tue,
	28 Oct 2025 10:16:57 +0100")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-4-sandals@crustytoothpaste.net>
	<aQCKCfuaEKBArD-g@pks.im>
Date: Tue, 28 Oct 2025 12:33:32 -0700
Message-ID: <xmqqh5viddo3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 27, 2025 at 12:43:53AM +0000, brian m. carlson wrote:
>> We currently use an int for this value, but we'll define this structure
>> from Rust in a future commit and we want to ensure that our data types
>> are exactly identical.  To make that possible, use a uint32_t for the
>> hash algorithm.
>
> An alternative would be to introduce an enum and set up bindgen so that
> we can pull this enum into Rust. I'd personally favor that over using an
> uint32_t as it conveys way more meaning. Have you considered this?

Yeah, I do not very much appreciate change from "int" to "uint32_t"
randomly done only for things that happen to be used by both C and
Rust.  "When should I use 'int' or 'unsigned' and when should I use
'uint32_t'?" becomes extremely hard to answer.

I suspect that it would be much more palatable if these functions
and struct members are to use a distinct type that is used only by
hash algorithm number (your "enum" is fine), that is typedef'ed to
be the 32-bit unsigned integer, e.g,

    +typedef uint32_t hash_algo_type;
    -int hash_algo_by_name(const char *name)
    +hash_algo_type hash_algo_by_name(const char *name)

Yeah, I know that C does not give us type safety against mixing two
different things, both of which are typedef'ed to the same uint32_t,
but doing something like the above would still add documentation
value.
