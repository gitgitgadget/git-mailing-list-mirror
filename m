Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE888286F
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795621; cv=none; b=TCwnPjRo2HU+iwRG4FS1iYYEu7BoQXyl4z3Sqna6J7tB7A9NuMVI3nMglX7SiqtqvqPlZUrZkQ1zNro2Bk3O/ljcBu0VVyiIl6YrnCP3Pk46U4zCyQxefIO2xT2A9wTr7cFFwHqQ7nMSkNTVCxzyD5UiNF8xHCUW9DuRNE8PaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795621; c=relaxed/simple;
	bh=VPxmxjQSLVtu8khD5Z3e8XkJZs2tLSVbVWlOi1XlHDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUOwSxfiYJXdTtOgrfnsGsRhZJdoq930hPofMdaxgBr6TyULDLVC8fHG2EVVE69Rvky3jIpN68/5kDQs7TCRirzZjDrUXOJzYtx2get1U9OQKVbDMqIzwCjVKu5+aB4DonINJrprr/zTXhB31iXt3TgLxhvsbRE03v023mRdsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GdXZfFXg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GtUdFMw/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GdXZfFXg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GtUdFMw/"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 59709138FF67;
	Fri, 16 Aug 2024 04:06:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Aug 2024 04:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723795619; x=1723882019; bh=IJ0B4GPje5
	TpEVUZbtsL+P479BMgt5VhBANxUbC+I1w=; b=GdXZfFXg0wmlOM2+jZJ54jHBvS
	becKXc0KrysbvtY164+tJgjKOz/DMp+D93aDt8JgWu6RMY6v5p1LsoOyA6pXKzI5
	Ihn1dGsKkvA9hTzpNGiqPJrDj+5IHCZnsXQVoobiPZxtXm2rxO6Cj0F2VTTiBNrT
	PKINBTCbgSMJVntX6adWYCTtL7CLhiuxdU4B6yVXz74UU0su76ZhRvXl+3cgAebY
	7vb6AmYv742CB1wv5dAPI8QO/eMFIlOlsuCSVGbdluPBmuL+77v756Euvo41bMpC
	zl76FfeCIwonwDw/51l1zoygt94fE+RBVijJWosNyvRUv7PhMpI+GjI7gwDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723795619; x=1723882019; bh=IJ0B4GPje5TpEVUZbtsL+P479BMg
	t5VhBANxUbC+I1w=; b=GtUdFMw/a5cI9UXCXNs7+qoE6hr8aeS3QINqaeue6e48
	Tu9v0iioKzAgQ5VgiGOoYDe3BWliX3CHTvpzLOvQK9UQZZcjzY6WIchg5EsMcrk3
	4Hy6qnClCx8Pf6Ovtua/kQs/esKapNFRqZbT7D7XSXnZgglFwHvp52GoYr3ZYksE
	jz+GtV96iyq3FYeVD1D2ftNE5afIQfB9pKC2OfJiFAb6GVJGb24pODKloIzEKlSQ
	YyZwmjnmBA+p40ZQdkRaaCIX8EnWcTjkExyXLKlHd2Qr5OtF4dcLFg6V3/Je8cDH
	2EQY+BzBuJZRGBkeRdnRmXBRZPFUe/kL2h2KDmmybQ==
X-ME-Sender: <xms:owi_ZtAV9H5cWs44V2B8dpAOH2kj8oiec9ydXqqnLIYO55liabvC3g>
    <xme:owi_ZrhFPB0JSCw3mngru6QHICy-IYm7B0651d6zFmZveagtbID70AVAs_3PUrETc
    n8g59NysALZGBz9nQ>
X-ME-Received: <xmr:owi_ZolXTWbf3as68ZkNXidajixkHhCu2KORIowGu4daSc1ef6MNeXqSQ8vfdFKiqYLt7mfPzJoQb7uEa1IfmihSH1I7wMQZ36tnwMJRlk12by0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehsshgthhhusggvrhhthhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:owi_ZnzHwtCgOoO_3m3f8hicSsWGNzw_teXq1jQgcT96iY5JVDFqdA>
    <xmx:owi_ZiQcvIygXK-led6v3oqmnMf6dzEloDZoCKFtCbdvhzfpEhAHmw>
    <xmx:owi_ZqbvdpchTkE4kXhT-0kj_EMTAaxqqtsK7mZrJ1wJlMz2MQoFuA>
    <xmx:owi_ZjS_mKydVf-b5Es6SSu55a4rYjfRA4P6aARL_xDBVM9xRsnv_A>
    <xmx:owi_Zgdk0wc5aIY2uxq0theLpAv3aovfn_5G64XOzBRIvs1AjQsRBE5j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:06:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c75744b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:06:35 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:06:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 3/5] setup: merge configuration of repository formats
Message-ID: <Zr8IoDy9dU2MNVB-@tanuki>
References: <cover.1723708417.git.ps@pks.im>
 <16f52b75d8972343776adb269da305e7406ff385.1723708417.git.ps@pks.im>
 <hxnibmbakpvh72kfrycxnvo5a24f6atcqa73yys4zthbqpwikq@s7435n3nqmlz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hxnibmbakpvh72kfrycxnvo5a24f6atcqa73yys4zthbqpwikq@s7435n3nqmlz>

On Thu, Aug 15, 2024 at 04:37:26PM -0500, Justin Tobler wrote:
> On 24/08/15 10:00AM, Patrick Steinhardt wrote:
> > -	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
> > -	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_format);
> > +	repository_format_configure(&repo_fmt, hash, ref_storage_format);
> 
> Overall, I like that this repostory format configuration is under
> `repository_format_configure()`. The `validate_*()` functions names
> confused me slightly initially because I assumed they were only
> validating, but they also configure the repo format. Looking good :)

Yeah, agreed. We _did_ validate whether the new configuration makes
sense, but that wasn't really the main thing those functions did.

Patrick
