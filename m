Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D62741B7
	for <git@vger.kernel.org>; Fri,  9 May 2025 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746779121; cv=none; b=lSkfdnELwpsWdX/GhAjJvKVhUqXSt7+vOH56VN7AlW2+pslmMR6TPq+ejbwIoWwtolzH5aP+eVZhnlUcxt3hWNCu5/+YtSKHFylyG0c6iQlsOtLUsOXKQGaRMa/VtSVpcmRrUOlclgY4u7OvEwCddEufSxjVSN4b3kvOOZrFKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746779121; c=relaxed/simple;
	bh=JiUNrvwyAxp7eO6GaDUi1CgZbuMe96GGYUMYXjP66pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQJ1o3Yl1xCZV3i8BE1oE86PHWhMqkSGPU7TBOCU5JfvNkJLgYUcSDtZtcBbzhGp9uVznMdR6Bl/MuKkTTB0PSL8RStezkXgvsmL1BiRBs/eZaQqGiv70JX53x+CremTt2xsJdPTlVW5t9s2192Bb0O5e0v1L7w7zj8Nwj2D8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1Jjg6jbs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i2F5/YHG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1Jjg6jbs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i2F5/YHG"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C2031380357;
	Fri,  9 May 2025 04:25:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 09 May 2025 04:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746779118; x=1746865518; bh=KTsxuWstqG
	DXhHXrGRSrtvBhORPFkWCMEh5409yO0r4=; b=1Jjg6jbsqRl0bbZbXHkohXTkOg
	J/1ZXwqqz1l49NxXjwd/CC6I4XDoNV/mLgKA/wogFYz0uynzu2LljgdpsSKk5HuY
	up+hQ4dGMCQHN00tQP7aH6CXaztb8LtEnUzVVjgG++ihGEg0uJCPKqR2BBLRQrvs
	otUMYXawKkav94mX6eEZvmxz3bTzi7M80hcZh65a8sZChJogen07FizUx+G/XyEv
	QvM0iilWSeyfxoIPJ/5x5bUuY0dvLq4HSB90NY0mUivJtdImRmhM6umYIkYJ0m9R
	Iwjjap5liczS2KXbX4EGUTw2II2iH6ZKFK6HHg1QI/jqgumAo/jnYxlJ0KEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746779118; x=1746865518; bh=KTsxuWstqGDXhHXrGRSrtvBhORPFkWCMEh5
	409yO0r4=; b=i2F5/YHGECXLFszrkNa5xCX4oCLl54Gl2Rj3OzfTcnETofzDXcM
	1Tqv/BZnceCSOyB/1GRhb2ryX+S1ASpv/3oEbmmHQUK9mVK/YWzcR71OeNBaFr8B
	yLmlTCqkB8XuhD+iBWbe8xyDcf+AH6qm8r/FEYar6KQSBSwl0MX3oFewhJUKff9h
	nBEi4epbv8gf1h8sfwla3jy3/+lQlAdXf1/3e7Wky8a7/GY7omRzKPqWo4/nJPFz
	z0j1Ivb2j0118xBB/rd5vxb279DQEKprsEJs36o5RRt2GChtpC/+dHW42iCKvZE5
	O3zzi6NUyRbff2XSz2/qfG6Dc6fM/ywEx+g==
X-ME-Sender: <xms:7rsdaOidvXqM6OoL8m2EvQokeyl-H0Gc1p58-NAIq92VrajdwwaC4Q>
    <xme:7rsdaPDHcKjw7bljKhmuHgACKtbOx_zjfiWpS1ZbhFjleLuWQnp6c60MvSQCyUZZI
    uICC6j4DImkgMnOvw>
X-ME-Received: <xmr:7rsdaGEZR3T2roceazVrhUc0k2p4CmmKiPqY1_1RifkTOJteBQZFSW6iXD7pcIylT5bNpkjBmPrZ29kIyvSYfmSvqQ_-zg1JwDmkO2ibGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghn
X-ME-Proxy: <xmx:7rsdaHRgYiunsy6j1g1ftIBHY66F56vzuavQ2Xg-tFlrRVqOll4jig>
    <xmx:7rsdaLwNv5owoU5FvRkiselUZfv6tVRLaFX3GNJklpNI-3LC4neArA>
    <xmx:7rsdaF5d5rumv6M1rvTy4KFaZJyiSrw-WuQ1ChT8PYPi0t73iKjaBw>
    <xmx:7rsdaIzGPQLkpprUuB2ovuJLXI0agrW0afDfTImtUgaKWFBp_8UvGg>
    <xmx:7rsdaKt_GzLNZTDwoEEAqj1-yNfKnmFAiN7sGOR-GPXNmaJ0nPk615LL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 04:25:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44593f4f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 08:25:16 +0000 (UTC)
Date: Fri, 9 May 2025 10:25:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2] fill_oids_from_packs: fix memory leak when
 fill_oids_from_packs failed
Message-ID: <aB2765DnIjb1xDQW@pks.im>
References: <pull.1957.git.git.1746712275566.gitgitgadget@gmail.com>
 <pull.1957.v2.git.git.1746774869081.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1957.v2.git.git.1746774869081.gitgitgadget@gmail.com>

On Fri, May 09, 2025 at 07:14:28AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> In commit-graph.c:fill_oids_from_packs, if open_pack_index failed,
> memory allocated and returned by add_packed_git will leak. Simply
> add close_pack and free(p) will solve this problem.

One more thing that I missed in the first review: the commit subject
should mention the subsystem as prefix, not the specific function. So It
should e.g. read:

    commit-grap: fix memory leak when `fill_oids_from_packs()` fails

Patrick
