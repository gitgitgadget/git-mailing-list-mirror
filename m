Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0A1AA794
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059755; cv=none; b=WRzh73wIvDMHt1vAg/3zBDZcwfTYxU7Zbs5p1bSd/iBqyXVzrFF9A9M9mjxqIits50C/56kNkGpW7UtaR07dcw7fRI22xrXIsfmkdP8BHUvK+35CB+P57GOLa8wl1aidaVy/y/z60EE6034RBuvQIA5uFX2sHxwGOqBT8awZ2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059755; c=relaxed/simple;
	bh=4BTEe/7lZYhIErN+xDM2PO30QFqRpIqaTCyWpS8kO7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M/RIgac+JvqnTVE1FlD5fVQAPOaG9cTuk876xSiNypWLRyZ7pmcH8g3EQyEL7+tIQSUIgES2gMKGG7qli7Md4dPScY/6XZ1XW+P7vaHYA92+3UlylsSWvPG/0uofmrEE6zj8vDRKhQ6l+UqKsEgAVQ92cWPU8yf+eGnzClownt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J+vBBKqo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nfgYWzL8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J+vBBKqo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nfgYWzL8"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0ADB813802B2;
	Fri,  4 Oct 2024 12:35:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 04 Oct 2024 12:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728059753; x=1728146153; bh=86ycpGBD9J
	6VLGpoSQsVWMIdEH2oe6uXEXbGlp1HPN0=; b=J+vBBKqofbsmPb59cIAvvqm/Mf
	egzNTCxuB7FgUTEVc0AbCnczSR5gvfr477atgvuHwSenHzwoCJsvfDyRjBFx7Z4n
	fZ2p0GPJtxGWBCcsx9qfXmbG1JVTjzUtYcvUNY+SJKTJ1TB9v1Xasocsg2xQ3CA/
	rJ5JSSlfh912sVpGO47QBurcRiZxGx6fX47DI99g4UKO8LwtiovXbbcMLKww0O6G
	//f50SX+v8JM5i9UXSYO1ACU66u6FDfqoLTITvPpnzbPUDvi+hkCwPlJI43B5sV8
	K/5zwN6xwe4nMGrrw2Wc/ET/+9vEqC+YHAP0UXsP1PcZxobofMenmnME99Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728059753; x=1728146153; bh=86ycpGBD9J6VLGpoSQsVWMIdEH2o
	e6uXEXbGlp1HPN0=; b=nfgYWzL86+w06N4cynA41RKHObh6Dg3oKRSt7zlJH5g+
	RuZWZlhHLroGhg5YV40uY1wSArUaaGXGv+A0Ud4M6pe/uTi7sts9pXOV2p2jSByK
	uFm1Mvj88+Fp31aTdJvSS7Z7BrpGt+0LCiy3aVI5wl3DhktEQ29Z3HYalxtooAQf
	ukhsZK43Wn2N+uD+5lh4HpaJXeeWj80aQE5KihKT3szij7VJXgPbOIngYt7GfM8g
	EKNVmjQt8JtpGd18Ri9SWYRjqijerZ2FAya7q+pT5568I80Za9vrYXQmGTMAjzOL
	0QD4GhLSR+jNp8cCp5iFmfHNHbf1w/3lJydnnIHZDw==
X-ME-Sender: <xms:aBkAZ8vrPcVJBu-z9Xx_xWzyCrAoLCLpV3t6lKJeAsXcvDR-jC1L5A>
    <xme:aBkAZ5fjT06XO63myuz5wYukDjCCBYR6tbKeUm8-uuSvIkOb3xMV9KCeoc7iy8-ws
    5txzZficId7AEjsww>
X-ME-Received: <xmr:aBkAZ3zpEdf3Olmo9X-KJA3k8U_HbJU4AHSlOBvG3BPZghGPkvrD7kPP9Bqi7B2AdzrX_pNyVOIJIDvWnZp8fmPK5UjcS6bo5PLvsAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aBkAZ_M9mbVLpiCEKzixFk9Du5GYqJUtFKz5N3wG3ITDVKINU18SOA>
    <xmx:aBkAZ892LxKoJEZuhsY32g-fs82BZ0Lz_U8POM_J6JGVr9koDMdCPA>
    <xmx:aBkAZ3Usruw3TMwZ42GaN93xi80wCI33gRIVItQgnCt6nmOEe2tItQ>
    <xmx:aBkAZ1edkyayijGaHIcmTBLn_vDrC5vaWG19EKnK3dNmdntoencxhg>
    <xmx:aRkAZ5OB5TSNNOslBfF-O9Yp4GYpyV6JyUK72IbPQYB5dMkHGT3GpkV1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 12:35:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Jeff King
 <peff@peff.net>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2] t0610: work around flaky test with concurrent writers
In-Reply-To: <f3874c7e923846e453499e89f00dd4f8862e4c40.1728055880.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 4 Oct 2024 17:32:16 +0200")
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
	<f3874c7e923846e453499e89f00dd4f8862e4c40.1728055880.git.ps@pks.im>
Date: Fri, 04 Oct 2024 09:35:51 -0700
Message-ID: <xmqqttdresgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This should be revisited after Git v2.47 is out.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0610-reftable-basics.sh | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Ah, I spoke before I finished my inbox.  Let's use this version.

Thanks.
