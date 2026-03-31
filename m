Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD344E037
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774988883; cv=none; b=C0rpriHlvb4Wp6Iz1vxmBMYwr78doXwQKlGxxflodiJ7iSZ/oRTO4c4/weKdWQej7sOnupUaaMSZ2jWOZdMYtNrbJTvSNCK8jUP0UJCwKU1nvYum66yhwlH8PyyQYhGv+k2Xjhhx8EWt8ULRlmzRnHy+goifo4l/V6pkEEuUxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774988883; c=relaxed/simple;
	bh=fXauDwZhfwzuo3Qy5X6WBWV9lOwGnkdnDvqeNPC1PLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=To3lA6CVJlMHA5lRmnbPfAW6+bgmWdRSTZ4AVhw54DL8lzXjve4Bp7c9QEA2P6G7urtQ7VsEc6VJGvrybrdAqQE//Vnozf5nh/u4kOqaN9eBxwcaBS82Ztp56d8L8CkpgLw8/UOw+tZElx1QBb4BL9hdw7nMvzrIRNmAgy5onQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aUmtlwDm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EasHn6a6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aUmtlwDm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EasHn6a6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3066B1D00124;
	Tue, 31 Mar 2026 16:27:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 16:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774988879; x=1775075279; bh=zNrxoK4ISe
	k4W6I8phkowdkDH2RyCSy5rmJ8Wx+EHrE=; b=aUmtlwDmTYA5gMyKKLapO2TXGx
	+eHlu9OYrYoUDhMB4gXsOZsf8mmo0nfjCywWWLE20tLPgzL+oG0yhPgT6EsOQ49h
	J0rNlDuvOyiHZDBls54V52jWFdRS4NijTIOChAZZcjLRsL8lGjNCCsnKXVln2DUE
	fC5WZlvmTjN1tAKhZMKGs/wACJhZi6ej63yrmDHudO3yj0YPW4nZaWuz0qaH4t+H
	hNheORkYAmG/rwZm99Lb+M49oaFGJOGbhXSMehGJ4G0FcyZAxgrt/d4sMFcZR6X1
	RCtTfpnKwpGVqLRq/IPoUVHxioDSuc07a7C32L2y0G+D9jxW+PJSl7QZDJ/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774988879; x=1775075279; bh=zNrxoK4ISek4W6I8phkowdkDH2RyCSy5rmJ
	8Wx+EHrE=; b=EasHn6a6Z6eKMjxcfKwMiuYa1AgFZJAa2vEh2R217yTJXbcjb5t
	bO4fEwMIHMHLD15IPz2HAbtXNpAt37bXvrYktHjoC08yUBGX5Od3f5h65zq6M2U0
	5VrWOIh0DtSiUHTft45HinJX+BEufN5d5sXz44yegKV3YYt5IX9IeONHArPJCrF0
	lgn1hEUkzRk/u4PAgksCAXoAEDTrdMX2UJEVzJ9yphk6havHXEf1zHaGXbALgU74
	Y20UsbS1XzCGFuOV4h1au/+nxqj+1NzQVNePBj+mMiy+GbDgvQP897bmylxSW9Bw
	FhnrTwynjDMfoKJfj7HJ+DwjUWLLz+4g+Zw==
X-ME-Sender: <xms:Ty7Maf9Of0S6iemqmbwTx2NsgGJbdtUbYuPeMX_3iUUA3TF4fHjA1w>
    <xme:Ty7Maay3qg5aCpfApV0rTGQC5U6W2dpmepNF1UCMqgLB8NizT0s_R6fE1XCt81e5M
    CuM_kHxMjLR9XkKQp19hLw-nOVFAhy5oB5LjC23KhUFrPdmgmf9nQ>
X-ME-Received: <xmr:Ty7MaTN60a2j2uJSrJqzLfg7u_7s1OxHub4JQHSixYnXjCDVNshb8uoTRwY9WL8ASJIfg33Dvz0LHiKSl9kV_waoljqwtzQ7Kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieelffdu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphht
    thhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtph
    htthhopehjrgihvghshhgurghgrgelleesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ty7MaX_354uICEBEXofokBExmMjPq1MQuu4Zl4tJcc8EeFrrF71l_g>
    <xmx:Ty7MaY4Jc21UHn0OXKrCpl9_JQ8j5iNMynaKCL1wmK7k49XBQT_Csg>
    <xmx:Ty7MaV6jMMh7divC1Ir04ozsYXr8DHVSPMT04gGnLwU0eSMj2ZVpbA>
    <xmx:Ty7MaZpT55CaDDmB5pf-E4goGTp_UQREYLh1bErVnsDe1idD_9GbMw>
    <xmx:Ty7MaZf-1xGjBb2AyhLrRY7AO255vS-tm8HpQOUyNvs_NsuRm75vhHnn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 16:27:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Jayesh Daga <jayeshdaga99@gmail.com>
Subject: Re: [PATCH] unpack-trees: use explicit repository in trace2 calls
In-Reply-To: <xmqqy0j82ex8.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	31 Mar 2026 08:32:03 -0700")
References: <pull.2258.git.git.1774901607564.gitgitgadget@gmail.com>
	<actcHT_ZHkb58ndi@pks.im> <xmqqy0j82ex8.fsf@gitster.g>
Date: Tue, 31 Mar 2026 13:27:57 -0700
Message-ID: <xmqqjyurzquq.fsf@gitster.g>
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
>> The changes in `unpack_trees()` are a bit misleading -- while it reads
>> as if we don't use `the_repository` anymore, we still do because the
>> function starts with:
>>
>>   int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
>>   {
>>   	struct repository *repo = the_repository;
>>
>> So would it make sense to maybe have a separate patch where we inject a
>> repository as a parameter to `unpack_trees()`?
>
> We can see that "struct unpack_trees_options" is rich enough in the
> merge context that it would be a natural place to have it unless it
> is already tehre.
>
> In fact, o->dst_index->repo should probably be what you want, and
> because it would be insane to start from an index in a repo and
> store the resulting updated index in another repo, there probably
> needs an assert(o->dst_index->repo == o->src_index->repo) somewhere.

Actually, assert(dst_index->repo == src_index->repo) is probably not
what we want, as dst_index can legitimately be NULL, even since
34110cd4 (Make 'unpack_trees()' have a separate source and
destination index, 2008-03-06) introduced srparete src/dst indices
to unpack_trees() API.

    We will always unpack into our own internal index, but we will take the
    source from wherever specified, and we will optionally write the result
    to a specified index (optionally, because not everybody even _wants_ any
    result: the index diffing really wants to just walk the tree and index
    in parallel).

So o->src_index->repo is what we want in this case, I think.
