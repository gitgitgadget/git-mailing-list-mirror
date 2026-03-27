Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC3C34AB19
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630410; cv=none; b=UWy/0ZgeoLPx//I7SrVpDRtvYN3Mr7vxhq18J2L8ekmcTmW17rU323QFlQDrIJZ7lmEI4TfrMrVBoBBtHkMGvzzyptUO0R7Vojo8Du7TZ8JXOhbaJnWCf0VR50HQJnD8DN7vxtu3N7Z2rcOwOVNNwCFl4FOeWlj9Bxz7ZTArw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630410; c=relaxed/simple;
	bh=lDUOz8F2PcECQqsZ0ctyTknR2Pf5GcjSEZQqusVLsHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MScxB8k5xYv6Gsqqp73h3HUrru92LVt45OZ+ZrqzQbDfE0yQZD0Z2yuTesqD7XNN5E742X1Iq2vKkHz7al9wu3GuHehaXsjdgj41HLR6dUnWAE66ab113Ghg17kay/aWP0db5heVAaRgk3Uf++Rx5eiDgk9zSoajdfRikx1Vnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cBOtP18B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0vAyPwSQ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cBOtP18B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0vAyPwSQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB4587A0067;
	Fri, 27 Mar 2026 12:53:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 27 Mar 2026 12:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774630408; x=1774716808; bh=WMrjmJ6HC2
	W8QGr78SaQCXpn2k+tI2ojMmMoECL4zuI=; b=cBOtP18B0GgMeAaHkLTXa2DavQ
	t41qDjEpMQsPruT8PsS4dz1N6LAIpFVOk8HB2HTsLG+H+PP6gBt9/SHPt/zXigpi
	/tVSbWcrqkRTAf4baEsI+1/UWnSEXOUti377SVhWz/RXTEtN7ERoWUrjCfoe0DvI
	2y5YNo8wOVD7pIdTa8zuv/U/SoCDGd1YhoSKWnY8KlqhUdqKrgnc3oCFCCr37P3Z
	acGrfItLHn90P07Ylb7kZJp8WMFMgG/R133ajY/cSkdQ+7c1YftBIhmss2Oc5CF5
	dZtzPfwOSvesZXf1vbl6DJaxYt3Jy8rGgquNQ3Vi+lEkJFQRUc2j+X9zlMbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774630408; x=1774716808; bh=WMrjmJ6HC2W8QGr78SaQCXpn2k+tI2ojMmM
	oECL4zuI=; b=0vAyPwSQDIxmb1ZGh95oRCA6oBvnjPxjnce3fTo3ZGCA0Dbx7ET
	BcyCFk9pZxi9X5llXE3A2PFfN5bZzG1xoo6qgLsCdk5X3D+idBGYPhtLfG7M/Mlj
	Y4P170cVCK0Y3eAgCv7f46zZBOk6YHqVdfsTW5DxOB/wPesUNiFlZB0eLLyQe8h7
	JGL9ntMRZa5Lk2FRqGYV5MDB6ChURXR+PK1WpofUlpEwXmz4niUMbsigTelDdpwy
	5gXe8NdQ+9q9j99+pSvSZVVxNoYyZCSslnV4WSzw8hszUUbYeJHmoDa3dmGZXppR
	ib7GZkQOyuyQIukDULM5o5AzcuyyWM7Gt4g==
X-ME-Sender: <xms:CLbGaQKM0rzO3t7ulwaVyKaa3romDzsOYyGBfBlHa_2LCHv6i3hZtA>
    <xme:CLbGaYnDCqZ_l_wH7CNAK6zHCbKwMmgKy57VpkVHIcH0fLUdrN4lIIrqTJLaeQjBZ
    vfl5FJErSkJZ-RCQ1jgraQIXQfAksu7NL7lSC0HQ-0L2KPuYhlA>
X-ME-Received: <xmr:CLbGaRLHe1I2EI8VB27lUmPa6Yk6ygojFzdILp6sbaXMhpgzbwyRW9vxvojge1WHqjcMRwuv4YLr4K3QUowtiAeG6cObFAOSDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepqhhuvghnthhinhdrsggvrhhnvghtsegslhhuvgifih
    hnrdgthhdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:CLbGad69m9pfME0EcU2U0QJExMQjtTNu5x5s07F2Nl7GaZJADoJcWA>
    <xmx:CLbGaV1qvRww-LAJ0fj8HtSNQjMSwheIELHfbZSvS6z4xwbt8piqcQ>
    <xmx:CLbGaTdO-it5EX6crpKeA0WW5u9oCwTQMbUHZH3ymvZ6tneHo80-vg>
    <xmx:CLbGabe7Wme5G1Cm_yETFZvv4hejirRGWjYEgTWQhzkj2SiW3JDbcg>
    <xmx:CLbGaQFfsfpD4_Zc6CpLbvgCCMTFz2Jbo0OLZF6K7zWqhrzg0SGeUEMj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:53:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Quentin Bernet <quentin.bernet@bluewin.ch>
Cc: Mirko Faina <mroik@delayed.space>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Quentin Bernet via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] docs: fix git stash grammar
In-Reply-To: <fbe531eb-b742-4cd1-ab6a-2eaaf8d236c5@bluewin.ch> (Quentin
	Bernet's message of "Fri, 27 Mar 2026 17:28:05 +0100")
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
	<CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
	<acXIl2cuBv0ifiK6@exploit> <xmqqqzp5mfh5.fsf@gitster.g>
	<fbe531eb-b742-4cd1-ab6a-2eaaf8d236c5@bluewin.ch>
Date: Fri, 27 Mar 2026 09:53:26 -0700
Message-ID: <xmqq7bqxkyd5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Quentin Bernet <quentin.bernet@bluewin.ch> writes:

> My previous, simpler, grammar included "git stash <pathspec>" even 
> though it is not valid.

"git stash -- path1 path2 ..." is valid and is taken as elliding the
subcommand name 'push'.  So I think your previous one is good enough
but the command line description needs to mention that.  Double dash
is used to signal the start of pathspec when ambiguous, and it is a
good example to highlight when it is useful.  Without disambiguating
"--", "path1" might be misspelt subcommand name but we cannot tell
which one.  You may even have a file whose name is "pop", and "git
stash -- pop" would be a way to save away the changes to the file
without having to say "push" explicitly ;-)

