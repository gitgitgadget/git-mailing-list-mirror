Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCEA220F36
	for <git@vger.kernel.org>; Thu, 15 May 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327188; cv=none; b=BK90UG3Vcl4yzVAmgfvPP6sJIn72xUYQ0PaTJtdLdQouuRWaLBYJbIuPqYhn0FNK5Y2Rgk4LXZ04ntrOyjTia1Hg6DirL30GedB/BunnYOyeuODrL/c77KKnW9lMO8knO1qgs+9K2OTQr6y+VN0Kxdf5gnnqk7QyZG78zGv1qnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327188; c=relaxed/simple;
	bh=e63PUklaiWDKDo1l1FVKVjQv1uLEn0dGbNzNVcYlVW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X5Ep3QDeQZy+bMAlYyIwMj2F/TEm/jIUZJ5RFcxEHZD95pqF3YuoxmoK5y2vVv3QQWpY9SVgiTlZVCmUuD3xHZ8lVlvkmLaHxOoDv7bz4IN/PxagiigJ1Eao38VEg6Z0catq9BaL1qnzbO3t/lE2vN7EfI+4+429mrv3kE8rhlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iAKbQBXW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OioXF0sz; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iAKbQBXW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OioXF0sz"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 124252540127;
	Thu, 15 May 2025 12:39:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 15 May 2025 12:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747327184; x=1747413584; bh=e63PUklaiW
	DKDo1l1FVKVjQv1uLEn0dGbNzNVcYlVW0=; b=iAKbQBXWxLfSzphdyNNNKyjW9W
	Ft6MBNFIiFp8RYnb5iEiT0ZxaGOk/GFjzG/t27FBCI0jca/Dm8PlNz2ixHRmJTNl
	nr/bwTuwDDpUNqgjN45FBfl5Me82kQSYuXauGMD2E18jOhXtavJ0jap3N6KVsi7W
	ydn7dC9svXEVOuToTWGYKsb9LqqyKqv2aZMwEwlruMagw2dYHlh6bltAugNM198E
	0QOtUJnbsR/t5/2ZCT1FzuR/kpm4uMWa2GC9NDn9HfKJMMpRJn+ZulMSKZJ7S+qu
	5Oi+JpaKo043dJTjBDMtB25nmNx9BLmSdcOyEH87eQXufT4ePQ9KhzXqw3ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747327184; x=1747413584; bh=e63PUklaiWDKDo1l1FVKVjQv1uLEn0dGbNz
	NVcYlVW0=; b=OioXF0szFMDsjJIOW35deZF/a/dahTl+p15Wu0BPyQkOOvGr3+d
	tD6CdXbiHPh9tC+UZ9fOnpxIDJYx9ZqtklXkEPZTl4JG9cQDODB/Ef+XGZUvJAjU
	xZGRfGouV5kfh9BSogg6R0J3UzRUU9juMOq7ITaVd+Dfo+4CVVhZuknFLwVrMLIk
	lrgSwbj/ViKPyB4JEEMyC0xeNkPbS6LYHrIrK8eeL65mscDBtcX1Upfqz+IQBKKZ
	KAKN1f6cqsXuK6rgHiLx5/VxSxtUG5OFtkqrBwRj6GPkN2T7Mxwhs0E0fppQe3f1
	v7rCS0hDND0/zqPYF6R5eV6PYnwZ/m5rExg==
X-ME-Sender: <xms:0BgmaNscJw2AbCMuc1IlqWBDqQ1XHC-uRBXU1XTTmCmCx_ocN43G2g>
    <xme:0BgmaGcnbolZtzAcZcaUPS00EOhqQG4iASzAu86D1wzDatkc2sW916rLLfsFSvXQS
    DT38sl9uyc7BM_BTQ>
X-ME-Received: <xmr:0BgmaAypoRcVf3WEGEt4txAVjc4n9baPnA7dUYDm2RoeLxHRcbG-9WEety-HxYWr-eytPXptnFYV_R5TgNj5vNslftLqvXHR_MXBHHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehmrghrtghnrghrtgesgihiphhlihhnkhdrtghomhdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0BgmaEMuqdE0r-becDmvn1Yz8Vhc-KzODlx0cfxyXoz6l-te7Z4DZQ>
    <xmx:0BgmaN-ooEDRs6EHWbcLclZGxlZk2zfmLAFy10k3Srqyw9urnlCRaA>
    <xmx:0BgmaEXdmmx2ZB7c17rpdUp7HxE9a4-GKigdin589_1ZGKmRpbTh2w>
    <xmx:0BgmaOfF9aSviW86keYufuHX8XMdBtGZ7Uxi_i7Hu3r7hHbtaJ-Qyw>
    <xmx:0BgmaHRH8W2xyGhhnQnZ6N_kxDtLS4RrrFai8O9XNElEVBdm8PYpkfD8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 12:39:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Marc Branchaud <marcnarc@xiplink.com>,  Toon Claes <toon@iotcl.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
In-Reply-To: <aCXsKHiP4uIzCMrt@pks.im> (Patrick Steinhardt's message of "Thu,
	15 May 2025 15:29:12 +0200")
References: <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com>
	<87ecx0ijqt.fsf@iotcl.com>
	<323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
	<xmqqjz6sb15u.fsf@gitster.g>
	<7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
	<xmqqldr789gr.fsf@gitster.g>
	<9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com>
	<874ixnjltf.fsf@iotcl.com> <xmqqy0uz7zzh.fsf@gitster.g>
	<0f491261-bbe1-474d-a240-0ddbf22cc754@xiplink.com>
	<aCXsKHiP4uIzCMrt@pks.im>
Date: Thu, 15 May 2025 09:39:42 -0700
Message-ID: <xmqqa57d3k1d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Curious. Isn't it exactly the same what git-blame(1) does though? Taken
> the textual representation of a tree object, we figure out when each of
> the lines has last been changed. That to me sounds like exactly the same
> thing as git-blame(1), but just for trees instead of for blobs.

That's mechanical worldview from the viewpoint of those who know the
internal representation and workings of Git, I would have to say.

As an end-user, I view "where does the body of this function came
from" and "when did I touch this file the last time" quite different
and unrelated kind of queries.
