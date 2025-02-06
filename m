Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134F21CFF7
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847093; cv=none; b=TyIUkP33zwYBfeV/a9Vgw0QQr3gfKSOMepGLNBOp+3noYCHLW+9zGjmEcEKfvANy/XtqStJCyNWrULV82K6YW4jAfZZO7vUm3cVzSgMeNH6PeXvSUPw6UyAVu1+gxGxcXE2kVU2/E0ncDjdfEOOoDOWzFpJpE9NI7noyzRoIXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847093; c=relaxed/simple;
	bh=mZWVG2NM+wqWCaGslbgRDpaJNVZ8s3EOLHUSe9SAWr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q729pc+7lPidKWOA9rALOOls/CwUfbTbLgXnpPyX/56IXWsrD/a5lpuvLru89PVpxSQ0lQ7LXErMDoB7c9FBgX5gieHLdjtidbVlM4Zo3Vs9QG45P0rovZU9JuYWtLrMgzwWiJ2Z4AoTVUF2Hi0cb90R2aF97feD5HIsOTZPdic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RGdGiOdb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f3w1rokF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RGdGiOdb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f3w1rokF"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BC04011400F7;
	Thu,  6 Feb 2025 08:04:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 06 Feb 2025 08:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738847089; x=1738933489; bh=mZWVG2NM+w
	qWCaGslbgRDpaJNVZ8s3EOLHUSe9SAWr8=; b=RGdGiOdbUmn4J3KAxMfHQQQ4+A
	GH2SoP9qODLQmoMCHOpwhJYQx3oTMFhRoyL+WVm9onE9Wc2KLpHL1ZGe+75DOZAY
	H84Lm1+IVwJKCaJBdSQdrjy04m+pl8hiUePbyLQxhAS5JNqXhNKHhgTD65q/no1w
	iLgGgoqofd88JodZjOWhEkOICC984hk8ca3tAQMIYPqW+pLbMz3nLXuokUp1kxA4
	cfKFGWurVt3o3xDmYqdwfD1AZ0vcjo7kcyXvWK4cQyLKlm7/9aWjwS+ajz2AjtvD
	+QHi8hrRsF671O1BOkW4e66Ih5WMty9ovlMnr9ZrtqDTQF/jORgRpsg10QMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738847089; x=1738933489; bh=mZWVG2NM+wqWCaGslbgRDpaJNVZ8s3EOLHU
	Se9SAWr8=; b=f3w1rokFhHGWXzhK3bmniBdj5QsgrDpSVdlF86fywqyB+6ddxnI
	vt7CJKqG7y9369WLNRwuDizP4Qbfx8a/uiC/KzD6FVHOT2oZZOQROaZt++cYcIms
	sFCLun5OR9JQPMsKKadwIALHLDZonNZpacuCeAO28koyphOf6gdBtQSOyLhDzxL4
	/7brXHfpnZg1mFDBoW1o9MPmhPxT480zh52tY8JVeJi1BTeatGs73mnx1cDDim8/
	0E6ACOvSBV1gZFOnYDCf/lZ4SBJ41pUisVzGxsrqZc5WX//f3PjRrj6Mt1uLw0IS
	xzRTb+F+6FqoMIQRPiZbUy+KwpFrJQBUJDQ==
X-ME-Sender: <xms:cbOkZ8z1JLz6DRVxnFF2d8QPT7M0-Y4MZZFY8ApKQ69wqGf4_-RQbg>
    <xme:cbOkZwQMmBjfj7YAw_CH9U7PAJnpL4EEaTiQJoKpWP3NXFgv9fVze2bu3Jw2utOJh
    VHIPVhB4NF9PkKJww>
X-ME-Received: <xmr:cbOkZ-UNmZYzt0GG7Ic4qPtxyZbh8um5N0gCLL14U0iBluOf3XKrNbFiwDr5mfHc45h14kWyzGYeU-I5oz7Vhv9_xankmbsMwnT3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehilhhlihgrrdgsoh
    gshihrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:cbOkZ6gUpktt-EUpEAHUwEm_NkrC_yLgiVelUy7u4EbAndCH1nhxHw>
    <xmx:cbOkZ-B_aWPJsgCb8-9Q3iVwGJFOzE2CSRkBukDGBcMC8IghwAeX5g>
    <xmx:cbOkZ7JONcCpex-BDQOIrV3WTbCRZoJiGiPZ_6MNIx7BVUau8g-nrA>
    <xmx:cbOkZ1D_GxYm4TJVJaVGPvpWxrlh7T_FXMrjyTYFDQv63eDB5ykbXw>
    <xmx:cbOkZ17l6amnxKuxQWG6K2uZgpGath6_UCx0U8f8PQIZrbsfgPvkEqWL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 08:04:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: Jeff King <peff@peff.net>,  Johannes Sixt <j6t@kdbg.org>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Long names for `git log -S` and `git log -G`
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com> (Illia Bobyr's
	message of "Wed, 5 Feb 2025 17:43:15 -0800")
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Date: Thu, 06 Feb 2025 05:04:47 -0800
Message-ID: <xmqq4j17kyvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Illia Bobyr <illia.bobyr@gmail.com> writes:

> Same as PATCH v2[1], but removed gitk changes, as suggested by Johannes Sixt.
>
> I'll send a separate patch for gitk, should this patch be accepted.
> Or, I could include gitk changes into this chain, but just as a separate patch?

They are technically separate codebases so the changes to the core
would become prerequisite for the same changes to gitk, so from that
point of view the former may be more kosher, but I would expect that
the latter is fine in practice.
