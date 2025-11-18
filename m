Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2F2DF3CC
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763501675; cv=none; b=t+QOEb8b/gCM/ku4JNVQABFFcZUSEsKNLvpwUK40Cht+eLdC/mov8QeaF+mDJjB0/oMKMW9pc46scmEeXVIMtY7joKTrE/WhHMyeo2IUQsv9Vi95v5GfYWsV+L57wFlWw8eGHTLVef6cNlVC8DdDRe1VWsCbnaKZ5r8EgMP3fEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763501675; c=relaxed/simple;
	bh=LQ3aqEgzCuTcaEbNb+qdf1j+2czwtQHilg1XxGbSYTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G3WDIu23R/QnHRZlN9ObmrKOiCO1cfKV6vX963xB3CTrts0Vx5k8PE1xefH0zHZ0Yc5X8s53sz6wsKOiOp5gexW+azAfEUYG/zkKrc1ESRyNdeERedu0+eN5j5OQQ0vzfYML3A3ytZ9dk+L/4t9cEHOAcMUO+56dc418WKeErZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aShQAA6a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OF19RxZh; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aShQAA6a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OF19RxZh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 59641EC014C;
	Tue, 18 Nov 2025 16:34:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 18 Nov 2025 16:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763501672; x=1763588072; bh=4tiJ3R+hSS
	3UKYfngUgJDllwvpwJ7g9FHNx+8zvMa44=; b=aShQAA6ar9IhAQ6g0LIdQdkkUb
	TC/gJor00fJqpfZB24zJqtUW2cgPdBad87xeGf3m87dBYTl38DZ27MInV2cYsylW
	RSRVSRBrWmgjA4/l2OWriJ0VkP/NKYUOhD8XNj3gMuq45eKr7G8zK1o7vbfum6tD
	9Q+oYHYF4NBgZbF0QpeuyI393iHjNuHmjzUl1JK6hA9jZFLB//IRxdSv4zLXtZkT
	e+LKfFeVijnOt3y8GsRsTO77fTsuEP+xl3H8r61LuU/lMsJel0/6kmym94v3eP8a
	zyD0P2sbFswVP7amdC/+o8qqpXiyHFUkkE/Z1pAYksnzpXt5rJzYWCn295OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763501672; x=1763588072; bh=4tiJ3R+hSS3UKYfngUgJDllwvpwJ7g9FHNx
	+8zvMa44=; b=OF19RxZhb5kR6oC6zdHXX1uraMduL/zTK/nEAxYh2pT2dZ2+0WO
	GJqFpvHcnr18FfCurawNdkyt5G+TY4Gargw1YxwQCui/CcgsNUs/R66N5FmNG394
	125IpvU+e4MH5qmFw0G9OqkSxcazgRgd9qxtMVYFuQI8oMVLVryqCSbkR6F9sGMX
	D0LUl08OHpK3IEAl34245Xg+R8Sa2MOlM8nSz/9MSutXWlfWGgODqre0jdo1qCaY
	LfLKC00AGAqbw1R1f0ALm4JEf6kVUvXv1cIV+h7g5u9JGaWJKprmN764WYb6/9Os
	3JUbioRKRTr74tlfbE7Rj5J9Ycv02ERJZHg==
X-ME-Sender: <xms:aOYcaQsxgv2JVpVunzxpEUzH3koH6FwFIZU8bS74haYcSRki-Pbmlg>
    <xme:aOYcaRIFFKB1VNT-KZzh_kd-3X9QoXL0Sz0N_a5C5O51YLaZsL06VYecWbnSnBpYN
    2hot5BAADN5g533CKnYVlGTkFFAd-pQL6tROlNQwIOMddYqHuErfQ>
X-ME-Received: <xmr:aOYcaVmvb7Yf7x9uK2CQ48MEm3JUcAaSG4wKkl-YCOgVAGOD0z9JeMENAjLO1C9iNqLw1kHSvRe8Q4Yk-4As4OMr30TVnhNyDWAD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aOYcaaIOEb2zHo6LHdmPNKJtepQNJnCEDQnQublTTuKC4UE2d6z_-w>
    <xmx:aOYcaS6WNjMg_hnyqOzVrn1MmOf_N_Liz8AcudY4WQaLQGZK8YnflQ>
    <xmx:aOYcaW1kw75R3SaEMgC5MZ_pjdf-_owN7daT7PBSXFu7AaZYLzfANQ>
    <xmx:aOYcaQcn8O0AcPDtFG_FsdxgnMUXJGCJaPJPCuurd6J6Fo2m_X6zrw>
    <xmx:aOYcaRyp6KHFNJiRzGucsvAdb5iPf9nd03Qj6nHGVzkTK_fNdN-mWXpO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 16:34:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  ps@pks.im,
  karthik.188@gmail.com
Subject: Re: [PATCH v5 0/2] repo: add --all to git-repo-info
In-Reply-To: <20251118204929.43597-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Tue, 18 Nov 2025 17:37:02 -0300")
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
	<20251118204929.43597-1-lucasseikioshiro@gmail.com>
Date: Tue, 18 Nov 2025 13:34:30 -0800
Message-ID: <xmqq4iqrdnyx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> This v5 addresses the issues pointed by Junio in the previous versions. They
> are two small changes:
>
> - `print_all_fields` now has the same signature `print_fields`
>
> - now it uses `size_t` instead of `unsigned long` in a `for` loop
>
> Lucas Seiki Oshiro (2):
>   repo: factor out field printing to dedicated function
>   repo: add --all to git-repo-info
>
>  Documentation/git-repo.adoc |  6 ++--
>  builtin/repo.c              | 63 ++++++++++++++++++++++++++-----------
>  t/t1900-repo.sh             | 21 +++++++++++++
>  3 files changed, 69 insertions(+), 21 deletions(-)

Looking good.  Will replace.

Shall we mark the topic for 'next' now?

Thanks.
