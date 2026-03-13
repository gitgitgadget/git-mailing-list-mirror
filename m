Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444E35950
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375593; cv=none; b=esE7jRYYoSwyi8b5VojYCCTGKyPpQtA6pRAZas93mM2TPmCZlci8k2GooQslbdo/kWH5YKl7/QGd66JaTe7q/c00urUNouYv86v8GwzHqAd0bBup91JfbkAi0wTB4yEXHF6RwkQgPDsbX6ywjQvkYDorTwmowhsKifTnC1ZA7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375593; c=relaxed/simple;
	bh=wZFHRX9D5iOmSFf2UacsoKVGJnY6HsylX18m0LIQ5v8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NyRT0yHnz49yZMvkh8Gr3qthSQakhCydrTqASJlEUFFmTWSJOgH6rWWmAs7jNj7T8sIeAVL/SINV4X/cQNxtkrbEOEER6YPGjBpF08TooaQ7BoPyqtXKyZlJmnnFg25rXqj4dUGMw6WNfUIgni4JBGkZc3GSIuL28DvUaSfPWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JVWberHA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DRZgUJEJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JVWberHA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DRZgUJEJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB3B87A01A8;
	Fri, 13 Mar 2026 00:19:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 00:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773375589; x=1773461989; bh=USFJFaHNb6
	otBdCkAv5FtlmkPExcDsooMVM77UwBwJo=; b=JVWberHAFrKWl08KeopXKVLJgR
	ZO0oRQOY8RqjsX277MSL2acc95QykCO8AaWxyMMGXQM96vCDdZm0c3/MV776P9pM
	b6uhsznWxhXzP4gD6k3mMpv4ooDgk4Ritic0lPLWIEpyy5HYOom3geLK0ML4i/Nm
	6p9sFcE9RadJbhmDYfoWv91w9dDdwhYfF2eQOfGYKhKSlh/DQWfJeUZ20FSC39kk
	tgCN1D6dXC3Ex8w2WOuNmkIMy51YXrG0mPU/1Xz+0eolw4btXn039TOo6Y8vItdo
	NB9FYkXm0HIGWODwRWh4agAuhL4a6atblRD35vldlTCijzE4R/33vp7Bp7iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773375589; x=1773461989; bh=USFJFaHNb6otBdCkAv5FtlmkPExcDsooMVM
	77UwBwJo=; b=DRZgUJEJ6j8ey7E9uE/pg3bn33mB6zWrHiZYHjzS+y9FH4xSqE1
	0X3OFjGkwHyHn8cac+8/7IVEGgRw+5Q7nDKe4MfJlOip7eRfdt6KtMIRiwiDhxpr
	x5N0Wq5k++jrRrWU5hm82VV76wlT1C42AJ+Tt72/yApj66neF6anDdoCsLZFubsC
	wIIIgh43Co31qz1lGG5u3ssmNME5p0DtFc6aVE6cXYMgMCZutezyB76knlxUFMlX
	jmaUPx/vgHgw0KmUt18j4JZacLZ3vmQqZjuNfpOu8FODBXHn+DttLHn4sQfQAvRC
	MpVen1IH+IpNBBwtiBTAtpsnxfXPkWUPmVQ==
X-ME-Sender: <xms:ZZCzaZLQVd-5Dio4lvo2DwVVFOGkbQjdBO_CcfVLMBQFO66WLYevCw>
    <xme:ZZCzacK6s3aqqv_lvCRkTLyjj73SfE3dwyH5HzczxLG2aczMuJepiyj89SNPIJMTo
    HEqyjDV5j5XOogYl71MdiPuGIrUbAa3tlVLHN7q4WUNZpP7JhbW>
X-ME-Received: <xmr:ZZCzaWveEtlzv0TQwBEGbCdUumUHpVg7-6hxG2TSIr0eebXIslxKLJhynGo0gde_AnV0OeH3Bx_HgybVkt3GiHq75AF9g9eEaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvg
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZZCzaZTjoA6Q4dHl7bb092INJbsunYGRF-xNpdGFayxM4DHII8WpMA>
    <xmx:ZZCzacMTqZgesSc9ba4cfBlIEjXJ713WVDzXGh8Ut8ST1q5jtpJInA>
    <xmx:ZZCzaebpGIh75OJi1ywj0dMHQc6ihGbFppQQhffmYdETmOkudiSTmA>
    <xmx:ZZCzaWxOs_CnF-W8Dyn_lvBjs-yH2zysW4FdtbmrawFi-tuob1-ZMQ>
    <xmx:ZZCzaWODgjGm_S7NW0n725GCpxLWGtB_Gm38z22cLIrdTLuAb6MEUpmU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 00:19:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Mirko Faina <mroik@delayed.space>,  git@vger.kernel.org
Subject: Re: [PATCH v3] apply.c: fix -p argument parsing
In-Reply-To: <20260313001629.GA3193660@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 12 Mar 2026 20:16:29 -0400")
References: <20260310005408.2022216-1-mroik@delayed.space>
	<20260310050621.3849719-1-mroik@delayed.space>
	<20260313001629.GA3193660@coredump.intra.peff.net>
Date: Thu, 12 Mar 2026 21:19:47 -0700
Message-ID: <xmqqcy189x98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> diff --git a/t/t4120/patch b/t/t4120/patch
>
> Not related to the failure, but IMHO we should keep small data like this
> in the script itself, rather than as auxiliary files. The t/ directory
> is already quite crowded, and it is often easier to refer to it when
> it's near the tests themselves.

A very good suggestion.  I actually did find it a bit annoying to
see an extra file there, but somehow failed to mention it in my
review.  Creating one in a set-up step and reusing it would be just
as simple as shipping an extra file.

Thanks.
