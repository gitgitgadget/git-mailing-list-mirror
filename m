Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEB1EDA2B
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636855; cv=none; b=S/Rkmje2p6nhaQ5SSofaO7hG37rtvSpOgOgtu89O3vuO6lRL6E9DjbMZeMtg4IBsKEfEIuDPi86PyuU1d2ov+1MD8BHbwGaq7vhmekN5WidtWZ5ppYGzbxYZJag4dO75XfOtE2b74ywJOAyuZfUExi2BVNCd98hET9QF12pt42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636855; c=relaxed/simple;
	bh=ITo4cVeQ6jo+dYTS4QmJgmGZdbnVAAJQL2QpcUemasU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rkuGbjvLxpY0pelyAX0XX6Jv6pjJGZFLok9ZfAlNqAslad2Frrpy1YAaHczbfE8S9KweoTISti95Da7bqvYuWhgwIgJ73DRxZDPnKO6cP4rc0LavV2QkdgwCUvtdLbF8s1fLG6hXkybeEs6R857Kmi3Tznf/mQHRMhscEhlz2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BWjae8Dx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YERmYMIO; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BWjae8Dx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YERmYMIO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0678A7A009F;
	Thu, 16 Oct 2025 13:47:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 16 Oct 2025 13:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760636852; x=1760723252; bh=8vGbmpZ0xG
	9rjAE5ucLxeheIBXpSAL20et9zAj+F4k8=; b=BWjae8DxLdbJayw39hpgEi4zWy
	/5iSsy5iQb0oTp8jec2BUoBJtf+FPR7PHZ5OugA50hV9XwdnazmWFabn6EuAB4Ue
	sy5GHeVSKQUtN+0+U+dpxD3vgZ0mcrp1UtRihVu+NWOqzfbK3KHpwKEw9Wt2J/VO
	Y3dlkhEY96As8KaaN461dGwG/CGUSpefy3JDadC6yJKnj0SNGMDvM9OFO709neHm
	cHMOmfWx23i6vTbqtTOMH9qf3wGl14W5GSy1WTiH8B6qJChrUBtezW/drf5hWHrS
	JZ+JQUigVUBdDpQY4usMUkwhZ9h5WDuJxx0PqLVqXbgDyZ4ey04EnyMsVWmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760636852; x=1760723252; bh=8vGbmpZ0xG9rjAE5ucLxeheIBXpSAL20et9
	zAj+F4k8=; b=YERmYMIOQkUd1Z4wqBPlLmJw+syHMqkjtikusW1082V4oGg7K8F
	6C9biAmW+qQeKFyc4guLMi/BjVe4IxUiuX3eAbgBu5egLlXwiA0GCUwI239uf8B4
	yBhx25QhNp768n1CQD/r1xiZHWLtQTTTRof1rlZlDfwoRK1XqWUM+fHvpVY8XChD
	4KD81eSS+ZWAzEldgHGvSyS4JaIAXfrnUe9KZiRY4YJAj72BXHIqANrZasPQw2JS
	yAJao03fliBnRdD7s6Vurb3nLk/3BpcLtUtwiWRDX7FAI8mZLBB1Wp1MIuHktbOr
	x2TRm7UlywvW+vOQfdGCvlhO9XUD++x4pMQ==
X-ME-Sender: <xms:tC_xaAtucnT02sEAP8P9xmOZsaiJEGhSos1TTpmiaxLICy_d3iK0SA>
    <xme:tC_xaEd96cKqnveDqLW37MiDGMxpDbneDrhFCdWHligMo9q-ljPElfo-ZljwmBdoQ
    zUlqZS42k-tvIw6JkUUGqP8IIF7gxXE1aJnfdDPtPSQ6tSu34nhSw>
X-ME-Received: <xmr:tC_xaAwvVkFis2jZtvsaOsBQtHfxF3xdddFvltTZdIyBodSrwbQ75QMiYhgnbb3NDOzQmm2_G_LrX-vMS4VwI0rWCKsQzIxb6gDl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeileefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tC_xaCHeJuAjGz8vogQIneu-BLGmWpTSgI21HfIaZvZlmfQ8QKcbMg>
    <xmx:tC_xaMxvy23LXoVrm7HW3e2J8OfDYprmoGK9jPFZy2q4HgW4-vGJ3g>
    <xmx:tC_xaLsvtszlRtRE7ehos6G368Fq8Ho7SEjkGdxO3H1NlLHkTAe3mQ>
    <xmx:tC_xaB1ow4rhFaao8o5x8sydfmu15HPEstlcCV1MUnkjHWo49BbEGg>
    <xmx:tC_xaOJPsoo8BaNwtfohIXEoEMbT2aa8BLAig3ap0xgWTYdwK884VJRi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 13:47:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Upgrade a couple GitHub Actions
In-Reply-To: <pull.1990.git.1760629692.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 16 Oct 2025 15:48:08
	+0000")
References: <pull.1990.git.1760629692.gitgitgadget@gmail.com>
Date: Thu, 16 Oct 2025 10:47:30 -0700
Message-ID: <xmqqa51q4u31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The Dependabot setup of Git for Windows suggested a couple of version
> upgrades; I extracted those that apply to Git itself.

Very much appreciated.  Queued.

Thanks.
