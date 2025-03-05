Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CD206F2E
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218313; cv=none; b=dDlt+qTfHYnAhtmJmGJGsuJNZsCug7iuy/AegXPP+oryCi8BMcMVYlWeboOArhf+yxiMxWz5lWDJAFDb5P5ZsIlStT09kBUKfU29dL+QUhZvBQao1peo8TpZIj53lH+XbUt7VScI7bocEkWA4GSEfzXDkbacXYnsa7rxsI/upqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218313; c=relaxed/simple;
	bh=M4kF5yQO5J4wbfjih9XnEyC6jm96Y4Avc2d4ouSWgjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ublpYiZpgj8sSkYkTV7KWeR4Gv778ttoPWNm2S2ErzMrxNoHcSqAze35K8KpZwAUipuPQlCWQG3aBP2XXOHPKioaihLYiv3kZ2bs4L82uEOoPGkBw7Joqz0YdOHMsWygis5HBq1aaAOhHxgXKbkzf+h1n4amMjK9A6gyxpZHp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=chJ3LRz0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9YVZfOe; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="chJ3LRz0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9YVZfOe"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BF301140237;
	Wed,  5 Mar 2025 18:45:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 05 Mar 2025 18:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741218308; x=1741304708; bh=M4kF5yQO5J
	4wbfjih9XnEyC6jm96Y4Avc2d4ouSWgjc=; b=chJ3LRz0Lv0Lrd5Td0O3OwkRwX
	5iXxBUkVMr6djxFqLdv3nlrs5rm6OAmt+RdRcVKIwt+e/iaxYOA4TgiE3YUAbur9
	n5SLAGHM0Neh+mqTG5d4nSA2pg5lRjEHeADb29xrQxPpgFNYRBM4Zxuvz+QTseIk
	lLGWWXuhFW9Abs3dSPhthI1jjFXkJwvP8cf4/UEd389b+P3XnSP8E4dCZJcXGVe7
	zUT/Nmh5FPweS4bKYQbcSiO2FN6ekWPeUNOzQCzzbdOVDq/M3dWmoIa1NgVAV56d
	2Il4ZFlpNMpKQYG4Q0UeorPUsiaWZnfwe92RvIJKqSw7s+hb0Gd43Fb3vTkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741218308; x=1741304708; bh=M4kF5yQO5J4wbfjih9XnEyC6jm96Y4Avc2d
	4ouSWgjc=; b=A9YVZfOeuwS8wxFCELOeOg/l07lQp1aplyjCsozT7lIA/H0PXAw
	vkaoxyVY32cdtnYsTYu0Kpp4vcfCfzaer3E+sJe6W64nLN2zQRNpzzL/FSIfTnl0
	JUiDpQGzAEQk5dgaluREzSgNlbVcIzciYlIlu8WBqN5YSLd2AmsCZ32wzLSa4R2m
	aNE0ah/kisHlu++3TX0HrfgVinv0dgq7AS2FfEXV83AS+WOV4oFCoBzQ/IbENHrP
	ZqIiNCDtZybyQGIDUIgywIwq0V7HG3oDPoRSGEupnyOw/uKoP6M3TxDAKo6qjdLa
	v3FX+I+n4qCi/MN6/djUpzi4ydfivXEwF4Q==
X-ME-Sender: <xms:A-LIZ-tDLR9es8L0QZA7mV3LDvks9xkiknDjQNtMTjppvO2B8PGmcQ>
    <xme:A-LIZzcp5Z_yTIrllJonaJVYf9-SwyDWYd3ZvhelTls9owMu9Xzb4jXZdWTbf4g-3
    jlkWzSrpwFDKkMhrA>
X-ME-Received: <xmr:A-LIZ5xOrp98STCAnnC5kKmqv4WJyjz0CZSzfEavWuUxQhRzwAY0gqxB6wCiMrsNwZzmdW3fmJr5FIlMtNi-Ug71XnpnNDbmlGm_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepshhurhgrkhekkedtieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:A-LIZ5MMi5znLyJM1OUZxAjJ3HNArkYyk1lw3DCRGePyd1vgyciRQQ>
    <xmx:A-LIZ-8wSOJSiVk-DnoEqFTE-f_iTpRGQweYXtuEE3piCeAHNpLR-Q>
    <xmx:A-LIZxUs7hMog-ZkJ0LvaMAtoju3gqW5HFZ1WUM6Bdb_Daj69sQVdg>
    <xmx:A-LIZ3c0_cMynP1XLAOBNNBSqNNxrtsCzq-Qbb1ipIMlqar_XxPkfQ>
    <xmx:BOLIZ-x579Y4ZZ-BtaGNvn1tZlwWy489w3qJMxrvw0EM6lOrwBxqgUHC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 18:45:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  SURA <surak8806@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: The transfer.hideRefs of the upload-pack process does not work
 properly
In-Reply-To: <Z8jadiyUj/U0TORF@nand.local> (Taylor Blau's message of "Wed, 5
	Mar 2025 18:12:54 -0500")
References: <CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com>
	<Z8D/aiqN5e/aRSn7@nand.local>
	<CAD6AYr84KuBb5N-LVBQo-6Gq2Ms3JKQCk0gyO8i=N8gp3whe_Q@mail.gmail.com>
	<20250304075113.GD1283943@coredump.intra.peff.net>
	<Z8jadiyUj/U0TORF@nand.local>
Date: Wed, 05 Mar 2025 15:45:05 -0800
Message-ID: <xmqqwmd3jb3y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> But then we have to handle the reftable case too, which Patrick gave a
> potential fix to below. But equally fine I think would be to push this
> ^^ logic up into refs.c::refs_ref_iterator_begin(), which would fix both
> at the same time.

Somehow, today seems to be the day to read about "let's push as much
common things up from ref backends to the generic ref layer " for me
;-).


