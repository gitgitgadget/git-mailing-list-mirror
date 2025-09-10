Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84713A265
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540468; cv=none; b=Bu7/ckFuqXMBzY2AMjvxyWhV+/HefIj+oHci2kXIhWHQN/VVomxCNnHvaBz4nXpU7kbCxzbxWQu7vRIcG/wz1+3mLr+Ayq2PgijKqx8OF9koGsP/GBVQk5PqMXa99mW32wJdSXV3vhOiglqIDjKfeCqzc9YtH/vkKH97ooKTJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540468; c=relaxed/simple;
	bh=7RanlX8Q6ltE/bCRs2JcZq+EtOhgXpkNlxKORV+hbRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VgJ2RDviWOovex/4oSPFcZiKwRCFgqCI9IyZ7nJ3H7l7TeEXmcLemPx3A+ID/CPAa2Y+cR+41qYUYtzGxthVIsrFz2BBzLu5xxSDFOCOSi721TS7pU+ipGSKc3+QjXj5BFtBbc9142FJ8gAkUP9cBmXP4wFtVkb2p2eQ1nu/SP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FnYVy4Af; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DSWhL8nn; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FnYVy4Af";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DSWhL8nn"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 62CC8EC0315;
	Wed, 10 Sep 2025 17:41:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 10 Sep 2025 17:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757540461; x=1757626861; bh=vwRFgAzzcV
	bX2lR07ydDvcyhuxP/oVQOpmny6lnym0E=; b=FnYVy4Afb9XQqSvyNiLvqSQL+I
	HHa6POYadyeXoTsyjl1ioixFII/H01qdcG09kTuRjcfDwLom8oxa4wDltpGNh12C
	v035qh2/ajU78ywHxwOaDHjkKI0q1EToD2kJACKBo7kt58M92e95AyCP67qWLbtT
	rY9nF52WA2HapD5Q9fpnXZjjc3sDFXUIpUi3W4Y5H+ZwUrWpoTyt2t9Wd42DuUAh
	CK6iu5jVRbm3xOd6UItPPFKpHVs9TB2u5Zijs7Hjoy+ktIrSNCqtRDzzoOye5qDV
	inmpdj3qQblKc3cctBbhj5nrKFIv7yR6eE/m4kCAbGx4SfJe2g2vG8xnGhSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757540461; x=1757626861; bh=vwRFgAzzcVbX2lR07ydDvcyhuxP/oVQOpmn
	y6lnym0E=; b=DSWhL8nnaRZcKyEKHvu1AnXjeVaaVRzMKLBEtDsGOWHhDuVREvh
	5vtqMlSIbooIDJn0SLx41KTBek8B2iItDuF4CsNP5XRlLQLh9D12n9tedCBM+OkJ
	WeFimyN62qvxarxMl3ecRQhU0NAKKWy5TKpXoBjnr5KEpzCLRwekl0K7YK0B0U1U
	mAZ5f+Gy5SJLO90kn4iWE684jdEXifEPPYa1wn4TxiqhZXVv0QjXGLAo17/IMvH5
	6bjznF9AdYKUSGpFvycfPMS6RMGqQKPsQqz/kLokHo4OQVMdcS9pflmQrv0OE6CM
	JVklKv9jM9tqmuCsjB4k1LUUxh/vskKmCtA==
X-ME-Sender: <xms:bfDBaDTqdMNhyEAqYJHo7B2ATjc_7dSlH_zTUs0G1x7SnaQsjKkIbA>
    <xme:bfDBaCVMZi7X3pEcCbhz_f4st3Hq0CdAdbGVi-kgUnz5zccVrwG2zUwy8oOtrk113
    Yt4E9UjJ0QmaxVMNQ>
X-ME-Received: <xmr:bfDBaPQXw4A6cdsyDR1zNHuXbs_-xJSvdkUtjJpdv8D_hT_9ZrCR-VEQyUgMtM2qDCEugnbGW23Hl82KMz6MSWAtxHKTDVnsX_OLw34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bfDBaEk_Ow_5C4GDhBSqsfVFvC9UIwR02qUpwVusH1i6Z_FCmqDxCg>
    <xmx:bfDBaN7nrq49xvK-k4P-a5IfrCMB8BgWCDQnvcz0VkddIOvYaRnbdQ>
    <xmx:bfDBaCiJTD2bYfUYalfem3ehcrVNqofNsk-9FO3RPpOP8GNtu-OOqA>
    <xmx:bfDBaCFRGYzk1tBkParolCyVl30N2mQ0pKbTb8Sl_FYo4jxiZI8XNA>
    <xmx:bfDBaFj1MOJcBKEXGHBIZzuByHQRq42zTdf0AaZincKYAfvUfw82qEXk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 17:41:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/7] git: add `deprecated` category to --list-cmds
In-Reply-To: <20250910155001.GA1134782@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 10 Sep 2025 11:50:01 -0400")
References: <cover.1757345711.git.code@khaugsbakk.name>
	<cover.1757446619.git.code@khaugsbakk.name>
	<66e6a9554b16b2079e5613a415a2d27a601d146b.1757446619.git.code@khaugsbakk.name>
	<xmqqjz27ti6i.fsf@gitster.g>
	<20250910155001.GA1134782@coredump.intra.peff.net>
Date: Wed, 10 Sep 2025 14:40:59 -0700
Message-ID: <xmqqzfb2ouj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Sep 09, 2025 at 02:44:21PM -0700, Junio C Hamano wrote:
>
>> Will replace.  I guess we can mark this round as ready for 'next'?
>
> There's a small leak issue in patch 2. It should be a small fix, but
> worth doing as it is caught in CI.
>
> -Peff

Thanks for being careful, as always.  Very much appreciated.
