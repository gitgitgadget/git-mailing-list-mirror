Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E027468
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436142; cv=none; b=BE+6ixxap2jBTKeA/+421uJzuQTxwM/RWB1+dRqIzXd4deWemoHf0VohyZl5bhGvS7ogsh7MIDJBIast7H954kaw48zm+fwfrgh1qOgMz5zYoBbvsNcYVcqka1CE/bAbxq/R3B79LWEi2MLdYSFZF2BzO0A7E7BGByAfUrWFq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436142; c=relaxed/simple;
	bh=85AH0m0W4WN2IXSFcot1H5Fape6P8a1Vi3awj1mXads=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noqrMmuvwnlxhPczdLvr2jfuE2BdtvIAF9ISg9H1QG8FCYGeNqxfvJNZ6o1gGI8N7gRnYSietX1cJvQmdCwDbwsUqryhfCKKB9Jg0sis6oHm6g2jNMhbEBDsbLjf5KXre7NMF9Ko3oZa3Js+GBcDV+UTGddxNWbRfq2B2qpqWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fpAiKrCy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PENGewzF; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fpAiKrCy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PENGewzF"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C11325401DD;
	Mon, 31 Mar 2025 11:48:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Mon, 31 Mar 2025 11:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743436138; x=1743522538; bh=0ZXTqzJW6L
	rlHbASRfaR4kTnlcxWPjBywyXULCZkYjQ=; b=fpAiKrCy/F9owxDpplvAUqGNkr
	6hZSOYodZfA4DVToqFUw2qTjrCff89abcQ1zijWgUyYxmbOE+E+Wh/23vEJYC2t9
	UHvyDdLQ0H1qhn2BmFlmaC+84V+StKJTi7WuqRfojUyg6luNFNVStVRVXmAeEL2E
	qBSae/5OQEPIFP+RGGTvAOws549/UqSDWOK4B2foCrdMW/OuWnjcGt4IvjYT1FoQ
	eEDmfuTcxv9lHYc5QHTstaKmSdttmJDeuD5eiEILCB0maxHjPxzUCnTBjqCVzv5U
	XoWwa/dL2PY1tquFPO2OzGFdPzJqBDmzXZGy9Gl4lrqA2Nh+Ot52KrxoEwDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743436138; x=1743522538; bh=0ZXTqzJW6LrlHbASRfaR4kTnlcxWPjBywyX
	ULCZkYjQ=; b=PENGewzFWipQtt9z0TDB74PEQo6JJTpaPqxEmygITFZ53G89/MQ
	7pGQERQWnknjj+sudUXP23cd1kAFa164vIPc8iSbdmIAOexSq4/O2H0fTJQhbaeD
	3MEtVxkLK+J4sQKsacemRFf8S/J+oCWqrRK51ueepWU1YBEtUFQv7XgKaOoeQ+7S
	dxTmzAR+CzowP9rAelfgfbwhf50sRhr5Gakp7zJcvntlo0ZyD8grrDCff20wrMos
	i1t0NjHTM87BKrSJT/NSh0g+6F6Zh/gzxU3Gsa4kkzGJxbIUz9eA/QJ+HzhgOMry
	Hw/JTYtmqHW98vHDLdH5YIiqNjFEzu/JXkw==
X-ME-Sender: <xms:arnqZ2utB1fNsY_LUiKbTMElvGPmplpMtg0IpWj2tCP4WPljhO1CmA>
    <xme:arnqZ7cUreTaP-_Z7Bj0StjkEJZ8icFCPGmfkAamr5b0y9vF94MPG7J8tthbAlk-R
    GJcCwW30DUxjOTlcQ>
X-ME-Received: <xmr:arnqZxyUYqAT7ZqLXBS7YbEzt8DFvm8DFCQYEA-HSzorokdD1-xes8YVr2OFh6eGMoBROZMIwzJsPq9FBZ0z8S8bUbRzvX2WXhFSGqFPda4WHLe874BY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedtfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceothhmiiesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepgeeuveeiffdufeffgeevtefgvdduteffveefffej
    ieehtedvveffhedvfeekgeeknecuffhomhgrihhnpehfvgguohhrrghprhhojhgvtghtrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    thhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehglhgruhgsihht
    iiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:arnqZxOkvfHMNnMNop9LTnz3eOkVb7LIU4phRzniP2h8lh_fC98uXA>
    <xmx:arnqZ2-y70YvT7B4eC3tpZMJYbNcQOA5hGF9JN1Ufuk3VNMqjkMTKA>
    <xmx:arnqZ5VPmc8dzZ4NempC5C5oRWxCAJNsPQAPquSH28Rj_fYukKDSRw>
    <xmx:arnqZ_dRwCdD5AJi9cUiKMMvkxSoJ2tt7u8tZUAGzTfuxZsls9ciUQ>
    <xmx:arnqZ6aIVynhJaVvGrQIyy2GhAt9hmZo-B9epZBqXgHkIk1oUkoAyqDY>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 11:48:57 -0400 (EDT)
Date: Mon, 31 Mar 2025 11:48:56 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <Z-q5aOIahoUKSyBi@teonanacatl.net>
References: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
 <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
 <Z-Zr7BZL1UGqVxKu@pks.im>
 <4276c8d0b72f11f325482756d3bc251327d0ac47.camel@physik.fu-berlin.de>
 <Z-atRMGXHilZRTEL@teonanacatl.net>
 <Z-bCNdOOLrM2Chb8@teonanacatl.net>
 <Z-qKGqpbdaW9WCrP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-qKGqpbdaW9WCrP@pks.im>

[cc: fixed Derrick's address]

Hi Patrick,

Patrick Steinhardt wrote:
> Thanks for the additional information!

Thank you for looking into it and providing a patch!

> One thing I stumbled over: the `--min-batch-size` parameter is parsed
> using `OPT_INTEGER()`, which expects the value pointer to point to an
> integer. But we pass `struct backfill_context::min_batch_size`, which is
> of type `size_t`. Maybe that's causing us to end up with an invalid
> value?
> 
> Could you please check whether the below diff fixes the issue for you?
> If so I can turn it into a proper patch.

It does indeed lead to a successful test run:

t5620-backfill.sh ..................................
ok 1 - setup repo for object creation
ok 2 - setup bare clone for server
ok 3 - do partial clone 1, backfill gets all objects
ok 4 - do partial clone 2, backfill min batch size
ok 5 - backfill --sparse without sparse-checkout fails
ok 6 - backfill --sparse
ok 7 - backfill --sparse without cone mode (positive)
ok 8 - backfill --sparse without cone mode (negative)
ok 9 - create a partial clone over HTTP
ok 10 - backfilling over HTTP succeeds
# passed all 10 test(s)
1..10

Source: https://kojipkgs.fedoraproject.org//work/tasks/3947/130943947/build.log

I tested it against the other common architectures the
Fedora build system provides as well, to be sure no others
regressed, although there aren't as many as the Debian build
system :).

-- 
Todd
