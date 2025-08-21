Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A71DDA15
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737423; cv=none; b=vEy1knq9y7s1j4sS6JBgQEtpx34Jr300o18kskPFMjM93gRCtTgEfVg06cMJw17I01naISoxdS2XvwzfzuANW6LTrBckGRZhqLjiOzZNd0Ie0+eEj8xQv4Y2U9mLe2E+JWxGK2P4zLfa5pVp3tSIOAqb1jLh3MzyItPiNt1BWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737423; c=relaxed/simple;
	bh=/sHvEIgR1XIMULQOzgcHKx6dm1EoVOZWgO/8L+sgGnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ioxr0ar17GEXe69qMC0eir7ZGmmjoA4Qf8xCB6yP48cAnG65L7pgYwbA9qXpw5rwUS/n6jrJZoi4wbj/t8we2+V+qPGKgtEYfhxXHNEyJ+KsLU3GZapsc/mpP1+Bc7DEa0yXtusEGRDS3+HYZfEarcKvbuhlLGvFpQDmGz8haeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E0t4DS+e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S+6yqNuD; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E0t4DS+e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S+6yqNuD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C631A1D001A8;
	Wed, 20 Aug 2025 20:50:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 20 Aug 2025 20:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755737419; x=1755823819; bh=Ewe15AsIMO
	ZA5Ze3yVuNsBURGPO7RpeSNY4v8aGQa0I=; b=E0t4DS+eE9GiRFTgd/OqRsXbGn
	4E0E7kjuW3le/DfC/tQacYM+0IN52svoByf5iOM846aL4EsTY0XXrtJdQdVYqy1L
	Lf+DxtNw/RCsx9aMaEhmjceTNsv6EI5G2ihO2TN82ZgPzGdU+T+PFcjkcz4V//H9
	hdEaLvAfbDFTvAHqtjIDOLmvUZ0+oEIPGjumEDfVEUTCVq4EdnhX8Bh2diLwbvan
	iJcsmkiawM4owtuuh2XOyobheg0OmiSFLj4qSY7mbOEB5BEGxmqgJRbkmTqHR0bX
	F7GC0Sucn5wq3tSk/0XuHxE7uRPWSweIgiD01NEuv51m3iL/rFDXyfNo7SDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755737419; x=1755823819; bh=Ewe15AsIMOZA5Ze3yVuNsBURGPO7RpeSNY4
	v8aGQa0I=; b=S+6yqNuDkWFU6SsSx3x+Z/NVWQ88Yo1D4lp2ZvormnXBDuJ83pr
	ihCAn0O60Ln5xZXSUJZxp2mBFPpLMeoV3m4UMadRNJ/c+QL2y6iH7SoRwGajleQ1
	+/tLu5pIwTbceW6jEGyGRMFTYJnAfg2cCWc1A0gIjvus5CSO3Sm+ZZOuxq8ybhiM
	mHDGVun7yL5s2uiRiBGwPihqzdcodKYFTEK/bPS/aUBP4s7T2RHXqNSMWai/hP2l
	568EaSO//2WkWxDySC7p09NGuO/+enLgMr3Ao+rT0Q5jcqDs1biWQhsAPsDWbBAR
	o+Efvn1SIz1BKeqtJlP0Gbs0wPq7UI4YB6A==
X-ME-Sender: <xms:S22maDgDURyhulQXJ7jT8dDf5aP41mOkeER0cX2_HP1_lV8GHOwU2w>
    <xme:S22maNmKRkoRTO4eIZXYbZ-x33C23Sph3vRzJeJxo8aUjWjwCUnlYP9V9kxXRfs6r
    l7ygqOQy_nkHdetPw>
X-ME-Received: <xmr:S22maJiCg70HkhcrWyRjQqTF4E_cb0BXFKBUgrbK4zP7bziZ3LsJIpUeO12bHxuTn2cZkkaSJDmyWylHTrum3sS6US4Qz2bNHDnuEjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurh
    gvfiesugguvghvrghulhhtrdhorhhgpdhrtghpthhtoheprhgvmhhosegsuhgvnhiilhhi
    rdguvghvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmrghrthhinhhvohhniiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopegrnhguhidrkhhophhpvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:S22maB3_J1Q4Rh7eYVHwEmlpDiQMOyxy8bX0RCOL8CG__T5pcZfmKg>
    <xmx:S22maCINRWv-QEUBewkCELbleq1HLMleuFdA21-k-R-7lRuu3kgskw>
    <xmx:S22maBx_ZcGiz5Lsghrz8Aw57b3j-mcA3hN3stSHSXL7rPkOux3S9w>
    <xmx:S22maAVCo4ycr1iQG7rWsEHyXbzYpuMZNZ5_D6j_ZjQlYQ9n2vR47A>
    <xmx:S22maC8gdOS1WwGRpz5qAavzKf-uXVYvp1inwjGx-a-zW-VfNLc4R5An>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 20:50:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Drew DeVault" <drew@ddevault.org>
Cc: "Remo Senekowitsch" <remo@buenzli.dev>,  <git@vger.kernel.org>,  "Martin
 von Zweigbergk" <martinvonz@google.com>,  "Patrick Steinhardt"
 <ps@pks.im>,  "Andy Koppe" <andy.koppe@gmail.com>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
In-Reply-To: <DC72UF1IMIUF.2F7CNYOHYDGVJ@ddevault.org> (Drew DeVault's message
	of "Wed, 20 Aug 2025 09:29:56 +0200")
References: <20250703113505.11889-1-drew@ddevault.org>
	<DC6LB8FINRXH.1TMZPB1XKPQWQ@buenzli.dev>
	<DC72UF1IMIUF.2F7CNYOHYDGVJ@ddevault.org>
Date: Wed, 20 Aug 2025 17:50:17 -0700
Message-ID: <xmqq4iu17b1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Drew DeVault" <drew@ddevault.org> writes:

> I haven't gotten much actionable feedback on this patch yet,
> so there's not much to do here but wait for more reviewers.

For a topic that is older than 6 weeks, I am afraid that is a losing
strategy.  People who might have cared about the topic said all they
wanted to say, new people are less likely to discover the topic than
it was fresh, and unless you make an action (e.g., posting the "next
patch version" you mentioned in [*1*]), it is highly unlikely for
anything to happen while you are passive.  Even a small update that
addresses all the little feedback would serve as a "ping" to reignite
interests.

You seem to have liked the approach to generalize and encode all the
commit object headers (except for of course the object name and
author and committer ident, which already have place to be in the
format-patch output) on an e-mail header in [*2*].  That should be
sufficient for a small update that tries to reignite interests.


[References]

*1* https://lore.kernel.org/git/DB4WU136IYR2.3ELSGQUDD6QI8@ddevault.org/
*2* https://lore.kernel.org/git/DB5MUUDPF6C0.3OR02N6JQB8H8@ddevault.org/
