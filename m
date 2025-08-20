Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345C52857CB
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723792; cv=none; b=LG4nh5IseW3zhh8tz9EsAkoA33OUZllnSw1mLPMrn2jMBscv2r0RkI3bBdGKpwu3nY6NKbGn94m8/ar2NdEMrtEjqHuiYR1vvvPd47BC67aMie4KWO8/VtP8/CTYqPoLNgvTo2dLr15tmEhe+PV9Ne5uyqJGzUf0Bnf+HE+tWTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723792; c=relaxed/simple;
	bh=L8Rrewzvjy9w6FWsYJCjyvd1LgBd/jbQL5+mYxSna6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WHQlnI0hsVgKbkafwjPNg0pb+YlLDDMCRZg/azPzmK5ULCEuTCeQLmKaLpXhNiPS41o0Ca5Pl45RYJJGmZxK8xylYr5MqtTbW4zrIRelNGEAIOsLWpEXAi0bv7DkkYnEoJvsseEI/USW9uM2hxEnh9cpYmS1eX0o//oocQf8MjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MdebwhDv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DsviSkBL; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MdebwhDv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DsviSkBL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38DA37A0018;
	Wed, 20 Aug 2025 17:03:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 20 Aug 2025 17:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755723790;
	 x=1755810190; bh=n1ukOLJ8obJFUjN0jYIE5kPvXkM72agdWl2bfvRhLCI=; b=
	MdebwhDvPW/kQ02nWref12bntytWtIwmaIxHfE6v5vncGghGABURsoiUvhVRrnbf
	LA9/Xn+c/l08PG6pCMIZ2to15mbtJI4dpmZKycDEVKakxQpnkSN7owOavTd2Gjcz
	Yj7s9ht7pwA1p/TNyPq5umTkQlwk3RxWcSkLw4lTK3VMVXiRBMSKHjny/1TSPlNv
	Vdwo/EEhrSEy+7ePgb35tkB9pYJPNlcmIyfXuoOtLHcbvI0YqLncY1powascbTDA
	gIQS+nI3XBgcztyDvAgHpRdnVw8/hC6r8+MuCwtj6b1DZEsun9Bc9lhhZvmjvI4t
	JRBfR+wgsRJ9nowsjLYFMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755723790; x=
	1755810190; bh=n1ukOLJ8obJFUjN0jYIE5kPvXkM72agdWl2bfvRhLCI=; b=D
	sviSkBLbsAgfn4yXkCh04JsS+1F2ymMvaMHOG8tAiAom3E0iasvPNJ3ml4J/iOxP
	LbzNq6vifaZKm1yu8vhEvuxHPPF3Urudw/+fAshZKEoAOKCmmLQ0f1Gc1bP1RPU7
	DlsBhAjEmxSJ3+68y5AwUInASqDiQubjC/mScGiu9aRJ3t2poHrW1/MWMMMnYJyZ
	gUJHV5WP7idp6P01iYyxHI12WaG7JASXlC+BMt60skrbaW6bS4C9puXXvbRqIFOO
	/VQKO6gmKibkyr9Bs9lZYGVuIdCd0LBAdCQ7aavo2SD+uz1l+foAxAfg92YypokV
	MN4D3UZ7y/JkIMnTgABEA==
X-ME-Sender: <xms:DTimaF1cEBzDLlNa6-uXccFRT6OIxkTOy5Y_S9OFl6h5tS7W9Dsw3A>
    <xme:DTimaHl0wRT9ksUvyK5lIUr9WOiJhtNxAneo1gCOLAWQ1M8gyIeonp9lXhO8ABerE
    urKHzOdOufWnuQnkw>
X-ME-Received: <xmr:DTimaMV3MHgGqc6k0Qev-da2Oox8nJlmca9pT0HPVz7yz-V4LqqM83ajSKS9SyNHYkSfJBaxjMO39ZCodVBGmR8MXnn0J-XW_oADHlI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DTimaNu57yzuH9xRgxReqwBQdryCxVCBtXcJB0OHcEfY5KpVq1GJrQ>
    <xmx:DTimaPY97cYLxedzoaXOBg4raKOLkStJgpBEzvJQPjl0OMYhTGrWTA>
    <xmx:DTimaMWtr6EMfQc-qAlCswxLtaGBDj3KzmB-fcMvo4r3yxij1K58VA>
    <xmx:DTimaEQ8-aw6CPG7aLgpx1O_fdmhIG1SKQ00UB0uxEcGw0Wn0yXOSA>
    <xmx:DjimaAAxYd2r-SeLZKicjqK5h6FyT5BdTC1FRYbLbp-_uaywSY1wggmg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 17:03:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH v2] doc: fix asciidoc format compatibility in
 pretty-formats.adoc
In-Reply-To: <20250820203722.31268-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
	message of "Wed, 20 Aug 2025 22:26:10 +0200")
References: <xmqqa53vc77z.fsf@gitster.g>
	<20250820203722.31268-1-jn.avila@free.fr>
Date: Wed, 20 Aug 2025 14:03:08 -0700
Message-ID: <xmqqwm6x904z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

> The change is needed because Asciidoc.py and Asciidoctor
> do not process the '+' verbatim the same way. A span is
> detected when the format sign (here '+')is preceded by a
> non-word character. I haven't digged into the source,
> but it seems that '{nbsp}' is considered a non-word sign
> by Asciidoc.py, but not by Asciidoctor.
>
> Using the double '+' opens 'unconstrained' span,
> independent on the preceding character in both engines.

Thanks for explaining.  

It is especially nice to see "independent on the preceding character
in both engines", meaning that this fixes Asciidoctor while not
breaking Asciidoc ;-)

Now, can you do give the explanation in the proposed commit log
message, so that later people do not have to ask the same question
while reading "git log -p" output?

Thanks.
