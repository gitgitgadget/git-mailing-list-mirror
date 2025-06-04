Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80406238152
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023318; cv=none; b=Jvl6TRycp5nNKr2ochCYLtnclterhsVLnJT+uBTGAYvqrtUiSUnvdbxbtC3qVuxCBAa10LkLasB2dU2o2CPy/+gpggQhkuZjthOFTkPJJS1AHKxIYk7sr0RtmeNldDzNMOhJJKFbfoC7l1W7QwCxG364V9DP5bxJWDEC5K410U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023318; c=relaxed/simple;
	bh=lCajCNn9oAaR4rBse0zW+g/Ghj1+UwAcE3JGUBEIctE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heDirrldcZRzCoM2PK4GSKQ7NB3vZFNe9D2sAlXAds3HTyAWfd+qBimUPlleVaZVubv0Iha+cMPCncqd+YGgZE9+Nslw2+2XkgzdEfp/6kTofKiggTV5wCwipxT0pNfRlZ5yOigGAg/fCBLljklhmNAf+LiG1rZpiXdyFXy6Yq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A5liYNia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXcICkxB; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A5liYNia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXcICkxB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 74AF7138041E;
	Wed,  4 Jun 2025 03:48:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 04 Jun 2025 03:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749023314; x=1749109714; bh=UQp1zvBT8S
	UOGnG3TRzN25jCXfP0iP7rs487Y5gqqEw=; b=A5liYNia6cwC96uKeiWUvnb8MB
	7uT0Y3s7XMmT/3x7IuluDBdfzY7SXhGwPJrD6U89ScAFDR/j/YOrFdZBraqrz1u4
	EwzFdXaZpbDV55BOHbOPC4Nb/z0barmjNK7hhgJxa0UiaofmTGlGExb+loi4NfT6
	TKb+zpnHu7xA96NpHSMNBwRoCEeR91T3EykRgTDPIEEY4IPskgQb0wVRSCD/21SY
	YgIdmY9scwN8klgZHXlYRdMTdkWdggw+FIvMy8FOrodIqipTcbnqsdlE2EGpK27k
	hgLfnqlQ2XnXOOh9PX+RqIftmU4JYGi2Kzr6pwurci5bXT5Lp+tJY9n+EOag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749023314; x=1749109714; bh=UQp1zvBT8SUOGnG3TRzN25jCXfP0iP7rs48
	7Y5gqqEw=; b=cXcICkxBW7Te1gr85CGcdEqDncoCPfvhVJonXMSgvVIlQMDfteB
	htHA5YBbKdvjvRgug7gcNpy9oSkE7gMspTLLI7zZpnqtheRjHxOLHatuFTzJ9hgS
	QETTIWbnoUY3pLpqkrfd5pJTMULyrxK1WtjSUKZ3wGPL9JSv50TF/XC7vakkGdxq
	E+zvaqcUpKK/QWM4PUee4XG3N1j1c1YwkVa46A2hIC493vPKtL///6VygRLuKYmY
	My0bx2+Qp0Rer0BsfvWi7FTFJMV7WBaqSALoxjUJP9RF3/R9ifraIpmIKbzJ3NY0
	fjTXck/tid1I2NqG9hevXz6MFPoAttLm3aw==
X-ME-Sender: <xms:Uvo_aD9KP5mzomjM0QZ2O0-soVdIfvlEBAs0Jj0Bp51wCTQtTf4Jlw>
    <xme:Uvo_aPtSsXi097YzS4ZIZRHCrEqivENJAB4FnNbnUS51mFqKUfBVFoZBaaVlK6yhg
    aSXXd9S4NysbwqYzQ>
X-ME-Received: <xmr:Uvo_aBAv0tSIXEdJaIzcoXtnHCbtf_FkA7jyR0V_z2ZxHGMKcoWqF8uyKS1Bt7nBnaeZWmIp4J3IwnLePrn5k1mOTkcF_Z247KPZF_q-Ujs9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghn
X-ME-Proxy: <xmx:Uvo_aPfVafuypZast8yaZ9dB4JJopSRB7Llf6YNpt2O2FWeUfsvSlA>
    <xmx:Uvo_aIPIQ9Arl9SM8hOkWJ1462FuA_LzN_y4cKvFWpA7j8VkNHmQ2g>
    <xmx:Uvo_aBmurIZpMZhtq4ymTQ-zu2KTxKHRBH9yf49kGuTn5FKp5DiG2w>
    <xmx:Uvo_aCsomhvTcpoQ3k-UXhlwJG4xo0qqtOFsR5O36rnpIzM6LIOCWA>
    <xmx:Uvo_aHYmafy-WvUH1NE6G37R-9TNZYayjwHIJQWVbBvQRkzH5Gzri62o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 03:48:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6ebd745 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 4 Jun 2025 07:48:32 +0000 (UTC)
Date: Wed, 4 Jun 2025 09:48:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] revision: fix memory leak in prepare_show_merge()
Message-ID: <aD_6T0lUOsqrb5sH@pks.im>
References: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>

On Wed, Jun 04, 2025 at 03:08:56AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> In revision.c:prepare_show_merge(), we allocated an array in prune
> but forget to free it. Since parse_pathspec is not responsible to
> free prune, we should add `free(prune)` in the end of prepare_show_merge().

That is a rather obvious memory leak indeed. Do you know why we never
detected the leak in our CI? Is this code path not exercised at all by
our tests?

Patrick
