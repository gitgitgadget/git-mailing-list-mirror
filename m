Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8502765D7
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852943; cv=none; b=u+KIC5dchYVLV1IgmFbdvD/q8VzY0+kDTVqzYKJkM+TGV921M5ASxD0nO8bpMjnhwDqTrH1Pp7FZ5st2X8W5oTFNaLay41yLT5upUR/p65zpfg1puth2NnzUihAH1uDPteVvlXUqzkplcIOnkDrKvpSIJO8KksNX91+gIhsvd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852943; c=relaxed/simple;
	bh=hUPvzJ7FUS7+uOz/O+21GOlrwh9A+qGSCxjGErBapbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KwCYR9uoVSsQLaum96Kmsu3bx0A7WISdnRDbHwZNYMHw8unmxFzmIs6BTz0qOeWbdlwScMFCIJtfRUg4cErRsuFqof3mMIxcLIVgIuzsAGcpufholWjdrtgc1Y0g0d3TU9IjE+NS0ouGBiQKyxJy7g5f2rA7ndWjBEK1z2FWjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fuNIwVOG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lGxzaxgX; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fuNIwVOG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGxzaxgX"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C32F614000EC;
	Tue,  2 Sep 2025 18:42:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 02 Sep 2025 18:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756852940; x=1756939340; bh=PQejCxg1dD
	6oteXVqHgpGzh0ZKLnvf5/BJyaII1Ij4g=; b=fuNIwVOGMAv/Y2jjNXDayn1taS
	BOZMT8RZC2q5iNGsZjtPRO77ahbZH5G0HMwiMuNLhX3tZw6PTyxpzBao1nun7KGj
	mpRRXkT7kdXSZVhjE30Gn+Bo9CratioHL5UHakpWJOhFjMY6+OlaR9NDEBQejE73
	i3G3EoBOOr4fQ0hlDnS25O4ug0+oHwNqx4DDYXxmDjM8iK3rzPTAnenfrmKD6eSG
	8L9JuOmwo8PrJC3iopn/+wF9NRJDT2FdNI8k4shmabQ8Iw2T/mcRWk3M/uEcWFUv
	kaXLBYVRc07wz9Nd/EocQN0TOZxklyZp7PxnokvffcujRAP1KPft5mmD9fsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756852940; x=1756939340; bh=PQejCxg1dD6oteXVqHgpGzh0ZKLnvf5/BJy
	aII1Ij4g=; b=lGxzaxgX5w5riVriKh56FGWbnZKiwXxn+Bi8a2856DUVEv/SvMu
	0WhzQVv1/QyOIgPO43ycjhYU8uZO4LUJ4eGSL+/b1ut1a1tEIL4NG2wtJegHdqVa
	fkHXPfGB4DuSetdqQi++9mvborHiM7oSDQ6DuSa32/lwgikRKeicUjK9Bh6ucwdA
	MkEqjdvZCTtxMAJ+lZPRQOMHnTSLaajVmu44w5bngX4jcPIiEw+S0FG71c+mttVh
	YfsmdESzwdVOrjfEP2NO2WBKK3uZUxNnHTHnySgqHpXLAURc9QXWVTRuugg3loLn
	YlheaFWR/bF78Jl0RS9fvcf+ypLO0fhs/gQ==
X-ME-Sender: <xms:zHK3aCXPOHbIj4iDn0NW4wo4ZrriZowd_9Kyb4gGcyBaYfPnxlAZWw>
    <xme:zHK3aKEDeg8vzn-rIJyMAtj6_3ChrgYd3bVN6_12yc9stu_WmGZeDhw_htWwj5rdT
    UGH-XBUfF3NedBtyw>
X-ME-Received: <xmr:zHK3aM1bQ7IF3NYWTzpOX42kbPmArIpOPrNw9FooiBSKER6IXX6iEFIYYX7bst85L6mZaFTSKLtv4bkE2jWLLuIL1EHLbKaoKtK-FvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zHK3aEMBOgfAaO8eizK_0ReXlY6KW_hMgeEOMR2L3WmCq-ipU_GQVQ>
    <xmx:zHK3aD4VlXgD15dA9DL4oTQmpqKbJmKLN6cRo_kR2KsbGPIf1xAExA>
    <xmx:zHK3aG0H8fdiz6UxWrHRUV1iw6DwfXq2MMYbGA2ocs8taMit5z3sOQ>
    <xmx:zHK3aMxYOXTUv67bSjxTZwpd8lZ5PmZlNKn8P-NSusKb5bbm5l_bYQ>
    <xmx:zHK3aHlUehFBIXbpU37e-SzlMQqCH0C7O9urmj5vPNvBOBiu569O_Adx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 18:42:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  shejialuo@gmail.com
Subject: Re: [PATCH v2 5/5] refs/reftable: add fsck check for incorrect
 update index
In-Reply-To: <20250902-228-reftable-introduce-consistency-checks-v2-5-4f96b3834779@gmail.com>
	(Karthik Nayak's message of "Tue, 02 Sep 2025 09:05:25 +0200")
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
	<20250902-228-reftable-introduce-consistency-checks-v2-5-4f96b3834779@gmail.com>
Date: Tue, 02 Sep 2025 15:42:19 -0700
Message-ID: <xmqqo6rsh3xw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Introduce a fsck check for the reftable backend, which checks if the
> tables in 'tables.list' contain sequential update index. The tables in
> the reftable backend should contain sequential update index. This fsck
> check ensures that.
>
> We must note that the reftable backend itself doesn't check to ensure
> this and it also doesn't check to ensure that the index in the table
> name matches the index in the header or the table. The latter is not
> implemented in this fsck check either and will be added in a future
> patch where we add fsck checks for internals of a table.

Similar to the previous step, I am not sure why this should not be
checked at runtime and is flagged as an error.

In general, we do try to avoid retroactively tightening rules, but
the reftable is so new and not even the default.  If we noticed that
the runtime has been overly loose, the time to tighten it is now,
not after even more installations use it.
