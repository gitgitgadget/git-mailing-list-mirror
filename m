Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABA18A95A
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 06:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775354; cv=none; b=WvHbuxpwkk+oefCld7dTbLUYEtfA51H3Ex/p/pdrg50gdc41DY6UxdCoNMAZcu9Y8Se0szd4+u81hOxbx9+i45EUfnrGrROlhBoe7MeDmO7aPoX/XmRvGEMXFTeAjH/3j8eLbvjKsEdbu/S44hhBC4ewOBB2m1FNvM5l6DlP/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775354; c=relaxed/simple;
	bh=LJlo4JuaVfYzNk5NGGuMQEQ4gl1Eja3vyvoytX249vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1/cWUZ8MgDzRbo5ML3MNAOAdgimUfu3JY0v316B0DAjXeQqVQHZ5x6WAAZBTQVC9gtd6v2UoQTdWVpPB6pvhwH1DrdcjdhNchEm4eYDNe+Y4f9V9ykKhLSowCGC0qA/pd+26mlwM6ZYdNviQ8bqZ+xpPQUxB3uLMKJWCg4Xxnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mIaEaTEq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SShC+Xww; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mIaEaTEq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SShC+Xww"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 25FE4114011B;
	Mon, 17 Feb 2025 01:55:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 17 Feb 2025 01:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739775350; x=1739861750; bh=yhXtjUoDVa
	h7zeFc9KscHNEA15mNwV8Ng3XyIYeXNnE=; b=mIaEaTEqoapLy16bW6qgjhzWMF
	jotKV59KIA1BaUfAzTRXL7QXK4+BDjUYqvsfSBKOmtiHW+N5Db8AS4fsOCBhCWiL
	KuXBGtZvcCiTq6oau2Lt0S5OFMY4uRNEBSnYLPm3ic7fx4ZZuLKvHmJZjOkmlKo4
	I+OhOjyMkmcODfH8zhYgtTbXWpCbQQOI6mC7fG5axqAs+MZicIDyl9SHc7OWrUE/
	C8VFdAnX6I0fjPPK5AaG+z3/KREMzWZu8QQLJVYV6XlGGzZEoXMCG6s87tXkzxaw
	kY+lwxXqo4iGc9FWmT8WY2ywE4mJ1pXJuWcx0qDEvmgwFtrCTHjiTdGePLxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739775350; x=1739861750; bh=yhXtjUoDVah7zeFc9KscHNEA15mNwV8Ng3X
	yIYeXNnE=; b=SShC+XwwCw/MBy/zrHQkXk2QAUFR9J2gTYaF06xxj5dhiUtXEjm
	3pYCioWwWvMdUCymasrWr8CXsTPJ/qmpPI9S/V7kDSwZ2gU5eEU07/7GjSsEyhlm
	0m2X32SQ3qX/P03AsIEpaipr9k2Cq3z2W3gaqrpw+zUBOKHwY+vCSz93Llfsq5i6
	UnKZhzvlk5IvbZhOKECobYgY+YGfNkZfuP2Rq9vCoaGjXagPQO3ZFT55qcJf9x6t
	dVrCHHpsb5GOXxOPUqS3vCoAOW9C9I5sCdFELvhTXYczoEN8EWnco0uB15iueTCx
	KSBMzXVCoxsynTC/IsAptMnW13+rlT9cEeQ==
X-ME-Sender: <xms:dt2yZy98GzbL4TVbCP_RVF_Pd__Npzk1CPTcvlRnpucc0tNQoVo3Ew>
    <xme:dt2yZys2kEDebrTyGWKOD5XMgx8CB3xZUmnuEupW2XnUFNxfJxFMaXFj7q_UWZ-Dw
    mYyIhFBPWO7rAVImQ>
X-ME-Received: <xmr:dt2yZ4AKFj9BMV3AdAL6Jw_k2Yh48vnTIrrFu4wqNjGrGzAZgIQM6DVPhAaeSATSVDpGg6A3E-PxoGgl5M6UvbktJT6t_79i2bxkrR2mwLWGnh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehjeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehu
    shhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopegthh
    hrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoheptghhrhhishht
    ihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dt2yZ6fktJwNTl1pbHvpwAxCpYf8vSjS0FiW-kjuAd6uwYBaZfQiTA>
    <xmx:dt2yZ3MpqxbzI3w_mvwOJ-J9BrIIBG76kfqWeDeoc5JwrbWIY2iPVw>
    <xmx:dt2yZ0mUCN_G15VgfgRXD6rhzReSu4G0b1XhhV52_WBZ_RjPSVhAww>
    <xmx:dt2yZ5tKyh_7D_oeke0F4gIx49WXTH9MLLv9nJDphI0Fz2bIMQBMAw>
    <xmx:dt2yZzBLrISPuSHV3hCgHpuFj3W1FrjXQWTSn1b0qepmCTXr3H8ybpzo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 01:55:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed6a0d1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 06:55:46 +0000 (UTC)
Date: Mon, 17 Feb 2025 07:55:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org,
	christian.couder@gmail.com, johncai86@gmail.com,
	shejialuo@gmail.com
Subject: Re: [PATCH 1/7] builtin/verify-tag: stop using `the_repository`
Message-ID: <Z7LdauBUSfqvyvXv@pks.im>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250214230210.1460111-2-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214230210.1460111-2-usmanakinyemi202@gmail.com>

On Sat, Feb 15, 2025 at 04:27:17AM +0530, Usman Akinyemi wrote:
> @@ -35,7 +34,8 @@ int cmd_verify_tag(int argc,
>  		OPT_END()
>  	};
>  
> -	git_config(git_default_config, NULL);
> +	if (repo)
> +		repo_config(repo, git_default_config, NULL);
>  

I recently noticed that we have `usage_with_options_if_asked()`. Should
we use that function rather than making the call to `git_config()`
conditional? Otherwise it's not obvious why we have the conditional in
the first place.

The same comment also applies to subsequent commits.

Patrick
