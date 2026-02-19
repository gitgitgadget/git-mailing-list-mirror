Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0362F3C26
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501181; cv=none; b=LwwCxZ3LqCBTz020leSZe3MATOS21+VtwbiirL0Bn8JpYKKY7/KC1Os+5auq73Yw6XQ7rnpqZ3GnMOtVXMvWKXOQ8L8k5SDnZbnTCMJrfS7oGHlXRYqSpeh8UsyGyWC9hw38pgs2n9gXhmewfy1UbulZ4ybyf/Wn4RtxNZIAlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501181; c=relaxed/simple;
	bh=h3BsNAJTg+06Ybnuy3DK0EIR/5SvDBLiK9+SyUvTwHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S36jnMS0IM5AouPRQcCIn38QC79FNWwI+Wc87/tEvikmlfNm61JaxwuCyvm+OlfBYJDwc0g7DJmLnH3pQmCe2bxrxtPnmY2Zvrrlk6dmWNmqPuqFAkqSNg0shme79DHZIIpBb9SgrAfJwKjpR2CmUEIfqkDhgkE9zbIhqZbNY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nLWN/Uv7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oHLIqDAr; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nLWN/Uv7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oHLIqDAr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F099EC0597;
	Thu, 19 Feb 2026 06:39:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Feb 2026 06:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771501179; x=1771587579; bh=5hJ8B7oEYI
	GGRocUnJLRp91ykAjjqVu6BI+PQ9FnolE=; b=nLWN/Uv76BJd5AANzvfRkgRzbe
	MFUDG85Px4jIjZ5JjPuOTAAVt68o3QP68+T3URAV7ZgSDutnKPRq1SNdAobEo9xb
	dZRhPimSsV4lvgz53UQZqUpHIjvSvNN/LbR2dBAmR9jN0Hi3xWdgg0UNtXxYNVJ2
	tAQ6YRM81Dw+MVVHvOLf7rwo3oOWCfSGP92uXFtZGzXMNIn/j+5N/AV4zq2I84N3
	wCtgWsCYUtVG2KPjO7MS9tPotLQeBu6HfsUywf+pGDDedpU3/oqs/qlhqu+O4XOn
	SKbamKVrVHjls7F1jiztQPNokDmFvcZ4f2/gWNrf3+7sGGbtASAy7zaD/uhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771501179; x=1771587579; bh=5hJ8B7oEYIGGRocUnJLRp91ykAjjqVu6BI+
	PQ9FnolE=; b=oHLIqDAr7ZB0Z0B1ecbt/MLKt7CU0107fW+gIT60j6XhuB8zq8l
	BLzpGmodTqb0oeRE5o7u9F8+wqNF8F9nP/ge37b70Ij+vlTiiNZ82i/0xKxZsXgj
	OZB4aQTjb/NK2hzSDq0z1hQVyc3WiEW/vv50PfwfMWNwdB5do4HLdDLQZQoMOSno
	G62XB9L6XbcHZKw3V0+mTiH3KKsXUGfN1Gm/KTasVWablZpXHafsv+ydeplywxSn
	npB0UgIpfMnZDIo16CshkTFD/v8t7K2mllTFjlQBwvX+jE3br8j24c6WJO4DYpjR
	hlGenwiqMS3NTdHeoDZ1QJGxtaZyWtRNYRg==
X-ME-Sender: <xms:evaWaVT_GfMBWI00MhhFlHfT8EIgzwc2t-q5n-9mJWphm1g-gAfmww>
    <xme:evaWaVzvFXp9cJzqDoNeYdSrzqzrsAj6CRkSPAGvxS2m4MSYEzadowEA8Xu8A5uiJ
    _boBthRpW5vOLk4ev07qSE-ahzq9N5kEwMuf_OMD0EsyF-ta-c8dQ>
X-ME-Received: <xmr:evaWaf2fHY_gANAdbi5XlKegCxh0HBs5a1vNFhV_BfH3OS0aEjq7ahp93mmUZRjeDkZFNNeEhMG9iaYjq3VRqbZb4Mkbu24RmiY3VF3ZWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopegurghnihgvlhesuggusggvtghkrdgtohhm
X-ME-Proxy: <xmx:evaWab56tkkAGa_AhEsW_lpEteSeADCqB2YtJwBGC0fTt_wZSLoqqQ>
    <xmx:evaWaaUsYu1JBJSBy-7ZS5zuf8Uih3v_rccMAz54ZE0sfTePVYVy1A>
    <xmx:evaWaSCOm9N0hcJTOXTmNGhGNNaCXwRp3zDfhZrophILbrXWCqBcuw>
    <xmx:evaWaR5XVyg6X3AFcvTwGW2KCzaHTvkQmr-clWb0pO4AuWKj5AZrHg>
    <xmx:e_aWaaUsTrw5vHx19S9r5Sc_b7uWjsjzeQr1qRYz1PM0MDgIuCtIslqR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 06:39:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 124c95fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 11:39:35 +0000 (UTC)
Date: Thu, 19 Feb 2026 12:39:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Daniel D. Beck via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	"Daniel D. Beck" <daniel@ddbeck.com>
Subject: Re: [PATCH] doc: fetch: document `--jobs=0` behavior
Message-ID: <aZb2acEvAtNmt-4j@pks.im>
References: <pull.2047.git.1771443159369.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2047.git.1771443159369.gitgitgadget@gmail.com>

On Wed, Feb 18, 2026 at 07:32:39PM +0000, Daniel D. Beck via GitGitGadget wrote:
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index fcba46ee9e..e15cbc51f2 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -234,6 +234,8 @@ endif::git-pull[]
>  `--jobs=<n>`::
>  	Parallelize all forms of fetching up to _<n>_ jobs at a time.
>  +
> +A value of 0 will use some reasonable default.

Can't we do better though than saying "some reasonable default"? As a
user I would wonder what this is even supposed to mean. True, we don't
do so either in the documentation of "fetch.parallel". But arguably, we
should update both sites to reflect the status quo.

Going into the code we seem to fall back to `online_cpus()`. So should
we document this accordingly?

Thanks!

Patrick
