Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C4376BDE
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683734; cv=none; b=moTbszsKSOglp61ZfZbnpBTXdDtrcmdKXZt77B4Q3qQaSBliyVhx9cq42zEaz2gFNc2pc9/GtUsBXVKlZZI7urRY6yHSFU3H4LWc/r382Nq86H/BV9SWoRiPXcqnR9AEaIVeQ8YnTLhb6bfdEMVBnHAxG19xohULW+TZmTGiHvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683734; c=relaxed/simple;
	bh=sYncpzH4ohZo//HXXYBflwN9MQETELwOFrbGf1HhNpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SQbTkjFxJei3VOShT+5/WGt2EmWexPjOROxxncRvYpEAlBTtPr/OQ9S8T3DrDQ86am483ky7dq4LP9uHOkhwFt3OCGwpirchRZWAS3PDFUMfkwFI//EzCtEOt/1K6c51wdaYkLqlgdhEz89VIy1EuF2y1Dxh0SzMZ7zQYzkTlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tCbZOByg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sRsTgpqk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tCbZOByg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sRsTgpqk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 85F48EC0469;
	Wed,  8 Apr 2026 17:28:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 08 Apr 2026 17:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775683731; x=1775770131; bh=xvCfT9tdmj
	ndD5T/3ElOQ5ovtRK5arXRYiCTbdRdX3w=; b=tCbZOBygJLwnCre4TCxPuMDELM
	cHU8iRSdeOYzSGKHrbOH7oMfL8Nha5cfX0GOYxviDgKImQTcXFsjPMlCYWDwkduv
	3DulcqTz1mCwgUz4jVcL5p+xsnI/AqnIh55xx+o9mxAP+BxRCd6R+zIrGo+DOsvs
	FDBQOVi4NfM9JsECnsj9ldv4sd5TMiR/0X1O0VbQvzpW+obbeW392c7/wMilP1G/
	iqgBNkdRNztlTsDPiBitCj9xa0BHoANIvbGxaq+Pv8JGHQFf9DjwBjX6vrEAbq+r
	MKTEkvofVPB/d09aXuCR1VCLqso3TMr6V4Yekhx7I4LyDY227h70bM1GK5PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775683731; x=1775770131; bh=xvCfT9tdmjndD5T/3ElOQ5ovtRK5arXRYiC
	TbdRdX3w=; b=sRsTgpqkPal9iXf+CGfbvVeO/R6JnL+S+hlCzTT2DnKoQpfjbJq
	Vnngp7OBVnyEAiLRqAVQ02eHNx3mBiBXtFWooq365PE87VZ5bU9cgoAa9EKgRcUY
	32Hei1INMduwvSmb+O0AZdqZ2HhQ0WrlUVtljCPfJ8oA9yHXz+hTByP01VcHoTxe
	9Cdp2nCY4JZBOz9qE06jKTrXV226Yl2vS16gUL5okAdTSp6atxztSAhNa93Mnr56
	/MkDOOXfmManWMJqa7PwRf9Sa6KJAVSD1iRXs63UKbyp4mZU1OokTmLAOkyG1AfB
	4N5dHcM6i9JaeaVbo40hetmNAOBVgz0Dk1Q==
X-ME-Sender: <xms:k8jWafOtJaZEi9XCgtPVs4TjiiLqjCuowJqqWyPsEQsTMIifGUWFKQ>
    <xme:k8jWaWhJIyakFAGn14yiy_z0W8QpLOlt_U9UJCmaWFt9tpsOWpvDOz2UTpVW0jjvu
    DoyVYWKnUGQk12S1yEfzyevkTOQf5dwYRTpjOEVif-hjOHC-MGeRIY>
X-ME-Received: <xmr:k8jWaSvqf0AOOYLViZdPFmwEr5mMkHTIj51SHFzWtHEROPeiknnZCxCuiZj0CkRcJLUUbe6NEmE_4vDwNBT0CiDU3nvhpHe8vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihtghhihhnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:k8jWaahX8rykttpxr3KuXXVaHuF_7mwan9GsUpD2VQ-npA04pEXKOQ>
    <xmx:k8jWaYYa7ghxVQoHKPb9lVH5xIq6Cp-spPZsGgiEmFVq3dOxiqcz_g>
    <xmx:k8jWaZYmwDm6skgLA-Ta4RLEk0RfYxG4-9KrsLw3rUO9BWs_ieXtjA>
    <xmx:k8jWadyag3MswoVGDC52pMOCZEQqGuElC26sACPnFtmw8985j24sdg>
    <xmx:k8jWaU-7MZ_U1B2DswWq75esaLjt7PvgWWcy8s4fyXYLbkhWr5FFDy0R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 17:28:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King
 <peff@peff.net>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v5 0/6] Xdiff cleanup part 3
In-Reply-To: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Wed, 08 Apr 2026 20:26:22
	+0000")
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 14:28:49 -0700
Message-ID: <xmqqh5plxhta.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes in v5:
>
>  * drop commit "xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for
>    clarity".
>  * add braces around the else clause
>
> I didn't see a better way to rewrite how action is used so I reverted to
> what it used to be.

Thanks, will replace.

Phillip's pw/xdiff-shrink-memory-consumption topic was built on the
previous iteration of this topic, so I took the liberty of rebasing
it on top.

Phillip, can you double check for mistakes when I push the result
out later today?  These two topics should appear near the tip of
'seen' next to each other.  Thanks.



