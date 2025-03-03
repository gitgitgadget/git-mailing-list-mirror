Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D1D2135D8
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010855; cv=none; b=jW8DLxEHqAaVxUHR/HMxcDbOBltA9fxzg1O4S5q7omoTt73831HpTQMXkNy0GCi+FawOOBICiPsBRFdyFMZfLYpZTDAouznUtR7vlyjxeZl/UMNBid8pD9aEHgM2G++wIniGRqd5IZUSeSCirY677eoYKO46O2UyZ8lMSfzsNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010855; c=relaxed/simple;
	bh=FopOMGO8LMhFw1n1wnMui0sVs0GLdvrcXnGPVWAZ3QI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JXm+4kh4LETE07DmPbfhGkNQpIkF2CIP3nSChoKoX81PDtUl71OYfUlTi0yAoVxd0RjnbqFi5q/+6KM3EJbZNN+N4QHmo6kPgsbY17zQaYpkdvzrGChz9MM1eFGGbU5xYqYOsYYMsq2wa4eYkBqP3a4fxfIBObpiE/iW++Ahbjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xRmbP2Bi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2KAy7lNt; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xRmbP2Bi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2KAy7lNt"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6BF7254015C;
	Mon,  3 Mar 2025 09:07:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 03 Mar 2025 09:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741010851; x=1741097251; bh=FopOMGO8LM
	hFw1n1wnMui0sVs0GLdvrcXnGPVWAZ3QI=; b=xRmbP2Bi5aDhkN5nHnfpjuZc5f
	sx4ytSXml8UM5aNlYl086GROOjgIq/3b/9bYcjE2M6pM/WjqUPK43heBDtfWVuTi
	kSeZzAL2Uxwy8fgkIH902HD9TOfR0e7xpebkmYMTc8sSxuOA0+2+hUxvGsSIG0Ua
	JGn1mZcppLps/J+XQhayrJOMOINK0w9fsqv6/zsTltsJj5jtM7AqzbOO6K0gDtiy
	oAIIENWKPReInxLPj6BiwF11Ph52PHfDKPiHdKNpa4AEzWpCBJCDjnlReQTzdB39
	U/AQ3BVLmtqkZHSSFjRNSdsED3Uaz1RTdxPARUuTakxslv1GyyKRYxkbL8lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741010851; x=1741097251; bh=FopOMGO8LMhFw1n1wnMui0sVs0GLdvrcXnG
	PVWAZ3QI=; b=2KAy7lNtqI4+0ZAGIeWqjXnQ5hDv5pmArphUom+7igwd22CZH1T
	FZECiMwHoLkjB8yqglPL0BRXW+i/98DSh3nqrBSJlhNalOTDbnhBOvr4YMw03Ibm
	xVCCNLwikOUaw4QT7CTqnNnhBZDkQmuwnbxzQ4bealddU/w7F6ZV3IFVRd7NZxD8
	6Wj2y2RM/Xbh5rbj5b5v3rrSgf4TRoJH5StpJdHwXZA4ZOqb4fMK+esVDyO+hDSq
	BejWepNC0qzF3rjMsid/LFyuPhRZV5SjE+piXUaZpmW6+9zW4bGh62Q1Ogtncel4
	hIv8BdBvF0jlPmgKmEcin3EjsHWQQTboF0A==
X-ME-Sender: <xms:orfFZwFc8Va50ko86wN82o5OCaPOp10wxV4oMQWGPYO7hXi0qG_NOA>
    <xme:orfFZ5UuT9Q3JzXbYvo8k5gEf_V7Bu87v2lHzx6N1yvDKLFx0O7PedsL0NyGLVsr6
    J2meq4heTbq4Va4Ng>
X-ME-Received: <xmr:orfFZ6ILTahtiudC6oRmpZ6UiP2Ezesn6_R1oShbf3JjECg8yCyXTU-JX4bhnjN8bxDOnQtwbP-Xn6rtcG1AbFjQg8Bi-0-2P7r0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesghhruhgsihigrdgvuhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:o7fFZyHsfFuuxhGQQNj6Ze1-Q_wCfPBdLzAEYw5qD0sifRKcZogn-Q>
    <xmx:o7fFZ2X0BbklIDvXzFXl8cAkx_ys1UWkqbqTaEIjdHHMu9eSeh-d5g>
    <xmx:o7fFZ1NpHoW5NmJJs4l90YNWm6srm6Iy7JzR9WIDkNVON8OkKLdauQ>
    <xmx:o7fFZ937tIUe5YegvWcdfmzGk81RRvctaNExAzad8OVavDZ9KfziPA>
    <xmx:o7fFZ0xJpaMnqLYRONsa67fUFPE044vJFbAOzKTtA8vJoc--cuFOrMw7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 09:07:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael J Gruber <git@grubix.eu>,  git@vger.kernel.org
Subject: Re: [BUG/WIP PATCH] unit-tests: use clean test environment
In-Reply-To: <Z8WFcaEtMCD5C0EN@pks.im> (Patrick Steinhardt's message of "Mon,
	3 Mar 2025 11:33:21 +0100")
References: <e3be6705d103ccbc165d0fd3b9b7c818d14001e9.1740516033.git.git@grubix.eu>
	<Z8GVAjwZWOM7c2fR@pks.im> <xmqqseny40kx.fsf@gitster.g>
	<Z8WFcaEtMCD5C0EN@pks.im>
Date: Mon, 03 Mar 2025 06:07:29 -0800
Message-ID: <xmqqzfi2xl5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Maybe. I guess for unit tests it's a lot less clear cut as most of the
> tests won't depend on such a controlled environment. So sanitizing the
> environment would be a good enough first step for me, and if we see
> demand for making specific information available to lots of tests we
> could still start to expose those at a later point.

Fair enough.

To put it another way, if you write a test and if it gets affected
by externalities, perhaps you are testing a function that is at too
high a level that is not a suitable target for unit tested?

I am thinking about the recent "make repo-config callable with
repo==NULL outside a repository" topic, for example, and I suspect
repo_config() is in a layer that is at a bit too high for suitable
unit test target.

Thanks.
