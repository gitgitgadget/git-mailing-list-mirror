Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42D3CF58
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513967; cv=none; b=uhubKujkoNJ4GlD7r19C02HQLJCEwuFO1pcx7FfPpdFyG3wi2WdoSZ78ww8ofqa9N7CTgWFbDWx7/hFIwe2Bn7AjHamm1CsuDtpgt0Np5KjXLzNINq2m8H0l7iXzCvQpEQvHusi8yS/A72BQ1d8VXbM7P2+DerDbrcJz9EFl9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513967; c=relaxed/simple;
	bh=Hn1srQ6HHNmAh+OtrpIJcxyzdLxzALnYrkWDmuMNRto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kb7y9IcGJnXxSukYP9FDGCdlo2EERMBM+rr2F3jGz7lsC1RetyrS7x4NI2b04ovJf0CaU4RrVP7PmrAMywWmBQZ6aREQebDgehrKbxnrxsc8Vux0ZTtVBlGyv5H0dmvFwzEdxUJalsq+lrMyAu/rVSbdtBjBvdFCi+YyIPZj5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TqqRqsZy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HeeXbpzM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TqqRqsZy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HeeXbpzM"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0251C2540123;
	Mon, 25 Nov 2024 00:52:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 25 Nov 2024 00:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732513963;
	 x=1732600363; bh=WY6f3Rtcu4KsAdWynaRBmVtbShgeqmGqSm77EYowD6Q=; b=
	TqqRqsZyEJ/cG7mkpYqKwW2jOkzq7Ztn2jFNNlq4K/uMoSvDlgNqeFA7i6L8G0pq
	V/msaqdaOwU9Ll3SHCZItSUvHN5ZyIvbIKj0m4DIK/CjAYPOqVG0d7yytZj3Pml/
	TldXuPs3lrkuBBEgTrQoJWIJmPK50aWSzgUqf/Ur+cvZwuww0QYTKqeBhiLwTVZ0
	EJ47BrbwpwKNoyVoSzpZ5stnHe/bik1gOR08+IzxXWlFFS2m+9s1MwblHmU7Dw65
	0W7ZavNQdLkc/SAa0uNfCuHSYwCauqUy+wxrokQfGS7iU61nui4Mg5h9YmaZ0IgN
	WAy4x5G78qPvetgfwM3A5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732513963; x=
	1732600363; bh=WY6f3Rtcu4KsAdWynaRBmVtbShgeqmGqSm77EYowD6Q=; b=H
	eeXbpzMYcIbL0NK3DEodlQ0H52tzuuB9ogsqetKmDlVmZaw9dBkEqSf6uGwhazhl
	fHGE+Wa9aQxMYz/p+C/BNkNCCh3+Ql7hKhIOCUGqY950Do58jIGPOG+LRo6IsqrP
	aDoM/qvsQ3mUwxeVqQUarKwkMuxG26WYwNcB8Nx+nzapqHqRwuYiXJv5GwVujq40
	nxCBz6En7+9qDOwc2TevT2wxkoQNRQ35Xrg0z5XP1/MDRAmMkMkAxjhpvJr62Sl4
	WAaFlEq8IPChVTPW9tqVkHKj3tH/pJY67/Et7Uew9laI6KWX58ZMKSOO3kNVlEC/
	07K3lHlcuR9Pxq01/H8vg==
X-ME-Sender: <xms:qxBEZ0skfq5CZFEKkLkwH5Fae2HW6_6etWXc1KXVnVwciWIYZYv_iA>
    <xme:qxBEZxfyamfY8t5nGe2EmXoKFJdS7vAUCCQ9p19Sda4-4t4MjDBnaqgnhG3eM51eN
    2C9uAhZHQoX1N-p7A>
X-ME-Received: <xmr:qxBEZ_wVnjRSr6rL-8EpualN5TaVmdW_TXGjmd7PfSKYYCkRIcUMUaKkccAE1dZVu6FbDh8x2hr-3BjHoemL-HnZcCjeYeAbmMbHrj5j5dZsPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhkshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeekvdevhfeujeelhfefleekhffgffevffelffejudev
    iefffeekkeehueffkeeugfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpkhhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qxBEZ3MwQ4A9CxSLgG5ZDIYhIf7ZycrTlInvrdkJMa5JFYRrVTJP4Q>
    <xmx:qxBEZ0-3apor56J_H2xOaySmJTDgmi8rOX5sBFerT431yFTFjuvjKA>
    <xmx:qxBEZ_Wi25_-i-CsRtL2n5g7Gnq7eVYvB-JuHJIzcuSsZNhvM-E4CA>
    <xmx:qxBEZ9cRZocwxoSeMuslGM_zYzqQLcc5gXP5l_hDU3AVrxAYWXr3yA>
    <xmx:qxBEZ4ZkQUs-1SKYFvCcYnpinqPrXmsmkJH09YryVaoG3ccXhQRTHRfR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 00:52:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 77fa69b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 05:51:41 +0000 (UTC)
Date: Mon, 25 Nov 2024 06:52:30 +0100
From: Patrick Steinhardt <pks@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] refs: skip collision checks in initial
 transactions
Message-ID: <Z0QQnqZ5x9Y-Js8V@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
 <20241120-pks-refs-optimize-migrations-v2-6-a233374b7452@pks.im>
 <afed1ddc-90fd-446a-9da0-b8e8f3fbb903@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afed1ddc-90fd-446a-9da0-b8e8f3fbb903@app.fastmail.com>

On Wed, Nov 20, 2024 at 11:42:29AM +0100, Kristoffer Haugsbakk wrote:
> Hi
> 
> On Wed, Nov 20, 2024, at 08:51, Patrick Steinhardt wrote:
> > While we generally cannot avoid the first check, the second check is
> > superfluous in cases where the transaction is an initial one in an
> > otherwise empty ref store. The check results in multiple ref reads as
> > well as the creation of a ref iterator for every ref we're checking,
> > which adds up quite fast when performing the check for many refs.
> >
> > Introduce a new flag that allows us to skip this check and wire it up in
> > such that the backends pass it when running an initial transaction. This
> 
> Missing word? “wire it up in such that”.
> 
> Maybe: “wire it up so that”.

Ah, indeed. Will fix. Thanks!

Patrick
