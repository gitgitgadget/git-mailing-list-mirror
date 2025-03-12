Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95A800
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808822; cv=none; b=BfgQ5muUbyGOG/kVy9+M4aGG1fH2MP9oqSMk/xlppG849OeuoHbQce5CF7w4ondXRCBDBoKcvoKjP6egEhbdpNnw14BHj2VwX/nd1vIPiKVjjgNezjNtCaQa1KlVTCp0oH0EWcfhH1sHgl1Yt+OFScqx+vR9vz3hcQ6uAjjgReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808822; c=relaxed/simple;
	bh=10PFqFWhPrH7q2Zp20KEoDM8v5xnksPBlziDDV3RP7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rxxFXlOiuz3CVEKQnrBpYXC2DDX1UJbUqNtvlwpMCENvMeKl9X8AJVAfOWaQjmVkgX6aX9ij1R5PWhJbrFhB0s97HCkmPpQrIn9KJjXH21ApPBLCw+Ogxw6JMPWXYF+/TaJmBBiVRlKMezVRFO/b0RNcZeprq9/6FQS/PPQZWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oLxiRFKl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SoSSjhfs; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oLxiRFKl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SoSSjhfs"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B494B11401FF;
	Wed, 12 Mar 2025 15:46:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 12 Mar 2025 15:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741808818; x=1741895218; bh=IYmJP+DzKm
	EtWBuhqnzWBQ7ar2zVKAvnzye8jSXl4Xw=; b=oLxiRFKldypc4U4VpVpwIuHYI8
	qUhtbIDRN+h0elL43z3fSPNDVUb47KMHVQeSm6HrkSLVIOaGnG/vQzwvBC1NRul4
	AtKk4tnepxT8dtGaa6cprpFb3jf1oTTKF29U0UyO8uuaILD3dXdXx765MD62HZND
	82BejtMswDWSqSlJ2C0vu+JbH6dKZ4qVp75vwqojquhf8LdrZutDb+jbrLrpItDG
	ty1ZVLSXbirERcSU5T7OxX1oplgFqhJdLT611V9dRaRs3a1iUFBBgX4ZYhqvd/Pk
	gtsAIxSduOoQ02b4soBo0kbiNuItnSamVGlxG1rSxZTpQdyl0aoXSGd9O0NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741808818; x=1741895218; bh=IYmJP+DzKmEtWBuhqnzWBQ7ar2zVKAvnzye
	8jSXl4Xw=; b=SoSSjhfsPgeAOn9c408Hhlzo3oD7N4hzauIhtTwWcYkugutYLBu
	VE1mGmcMkvv/UzmA69IGI3IZ/KN7P1mQRsqIWVYUVKYLUMmDetnkkADQRfjGfoWt
	EiKezCUMr6Tjai+DP97P5N1a22QxZwLTiR/bGWzgY0hjayz7nfVZS/YUSWtQqYtQ
	Ttq0+Zh0W8rOwjOfhv2hzCpfaK6yudVXg5ptIDi1H7yLFQPpIcI0iNXzrgdT1/XZ
	dtG0nxlbagNI2axvcEl47svidSlosKkVV1LxAjwCHl0kQVSINByTZ4PSS9gKFkti
	3Xu2ETBkGfRDLTZexrofa1VVPMoHJXy9udg==
X-ME-Sender: <xms:suTRZ5ue8c0DTYy2VkM2LaRY9o8HJf6ixuZuweJR0cPOzTx9lgtG_A>
    <xme:suTRZyfmOa1M8eih_D4kMTdpG0cv5PI-9cNkllHsx1g00oOm853fKdluwGQBHiMMz
    8FASMOiMckPxRDFwg>
X-ME-Received: <xmr:suTRZ8xgwruExEhMdqhOjBqaANhFYFnWy1L_4ETCMGOf4IR4bZr8ZGwaIEpCaDJOp0bxgmbsxGn6AQ2qA4MTwmb5Q3Yh30PYAt9S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:suTRZwPrrf1tPg6z0LX0Z5jemQl2q-cz8zonF4nQDFuwwjOU6sMaiQ>
    <xmx:suTRZ5-GOcHtp1Uz4jimp8CjUgteiYbVdK6a5QkK01m-rurzvU_CrQ>
    <xmx:suTRZwXI63H6W1tt--tNOGIbDQRqD9aMfFPcW_ZuFNgbiVdrq3qC7Q>
    <xmx:suTRZ6c5UoT5TeE0-9xHilgznu02YmRnH44uqXie2C4utscfS9ywhA>
    <xmx:suTRZ5zgP9eoIuMSpnni89BDIUS-P2X6WQQZncw3FBD6ZxH_WnHwJ1UG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 15:46:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/6] pack-objects: freshen objects with multi-cruft
 packs
In-Reply-To: <Z9Ha2mFXpojI+aIR@nand.local> (Taylor Blau's message of "Wed, 12
	Mar 2025 15:04:58 -0400")
References: <cover.1740680964.git.me@ttaylorr.com>
	<cover.1741648467.git.me@ttaylorr.com> <xmqqr0332un3.fsf@gitster.g>
	<Z9GpQqm4YBvWF7Ff@nand.local> <xmqqfrjixfwe.fsf@gitster.g>
	<Z9Ha2mFXpojI+aIR@nand.local>
Date: Wed, 12 Mar 2025 12:46:56 -0700
Message-ID: <xmqqa59qxc9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Maybe we should call the option something else that makes the cruft pack
> use-case clearer. But in the other thread I came around to the idea that
> this case is too niche to address completely, so I think we can discard
> this round as a terrible idea.

Yeah, I do not think "an earlier attempt wouldn't fill the bucket
fully, so a later logic may try to fill the bucket with the same
material in vain, failing the same way" is a problem that is limited
to cruft pack use case.  If you are repacking real data into 200MB
chunks every week, the 198MB pack created last week that is lying in
the object store that houses the oldest part of the history is
unlikely to be improved by repacking it (since the attempt failed to
fill the remaining 2MB last week, and the oldest part of the history
hasn't changed) but it is entirely possible that with the pieces of
information left by the current set of tools, the machinery may not
realize that fact.

Allowing the resulting pack to deliberately exceed 200MB ceiling is
one possible way (I still do not think it is the best way among
possible ways) to mark the pack "frozen-do not further touch".

Now, if the essense of the problem is when to mark a pack that we
stopped appending to due to max-size limit as "frozen and do not
touch" to avoid this problem, how such a marking is done, and who
uses it to avoid repeated work that is known (to us) to be futile,
there should be better ways to do such a marking.  We have .keep
mechanism which is ugly but proven to work and we know how to deal
with, for example.

I wonder if our pack header or trailer is extensible enough so that
we can record "this pack was closed due to max-size limit of 200MB
and appending even one more object in the queue would have busted
the limit".

No matter how such a marking is done, later repack that sees a pack
marked as such, when it is limited to 200MB, should be able to tell
that and act a bit more intelligently than what it currently does.


