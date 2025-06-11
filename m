Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF6EBE
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749601360; cv=none; b=U+YJIjEuROI7WDXLyhPlBRys30bVDVPCARqTHbowTOc5W5UsljSVbOI9zCUpCr/VTJqkBPuI6MWYdtLIPOtpfp5wiB0GIwFGRZfElSyUgGQvgjH2jSspRgkXGPMaGylIsNboTYS0QH5aVyOuCtygOpRjll9LKuuvo1F4eWIX8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749601360; c=relaxed/simple;
	bh=A3n59VS4kAY+2XH1dLbHhX7Glbw7VhfhWV+26pR3rWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gj2MGE9+629M0/qEZIfFal91+sjioKA0kLsOqyHyuu+FmbLlvX7BMcVC1xs8ak+mf5iaomVAL1GCyfwpYlzJi2ESFnDlkFf/Pm/Ksa9h5fTzyr2Mm5Aj7161hjHRWRUFxOhm2wMjD2WeIGbxhJb7NoxDIefUToP6+rga/bt+QZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WebM2ZZt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xu6XDAJw; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WebM2ZZt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xu6XDAJw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 82F0711400CA;
	Tue, 10 Jun 2025 20:22:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 10 Jun 2025 20:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749601354; x=1749687754; bh=A3n59VS4kA
	Y+2XH1dLbHhX7Glbw7VhfhWV+26pR3rWc=; b=WebM2ZZtXwDh7zWUVjty+qb3ug
	KteePZyX3lWTWOAxEgEP335AblRL0wTRe8edVNnHZpLmj/HF+5uvRsA9gU1zULh/
	39DTL18itNYRhp17Dc1N9MZrou1yVmAXjE5gYBm2S6BQe4Xu7Bb4zdGeYwJd2Elo
	rULmngfgmlVOt2NuZXk6d/xyhzw3bhkUCTWO7XbHav9KPMa0NM0Ta6G1aznr18Us
	+IE1bTPy4ghjO6mk2ioqLpciSdSy7BUluyzUIEVz9cVPL1hjKyLGobaKN1F9/ZCA
	M+CGb2ZDjpUx9k9NzxIL4kxNtm4B7Xhtz00ZSfRE4YAj4cRMUB3AllkAv/dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749601354; x=1749687754; bh=A3n59VS4kAY+2XH1dLbHhX7Glbw7VhfhWV+
	26pR3rWc=; b=Xu6XDAJwOF8AqcnD0sJ31PvOMseRg9yux+oR4wtXeisaV8K/RRU
	W5bes3aHmtITaB0JIv4xITULUbF2PkBsJfbCBKO2lRL60QoOYZlcaH6JjwW9RQkl
	hpRjXCUrw8fqt8mNS4iHsaWwvX4kYSXEsoLLR2oxuYmAMSbv/txNdBgUyHLrPmT4
	bA2c34RpJk/veCcv3/3A0FYqbhWlZG0tQeknP5qPH6Kca1b69Km66n5dV/3p9DM9
	gi/A/JwQ5or8l31pJMvjuQp+xNtdEpEbI2rt7LwfEjuBZ7CqGQItTvw18vfQ973p
	5Iwg8kuCHz4BTgF/4NTHyEIN2NgCUQNjhtw==
X-ME-Sender: <xms:SsxIaD1Go6VYWFL9vUYk31qv6qNj3RgQFjYxFOGlgvQtlB6kQ2jVqA>
    <xme:SsxIaCHS0SXtTLbFuVshDFXKNyKJOjPh5vDJKvR6GW35FAzzMFku2AttwmE1U1k-N
    Nyw1U33EV4Ocb-m3g>
X-ME-Received: <xmr:SsxIaD527Oi9d7T76E3cMzMQ4B1MdhLeQAbRdgMhQWujCmPF7WqGsWGAnhWgWEfIOCeLtZRL4XlV4FgewX78SWQii8U6odL155he>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvrghsth
    grtggthhhiohhtthhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SsxIaI149ajL8UuG8Xeigfknd3XP83Pbo7HZ6jtUYEXRvRlVGEl6cA>
    <xmx:SsxIaGHGEh9fpxHDOmgcPhrkYf8etK_QkEmxNMa_CO-nu6gBfb7t4g>
    <xmx:SsxIaJ85jJlvFldzWcVTNupXBa6_31DA9DHSEi_t7Mn9-PKbVy1Vag>
    <xmx:SsxIaDn0qs_35Dt4TqF233A4wdVs8aApDze9AOMrQ84ijK1WRWsn-g>
    <xmx:SsxIaJU3tkxNT5mML3BO_Q-3iIcSlGYlXLiZjwDzc8UdfXelnV-8W_vn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 20:22:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrea Stacchiotti <andreastacchiotti@gmail.com>
Cc: Andrea Stacchiotti via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] branch: move multiple branches in a single --force
In-Reply-To: <CAEgWtF-fNXaC88FWw5K_3ZpbvQSxAfeuCFy8kkrh_z16vD77=g@mail.gmail.com>
	(Andrea Stacchiotti's message of "Wed, 11 Jun 2025 00:17:39 +0200")
References: <pull.1992.git.git.1749546464346.gitgitgadget@gmail.com>
	<xmqq7c1jmgpq.fsf@gitster.g>
	<CAEgWtF-fNXaC88FWw5K_3ZpbvQSxAfeuCFy8kkrh_z16vD77=g@mail.gmail.com>
Date: Tue, 10 Jun 2025 17:22:32 -0700
Message-ID: <xmqq4iwnktyv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrea Stacchiotti <andreastacchiotti@gmail.com> writes:

> This patch aims to make repointing multiple branches to the same commit-ish
> easier, currently it needs a shell loop.

Or "update-ref --stdin"?
