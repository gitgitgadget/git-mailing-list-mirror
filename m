Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720C1C5F23
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737582173; cv=none; b=pqyZq1p9wFxnKKSm7qX2qA6OAh80e0Bxov1Ry+Ftx/3rHKYKvUAvtOcQ8xwpSammwAGXBt93aiOEIypdmie4MfwSspu2YMFZiVSjcYdFVxI6C8CNOII6JoPUNv9sIPljv1BlSpfdRG3mxBO9v4YqvP23ruPnEZvZaKFXnDji794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737582173; c=relaxed/simple;
	bh=X6DsgrF3YKekehUH5bZ71W6rhjEThl9shvWn2ywnW5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JLWOJ+ygDY9Q9o9Y0X3i2kAFUG654KGNp9Z8h/ueW75kt6vJXK5uxnAdI5x9JNtrO0xj+C9QQ2/0SOovzZX/kl0FIdrbzvngZHNuCgEV0zPmnHI2uvQQTLDeG5XelT5z47v5QLIwcOnwe3xNqnTZcbkHPZtICGQAhn9PG7ZK5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C/xrR8lP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=apMiIp13; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C/xrR8lP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="apMiIp13"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FC2A1140218;
	Wed, 22 Jan 2025 16:42:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jan 2025 16:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737582170; x=1737668570; bh=pdVyDI3YiL
	1KhNPTNIzLqdUGdibwDQ1MRoZQ0S8EnEk=; b=C/xrR8lPf4qSGTgNFtbuF4XQhH
	6FppYRZZ9mKRIPdomYk/2MDUdlNi78AsWID3/OStLzibA77CYDGxUzD9EXBBmnKm
	yX69M1pjW9t7ZFzOy5X+a8QdsAsEoT4cmRgCdzFRirdR08Pp/q1dltNO2Aa7F5gW
	sPRtJpZnjytLO4NY6cjetaZ182/XkxLV1ZK4ghWCDpudRl8Lgigoz7/FHu7nYepp
	i6GnZVYSgvbiXaBBbGWcIpLljWLJxm8cOJLLFvK85fPyEYBSbbxntSednkmwuGZ9
	Gq9gLVnyG+W6IWG3VdnmgECokOeGczjTeNnNcYfBd8icWJDSctC6dz8dEbCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737582170; x=1737668570; bh=pdVyDI3YiL1KhNPTNIzLqdUGdibwDQ1MRoZ
	Q0S8EnEk=; b=apMiIp13IthWXAai0OwSxL38vvC6f0CEKS6hAAEVHxFOv8B64Q9
	/bH0tkfd0rfgsyCjl0LJQGCIxQF7MRlCPgSv8k6Z9xBI/HCxCLydn2eW3FmoWqdG
	mLYEwXRX7Jx2U2m5DJayh3v+lkpyOUDeXLvkn5TfocmsCc60ItrpKjSQxogKbQLD
	Gxh6FSJA1UuXmKY6TTE4rnHj/YsTVMGOa1K7rEb77Y6sz9NwH5aXiLi8lZ6M6IHN
	sYmwPQRhOMVj5z1td1+o/nS91N3aBihgqXilPLKLj+kyN6RDK6Mv6wchg6lQPXgB
	4JDPpVNCb9TrUAomkKf8hzIq5KyLqmxBsXQ==
X-ME-Sender: <xms:WWaRZ-QyRqaM2tmkkz_fUGeAnrSHYt-30n6hXyA3LEybironBIye2g>
    <xme:WWaRZzyfwsew-1EdV5vNxxQX4DONHODrZl5JFD2jYY2pnNj1Hv95sOpVELv5cbVWd
    b77uV7GjoEm2JaL-Q>
X-ME-Received: <xmr:WWaRZ70MnrMnx26R1GK07YvR2g3xjbbMBY7zQjD23w_STo2N75zSh6lsJvgE_47VIsSRmbMOuZUgtM59xywhCbb9KgYxe-VcPKMO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfi
    grrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhho
    rhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WWaRZ6Cm3GK3Aygm_uW24fZ9YrffOXlcKUfKPAgWV84QUH-aYWyxiA>
    <xmx:WWaRZ3h2au29usZd40HY4WIJ6j-0LacL9keb71LrqI0hI1EzgOnKAw>
    <xmx:WWaRZ2rdSoSy4hbYRrwf9_CXR_fIx0cMNpThYd9-yviUQizPGEIHkQ>
    <xmx:WWaRZ6gTIxMR0jYIeXezC0YMDMBtgR38wsCT7IEWnl2VQJfx9l4yEQ>
    <xmx:WmaRZ3hwQtcnKoZWBh7wo_udHpkcbfrRFqkPMoM0btjUQxpcmxyKvuQ1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 16:42:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Evan Martin <evan.martin@gmail.com>,  Eli Schwartz
 <eschwartz@gentoo.org>,  M Hickford <mirth.hickford@gmail.com>,  Toon
 Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 00/11] meson: a couple of additions
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
	(Patrick Steinhardt's message of "Wed, 22 Jan 2025 13:05:43 +0100")
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
	<20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
Date: Wed, 22 Jan 2025 13:42:48 -0800
Message-ID: <xmqqsepav82v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this small patch series backfills in a couple of missing features into
> Meson. It also improves test coverage of our Meson-based CI jobs so that
> we compile with Meson with Visual Studio and compile fuzzers. CI runs
> for GitLab and GitHub can be found at [1] and [2], respectively.
>
> The series is built on top of fbe8d3079d (Git 2.48, 2025-01-10) with
> ps/meson-weak-sha1-build at 6a0ee54f9a (meson: provide a summary of
> configured backends, 2024-12-30) merged into it.

This round (especially removal of some code from GIT-VERSION-GEN)
looked good to me.  As there is another topic in flight that builds
on this one, if there is nothing else that is glaringly wrong, let's
mark the topic for 'next' soonish.

Thanks.
