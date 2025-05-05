Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F13255E37
	for <git@vger.kernel.org>; Mon,  5 May 2025 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479944; cv=none; b=ccVSVIaLaPgw0VQeoLr7s1VGms/mCrIKFU0ZZaoZDTzBGB+AEJ9WFaATlRUcj54hWINl8BjRD3eoXfDPNiCaRpg4JM9cLtv/qeBWdcDJFluolpzoraYDuin+rf2HOo3SmGE0mSz4fj9vS+GZBrzdSZ0nWlAkhT8Vf4Zbg34diKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479944; c=relaxed/simple;
	bh=Aijt4DKJDsVrtqZFWo7gqOF8uYcKVLHzm0d9lwjFw9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b6qDRGBwOcjVSstr1O8SUabGRiNOh9f2rlHebpqjazdoZm6tHMBX3/UgcaC9THOnTLKiuaDSC0h3CvCgcwyuWXI28ypcTbksX7PIyAfkfzOgDY0k6kMthoAXoccxGcmiUa5QTA5jD4p+RrK6AvNZRVyrePCuxPT48Utcqay/DfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gfayN+43; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lM6U+SNp; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gfayN+43";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lM6U+SNp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 11505114019B;
	Mon,  5 May 2025 17:19:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 17:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746479941; x=1746566341; bh=ijvvNvmM7n
	PPnJ4glNf2jq5C2AjMt6DkZGRGRclz7Ew=; b=gfayN+43SaJsh6AbL4KP2a20M6
	YVu4sE8HI1iFzehvy/LesKEMn8h3RYp3Ryif0I72IKMabF1YmqGUS5HeO/ayI+rw
	5QTd9Bnhih368G4Qug3D1f0q5w5nBLFLctrqLHCTznZeQ3Fr5OjTPdGsY6esn3wS
	4CAFK/PifyH+aP0KXamt1YFbNAxIRKO7/csyh6V0T/s4G9TLqvOX3C6xlqFYG2q5
	Gt57LFuk7kEQBoFRTCCIqsgomwxfA3AAIiLJK4KyzDRb8flFx7j9FU3T2Azwv50P
	d5jOOu7z9LfEkZbaWcC3QkiovhwNaJ/tFq6ccKeLy/Y7P5CMcbIFn+aDBM9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746479941; x=1746566341; bh=ijvvNvmM7nPPnJ4glNf2jq5C2AjMt6DkZGR
	GRclz7Ew=; b=lM6U+SNp8ZdD0NrL5qbfqW9OSfzTl7PexraMPx4VSKSd8uLv+9n
	/SZOSJsh3ZI7PH9HgwlfY5l7iJWsnLREnsqXC2MsQK5HuQV0giRaXe1qQKfaonqr
	3qzPn4uZ9qI3tkS40OlSL6jjBu3LK9svmAeh/d8Dq7qJBhelEDJ6u+97QasOQwBu
	tdJdtgcFgYAEUVZTH1vJTV9ZckOE5z8gowoieZ/yYb8hL0Gh8Zu625iQ5NQARNuV
	5NnFP4pJkSK7RshyWhgl1y2AyI8p9cYW3eM1TESKZRZPgv4fxAT+kST2I04BEz3O
	BJpxJKWjKpLlK97b1HBBZyiXCK2v8NlO4Ww==
X-ME-Sender: <xms:RSsZaJlbKEu3v6DmfBhf3A3GOihINhGPTILRjlYIvDUplmxqZlHNMg>
    <xme:RSsZaE2SfKkvrm3X0nwObBM11MPFf50nbkAlnU44vp7pHetU3T6zR7yaUCOqdBiYO
    02ZLr-N3pRkP0WbNg>
X-ME-Received: <xmr:RSsZaPrQ17FJE4rsO9frk8BHwy35XcNQoVN5kp7gRNtmPB6sdwXLIpQUuV5HwL3F7E6w8vzRojgdTQlem1QL-6Ni1nmM52zdP5NC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RSsZaJkCAFYOYb97pZIIwohtOI1xhrqDrULvM3mD6UxExQ2koSflsA>
    <xmx:RSsZaH1Vpu9AjTVsEKlyplVcf8iCKynEkAcUMInkwarMZPi0t74X7g>
    <xmx:RSsZaItQwzD-UQPCsYOw-Uq5sOaEueGIalMBNXlzwJQQG-xhYbJ7Vg>
    <xmx:RSsZaLW-R3rv5Q7oOPZgwFR4e2nj2wgL35zO4tVpnm2X4CAvzL57DQ>
    <xmx:RSsZaIr6M6GdQlA6-YYnOm4TEOby0IWRR8gWmWTbA2piOQCi7tKXkeEZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 17:19:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] ci: fix aggregation of test results with Meson
In-Reply-To: <b98d128e-0c16-aa50-e5d5-1717a611b7f6@gmx.de> (Johannes
	Schindelin's message of "Mon, 5 May 2025 16:00:07 +0200 (CEST)")
References: <20250505-b4-pks-meson-aggregate-results-v1-1-f38899a0a2cc@pks.im>
	<b98d128e-0c16-aa50-e5d5-1717a611b7f6@gmx.de>
Date: Mon, 05 May 2025 14:19:00 -0700
Message-ID: <xmqq34dioiwr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Johannes reported to me off-list that aggregation of test results
>> doesn't work on GitHub Workflow when using Meson, as can be seen e.g. in
>> [1].
>> ...
>> 
>> Thanks!
>
> Thank _you_!
> Johannes

Thank both of you ;-)
