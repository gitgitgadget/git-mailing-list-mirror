Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352320459A
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751929129; cv=none; b=kJUQPKjHfGYoRpYf1H3ryfkiIZAtseHCEPQBp21duU8vEeE8QF7N3i3r/cK/NckxGAO+o+7HfDcKEAgVyHQYwt08MxzHqTYf2EGA6mlM2nbYxxvLprA10yWHyK3Qa9dHBEzdqPOEXUPJKLmOVfDdXyRqdeRd6MKbt3pIpF40MJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751929129; c=relaxed/simple;
	bh=Cv7SDQesAfVzb18DxZzJYEXPSJjO4+EtYdxs/F80bUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kjM0U97jtK3jfE6uOfS7Ga8qUINWofn0I+8KKM5tJUgfKubwwJh3fL71wNG999SdhvcvmOQA+i2bqUTe00p+bkIC/BRdyf4c60TlGxulvCuFdUl7OEEKBH8+ubhK/FlunbmpeR5lgmcQ+f68hMmYUJCGrW0PR/cmTjYzrNuA9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hC+gsk5f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jwro63BE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hC+gsk5f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jwro63BE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DC361400A30;
	Mon,  7 Jul 2025 18:58:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 07 Jul 2025 18:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751929126; x=1752015526; bh=xdft7PqIAg
	lS0HYwT3/b5X9qxoWbrTgAH6d/+5vTANA=; b=hC+gsk5fd6BvRz2XhPp5ZK+3g5
	DFlSlPJCiOdVH+4wVWVTamTa87l++3wM3g9AKrOKNW/X1H6XYe++1fFaeUjru2kJ
	jVBzx9Bmw1pF0Its9dB/+NnF1Q/XDZiSK+YYxCsl5x05mEVtg87TXnjhHiOY5bcC
	8/HoMTGvexNq8+Ofj4nf3UfZxTL2yxR8Mtionl7WwGAPJwjLoSqi/5oWCHjqGLaG
	n3q0NTdLiA1bNlIbj+UkVr7NKfkeqXXlLpeG9OV1l1/dAluKPI8TA3LYGJV+Cvhu
	xzZaIFJr0Htq/4epQ6iXq1TRxkpWSiwUnnpu3Cpx6wNmCcYMXqpYp2dWWpjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751929126; x=1752015526; bh=xdft7PqIAglS0HYwT3/b5X9qxoWbrTgAH6d
	/+5vTANA=; b=Jwro63BEWUekCHu43dc1rvKeSVwWIxW/FoqBThPB9iBVCv4TqcB
	KmB6Vc43rmXqzxdYlQ1LHZiCLod5onnzcTs3Fmu9uC+Gq8nqihW7BOsV8m0lL6C9
	gtSkN6no3zBlI4hoi/Qf5cZ5BkSQhSYMdByHr49sOfxgMOPoiXB6ijt/3GwrE1PI
	IwOg0l9kF6/q2L+D3FYEoDQObA0I0I1bJ1gv0ZIOKxvpRd7pr0eZDWOSTrxTC4C3
	DcQwbDADycNq0jIOEIUC4HeaQO6K4kmXNWhIr5KawP1gbw7OXxZgdJKyNYb2rql6
	HXj99sRYD3MjejapOPmEttA4F5znpNd9bNQ==
X-ME-Sender: <xms:JlFsaG1kueLqMd5TMhIcgDv6sJUwCuwkdUC9qoUC2Kid36TEIyKqCw>
    <xme:JlFsaF-Fw7pU3jfot67G-ECuLyIOCebE6s_ydeFMzp6e5BaVf9YyvjdErs8fDBbG8
    OTJXCIYIZ0c7xrXMQ>
X-ME-Received: <xmr:JlFsaOrYM5K0Pd-dM05j5Ud4Ddyt2OeRpqKXIW5fy5N4ptZ-ZQslJSBZaO91tLHA2CQ4uBniadQj5k_EDiGjr9dRG-TPk3vlaABJHNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JlFsaHTHLTpWLRV7ogAQRWO0byLNMv-BLuK9mlsE1nfEZp5OYuqvHA>
    <xmx:JlFsaJPaQW_6FFA1bRyf_CzEhvGad20FXhWALMPdEokirnByYrK3Ww>
    <xmx:JlFsaNge9Us79WqOB_MoYHvgnTSEX5vN8gpeSC2m8_WC3FAL2azfOQ>
    <xmx:JlFsaOkYAMgj2paMYgj3fpw1MpTtJMIUh8pVczwnXIHksZaitzuuYw>
    <xmx:JlFsaHCxTQ4pDanW-5ok1tJlHnPnekjTVPdKfiLuLGZtjXbReNjNu-ha>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 18:58:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
In-Reply-To: <20250619133630.727274-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 19 Jun 2025 15:36:30 +0200")
References: <20250618151821.528627-1-christian.couder@gmail.com>
	<20250619133630.727274-1-christian.couder@gmail.com>
Date: Mon, 07 Jul 2025 15:58:44 -0700
Message-ID: <xmqqbjpv1ucb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> This v4 is just about fixing a few bugs in the tests using the SHA-256
> object format compared to the v3. (I had issues with CI tests on v3,
> so I sent it without waiting for the results.)

We haven't heard much after a few comments were posted on this
latest round, since Elijah's
<20250619133630.727274-1-christian.couder@gmail.com>; I understand
that it would be the author's turn to respond (the response does not
necessarily have to be with an updated iteration).  If so, let me
mark the topic as Stalled in the draft of the latest issue of the
"What's cooking" report.

Thanks.
