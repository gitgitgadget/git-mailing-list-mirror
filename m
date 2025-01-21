Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0FEDDAB
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422227; cv=none; b=uKnEtKm1JBU1vpRgL65CwojdRS9u/lrsNjTIxIECRCT9Ead6b10ugpvEIH8gq/gRJcmXOfASbtsvcw7JKXQs6R9pFoi63YXj/5Di56Yt45X18Go5Gjdcha8ph9j0P4LXDY92gFHnqWqwTG5ccd8DyyiO/2cKciss5tIQQUXXA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422227; c=relaxed/simple;
	bh=wQxXscSQrxH5kPRG6x3xJxmxO/vTtb25JHB0cqXTpGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tm0NJiCsH+h3fbV9XoyLz37QiZ40zY7A3P59e/v/9tI++BoAyJozy63EW26BUHBscRBCdS6Ag1qPLEV0ozYPnFH5yRZqUWQaOyniJf3wDqFQZUPKodWrzi2799q6ANb0gSFSbXYwaLx1ROj9S9MxqD5DP3CFtl+i/QW0wjtlLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wA5HNvg2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHHKry7H; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wA5HNvg2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHHKry7H"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D172114018B;
	Mon, 20 Jan 2025 20:17:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 20 Jan 2025 20:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737422223; x=1737508623; bh=jCdAmmZr82
	ws4Bl+Xv0blHi8lxzcbMfIHbE28Xg8q0E=; b=wA5HNvg2pg6zXlEEe/pZ9Z8hDo
	gGEOrutawdGUkDQFbtPx4ZdmDNfqU5aQRL6J7ABi0MfiIdvO67rw8MNMfIMH06Mj
	dlr4GZCAj1E0La3PbxGoK/JAo1smFY676ksnzX/V6kHiMV0TLx8+WBjZBiyWqidE
	9UZracFySg4XKS+QGFYPvDrV17QK840sXXYetaOEO1KAMgTX28tBEegzjSPH6jHS
	WNiXodxzbXTF6GwyWX3GMyPDV4i3OE9yFD8+5zfC2/VP4vxenRIVNUc3hMySy6C1
	G6bhCjL83UUXpyuoNsCjp6zKZOo64ha80ySONXLeQHb5pQ0hH93tdBP/CYZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737422223; x=1737508623; bh=jCdAmmZr82ws4Bl+Xv0blHi8lxzcbMfIHbE
	28Xg8q0E=; b=EHHKry7H8eHXmUkzh8pfpxef/uMu8RAfckMhpXNRDxZfI7ZzkJZ
	ZpLf07zcjT/wZzbgtIM8SLTc9hmVJ/RYxVa71tXtc9jaVavq1NAH4F1zmNFuWAt5
	5O8lvfNRFA5lSh37EGdtEPkGK24LMMaptqmlUVEBAHfBucEPF/YhHQvW2Ektffg3
	lfrEkne0aZnvpKRT7mvVnV9KQpHJWBqc1MwUVQTVr2O7fp9tTGq89t038uUIrUm1
	+BOvXKYROmm73XaKfABuoT5xuFjj2TFG+VnTB4oTZGXHIlVb/xTv9pweb1InWUVy
	9Tg2VaRUF6qjavFDiBwLKNebl995uvwd4ug==
X-ME-Sender: <xms:jvWOZwVx0AEuSoT7Tndyr7S1a9byrki_hmcuFZqmUA_De--2xfRhzA>
    <xme:jvWOZ0m53NmiTLrAeklhoKoFYJ1gCgO9Y-kl4E8Mq-XnokM3IowEnjjsEYtssqb5t
    i1xKQexn8ZeeouC8Q>
X-ME-Received: <xmr:jvWOZ0bSHia2cs0yrlelGXWCbFQPT0yV8D-qOMtgIdqGw63gW13BdtBevoeTyVnbkeVd86TdL-pcBeMArcbd2romA6EAKVU1ezr->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejtddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehsthgvrggumhho
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvg
    hmrhgrshhssehgohhoghhlvgdrtghomhdprhgtphhtthhopehmhhesghhlrghnughiuhhm
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:jvWOZ_XXdb07CN_8rA8z_S9kjt7dAGAldN7peHyAYjFq3jz8r9_KcQ>
    <xmx:jvWOZ6nVUlNbvr-9GaxuE4IwqkX5kPMdiFdh-k86vmut8dWwsivP_g>
    <xmx:jvWOZ0dr7ez3t-lrLrRtjw6N4xx0Y1Ee6MYx3tjdTD-f2t5j6d7N6A>
    <xmx:jvWOZ8EIihnQVsdOiBHsrhTRIpbvrRYzSOlVzGLjW7LkKj9sgWqnRw>
    <xmx:j_WOZ1-7PY5YbXV6d3XHiWh-nj_Tn4uYgcC-0HY4uBWnXquAc3eK10-I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 20:17:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  calvinwan@google.com,  nasamuffin@google.com,  emrass@google.com,
  mh@glandium.org,  ps@pks.im,  sunshine@sunshineco.com,
  phillip.wood123@gmail.com,  allred.sean@gmail.com
Subject: Re: [PATCH v6 0/5] Introduce libgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <Z47kr0_fYYdaMWyA@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 21 Jan 2025 00:05:03 +0000")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1736971328.git.steadmon@google.com>
	<Z47kr0_fYYdaMWyA@tapette.crustytoothpaste.net>
Date: Mon, 20 Jan 2025 17:17:01 -0800
Message-ID: <xmqqikq92cfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> It looks like we're building a general Rust lib crate and a static
> library here, so symbol versioning isn't an issue.  I expect in the
> future we may want to provide a shared library, in which case we will
> indeed want to do that, but I agree that can wait until later.
>
> In any event, I overall think this series is a nice improvement, and I
> am very enthusiastic about it.  (This is mostly for the benefit of
> Junio, since I think the authors of this series already know that.)
> Once it lands, I do plan to build on it somewhat.

;-)  Thanks, I heard you.
