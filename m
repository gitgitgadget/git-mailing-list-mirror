Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E011189F20
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523213; cv=none; b=rRlXgnShg8iK3bd5NTfVV7e2R1oZuyMso9JUMskz+LPJxSdiMJ8U7G5NXWO5Tu0sgrpqYlA/gHuaKk9yqkZ/04yakEoKuzdvxIM9XGtDjfcKLZC3nxPCQArzmmH+Bn/4Y5x/BJA9MoxpHwVuYYQyKjc11Wx8co0I48xvgqNWSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523213; c=relaxed/simple;
	bh=b7OaurhBEO2ZA22tJ+Zd4qn9naSG/SNbBFdT4ddD6Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+YFB/vIw0s7dh+1ayV23d1DWlNTejajz4VXQG3EBY9cxtsFZVY9M0awtWFpGJBskju2W8BZ6dlo9uPr/9pb2UaQA9pQuXka7aCPL5wmnfNxc5jBDYfLMyKRScHASVkkXHWl3ByKLL+aMFcSAnvj2fmR70c59nuasaIGJ02DXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wq1yXWSg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ORGzOuNl; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wq1yXWSg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ORGzOuNl"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17E362540160;
	Mon, 25 Nov 2024 03:26:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 03:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732523210; x=1732609610; bh=6mFdWhGSPP
	bVI/NEvlqc/F28/8KhulfwzgSOiwwgBd4=; b=wq1yXWSgdgeUhgBZ70rjSPoGIv
	IE0gqVaIooaDweEhV94H/fTSd/1spS+zNS72nyCHioJIApU5u3vIYU518MpShN+v
	g42qaxONC/dOy4abJcTjOywmo5MhJHCv/CAN9uZYQ7vPfIKAVhUHkpM0jXuFM6jB
	6GO+JM7jG7DtMxmyA2+PS0usPGlD+fXXSyRpk6n8zFT1IE7hRQrWrl808/L6ErlW
	+q1yjIGeVz7ZfQuZSbBBuxDam7tZe8Jey/b9wMW9vRFWwlJzbOw3j6VmWxhcGjkl
	BuY5iqHWxSUEwrk4zRdNeDIIRWSQkZJADTVvnye3cLuB2rCYjdM45QkUztEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732523210; x=1732609610; bh=6mFdWhGSPPbVI/NEvlqc/F28/8KhulfwzgS
	OiwwgBd4=; b=ORGzOuNlcTmSPfuJ+Qr5+lkWMfVr2h/Evm4d0r7YVCbbg/LSQxO
	xWLUGJN/drWDiE3+IhdIqQ03/h9LbiO4eDPnN1xX0lrCvx3xPIGPnK/eTwNqd58L
	7UKbcgs9zbi1AOkjs7j3ou/kSrj4AKAd8fKBHqmAlf25v70hHTz6FyQ4E5muj2hi
	lnd13wtWLFJzT630Zl9fVeeV+MHBSflkGPdvR9kiB3OqHDZd0Nin1JhT+YNuWt6z
	QS5QkoFvDiaXjX4GvtpA66FOjFyG6l6pi1YgQL14p0EUvOuHEiOWfiXuuQw/tPPi
	8oHzchvCyKhmGYrbCCqKle+Rge6b4OPmHfQ==
X-ME-Sender: <xms:yjREZ-QUBcH3geCrb3ZKNI523ZmI2eaZH4OZLmEtCkTuD0eFPTb1oQ>
    <xme:yjREZzzZFAJVFucS14Es-SfQ2r6rfA4eo6lnJ4Edj-ZBHGjvKZkS07TpAq-Y4_XeR
    fAVp6MRhkWwqni1Sg>
X-ME-Received: <xmr:yjREZ72-vOAuapft8EYOXbC7kk_sSrLdXhjEuXLmkLzxaqYoLux-uq-Xl22xvIsa5bicfFML_8tAuTlL6JkQKEaT1GjNMHbqlNZuTp1Qr5cS8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheplhgrrhhrhiesvghluggvrhdqghhoughsrdhorhhgpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeiihhhihi
    houhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhm
X-ME-Proxy: <xmx:yjREZ6Bw2kTEtxc6eTyGevUBsw-FQRb5zwhqmn-3uODVPaxjxmuhJw>
    <xmx:yjREZ3h49WH3jwfGc2gHwxmqYuLVsAPG4Bxdge4npOnrBBFcVa-ATw>
    <xmx:yjREZ2q3Rt_sD_kk4I-yTkHPR8tbuM9G8euPqo-A_GmuWTXFTw98Qg>
    <xmx:yjREZ6jlOg5xj5c582hL6W0_TLJiMnjsm6n5fh-pAHHXlJhFYU27Xw>
    <xmx:yjREZ3eBdEilf_57mh7aUp94Wyges2B6B8lQ2B1kkg7QRJIngEl5U_aS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 03:26:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 582863f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 08:25:49 +0000 (UTC)
Date: Mon, 25 Nov 2024 09:26:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v2 6/6] push: not send push-options to server with
 --dry-run
Message-ID: <Z0Q0vnTuo6dQDOox@pks.im>
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com>
 <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
 <9d11105d0d0ef5717c6c691a3648a1c1bd1aa988.1731603991.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d11105d0d0ef5717c6c691a3648a1c1bd1aa988.1731603991.git.zhiyou.jx@alibaba-inc.com>

On Fri, Nov 15, 2024 at 01:15:37AM +0800, Jiang Xin wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> 
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>

It would be nice to have a summary of what this change intends to do and
why that is a good idea.

Patrick
