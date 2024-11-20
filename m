Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF72746D
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112830; cv=none; b=OMJdhdEEyuBFFQUHyTFUzc/JWi1zo/41eikn/0s5zNhjcl90RZG0mJCsHoZ9EdkQygApzrwJ6SJyyTvmzfG1kveVjbdemlkLtdRviYPz6bAxrcBTbzQgbyVAfO/FjNO3aVDW5qoDuORtO2ZK7M1cLyIaJQ/W+HXohDq5khP78gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112830; c=relaxed/simple;
	bh=eIcvK1GL7M/BKrldR1NI3HhXaHaJX02y9SzdrN8WauE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/D0JwUL7KIoW+hdps/1iAlw0Ssg3X9I9YZvF5bTcQYGGXXOvb3fWjH6NahBlM81nTlA6Es+Xkw4vPm4J/IrN6GGSvwXkSMAVdWhb5HMjzNbtQPy59vTe7MVEFNc1cKSA7hnIB5Y2MBopar7yoKG2aWGzOqMgDE3Vd1BwLY3YeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vkLUqSNV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dzjg9Kjb; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vkLUqSNV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dzjg9Kjb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id ACCAD13806D7;
	Wed, 20 Nov 2024 09:27:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 20 Nov 2024 09:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732112826; x=1732199226; bh=wC/aiLhjJY
	ZPqIGQzb2JWXvIkUyuk07tw0Mkc2+Q0Dc=; b=vkLUqSNVMVvvPdBsPiZRgVH1U1
	tPg2C9GF6k3dGgtC2VYrCFysS8vQjwS3AeZsTmKkreZ/fL+D3bHSdYyBywNTzLoG
	qbtWV3rVHNm5za8UbFqs8BbBz4n+6p+f0K3i2Rna+ZKgVVoHZEaIrOP/dzBuHBiJ
	MVNIoybxhZ2YUclz1r8CwjXZv123zJxWO7qJaCmoL2P4WvGZRRCZPmPcX02wL7H0
	Czn6G9ZP0hHc0UXhuE53SR3k9ymtQj6vbo9JxLfpflZ8fM6hvdPfrzHk7FYse8aD
	2AV4kUMNT67gNV0uTQvdgB8b6Bj1mn9u02TBIYibk1aO9dLerXWg9r5e2G+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732112826; x=1732199226; bh=wC/aiLhjJYZPqIGQzb2JWXvIkUyuk07tw0M
	kc2+Q0Dc=; b=Dzjg9KjbhvNnd0rsyj/UF26F/od8PjoDXh2as3lHHzxt+AWRg7t
	dO/cDRcNrbGsfAfbDEvXJQlOMBSOmqsiinqOKoJUeAqyt8iDi3USDqLD1aLVIUA4
	fcS4QyM/N03Cu7nWADQPLjIYIMcJwBL0vEe+MdOlZJ/DQeptZJo11G7BPyOgDQqk
	OwlLBScZwI+72l1ZVMuqgHlzsKQ+b3LFpHX0yHq3mB1lhMWsFTrtP80YKD+4kPsv
	yJylArqD51Bfmh8oee/RS9nwHd2ZNqK4tilJ3ENzRTyY4yfhYY+nnArnt4TlETmK
	3wubuu2FOLa1d8wTx5mHhBhqSjjiUE7Q7zQ==
X-ME-Sender: <xms:uvE9Z0DzS1s2mIYbFc8j3uHJYfaEAQhrZxQnh0w7PJOHMPCZLaVtkA>
    <xme:uvE9Z2gu2CIbNp_Hm0hT-jVffOpgybKIK5EqzoIK1fwziflroptjTxquo7ql-VamX
    jue9k_4Hsg04VfAeg>
X-ME-Received: <xmr:uvE9Z3mK_f7gL-LssBtdce5-wYsFxjFZYDSNLF_GiPfx2UUX3pkTlspQbwlQqO80w64h5PTKlEXnbI5vvLDABavRnSMrEySGQNGxYCZHiWWIpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehs
    hhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:uvE9Z6wXzDY55GWq0oyErm98W0SdAL4-Fup8kUxQonUJfuQQvO4d0g>
    <xmx:uvE9Z5Rg_ui4HleX2Z9TqhSewoaN94_y6_72MnjZ6ZtQlkXdZZBohw>
    <xmx:uvE9Z1azaqBYq16udtZGog1208iRmgmxDQ4EMO_z5evyuOXa5iO4CQ>
    <xmx:uvE9ZyQxc4SGNCjmjQ5I4rQuNQiOi4V8Q_2SrXhz-qc853ELSLAaVA>
    <xmx:uvE9Z3NAhGnpnBi6ZvBqda_WATGoTGlUowzHShhWcu5MEP5iN0_AFMfx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 09:27:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8154f18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 14:26:10 +0000 (UTC)
Date: Wed, 20 Nov 2024 15:26:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/9] add ref content check for files backend
Message-ID: <Zz3xpMdzeeUssH6n@pks.im>
References: <ZzYqoai8X_Wdtbmt@ArchLinux>
 <Zz3MON9_9DGD6nsy@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz3MON9_9DGD6nsy@ArchLinux>

On Wed, Nov 20, 2024 at 07:47:04PM +0800, shejialuo wrote:
> Hi All:
> 
> This version fixes two problems:
> 
> 1. Remove unnecessary space.
> 2. Drop extra "strerror(errno)".
> 
> Thanks,
> Jialuo

The range-diff looks as expected, so this version lokos good to me.

Thanks!

Patrick
