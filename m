Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366C198A2F
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406721; cv=none; b=dp02d79FURozNow2HW7j95iw/s3MBbPtig9D8GUshWMjV9ErOA7zufzeLJIhvxoFCO4KykDSPFPmaSs3oz7YRKKXcHBvXyzLbgP9D3lW63Y1g/9NJ4+DUkGu19BWRJo0rfLy/NFDKK7sqbSikaTiiYDKDIrdvfPsKpO3BLjV08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406721; c=relaxed/simple;
	bh=3/y1kSR7eO9Badxt/vfUpHP0DvQ14o4skk/mvlCPHuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVg6vCLCFQvEXvuSZjR4JFD3DKbEMbikxCNN/VxpApdiwiAG2L2OmIuxlG/LgPpGqMK5xcUcKHcj9zv6YUrEfANpR3v1Zqg580KcxWXx1siwBhTmoKWfT61IMcCl4bXnn+ooJzvzSsAPgaTllfDfCqTnHVcgy7M/PzAqZ2L031A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k1ITwgbY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P5+8r1Hh; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k1ITwgbY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P5+8r1Hh"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 85AB513838F7;
	Mon, 31 Mar 2025 03:38:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 31 Mar 2025 03:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743406718; x=1743493118; bh=pQGqk9ZETs
	m/WMGGQm+4w2iumWSRR3aFK/MmkmddNt8=; b=k1ITwgbYIoV+Rt4nahyiaRfbGi
	TOMNFEXQwvA+8lqUBxo+DnbSOU8PzTx6G2MuICCaaHbROlvbIWt+9nkmpuiUyOxn
	8ZaGx3dZlFvJ2ZTAct4BreFVedSAXZMcTcxFEzS1tBQ6GQYKQpQHO9aV4KbjlcHu
	v+mau36pwmWbIynAPgJkf7jkPiyLHNSHIdna5hfc0mxYP4OKCng4hrDhmrG08jnI
	a8j0lseAX862aSECw6Ltp7led4UrpZ//JIexqwzdvjM/n0sCoRNaPn1UX17bAfhS
	lf99qjXXf1jlr5bcCudleoj1eetCJeNYAOzWeqmsOJvozYCq4m+ys+HAL+3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743406718; x=1743493118; bh=pQGqk9ZETsm/WMGGQm+4w2iumWSRR3aFK/M
	mkmddNt8=; b=P5+8r1HhriwNd6L/ViRb1x23PWgri7wh2u1QvTCfLycbk/1ju+x
	ajZUi+DI+9QXGPmjnZai2RycpMRno86K2BD831RHcGf053+X5JOg5RpGxts6PZ6Z
	xu5cijeTbz0hjRNM7fUWPfXLkfkTYx0GNGqL1zUoVOsmSuDNf6Xqx19FwnKaWDlW
	By+ikKR9+6Zpb2Ywlk7xdfavkIPqaqL+D4ExOPhyXKs18t2uS9VhCDRgkQ1/cb5E
	cx++IYX/U5CV59/Hn+FzZoXs5mII2eFo7ilbxZ9H1l/sIyQhIYBtPOr41x0I0nq2
	1vl5EvmySPqdN31qooF3FoeJ0ZQ2f4sLUvA==
X-ME-Sender: <xms:fkbqZ7EhijLZulTazdfbv4sfQ6B8bczDLTil0EnAZoXp-NOYFSRadw>
    <xme:fkbqZ4V6N3QTShin3-rD7dYOpINc-AbPCqkBeZ0D-J19D8zjfthGYh-JqDw76_zf-
    J9NfdWwMKR87Nci5A>
X-ME-Received: <xmr:fkbqZ9IAr5OD6rn5aauRK9KsdgAfQwiRPalg70q0zn4iIti5Mr0xvXln7getHNdzqI00cWqJhPD2AY_z2mIupbEBfpk8kd7jP227p1QtYOBRVpvv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fkbqZ5Fxuz4lrRufCCUYnmUVHRMDAsQpt9fIVmdZZtsDHwhLF6uN9Q>
    <xmx:fkbqZxVlx8m-8n0xsRhPmzuRZ4d8lCEDrlhu4WS5nF46VubJL6fHxQ>
    <xmx:fkbqZ0OE-fTVwlkV0HfVOQ69n1c0pW8eJ8pka2omWeBmZ2F0Hub-tg>
    <xmx:fkbqZw0Uc_XSkdeToNAnmUj2KVebW3ws3hbjfbe_HjdO65m2Id4cYg>
    <xmx:fkbqZ0QPpy1kq5pwZA6lU7jCEeni4E1XnPZrqSoLAOWKjzLBtijbiW6r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 03:38:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c213296 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 07:38:36 +0000 (UTC)
Date: Mon, 31 Mar 2025 09:38:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [GSoC PATCH v3] userdiff: add builtin driver for INI files
Message-ID: <Z-pGdyh0eG3xSe4W@pks.im>
References: <20250331031309.94682-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331031309.94682-1-lucasseikioshiro@gmail.com>

On Mon, Mar 31, 2025 at 12:13:09AM -0300, Lucas Seiki Oshiro wrote:
> Add a new builtin driver for generic INI files (e. g. the gitconfig
> files), where:
> 
> - the funcname regular expression matches section names, i. e. any
>   string between brackets at the beginning of the line, with or without
>   indentation;
> 
> - word_regex matches any word with one or more non-whitespace
>   characters without checking if it is a valid variable name or value.
> 
> Also add tests for the new userdiff driver. These files define sections
> and subsections, with and without indentation.
> 
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>

This commit message reads quite nicely now. The changes also look
sensible to me. Thanks, I've got nothing else to add!

Patrick
