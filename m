Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A22D4B4F
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433280; cv=none; b=KHetYQjvO7l6VznHAP+CzNVvWj1ZzMYe5CzFJlw+gDsu9WkJNSueVCY9qGYtq4KRc/v4pwvjf7uqtoX+6XlQjG/kFdO+sJ8m0sQCfgwSXsY0C6Z7eCJyOCesg5YLUNcmtMeexCefESZQchaPmB/IKLE3/apkHOm69U09xRplw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433280; c=relaxed/simple;
	bh=C93WEiOuh7zOM21im4YbaHRGhH+0lXA21sKZ6U6CATM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gjXZwkLAOB0HUYOb9DT6MC0vb3PfI07xqh2garvGa7pa6jGgPgYHvVa/efDAurAxP0C4On8maTANv4rNb2FFrgz7L7unSLBG0/uyGDG12HMHR8pcVCcV3BWASAWWCNwUBQQKHDCjljDPiebXEwXOifAYOX2B1QiAev43TwxsZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iGp7U5oy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RIko20sF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iGp7U5oy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RIko20sF"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CF4411401D9;
	Fri, 20 Jun 2025 11:27:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 20 Jun 2025 11:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750433277; x=1750519677; bh=AlHnCs/Jo+
	JgrTmf7olBOSm/dc7v3CQabYf/Zw74aO8=; b=iGp7U5oyLqJQ6spHU9LywWfg4L
	WpNFVSCUMmk7TK5qqGF1fvSff1W2bg8PIz2kAX9bFZvfgmwjGhJhZSOMzCEE+WSA
	kAGTlAvbAh6CnpZWpvV04Y6hC/uuBaKj0IbnMiZlfvAOEjIdAKz5PjVA2FohGXq2
	lvnJWeCO/SFs+fu/W7sHLpyClCRwFrfllHsrgC68mTT5cWyTwXuggqm7Bkf8SiSw
	7bGemPHPjMyV2R5tqYk0Zh1/dVxgbo7Cm/aCogt9mMwpYWw8A5OCxhAzqAstkC4c
	hUE43Jvy9JiQBSHt/H/2uzjLPvjzg6ymyTdwkkyNkazjiEGY4uh+x0L6a9tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750433277; x=1750519677; bh=AlHnCs/Jo+JgrTmf7olBOSm/dc7v3CQabYf
	/Zw74aO8=; b=RIko20sFcbm2YlmIZhmoIS6Au6hIiVDIHx3OhxQYa4YM56bA0dW
	WZp1CqZLhsOQwwVeNDSh6oSpCRv2x9oxhNWx31pSA6F2epIuhENZ/IBqTasFSZ5k
	/fdSpCqEkO999dFXXVNluAj9CamaShmgvkcGtUHCvhAWY/KTfdWOgZ38VveWWbko
	Jk68toteGM/tvZD+NvwbLXX7jfnDfnTVzbBxbIpR1jTk8THPRioZQp47+jdHDnR9
	AM1peHHr+kRLZtOgGUKeWtgDElcY7tk6oHGhWsEm32ySM5Vu35FGOzGOCBXrAqSC
	RcGj3JyzmrYAHiBAZegw4fO+07XUPibXg6Q==
X-ME-Sender: <xms:_H1VaOraRz3tSa5wYE89KADNAdzR4x20aR6d-2PMnjc7wJVXkc3NJQ>
    <xme:_H1VaMqN9KkViqpET1Nbv6OclN3lRqACBxYRIpZdzU2__trg6C6m6hLVG9POxZThM
    XpeWZGHwWI3DwiO1A>
X-ME-Received: <xmr:_H1VaDMzHO6jx-KB2pWYeNQI-7NhAyIVJQicM0yQ0tAG0nhquL5v2W_GIKL--mfjxi5FSppAqEN884zHtWC2Y1q34KSIX5Ypb1xM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_H1VaN4K6Wkn5h26ohh3rCb7E03SvXiXAPji4R-fSOJEp-lGz9AScw>
    <xmx:_H1VaN7Y6Dy-1n4m_tcEQad3cle6l66ymvJbsLSF8tpX2DOAEPsdbg>
    <xmx:_H1VaNhmihO9N3ZXQR__C1zR4Q6wwKATTYmQKb3Ozy7sIx4yLJaW-A>
    <xmx:_H1VaH5rETyF1_sGkXXNuJW5T5uYpoo9yVFPRFIwST4zniXjySzBNg>
    <xmx:_X1VaEO4_o6jLrtM5y_Ymck0Uof2W7ZLcgJEZIfpSAZWNmx-ZoTMn2wu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 11:27:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v5 8/9] pack-objects: introduce '--stdin-packs=follow'
In-Reply-To: <b81b6213e8f98968a98bd147c068090cfadb5f92.1750375803.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 19 Jun 2025 19:30:30 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1750375803.git.me@ttaylorr.com>
	<b81b6213e8f98968a98bd147c068090cfadb5f92.1750375803.git.me@ttaylorr.com>
Date: Fri, 20 Jun 2025 08:27:55 -0700
Message-ID: <xmqq5xgq5t6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> +	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
> +	if (mode == STDIN_PACKS_MODE_FOLLOW) {
> +		if (object->type == OBJ_BLOB && !has_object(the_repository,
> +							    &object->oid, 0))
> +			return;

Sorry for making a comment that is not about the contents of the
patch, but since we were discussing clang-format elsewhere, and this
happens to be a case the tool gets it right, the above should read
more like:

		if (object->type == OBJ_BLOB &&
		    !has_object(the_repository, &object->oid, 0))
			return;

cf. Documentation/CodingGuidelines

 - When splitting a long logical line, with everything else being
   equal, it is preferable to split after the operator at higher
   level in the parse tree.


