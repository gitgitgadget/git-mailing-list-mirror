Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471375D8F0
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445255; cv=none; b=qYqnIsDleWmeWTqiox1sLuT0t5iJCsP/EBw1LA3A4c/4lPOBRJXlAQ6xaHmU87RUbYS+RIRuKoOcErQTqhOQhAe1h0m9W2jzjRZGCh91t1KxQBjQrqw4sqYFIjpZymi9r6aNC0e7KoeVA4CwFNXyutaMiGugm6EucVNzCrf0Itg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445255; c=relaxed/simple;
	bh=plYInlro3TixhKeKIp5QYIMNMrH9jPK8TQ3+j/lUzn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aP97apwVXgN1Nqf7NAbudB6s2T444LKIMaAzct044mFF4fyEInjdnX3R2MMz+SXcqSwz3O9UnzUnKVgtrLf4tMZIEEPyRvmuK+UEFHws4+03MIJuy9kJwlRTHQNBU8qdQoL9OuLPcka8x83lEvNlvAfGbdj4iRfA2foZpcaEeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DviUmtgR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ke7bGq/+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DviUmtgR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ke7bGq/+"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0BD112540123;
	Fri,  1 Nov 2024 03:14:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 01 Nov 2024 03:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730445251; x=1730531651; bh=wPoi/tmyUe
	cpJY3n2FeKVirsjJ/piVJVVNgFGYpj7qM=; b=DviUmtgRL7N1VgYgDPFEpe56wk
	XKt1otojhjunATlWS+uHIAFPBjeFs32yK6cVQqib4mXKJffHWY/St6RSc6JEj6Fh
	GaEBcwtzhQURU1cW8knPqSvjC1M2Cx/3/e8/7+JgJ1wO9FnR8zMeSrZSgx7iEXqR
	+lUGFMjg5pY2TmD0PaSKe3FHdwESt+jWUSoPawkOUkrJvJYx2pmCmdfYxo8CS08F
	xTqILyhUTihhtFqP2HLXfjVc+AFervz/ASMVHRM9dgkj8pc4nNSfbD0zVmDN7fM2
	xX/6xYoqxAnxMJA8GX0F9C5goLZN/OI2haa9LRhT9FMOj+Qe902tywx/2DiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730445251; x=1730531651; bh=wPoi/tmyUecpJY3n2FeKVirsjJ/piVJVVNg
	FGYpj7qM=; b=ke7bGq/+avUxG8k1HQnni6o9eKit6h9gFKjOcbeDe1gJo1PzAFn
	N4eTUW/BbgpwuIOunCXY0r1WSD95QIiVoe9BDjrJKOGvDxSruDuh1adqyj8cM3qC
	w6/ULEJu8calPakkxjQi+29ub8wZmyczTokqpb0c0YZ4dFsIdrOLIVVBXgG1vpvB
	1lP6x9OjPZxKPJxwWbwMZxJieJIda13RTAAZwcTfZ7SsvvR03j7X+C0MqGMXiTH5
	pGV7FZqV+ErkFGnyiNUuKNnPq8Hzi5XK2DliGuzpPcqFtFXkpU2xamt8PHOy4676
	wImiTAFJDjwLl29MrYqAJJBF/z+IoGFOUUw==
X-ME-Sender: <xms:w38kZ0P324wTs6DiPC3ZA9_Uj2Zmj1ehqHW38JVQSrTzt6KQIHj1WQ>
    <xme:w38kZ6-ViO2Isq_oylvr6Nfo8jrg46Ds9-VU9Tx-CBbG4pwBPgDdcwNYFOXxB1sT1
    cHuo9ZUEkCBrj8GrQ>
X-ME-Received: <xmr:w38kZ7RNV5A75976FQ-QtAWsYOFjYaRmsy41zuYeeNNkhiaInAFrqW-Ej14fij71IFRrDACuVrkgX7Nqc6Cs2BnYIe-lP9vteHXX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtugifhhhithgvfe
    esphhmrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:w38kZ8s5z-MqzUOwZyhI_VJxm2-bY8GYt3u4jzutNoY6OrKXTG1BvA>
    <xmx:w38kZ8fBj7oVKIKj9RTZXzWkZqDC4SZzxf2qnJLfHfmKcMnDUsLoTg>
    <xmx:w38kZw3oqE3l_qkEDpEzWiaeFLnqA6JaNpVFyy-6Hpjirs8HzJC1Hg>
    <xmx:w38kZw8NAHbYk34lPWUw4QW-p-Wh2cNoPKu8A-wHHGEDE4QnHJH3Og>
    <xmx:w38kZ0SzkVGRxPcjahVGOCTLdqMteB7sIsX-2COas2mduaOlO1ZRZpEs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 03:14:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/8] Allow relative worktree linking to be configured
 by the user
In-Reply-To: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> (Caleb
	White's message of "Fri, 01 Nov 2024 04:38:15 +0000")
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
Date: Fri, 01 Nov 2024 00:14:10 -0700
Message-ID: <xmqqzfmj2zp9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

> The base for this patch series is obtained by applying the following
> patch onto 6a11438f43:
> - cw/config-extensions topic (doc: consolidate extensions in git-config
>   documentation, 2024-10-22, <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me>)

I am slowing getting back to speed, but with the above I noticed two
things.

 - Do not encourage people to _apply_ random patches before your
   series when the official tree has the same patches.  In this
   case, you even know the branch the official tree uses
   (i.e. cw/config-extensions), so tell readers to _merge_ the
   topic before applying your series instead.

 - The notes/amlog I snarfed from the broken-out repository of
   Taylor does not seem to record the message ID
   <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me> Perhaps
   I was looking at a wrong repository?

Thanks.
