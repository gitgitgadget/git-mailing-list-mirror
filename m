Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389E233127
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021128; cv=none; b=DW2zjiFuR48HttbWcd2cqL/ltu1eAeyUbR0nROIGF05+hjcVUitBcUwXbhoRdHqFYBk/H8w9vQcJqezAUsL74jLbbFMG4bdCS1dCOMSp3HYtt9PC2lrNxAXDHrl+/5IXtutPqMdWezkr4d1m7AsG9+i0h+BzwwzoOJnjkYGWzZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021128; c=relaxed/simple;
	bh=zco1KXnp8wS12io6wtlnjakcXECgCtfM9OndPwSHAS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zt4qcMfpDD6VL9U1X8DMoZrlcqbPbRPHRfKJDMoxiQlfv0BEl3FMtsfzkEMjOuZlskrQ0lP7mKuy+DE3H0hFR/fT2iDvWbjfuvP7DHqBENJD1P7PFNqERSGHIFDaxv5KshyCPP3aQmJOLWij6Ii53qERA+IFKzl4TUhCrXFe7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qtlyZdf/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jeH58Bxp; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qtlyZdf/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jeH58Bxp"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD6602540250;
	Mon,  3 Mar 2025 11:58:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 03 Mar 2025 11:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741021125; x=1741107525; bh=zco1KXnp8w
	S12io6wtlnjakcXECgCtfM9OndPwSHAS8=; b=qtlyZdf/0OD5xq5fgv2rVz10+f
	plCgNOkLTiLI8Gl8894Rs90uGY5Ihcr8Z2I+DQw6V5jBlKtLCK0Z0p006o3VZk5Z
	jWIFkdxklDG7/lOg9hMd/3r6F2sBXWelIl6R8xmlhuCXZiSA6kiXsG8uWCIpeZ1A
	pwIDSjWis0Y0Nrv8BgEdeNNeUyXt7c1vHnvxcyyr9gZU5apZbbAcCRDYR++u3vRO
	WKk4LJqc3ng7x/EA7Cp7Jz+DIVpPvEcw+YLZC4FE4/YtB4GAdhMRuqOpAufmi+dg
	1XEyGwd5A4yArW57l4t5va54xRYHy+UlpCN35FOie3HlCTnkiFv4h3fn3kpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741021125; x=1741107525; bh=zco1KXnp8wS12io6wtlnjakcXECgCtfM9On
	dPwSHAS8=; b=jeH58BxpX3Ylu+OQ3jDqOeQodIt3kcaFMV1qeUWGXQDJVr48ASl
	u67DS6NamGhdMH2WiGFlqly/5He4LOTyKxWFg0e/FpZJoJEuFqffb+up9ejYxd8E
	JoUbtzI/bYaW6K8gfMv0XBUuTDg19xGGtjYcq144Xaw3wmPs5gZKox5lhyCK15m1
	j41lS0tRvK6Ye2zU0JJWGxWFop2862NKHfu8Pty3rN5wNwtXvZHaGfpTDYTb3JCo
	TgvLlps70rQ8ArenjcaHiUpfqmyUwR1WNQjG0lDSvOLG6wdU7LlgmQO2MCLS4i35
	x94rsfOt9ub4ZjWSufXusGxuBFhgK7dsczg==
X-ME-Sender: <xms:xN_FZ7C3Jh8EcY1QYg-cZFsEBhBIWJA_-KuRYNnP1I82mrSApnmUEQ>
    <xme:xN_FZxhyukqYJUhBJ-xDaz47kb1PHKRVYFME3-drKALEE7nlaUFu0PcvBegVu1O6K
    aeIzd9yKc-y1grmxQ>
X-ME-Received: <xmr:xN_FZ2l8ZEkBpFnZ_Uyx3V4N98MV9BF-tpIofxvf6Axnk8MPwDJPri7h196m1N3SVxCCzCAIrJsZ2HnTQNWhEqJNqAB3zNd8-AmH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhi
    ughgvgdrtghomh
X-ME-Proxy: <xmx:xN_FZ9y6PoszlcH1bpB1og1Dk9mrxyNWBs8a8aOzeo3dRLLGqVMX1A>
    <xmx:xN_FZwT8quzu0jw0qjN_RxOnVyq92TXdQlIKaao7Th0e9MIM4Jbr1w>
    <xmx:xN_FZwaCz69LMSXGr0xSY3xydJ0IybEJYkpldESr1_Xi6i5MtO7JaQ>
    <xmx:xN_FZxRSUc5b0fwkJbaGwWka-0i9iBxGqvK04eEQOkIBRLvYfFXrfw>
    <xmx:xd_FZ0YiAqw6lDw0I6_-gEbDUTbIt82uE5XG7em2T4ZjDmzOg7Adcl9e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 11:58:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Karthik Nayak <karthik.188@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 3/3] doc: add technical design doc for large object
 promisors
In-Reply-To: <Z7g6c8dS_Ttt-T9r@pks.im> (Patrick Steinhardt's message of "Fri,
	21 Feb 2025 09:33:55 +0100")
References: <20250127151701.2321341-1-christian.couder@gmail.com>
	<20250218113204.2847463-1-christian.couder@gmail.com>
	<20250218113204.2847463-4-christian.couder@gmail.com>
	<Z7g6c8dS_Ttt-T9r@pks.im>
Date: Mon, 03 Mar 2025 08:58:42 -0800
Message-ID: <xmqqpliyvynx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 18, 2025 at 12:32:04PM +0100, Christian Couder wrote:
>> diff --git a/Documentation/technical/large-object-promisors.txt b/Documentation/technical/large-object-promisors.txt
>> new file mode 100644
>> index 0000000000..ebbbd7c18f
>> --- /dev/null
>> +++ b/Documentation/technical/large-object-promisors.txt
>> @@ -0,0 +1,656 @@
>> +In other words, the goal of this document is not to talk about all the
>> +possible ways to optimize how Git could handle large blobs, but to
>> +describe how a LOP based solution can already work well and alleviate
>> +a number of current issues in the context of Git clients and servers
>> +sharing Git objects.
>> +
>> +Even if LOPs are used not very efficiently, they can still be useful
>> +and worth using in some cases because, as we will see in more details
>
> s/because//

I've squashed this in and it seems everything is in order in this
topic, so let's mark it for 'next' now.

Thanks, all.
