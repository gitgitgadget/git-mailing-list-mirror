Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B21B86CF
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731365939; cv=none; b=ipHOJYXZX0m64Hl8Q5Y1D9VDUFwzCAqgl95w3zD+Rnebqaz5Djt2HBgfEj9cbGrlGeM5eFOEmwi9a9NWq8eeLAFKUIm6L4uENnB8ca4rqkFFxkJckVCWVDPNmjMTlBcsXfLUYjbnb4HBzksXpsE/LzimTF/oUeeRqi6gNKPLLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731365939; c=relaxed/simple;
	bh=VK5ChDs+tBAhPYMeGeyjj9GYLjhzDc9vw+SE3akXYOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RdjJfa58XutI4IYpjm/48weR0C4I8kaPRGHG8z/MxKyOlrTFvC6rHEx3PoRlH968vs8RczdQazxE4krJLDgzlIY9R+bh8ZdGdbZCUNCIvqzJCU8hw/pV0VeHinweTX4OB99wKdWCL8AGLJHjL8+nW8jC+QknP62hOWzRAoPlgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F3pfljIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U62mgSh4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F3pfljIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U62mgSh4"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B75B2540190;
	Mon, 11 Nov 2024 17:58:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 11 Nov 2024 17:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731365936; x=1731452336; bh=VK5ChDs+tB
	AhPYMeGeyjj9GYLjhzDc9vw+SE3akXYOg=; b=F3pfljIB1r4CzpBeEf9nddZSdV
	B4GRtl16IaVFGdm3jCG4LIB4EYY6eO7ksixqqCMFAv3xd7LdJX3g54p8/cPR4enb
	ZikhMNOZHR98ADmhhtPY+bU1skLpSjtV5lwYx1bZkJJYbXY5YVedpwFIUHD4ajpz
	WlYrZ6HRHdUiEaMvQeGgeIHjfIRkzquj6hz3p9lsrc+MIRJyP8krQ8qKvEg3Wiot
	Va3k7fCmxfY2SHfsmCdrrm0gvJrhpncBVYFOGTZR0mC1eyoC5DIIydgukZB8igd3
	otJGgbL/zw+9liahJ97HFFtP0nh3nM5cu+mJKUOd7b4S6dCWvD0pYm9dQw4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731365936; x=1731452336; bh=VK5ChDs+tBAhPYMeGeyjj9GYLjhzDc9vw+S
	E3akXYOg=; b=U62mgSh4N19gN+0nQlvyv9AuIPJx9nVquYI3s161FUgFCdI3mVo
	prVtDhUP6kicAJ3yAFKowpU5RZMzhU5yh6ZYKlEDfPebD81ab43hVBfj1x3E+CgF
	6CLQb1IdugCnCc4Et8RlgJqQwByWGipDzDb18uGiPTED2DfJJviRvs75/6iENic8
	Ap/xbUEGClHqb55DPgnAvP+/95R7oGXbP9ebhHG32QavslhNXbsSWrUgvt7U8yDI
	u1gZOWSNFZPG6Bdu1M6uJzs9NWo6WLhGmDwzZ8gwPabO4LjTqUynGbEHGUWIlZT6
	9/jyHSapf6sAwOi0ZdqLOc7rXwTeGaxGHBg==
X-ME-Sender: <xms:L4wyZ0-k6DfG9fPS49h8g3jxMA_pzhMnNwwIsXPbBfZPpvSXeMXf1Q>
    <xme:L4wyZ8sLdxSolfZsjBlixCCZkNqxMltD9tdj98T6naqnCUJ-I8EzhMQ-Ih5mTJndb
    jx-DTMXDHIiW1__gA>
X-ME-Received: <xmr:L4wyZ6C_zIvWCOV3pQy9GjxEfWzmm4bQ3iHijn617mwfCuSR1cvetR0bRWDnvJpyqlbdWrQshxDUZ5yHf_vzdBUZlkN46fywAyeK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:L4wyZ0fDuiZSD2RWk0JMhPCaKIBHvowqXwAAtLYgKfwI77p4rf21rg>
    <xmx:L4wyZ5Ozrhw8m5bJ1Pp14WtYzniHhuBbAuxwIh0DmB-ZklW32vIAtw>
    <xmx:L4wyZ-kjI7Iz8vrCQcyZ3uaE72j-K_FBHhuO_x6onNxABKMtgY1k8A>
    <xmx:L4wyZ7sxowatJspdHaJlujomeKgj0YetWcIONB7s72nwADQ1GKfd8Q>
    <xmx:MIwyZ82BiGHaPHqe3XZKFDRT6JHM-fC0mf4C60_oPDUq4S-KByJoOmDQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 17:58:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/4] t/unit-tests: convert "clar-generate.awk" into a
 shell script
In-Reply-To: <20241111-pks-clar-build-improvements-v2-1-d4794d8d1b30@pks.im>
	(Patrick Steinhardt's message of "Mon, 11 Nov 2024 09:24:57 +0100")
References: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
	<20241111-pks-clar-build-improvements-v2-1-d4794d8d1b30@pks.im>
Date: Tue, 12 Nov 2024 07:58:54 +0900
Message-ID: <xmqqr07h9y35.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> While at it, wrap the overly lines in the CMake build instructions.

overly "long" lines?
