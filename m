Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B7637700
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709180352; cv=none; b=R9bO3ZouQRgi/hFBTTAW/zbfp3cKn9VUTs7j6N2ZTsnGVUSxcOMENmiqfhRWHXPmglZYtNBNtJ9Csq8LU28DfjPIDNvi8SJRxPHP45sRLorztFQnDQBTYKiVufs60Fs/NqYaxm8wUiD7F5RB5yrJAf/7e9pEAjsLENJyGxwRK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709180352; c=relaxed/simple;
	bh=TfAciJxA7mj7SPCgAr9jSMZxYN8taM/jgDI9kmAnWjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYw4dlCZn6raB+Bbud/Fu3dmOnqn6TL0opIV9PFvLH1ARYXfrcZI8bipEWf3q0sOWC8GmCMZwh/iP02KwazQgUhmRc8iQGF/kSlNJhkGEys+dv/TEShvZxY5EsffpynQkXgWnxbT8vkHS6NvXLcHEZ0m2xJel5/XSyXyoMoylLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=htSB4X6Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lm2o7/Cw; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="htSB4X6Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lm2o7/Cw"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 88EB21C0007D;
	Wed, 28 Feb 2024 23:19:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 28 Feb 2024 23:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709180348;
	 x=1709266748; bh=dA62Y8l7VOhUXxzXG7ibcZxVaghcnVI0mzkEkOrfMWE=; b=
	htSB4X6QLeDSI1meFilm8z8TMgMeKZBtOm0+CCK0b5yD17GGkZZVOBfRyVAcgLZh
	1fzTXws0BsiXs38SmCgCZwNK4302r4WXvoGNFh1EUVXUsSdq9T3yvvefuN2kId3z
	kkxpcfSUWhJUb/7grilLiULkRSQgBAARYswWNJYE1bvFBZPaCy284e9FW0TnbXeT
	KA1YyxWbJPSa0XyTD13xlwIJtO9QMKWJi1yzh5aNRygr04FXn0C4KZQ7BPylR6mL
	VbKb/sKt0DikwFs3pN0c84lH+sUM8jPlRA/rVzX2YsPrx3KLQ54EF4AqyKLZt5hA
	jMnDTc+OX6aQstlPpa+A6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709180348; x=1709266748; bh=dA62Y8l7VOhUXxzXG7ibcZxVaghc
	nVI0mzkEkOrfMWE=; b=Lm2o7/CwwdxHLr6Q2saBQ0acmnuvs8jRY+MUI3o+ct6N
	eRcYhh4uvAPgw7PiYNLQZjbTrCtyYusafb7UE0dpHEw7NtqLpz7DsxXGzANUN2UJ
	ipFEs+AakAhd2oNvI3FrFDS+zlur59nk8lNzrv1d+l0ud9qrk1GCWIH34pPT2OiR
	lfXZHIUzfLmnls+2rE0++cHsJVm09Pk5XLZCLdCgNYNAFpsBLDVHDhOhnxwLebLC
	aF4x4Z4/zWtaD21bL3Wau7RUQKzz2/D0mL2ro1SCgrPSw8nwHJpMPCfSwD5ovUYY
	Li4vvw+dasG5mtv1roqyxL4NVj2/xfcUUMIqHOcBLQ==
X-ME-Sender: <xms:uwXgZU9c5Zfv43J4BFld3NS-NN_DH3WTqPpRy1M6EiEjivrR_061lw>
    <xme:uwXgZctjYaDpqYOa5uThtTnmwu0GlIYMTqAWDhtuKCYZJIM4Xx0sz1n7FIevfrpbW
    a_mlC_DAufKTwn1RGk>
X-ME-Received: <xmr:uwXgZaA3pMlZ4dySqhPLBcqrYAr173D6-KdQwDE_Lqf18_8CpOJg6Oiqtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeekgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhh
    thhrihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeduieegheeijeeuvdetud
    efvedtjeefgeeufefghfekgfelfeetteelvddtffetgfenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvth
    htrdhorhhg
X-ME-Proxy: <xmx:uwXgZUfbSLHQR3aduMpGbLMOV2-OIhndEekzooJ-_5Du2VikufQTXA>
    <xmx:uwXgZZPrvuTAPt1JFrYEMQBrQSLmFwH3EUQbMDw1YeURR8Cs9ZzTfQ>
    <xmx:uwXgZen7WhONnM6PpVdboIseGxXhXyTAWQTMsZucK4zXBPD6APaWUQ>
    <xmx:vAXgZSa49ibwemTdeXdCfEonvYnkPYxBzfUF8pyfWqGQFT77b_5RnV7fWd4>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Feb 2024 23:19:07 -0500 (EST)
Date: Wed, 28 Feb 2024 20:19:06 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] commit: Avoid redundant scissor line with
 --cleanup=scissors -v
Message-ID: <ZeAFutaddf4M2wjM@localhost>
References: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
 <xmqqbk83nlw5.fsf@gitster.g>
 <Zd2eLxPelxvP8FDk@localhost>
 <4f97933f173220544a5be2bf05c2bee2b044d2b1.1709024540.git.josh@joshtriplett.org>
 <xmqqjzmpu7k6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzmpu7k6.fsf@gitster.g>

On Tue, Feb 27, 2024 at 09:43:21AM -0800, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > diff --git a/wt-status.c b/wt-status.c
> > index ea13f5d8db..2d576f7a44 100644
> 
> I do not seem to have the preimage ea13f5d8db; as a bugfix patch, it
> would be preferrable to make the patches not to depend on anything
> in flight.  If feasible, it may even be nicer to base them on one of
> the maintenance tracks.
> 
> I managed to wiggle the patch in (somehow a context line was
> misindented), so there hopefully is no need to resend.

Sorry about that. I had these two patches in the same branch as my other recent patch
`advice: Add advice.scissors to suppress "do not modify or remove this line"`
but the two ended up independent so I didn't send them as a series. That
patch and this two-patch series should be applicable independently.

If you do end up needing a resend of any of them, I'm happy to do so.
