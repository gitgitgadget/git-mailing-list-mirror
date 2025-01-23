Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF21D63DD
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 23:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737675972; cv=none; b=B4zBpsS5d1Pr7PJq15Q4AY15yyE3rzJv1m7a/f+7KTTSaOmjoovs/cD9vTTrzxH1LQUMOzPVkDoBgqZxeJurw3OystFjnYD2gegp2StP3fxvs9QSc6h4AUkwzdLRaOjzQSxmV3r9EUAv4wSwHoejqkzLsMc29nJbfWhzyeydAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737675972; c=relaxed/simple;
	bh=Dsgn3XVOSoIrXCpjJwXOijkjXaNphNcEK0jZjs0kV1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QQmTTlo+PYD7ehLcMmeMQIXpemfcdY/kByuprrJEThZF/QgZHLDOTlRslIZ0itnLQSQ94q0qF4jHm9xmXul55Wj0FyvrVcTnpOAprZ+tgFKaWPBmxto6HhzeIqsl6vdPZeJeoWgDvtYrisfY8ivSUC+zcBTSYnfMKvaevEFivv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l9om3apE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UdDaVD9V; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l9om3apE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UdDaVD9V"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EF8BA1140172;
	Thu, 23 Jan 2025 18:46:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 23 Jan 2025 18:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737675963; x=1737762363; bh=XyUkRKZwUA
	AS4aDTC0JlXOBfHdbNkwZwVne4YgSdUxo=; b=l9om3apEZoq726CVcwLMAH4kLO
	KljRwQ8XpaTBo0t+vyDmkD9nWbX/nOGvZ7ZUyNw/6wnX8tXdGJmjvVkHyBq6O63e
	/cAUJxv90avQWF8U8O1Oa1RiOLGVFoX28CEQPpl77Xam935Sk21FXgDCr6GneQzA
	pszpndW6+Ixb0nWfjlvOaoOfQ8wwJmwd5j2dMHJVnD4vcKd6UL+xA1HlDJvJ/H4E
	KEz1hw/63nqunB1ijCqNw8ROtGSmXmdncNeObr3hcEgUaNMAs8hpZRAc8xUFkzO4
	7AQrbrSL1JVbPDVtSaE1e6ahGMQMeeR5ihv2bnkb+r0OrPg9kzH+kC6B/TmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737675963; x=1737762363; bh=XyUkRKZwUAAS4aDTC0JlXOBfHdbNkwZwVne
	4YgSdUxo=; b=UdDaVD9V3LlfeqIp33hO4bjbVa+dw3BRpYhWh2M0eeVfPWn/Lfp
	zG5D0zm/K6fd6D+o2IxApI8Q7RnIUrd5sCMBDQ+WnPAxzqAff7dVHbOF0WeMrc+g
	vbOZyWseAe1AGdIRJ9BBXriK/1P2MTkKcEDM9sTXXjA9NuqF+ZFMKZzT7cpfi/XV
	HLo6Td/zOIu3u3Q6oCs5gFkC5bTdTTYbAxnKhJmr06hyNbr1qbwm2/MPe6M+0STW
	ePmayDgtnztzlj2TviR5GrNLsPsFFASYR7ZTVdtasI+Hs4of2672mxFKIiolBeCH
	qILqerVepCbI/I5AEcd6ZIqYccmza7wJpHA==
X-ME-Sender: <xms:u9SSZ8Xb_t6zWVRX3oYanJE1-FNT2TKUHhs-j-f4M37q-1Er_l4dlg>
    <xme:u9SSZwmtiKMJgjW4_qzghN1MHc33N3E0eJV3AYY4AMCRhTGiatqk6L0v81r6TK92r
    -O_CFylTIBaq_ZDZA>
X-ME-Received: <xmr:u9SSZwYbVLY0GJ0WUVTl5NNBbuCO_KW3fZWePU7DskU6bFe2Dckd0fmxF-oKxYlUa-6dE9VEKQH3zPaeJJlMHE7J3rjiPe_m6gyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgfedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:u9SSZ7VRgpQezR4IUYFLxu0Gn35FBM187jL9MrILEgLmW5HosF_3jA>
    <xmx:u9SSZ2ksBdbqtzIVZBm_M_l7BdAKip1QQPO0mY878og02WyvBXkwzw>
    <xmx:u9SSZwfbzEUZnwXVZYyObLtR_MuIP8yvJGWIuqFiKmRNtC_L47Q5wA>
    <xmx:u9SSZ4EdEzS8ydLSHRMEnK6pm88uuZG4gkgHnJlHRECtys2AbQyrOA>
    <xmx:u9SSZ3B7YE3FecvvThyvWpCg7gwDlGfL67WMa9Ah6UwEVNHHfzflXCP6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 18:46:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
In-Reply-To: <Z5LLNMKSa6Y2zvHK@nand.local> (Taylor Blau's message of "Thu, 23
	Jan 2025 18:05:24 -0500")
References: <xmqqwmetgdgm.fsf@gitster.g>
	<1331d214-890e-4b47-87c6-44f445172bb2@gmail.com>
	<xmqqv7u7zz8v.fsf@gitster.g> <Z5E5KdbwHE7fmiJx@nand.local>
	<xmqqh65qv6oc.fsf@gitster.g> <Z5LLNMKSa6Y2zvHK@nand.local>
Date: Thu, 23 Jan 2025 15:46:01 -0800
Message-ID: <xmqqmsfhqekm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Yeah, I think "variant" is probably more accurate, but I don't mind the
> naming. I think having a unique identifier is important, but I am not
> convinced that we need to introduce v2 and v3 at the same time. I would
> rather see us unify behind a single approach to present a
> clearer/smaller set of options to users.

I agree with you that v2 is superiour most of the time over v1 and
v3.  If we keep v3, then "version" is an awkward phrasing to use.
Some people with specialized needs may use "v3" while most people
who do nnot have to use "v1" are better off using "v2" not "v3".

If we were to drop v3, then "version" starts to make sense again, as
"v1" is kept primarily for backward compatibility, and those who can
afford to follow the latest can "upgrade" to "v2".

Perhaps we can first agree to drop the last step from the series,
keep calling these "versions", and then later add "v3" when we come
up with an algorithm that would perform better than "v2" in almost
all cases?  I dunno.

Thanks.

