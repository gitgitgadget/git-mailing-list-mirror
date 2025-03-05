Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4F84D08
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159176; cv=none; b=madfpbiiaMoSSC1jvT7rkGLIBSURK1UOmHIIqg7Ixs37WwnJCAJKMxRSOYoY22OkrMBun17CAZuj7tDA9QgD9kwKzyg0bay8rKeD6kb/zTgg+PVZnLOSYDZFDbFjc92lu7IqLXu7Jv086Vt33NXlupPDbyeIaHeSE9uk6Vu0ntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159176; c=relaxed/simple;
	bh=uJEfDyJ7g7LsvaINuMOknJGFZlgiVFyL7qpB7AcLVQg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn6XXaiFNxk5Do+6KQIyTRd+pmoYqIii+uYwFyKIzliMryGsue1qtPzuHVc7lv14zEOmrFDUgIifVKcskDjBvPsaVjym34ppEAK5e4GsYaVJALlQ8rmcxcU9ehfyePK45NLClkIVK7DNL0x1Wl86INg7fEdp8nzhavpoSB61Vy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ChGqvE0J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iSe8f2/s; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ChGqvE0J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iSe8f2/s"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 995BD1140174;
	Wed,  5 Mar 2025 02:19:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 05 Mar 2025 02:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741159172; x=1741245572; bh=BaXAif/7wy
	2LqVMP1pQSHepELVFL7AYR1XRshp34UT4=; b=ChGqvE0JSP0OQ5JOJox91ZDU0l
	5QzDN9MpgTHZwqn6ifcMehEaMGRTg7JtdgzeK7ANxDND5hUpVh35zc77VJ98aHBV
	xDzYrpYQRaYHGVet6n3w2Pa1snZW6Wurz07AXZGAMpbPjNnnqx2y8aRnZ91zL2Hy
	PktthgVQDKK+tkFBUYY2PI0iobqIpuIVHz3Tx/Z3ea++TbAGLiMJEV5SR+8hHhOk
	cumHLEjDa7n7VBTuI0544BssbnGVWwtF6gLx6g9rVuq9rynlu6is4TzG4jWDT3cD
	K/SRCuHTe1M0aAZbf0pbmsNcWNVnKRR4e8m6iWjt+xJRSkxrjawMjeI/W1jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741159172; x=1741245572; bh=BaXAif/7wy2LqVMP1pQSHepELVFL7AYR1XR
	shp34UT4=; b=iSe8f2/sx/7wG+UKHSZjKpGYAPovlJS51BzeUrPOYX8ZOi3QTDW
	9Fu28cvjFiCUN8xulSVjoZOn5hy91nc3hI/u1GFaBNOlkAXlzRVUIlAogOwy1g3t
	ABM7eoG/VH42uLFQw9PeQPOzoX5R/9aUoEE5WuuWH/I+xPRqUEpWWTUTilCpdw9e
	Su9hHHndBzWk1hVjkQ9ZvjWockvjXZhsMNoBhdjw9fkedTnRFjDUNtXS7p+KKrjx
	JQtAO/2YeSRx5NPoJJl8p94Ix1kWKeODlJ7vZbDcTRNedBofeg1Af8Z3XSsJ1C7c
	JgI1rfcMOAUuah+kM+48lZHiqmjxXBOddWg==
X-ME-Sender: <xms:A_vHZ2TVrTDz8OXE12oabZ9WXDTYA6we9l7uILMzn5xhsT-j6mcszg>
    <xme:A_vHZ7zP4Z_GwDUcG321g66PBZbYBeHBwm4yuYQXZckZoo0PPU0A6kGb2Uc2aV_Qv
    rZd4dsqc0jDTAS14A>
X-ME-Received: <xmr:A_vHZz2zeHShYPuCg3xXB2l89svAUK77V0akDFAtJ6BTMxN7eiWdotWu_UJ1nZbaz3QccpY5obIM6sX6jmg4mP-Zp4JV0gSrCcfGVn7OFTaBBE6-oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdegudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejuefflefg
    gfehfeelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthgvfhhfvghnsehsuggrohguvghnrdgvuhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:A_vHZyCLjG-KsHyBWzzNjfD6OPzZKv1WsoT0nOfzUJ526-MVJPBkHA>
    <xmx:A_vHZ_jAmQFMKvDo3yA0HchQZa6Jv0vpFbVjLqIf3bAtVu8A7j8M8A>
    <xmx:A_vHZ-qVXEe3YnCMN0Wtkv9OZx6tw84ngNCyDtITp1KFbwwVBVgc5Q>
    <xmx:A_vHZyiicSMRrRPI2Q2-0hIcxKBwwCqrpSA-hEUq_S8pliRlc1TqYw>
    <xmx:BPvHZyv1Tly1dR2I5q_cmfEbN4l-ciIVzfu1IQdApKG1urWx0P_8H49w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 02:19:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 28157dd4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Mar 2025 07:19:28 +0000 (UTC)
Date: Wed, 5 Mar 2025 08:19:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: meson build: datadir missing?
Message-ID: <Z8f6_3nJ9ld4kC6p@pks.im>
References: <20250303203320.lP10PHC5@steffen%sdaoden.eu>
 <Z8am0ZmkJ7QD13_g@pks.im>
 <20250304181636.CEUTB9ed@steffen%sdaoden.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304181636.CEUTB9ed@steffen%sdaoden.eu>

On Tue, Mar 04, 2025 at 07:16:36PM +0100, Steffen Nurpmeso wrote:
> Patrick Steinhardt wrote in
>  |>   Only wondering why this happens at all, and is not covered by its \
>  |>   tests, really.
>  |
>  |Things like this are somewhat hard to test for as they require a proper
>  |installation.
> 
> Sure.  I just did not know about the meson stuff until this issue
> arose, lots of things seem to happen this year regarding it, there
> is a massive flux etc etc.  I did not want to piss somewhere,
> sorry.

No need to be sorry, I wasn't offended by anything.

Patrick
