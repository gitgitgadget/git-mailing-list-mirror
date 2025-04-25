Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FB2F32
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745555986; cv=none; b=AZtSp2ULmPNdIvC4hLqheI5ufTM2FmvMqw5zPnhT2nosFEZw9YpXICRBcR/okwLe8aeMxy2DXQtgTMhBFD37Ndt2FoE9nZ/198G1/LKMEjOuB/aLvPFee9wqEdITeRXyV5bXCjeC/Qx4bwJC/PBTQ6tMxZ7aVZZGv0E6Gq4xIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745555986; c=relaxed/simple;
	bh=IM/1dczmk3ZdzAMiO4aN0slpV0DL1e/JYoDCWeA3qyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4x8Fw8zZqnZSUn+g213mVeIvjxBzPDJn8Kw57d0NDoYe0dk/MAvmabHu/wEMZJtwhIVz3OaBUnSbQaeTjruS8WjHiElxPM/vy6E4jTncLeVvK2RgVm/1l7TchvRoFQcNMCon+KvEYfOeDPdBRSKyxpOWd3dYlYs8Y3pNvdO5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RIry99y8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ncLmNLXB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RIry99y8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ncLmNLXB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D46CF114016D;
	Fri, 25 Apr 2025 00:39:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 00:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745555983; x=1745642383; bh=IM/1dczmk3
	ZdzAMiO4aN0slpV0DL1e/JYoDCWeA3qyQ=; b=RIry99y8n86gowibGj//Xl396F
	7q6t5u9a17knrPPKdwIH49mG058ksJw7H5TDjXtLVGajyn8hnRGHb+bk5UfB/vO2
	G3NGBmtuZfZkYTunLwe+FsE9Zmafd7O0mA9JngQJUZ21U6vxsljDmMcSx9Vht+MU
	RZzpqj7EuXH9j8D8ue4NG2YgSOqBD47aHEGFRx+x8W0cbGElBTAjDYLpLK3wNOAh
	fsDJOLCzIHU4LgzEk70IDASedUs+hnARAI+3DdWAeaxyZ2LB+FmbFGybfO/LbXmQ
	NIIWXw4uLoVVndULfYP476vNX4qW0p4X1jm8yVTCPH8dDWPOEnWD3bwy+PaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745555983; x=1745642383; bh=IM/1dczmk3ZdzAMiO4aN0slpV0DL1e/JYoD
	CWeA3qyQ=; b=ncLmNLXB1+eplGruPhEQG0+fUHjfJi5tpSnY/w/tJnyUCxARdKT
	BAYTN3lRqey8BnrFwFw0is/f/+geBr8HdENKHApYUb5RzVvIRoSLBBHnfPhy1CFq
	fNrVF1QWt7eK+B/CAT5MuURGX6ATAhM/RMUhXuVUtjs9AZeDyER6b3acsButrvTv
	NEw94Q8OC5r4sucD/QEL5ihTLkSvQJ2zvrmw4hOPMPRaMD3kEg40RR2B+ILRINBh
	f0YkevXrHPBHh277ZfcwsUJyxWkQeIbzPYU1WLatO2qQ0+tdAV/iNoOYPFdu81D+
	aJlexnFGJ0FvZr28vKm2DquDD7aJP3RvHcQ==
X-ME-Sender: <xms:DxILaAp0AUehYyUcfgxy0JoWdj6TrE-yikLakZbr3oKa6uc6HwAZMQ>
    <xme:DxILaGqADXdDpEb50PzXr1UZqLSX5Ck8Pr76oJdQxA4n7oeMIhDuxKmZ8KM8CnCdF
    Zx7OavAFCMGjapFkA>
X-ME-Received: <xmr:DxILaFNBNxd4cH_qSFP5dI1K1DSTxifQvVdeMOt51SDX7LB0-qcC75-1hHXPl63y8-guyozAXwNtJqCtSFRDIbJkM2nve4sTN1hozSBC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgr
    mhesghgvnhhtohhordhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtoh
    hordhorhhg
X-ME-Proxy: <xmx:DxILaH7Onv4921RalugpxhzeA3WIoVdQH3nmejIhI2shQRK5j_OYnw>
    <xmx:DxILaP7jjvN1Wp2ps8Teqw5E3iHmr8fYZpd8GH4bmM3WmNxZp-GIDQ>
    <xmx:DxILaHjjuweXtf5gK8WFBQvt9n8tzjt4WmuwmyLgj67fWsNF3jtgvQ>
    <xmx:DxILaJ47m07uyVTSmH6RmO1Z6gg7pLvCFXaM_igOz4ufISSTgo28-Q>
    <xmx:DxILaLG15TGB9BSikTovsx3-Buxzm0kBXvs4RQc7ZCpdIBc0ERTvm4jw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 00:39:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ecafb918 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 04:39:41 +0000 (UTC)
Date: Fri, 25 Apr 2025 06:39:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] meson: miscellaneous system detection fixes
Message-ID: <aAsSDA5y_Dur9PGj@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250425002017.246985-1-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425002017.246985-1-eschwartz@gentoo.org>

On Thu, Apr 24, 2025 at 08:13:29PM -0400, Eli Schwartz wrote:
> Principally motivated to handle an issue where these were failing to
> detect the system properly, on Solaris.

I was expecting to also see my comments addressed around the one style
issue as well as the comment regarding `fs.exists()` being a bit too
magical (both mentioned in [1]). This is the only remaining item that
I'd like to see addressed, and other than that this series looks good to
me.

Patrick

[1]: <aAdFysi-n_5Aa4Au@pks.im>
