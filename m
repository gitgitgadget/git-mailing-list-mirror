Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E7148FF9
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729490667; cv=none; b=qFBSqKX2orqPqqjbf83k7/NdF+YMgDOwrLprG5iE6bsBj47o3iVuXumdBnJBIsP5tQZpAUf1bAop6FG1OAiI7cau7CFCNOQx3SXe3/wg2xhpkWCYiyQdbUuxOQQWutS1cN6Nia7TV6MwJDiXiPRMYbkN1Ygopm6r9okXrqyzsnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729490667; c=relaxed/simple;
	bh=62m4f0VlyS3VW6CHQ4oqLRWuFpgFdGrRYEu13mXJcMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzzzhs3SvPK1Gd99/J90esBidWY8UJoXvUCz5taSYdef6u60ajYKqFSUw5s4vjjGDGwf1RZc7DWXGASFmvur2+272gS5KyA1LTrbhTjP+EUnh6z456P63PlJ89UvU1nkK95vpyWlnzctCGU6hUpvBi0Pnzz0X6Nb0QRbpd9UKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SotUpXIm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJblHzuD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SotUpXIm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJblHzuD"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 056511140113;
	Mon, 21 Oct 2024 02:04:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 21 Oct 2024 02:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729490664; x=1729577064; bh=62m4f0VlyS
	3VW6CHQ4oqLRWuFpgFdGrRYEu13mXJcMs=; b=SotUpXIm/i2yL/gQl7QO0iHADh
	psQO1KrECHsEIULm82qyt54BT+sdiCu2CLRaZkWkP5McIk3az2AWulAeuSmlk9aU
	utjxkzFhRTKN/TEVRI8cEnjsYanjqnYeNsEW25Wkh+5kQW3hFKu0o8CzSQEjTx9B
	nDtsbjtG4RJO4n706RfUNvxmHXF0Nfu4H+HCeSmyzxFO7RNX+hu5G3jV8ma7PzG0
	ttFNmHznkSJ0Yxcu1717DmB5VWkvQ6EyuIuWYvx0n+AeZ2a4xihjqG4Ou+XGffAb
	W5UF2pAkfr9CZVKVtUOsNGWMLaUOrUm+aFZYc9VP4/uxVY1CxwL1T9vtr7kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729490664; x=1729577064; bh=62m4f0VlyS3VW6CHQ4oqLRWuFpgF
	dGrRYEu13mXJcMs=; b=QJblHzuDN1o7dJv6k8cPFJtRM7dX0gGJl1D+heCX7q56
	s1ZjTzFQSMzu6ePf/D3UzAMW/s7mdGblZbqj0dABmbWk9Q+5+bDwIRU+yeT7pXza
	iY+GW9CDtFU1qkFr8eRCePugqHg5UKoC9W5KXjMBNNl7ggKGDCsHLSV4TdbVxkn8
	M5Laq1whfqRUdzAjdo2y1aUzfDXLFzQY6rigMO5wt0ccRxOoZOEf0ZbptNdZ+lK2
	GB3p9bEcLURTYzA4mG5GUUU/E/qtuaqQcivjhd7a59QRExujngStjudiJeN258ly
	H44Gd6R2/5tyYpttCfbhkWf8WIUsYv6U/wowrH3Tlw==
X-ME-Sender: <xms:5-4VZ-YnNqOSkTLDt9CiT0gmh6tka1XusPV7DpqKuGqso3NLLid0Pg>
    <xme:5-4VZxa95akwAcny9KJ1IiI_cEw5r_O-DPhFay6lNdwb11-zEQAzu4QM9s0B5juvS
    UBcPqqsdT4KvlHY5A>
X-ME-Received: <xmr:5-4VZ4-eWxrmZY8dTP6EtOnLZmCrX9fPyqP6u2Zmq60JPDNizA4I9vSLQhntoLjz2UafLR5KaUZEBN_Wc2snvbd5c9ZZuADinKacESNlpBeo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:5-4VZwppLvzHO3XeQR583Q1s92QHv9MyTeA_-lVUJR9S4Z68a79-rw>
    <xmx:5-4VZ5p5nc8bg_MRyP909yT0qyeUBUXNJzrSsJYC2-uvVAWUkEOUaA>
    <xmx:5-4VZ-S-Kwi4NxImNHRJ9NPP7SaUTjc7X67INFPLX_eSza-2m8d1fA>
    <xmx:5-4VZ5qw7uw1_k9AzuCmeHo5FIEGzrNGSEABnUecbp39O9zhNLuEcA>
    <xmx:5-4VZw1g4IcmS2CCvrkx3tuPY_2cvM-_uScALckcybq3E12IwO1jl2oR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 02:04:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5976fe20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 06:02:52 +0000 (UTC)
Date: Mon, 21 Oct 2024 08:04:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] t/meson.build: fix up tests for 'seen' branch
Message-ID: <ZxXu2rG1ls8UcXug@pks.im>
References: <8b08b64a-aa5a-422d-9815-e67911a703e0@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b08b64a-aa5a-422d-9815-e67911a703e0@ramsayjones.plus.com>

On Sun, Oct 20, 2024 at 05:00:44PM +0100, Ramsay Jones wrote:

Thanks, I'll pick these up.

> Hmm, this is going to be a PITA as far as maintenance is concerned! :(
> If I am reading it correctly, the cmake solution uses file globbing
> to get the list of test files to run - could meson do the same?

In theory we can, yes. But there's a big problem with it, both in Meson
and in CMake: the instructions to deduce source files only get executed
at configure time. Consequently, when new files get added, the build
instructions do not get updated accordingly and are thus broken. So
CMake does get around this, but not in a way that is feasible for use as
our main build system, and the same would be true for Meson.

For our integration-style tests I'd be okay with not listing the files
individually, such that we instead use e.g. prove(1) to run all tests
via a single test target. It would be a regression in functionality as
we now cannot easily run e.g. "meson test t0000*", but at least we would
not have to maintain the list of test scripts anymore.

But for our source files I don't really see an alternative to listing
them out explicitly. You don't want things like git-rebase(1) or
git-bisect(1) to be broken just because one of the commits happens to
add or remove a file. And this is true for whichever build system we
want to adopt as additional official buildsystem, whether that is CMake
or Meson.

I guess we have less churn here anyway, and we would notice breakage
more readily because things would stop compiling. So this is likely less
of a problem compared to our tests.

Patrick
