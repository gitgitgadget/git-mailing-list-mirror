Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635114F117
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648109; cv=none; b=Q+vBaPri9jGaggzkF68V12PQFywPxKCbLHbwg8R8k4iKpVL8TjXYZ5EsTXOAmP+n0kzisDYEQ9mTXxDSpDYoUlY5t3fyVk2tl2bArf5ILXj/XkN8pjxQdvs92/tgV8pg/XBIl9J0EVTz3RpXhT0oEYr8sdXT4iUGDaQ/pbEY408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648109; c=relaxed/simple;
	bh=DUoz7tgPaVjNHYhisT35RNoldSkQanz6uWJkFBN4t+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lPCy4fX0fFRAdLOwqe356gaJZs4VStEgh16ly02MbjQ6KUGnuCkzCED6hzOTFcU56pDBOVH2750WFOvtP/FQuXFsgGcMyHIobn3UYaIj5vS7lb8YJG9Kacc/knZW98CawHsarzJzRDKwfYXZuRif42gHY0vOf6Xu6zuDqnMH0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sflc3lZi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgrnWuWu; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sflc3lZi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgrnWuWu"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BE9E31140217;
	Mon, 10 Mar 2025 19:08:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 10 Mar 2025 19:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741648106; x=1741734506; bh=vTAprXxhVg
	m2yUe0t+FktF6JiDbim4gDPTM7slB2cMM=; b=Sflc3lZi0pthRRQ2mQRkchsqx4
	xkh6rbCRMrzbX16tELXzWcVKqZJu4WIadRHtGeEvtD8b2LEQHmvVGbil8b5l6Oil
	qontJWZqXIt8gYTsA+E+lj8RK++FhN7gE2euV4u7A9fCgP2b5EpEEh4JtRn1G+gE
	OuJ/WqaZlEuqbvc4A4Q/FbFhFQDtSUMac3iNsDTVWX/fnLK+553NM0/xn8kYmakR
	wRJG+OoRnabrgtBTykps3cA9WEPoi2PkLWHKhFZuxm64lZcYejOf6oJfORSvVa+v
	cYObyWhaJ17bJ0iliutJW7w9JiYvQJDMZyNdjYCZaF2cpMEXVmvv+h9tZHtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741648106; x=1741734506; bh=vTAprXxhVgm2yUe0t+FktF6JiDbim4gDPTM
	7slB2cMM=; b=LgrnWuWuz8LjMOq/rj6coPCCgQeTVUHpZARxrIeOyYIHXWP6BzU
	SxqgWdOPs2rWt5PUDy2XeLeNJbwgGfyKlkX4mvnOpt6vQDCPFB7FRBVphENwFyef
	1W6Qdmk4kes0FEfTLRIDRyo4VVsbYqVM52EZnGO5CTDCG5jO9dZdZdNbQ4IhJ215
	yYpeggQuH8n4V5VuWIQ1UPSpko6rJ6tM1gXoY6NiYVus2NqJ4ru6mTUjAq6iU8FW
	wVRwDp4paRCHjQvuni+e/cSOmugG/B/9CPzNiUw8QjEML5HR0fR2oplPmMIy5l5a
	5N9yPYjoEg6u+Biz1SHbsHPr/XHhQOgJ1Zg==
X-ME-Sender: <xms:6nDPZw6AeZB48i0bodHFn3afFxp4vuQ0yPFnk0mmxUaPMJkoqNSamQ>
    <xme:6nDPZx42piVB18528LcITcHzAD9GcV-vtIFq5lb-5xT1wHckHneJY1-vFWutKJuLX
    8ykwdQ8I7hI4umGtA>
X-ME-Received: <xmr:6nDPZ_dWbDsVstkwViGqZ6YFWGK6G0Zn1DR6Tr5u9xFAJSsUBs24P0Wz8KHujX7Dk6EiVtfrDGlTcEZj_SZoX8ran8vghSi19e0m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhhvghjihgrlhhu
    ohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:6nDPZ1Jd2kW5wejW5oVbgd0PNth0eMV0Ks3AksbpXgF70GkhDbXHCw>
    <xmx:6nDPZ0IsrU1-LYurrBqAaLznDa_Y8WnRx32JUlLe3J-b-QW1JVtqBA>
    <xmx:6nDPZ2zAPTKgtL7UGnq6CMH4FzJZpy5IDivi_ZlkIFST0g81H_JupQ>
    <xmx:6nDPZ4KHWV3MMaD7-LuVlRwxMVZ6H1Eypm7_0zdMz81Ojs_hDSoFxg>
    <xmx:6nDPZ88En5M4hvByPKJsTnIPZrvbzEHd6z0s4TSI-9RWXJUaOW0rmPq6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 19:08:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  shejialuo@gmail.com
Subject: Re: [GSOC PATCH v2 2/2] attr: use
 `repo_settings_get_attributesfile_path()` and update callers
In-Reply-To: <CAOLa=ZT=zGTF2DLEy9VjXhcUN3wEi7_R=8O6nV-TtBXKT=ENXg@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 10 Mar 2025 14:17:06 -0700")
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
	<20250310151048.69825-1-ayu.chandekar@gmail.com>
	<20250310151048.69825-3-ayu.chandekar@gmail.com>
	<CAOLa=ZT=zGTF2DLEy9VjXhcUN3wEi7_R=8O6nV-TtBXKT=ENXg@mail.gmail.com>
Date: Mon, 10 Mar 2025 16:08:24 -0700
Message-ID: <xmqqy0xc4h7b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
>
>> Update attribute-related functions to retrieve the "core.attributesfile"
>> configuration via the new repository-scoped accessor
>> `repo_settings_get_attributesfile_path()`. This improves behaviour in
>> multi-repository contexts and aligns with the goal of minimizing
>> reliance on global state.
>>
>
> We should also talk about the modifications made to pass around the
> repository struct.

Yes.  We first should justify if it makes sense to cram attribute
set into the repository object and pass it around in the first
place.  Many index-state related functions do not pass repository
around because they work on index-state, so index-state is passed
around instead.  Perhaps the attribute subsystem should be the same
way, in that their globals should belong to its own abstraction that
is smaller scale than a repository object (it is permissible to have
such an attribute-set object know about which repository instance it
is related to, though).
