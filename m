Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D661366577
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560692; cv=none; b=LM6RUgc/QnJYsv86lR/zyb9Rc82W0i5xnkRI3doJAdyyDwmqItHiEXDpJOHX8MMalypK28AVG+wcmbF6Gkvd/ziRbI1to4+hgE7dUPh1HThf7V6tt4atL3GzDeuIHRjGNbDpYEvvV0F6X7ZLBfujbto3i+/XaPgW2AaUGxVAUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560692; c=relaxed/simple;
	bh=Ji2YkUN8SbNKlpwoyLXPKQSKwneS24bTkuot7O954yw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qv7X35KXlKl566cYJ0dPvj6AQ+JFdP5zudaS2rRLARyG8a/zgaCp8Yh2TcMTfJxARFtCxwe/h0blifwebBWR8YTwAEcPFWGS+vG+1tG27IL3tskjie0w5SLxIxqzMK9zHCqs0FqZzsqsOoeTn3bvBB68ZEDalq18i3tM2kjUlm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OYw8eXqg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lObx1Ro/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OYw8eXqg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lObx1Ro/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DB574EC027D;
	Tue,  3 Mar 2026 12:58:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 03 Mar 2026 12:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772560690; x=1772647090; bh=qv975Q5Cx6
	MoSdbMzaaQBcYrRC7yTsoF5zYI0WhSv90=; b=OYw8eXqgrD7XdZ6ZSmqmmvBlXp
	651QUUhl4gUX/Chz/hQb2CtijQBQM9jW3QxRSgqyUYZ+owT2bWZTGfASU3+vabxs
	3FCgV8OY+RfrOogi+uWwrvF1NC/nqn+dvFL1U42kNO/xzb/CAwOTP9UVzAC74AUA
	VS6ragDLAEsEyotrQzSqi8+fDLQegiX3gKuxP7R1Isk934BRBZKy3tMF+rTSF0cB
	luDoPtH0UQbQapbJd57+GJGevQ7gaXAiE272Km/CM5L/ZBAUdan4hwRPzGEOkBeE
	HpzQ/vHgaTGe8AoDP0zEJ54wRF8oUXvg07l7NvWy2gxubGANlEvgnTWsP2Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772560690; x=1772647090; bh=qv975Q5Cx6MoSdbMzaaQBcYrRC7yTsoF5zY
	I0WhSv90=; b=lObx1Ro/Rq0mJxbgQcWU86BJNPFnVeqYAlH0FgI1aaNXRP3tWwh
	Merec5HjvLNAF3bezcwM4yuJfpBeAOzhwMXvRex6tI8UzKH0gwFASd0qvGS1ItMD
	Ki/V5evzZecrIPE+ASUg+FCdp3dLqnCEo0OVAvN33yqMoNlKUnrm/jVdFhIQQKoV
	26ZrNx6yM7cvcIKaY+a28Kp9Xxl4Nyo4IMtb+6VP9uvOeYPLgOgF6TIh/g3AXv80
	iAIpUOBz8n8/8tz4qXZslEX79JVZ7pLjaYd0KqqQKgTgWXZlmwhtdYk9wXsSqAqY
	uIRiX+ohDVUN0bF7+RBnDagzi2qMEqcPj3w==
X-ME-Sender: <xms:MiGnaeLf4j-BDSrUNa6HzQwqfzgy7znI_9kxqms4QagDsWg0oh4ewg>
    <xme:MiGnaYZj5GeNl4_70bPohQeFJ_GGH4E-mmQtRSLaSoqHM8aRhJd0uNGwNBN-X4f_x
    0tXdfXBkXSJRs9qaq-uie4e78wxB-nsIhcRZknh1LwLUgDqhbgfmw>
X-ME-Received: <xmr:MiGnaQ-gdEzVWzC6lMbXobkgDqHNuGD_YWudUndKfgowKE2ZOFUD-bQPRE8qD2wZQAHU8MfALN58xQZQs6yY4FFqZt4sFxi0ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegrlhgrnh
    essghrrghithhhfigrihhtvgdruggvvhdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MiGnaZYO-XN_epOFmyC7UBBytCNw6iZQ2N13Zuqq3mVWCsOaM8uKag>
    <xmx:MiGnaUPOIvK3iHVrJi9bu9IwqGz2We2z9gSIwDYEpvYuDZmK6bkJoA>
    <xmx:MiGnaVBkM_CJpPLG5-qJ1auxXzl1iLQQV4YgGeiYZ8De6lAgCbLtdQ>
    <xmx:MiGnabLxm78bBIM-jvIBCu0em9vjY78qfz6jvB_Qd-lvkwLROq2d_w>
    <xmx:MiGnaVABiSPPyt8f19ZzKiPs31AM33TUbnFAzDPxr00eyK7lm0T9NCPK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 12:58:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Alan Braithwaite <alan@braithwaite.dev>,
  Alan Braithwaite <gitgitgadget@gmail.com>,
  git@vger.kernel.org,
  christian.couder@gmail.com,
  me@ttaylorr.com
Subject: Re: [PATCH] fetch, clone: add fetch.blobSizeLimit config
In-Reply-To: <aab5iICOAMrH2aQZ@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Mar 2026 16:08:56 +0100")
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
	<aaV6PLJCrpb2mQnq@pks.im> <xmqq342i12ky.fsf@gitster.g>
	<a3e064fe-9f0d-448f-b034-4a95dcd3fe97@app.fastmail.com>
	<aaaACBJVAZPypVtn@pks.im>
	<d4e2aa7e-6c6e-43a5-96ad-848d9447d194@app.fastmail.com>
	<aab5iICOAMrH2aQZ@pks.im>
Date: Tue, 03 Mar 2026 09:58:09 -0800
Message-ID: <xmqqtsuwdccu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think using something like "clone.<url>.defaultObjectFilter" would be
> a more sensible design. The idea is that we'd only honor this filter on
> the initial clone to basically be equivalent to `git clone --filter=`. I
> don't think any subsequent fetches should be impacted at all, as turning
> a full clone into a partial clone would need more consideration.

Yup, I like this one.  Should <url> be giving a repository fully, or
be some pattern that groups similar repositories together?  You
would not be wanting to clone exactly the same repository so many
times for a configuration variable to matter in general.
