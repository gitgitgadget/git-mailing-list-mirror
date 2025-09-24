Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BBB253F1A
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700574; cv=none; b=T1VyIhIfYPZBvBn6nAPLMPd4CHgBGLNLcblOtzBVB9+IsQ+K2MZM/9yxy1IzpV0dJ0DvhbXhYsVGXcSuPA8Jpc6/JlexHc8C7ny1QyJVxFrTW9yMeLF9/YkTZGXhG3rY3sCD9V4w97DfB6VHh0s94wMLeaQcFpqT5fLqJctPRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700574; c=relaxed/simple;
	bh=Tx8hMadj/0qYznlXm5P3IJG4Da9Grgt3O9ptF+SfOcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG2FOnqE17phGmNDZR1xXj/KmElqmhqW79T0uKob4zhk9w68WdlBcQN9CxktM15pKozOxTLXLQsd3V1NzEixvgBRLepIQQ13wf32YFWePRDB5Pyhvk2yEUfzuomH3+YrADj2XbgkomNxSSLKCIIk822tbPlpg1Ynn7YjYwWn3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KpoGpa6T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OOBu6Kh5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KpoGpa6T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OOBu6Kh5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 16A09EC00A6;
	Wed, 24 Sep 2025 03:56:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 24 Sep 2025 03:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758700572; x=1758786972; bh=7BmxqzZJ40
	FOX6mG5FVSzI7YATiwkUGvC9TiTvIgRqE=; b=KpoGpa6Txr/9x38SQsU9PNxHsb
	k2x3pnKoaSuWr0kLhAre4udcrmR6rrdnztt6OqmLbXU9GDBOyirX0sk26/3hGx1g
	ddzOIsuPQS6gjpjSz1heAcLl3iXG/BfHnnCTg63I4ckXzsI2CCIP+EowHz6LRxC+
	tqkgbJP3qNndC7ddnDkrElt/RG0EaOvi49swJmKwo44Bb0i0A/jmnijlg/AnyX5m
	Xvez5VDDlKpENEo7igcXZhR4mxo2H5eoGJ7+EUPY6tv8fnXkJv7al+feHxipOhqq
	1iJvnsbaLTbWSKUOHGAgUfsRRryy0E4X52wa5JaEa4p7jBv7sT/aqhREwgBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758700572; x=1758786972; bh=7BmxqzZJ40FOX6mG5FVSzI7YATiwkUGvC9T
	iTvIgRqE=; b=OOBu6Kh5CYOEY5MKkWe5zVJ0qMCkOdfAA85UCpcAeObU1TLM+Pa
	ziZyCjy+QfgIx29Z/nBNGxocmPnzKTh8j1KkSUXjDQB/4YMcRPmbalyE/kizZ1FD
	ZccPjkRy97T+likJtTueQ/ieUzE7/EomrRzO63Qc0KdOBX4vzBfD8n5CTdDs4Hnv
	BXTR6+zYY8xU9UuFWLgHWEpwOnXklKfjKkRlyDd3u3tnGE/pEVJCxVhv5wD0HOt6
	KnjiQL2V9ZfkdUuWra5mGlROL5YaP9Ggl8K0DUvl/Cpkufkq+QSVL4uvQuDmGdfI
	wAZ7i8CqkD2k+44niOd7px+WKtHY6jeYNGA==
X-ME-Sender: <xms:G6TTaFbLDuei5DZvN2vnEK7u75LUK5nySWzFnO5u7oeVyjY9JaSAog>
    <xme:G6TTaDaYchZlRuaYK-D1veeszibMIxVNScNBlHd4cBmW0XZtOtMHWgXXHhtPnbLl7
    s8mTdGi6R0Y5xeB2E9CTuFN88E1Xk2zAKL6a81oZKxG5e-4yihzNA>
X-ME-Received: <xmr:G6TTaM9gPRe0oehP_9yEuPTJofj1SdT0PTgkN7-mS7F5Vr_OZbInrgl-oq6aUTPRO16Vww0tlmFS_Qs8QoOcOw-n91sHVStMPJpsphuvqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:G6TTaChAEKSLjLvXX96qgVNcEvFSu5hW-_4GKgM7FcB6S-ldBbZUxQ>
    <xmx:G6TTaMd2sPYZD1ymXg8l7GlMLHPIakd42Vqn6IucNH2p5uYZEezoeQ>
    <xmx:G6TTaJqq4_OCf1C8-3RqyDYKzVKK6vEX_p6yadX0qhjeyvyCkyOtGQ>
    <xmx:G6TTaBATGb0F4Zrkkflo1cpa_-9v4gDyqrB6OGHThDrjjeGWJ4Jenw>
    <xmx:HKTTaFMF9amhRuel76j7ZlkptWn3qDg8ZVUik8b9fG4B4S49W2qJHcCS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 03:56:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e902fa1b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 07:56:10 +0000 (UTC)
Date: Wed, 24 Sep 2025 09:56:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 9/9] t: add a prerequisite for a compatibility hash
Message-ID: <aNOkF7Isc7OihClu@pks.im>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-10-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919010911.649831-10-sandals@crustytoothpaste.net>

On Fri, Sep 19, 2025 at 01:09:11AM +0000, brian m. carlson wrote:
> In some cases, we'll need to adjust our test suite to work in a proper
> way with a compatibility hash.  For example, in such a case, we'll only
> use pack index v3, since v1 and v2 lack support for multiple algorithms.
> Since we won't want to write those older formats, we'll need to skip
> tests that do so.
> 
> Let's add a COMPAT_HASH prerequisite and define the BROKEN_OBJECTS
> prerequisite in terms of it.

Nit: I think this commit could easily be squashed into the preceding
commit.

Patrick
