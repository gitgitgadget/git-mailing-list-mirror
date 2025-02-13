Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A241EA90
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424008; cv=none; b=hiDbTqMENxCw3vmRyVQMY+HGly5wGAAbI1ablQA2CT7BpaGcpqkmx35hsDrMr9EvBK8lFiXN7vx91DBjZ6JhaLGmx2UsuxQVcUFD12fqwpYnRfSVf+/LivTLtaJWdzCIPswLb8ETgqX/vWu/+T5wSQNp3XVYy8KzrMIMbdxbelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424008; c=relaxed/simple;
	bh=HFSxkweccTbiXRIYk1J6wEcWLwn6yBUHz1WYr22hoKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MCNSD6Qq1DeR9A5FO1bkbjC3jZASiOOn+jFPAfYa5c+qZF0+dp+Ezqs4WFLsuPrhY5ugvVZOl/q5UpGG2VQn48/S9z5OuSvO7wi5nfb3WEwQYul8GLnPTzv6AHtfJRnrpYkJVVhQdpSdri7O2769jVD8Ks9p9j1uGgsS4RKSZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uhnFxi3t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qoU2IqSI; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uhnFxi3t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qoU2IqSI"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 310F525401CF;
	Thu, 13 Feb 2025 00:20:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 13 Feb 2025 00:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739424005; x=1739510405; bh=9twuKEf9Vq
	zi00rpEOT8XgULZgLRZCB1QB2vMCSfs1A=; b=uhnFxi3tVw31YyOLVIdYd3PZWN
	j4AP+UiArapihP6yXCsiZXt9H1dOiIvK5wbzMoZ269ut/UhAnvZPFDIqwqNhgi6u
	qS71J8y8tCm7bpmzei/SycVvbq9E35hGkx0lTK9bcKBHTOistDbwUwobIHGnbJP7
	68Oj+I/DSMP5QfHA9po9chZLLcc6clxYzZzP8G6OeeMAXq4CbvEFVeh5kaSvQGSl
	j6HZEDfQY7yAgggTWOj8MRDjL7Nk4d57iNGD9pZ6KCZM69ey1Tgv7X9V+EAr2lTS
	YfGHmEwseXAEx8cnDFB1vb/LR8WfFHAIrI+tbPvOmM8nPhvDF/tXzMd4PCxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739424005; x=1739510405; bh=9twuKEf9Vqzi00rpEOT8XgULZgLRZCB1QB2
	vMCSfs1A=; b=qoU2IqSIl6ApOjN1fnDHoOX78Qv5smXhiZkPUh0WbUVWmnFQvWl
	12XQjcGNo5Ajbo0vSfI60/O3SBJ25kdH9ysh5EEUVa0ICCvnR6Niwp5xAiC/y7x/
	zrfugv/wdgHDoq+ih3L3p2cJy2sPXKM/Cb+IcpxPnXqTPSJP2zKzabQVj3BwCTgV
	P88bJXSzsCeg9UCyfkpscXStvmE4FlZsxDy8scU6obnI+ymW4xBUWc5dSyf6eEDX
	c6KEfA9TLUJ+WbJzZoj9M+Hc+MUZlNJZ018RTTXALtcU8+o/kIpFhon0nD4D5g7/
	HgQSxW906D/bQhS+oWQFej5QqeFePO8twQQ==
X-ME-Sender: <xms:BIGtZ_jxmS8OYM7JGIwHdvieFoscxBFVCg4lewTq7D-1gvwLZrF1uQ>
    <xme:BIGtZ8DyhvyORhwn_6XzvrD3RMEjukrYIKCaHID6smq4Tdin1Tk996YyBKFIpOYAL
    s-Z-rCNFJO1wHcFwA>
X-ME-Received: <xmr:BIGtZ_Ez7gPUtNdlMTkmnLcVCl496PVMLIkXeBRaYUOGLecDbZPv63mCYpWOAEgrswV46OK__IQtm045-P157WdxANQ9AidnraPupGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegheeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehilhhlihgrrdgsoh
    gshihrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BIGtZ8QPJtR2PcN3PSs80TUZWAywU31Z0tj3S6sMV1Fn1EulpZPc7A>
    <xmx:BIGtZ8ySUkMrKmo21Sl8uKH543-bt5nI1zr74f02dq-DX9TwM2eCkA>
    <xmx:BIGtZy5lApew_t3VwTRZDq5xQPBxr0GdacGk2bE2LvZjxhp3bVEcaQ>
    <xmx:BIGtZxz68Q9ijBCnqZtU5R38m2etZsVluiGJVWxM_dcxl48SNn0RtA>
    <xmx:BYGtZ48CdQuzwoKphuNiOcTdAUTf6E2TkYJdCWdxwMyE9BeDhw1efwGW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 00:20:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 06/10] diff: --patch-{grep,modifies} arg names for -G
 and -S
In-Reply-To: <20250212032657.1807939-7-illia.bobyr@gmail.com> (Illia Bobyr's
	message of "Tue, 11 Feb 2025 19:26:50 -0800")
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-7-illia.bobyr@gmail.com>
Date: Wed, 12 Feb 2025 21:20:03 -0800
Message-ID: <xmqqmseqpgjg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Illia Bobyr <illia.bobyr@gmail.com> writes:

> Most arguments have both short and long versions.  Long versions are
> easier to read, especially in scripts and command history.
>
> This change mostly keeps existing uses of -G and -S as is in the tests,
> documentation and help output.
>
> Tests that check just the option parsing are duplicated to check both
> short and long argument options.
>
> Signed-off-by: Illia Bobyr <illia.bobyr@gmail.com>
> ---

This step looks mostly good, but the option descriptions for
existing "-S" and "-G" have been touched by clean-up changes
earlier, so they cannot be separated out.

We can treat [01-05/10] as a separate 5-patch "preliminary
clean-up" series and discard this and later steps until the earlier
half lands.

Unlike other earlier steps, this one has a decent title and it has
your sign-off, both of which are good.  And of course it is very
much on topic.
