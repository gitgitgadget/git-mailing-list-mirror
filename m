Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D53315B998
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293052; cv=none; b=LS1F8TA7W8t5HROeaQE2mMy0V+8Xbwj16RXgQ8MRgEdEZof/jh90sHv21WQ2i+P3se6UAqYjIkcM/iwaRIRhEzCrTdylgkxncoXTSwYykQbJUzhkybEgkgVE/8EDaPT56qIokITp1ctKcFDnejAylJOzmImcKF97MyjUTF3/FxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293052; c=relaxed/simple;
	bh=Lfcy/4hWwDsxZmCxguQY8PnztsTYOSHI9MIA7t/t0kc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X036BJdquG4E7swqaT3qt9tN5b/7SbEhjONs7STz5+cKKKmq5u72T33fw2QnfX0gBVBdhhoWloajyDA1fptivm3FncuS41iqTLYswmSlAApvb9Cumd/Lm+mqdzfOOaNkexygNEWGYW4wf207ljF00g0nwxQW7LLcqjeI5s4DAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g1dcgb5f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oky+bn9E; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g1dcgb5f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oky+bn9E"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 972CD1D0011E;
	Mon, 27 Apr 2026 08:30:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 27 Apr 2026 08:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777293048; x=1777379448; bh=C2kZXWVXA4
	QA6FQJywhtGtHdWOOF9iWBJ88HCBUGEAM=; b=g1dcgb5fKJnEpCCWAjj8ovFeMW
	PWMOdjth2KAu/aG8FH0Ekv2hdQ6hDCH/UMOpAExFZCoTptH1ObDpmPY0/yH6L9WG
	8nJsdQbL1zj3fRHksAzpsD7kuQiX6O20R12VzB8toQs+Nai2BZRVgmAd4R6skqpT
	ljp51SAuiYVNcANDPRU8xDrNPFnaj7oOT60/p+jPD4cICn+NkUqobFd6Zwo+gt6o
	gTrxNbyYcTFohnToluIZQHotc6YAZD1Bd1wBiP9appSTQO+wU4LEbLq7EzIA7XJq
	WSNlMomU6fUhMdCkKmbAHMhfFxhYdW8U4Dhnvz36exGjiymR0oTMKC64V+hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777293048; x=1777379448; bh=C2kZXWVXA4QA6FQJywhtGtHdWOOF9iWBJ88
	HCBUGEAM=; b=Oky+bn9E3RlLXJ36nwgDG8I+wM8Ze0dhjNVI72uZjeagF1nLxru
	i06MAeGHPTVxyJSh2EGISA1o9YMKYNuQqtcQgWqB+Xm70XhkXCeDHyRFf0fmekUt
	/iNu8RX3WyQFA+JpT/nkBZsTfmQbfE+puHBTWf0RMd3/CYfgfhwznEwmJm7N5fDN
	sENbgYrTJJMPRBfkAQ5TFudXC9a9uj+vLB/AR6Jwopco/ctF1Ide8FvuJUtWv7vI
	FWeER2hGD6+WhNtxJqLiSb3ykWTehkifbm1rRJMhkWSlTejBhpQQWF31QkCWtdZw
	TidBkHIA/ATuCTIQnHpdYIzjwWDg8bunVIA==
X-ME-Sender: <xms:91bvaY6Rc7T5QHiklQXwxWGE_c_qWH8kVJoivaTcKnDpY84rviRc6g>
    <xme:91bvacdtli9-r6uhC8irFh02RISB2OO4H2lk33zXOFnu9QsK7w6f3A-FAExANX2pw
    E2ifXZMiGuvUqYP1iiU08XqbHGzGSqcpAltTuDjw6zecezjWaK1>
X-ME-Received: <xmr:91bvabFcP7askNVKmaKO_KXmsij1TreVjx4EcUFa1OQm7AurpoSH-BY3JSVbDkwsNBiOGHO0NK3hAV7Nl4xEGX2rrxImoynPPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheith
    eskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhnrdgrvh
    hilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:91bvadQy-oQT7Q5rCQjwzUbtdQ5NGkRJooKZ2WIxvnHsKlZD5YapIA>
    <xmx:91bvaRZMIp1c4Raf3NxPawEKHz3uWsmjhyur_p5CeGVStOBZlLY_Kg>
    <xmx:91bvaY3f3wFzmUoN8f_DVdfQ-xxXgblUHJwGmBZtxsb3eHdrsbVlUA>
    <xmx:91bvaUrZLRTeJh53tvqvuMpYZx3Nf_5o4KkeM7uXtaQXY824Py1cOA>
    <xmx:-FbvaWcCDybmZJY3aYLbS4lLbsqzfiF-sTKjzSe4x9V7S-oakeFEboCH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 08:30:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>,  Mirko Faina
 <mroik@delayed.space>
Subject: Re: [PATCH v4 1/2] revision.c: implement --reverse=before for walks
In-Reply-To: <971f19db-eb10-4c88-8d5d-3f4f7f92db73@kdbg.org> (Johannes Sixt's
	message of "Mon, 27 Apr 2026 09:33:59 +0200")
References: <cover.1776984666.git.mroik@delayed.space>
	<cover.1777249165.git.mroik@delayed.space>
	<4864ac46dd8ef4b704c29efc96c45f4e1412373b.1777249165.git.mroik@delayed.space>
	<xmqq8qa852b5.fsf@gitster.g>
	<971f19db-eb10-4c88-8d5d-3f4f7f92db73@kdbg.org>
Date: Mon, 27 Apr 2026 21:30:46 +0900
Message-ID: <xmqq1pg04mbt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

>> I wonder --reverse=oldest and --reverse=newest is easier to teach
>> and explain?  I dunno.

> What does it mean to "revert the oldest"? Or "the newest"?

I do not quite understand where the "revert" comes from, though.

> If at all,
> then this "newest" and "oldest" must be a restriction that applies to
> --max-count in some way. Perhaps we need a --max-count-oldest option,
> then --reverse does not have to be touched at all, because it is still
> applied only after the set of commits to show has been determined.

That makes two of us to suspect that this is more about --max-count
than --reverse.

cf. https://lore.kernel.org/git/xmqqv7dlr4yz.fsf@gitster.g/

"git log --max-count-oldest=3" will give us three oldest commit in
reverse chronological order, the set of commits shown are the same
with or without "--reverse", which makes tons of sense.
