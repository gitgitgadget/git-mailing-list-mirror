Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55336BA42
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758087284; cv=none; b=ONY8kJl+dxXddi8hFbCc/xz4wM24x79zpFHfcHvB5efrNuu96hGJkl2H2OlC2sqGyEvk/CIg0NEMd9fCVS/jTXeHmPdeYQDvWxzrBnJ1UbV1eusyYBSP40K0yW4bL0EvAU3e1RWETpmggaIBQWOcFxDgGjKR8OeUFy+56uJRGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758087284; c=relaxed/simple;
	bh=UC8o0IlqeS3ndCU+QrPYZEqm4uGs/IUUFTcGXRX14NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5d/PlXjrHu+dCzZ8vINCudBaPxbtl/U+C8wbvOYiOauXy3IAHL92ldpPC+6AAWkLKYdVJMupp+/413rHp+Uqs9nObD9Q74bm0Aq0+iI0dE0gs5tShpJ1lY0VR4cDJ1y90j8rK5EjKIPnXRAuEGzJK1E/79kB9FovFGT3DoP2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GXz29Vju; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jsl8NT3f; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GXz29Vju";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jsl8NT3f"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 60A84EC00D4;
	Wed, 17 Sep 2025 01:34:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 17 Sep 2025 01:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758087280; x=1758173680; bh=J3GjP6kipt
	E36yQdcwyGc6dxR90XfErW8NHG05Vhgho=; b=GXz29VjueFf43CAQa9gqkeXS1T
	LZmS6U6wQfSgudBUAkFUz+zMjM6bgzX+3bS8p9jIzc1dqpiNuiCZNNG/70g/nroJ
	mqnMMnoOH820GQFF0fvPnJr07ap/T8WzVYObL6sbPR4bT/kYNG7yp0Gk6Oa7Ueez
	L1JIRYLS8mEJY3hmvIPEr3O2dacnmDawIZyqAklafCFS6EGzdFwIi63bntVzzG66
	Q2H54Rt4G7jxHfK8DXdPkmjvbP7jzoGsLlLwRY5X/ILlRrdFwcf0j/GeR8dT68vT
	rWszCSHDQV8ShMf7a/XgGS/54rZRUj0j2fnZ1ZkG+8fuOceQbGl28J2SVdlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758087280; x=1758173680; bh=J3GjP6kiptE36yQdcwyGc6dxR90XfErW8NH
	G05Vhgho=; b=jsl8NT3fkPk+7xWbau6dlwnUrlSIpKOAt9COhmmiRi7nLG7tEjT
	wAjUkUiFb6v160XH0s42LL7dD5EurrO/wuikE0ZC/dADT/BGLr5mCGDTO0CWoTkD
	8LlnrX+i7XX7JfjIhBG9r3g8f4rCQKR8lq+eKpxsCNPWNOoCW83ePaV2rOH1TzSH
	gtev0HBaq3nee76lQbl1dWNxIi5BLqecPDv7mDumxFGhdi+ynAWoe54Oobl4zB53
	iaslXB7tqNv2HC4iPVOEB4r6heBG+yK/8tbagY6DMPCVay5buYDTl9h+OuqA3Nvo
	IseQQj3jQrrD8YqTmJi3YB6jJi+8KaGmD2g==
X-ME-Sender: <xms:cEjKaB4SV0XYgiAVI-RMwYJwHh_sYzyQI-VtKKkNCI2KMPSm5eTNlg>
    <xme:cEjKaJe46-W2FNVcbRCvQYaWr2HnwD54eRxfe9a62oq-dA25bU8gRmr7WJ78511hk
    XVUrbfhMrQ_khKGaA>
X-ME-Received: <xmr:cEjKaFBQiaP5prVBWGM8gtJGMG8qGcopW9JhL6ImvhDaTXkz8-Qs8q-UVAWsgye9xdnVWNx9msil0NkzrBMw8BhgH6hcVV2orlN3DHKRfbI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:cEjKaM9HoBYod-eMCpsJ2lNR42GgkIEXyFjqIo7JZNwKeyFANZLCUQ>
    <xmx:cEjKaALbLKZRp856qbkJjO8gwsZOl_UMO78j5rGHBxJinjDUTNOw-Q>
    <xmx:cEjKaFgfoDcd7cYG8t7UAe14J7eut8a_tnOiH14xcqn-vwNPicqBfw>
    <xmx:cEjKaA5Po9vApDbbdYXbPbt7ldc9RHcbDtIyfdJrFC9qF8mYcV4SYA>
    <xmx:cEjKaBoCMj6OJseIy5BIdo5gJ_YqtJSG_oc4F_A_6CpOaSnHdIX90Dof>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 01:34:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 30cd03ee (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 17 Sep 2025 05:34:37 +0000 (UTC)
Date: Wed, 17 Sep 2025 07:34:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
	karthik.188@gmail.com
Subject: Re: [PATCH] repo: add --all to git-repo-info
Message-ID: <aMpIaVPdgnbhBvlG@pks.im>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <aMkaePi90Q6sXuO4@pks.im>
 <xmqqv7linzex.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7linzex.fsf@gitster.g>

On Tue, Sep 16, 2025 at 09:19:02AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > One thing I wonder is whether we actually need the "--all" flag in the
> > first place. Right now, when saying `git repo info` without any further
> > arguments, then the user will be met with complete silence. I don't
> > really think that this is useful as a default in any way, as it makes it
> > very difficult for the user to figure out what kind of information
> > exists in the first place.
> 
> If we were talking about interactive tool, I might agree, but for a
> tool for scriptors,
> 
>     tool "$@"
> 
> should not silently turn into
> 
>     tool --all
> 
> when $# == 0.  That is asking for surprises.

That's fair. Let's stick with a flag then.

Patrick
