Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE52E3FE
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773550555; cv=none; b=b808DFiT6QDh4cDKqYeZXeLZRJPr4h+cgGTYlifQINXI/ds/W/a1dV5hfOlVHGWKKXLNYZmdNb4LDRNVJq6xpnR/1kvRMK6qeAYCFZHRPujBJ80q6v2LuVllSDEjNkwztv+wMwQZsKZoy7RumW8UD6Pl4ejExKvsedqHM6+4Ebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773550555; c=relaxed/simple;
	bh=UNmewV6nJZDbjBta8v2OM+a2efpbZqbaOlPlXXLvTc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mGXA44JPJLbna/Ykq2SGK/Py0DgeMbralgBlCsF2BgARj3kBGJYBl6NZzHn33dyAL/ikjZnRi1M7TPbaWpcSrCi1Hb1v/yQplupyiVncyzyWh/85QQHqlGsRwXz4uj5AjLr1fdMJS3czSTdIsLV9jZl4exEuQWD0jadgXEQGxQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RO+KMErW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MVSBRSvk; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RO+KMErW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MVSBRSvk"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F43E140005F;
	Sun, 15 Mar 2026 00:55:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 15 Mar 2026 00:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773550552; x=1773636952; bh=N4fbl7c3ak
	bEUJGtRd2h6c797fxL8xaEgeB1oIZ/Dtk=; b=RO+KMErWdT6aWxxmaU5OTq5A8q
	3pLuNNYMkJYMn1qe21WXbiYzBuoA2vkS/Ksfo/s/n5LEPGi5opFbHnF9xAOv/OKC
	xyC9GoKu/n8vWh9kmSHvus7U+PfD7ITCSRdTIzg8Swrr3oMNJdI+g0Ug1lWQPzXf
	/tpsvhtDuR7q5oORFukxkgCidqrU2PEqyPH+DoSXJDqJ+koIAaft8G1X+kiGmzcm
	aZteJfb+Ke/u1cnUJrciCsbtXsmEbwrYKCcPs/uvUpPgrTRQDDg4hJ+sb00yAgol
	VFz3XpYRtwaHs+REbN4DJahU/Fr7ohW2jrqEcJqYZs5QwAP24anrMSqFthKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773550552; x=1773636952; bh=N4fbl7c3akbEUJGtRd2h6c797fxL8xaEgeB
	1oIZ/Dtk=; b=MVSBRSvkaJyIaLiyVhpBxfH0ymGLYMNE580umJXI5sfom9lluRk
	34/AEVSPw8zNtOHokQ2e04P4tkmSvO4yomeGQnGga8GmH4qeW2WkdaXVY7JeVROJ
	zMuiP3ryHHSYBKb1ZbRcT3Hd3+xdkTmQJOqtIU9X6Zu51yMBPLRjeN1DsGvDekI+
	mI/4GC4Zpxrf/d/6Lyr2dfylrMlDd3Pvo2fI5xMhzNX7YYQL1a5oTT1CeLOSuOHB
	/l2dfQczZGqOdvpVpzJRNHN3FzUENP0HDrVTAOrcpD1jTpVrJVG4fupulZXn0qqT
	LN6B4+tFbQNsBgE7KrKMAy5o/85vwiDKMHQ==
X-ME-Sender: <xms:2Du2ad3ph-akZ5resh9WM2TDX8gUl4BMLujyXLBMFlllU0mrSmz_ug>
    <xme:2Du2aWoBa7S0hs2JBI-eK5T6dMEDd7FzeOG2l9ank0zDTEGKY_7qnVuzdGf2Z6wZ6
    02GwElZ0x_6zpvQX1tm7IxSEGmOA1GowrOPj8o9aNKs2TxQYZbckw>
X-ME-Received: <xmr:2Du2aRirqrVhlB6xDMHH1tvmbrUAjbONDTw2V9dk7TWSpYTT7Jr30d8Fx3Mdn-5_FrIZYGj_kHwj3Mz-moxQQGBzFoNVY3hmNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleegheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2Du2aa8eD0eyQqqc9H2kh3EKv4Yt0Lt7whc7TUOcJXXxL-ZUFfyJ7w>
    <xmx:2Du2aVV61WNp4ph-1zbIP7SnY2BTmE_xYoImFq58wQ2h2Sv0kNiOvQ>
    <xmx:2Du2aWAqy9s1NJrtzLEwyPsawLTdVO-NmQ-Ir-Nkc9XDtGLFiSOZSg>
    <xmx:2Du2aSFHGjeKru6ktalBWNL6LKd7CsYjjvuGl_jd6Yd4GzsW7sRAjw>
    <xmx:2Du2aQjWZMovo5r0Ve8BOCrW4_p6eh4zqKaocsbId-nXLQRq86BYsoyC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 00:55:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/9] repository: fix repo_init() memleak due to
 missing _clear()
In-Reply-To: <20260309133739.294555-2-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 15:37:31 +0200")
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-2-adrian.ratiu@collabora.com>
Date: Sat, 14 Mar 2026 21:55:50 -0700
Message-ID: <xmqqbjgpvgh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> There is an old pre-existing memory leak in repo_init() due to failing
> to call clear_repository_format() in the error case.
>
> It went undetected because a specific bug is required to trigger it:
> enable a v1 extension in a repository with format v0. Obviously this
> can only happen in a development environment, so it does not trigger
> in normal usage, however the memleak is real and needs fixing.
>
> Fix it by also calling clear_repository_format() in the error case.
>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  repository.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/repository.c b/repository.c
> index 0b8f7ec200..fb4356ca55 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -322,6 +322,7 @@ int repo_init(struct repository *repo,
>  	return 0;
>  
>  error:
> +	clear_repository_format(&format);
>  	repo_clear(repo);
>  	return -1;
>  }

It is arguable if the fault is on the caller, or the callee which is
read_and_verify_repository_format() that answers the caller "hey,
you do not have a valid format to work with" without releasing the
thing *it* sample-read.  As you said, this only triggers in a broken
environment, and there is just a single caller-callee involved, so I
am fine fixing it on the caller side like this patch does.

Thanks.
