Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E01FDE33
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878043; cv=none; b=OR7brnSqbvl2f4c+ayU1Gc26c1+ptzo0Ob5HrU0e3F23s6s12Ocs5MQE4Ec8tZmieSGS5DnmsiGv/Hr3ut/ptZ6mFT7C+BQWcFJ13HaNFxxrSWgiTkWbEFCTmbVpJyMElpiSg4Hx7HJfZolGgzIL9J8vwaKYm8VzAVuB+qgZM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878043; c=relaxed/simple;
	bh=gDQ7Yn2ovRr76rIgXFRLFcH6970NpLezdw509YMfpF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkqnFsZCChaRZ5QiIqegTi25TY7Wvuvmi68GYb+jZl7kSkykHCRDPzkQz3scL1Lw/Is1690xUAYtVFTVYvTXPykAl8TGJuib09mOa21LAdNe2tBSVlLmB9kpSGbMRxmk5NPB8ulnAVVCA8bXCZLqsUxlbC8++uKhuvZssjlyhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZZkTZskw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vbxtvYNm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZZkTZskw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vbxtvYNm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60301114027F;
	Mon, 28 Apr 2025 18:07:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 28 Apr 2025 18:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745878041; x=1745964441; bh=gDQ7Yn2ovR
	r76rIgXFRLFcH6970NpLezdw509YMfpF0=; b=ZZkTZskwci1Sk3XaK77Ald8T7d
	O9nz0fHgKApvYTjOQ9cTOzINC8TG4Vo1MX6dRY+zXI1mTfagWwhk/0G3ILomPKCg
	D0ktn/fIIhB3LPpasote/GTlK5S5NYle852cJvrRE6SQtLYAtHBWq3CX8hCH9gDe
	eqr1889OIo5OWuEhuSQwTpQC/Fkahq17dkk2A6v1TPEHUsLpzp4oxQIY2Fr+ujLd
	gIrR3KEMAXOXwFJXmYKSl6Y4ft/s3Q+50AwKr+HCDVhIscmWYkg5RygcseW5j6pk
	vEhOsTSYCIs1iiDyM4Fq+//K7hxEdHcrvs859P4DDBXcF4udOhM8hjUJ7bCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745878041; x=1745964441; bh=gDQ7Yn2ovRr76rIgXFRLFcH6970NpLezdw5
	09YMfpF0=; b=vbxtvYNmosz6uT4UOEYeB8Prw+3SRwihjY6QAI54zcQRHWPLGAi
	GltYLeinbASKp04lbawsLoYRQNlzxlYcWfDunLOq5F9Tagq+Zb5W4VZwC6zOHdqn
	GCnH+YrU2LRc6yNsQcfNQGjCTrxQ+bWdfg4ky/b3e/9Q5vOntZ5cId70RQqZfauF
	M5U9LEqLZZfnzQywC8qUddt8g6Tsp7Sut8n2EBbyWL0KsADmRttyeDiJGXkq0D7d
	FuqIVhX8kLIao0BabqOLdKVyUr2Gnczk0OZW5d3EuQ0YD9w1OsWyC0seRiyjaPl0
	SeCfYYuww0uxCBG2zRzRTBkA2ncudya1W9g==
X-ME-Sender: <xms:GfwPaOwft3dyghjZC_9M_Ra4BV8kSZHOs3vT-wbHpR0JWBRJ_Qt3Vg>
    <xme:GfwPaKS7LN1raZNh_pUYJeTy0br3x8kR_irISQTpCJD4q__5Yn8uj3tBgnVyNxnA4
    wrnlE1G5QomPk5IfA>
X-ME-Received: <xmr:GfwPaAWVMYf6V90Ag2SK4fls2D0Cf6d4QU7qh6GpzmZaG_CfvV8GvFlHvrVqpWOiSFkeNL8AwYYeQHefkMAN9KVNPpizQZ9qylfF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedvuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GfwPaEhdfhdsG5spabiACK5ESqh1L1UuymkIEMf8E73Nxrv4p7tWIQ>
    <xmx:GfwPaAAsQDN64CdUTWz1ioZTmY4fk838TjdGBpT1OxrWM2uXLMk8Pg>
    <xmx:GfwPaFJYwYq5ew0ownqOHk99h6s0GReGnyLdEeK7Y8kI4i8pbQKwLw>
    <xmx:GfwPaHDY4cMoItW2S76gMzPfdIaYT5RhuSq-mK9nGVROZNmd7IBbKA>
    <xmx:GfwPaAOO0tPdiqmKi6bMbpVVoKfZEpNtYdlfTUJxcP7DBgpL72g7S-Gq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 18:07:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 12/13] bulk-checkin: don't fetch promised objects on
 write
In-Reply-To: <20250425-pks-object-store-cleanups-v2-12-63f1695b7700@pks.im>
	(Patrick Steinhardt's message of "Fri, 25 Apr 2025 09:09:03 +0200")
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
	<20250425-pks-object-store-cleanups-v2-12-63f1695b7700@pks.im>
Date: Mon, 28 Apr 2025 15:07:19 -0700
Message-ID: <xmqqikmo9bzc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In an ideal world, we would protect against this by fetching the
> promised object and then performing a collision check. But this feels
> exceedingly expensive and ultimately rather pointless, as more common
> writing paths like `write_loose_object()` don't protect against this
> scenario either.

When writing loose object, wouldn't collision check kick in, and
didn't we compare "existing (not here but virtually here due to
promisor)" object and what write_loose_object() tried to create, at
least before this series which may (or may not; I lost track) have
disabled that check?

I think the overall goal of deprecating the function with long name
with another function with a short-and-sweet name with different
default is a worthy thing, and while I do agree with "as we are
replacing function with another with different default, we need to
pass different flags to keep the same behaviour" early parts of the
series, I am not sure about these latter steps.

Thanks.
