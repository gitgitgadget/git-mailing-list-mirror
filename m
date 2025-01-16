Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978624A7C0
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022646; cv=none; b=n8yfuzPw93gZcGaP1FEPtMGOsfnxWApNeLGgO4UTlugvD6eFTVDLtrPogUkt4Voh0o2ckTNvBdfFI/dNk0+bPNqxilcf7RRIqznQXVvaxDJRKzcqWUTTnmbWyNb2GHN5mayqaNqkhNRy+r7zczDoaTWvTO88jiUlUvqUxKyBoQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022646; c=relaxed/simple;
	bh=+FQdXS2idznBeippQzhwLzmysUb9/sBgeLVj0rOv9cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmV7BfoSRp9wekk2vfy+f0y86Gucw/1vUcG505mNKPoUXZuLP/6NFlSDq+MuWutyp/VtkvpOIxt3gPL9oSuzqGvNl+74ehZBWLpHEJAg8Tf+uf+QBLTOECw08wJl/g0H9CGHVd7b/fDQqvFEij3uQAzm2NuY2PjUdX2MuW6dq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r2Iz1oX8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tunh/azk; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r2Iz1oX8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tunh/azk"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id F3C741140120;
	Thu, 16 Jan 2025 05:17:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 16 Jan 2025 05:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737022641;
	 x=1737109041; bh=+FQdXS2idznBeippQzhwLzmysUb9/sBgeLVj0rOv9cg=; b=
	r2Iz1oX8JH+7mYpjgxbd1j77ocg+pMEXgNKwPuHfjWxdS0B5Yg0upX9ebCCfomZB
	wA8i8F7RCkldGB6QpMg2Ya55ErIv9fNckO4o+xqH2d/s1Ozz+NBc9gsF3Gvjf2Vg
	fYWUIMyS1BtnzieKrFoSVXHmS7pnvfxNrsXoephId+7F8bJlAMPrvME5rxvq5Ap8
	rD8zrOIUNL7T6oeVb6YGthk2gR1+9TRR6nzdjeNuB2SOLzBkx/cm4tpIGRK9GGB1
	bkgXdiYJMMijxtVbHmx94zIwQX2Zmdx0HuY8p9FD590vOiAC/MTte2Ez69dTFvK9
	X7NQaWn0CFLaVUY2qAdCpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737022641; x=
	1737109041; bh=+FQdXS2idznBeippQzhwLzmysUb9/sBgeLVj0rOv9cg=; b=T
	unh/azkZa02E3gcyylRp30+/hnhB2up6lL8raZC57Fi9FDJgo4nF+PPAfeuN2GWB
	59/IHzjEJ32kqaiMuV9mEM1RdYGyFN9Rkudn8n2wP+J0/mae/3pVAtWQFe61Mfo7
	uaY76KUDmLlThpM2WSp4k9zmXqf2e2QJivdN+fKHfU1VIUaXWZTRAEooX2O3f162
	UunvURn/gg7Fo521aCCx5vW1BjUDsDGw+HO6EoV8DkdQJIcjs6XSxe8KFWZRY7M9
	ojKFKDt+fJSgOq29hNhvteHDNpaP1PIJOWRzXgUaya9mBrQTFZih+o+AVuTzOmyg
	sCLjbfkXaTiyukSM2yaVA==
X-ME-Sender: <xms:sdyIZ8k3uLPd0Y3QPrjZXHuwyb7XWEr33INXJPwtR0zxuKzzuZMH7w>
    <xme:sdyIZ71y0Argy0gPxsKQOf_aQGJmZpK0EtQiSE56lITiDvsNUySVYnTymDxnvVNHL
    mrNdr_J_rdGI1x8yg>
X-ME-Received: <xmr:sdyIZ6oAc4VrPUd-AlwoMv7ZPJWvn8Ln2Itj4Kbsq4cOtBW9772SjOxfzFvfbhkUi3sh02DoZ50UV0CtGOqLQQ0ZBqY0RqTENzWlL4cvpRQyVMxwNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sdyIZ4lwK3IPBr7-hxIUVrTjn0vYB4yLpmPqn-mfYczJUkUOrKBEfQ>
    <xmx:sdyIZ63EKWzX_jlMqhkcv6zSE08LCU2ZXcwcrg1n26z3XGENoHyCRA>
    <xmx:sdyIZ_vH3mrwD4ISqNlKQkITSRsA2Ae1_CobhtVXVVAvOSxlkVTspg>
    <xmx:sdyIZ2U5iCB4qm-yhqYVQwruAkynBOjHtZcyd-cmp2kSdbSPWuHaNQ>
    <xmx:sdyIZ_wR3NYNDsInLvHwtOksfloX8XqglXG6cQzca5B-8R3EPthIsuOf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 05:17:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fa243433 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 10:17:18 +0000 (UTC)
Date: Thu, 16 Jan 2025 11:17:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 5/5] doc: migrate git-commit manpage secondary files
 to new format
Message-ID: <Z4jcrX_tH0xfGKPh@pks.im>
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
 <pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
 <28316a709da913c624873291d96ed5aeddc6fc90.1736972628.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28316a709da913c624873291d96ed5aeddc6fc90.1736972628.git.gitgitgadget@gmail.com>

On Wed, Jan 15, 2025 at 08:23:48PM +0000, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

I would've liked to see a small description of what this does and also
provide a bit more context in the other commit messages instead of the
bulleted lists you have. They don't give the reader much of a sense of
the context we're operating in and why we think that those changes are
good.

Other than that the patch series looks fine to me. Thanks!

Patrick
