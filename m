Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0CD24A078
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477568; cv=none; b=qjNEM/bR6haZ52aMOn6OpmokAAyrPfwq02p5ITHVrfkUiIVGBx4t7WIk06syvjBCoTW1uB7Slzu7ooUmb9Jp9Q7mx7Y/v65Jd9MQZmJVzhT3fsMcK7lcSitRh4O5ct6iVgh2r3+6j8lDoa+4OhGVQ43M9L+irWsZF1/pikr3nUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477568; c=relaxed/simple;
	bh=YBCIuoHKE94i5y6DZBqW1cwTYYkdKg/0J88wiscb0nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ik404IphJw06Fi2Om1ydJXIiwQbsRcOPv244EHon2EHGND9kELBDuzbCiGxR7E8kQaZu0jowmMjIo4V7I95lr1QMMKmCCaZP3BQQ1M8TTlCg+0A8a6NComEYc0BBmC+YHAySMrzjSnRd6jaNt8vwYTxamHrXsWN7Y4cYvKGydgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BYlILsnt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=an5U91sW; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BYlILsnt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="an5U91sW"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CB762540164;
	Thu, 13 Feb 2025 15:12:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 13 Feb 2025 15:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739477565; x=1739563965; bh=3UBhQy7ZJN
	tG0bJBrnT6wPjiFdlsA9PrPC6+TUY0cfs=; b=BYlILsntuHUSDD0mESNdJkUiAI
	0waliwD8H+il6DFg5y+zLuP5ePtFd7mUNIHSINQE4t+MiMFrQDmtLh0Psn1Geyqj
	ZpJLqzzw7ngEBfvdASEBvWgZACjQil2ZXcrN9H5AHkqlTfLBpP9vVaId0yp3CzRN
	wNUBpd4xfZgUqgmZlzO4L9Zn/3brm+r6VYnkyTQ+1FohL0PN3KWcXo1n7fgHfkEr
	hmz/I2NEkomF6LQ82R9NITHnmc5wZen1HwfiHUd4gbUvAXT47HqmN8aXdgf8eV85
	Jxzh3mpywHKuySLJTErPAmfj1JVJt62g92rV1okG0Z5W0yfdJFm7+uJLtg6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739477565; x=1739563965; bh=3UBhQy7ZJNtG0bJBrnT6wPjiFdlsA9PrPC6
	+TUY0cfs=; b=an5U91sWdNTa9OjFIpJyOMaY3od8gULRuTaoKQTcHs4o1pPobB5
	xI1oAYXVsxtg0LkD4fdbNQmI3fditQBPAurH2Uj++Ve78ihSXxiRdYJ2O+cs7xRQ
	0ggINq+aKe7iL9wsBC8riqF9so4Ao9W782rsMi407EyPJp4JzDGljGCiWEdADCYB
	1LnVxTuvqdwKr+P/YkPru64/r6EOJWGSKfvAfh+nOOqk+/OOE5YYgozX7PkHqWZP
	Ou3i1aecgVpvWF0HbgpTSo/PMKCwTBpSAXnGWR+LGMfHADVj8+XRU25lhLvkdpog
	nTrkrVpBlrVY9KJObdZQlVWh0SFoSMafLew==
X-ME-Sender: <xms:PFKuZ_NUuf9nEchfZHMF-VEjzzsQ-tcjcnxe7rK4qOTiVNlgLc174A>
    <xme:PFKuZ5-ZNbY37FbpM8tTVMdIGyz4NQgHrt9m28qzouXdQx9q98EcPFnlCHn-6C67S
    tUQqO--bTG4Ee2LaA>
X-ME-Received: <xmr:PFKuZ-SayzQ8Fq4RYaC6T-fkXUGO3QAy8SFv0JfqsJj44itMcc0DCZiv_YDi0rVFEqiMbqp4wgmuQnRUJiTtN0c2ALcREn28C5BkGag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PFKuZzs37S5glZ0LwBWd9cPbdNz0F1q-GrzAlOMbMbNQqR2DgWuJIQ>
    <xmx:PFKuZ3dKR2vHXVTs29Ku6c7_IW8RIKnNbNwnnRCzUr5W65bpDmEcpA>
    <xmx:PFKuZ_063BImK2jByYRCz99Q6CFOr79ai5XC5RAc2fGuiJROhE3v4A>
    <xmx:PFKuZz_9nR5ZGkELADrJCeo9ApjqoaC2rjfFHvJojlpLw7GqOXGwWA>
    <xmx:PVKuZ_TcQarABbuaQA32QdF1ERZ4Cif2fD-ghTQJVyLs3wqiI5JjgqPo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 15:12:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: Poor performance using reftable with many refs
In-Reply-To: <20250213194256.GA934256@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 13 Feb 2025 14:42:56 -0500")
References: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
	<Z62NFXja4CkrxSil@pks.im> <Z62booOOXODOl_sZ@pks.im>
	<20250213082221.GA916028@coredump.intra.peff.net>
	<Z63VY_wa7Z6lrUfY@pks.im>
	<20250213194256.GA934256@coredump.intra.peff.net>
Date: Thu, 13 Feb 2025 12:12:42 -0800
Message-ID: <xmqqed01ob7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> ... I have trouble
> imagining it helping much beyond something like:
>
>   git branch $some_oid
>
> which creates refs/heads/$some_oid. But we probably would be better off
> warning about that at the time of writing rather than checking for
> ambiguity on each read.

Certainly.  Thanks for a well thought-out analysis.
