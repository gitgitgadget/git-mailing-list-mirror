Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83A1D5CD4
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886283; cv=none; b=YnHDM4f1CWNv0SMucLUCKBVEl1oSFohMOk0IRhOelCcbIJNzYE1ZkOGcGRdEpqzy8doPOdBcjsflNsv+66KC6lxNmA/oycMgT25yEskIYgoO8Jc+fNxEP1w73xMQI0Tu7XmckTC1HVWpbarllCLAI7VaIi+EtmcFeb5Aje5tqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886283; c=relaxed/simple;
	bh=a5KKk5jbQRcZICRJ2iULXUIEXC8mOg2cc0u0p3dtyMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t9Byc1Jgf4kZnmjytbIPyBntwwaW5Ugi0r3zxThRO1mOPt3ixiVfYdbpFoyGaDh2PQf1I/zgqKgZwoXK46imVc6v3LKxBW593zI254VYQD9NMevI5yKrqczPjisRdgC7pID3QwCn/BSVTDTBW1LZchHqO1BO9BQ5vNzQR70LzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rWuXTx1L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJ55AYlf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rWuXTx1L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJ55AYlf"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 736FA138315B;
	Thu, 13 Mar 2025 13:18:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 13 Mar 2025 13:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741886280; x=1741972680; bh=7DhuJLUcXo
	2LbhIUR3cRPYaP7wnT3SIdiRlMgNHW9r8=; b=rWuXTx1La6kTGfr+DqY81K21Zy
	IvD0ryA3831PjMGnN4O3hDddaa/YOKIpWtenw0OTWWgEoTWHZwd8tO2zmhSRoGGv
	tHcBLFjJbFkSBjb3nCHG51gahJEfW9B9t8mrIaKRni7M8I/pCRLdAE/vmHtfUmc/
	CbWucXLlL5T9l6xP+G8SxK1xwcR7cFU+Z9XtmXmqOmo6Y5YutEiCkAsIRB9cjOM2
	KXwK5lHm+HTwC5TOPS+EVAhZim/Py9xXwt8u8APVCQNQ7vHANzsBNQlh91jOZcAh
	b127D80SporwZn4whCbD5cXUtFpGXLfxMUNi0cIXMk98X7bHWmSGxbIE2W0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741886280; x=1741972680; bh=7DhuJLUcXo2LbhIUR3cRPYaP7wnT3SIdiRl
	MgNHW9r8=; b=GJ55AYlfgVxajr97aykCdJxZsePEeF+1EurNVV8WELJrEIDO13f
	/jlOkev3Vlz0sYWQS6thL7tiwUcebk5bbNUWuxfpwiFm4lNynRE4NpcptNTMLLoW
	mxy6O7yyBmG0uQNxackBCQ4HAhW7VoQ2zS1VYOhtD3mIlZbkO2I9lXegyK7nlxQO
	Y0ggVhkfsoFwVNn/GcbdVrUC08JsYqYBA6pBZd0f2avv92f6Mg0Am4z9wwVcLfIa
	3A32fvfohLqj63/wWfnIngh8g6Oqigc8703r1PHe5nMLHR/OqKlyxU/VFhaUx9iv
	tWcJ6UNFzNxr2UMYxv7WRFUhQP2z8H3DdlQ==
X-ME-Sender: <xms:RxPTZ_OArtEswyFxZuJV7FkPXrkkijO3aPOKddGSGmoA0zBznjzUVg>
    <xme:RxPTZ59VIfGtF8RHH1C10ZfM37X3pdsM1a4iCnXirNkQHGVRyleL4Sp_srKHxaPiB
    b4qBJoMray64IBTIQ>
X-ME-Received: <xmr:RxPTZ-SmEmaIeMAtAeaB-E5Sk6XRYVKLsuKQecdA8XwZt5wO1GstMgY0TCN5t7A4wVwFf9kT01xGU_ljQczJTLFE2RXHgdb5Ch3yx_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekheefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:RxPTZztT9Q5rX2_dEk0itaXyx47YtChqEnizzjFE3iI62VHxdbO8eA>
    <xmx:RxPTZ3c24-cao6BC9S6qO1DJRlfOzrMq4R4zjVw-ONrko-951ooNaw>
    <xmx:RxPTZ_22R8fE16PLzWl86o2uv2CdrykU60fIJxh61u_ToI9ahZb1LQ>
    <xmx:RxPTZz_JydGI6O19npWto4Xbr4TCddlPsDlI0KL5uo8hPVUl5nT5pg>
    <xmx:SBPTZ_QI2tOK5oNfRNMBnNDRiHH2o-Q56pnhK5OxYQnwsSHHXMbCiBEH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 13:17:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/6] pack-objects: freshen objects with multi-cruft
 packs
In-Reply-To: <Z9Hl+UpnEq07qFeW@nand.local> (Taylor Blau's message of "Wed, 12
	Mar 2025 15:52:25 -0400")
References: <cover.1740680964.git.me@ttaylorr.com>
	<cover.1741648467.git.me@ttaylorr.com> <xmqqr0332un3.fsf@gitster.g>
	<Z9GpQqm4YBvWF7Ff@nand.local> <xmqqfrjixfwe.fsf@gitster.g>
	<Z9Ha2mFXpojI+aIR@nand.local> <xmqqa59qxc9b.fsf@gitster.g>
	<Z9Hl+UpnEq07qFeW@nand.local>
Date: Thu, 13 Mar 2025 10:17:57 -0700
Message-ID: <xmqq1pv0q27u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Perhaps in the longer term, but I think for the reasons above that the
> existing behavior (plus the new patch from v3, which we should still
> queue) is sufficient.

The older iteration has a few loose ends <Z8l5hxNjEOALl_g-@pks.im>
we would want to tie.  Elijah's "decision to combine should be made
at half or below the max size to always make a progress" would also
makes sense.

Thanks.

