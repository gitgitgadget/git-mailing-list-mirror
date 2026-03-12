Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3373750A1
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773279538; cv=none; b=QZEwkyySrv6KwhIaHw8zJGwKsuGxrK3wvzyKFwmUoYAtbEnlnMwl9j1yKEAsTYeLotBfVxIf7ESKCVMEz6hjzVBhAljDQKP5zbX5iW0gJHclG4GSB1h50wxfMr7rN64T0BqibzOIxiOPditFvtOLMLFw7jkhJGq6MUNuWzjLTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773279538; c=relaxed/simple;
	bh=MRaR4ybDF0lgVtRoO93XqvLyr7LrM9GkhAacNGIhwqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sd4lMQREpjL1sOMA9nAx6/ESF1TCO+IKRGOMEmD91gd5C4iXAS0/PRyyZr3Hyc46m//cne/uQR3i7eH7UDw13pKa32HBOZJsBz0smloyjY8v23TaTfJMsB27cRLIywZXVTziVlHKN57LnU5cuzVHTZBK1F+kuPD+4DXd39DEMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ke0MLAqK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lwnSI2cu; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ke0MLAqK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lwnSI2cu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E94D7A01F3;
	Wed, 11 Mar 2026 21:38:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 11 Mar 2026 21:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773279533; x=1773365933; bh=+QF6B9ODVp
	eZqMNkPD57+mFOVu6A1JzRpPmpcGZU7Do=; b=ke0MLAqKBY73Hjdggxnc+HBFh5
	vq+G/lWBpv7pEzY5+70BJJrm556FBS+mDDq739qHnYokHxRcSeDbZgxbHZQNPbFy
	/RA6Ln9ffS0EFOHisctDgIWAJubMUE84KriEscyYkWticpI/EDnY9tFGsj0am1t0
	MVonbchtD9pMIzvBMjJfdvMH1c35v0wW8MISUihS9jf6Q/igUs2ZA2C4OoFDLwlO
	Gs9FzFpl+h401R13oZ44xyUlByzNwCii3Hg7u8MnNC5kAP7wopfIL2C3PSUA54nt
	f862diywiI2y2Xb617ldhOTlGyt5xIB2Cwcfzg1M2WmwwfszMVj2eBGUKoUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773279533; x=1773365933; bh=+QF6B9ODVpeZqMNkPD57+mFOVu6A1JzRpPm
	pcGZU7Do=; b=lwnSI2cuiNIzF0IQpDhOVBTQJjXgadO3g4GEBtkFFS9nsgJCxmb
	ETH02pxCyz5Pj3DxLlyusQDIOS7Yn7zvrsNUXGJwSQokOCB8uWq5EyVzako8LDpc
	S9Z/b1vHzX9nSqbvaYZYIth+smfdOQEeBGzGrihI5HkKDtxpDLFCTuLKqBybcvYO
	2l2YKTICaSIilzuzbSaFsN+WQZskpP90t8wQgKynI8NGdRdoN5RvNvsi2xhjhFje
	+Y4jNZ0IBP+LCULvSMwyCd0GvClG+R9a6scJvknk9snyR5xFkJe07ZrkAgivuEVg
	G+QnCwwiIgbZ/QxVfdcwe+B/68RAvs5aroA==
X-ME-Sender: <xms:LRmyafrmWD36YcNEHBYfVldh5v_i6jiaCXU4EdVLYuBv3jMzq2WXGA>
    <xme:LRmyaQjbA9QfoDVz1ILAYp-Y9_QUNlRZkbS9vp_lLZEixlf5f7GDA_a_AmkQ3Js_L
    F7Ex4pBqtpy67oucsCzXStztlLFjLxW6hyblxLHyDNNcr77C5Uq>
X-ME-Received: <xmr:LRmyaUgF4DpyDND195rN1Jb6gjLFLo2JvXOWQmku3GZPsYljjgT8XiMeoNHUxZ_U9Ja4ExRVRkR-6N5NbbUQIXwFHrICm6judw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtph
    htthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LRmyaegZIiqQIdQUwtWQzLubnb7CeuaMERFVSlKWnbkY-1Erf3q2Fg>
    <xmx:LRmyacI0wdoRHdeOeYoQcUh5ZO7_C6eaF33M7SOev0v46K750CVDZA>
    <xmx:LRmyaVEcfpzXaT-nR8CI__hrNH10b8yEUW3gCgltl0Wf9REx_a_KBw>
    <xmx:LRmyaYQcCJ4V4Quy3S6cUVBEqXTiVpipTDFomPfzL1JI8OhhJaTwPQ>
    <xmx:LRmyaeuHB9Yxr40VJ_9zgk404XYyUZPBKmlmihbn65e00jharFRhr6at>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 21:38:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 1/3] doc: interpret-trailers: convert to synopsis style
In-Reply-To: <doc_interpret-tr_synopsis.48b@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Wed, 11 Mar 2026
	23:31:04 +0100")
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
	<doc_interpret-tr_synopsis.48b@msgid.xyz>
Date: Wed, 11 Mar 2026 18:38:51 -0700
Message-ID: <xmqq8qbxkes4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> ...s. The only thing is that `": "` is
> used instead of `': '` ...

The description says that a pair of dqs inside `verbatim` replaces a
pair of sqs inside `verbatim` in the original.

Does this refer to this change?

> -This means that the trimmed <key> and <value> will be separated by
> -`': '` (one colon followed by one space).
> +This means that the trimmed _<key>_ and _<value>_ will be separated by
> +": " (one colon followed by one space).

We seem to have lost the `backticks` around the thing.  Intended?
Does the thing still typeset as verbatim in the manpages?

Thanks.
