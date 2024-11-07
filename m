Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2D6FBF
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 03:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730948897; cv=none; b=E1Whsh5DFDw+HQ9qBfsho4X9XMv97BBMsIxZxouHSdQGGf07jtMsldZk7R21bDFq//ZCOueiclLiZEtaCFhrFr9BIwH2I0Npg/yJyd1ZBtaI0yU+tjjSQbsBBXRu4C2aZjNlUMCezufmxjaZFBe5LBSI6TnMMbfj74YzuYqFACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730948897; c=relaxed/simple;
	bh=vOiV6deAYeCJrInfpqA+0JamMcpAjZCqx7J+W/zK24Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m1qDvlWkPN8G/pdd/hQkF6FEPB1ktdC5QaRXEDEFE+DRGEclCtS0ALPJWLZYLyaDe9I+EGTwlcltuxkvpL6ohLpfc8kxcyJ7h6ldnfair5/o8IUctvm2TM3AOWnA74MZcdk5AoQ3CsiEEfBBfMpb4eDUi9fZwCWEBLzeugR82Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ayxY3Mev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VrCGCa8Q; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ayxY3Mev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VrCGCa8Q"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C1DC2540178;
	Wed,  6 Nov 2024 22:08:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 06 Nov 2024 22:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730948894; x=1731035294; bh=4a62wIjS1s
	FNEA79XNNboCzRxS2CSvRjj2+ExbAmwz8=; b=ayxY3MevRKKFJpxzV3NggE5nbw
	Zs6VR+lLaTuIC3S+7TmSNwL5r2bN9q6QaJDwlXATM/HEPJ6BWys1Yos4/j0YEWsO
	mJkSrmUaQ6NFUWzxneCIWJOpHrUNnkh6apDPaxUGjjQJSpHOwVcPQFQCe2hXNgs8
	XHcmW32dKqM+Qx2dEze0IZ7AJ+rPbOxTP9HbzH7CJmqW+Zamt/OfZ5kvFSSNIcpQ
	5rvCf+ogmDeJK/mRafBjo3UqsKvTl0f0viEpB63iIClfEhEP/snyvl3Ll66cZZrH
	kkLP1HsTQxZ/XNSyZBHrIci6emSBYe2piyXLdTHSDLdTSjdkqlHr3YtrBKDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730948894; x=1731035294; bh=4a62wIjS1sFNEA79XNNboCzRxS2CSvRjj2+
	ExbAmwz8=; b=VrCGCa8QFdjVqsrnX02fLW4TSNnarntYV0RAvHeYakyJFXKlkza
	N3nqZ2wnxAhp+4YRCg68bwS56IZXqP1g+/insow46OejYL5O251Ho2S1xvx4W/Lr
	/dqw/rptKzIWCDnymXVIUxnl3XJB6qYSipA1Y//JB7gUm17P5eakiv7xkzjDp/dj
	kZOc7fReEZYbb5KEXHGC8OhXT2HzVHnpnJUrO/PaL0Ds4p2M4aBLsghzse0s8BW9
	iOrS11jIozAXiwtkRDHOKmiWHTXp0RHg6bAVjxxTbVFq0lynOr/bYIaB56GLIUn3
	nQuhA/H5iz5jcyRHbPVwc6LQYVZoEDOa8Rw==
X-ME-Sender: <xms:Hi8sZ1z2aUGbcT1t3rXbwx0VHeB4ZeJIJAQ-dpo2LRsooiTrYOWdrA>
    <xme:Hi8sZ1SpOjpcmwnDZ5VDWQGZNEx-xZyfSejZMgHaiHENi_MtlNRwSWyuwxLYw82b9
    r3D5YhQxDwJJpAHiw>
X-ME-Received: <xmr:Hi8sZ_Xo62eLKpAG22_J-C9gonOlNCR0cJP5ldgymtsj09x3tqPXaK1v9kdZoKNmmWoDBx_m5SJVBkz6eg2unJ7xEcR3pd4vtIr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Hi8sZ3i6fa_Vmb2nANzDLMi-_pq9g9ZBJ5sTA2suSX7nLI7Eugzjww>
    <xmx:Hi8sZ3D58-Ba57syPf4hEPX2U0hPLLaDzebFsxo-oS8m8kLfIRYz1w>
    <xmx:Hi8sZwJxIo6LfUGr1XYbu-baIJk3Br3Y2CNVZkPytXP9a3CdW803fg>
    <xmx:Hi8sZ2B7p9IeZowCuwWClXrJjTsd9pDuCdUehgX7FTGqxV9RD2zgcA>
    <xmx:Hi8sZ52q8Tzp241j-cBxgXJdaugbrXRiueYDZbjMAuOQwwfV35yDsn0R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 22:08:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Taylor Blau
 <me@ttaylorr.com>,  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] t/helper/test-sha1: prepare for an unsafe mode
In-Reply-To: <20241107020810.GD961214@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 6 Nov 2024 21:08:10 -0500")
References: <cover.1730833506.git.me@ttaylorr.com>
	<0e2fcee6894b7b16136ff09a69f199bea9f8c882.1730833507.git.me@ttaylorr.com>
	<xmqqcyj9qgyf.fsf@gitster.g>
	<ZywOWn08cGBnBWM-@tapette.crustytoothpaste.net>
	<20241107013915.GA961214@coredump.intra.peff.net>
	<Zywcr2lMM_Ij8suu@tapette.crustytoothpaste.net>
	<20241107020810.GD961214@coredump.intra.peff.net>
Date: Thu, 07 Nov 2024 12:08:12 +0900
Message-ID: <xmqqed3nvizn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Me too. If we were fixing something ugly or error-prone that we expected
> to come up in real code, it might be worth it. But it's probably not for
> trying to accommodate a one-off test helper.

I 100% agree that it would not matter all that much within the
context of the project because this is merely a test helper.

It looked odd not to have sha1-unsafe as a first class citizen next
to sha1 and sha256, with an entry for it in the list enums and list
of hash algos.  If there is a good reason why adding the "unsafe"
variant as a first class citizen among algos, the approach posted
patch took is fine.

Thanks.



