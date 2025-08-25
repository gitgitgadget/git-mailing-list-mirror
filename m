Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D1221723
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153305; cv=none; b=GOAL3HHVAOqjmT6K3K2K+oGzPIXDIwYLBasbXmTZTg+QbufJpIsCUGPj2J7B/7sJqSkLqzQcFtu5D5L1GtzUk6b0KVEG9wZsSPa/D/bK2W8KKXnVaZLje93lNOpw3EtzQBkZDSKZPp83A0LefTUHDrd1R7Q4UEYTwdzxG8H+nD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153305; c=relaxed/simple;
	bh=XmsWc+f5fvAv3tIODTnRQQPmKsUmd7xqLxg6EYyb6QY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qzOlXPeiHRmASGFfnzCzf3ypMKFE3xmTLAxNJGtD1LgiqyWLfE9NqUk18cyGzOpQ/wGLkUf3baUoiiKGwVLMyuKgWzZ0CTD9Tc3Jf9zM4shVuJwe8f1czRS7xEJSBEMCgXDyGnh2OQZ21u/BH8EuSvPYyUQL7fBi7nEhHhAfki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=clEhFhAd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoeGm81w; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="clEhFhAd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoeGm81w"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C65E7EC0407;
	Mon, 25 Aug 2025 16:21:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 25 Aug 2025 16:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756153301;
	 x=1756239701; bh=5mTQc2I+qG2xowXK/q0IxfPyE6iJON6qbBY1Sp4p8Mk=; b=
	clEhFhAdRn9v95KAb0MTtY/gwKqNj9EG7Iz/6vsyaL+pU/kvTxuKHjXXF0vsS7II
	OPrkhJbUR1fGXXKkk4qm7LTOdIAKqBINEGCLoOaMfV6NY6uAdM/VoJq5Tdo+hwSK
	CyMzSEJbmFSzkWrxCQ3bFW0GBbxuTUN6Tm0bqc/QmzMEelCneNF2TXZXszla3aEG
	trsLZwUW/QMtKM4kmnHO7byd3ELJnvgzG8xgWMmKMFGVwYEVMW+jhIYhSfO0223Z
	skOEbpcHG5y7x3Uvb1MWjLOKVcjm6UIx9IbFPwA0A0tGrs0z2NTgKhv8GcV2me8p
	sScykYP70sxH/yvrknjL7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756153301; x=
	1756239701; bh=5mTQc2I+qG2xowXK/q0IxfPyE6iJON6qbBY1Sp4p8Mk=; b=H
	oeGm81wCrbMrQo3dYdEbXXDXJGSkvK9uKkkO/zgCrPhu7CbFPx5LWxEdF8C5NLnd
	cf7FJ+g8D0ABsfrgmIofyOV54yOvolvKPLDyDbV9qi+bl/eXxC2Y4LO5r1qu9/Ui
	/YtrzWqVXmcBMkB3YIXABoMmyPQvxsszeAVn43vBZ7eJ0ulO+YZFV/xx3V3zUg5c
	Aa+HsX25atWjVYEscXEW8CpxIZIZnJ46cQSJtyBMHk6CMefGVR/BVMbyrL6LEYym
	M6wyP5lNqq5aOXLNKwASkGYzhY2aChlpuIrSaLIYtiyCO/l3Dg0QTxuKNiAt0Y+5
	fNtVsOWvmZ3A5JmWVjOWw==
X-ME-Sender: <xms:1cWsaJRZiBvbiot_5AUPb1ag7x_wqtf-Ny7Cg7ohfpWkyF7eab3RUg>
    <xme:1cWsaOSuC8mGMw_DTtN03OyJDOL3dimDcUrGMvlIYFHZJQx-doiXeLVBCQIPOKmer
    T5dS8oDRKK8kE7JkA>
X-ME-Received: <xmr:1cWsaFR565Bh3jlaUcv7M3NOKHk1geq1i43dB_coG01GoqPzI0KQlodtQHZNzYZsV4PwK2PanUQ5ohMRUQn4EubJhTEYcIUgDyOl-P8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtg
    hpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1cWsaL7dySnn0n1VtOB83PIBdkJuASBezfSBWVwFLJ73vEqQbxwdUw>
    <xmx:1cWsaJ13UFsLUEGko-0XDS9V7-AqW8Ioh1oKCCR1Am9tGX6igDFE1g>
    <xmx:1cWsaOBDr-1eg1RkotvlSuVg2-AeRFv3FQEtSXtUL7qZxbqUR6HhHQ>
    <xmx:1cWsaMNnjHQyjlkwKYgUrjahoTbfTFgPRcHSgJRaQDcx8MvPI5Q32g>
    <xmx:1cWsaBr1oP4pPgopg58j-VlvX6MY2-8o8nQ5vrVAkmTAtRLHayXrW5xT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 16:21:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] doc: config: replace backtick with apostrophe for
 possessive
In-Reply-To: <3ec6a00e3046166c7adb593f38c4099921d8ada3.1756064760.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 24 Aug 2025
	21:46:51 +0200")
References: <3ec6a00e3046166c7adb593f38c4099921d8ada3.1756064760.git.code@khaugsbakk.name>
Date: Mon, 25 Aug 2025 13:21:39 -0700
Message-ID: <xmqqwm6rp2y4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Revert back to “Git's” which was used before d30c5cc4592 (doc: convert
> git-mergetool options to new synopsis style, 2025-05-25) accidentally
> changed it.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
> diff --git a/Documentation/config/mergetool.adoc b/Documentation/config/mergetool.adoc
> index 6be506145c1..7064f5a462c 100644
> --- a/Documentation/config/mergetool.adoc
> +++ b/Documentation/config/mergetool.adoc
> @@ -65,7 +65,7 @@ endif::[]
>  	During a merge, Git will automatically resolve as many conflicts as
>  	possible and write the `$MERGED` file containing conflict markers around
>  	any conflicts that it cannot resolve; `$LOCAL` and `$REMOTE` normally
> -	are the versions of the file from before Git`s conflict
> +	are the versions of the file from before Git's conflict
>  	resolution. This flag causes `$LOCAL` and `$REMOTE` to be overwritten so
>  	that only the unresolved conflicts are presented to the merge tool. Can
>  	be configured per-tool via the `mergetool.<tool>.hideResolved`

Obviously correct.  Thanks.
