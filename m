Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6AA20309
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451827; cv=none; b=feRdAGEWxXZGyLUcWkDeZZCx4t3ycLoGiLGJ8JZGJb7VHZPlBvC4KmQXtnh9KTDAyI+LndP66LfABay4I1caUSdbWsi4vMedE+81JB6amk892CY4lJs6ugu8mvs+L3rgQ4hErDS444uxceT2+gfKmLIURyf5V64OdnlbctsfNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451827; c=relaxed/simple;
	bh=PjDtKV32P4iqThO+lDd8FfVzpkQkKgSu412EY6+p1CI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=teFJmpgWvkh8MVVeTna66D1owWVNIBJWmnMdqVy4kRbBZLJJ6yAKGoS79418p334MtJpWM0PwrmGAurpdDg5SnG9LyLbPbhoUYHDTAtwU5n8AqcAdjb20MCz0WC7fPIiHVW9JHduaPMXLNApcyi2SNFkrVY1hheg3EIEl5eoGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=slNq4/Ka; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="slNq4/Ka"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D752114012E;
	Thu,  5 Dec 2024 21:23:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 05 Dec 2024 21:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733451824; x=1733538224; bh=t5b+UTguPGe1VMCSSMQAU/VJ/1p/su0Cqqb
	3YmUionI=; b=slNq4/KaOxyOLsHzp5KLCPubcRYeUALK2IZemaamIglYtgz/ePG
	ZZ9K88rB3jy/QWVu+Y3SBw4fjPv2yoo2RSacnSWq2IpFL966e9G54t6q/G9naQnG
	bWILfE4N1oi8RKFCYQjyUFhjFw72fQ3Zvsq8zpeZM41zC97lrEAOYzEbPG7xbOlS
	UW8EueypRFaeYDopGDhLDmPr7shaFnNGRaxGOk3MJEpAwNe/0/ZWqeSONPTzWIkx
	GtZAQNp0nilyx/u0xdNGg2oNzo5S8SMdcaiC/bbOGttZJRQnFImO4FAO/+swjh9S
	OPEQmky8QHI9fNlk09r/dsIZCeRMvcL5w0A==
X-ME-Sender: <xms:L2BSZ5aSYJcxWfMMaIMR3vNdzF10_F_IuZCMdPMi3_H8EyuT5gKe9g>
    <xme:L2BSZwZKD7ZKReKxAJk1zerS9coH52r2XOiCoq7SCVphJhVYx-v59gHPaTyEEBrx-
    xAMgIkUSjwo21Bahg>
X-ME-Received: <xmr:L2BSZ79A7KlBR6zB51vmX6vytyJ2Jz1A3iGS5UroUj4tD1bTYk9fcqXk1shxYtvUqxbdMk5bObe68bbAGTYZCOL31cICUM8ECeq0ixQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvggsrgdrfigrlhihsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:L2BSZ3qXujJhF1asR4bWdHlCEqQdNOQjQ9daUdv-S0rcbpEbgi5iqQ>
    <xmx:L2BSZ0rfRermO-nqySZDCLOq-LcU5MzLCb9Hj0-8Koak3YrjBFJgOg>
    <xmx:L2BSZ9QqewuJ_O08e8G5ZoE99dWhSzAkLhhN27HmL7kjhPvO1iTT0Q>
    <xmx:L2BSZ8pF-VGw115WYZOB3ImpEESKs8ErqPG-LPp4BtrDUsiteXSttA>
    <xmx:MGBSZ8JhlxVHv_ootJciOep3Vcs7wRR7bq8Gifk0pYqTUOxfkzYaGmbG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 21:23:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  Justin Tobler
 <jltobler@gmail.com>,  git@vger.kernel.org,  Heba Waly
 <heba.waly@gmail.com>,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH] advice: suggest using subcommand "git config set"
In-Reply-To: <Z1FkrsQ5tkz1pFUz@pks.im> (Patrick Steinhardt's message of "Thu,
	5 Dec 2024 09:30:38 +0100")
References: <20241204130928.1059851-1-bence@ferdinandy.com>
	<fsqe37ibvarrsjugc4r2cairndr37cmyc64jneaqzhkq4qiiqd@6rskou37aqat>
	<D63MDD4V1FLQ.SL5FXZ9YS8J6@ferdinandy.com> <Z1FkrsQ5tkz1pFUz@pks.im>
Date: Fri, 06 Dec 2024 11:23:42 +0900
Message-ID: <xmqqplm51rdd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Yeah. Overall I think it is fine to do an iterative transition to the
> new interface. `git config set` is not going to be the only instance
> that needs changes, but I very much assume that we will have suggestions
> and warnings all over the place that may recommend other modes of the
> command like the equivalent of `git config get`. But these don't have to
> all happen in the same commit, or even the same patch series, from my
> point of view.
>
> Thanks for working on this!

Exactly.  We may have to keep both old and new (more explicit) ways
to spell the subcommand, and consistently using the new way in our
documentation pages and instruction given in advice messages is a
good thing, but it is more or less a clean-up effort we can do at
leisure ;-)  As long as we make sure we finish before we mark the
old way deprecated, it is perfectly fine.

Thanks.
