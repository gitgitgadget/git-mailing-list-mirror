Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE992223DFB
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331868; cv=none; b=E48GmumJGJmCj5jwUwipMuL3T6wG+Z1KHqZxG6zS2OHONUBprJ9fE7FcYZL7yRI05Dz59xTAzW85FJGdBoU/shrhsrewiorUPevSndOekgL+kR9QqhNymYYpK5uErlCD1lr/5SYsN9pHAA1N2skIHx0lveDayYXa08OOXI1ApEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331868; c=relaxed/simple;
	bh=MRzIA7vTa8XwqjkEUuh7svFilcVBAWFtR2u1hKvRWNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZOML1BlYjAEUaobZ2yaOApYc5ga0UsIB5swBv2ZDt3YjJ+yZShhdI7JdffqhVAGWFzPOcaQI+VrOxBgTQnTTcPy3MgjoDzEIIdj1Y56DWZn6kY2OWn1D3W7/tQKiOxBft5YI3uU5oK/1qrdilVUMsfIdBhtP8KK4itzfu47BMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PGZYDxF4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bb6vPHd/; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PGZYDxF4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bb6vPHd/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B300D7A019A;
	Mon,  4 Aug 2025 14:24:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 04 Aug 2025 14:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754331864; x=1754418264; bh=mrVVquq/76
	CraeaxXQVQN4ozd7QrnMpn16V6XGPfFA8=; b=PGZYDxF40Q7NCcFxYzLzU+Lv7K
	qe0MaxB1NfeItHcUuX53qUIhYM2kX+mS+JRjWPP5Wzp6zYIqrK/EGk2Oa8E0YVjL
	Sy37emJTTC4sNkdmfXnngcl1mefc2SbpddFxe+BmGuVZcqwUJeZy3h1JvdRiRrIS
	NqUDS9OCnctazmGiEjUNCd3zJJNiaA4fZKB8C/Am7CTiVOyvA5RvNS4hDL54EiJ1
	cyIigM9b99Y8eBNytegSNIy9tPEImRpb9sqeHUQcOCOvoARaPMIVZC2B8Fis1Fdq
	K1EoaC3n9iRbGC2o6pUgJ8mUDb35nU5z2gWyKnR2VixI29EAiizAopLBIPIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754331864; x=1754418264; bh=mrVVquq/76CraeaxXQVQN4ozd7QrnMpn16V
	6XGPfFA8=; b=Bb6vPHd/jwnQhdr8xNfD5v5r1xpSjM1gHRf90OPYqOEYHzt3MWh
	17tBNeDT53JsHp6CnXcdPb8NPL7kMiRYS+ALUsRoMYMW4qrlmAIgHdHsC4Ky6h82
	0wxNjvISFUGgOfCe42V0McF1BqhI2HMXOvCudFI2L1bHedHJ7nz/eT3VGln5wUQ1
	2C6NMWEQwaOGEP9A3Tn15jlL8FoZggczta5CbzdpqZeS+a5Tz3TB5Wl+Mdpo7QiD
	iWBIu/Ji2p8LmA8K521vSRFfG/wNwrF3ybtIy03a0qbIQsMyu+RCXo1u/f1KIpVY
	9QJF1ZHttlAEAakiC+uT6wDzBLzlUTfYMaQ==
X-ME-Sender: <xms:2PqQaPQCymTH0DYWZm-c9uMKbDxjnUP5CT-keiDsHEGTgtTa1zaLYg>
    <xme:2PqQaOVV3qTVHlkqp066FcSXGBwVhCvkryQ1Kz5r-BYkVjaK2lyfqV03iYBjNgr6u
    hVcwaKy2aSp6LvlMg>
X-ME-Received: <xmr:2PqQaLS-oUcXU75HdUv9PPo7fUZ7nnLkgGU0b6ULVe_HVgiHwvfqY1409SUyXfSoGuQ--dYBJ_CKr_MngvteQtYWXXMK6XjyChNbBSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeftddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtghomhdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:2PqQaAm_2P43m_8fDa5LfcDCnhfJ7nKhV5HP5aF-psZ05GaGRf2RyQ>
    <xmx:2PqQaJ7MhHpxkPjgviOQdYe5pPMyTtb1VDGbBarRnWHrcC9ja1mVpA>
    <xmx:2PqQaOhu45MzK00ThgZPN3r7Y_W4_OOt70bV8E4r-9uIx__JkXpPew>
    <xmx:2PqQaOGjw0nNMnK91Q5WHtSHuYsqGjpeBHYND0eJwQU1KaVeU2nlqQ>
    <xmx:2PqQaLt0JYx35NDHcC1ZB6om1g7l8hMfIqNMWWDTq9WT3zU-VsxQDBOw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 14:24:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Han Jiang
 <jhcarl0814@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/6] builtin/remote: rework how remote refs get renamed
In-Reply-To: <aJBYdBqmPtfS-ocR@pks.im> (Patrick Steinhardt's message of "Mon,
	4 Aug 2025 08:51:32 +0200")
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
	<20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
	<xmqqcy9gqiht.fsf@gitster.g> <aIxJrvqLvEl8qM7V@pks.im>
	<xmqqpldfm1ps.fsf@gitster.g> <aJBYdBqmPtfS-ocR@pks.im>
Date: Mon, 04 Aug 2025 11:24:22 -0700
Message-ID: <xmqqa54f54ix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> There shouldn't be any textual conflicts between these two series.

What I meant was this.  This series is built on top of an older
iteration of the other series.  The other series however has a newer
iteration.  We would eventually want to both topics in the system,
so as an early preview, both would be merged to 'seen'.

The topic branch for the other series has patches from iteration vN+1.

The topic branch for this series is, since it is built on top of the
merge of the other series at iteration vN into 'master'.

We merge the former into 'seen'; we now have patches from the other
series at iteration vN+1.  We then merge the latter into 'seen'.  It
wants to _also_ merge the patches from the other series at iteration
vN, that duplicates vN+1 but in different ways.  If there wouldn't
be any textual conflicts between vN and vN+1 of the other series, it
may resolve cleanly, but is the result sane?  These two iterations
are trying to be moral equivalents, with the difference that the
newer iteration is trying to be better than the older one.

And they in practice are most likely to textually conflict with each
other.  After all they are different iteration of the same topic.
