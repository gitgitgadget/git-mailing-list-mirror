Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96426F442
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905343; cv=none; b=D18vhRf34T0B1kN0g/yI18Dz+I5ubiReDinZeXB+FI7R6XJLRVsXePB0mbehdJNUmlCDafZg1PdLutE9RwxyRB2UwvL4ZocyVrgFkZsGAMCS+qD9K9BxCLTTTm92/NqCOMFjNK/cHOLWve32V85IHmWOejxh/TnzvtW3SM0zDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905343; c=relaxed/simple;
	bh=MD0rCqtqhauuo/SGQNnuKKqzQ8swgnIhrSOfzTfwpDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGV/lKWDm0cSIvsjLJS9cB4Gm/+urNTAanMKQvJxF4Scfcwoe1hcyv5lVqs0Sa2B6GDKeoeTfkHrDxZNkF71sK0eBdr+J31MyH69v/+/bj6pZqQYA4L5pNWkKMQH1Rvr0O3HK4fA9s2doYrRUoEKO3Egyw9gSZfuY46bW8hKP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hFCQuHMX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HyDsJy5H; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hFCQuHMX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HyDsJy5H"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 73E2B1382D8F;
	Tue, 25 Mar 2025 08:22:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 25 Mar 2025 08:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742905339; x=1742991739; bh=MD0rCqtqha
	uuo/SGQNnuKKqzQ8swgnIhrSOfzTfwpDE=; b=hFCQuHMXUypVyW2pYTGsfpjG2Q
	YPFt6kpvkLtviKlWDZ+lkRSciluOjsKm+uWw6urvbvQLK5YyGwROXJCzbyzbDWEO
	0ms5JpXA0H7QsPVHYeyBH4A1v42srWbIxiVba/HKMta2o6x5phz35qyq+5CXAZve
	B9nPpDKDtGpXzkCzKRIvJwrPWk7oAbxM5ViyOAbrNmfvP8JqFo53jmsh7mEXZ/X/
	Tc38vY70zuxVDbBxh5KW8T0ZFRnU9btnV26Q9x9RvV6Zvk7peCJgzudeKEYepmIO
	/S8ABaqgfQV7ibTYFse9CQmoi0Qzl9wxkwVb9qHxb7PyB7GhWThOl8CeSGVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742905339; x=1742991739; bh=MD0rCqtqhauuo/SGQNnuKKqzQ8swgnIhrSO
	fzTfwpDE=; b=HyDsJy5HxmKj647wuLtrg87j/bDB0+zxm9UTw7ahGkW2tVZnUZs
	iU57QhZ6v02OQlS+CBw6T54EL7o/QdY42DzJHf/yPpGF+bKyqakouWj+AlzDQYpl
	HFVu2Q3dDeo/TIfDmZmJOip0aQ+Uy6bH40Zc82XjOTp/bb4dH8FteWCLkeudP2mv
	EQlsXjgb/rsxydYRdt9AOwIU5bvHKmFaAso+2GqDzPew6MQ3/pjAhwSheI7yv7WZ
	CddoJ5wCXOkgKe9dO3GB5zX5Vc/IE9oLrDAvnoRUvpL4OQKs0DV9oN483qgc959o
	lErXGsAGGHSr6Js5Qx1fkUgab4qhcS1xqqQ==
X-ME-Sender: <xms:-5_iZ_G9lxuvI68aWqguaz30dLGqNNFu4k6KU6C6CqUJsdwg5IagwQ>
    <xme:-5_iZ8WBZHTdTMeasokTkmsXDjJt9MF0ns5qc8FAOoNKI2FdI03SB_oCJT06flyW0
    MZUfr4urvzz91mIAw>
X-ME-Received: <xmr:-5_iZxKXXkrurxlB9eu-XqO4TCWqBjGByX7CsgbdQPhATMGZisx9PQVBpDkyjd1hKuNNYUNQx5kIcOJDl6btRQl_reIikZY5BwstMCFoJxCPUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeftdeitdfggfffffelgfegudehvedvkeeutdel
    leegueevjefftdelgeehleejnecuffhomhgrihhnpegtphhprhgvfhgvrhgvnhgtvgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    hhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:-5_iZ9Hqe8tuO1b_6aRGCgWi_2RLi4ott834S-6hWZBzbgIkeT51ew>
    <xmx:-5_iZ1WFqusSkKfoQu0okOeXAtm-FC91hyKvTJ_cVCTMFIP73r0rDA>
    <xmx:-5_iZ4O_p6wNi2a3AzizVMTiTGN0rcaI_MVW7GhjblSlCTQom76otw>
    <xmx:-5_iZ03O3dLgEF2v97dII3-dGT86LepGSyDMhAtGu-BpvWeJ-H1m6w>
    <xmx:-5_iZ4RyKWL4yDti6P_iB1zItoDSqHbMCOFDgqPqI9ASXG_wRMOW52JB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 08:22:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f701a636 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 12:22:15 +0000 (UTC)
Date: Tue, 25 Mar 2025 13:22:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Avoid the comma operator
Message-ID: <Z-Kf9ovF8zAemgUP@pks.im>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1889.git.1742889711.gitgitgadget@gmail.com>

On Tue, Mar 25, 2025 at 08:01:48AM +0000, Johannes Schindelin via GitGitGadget wrote:
> The comma operator
> [https://en.cppreference.com/w/c/language/operator_other#Comma_operator] is
> rarely used in C anymore, and typically indicates a typo. Just like in these
> instances, where a semicolon was meant to be used, as there is no need to
> discard the first statement's result here.

The changes look obviously good to me, thanks. The reftable library and
backend also had several instances where the operator was used by
accident, and I've gotten rid of those over time. They typically don't
do any harm as the result is essentially the same, but sometimes they
may cause issues. And at the very least they cause confusion.

It would be great if there was a compiler warning we could enable for
cases where the operator likely isn't intentional. But I couldn't find
any, unfortunately.

Thanks!

Patrick
