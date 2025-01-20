Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF201B6D15
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402769; cv=none; b=L4A5yGkkG0Pvsb0FVrNfvrkywQdQ/WmAf7jGDBKd8oU1/d9E5WtR9AbgxofWp/GpI3LK3NCooasmNBJriEdj9P9RkKEoz6MzVB5Qu8wjMla+nCHytYTaXDiOvegw02B4mJhrAxg1HxhnwuEB97pTsXzodX2XfvWq8Q36tyk3l5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402769; c=relaxed/simple;
	bh=loJm2H+A5WvWXYn6KR75724Vlny7xAT90HrSzf02EZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V5reU3inOkgnFD/ZxfDS4TYIt5fYmRnkTET1iq1eT0vS4NjuXEPlxEC5MCw9KV2RltSOiEHYGIg6SQ2q3boTVn+IYErnMGd4yQU6Inl8M0ZY+NbQCV7AyyUdG0Wedg7ioQq3fcitGvAsLRIbb1QUzUCaoXyg21SU1yFDpqyGObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dReIprwY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GNN4S4va; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dReIprwY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GNN4S4va"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DE6E1140094;
	Mon, 20 Jan 2025 14:52:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 20 Jan 2025 14:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737402766; x=1737489166; bh=BlM3LH+06h
	dOuARASMmNzyC7v0Zsf61sATEnXDDaF3g=; b=dReIprwYjtIPODzJ72kTzCCA3o
	UsOq6yg6pB33pXqJCk5pfliGo83Q/sNJSm+HCwm4xXKGxen6pkhzCOMEc1y0VnbB
	3zS5D0s9yRYj2D1su/oXrg3byJ3PqpS4tDhgS6xQTaiSNeSgztpPrc+UCdKXMdXT
	hKXwAoaO8NO7C3jlTOaUm18zyegZShJv3g2pIQzR4M5oAvqxLh3Tr8nQqEQWfjti
	8480iWSqt7TT6lJ33ZbQPmqQobW7dezJHxUP7JlDY5QBX8RboEDl/b9llCqtehaL
	V2Sv9QssOAEtUdZkpkDpCmfieEzLu8q+X2cIhWCcni1rW2/kkZrrvcRCAJNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737402766; x=1737489166; bh=BlM3LH+06hdOuARASMmNzyC7v0Zsf61sATE
	nXDDaF3g=; b=GNN4S4vaNaJM0ARWgAcTKpxyvE4FYkr8Kpn4nAQyvaN5dDvZnGN
	7L4qlO2jloYknbOxwUb13CJAknR8qhRsdiLIjc2UWTFf6ZW5t2KcGz9H1q7dYpI8
	T7CzEkc+T8rg5RLjz70CHVDaGFxvBB6FsOvVChnAELSoHzNFHCBJyjv/Hg0z8ANq
	nxKQxJzHZ4fGkxbzMXOSKgj677enG+KCtP+Fh3K8/Or9OSZDFPEqrr6Gk/HyKjdE
	s7f0rNM1SQGvBY4BxP7ZPlqHEPewyZR0s+EzLPUGoYHGGuG6VJ74PrPC7US86Oeh
	P2FsNEVb/kBX2AYmnarksA/1Y7Hdn6abHeA==
X-ME-Sender: <xms:jKmOZ6uhSu2Lm-8IG9_OUyTe-Zw-trtEtsjeKNqnCMTLFbSbOOByaA>
    <xme:jKmOZ_eToLHg_oi2RbaFHcbupH63czt4D8aoh-lDn-rs26CZDhUc3Enzvf-nwhKK3
    BqO8kYJe2VDVXtH3Q>
X-ME-Received: <xmr:jKmOZ1xCY3foEHZzTBAtVJ5x78Snl-FWuGRinbS-PTLJCP8G_6TMZYO07npr9SYHl9PgZEncDQapP8vZEgYBaP-JJw33s9DUET1G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mh
X-ME-Proxy: <xmx:jKmOZ1NVlTwU-u4PmVgLoky3VNIRAN6cariU3mnjRavBU2dVnNoWyw>
    <xmx:jKmOZ6-qBdWCv3HxdG9ShyrckafCs4Sd2v2pqlH0t90xNcS3Rqgk0A>
    <xmx:jKmOZ9WC_WZPnYHyd1duP4BVjcWWOU-nFyLOo0Mqq5LxvLcOY46rdA>
    <xmx:jKmOZzekdWKyGwruiNUKE_vmMao1aMIvJ_zJvO4-EEv1BE5-LvE_Rw>
    <xmx:jqmOZ1Ugv5rMJKk8R-SESJylvA7HGs1m_mGt_LLZBlI2ZSKTwNO9UHlM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 14:52:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,
  rsbecker@nexbridge.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/6] t5701: add setup test to remove side-effect
 dependency
In-Reply-To: <CAPSxiM9qRQ2HuTJDmhq_xeCRmn+yUvjXokwEwJE0S4av9Y-TKg@mail.gmail.com>
	(Usman Akinyemi's message of "Mon, 20 Jan 2025 23:02:05 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-5-usmanakinyemi202@gmail.com>
	<xmqq4j1xkzir.fsf@gitster.g>
	<CAPSxiM9qRQ2HuTJDmhq_xeCRmn+yUvjXokwEwJE0S4av9Y-TKg@mail.gmail.com>
Date: Mon, 20 Jan 2025 11:52:43 -0800
Message-ID: <xmqqy0z52rg4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Yeah, that is true, I could not notice this as the next commit of the
> patch series
> was able to fix it. I will change it to "echo", with this, it will be better.

If we want to prepare ourselves against any arbitrary garbage the
builder may throw at us, using printf with _fixed_ format and feed
the potentially arbitrary garbage as its parameter to be
interpolated is the safest approach, so writing it as

    printf "agent=git/%s\n" "$(git version | cut ...)"

would signal the readers that whoever wrote it knew what they were
doing and was being extra careful.

THanks.
