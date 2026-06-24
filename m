Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF70128816
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301631; cv=none; b=c1OAQUWjVpX3gyFNXdFKpUyYhIGq0PEHJ3AX+CIobQFuhqW/4+3alK25hgndwyRCli2r0J9SVdC3iN9F5mPri6xtBDqtoljGc5QHn2Vu6OM4YD4bkg3OZf4yzbCtGvbZVwAtEpQoivH9kJ4KSYs61zlbdYKZ/QmvCrYuf2WX7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301631; c=relaxed/simple;
	bh=CTu4k3mz334Viiu0MninfoTnCkn5k0vhwhVpbG9abhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=py5JRc8Hq9OhlWL3Ctes6zexRIK/SCfXhen2jCYB/HTkeDCWtEaoKcvwZUMi2WxPpm78OC+Qfxqeuah6mOm1XFiq1HOW8gD3ck+ciomyqiR/JhvwwgBhWcSIyfSQSi0M7XKt0gacYX3uFdT/nuoVzr1cXJ7ukzOGyPVCxuDFiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IwE9MpDP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lT2j+7gw; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IwE9MpDP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lT2j+7gw"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CE4A7A0104;
	Wed, 24 Jun 2026 07:47:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 24 Jun 2026 07:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782301629; x=1782388029; bh=3LtnSszgVj
	i2vkcanRTh2FL6sP4DGnQgql3AF/by4RY=; b=IwE9MpDPFXrROZRdieL7ZJ56/P
	4o/0G7Dmon6mwQiaB5Aqgg+SeCedUuqTuTYt3lQeSsIh0iVzqIsW2qLvF5M7GlzH
	jubsKy4YieLC1U/kGVjir+TVz9XWIDB3zFx9Co4n08W02or9Mk31Vqkrnq/8wo85
	JUDmIKZtnGUX/9W7Op/Zup/kF8bXiIkj4OZrvAynOyp6Hhn7P3KTY2/K3Tjo1UEy
	I2pghhBLAvZKLwpU1af8X7ZN4Sfo0/5nLI/KBcBhE9f0w87Ci87yQ4weBcCPLc30
	JsEW6H/sn2+YzXcupuKIKctlIIAobh4WF0iDdmsDtyT9uPOSsPNTyRpVaXVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782301629; x=1782388029; bh=3LtnSszgVji2vkcanRTh2FL6sP4DGnQgql3
	AF/by4RY=; b=lT2j+7gwd92q4DpmuzxAEmIe6UrL9LUiKsIssM6bLAdVLpYXMja
	AUW6CIWduphz15SSdDuzBvjiuy8NQlXeVhdYzMglbcz6krO0+7HNhXEaiCKGe8GM
	yHTP7foP/UB8t4mr0wA87E6IYluB2FcNe8s5hwQ1pVLM1AfMChv62h2k7rWcDDZN
	33IqFrHB/uszZxPvz2MrdYQon7SPwHjBj43oX4kj3Mi92le7LQzRMXEHEzVN1aG4
	6dIUZHCeRY932559VzhR1q+QVIO4Fg9fNPMTBYn4I7g7qiFaw/0vO1usb2yrXxrF
	TbFbKcEu38KgyGeOHCwGFp7PdJUZsBOOd3w==
X-ME-Sender: <xms:vcM7anKnSjSKLmeqfCdSURjIuk3a5zYJZKkdZ6jiLw85v0LD_Pk9pQ>
    <xme:vcM7aimvI0HG31Kfz_RMvuulA0PXrdQnJQ6lSyW8TO8rH9lVxdj5REtxUMEZPOEHu
    FUeKj8dOrLsoE_hT8EzSTpqotB64JOu2A1_OsONb325kLtYJyEJMg>
X-ME-Received: <xmr:vcM7atFy2gefeN2kvFoDZvgDcyx01an8bXKoS6bnPfJj4hNoiGjUc7_ZXHuXHuCZjCMUmErwCQlJXfLFF5OeCBi1-ievLDFDtLrjXTzr>
X-ME-Proxy-Cause: dmFkZTF3h79N4Qbz2Kx6KdBNFU8M9sdxIijigJ9uERzQuZTA8pO7mI53GosadT5kFezrPl
    m91JjMMlPCjE0lz8VxCHe5R0ZiPteuIuglUMgLW2LFm6tcDL4jURHCYeHuuv2QChhi288a
    Kx2ewxcy9OgRF7/NiZ3TUt+ZFZy5yMRJh0DsvciWDwCkudqs7pchq9Q6ZAHIHGScrFNuiU
    /3stS+E/xQLsJ6uQMuKO8t/lV+1tO5VwLlHrRcIrGtZUKJ6zYuO/LGG/3Rf+ctbPEiNdAl
    aylrRbVeIo0j/GnNo4y6ILh+avhV3fCDnzaNAAIDiO0Vs+w9e2hFw1NxR1xgR8suXvW1LU
    mvx9XiHJCx686+EmJW/TAqYg6lwz+e4NMZnEyTwmh3njRZUhksdCtv29Wp91O9mj5lPEES
    0O+NSzPknjgLn+MtS1wJ+HTU7gSEWYFFj1c8rdMRd3AMRQ18edc4Ts86/RU2DYDSjvVJNP
    XtTnZPUZrJBXbouC44l3KngUa7/qbYZneIYYcdKKB7895j0SbWFzO7Vpy/N6lglVD7Zped
    Cjz0YKNb+m4PGQ6cxhvgzv8junPcVpfi4Wd8DhCeNOitcHKQ6JaHMfet5aWoduuW2vyfxL
    1GWbdEe6N7PjbnoYRn+7rzandgn0rajkAYnmPtm3PQqPHOWs1a9/WHht9yDg
X-ME-Proxy: <xmx:vcM7aqEsoZogXVkjMeQqGpenf45FSPT7p8K1un2s3hUw770kUbFIMQ>
    <xmx:vcM7aiMihtHpd2LEA_fUEtBOJonvD3tkPf5GP3NQf36wtVrBGa_d1Q>
    <xmx:vcM7ahF8nZW7uI1dSybcOeJU23GSvdbFX9js7Y9ztaXk90mphVO8SQ>
    <xmx:vcM7ahMjBL3QiKTVv6n-61lx1WFOx5URxeizPIeJ71n_EDHgcH3-sQ>
    <xmx:vcM7ajOdxKABA_2JFHbVYx9JkoEN8bI4TYSpNr1mqR59-h80EcePYOnG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 07:47:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a81598dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 11:47:07 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:47:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Weijie Yuan <wy@wyuan.org>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 0/2] doc: clarify review replies and reroll timing
Message-ID: <ajvDuUiDsmyf5LnX@pks.im>
References: <cover.1781714757.git.wy@wyuan.org>
 <cover.1782028813.git.wy@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1782028813.git.wy@wyuan.org>

On Sun, Jun 21, 2026 at 04:04:36PM +0800, Weijie Yuan wrote:
> Changes in v3:
> 
>   - Reworked the substantial-rework case.  Instead of suggesting that
>     authors send a new version sooner, the text now advises authors not
>     to rush out an updated version before reviewing the larger changes
>     carefully.  It recommends replying to the review that prompted the
>     rewrite, saying that a substantial rework is planned, and pointing
>     out which parts of the current series will become obsolete.
> 
>   - Dropped the advice that a topic close to being accepted may justify
>     a quicker reroll.
> 
>   - Removed "how close the topic is to being accepted" from the short
>     reroll-timing guidance in Documentation/SubmittingPatches.
> 
>   - Updated the commit message of patch 2 accordingly.

I'm happy with this version, thanks!

Patrick
