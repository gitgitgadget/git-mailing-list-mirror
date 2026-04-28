Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9F2224AF9
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340784; cv=none; b=gawgn1iLzfO+rt1x7o0D+BQ13+p44PVdXaQyFUUrztfUnIMg42gkC7kdjBpSjRZJD0AGDsogvxHgbq/sEF6ez7LcSRrnQIp/VMv/LnI5zrS6BAP4DSLAfxRo7tXdxL4pNQqHq2zO9CF1yh5MMxGAzII7WJ7iwpDe0WmRXHeXv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340784; c=relaxed/simple;
	bh=/m4mQtEAP8x3d08S3E6JkgL5/hYrWC+RMR+rrMRn0b8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YxvtmCAkhDJJCj9dBtrtX+YRJQETigRUF0ECa6bg5qDMzkC5DNK7P0JL35CdEszCV38S/Qc2zg3qPz5bxvcGek1zK72TWN+v2XL5N8kamuguhjPN69MHUh5Kur6FTHqKyQzEtixwYFgVfhUKPCPKM2RNc+qOVm/fQEcoVN4rutU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ifmOmRli; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R803ZhLj; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ifmOmRli";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R803ZhLj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E77431D00232;
	Mon, 27 Apr 2026 21:46:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 27 Apr 2026 21:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777340782; x=1777427182; bh=h7wIOj/RX9
	VCOVINfvY7Pku6NJhnI5wyL7YZCcFLeTQ=; b=ifmOmRli6/GbmOat4l7RzbZG2i
	NRY+HHINC8s0OF8KGWmsiDYJsCbZ+RL+0kPpO5W/1pqGhVibhy7QlKNLQ/yGBIxg
	U3lolRNxWVWrr4d7kvTp6duBd8xvSLUwp1+S1OeQZkt7eFRyFfY+uDSrDdZUvwvH
	arW9rp2XtiVmF2L9mU9W9z0BbbZsUPtPij6doaOgp85Jwz9Gtd9Zu/Yz7ezbLSvc
	cS5etFbAstWGySbQr0LyTb+00C5ZRX3uf6GOU1so1ehdZG++G0zkgxZFOtF86TpU
	UJG8DEGG4obZVE9eSv0rW2zlZmoogCXvnkG1XYzy568udClmgi7cPNnKEvDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777340782; x=1777427182; bh=h7wIOj/RX9VCOVINfvY7Pku6NJhnI5wyL7Y
	ZCcFLeTQ=; b=R803ZhLj98JoWGTEu5ag+32FcuIm3rWrxnQ5KB+An+aUsf+xTX3
	RZqHoS1HZyZwQ8a4/45pRBzOxCCS3JlM6RA+gCe1e5Va0qYF2rp+C7OsnkUuhe4C
	9TE0dZoZq+mXEeLq9C97jxwdeCEgTnPUlLAbGss3MfaNVLexG/0pKXWde+XSKcqV
	FZRylstl2vISUz+/1PF+vcX8fzWgHV13urOOuu262vsgaRzYIuD4e9Y4c54S7Kul
	bmOU54vLvmsmZi9eX20n+Tsom8G8i4CHj55FUXkKKHu20DvXOJLumeX1ek313wyX
	Yj9sAL4YpagIZeSN7KhIouqOFHIweX8p43g==
X-ME-Sender: <xms:bhHwaTatJbiFbaudPZX3NZLy6RFzF_cXyqW0bLduFF2A_qiLv-KB4g>
    <xme:bhHwaU8kJfZ5GbiX8ooc7nrZg0ow-L1Fd9-G8QvJZuozpHtP-Q3M9vMchg7zgQYhJ
    1MG4ubvb51CtIJZXIT9ifi_8nJAKlJF_9HEky8TZPCwH1vlKrZUUEY>
X-ME-Received: <xmr:bhHwaZlEYa7yT7xHKVUVKLTHAV7nUC3Y5Mz3nBFCB2NQ6VUWeBBBLFzLM84GKAiovnMDjkon_SgpTBqaiAPFgQDfBwQ7fC8LHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegtrghtsehmrghlohhnrdgu
    vghvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bhHwaZxgpJuQYw1-NOFbM_Oenog8hnfhuy-8FEnkdRn9xHFmi8hMSA>
    <xmx:bhHwaT56Gc2HbPVvlKs5YsE-Opxt3wgpmF6WtUvZK-NRvooPwFV0zg>
    <xmx:bhHwaZV2dr4Qf6uTv_e9_YWBnhMCvqfh2QxeWGNE0Y5pM4xjnUJYAg>
    <xmx:bhHwabJXXdc4HVA7BEEFySNUNlTnvcMq3ZqOkR0XIu_UObs_mFpsVQ>
    <xmx:bhHwaXn8QMum0p9QtFaM3Izz-JIX2qtBy6W6ol3d3X3_aPH2oE91QpFn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 21:46:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>
Subject: Re: [PATCH v4 1/2] revision.c: implement -b-reverse=before for walks
In-Reply-To: <ae-J4ooz2PJ8bZAq@exploit> (Mirko Faina's message of "Mon, 27 Apr
	2026 18:48:56 +0200")
References: <cover.1776984666.git.mroik@delayed.space>
	<cover.1777249165.git.mroik@delayed.space>
	<4864ac46dd8ef4b704c29efc96c45f4e1412373b.1777249165.git.mroik@delayed.space>
	<xmqq8qa852b5.fsf@gitster.g> <ae-J4ooz2PJ8bZAq@exploit>
X-Gnus-Delayed: Fri, 01 May 2026 09:45:07 +0900
Date: Tue, 28 Apr 2026 10:46:21 +0900
Message-ID: <xmqqjytr26xe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

>> It might be that the right way to look at this new feature is not that
>> "we are changing where reverse is applied", but "count limit is applied
>> much later than usual"
>
> maybe --max-count-later as in max count is being applied later than
> usual? (either way the users will still need to reach for the man pages
> for clarifications).

I very much more prefer what J6t suggested, which (if I am
understanding him correctly) would make

    git log --max-count-oldest=3 $options

conceptually run "git log" (without count limit but with other
options like --grep, --author, --since, etc. applied) without
showing anything until the last three commits remains, and then
shows these last three commits.

    git log --max-count-oldest=3 --reverse $options

would show these same last three commits, but in the order opposite
to the first one.
