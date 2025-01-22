Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30F74C14
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562995; cv=none; b=VKv3n6HAzMuzJaDO3cgpNAbHTMkWfl/DDYEYtCZYk/p5lOlBPWbMyIkaz67VO03yNLVZ52tOTJQiFEWt0NLx8mr+nZdH2WwgsuvXds6mrz2ayb8eRT2N+6GfgOzmrgQbW7/O/ObDl5CpoZFqZzBeJK/6aZ2Rm3nk1viihpWPfm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562995; c=relaxed/simple;
	bh=20+IaXS9/jDKEpvqVz/VY+kdzdB6bhsgQwpRaZBbFmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F6kZX/HYlDO4HokMgV/aA8if15rvpliRAflx1mlSCSNT8kMPTnYp73ZZ5RqohrH4bA9F6ZJbsLJc5vZRRObOPi4R/s2useklNMjeiEVG29HajZVMTAQKFvtBPF/0irn6kPAwsUGNCagLYma0+j2/z/Y3aVSoLRFSraLSmCH5eEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J0foTesL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MriU1M9M; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J0foTesL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MriU1M9M"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 44F471140169;
	Wed, 22 Jan 2025 11:23:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 22 Jan 2025 11:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737562992; x=1737649392; bh=J4hN8/sYiv
	Gvm4p1w6NXlcJOm6l88amjwYmihakDIJ0=; b=J0foTesLbUBux1XMnNVerorSH3
	IOC6fqLnMAGtPeMQyAtOomMXb+G1bvbUucfqXCBLHrDnHjwuJLIq1sgemqjZk3ci
	nipTFh6ybNVolKCCCbiVLNKoRHM6drY5Y+9P36B0dFVZI+E/iGAF9i4N6c13OBGe
	2ilIAEnEGZPibrprQweu/z/xJ+ip7FJ7riQTjzHXJVJFWZ/1D4O05rJeVd4qQYHD
	QLZk5tnSnDyyZFsNPatOwXy98DUavnI9pCvdoM7XNqn2s2k6xfvTeZ5NKKKWFpn4
	CsZI1LDr4LtId7K3U/OLDcOo9sBW2vcMpGU4VrLhEN0qWuBRHX94v+88IDfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737562992; x=1737649392; bh=J4hN8/sYivGvm4p1w6NXlcJOm6l88amjwYm
	ihakDIJ0=; b=MriU1M9MSeD88OHaoPKlJUbsR1A+AxzXoUIsGGIOTCPlfeaDeBl
	pLqcUSXv4iJgQSaJ41/Z34Gpjdpjp66jly95D9IoYKfeYly4MbicwJPhNDQiq9SI
	YJjySQp767FEfpXE3Dvpv9/BGg/mgLxIiqRC/rp6a/jWlXT/HDP0rOvGIiZAt73f
	+WvFnwfVOXj5tX3/h42oKFWkLpLyrZyB7JAytpQfcudfm0snHv/PWwx7odMrCgvu
	d/fhq76blrHm7O851iMFByhG6xIzJVG3HJDxnGFAwBJerjnrYAHLtp8l/X3D8AGf
	X5KOAbq/uxNeE96D+Tr4b817v5vYn7ogLBQ==
X-ME-Sender: <xms:bxuRZ54CtsCq_g2_7roxBE1v-on3FDug3xePzYu0SOhIY1KXTUYS4w>
    <xme:bxuRZ24td0lalQGOq1jVfU8WfVTsA61efKVJMT-NBWIgDjf94CC1grxcMBHLZQPSZ
    SM_XS0lvq3fBoVWnA>
X-ME-Received: <xmr:bxuRZweEV5dVjSLbyl4Cy6OQ1PXqelzC-OaPq7EIRWm6ALkNMbv_9kZLIG_EEbfxJCSp87MPokWPAFwx-pWAzzqTik93IthBegjD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pegtfhhjsehjohhhnhhsvghnrdhnohdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bxuRZyLtOB714VqQgV4_Bo00Ne5SBj7rbrybWgjXhwVs8fiBnGkLkQ>
    <xmx:bxuRZ9JH5VYHvr1xVz0cTphE866mcTUMj4BQtRfy4jP6O4Mc32l9ig>
    <xmx:bxuRZ7zcpNDMqo6MWgoLW3asLlr4ibCPPbY2ezVzUnI6KHc0IYD_mg>
    <xmx:bxuRZ5J1cOz0EFmM2thmNIKV6FLA_BroZLDYW_6LIL9HS9MmWRj9fw>
    <xmx:cBuRZyrv3l3AvgmvSbetxdttJMWRgqq0ubihFI_ZpBlZnFnboaZPtRCs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 11:23:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Fredrik Johnsen <cfj@johnsen.no>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [Feature Request] Allow batch removal of remotes with 'git
 remote remove'
In-Reply-To: <20250122030832.GA3322144@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 21 Jan 2025 22:08:32 -0500")
References: <DB9PR05MB110863344D3776D13B436F563C1E72@DB9PR05MB11086.eurprd05.prod.outlook.com>
	<CAJoAoZnecm5y8243R9JsGjRDuv-Mb=UAwa+Hbj5CKDKNPBLB4g@mail.gmail.com>
	<CALnO6CAEaOUNwMpOTF8wKVd7LAv+UiU5W62ZCBc0U-K_JhHU-g@mail.gmail.com>
	<Z5BW5ofJVbM1obb5@tapette.crustytoothpaste.net>
	<20250122030832.GA3322144@coredump.intra.peff.net>
Date: Wed, 22 Jan 2025 08:23:09 -0800
Message-ID: <xmqqed0uyg0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Jan 22, 2025 at 02:24:38AM +0000, brian m. carlson wrote:
>
>> Because `git remote remove` will remove remote-tracking branches and
>> their reflogs, we typically will want to do that all at once in a single
>> ref transaction, and hence in one command.  Not doing so performs very
>> poorly (as does, notably `git remote rename`[0]) when all of the refs are
>> packed.  If you have a large number of remotes to delete and a large
>> number of total refs, this will perform really badly indeed, since the
>> operation of rewriting the packed-refs file becomes quadratic.
>> 
>> The removal of the remote-tracking branches is also the reason that
>> editing the config isn't sufficient, either.
>
> I think the config update is probably quadratic, too (in the number of
> remotes). Each one is going to rewrite the whole config file, minus its
> matching section. But a "remove" operation that took multiple remotes
> could do it all in a single pass.
>
> If somebody does implement "remote remove" that takes multiple names, I
> hope they'll refactor to do all of the operations in a single pass, and
> not just loop on builtin/remote.c:rm() internally.
>
> Probably git-config could stand to learn similar tricks, too. There is
> "--remove-section", but I don't think you can pass multiple sections
> (and it's likewise quadratic).

Thanks for bringing up the performance aspect and where the problem
lies in the current implementation.


