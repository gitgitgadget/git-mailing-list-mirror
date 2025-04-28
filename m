Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218626F073
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876432; cv=none; b=JHhiIiddjBgp/WNl7cJxz3qE67pNh9clObMTRK6yLZS4grZbAdgc+Fsy700M/nG7XMZ9J0Z8fKX3i4hvuDt17AT2TLzOEzFH2aFd5uhPFaYt/jd/WDgIDVEmUqVHQSeQrI3OWgGx9Sh0uuspjC0HaraQ2L8+8uq4PwcBhHdufbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876432; c=relaxed/simple;
	bh=w2IE+gENLdr1X9A5Og/Qitp1HAUAj+t13XMe1FPKU8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B3hpLS3uD/SBi7BAiUNZe9PXHZ95SjLubm4peHrW0btXzLSD38m5gRP8uOrGvNCAj3mk+vmYTZKa5u39kl9izHvjdEdS5e0rIxUpT96ixPetOvd7qCAyIHNL1H3geP2auRYuYKvKJIRqeqh23QBt32zAADp0yTDrN+OAwhEwzFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GKwya++M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KmvoqLbO; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GKwya++M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KmvoqLbO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 21A8511402B5;
	Mon, 28 Apr 2025 17:40:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 28 Apr 2025 17:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745876429; x=1745962829; bh=XEO/D0I7Ph
	8lI/V+bdMRH8otnCaEvnYsMR0hVJwKHlY=; b=GKwya++MzKRmURCcJXcwSMLY7+
	hWnD6IV98zU4ud4QXmoUSNCYiOdLPMVMAekCZA19uO90i960r6ozOFEUaub1Mnwi
	W3v4M5rAUJ+YSbwqYS9ATkgA/YpgWhWYN+EIyAacvOeKJSVfahdgvxCF6DAdxEUz
	5FJkG2tTQ0lKzZMuS54HXN2CDYj6bGTAyDEPNH0+SjcdsP60BzmgniZMACaDvQoh
	NSXT9zYsPcFmbz9J2hDn9ePYEZaZi8fdANO6Fyn9L3QMUyxgTB2nDIaaT+mxJ8CZ
	i701oqeYuElRIL7YVUIhKcbUOlHmCTw6qVGjaFUAq2HBAuUnHG0IlqQ3iLCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745876429; x=1745962829; bh=XEO/D0I7Ph8lI/V+bdMRH8otnCaEvnYsMR0
	hVJwKHlY=; b=KmvoqLbOHTa+oDLLO5MGwIisPw0oQV0jUZxo3rZAMYf3dgvjUm8
	esFKeRdNc1+IG3hhvjpnAV+OzPqSRvRAJfZgUr0OLe08xJj7kDnIV3df5IZI5zUD
	5GHZkN8hfcWpMs/S3WaPqwfVAWVW1K2Cx/2rq682xbH/4X5IdEPb1lcr4R6HnDGk
	CP5QchX3TvUeBVi4Sgg4ftpLWmwAj0tOp2lw1uwY9KruMRWcxjSi5Tp9rAI02ajp
	c+VG7js7TiygDh+uoAqRbYZnqZF0LxPnOTwjI9E4xQmJabytkbdd/tgiv/WiD347
	CThkxtW2E6jJ2tXltVmaSkwT6Q98vFeFsKg==
X-ME-Sender: <xms:zPUPaCpys8z-eJqHynLP85-ijFQAnMIr1xF2knDSvgTzDvMQpuouZg>
    <xme:zPUPaAp0p1PIIPQPaEj3onLglFWFNXPlouOzGQY7_lVScS-x7hbp3e1JdTS5XHaEQ
    rdpTeKAwxtAvDtxig>
X-ME-Received: <xmr:zPUPaHO8Ja3mjuegLABoIBf5Iom332m4NMLV2YEaok9pR6_hqo2ir8mamh1dNdYBr9F22gOrXwICJvsNGB4qJhzSzJsrjezfNAUd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedvtdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:zfUPaB77R1ljRgxIJ3iGypVBf8ucdKg-_EVYI_3uB8L-0axvY3ySGA>
    <xmx:zfUPaB6kLm8P6ZOumzOMUVpiMb8UrRG4jt_VwDdzNltSg4ewzaDD_g>
    <xmx:zfUPaBhx3Q4ZqSUQg2pYC3yuVSIh8GEr5Y5hsKZX5vUM7vV-ipRrFA>
    <xmx:zfUPaL5IoszDXGk9oc-q7wB9mp2lFtv9Nn8Y8h42DOY_xQ_ZvUmtLg>
    <xmx:zfUPaPEKi31D5R4rSJFLDmmWWOIxNdUS63-8qruMo-Qdszfow_2bsHxZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 17:40:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 06/13] treewide: trivial conversions of
 `repo_has_object_file()`
In-Reply-To: <20250425-pks-object-store-cleanups-v2-6-63f1695b7700@pks.im>
	(Patrick Steinhardt's message of "Fri, 25 Apr 2025 09:08:57 +0200")
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
	<20250425-pks-object-store-cleanups-v2-6-63f1695b7700@pks.im>
Date: Mon, 28 Apr 2025 14:40:27 -0700
Message-ID: <xmqq7c34arsk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> As the comment of `repo_has_object_file()` and its `_with_flags()`
> variant tells us, these functions are considered to be deprecated in
> favor of `has_object()`. The benefit of the replacement is better
> defaults: it doesn't fetch missing objects via promisor remotes, and
> neither does it reload packfiles if an object wasn't found by default.

The reason why the "better default" being "better" is not clear to
readers of this paragraph.

It would be better if too many places need to pass an extra flag to
disable lazy fetching in the current code, for example, in which
case we would instead have fewer very selected places that would
pass an extra flag to lazily fetch (or even better, see has_object()
fail and then invoke a lazy fetch themselves) while majority of
places would just work with the plain vanilla local repository state
without having to worry about lazy fetching at all.  Without
explaining why it is a "better default", it is a bit hard to justify
"the benefit of the replacement".

This is common to this and the previous step.
