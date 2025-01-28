Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58801DE883
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738099070; cv=none; b=PdvY5K2XgHEi9FjRMEwUb2BuQV3qZZ2HJFzjCH4iQUt+BZ+BzV3cnZGB/rlwBkVN8f1GhgeY6ulUkmpCpu0dGfuPWY6lV6dtV9hQVjOl0x5gsXd/3WGK+KvsJ6UN/qIeWYG8bJno0liZxIQDRTb63QqipMaEHuv+au5Q2rElGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738099070; c=relaxed/simple;
	bh=okcwZLWRyis9nAGz1ZGCQUTmczBhldCRvVetetxP3Mw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BUlWlTYagiFjCCBIJge1SmL4fTpaijhPXGbTL0lxUciEwvFHtJl18pGWx7UjgifXpzDU1cX7eLI1uAXvGTCd/eH72pSewdCOIM7mbwQZVp5AaDUAPIRlYky6fjOw0YvDG90Q+r2sqJ+WV1ZJoQeXKNCh9E7QpbQUIfbeVfSGi5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TOMaRVw8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MkQ1jQB0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TOMaRVw8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MkQ1jQB0"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFFEB114010B;
	Tue, 28 Jan 2025 16:17:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 28 Jan 2025 16:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738099067; x=1738185467; bh=sMdngEO04U
	2096d7uKVNw/w6JHlDVEljBEWB54boqh0=; b=TOMaRVw8H04ZFvNLI+S4jdsNSk
	y5ZqGwPs15dxiPvw1/FrTemaonKNTRqII7jY+oSdwf1xUSUxiOvUay6GXpMvflWE
	gj3eH3ymDuMytwt5g87HERonLC7tuI8ziIBX//dE1Sdl8RS1gyZbhX0DpBKVHoUv
	hwzresl1UeQOUdr0eFXIwnZDvJBBQw4cs3Hi4PGJF83OwucKJkgqik13yuasRmC+
	dac6hNQtf+U4kgRP/+bb9u2Fk/9JnPTcKllT5ihFMGAAMn+S6sIHg55mMDKVLobK
	DfL4IPFf26GncdlmSlhB8qA9jY/3mF+fYgJwI6tKrNhF/eS3zsoRum5Ma2rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738099067; x=1738185467; bh=sMdngEO04U2096d7uKVNw/w6JHlDVEljBEW
	B54boqh0=; b=MkQ1jQB0eAvzcAOhnn8EgjpcTfGgImB9vlDFC/7PV4AMhfOIKWK
	PsEXWvz880ySmYRTjMS+gLTCwqToa4mXfVv+rbtZ43xksKx3qCTWucX9GQOOohqF
	gNICkrDIVKvv5ImiF9Ea966AaMlOjg5YWgoUmzD/zhiR1B6wR842ISyF1Dvsf47i
	E/uL660RZscLwCokk3Hn5B30dJ7zAwhnFB4h4ZLXHkuAE1tx3Z6o3XlNRDu8kL/Z
	vvtzcWHm4LzKdAEeeAGWW/exacPoYTl1g8uQpfqwvgYX8NOYazxKk0TdUv7ZGhYm
	RNZ6fPFR8ScGhqCeTJNx1i3I1v74cF+WsbQ==
X-ME-Sender: <xms:e0mZZ31eDZUmNf9rZO5vqHAbzzHGQqNCQy8f02byABwJ1-L5IIhbRA>
    <xme:e0mZZ2Glx0K5EjyLf9JBrcw2us6WQyYLwnOG0aH906ij7vVAFgqCBPXUrbCd5P0fw
    081iUePt-g6m3gR7A>
X-ME-Received: <xmr:e0mZZ37oYlh_w2QRZ4TNLbwyq5IH1VeOd4YkjjmgpK6xuoXZvTLXHepqjnGuQ6pXLg7u2mx2pAbC62iLNdrNg0XPXCzGMpcRxu0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhr
    rghsshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:e0mZZ82dCVz9nJXoEvZ4TUQNOrjicIj4hUJ6d-XrJh7F9tZgSe1wiA>
    <xmx:e0mZZ6EiHk-q79EwXV9szCSUn69eV0deWbMvir8A7YI8dSMEugsZaA>
    <xmx:e0mZZ98ARM7ENhwlWTdSva_dm62qL8NvJ69VHiFwj9MOhb0vpeCifg>
    <xmx:e0mZZ3lK7o3g0XWtO4_iLc6UO8RcHZYcm4zVwgVDeQyfhrjWN6qonw>
    <xmx:e0mZZ4bstAehsmJjE-v8yOUlUslnSNSKTz3EsAWn4L6vSPAWRXK6wg5R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 16:17:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  nasamuffin@google.com,
  emrass@google.com,  sandals@crustytoothpaste.net,  ps@pks.im
Subject: Re: [PATCH v7 4/4] libgit: add higher-level libgit crate
In-Reply-To: <iexpjuyxdg3yzk2eeibtzfgyzzrnpo2fg2ic6eeajky5lm7elw@tby4wimoqjrg>
	(Josh Steadmon's message of "Tue, 28 Jan 2025 12:50:32 -0800")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1738023208.git.steadmon@google.com>
	<88425bb0b1b90cf6b3d2d5a1af57e46c7a03ad39.1738023208.git.steadmon@google.com>
	<xmqqzfjbo7sb.fsf@gitster.g>
	<iexpjuyxdg3yzk2eeibtzfgyzzrnpo2fg2ic6eeajky5lm7elw@tby4wimoqjrg>
Date: Tue, 28 Jan 2025 13:17:45 -0800
Message-ID: <xmqqikpymydi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

>> I somehow would have expected this part of the patch to do
>> 
>> 	libgit-sys libgit-rs:
>> 		$(QUIET)( \
>> 			cd contrib/$@ && cargo build \
>> 		)
>> 
>> but the above longhand is fine.
>
> Fixed since I'm sending out a V8 for Phillip's feedback anyway. Thanks.

It would be a "fix" only if we anticipate that we will add in the
future more Rust things to contrib/ and all of them would follow the
same pattern.  Otherwise, it does not really matter, and as I said,
what you posted is just fine.

Thanks.
