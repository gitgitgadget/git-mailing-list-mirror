Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F52DECD3
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422954; cv=none; b=AbMMgsm5gV1pbeK5m8j4Grt0VvUEFMJB3aDVpxxDOUskDzj1/P6u+9fz9gMOXp0ntl+Dq0l1Tjc9ZU8kjdqwo+uT4TmGAyLWbE7/Zbp7sh2y7LdnaswwgbZQRFRF4EBDeR+qVxYx12rSiaxN5kPvwI3LUYGnXEODAIrsADFgazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422954; c=relaxed/simple;
	bh=tOpxXhGh7/p6nwV7p4FbWybF1w+6gFNKmvmeI7oAEQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfiRn9B/7LmX2CI1B6zhLziaeS65S6/tcAr0rWeD7yzaVllL66rNORZcK3vVwigVOa8esrVPQBncygVFMnqoNRiz/hiDJesqh0nNsTKUyU9AhNKjE27t5JLyLbb4wubJBmLjifrTYC4vA4xXZMyXV7GR/Jvi+XDaAF/FWL8y8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kAJM0UEP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lXnDF99T; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kAJM0UEP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lXnDF99T"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 57BBC1400285;
	Wed, 25 Mar 2026 03:15:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 25 Mar 2026 03:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774422952; x=1774509352; bh=DIZTv8/TR4
	mfD5jrc30u3TMm93JXi0Z0QmH+mkYXGsY=; b=kAJM0UEPZSh8t7tSytfxvT30De
	gp6uKXQgK2NVhldvqU/oh00ZZ/J/UvVZOdS5X3DN8UYUOxqstMVXS8WKeVoUcbJJ
	+kENdjfmPaC87ScIaeAimljmDIUTH1XQDKQXsAquLZqaU+iqGALKgvVQGI5OpG+t
	WpLx9qSYD4VMX/8ff4NXXWFS6sIInbmtCbrTXPYxqS47md4DZj5AIH3NXqjMuOrc
	6jArx8c70MKDD0fLhX2fbgQgjyN3Wyjo49gqa8WoQ6a8QZU9vgy/Dr/1FA1DMN6X
	Oo1iOrr0ia9h4hElgGk7iPTv3OUQ87kel05+zb6EqMxuYDJz/84qFai0v5wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774422952; x=1774509352; bh=DIZTv8/TR4mfD5jrc30u3TMm93JXi0Z0QmH
	+mkYXGsY=; b=lXnDF99T+1lqhy7+ywvDqoG+2JJEeGZ3InPs4grmdberLvvLjj9
	dqcCURznQKxDtEUYP8ZJBStSyCj8/jMdI8ci79nO4FGVUjHJwaX+owq5PRSnC55f
	lYcoy1gq/Bco18zj0oGIk26JmVRDwPIBHhhtKUNQFQp64FFgpKVS0T0k7Btk/S4y
	twbdIoLugLzKaDqJuIeBgrVmebS/5QDjxDM2ipokldpmew5tbWqhhc8xmbzsq8KH
	fwdA+LFx0C1Tftfi0mt6li839VEwg3+4AhnCivvD4UVlBsKeOHB2N/9d6NGw5u0V
	qlPESdA+ACdBuDHnWrTTn8oYoXxUnaj5EnQ==
X-ME-Sender: <xms:qIvDadby6um-DE7cptIeWGmFJYVvpa-ZsXQyG45lp9xrkt2QeIbTmw>
    <xme:qIvDaaZIEflURiUh_VuwMPtrQTwwOtmb0-2aAPZmHfaP_wz2U3-IDZ6aGjJ0EKfdx
    -uY1SYQp_Qh7HHveJR7O9Rt3uQSOYK27mE2nvIRXZbO42xSdhBXTw>
X-ME-Received: <xmr:qIvDadkI8rS1M51ntAgScdA5gToyccF7D1NxGgRye2W3TUUuG_8D_yKTzXl8eNKbQAhLndiFGMYsfN2oAAEFWW2pxDSlIEITMeBepnQ1l9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qIvDaWwD5_yIfNvzadooHo1ZpBObSvxtLPdKnKrnKlXKYWMLV1r6bg>
    <xmx:qIvDabP6xfSdjkhGPtC4pJeTbVjS7UG50WdISBmeQy-PE20uLR9oyg>
    <xmx:qIvDaaR7JAxY4LnrA4N9yNKvmusB_z3dXkwmSyp6T_T7sN4AM62GSw>
    <xmx:qIvDaZavYgHSi1x7lQi7YBKB2P7TXnZZ7kGpU9HhAmMEJkT77rMmtQ>
    <xmx:qIvDaQwk0IxJLf0DekGcP0Ja2F6Lw5bOiyn5mt78mtww25VOef7RQea2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 03:15:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a65af825 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Mar 2026 07:15:50 +0000 (UTC)
Date: Wed, 25 Mar 2026 08:15:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/11] t7450: make test "set -e" clean
Message-ID: <acOLo9Jdw2VkwQpc@pks.im>
References: <20260325062114.2067946-1-gitster@pobox.com>
 <20260325062114.2067946-6-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325062114.2067946-6-gitster@pobox.com>

On Tue, Mar 24, 2026 at 11:21:08PM -0700, Junio C Hamano wrote:
> In order to catch mistakes like misspelling "test_expect_success",
> we would like to eventually be able to run our test suite with the
> "-e" option on.
> 
> Often we write "A && test_expect_success ..." and want it to mean
> "If and only if A holds true, this needs to be tested", but under
> "set -e", this will cause failure when A does not hold true.  We
> need to write "!A || test_expect_success ..." if we want to run the
> test conditionally.
> 
> Or write it properly with if/then/fi, perhaps like:
> 
> 	if ! A
> 	then
> 		test_expect_success ...
> 	fi

Yeah, that's what I have, mostly because I find it easier to reason
about.

Patrick
