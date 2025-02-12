Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E98205E20
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352228; cv=none; b=DmiFSHutOKOsTVXEnPFRes1gA9zJ0P2yQf8gpe2YCCyfPlrUA7rh7Uy9PMnkCBpKN1qmp3Q98UYUWNfuxW6p73XJNRr1ODbJ6c+iWoI/xaXSWj0735hvB7uUtykv8heSSo8G4ihxX5aL1QFWjW/EujHDS0wQjPKvVNOiCpiZB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352228; c=relaxed/simple;
	bh=wX9613btTBMOovvRD3ks13+DWA2GvDMGAKyD0L3tqjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKpqZKvgmsDS0WMaHYEKhoTlZvxD0RTYoaYlsvFH+mcP0z3CLG4VLb+2RZB/K7FW9Hxp4tAt/7u03zd9AMII9uiD/kAw8jX+pGv1+5XyET1aPKBNPBT47qMH7CciEfld/rpD4PZlggnbpAgCfkjdbFmYWLOnLwRi8kqCsIEB3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YI09cuAD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=byMreS7J; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YI09cuAD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="byMreS7J"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C732311400FD;
	Wed, 12 Feb 2025 04:23:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Feb 2025 04:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739352224; x=1739438624; bh=4KHOvF18Zh
	6nnUw0mhBVVFcy1JSRYiF/K83NYu/v7c0=; b=YI09cuADaoFjnBJhrYWbJR1abO
	60W9FcF8edxgpYuTSm6OA6Ac+0mwBM1qz1qov17pnuYDiErpYkj5POn+4rAy26e2
	fXcRyVEoRDhRk95AuiuB8tHwV2QJGd5In+TB6uVJjcBr4eooPu7GocaVj8Me/uaO
	ShMf9UNSoRtBKftSNA5s8WWP3leAZMl79qtalwp+tQqOh2TPKZ5x3v764Fv+mXM7
	QizOTC+iEf5XyCZLwgd6lRCU4ai+8w7nt2/n2nd3SAw1byj41BTlnR9/i8dZv9C4
	pQTgsxlkYV/bFhBxsqxr5c2e7k03BYiQvbMNICk1BVZLTT82ntSNE0zNgu5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739352224; x=1739438624; bh=4KHOvF18Zh6nnUw0mhBVVFcy1JSRYiF/K83
	NYu/v7c0=; b=byMreS7Jg8m6KMiiYK3pOC8r4GWIat/gPSCR//xm+S3PNm7uy2W
	M3PJkmOvJQQkJArMXgM9zKUqF5CcotL4Qn1UMRZSy05saOFhbC/JM2FuBTQ2qR05
	ptoPmH5wYjAAzUzq3MEVx/YZfj1nRArAy00UlKglKWnDKiLnYbVUXNlD/P2fNBa1
	dY/zeoFnYtbGtrCUXx2R8bkWmzAo19ehutsmW4NyAP5BzOfsG0FNcHu7STVpG0Cy
	oEPhxaeb/ZtL3xdvI/oSI5IRcveWK/7s8yvvE0NU/YAxHiGtfap2ix7sY4lhg31S
	RFgC5EkveBSLjWh2LeqQaddzjt5dQ5leitA==
X-ME-Sender: <xms:oGisZ-wZOlT7xYvK6LYgAMPYzDvg6jpRGzdcYu-dVy3A5NFr7OQirg>
    <xme:oGisZ6QtjeXWqzCP1gVollx_aqeCfBgi58f_P9iLY3RNftNbGAjrBlLa9gsck3CjM
    GRBr0gz371yf4DwYA>
X-ME-Received: <xmr:oGisZwUfrtbyQKz_Q_vcRb7JfyRCM9Bj-78WMXsrGT-X4Eh5jPlY-tNjyRSLlYLRF7EJ1rvjqC2jqcY5NIWVH_cYDPl3NCLw6sySmfY7ylY2vgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:oGisZ0gfgQu3GJcD8wrcJeY7EIycK-SPmeEQ1NE8wUXJnBvnaYcNSg>
    <xmx:oGisZwDGuGrBvFesJuphq3YDGBq_0bW0ndEVBJna6mHwQSDK1sv3Ug>
    <xmx:oGisZ1Lqdns4eszcu8xbgETM_hE05nTkkanRucvZyAFbdcFq1O8MlA>
    <xmx:oGisZ3ACXfoHJxyx3bR_5aQqYr0EUr3AN7upm1obx-E45B6dSk4bpQ>
    <xmx:oGisZzOIX3dsxn0S8_Zw_dpRUvEtdMz2nXvA3U2neZtifhQUG36XKCrZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 04:23:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5314742e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:23:41 +0000 (UTC)
Date: Wed, 12 Feb 2025 10:23:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 1/3] diff: return diff_filepair from diff queue helpers
Message-ID: <Z6xomFk_Sb18UMFo@pks.im>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212041825.2455031-2-jltobler@gmail.com>

On Tue, Feb 11, 2025 at 10:18:23PM -0600, Justin Tobler wrote:
> The `diff_addremove()` and `diff_change()` functions setup and queue
> diffs, but do not return the `diff_filepair` added to the queue. In a
> subsequent commit, modifications to `diff_filepair` need to take place
> in certain cases after being queued.
> 
> Split out the queuing operations into `diff_filepair_addremove()` and
> `diff_filepair_change()` which also return a handle to the queued
> `diff_filepair`.

One of the things that puzzled me a bit is that we keep the old-style
functions, where the only difference is the return value. Wouldn't it
make more sense to instead adapt these existing functions to reduce the
amount of duplication?

At the same time, while we're already at it, do we maybe also want to
adapt the functions so that they get the `diff_queue` as input instead
of relying on the global queue? That would make them more generally
useful and be a step into the right direction regarding libification. If
so, it would indeed make sense to also rename the function into e.g.
`diff_queue_addremove()`.

Patrick
