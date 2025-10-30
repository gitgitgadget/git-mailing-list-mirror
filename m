Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC062EBB83
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861176; cv=none; b=VlUxioeQYWwtUCkpB2vP+ugHvH7PQ4fKjDNc6WwJaeJEVyK4CHdoltdcQuT+/Z/TdNyHvZQK3jkBUIwMe3wzBHx36dTgDj1yOhCYCCsFjsjUdkZBCkwb1YilhjgEWnT90LIgB3dKjQSGjoG3iQCiwwHIUHcC6QDNiHaN7QzpCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861176; c=relaxed/simple;
	bh=Gm6sJgYvb+5P1Pk7VFRzpGae2cq5Y32kQte3w5TTlI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lKaZN1FuHJs9m0OOYXA5ZSJKYZEruFfYVUb+ieKL4K1OW3hjgd9i0s47vReNQ1o0dAdDasP6oGyZk51jarZa3Ty8XegxrzZCMmt0rDMHqtQ8EQtsRdUiXGPcfLasi/r7dkWSBR+7hECOM4ql/Yw4Qh6apUhzxEtHvyBf47QY/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TEXllWhT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qPjmXaCC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TEXllWhT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qPjmXaCC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E8711D000A1;
	Thu, 30 Oct 2025 17:52:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 17:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761861173; x=1761947573; bh=MIL28O2IWj
	joFcqfY3E08Bowovura0/H3ErlvDCDz40=; b=TEXllWhTZ8AVP0leJHCpnp486u
	fl16xqLh/PuEIp0x7v4BtwbH1fZxxJCJbO8iLYTxE/j/Gw6uaUMUY6QqgU9xysum
	/4HB5etzEBJF2A1VPchjWQqPeYcKQbnesnxSAPf+OwztYs7smqdcHrBVNVUQL6wd
	DKC0KnYg1Ei3JHdWSAjRzsGVcwOd+9qWos8CqBU/m4QoMrR/OTuhQvD8lz+iqMkZ
	6VKAQW/t3ozAiRXH/xV7yZmVhCnHMLXvM/OOTirK9XRe8yNkLp3GRnqVuVf9MF79
	Xb5CtHN4d6myAeEI61k0yaT5eKUmqg6Xn5SMxA8v8DmkVl6eN0ZilmWUwMiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761861173; x=1761947573; bh=MIL28O2IWjjoFcqfY3E08Bowovura0/H3Er
	lvDCDz40=; b=qPjmXaCCH7EeaHhXHOX096NsR8WQxns69GtVQO3BGLuNnBySAs1
	TbTogV7iq734LSD6G7y8ztFJSpFlBf3Qvk9OomcthE3HeTFXPmaIJWWgP0dK12Nu
	DvCe1A08/1bFyJ2exxpDI0pVD6od3Vn4HMQH2UtSkOeV1pJmV6bZz/6Hu4fjTnwt
	eN/xp41JpfOHshhU7dRu0beiPYbzGiGLWIqYcMfdsryAnWW4hwDhu5xK1gBoiUEe
	ce+FgirT5K7ixOPweR1Cr3ZPzVI3hrDDEMTBrh9GzDYd/CS8NzOxVkF9vNM8PseC
	qTf/KOu4JI9/TqF3FvUsxk0Th4wg5q/KVBA==
X-ME-Sender: <xms:Nd4Daa0faBjBmguf2IqoZ1WGCDzWDWzd_RdSN6fw6nJ7j15YOxfXsw>
    <xme:Nd4DaT_Rc0UIFKMEHEgj-i8qSvHhUdmvxf3p6MnV_8DgtcoFI55NwEim5Jq9GGLbA
    MFgrGfhfDlxAbHbpRcMac-e9yEFxlcxrIzA4h32LfzfadZQGUwDQQ>
X-ME-Received: <xmr:Nd4DabNEdcsyIJNs2kBsWeGotn4uz-TArfsJgWUkqEcsHqPxToIuHTfpmgTP-UtPV0xlEyDQUthvDC2WGAZzCevE04AQljplTZGa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:Nd4DaXc8TBGzscEGJZDokd6eVmhp0J5PT94XiBcx1w4Q6a6hjW182w>
    <xmx:Nd4DaaVlkgBkcgYcLO_BIkKIby-n77FVFfuPacrhd0spK0heQpPohg>
    <xmx:Nd4Dafjev5PaWnyBfNT_aUyPsPt21pJTl7O0ZO4TfY89Js1rK5cQOQ>
    <xmx:Nd4DaZ8H3j0iXPqcTKegO0LwYZFokoAT6ldQ6UN4fPp8FS-36z5u6A>
    <xmx:Nd4DaRPdQ2Yn9Wkwu0mwT5I9-3BjTVQdHHBxGhy-AZ5F2dxF5uVI2gUd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 17:52:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 09/14] hash: expose hash context functions to Rust
In-Reply-To: <aQPbsX-J4eKvRTar@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 30 Oct 2025 21:42:09 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-10-sandals@crustytoothpaste.net>
	<xmqqqzulacst.fsf@gitster.g>
	<aQPbsX-J4eKvRTar@fruit.crustytoothpaste.net>
Date: Thu, 30 Oct 2025 14:52:51 -0700
Message-ID: <xmqqh5vg3vm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-10-29 at 16:32:50, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > +struct git_hash_ctx *git_hash_alloc(void)
>> > +{
>> > +	return malloc(sizeof(struct git_hash_ctx));
>> > +}
>> 
>> Not an objection, but this looked especially curious to me because
>> it has been customary to use xmalloc() for a thing like this.  Going
>> forward, is our intention that we'd explicitly handle OOM allocation
>> failures ourselves, at least in the Rust part of the code base?
>
> No, I'll change this to use `xmalloc`.  Rust handles allocation itself
> and just panics on OOM, so we will not want to handle allocation
> failures ourselves.

Thanks.

And re-reading what I wrote, it does not make much sense, as we
would want the integration go in both direction.  I should try hard
to get out of this mentality of talking about C-part and Rust-part
of the system.  What is allocated in one side needs to be able to go
to the other side and then come back seamlessly.

