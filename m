Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA2274641
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069059; cv=none; b=goFNiCxJ24d3qZXAk5/q33i/vXJQM8R7Vz4IQSTJZYc+fSv/2KFMIBupPpjKVtdIpMyc6IqcCM6/LVGTC5DKPk9VU3zmxN0lNjl4knGPZkhOKS89XbPfZ5YkUWtG+LEnKMbfGmkapLFf8SynP74oYlcl3uIT8uZLKuELsi6mLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069059; c=relaxed/simple;
	bh=KA5GezrrFLFjohq/VCrhvudOaK174mpmiIz1PzG6qf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o3y7CX2RigqCZTmmlTPAzARahcvfivlTQNj6FiHAdyAALpKW5nMDivRXgR9FTZsxP/EfkFVYGSWpk7dAKynF5XTkpyBsMD84rzU9PmSEKFeMtkIoBuXBsmkfqsS1pZZIOaB1BF+todvk7u8nd2vcqN1bj1vUQ9Frd+ENC75b6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZMjqVmoy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A2d3pb/I; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZMjqVmoy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A2d3pb/I"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EBEF1EC0596;
	Mon,  9 Mar 2026 11:10:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 11:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773069057; x=1773155457; bh=Dr1y3DYje4
	rTNMkbh0yohuVpwwutgVt6ONLJcdTbb6w=; b=ZMjqVmoyfspCnqc3mxH+aoIZ6O
	NzUsQbqWfBm9V6C050YbhyJtFPV+gkEZQheU3OsxyZTaYL9bsG8Csbv6RR2RnbXF
	y2FzSt+2VXfEYbwdRiwvoNFMyGXde3YFf6IOpP2+AJ1EVUXMsLGKSdCcA01guM1h
	zIVsCaot0H0kAMsCoo64e78DnMgL+RUYLSrGDYHTt0cIjAF9rNAMUIl4QYzoUphO
	ow9CgZkkBX6LXmU3wTQVvqQgYXKPT8+9yS+mCQAk/vOxXpwgIDadRjdJy7smSEIF
	4H+zGLZgkP+scM/eUMEKpLuqK0rsxcQX892fqbOTmxMHIfgTBFY5KxbclyIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773069057; x=1773155457; bh=Dr1y3DYje4rTNMkbh0yohuVpwwutgVt6ONL
	JcdTbb6w=; b=A2d3pb/I7e+Hspmt0W9PgG8Z/bg8ZHTeOUft8RQrnQEXgTt5EhE
	hKEs4NU1PkiZY+SM/blnPl00hHgp8IwyOIQJ+uTE6ica0xEW1oIMTt6YrPloF0m8
	6wlYpkHxbH2UHo4f8RtaQlKwWGY51Sf/Y3DRXK/QeHmxN9hBJ/pPso1KSiCdxH6i
	CbmHXK304nBKDpb/GmSB3SiFNOQWixsZVUpks/Xi+yTUXJgyWLS4TM7n4HNCP6sY
	BpfHTmE+tVc1ZmEdogsGOh6iVOSR3PsoSwnejAsue+ynXeNofMexKmJOy3H4b1kn
	PKfIJ8+LFzKt+4CLZIvZ8Bz0vEzwhL/BPBQ==
X-ME-Sender: <xms:AeOuaQM7KmbzbLN9xvzYxr6vpLK9pHejTWBL_rwVj5J4P5lqq2rK2A>
    <xme:AeOuad-S8tQowNomZcVDwiaKxap_E7nseYa2nKB8_EzbF6Ll2kyvgqNpYRIktBviy
    T98VFsMy5sW7JvCjK2UkY-ubqZI7fI041IreQlAXThTX1Zaf9jB1A>
X-ME-Received: <xmr:AeOuacTwutC3TeoIFlGkeKbubX5Yzq-o9ng56f75F_BIhYeJ8gFgq21SiTjV-IMjbRJ4ymRrI_G4orckHNOJzTHDF6aZi9X0fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AeOuaXmpuJmQ3RDEFDvibKKWFZu624PnhBP8YXwf7W3kh7j00Tpvww>
    <xmx:AeOuaUQUsDIEtGjXA_eU1kkbKzltBKSjYEHOLiLgmJkwrbzyYhBz1A>
    <xmx:AeOuadMGdLyPuPC6NKm3jIrjFI3rrCqlp-eEg5vK7ny_8mDyvv4Fdg>
    <xmx:AeOuaVWN90eitim0r427rTksG7Y9U3AKOwoyLILyHFiegffn5CYZ3A>
    <xmx:AeOuafwz5dTMYLqt8KqnqCl5wuIHX5mhcO2w7vKVa1h2nRGdO_OaP2Pn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 11:10:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH v31 0/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <20260309092052.79051-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Mon, 9 Mar 2026 10:20:52 +0100")
References: <xmqq5x7ba5jf.fsf@gitster.g>
	<20260309092052.79051-1-haraldnordgren@gmail.com>
Date: Mon, 09 Mar 2026 08:10:56 -0700
Message-ID: <xmqqwlzl598f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Thanks for all your help here! Is there anything you need from me now?

Thanks for all the work.  If you haven't heard any breakages from
others, and if you haven't found any breakages yourself, there is
nothing we need from you right at this moment.

The patch series is cooking in 'next' and unless people find
something glaringly wrong, will be merged down to 'master' later
(after which, people might still find something wrong in it, of
course---any breakages and regressions need to be handled no matter
anyway ;-).

