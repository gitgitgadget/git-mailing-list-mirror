Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820A3594E
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179500; cv=none; b=ODnygvTNqa6jeA1/mwVt0rPRvlqbR3ruXrsVQTgwWT41iAv16AMqtswWTbsqBqUpx9fv4Vuc5KE2N0xL02f/7+vadP02Wrb4bX1Jmgj8V4CFSWLxogH0EzeqQqHXIN7qWkMUSlOLWF13zVHl9bt5O8a9l1EwPuJ5FCvBNlnCkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179500; c=relaxed/simple;
	bh=9PPpG3GRnxHUGSzGRIg4fn3BRsQ89TgOfhl4y3nBIyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dEqxGnmRxpfTd4LdihQrvHfpc6IytwCc29lRlfoizxbKsfGak0DMWnbdZTbTWAtGNILt9oLm+y4b5L86K/z8f8Ltw5Bn15Y1VundNCDcFH0znBfW9EJuEX4hygxQh2/zRtehTfNbsf/DMpCpohuu0Om9YuVOFpC9KWjt87yuxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A8ZbkU+S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PGKgAevy; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A8ZbkU+S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PGKgAevy"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 639821140148;
	Mon,  6 Jan 2025 11:04:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 11:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736179497; x=1736265897; bh=U25gbuOdBs
	9Cace4gjFpwJ8MBB6QCZVA4PPlyndX9SE=; b=A8ZbkU+SDP9Z6x8eh0o1yYJHwp
	IlNIWC75woiopfO46ShebIyeaRDBWghZs5ZKL+l4lxc+nErPVuf8f9IsU3J8jzFT
	pQFhNrB0MV/l46YegX7HL5PhKroe0P7qQxLTNbYzFEi/xT4lRCbLi/D0pMYm1/hY
	xf0ITnYr/UjH004EdPIemPa3A51evSHFqDeLPKAE9p/MVaqk0BHezuOuQ5zFks1T
	UyyBnXReMUz+RO7cwfgHq5nzQiy7oyuINRw2Xx3/f1FwtR2Amj1oUyXIFGdxYBA8
	r0F4aodq8vMXtKnToC5A8/mnNB6A3jkaGURwthJMrKIiVxXvg/lCywrtZ9tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736179497; x=1736265897; bh=U25gbuOdBs9Cace4gjFpwJ8MBB6QCZVA4PP
	lyndX9SE=; b=PGKgAevyXb1WxT44ZWG0qEA8UK1d6djAovNnc895JZdy69RnUJR
	rhZ1EuYPecI0SuEKLN4yQ4isD9nlsxcHoD5WMNGX4lcMCFcbO0zxgejSNNMLVyI1
	xGaKv8D+mB5jv4sE/9s5cw9Wp/lIJi17rSNVlCZJf12EpVYqoaZZntFeFnFQk8yf
	Nwjf0xihSgCiY5ay7rFezjexjsoKPsWOOKlnKTXQ0EVjup0nvbxYml3ygmLRqe0K
	QsZK7OtU+vUSRnU4RMcnkA67XQTEKsSj+Vqia0p2/im3KLHe1yWgoDAPSiSwGKuE
	SqaXNR5Y5e3ZCxUeVxk/0HyIIKgb1i4Ursw==
X-ME-Sender: <xms:KP97Z8JuoJhmvUpVFdzID9YazAXbtUjSpqbEv4YcD-fZt4AReGCctg>
    <xme:KP97Z8KQn75_sWhs2KTdEBg6q5HMAK9h_etRcvk4Fk2NrfFyqySDXm26IPgXbfsd7
    t5f12fduWlXPx7hvQ>
X-ME-Received: <xmr:KP97Z8tGNywi9NRf6GaAp-ot6wLkfVDM-QNmsKMC19nGxEbbTmM2vdqD9OLYYQmZRV7XEXkQoM4bdUx5EeJ7esaUW1FNqkTf3-FO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:KP97Z5byKg_pyhsBgoXXPlyWr5BGiz7sOFsR-0Cj55mbPQROp_IXeA>
    <xmx:KP97ZzbSx_1Dm2hZGokdp5xhsJ5zg0Xp3JrTuw--6mFP6grQpj_CJQ>
    <xmx:KP97Z1Chn7NsytImmqAzxX5i1pbqSAWWovdFEfkozP1IzIj247yI0w>
    <xmx:KP97Z5YgQ27EurDz6rDp_DAxhlMqis64VJAjuuZ7HvmBcp6f8UNxOw>
    <xmx:Kf97ZwRePxCkLfiYiIj0uw4E3v9ZFi7_kMwA6vvlLp1YmqWp35Hhs8jU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 11:04:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/4] version: refactor get_uname_info()
In-Reply-To: <20250106103713.1452035-3-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Mon, 6 Jan 2025 16:00:50 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250106103713.1452035-3-usmanakinyemi202@gmail.com>
Date: Mon, 06 Jan 2025 08:04:54 -0800
Message-ID: <xmqqv7usylll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Some code from "builtin/bugreport.c" uses uname(2) to get system
> information.
>
> Let's refactor this code into a new get_uname_info() function, so
> that we can reuse it in a following commit.

This does two things: refactor and enhancement.  Shouldn't it do
pure refactoring in a single patch, with a follow-up patch that
extends it to allow the caller to hide the system details?

