Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE61FCFC2
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276524; cv=none; b=FppTDDWksdAOOEPkSKjePM59oMhD+YNbrlhxDBeuM1/Oi1xlMAgHVvaNfUtZOym+4XQocMzM8o79KFdPAR/iI7aBsAbiQHJkLGZXn/jKwtmy70/xuO2f9vCulzGX0SvJ2it6oU/0LMXNadm/ji6vStbyWREiquCnmPx0dLhPE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276524; c=relaxed/simple;
	bh=BfIXfczMgZy7nn9Q+vl9/VGEEF/yZHOnQ1Ua/6Z9a/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf3Hjtkye+DoYd7KFe1hmfN8uFuX6nHt6jLeQfdf0amrfpTs2LvRcNDFGzDR3NGy1Nh//QIFi/JSKhBQ6citX8JJCK5jxN3wTMcESp0bAmmAo1B8jrROReMPck9rIRQgiyj+zUb9dLSJR+hD1ry4WdQn1RaFK9pRi27yrQMLRZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mSJzK9Bq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JNTqlzA9; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mSJzK9Bq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JNTqlzA9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C89462540139;
	Tue, 11 Feb 2025 07:22:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 11 Feb 2025 07:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739276520; x=1739362920; bh=rWRxD4Z4si
	kQpyRMcfqhvWQLTrjAolV1vpZjdaQQTTw=; b=mSJzK9BqhrMg0uGxcmbpDJnK5g
	xXG7DzckJKFptLz0WHo9IP2lggneQC1mqhGVtXkkBbmA6HNQY7JydXP61E+oWh2r
	FBj9i9zwWt+9sda+LmMOxbFuqdzqBwnyyXxDh6XvRkYD5q9hRs0BONWakIPQjJmV
	xqhoASEuBHQJOZNKaE3hJl5zPo+e47XgGAYg2O83Z3rdNimMgjHyWc7LY7raSyLd
	XQUPHdy9/nnWa5MqfGdcG+qD3n5+o5+vM1QmN9gmoJN79ZU0hX6Nx+ZXiRUgy8XZ
	PesLlfj9PU3xsSPJUI/pQuJtHklfvIVXGlG+QBs3S2RHIgsZH5ql+B7KFiUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739276520; x=1739362920; bh=rWRxD4Z4sikQpyRMcfqhvWQLTrjAolV1vpZ
	jdaQQTTw=; b=JNTqlzA9tPWsHUqc+6FKOvg7UBmYCAz/kNOBSwgnHcvYz5z0VJw
	22J0vuGjkeXKapnrSKQikkN//sw2n7x2jByoaKsX1MfM8jwxxb1Ai8JUWErYY9zH
	IppnOXB3KWP4fGLcPxtNkzFCqfQsYFBBWxJbooXLC7uBLEfiyyqFjXH0AKX1p7Td
	kdWK/ElbUSMahX2d6c5vYGeLX5xgid3ugtoYHgSJCoFn6CNkXyvGvcssT+XD8PnZ
	YF9xGj+zHXmJRonhdfjM8kndnXzpzODsO6hECWrBGpLwy+ZvaXPGFVDuB4yor+XU
	ZX2doEafS1EWaBQybcBvaUXSnB7je4W9U2g==
X-ME-Sender: <xms:6ECrZ6sEqDLNr6LwfdZTrYqquQhXNLi3Bm6DoRuMyfwwwYc3BAPKWA>
    <xme:6ECrZ_e6VWWc07XIZmV7T1f9ncsSaWYgAc39L8TWH-rh3oCIRI1ITcSrHUiyMQ-Rw
    64MPQYB7gIeMmIZaQ>
X-ME-Received: <xmr:6ECrZ1zdjrC_IpKpTWBtY8XZoPpZfDp_394Q84iznNL4up9-h4hrw3iko6_olG38nM9LWnA2MDLltxDvOB5oMWya9fpgno9UxWOnhUA1A5auKrUh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6ECrZ1NUaKXhzGJRQQHJCtFTaCPY_RYTZC7mhQUMDRo9VAgjekXBUQ>
    <xmx:6ECrZ6899htEtjjN8ilbcq5nI584cLwtijc26aRPNa0BnnC0MB_pHQ>
    <xmx:6ECrZ9UZfkOoPUcq5mGDrILIzKrShT0HEJgsuBbO5G2k6gVMdNkdog>
    <xmx:6ECrZzfv3wBBtHIqA7BMp2-rqsnQOMnWfulkNIYi4ten9wWLf2_HnA>
    <xmx:6ECrZxYFvvFmFYJa4SfQEtBssp3wOpxoweczTSZ3JU9V4aHY9RU3JJUN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 07:21:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01b2d97d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Feb 2025 12:21:56 +0000 (UTC)
Date: Tue, 11 Feb 2025 13:21:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH v2] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
Message-ID: <Z6tA4zC4WhdAVbPD@pks.im>
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
 <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>

On Tue, Feb 11, 2025 at 12:42:18PM +0100, Karthik Nayak wrote:
> The 'git-refs(1)' migrate subcommand, which transfers repositories
> between reference backends, currently migrates reflogs by default as of
> 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
> 
> While this behavior is desirable for most client-side repositories,
> server-side repositories are not expected to contain reflogs. However,
> due to historical reasons, some may still have them. This could be
> caused, for example, by bugs, misconfiguration, or an administrator
> enabling reflogs on the server for debugging purposes.
> 
> To address this, introduce the --skip-reflog flag, allowing users to
> bypass reflog migration. This ensures that the repository ends up in the
> expected state after migration.

Thanks, this version looks good to me.

Patrick
