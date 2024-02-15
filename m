Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5552E132461
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029798; cv=none; b=PaiAiGWPNKpPYETdqobROQvdoJDTYseqpyeLvF6sAtYiehOcxwwuvXRK6R+22OZPF13Gw92nFJarYTWN9UpnUsJOBNWVJfFQGvYoGXevLjSsNxUVZ3RBK3C1vOove+0BCaH7fKVT+Gt77+fsa21CDuheNZoyEjeHOzDld7ydoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029798; c=relaxed/simple;
	bh=Ak8u92AJ1Oyla/e/fnT3j+utcLu2gxL0ZZVLlsPC7s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsM2D3I5L+QJoGllZVp3PWJi4i9PowE6bU7haVyCFnVm/q8z3DwZ5XHDwwlFhdzX1XTVmRQZVCMKxQNp2mpDS4qV2IhgqVAY63JvF3GHpva/oJP+kHI7Zqi/XdAlTM1PcN75AQaF8kshjt5a3rrKtcym6fHzVgRE5NLJEGz38Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu; spf=pass smtp.mailfrom=u92.eu; dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b=WpW37juD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z0hCBqq4; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u92.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b="WpW37juD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z0hCBqq4"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 3EA3332009F4;
	Thu, 15 Feb 2024 15:43:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Feb 2024 15:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1708029794; x=1708116194; bh=Ak8u92AJ1O
	yla/e/fnT3j+utcLu2gxL0ZZVLlsPC7s0=; b=WpW37juDA5mnUecy6WOx1Lf59v
	ckGoj1yUHVjb1U/J1HQNP+d+lmOZkHfjNjTcVjA93I2PbIFdYM5wT+QZT/iIizLa
	iAVV90w19EGRC5Z/AeMYqYYXoRjkrJhX93aWn0o8S33VW74jepDRj6512IRtLT2V
	h905jps4H/d3co+BybzANTn9AoNCzjIXPchLxiXO3QJERuOp56wJvhoddCJ06dDh
	HNwe7kP6nZZVeCTGuTO36sJlKuAJZf4rC82WwB5BUuvP2jVo13yJHDGG4DyUSfSh
	DqovqBu4tefbQiDmg94kXvPkID5+jcVuXLzdb2j6Bgrln3CBMGKhiv7Sw27A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708029794; x=1708116194; bh=Ak8u92AJ1Oyla/e/fnT3j+utcLu2
	gxL0ZZVLlsPC7s0=; b=Z0hCBqq4bFtcD5i4UUsZAt7pHM4kPkLvA7/F9re5C13W
	9cnFNZpjYKZYrf96yy7c70xA8BgD2tqL2Elo5fsCvD1CT/FuUfOa3T8PUDvGJ/T/
	z0RZ8sO14UC0FAxNdd8j9a1xLodMBIXSc7DIthDJMXcyhIDidcg6dxp6vsVIUOSy
	qrEQwQck/99pz7nJTHc/DKm+F3QecUJwLSV1tX1+Yo+HVZQm7jGTnYqgQowWISn8
	S2YVChYNIvi7Yhh1V1K1fmrfLWk5FVoBHYPq6sDOou5+TGsgFKHpr3PtqhZIDRlz
	W6tgyV0cLYlMrCGHi0nTFKqv7xxagMKEfaAEaTxGSQ==
X-ME-Sender: <xms:YnfOZcgXuFo0OnFw-31IHn0udejcLwDYmFaiR8Vuh_ML3MuJmW4vyw>
    <xme:YnfOZVDsFapqHP7vEUlUJwOVNX6me69iRMGSsndDZbAd9TGnAt5rhCnsUtg_GIhXv
    k_WGxStpR6VTzPYfA>
X-ME-Received: <xmr:YnfOZUHWxU5K63G3Dtn2YIJXKfZHSiATgkF5QJhUDo1BsnLRRDAwUuuh37vzLTpl6eQ5ADp7Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepffehveetfeejveeikeehueejieevgfeuvdeifeelueeigfdttdelleehveel
    vdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:YnfOZdQLim8pJVkXVEJEhrbycjcBvNHShM7iIX6Do1BOxsPetQc8vQ>
    <xmx:YnfOZZxFG4B6FRXRsfRv_hfIx5_m62Zmvp4khtAeFY3mflnPVndVug>
    <xmx:YnfOZb5n3QD7kgUwvW6vd66Andj4UHDO72un8VDGH11AgxTWlL8ksQ>
    <xmx:YnfOZXYaRYYfTu59VuN0m8Wp4VI8sZqKP-0AmOduDb-fVC206tPwNA>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 15:43:13 -0500 (EST)
Date: Thu, 15 Feb 2024 21:43:10 +0100
From: Fernando Ramos <greenfoo@u92.eu>
To: Kipras Melnikovas <kipras@kipras.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] mergetools: vimdiff: use correct tool's name when
 reading mergetool config
Message-ID: <Zc53XnK1TJVQNjOK@zacax395.localdomain>
References: <20240215083917.98218-2-kipras@kipras.org>
 <20240215142002.36870-1-kipras@kipras.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240215142002.36870-1-kipras@kipras.org>

On 24/02/15 04:20PM, Kipras Melnikovas wrote:
> The /mergetools/vimdiff script, which handles both vimdiff, nvimdiff
> and gvimdiff mergetools (the latter 2 simply source the vimdiff script), has a
> function merge_cmd() which read the layout variable from git config, and it
> would always read the value of mergetool.**vimdiff**.layout, instead of the
> mergetool being currently used (vimdiff or nvimdiff or gvimdiff).

You are 100% right. I completely overlooked this detail in the original
implementation.

Thanks for the fix!

