Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA01E9060
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512225; cv=none; b=GOZ5/IWyFXplnxsVT1xTA6s43k8JJvVlni5vHwF9gnR1FxnQ5MPC2mGvXdNqi9BugmkXyqOwjGfWDdVZLs+Py3o44AIZhBphI2v4mTbfHdIAkhVwwqX9C/ii+kCJpRBxakZzDzh81mNnTYD9Ny4RF//s8Sw5GA/xXNk3uvZ22ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512225; c=relaxed/simple;
	bh=Wi0c49veInCS5Wz+QR64m1p5zUbUwkuSEICmEU56xEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHUV1vcJamRgJRxwoUkghGysoRUmJ7qkIB1eddtsFpn1C/H03zFWE+mH34DpxZKseTp5JK4l1PHmOC6NzjTmaAnyeqySrOcLLrxiYiSk9NuuOTsJtMbRIVlJZyI2sg35Glq+0r/GvqgM6CQWMsdOHfBaGCQF3LXlGG6eLsSYQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ALqtfPCJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oHLPmjkf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ALqtfPCJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oHLPmjkf"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A5831140096;
	Mon, 21 Oct 2024 08:03:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 21 Oct 2024 08:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729512222; x=1729598622; bh=Ni2QXN0oEw
	0Q6+4p3gW2LazqAtNBatvsuDr7U1v9qyQ=; b=ALqtfPCJhNpd/QlG0DyrJE5JP4
	XtpMQkycdicGSUnKzpsCjINNfq5nm52iCGLcCQQyLh8H1vkTyeol1sBn5y8olQ9S
	jI7CyfAP+BE+OfNMpdUDm+rZLErN2GoIgfzD3QEXbGWBhIHJONdJ2/PLzE3GsJYX
	Khnn3w/ET4uQFRzRtUSqV1PH3OkDDehDlf/tkgh1GaebAYwrPdgGzR4Ur9tUwwSR
	UQqlYYsjoT/21nsE2xyMQbWjtv7yWR+AkwIl9ZzOEOyxbOyJy36BYQ7q5lLdM7VZ
	kwS3Wwaf3hMRoX6cLcfaGjTf+qAgxbNoEtXsY6uoHllkY5PBWiH9sTPkylog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729512222; x=1729598622; bh=Ni2QXN0oEw0Q6+4p3gW2LazqAtNB
	atvsuDr7U1v9qyQ=; b=oHLPmjkf2ZQPvNKh/XO7Mi+zbfjp7gj0K83GUvXKOvIK
	60MjDV2wwPy7bD0hYYV78q6WRYgvx8Ewhy14BRTgcF7gK8vov2lZ6tmdKimyxv8h
	5nPxpQnsWbzampi+aEw4csNjuAgP3l4rCbkkMsO4ipi6p24CyN4Bpn3U/bumML5B
	uTMEsK3yw1fA3pOqb23ukrMGIUJ6hrKcyPrX0Fd0DsM20+BvF8yocIykW0YrOwnY
	D1V6gGyn9M3u5o69n+UT/upT1Wie1lOND7MGb9f6OWFECg3nH58oamG+UPZluKMf
	ERDLt73gvhK3PtP7r1w27PlK5wy+PS29kS/tCmwGhg==
X-ME-Sender: <xms:HkMWZwtd3rRidxR8NGF6zGl6j385k8aJhdyl5cqLgbSPNGOKlbZHuQ>
    <xme:HkMWZ9ebX2L68kTG32plVCOCEvSt845nC-X2qWU_vYohi0t4wH8FqOWdmvWUqb7n5
    WXUW1cAQWWmXwk0QQ>
X-ME-Received: <xmr:HkMWZ7zcTNyuBv0kd7Zc4Npj6dg4jBqq64aFyD5IZ8_-7_6SaY9qKMoipYfAUWqvJoP2MJKJkKHID5Mv4fRV3wk_TgZUfvHa6OvT3qj5w_0V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhu
    fhhorhhijhhileeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HkMWZzNQPqVdZvLqJ6pSBqP-FjCFUm2Tdpz2o4p0m1y5qlWYzeQClQ>
    <xmx:HkMWZw-83bx6x5H_zGO8u0niwBjHqv1l_IqSJhLHoQMEG3IpzkhMAg>
    <xmx:HkMWZ7UoGYJ5QdOsD6s_4W5lenQ5B3zxM0oc0SyvmdDmB_5B23rs_g>
    <xmx:HkMWZ5eEwu5MqRwu1rFCFjvYM2PsbeyY-fQZzz0BMBHB292LBpJ9_w>
    <xmx:HkMWZ_k61u7dlEnbrRj7Wv7NyU583gAotYzjnjqsm5y557NE_xWB3kfu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 08:03:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da803246 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 12:02:12 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:03:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 Outreachy] t7011: ensure no whitespace after redirect
Message-ID: <ZxZDFyKxTn_D7c3o@pks.im>
References: <20241019163439.274656-1-kuforiji98@gmail.com>
 <cb88194a-15d2-4c3d-8768-189853572ac0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb88194a-15d2-4c3d-8768-189853572ac0@app.fastmail.com>

On Sat, Oct 19, 2024 at 07:54:30PM +0200, Kristoffer Haugsbakk wrote:
> On Sat, Oct 19, 2024, at 18:34, Seyi Kuforiji wrote:
> > This change updates the script to conform to the coding standards
> > outlined in the Git project's documentation. According to the guidelines
> > in Documentation/CodingGuidelines under "Redirection operators", there
> > should be no whitespace after redirection operators.
> >
> > Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> > ---
> >  t/t7011-skip-worktree-reading.sh | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> I can confirm that there are no changes in this version to the patch
> itself.  Which was expected since the change was good.
> 
> The difference in this version is that the commit message has been
> improved.  At least according to my taste.

Agreed, this patch looks good to me, too. Thanks!

Patrick
