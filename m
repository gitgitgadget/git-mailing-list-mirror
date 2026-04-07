Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0BB37267A
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534998; cv=none; b=l/hsOgCGa5m7Jr0Sc+O6q5N4IASomMha5C+WCDMzpy3gV5vDs2gZFJqCin39N7nHWp33L4IZ24CnlrPu6bZCWqhVbwMgfF+LU7KVWi0vB7ZasMQRRNv5BexwAK/YbBtT1FzQKMClMipFxdVI56D9ezdxalxd0rhS1zues2aN9s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534998; c=relaxed/simple;
	bh=/3+NsKt/F/ZHJ/g/OX6bCeYYgmmPRjvoCrZDETHteps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UWKfbF4CGtlyYbynTr/AtUE/fwB0DpiFMWO36gCegQW54mU1BF93CdCtGMcOx8/mQXiSIszbYzGvzzWz/QE4QZITBxTmc911GsqO1tjuoK/BiXyfmedj4z4kmIGvCHfgLdTRU9BvK/vcdIh0E1Gvi0gFghmKE7mCJscn9TS99KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0vHnIWMx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tr7jsOTb; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0vHnIWMx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tr7jsOTb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 73235EC0387;
	Tue,  7 Apr 2026 00:09:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 07 Apr 2026 00:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775534996; x=1775621396; bh=d9H9fjOI8e
	8pqkKSYzT7vogGxtYyDjtU+26SAKX4qTU=; b=0vHnIWMxHf+aXGLVy/KYaBKdkQ
	oytkqxoUumE4MTwhPRsJ3/YOeQkHIqaU/w2L+QEivLwMt2xPRtVZlOK9yDLUDFoN
	JIQ/mOGSLAwZO5MUh/IAaemwB5MwQYd1IaBjNMxnZFpH/52JneM25ua5WC5r+7oX
	ucXwtr5lYF6pyqROTzeV5Cq8mzpnk1hd2tLVWtWkLSVEsBMaM0VZ+/1or/EhhEGM
	gR5te+TbuQUXiRhwl/eMCx95e49gqnfppDZkA/neDP294I2GbPFdMi7YXey9Igze
	NhblhgpIMAvKu1R/Sh38S6oR2YfRhZQzmTTQuEn6rY0V+nyF5YI6KRbeyySA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775534996; x=1775621396; bh=d9H9fjOI8e8pqkKSYzT7vogGxtYyDjtU+26
	SAKX4qTU=; b=Tr7jsOTb+BdYAy4Z1Y4fs4wEhO2N4ZARV6vz/xukogs8UWj6uu5
	esPhZ17NjxLvKSXdojaZdx5uIbzkJlky4Kr1KY5l2wW7E17879GhQ8MIJlELU6j/
	HG9sufeDOdpGz76JSHbDDtZ0h6zN8w19UN7rledDRCdQZFb+tQwOOfjrqHqmOF+h
	8eiHKKaB+M4GIGp1Zr0cp4+MUz/1fk4sRBCEr3B4iPzOPYaa7O26cJksjtba3UQ9
	TrOC9FKEmZwDxU1GqYlZMBtMmzEQsA3ooCtaxzcv3yx52XXg7ixXukhip8lKUBwi
	QGu37Lys5f3K1XzoQ2X5Ogq9E7ZwjqqNJYw==
X-ME-Sender: <xms:k4PUaYOsQh2ULRS45RiduUMiAvr1o310MFpphYYFhPdNtHx4AZ505A>
    <xme:k4PUaZU6WoaKAMacIPhaC-P0heG-8GlOLWercm-IvPgO_ijLDmGyXqgwaWHEsFdz1
    1ytvao97ubp5l-26xjAjRxTnpznz6yrlo-pnRFhIWtdcSXKS62l>
X-ME-Received: <xmr:k4PUaVZvLyl4VP4Cxma66QNbuFpGhpWUgBGj_Wxlkeqzjo5EQAvwem0UgccV1DCsB7nLk1XWdxe-kzinl1xGw_gVUSCXKeyiJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduleeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmsh
    htrgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepmhgrrhhtihhn
    vhhonhiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehrvghmohessghuvghniihlih
    druggvvhdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehstghhrggtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhlihhpmh
    gvthiighgvrhessghluhgvfihinhdrtghh
X-ME-Proxy: <xmx:k4PUab3P6Hm3v2MQ7hCGo0p250PRvIIZXFoMnL94JEsZVYeAJtMOXQ>
    <xmx:k4PUaZBGKw9MdaF0hUEO1x_giMXl9cqrHYIObo6PGIabBG6dgRl8OA>
    <xmx:k4PUaX_ePHcsnMtl9wkTFddrMsSs5olKbzYIHingV9FvpYcjQ7dHBg>
    <xmx:k4PUaUVGyBQv09FS5cQ8mXXleNUI7jBGQx7fvrfyZUIzDAiTxFPCtA>
    <xmx:lIPUaXesRDFJ6xLv59IL6w9IV4Eorq-vRlQ4AAszwXwNHq95PJOcrqLv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 00:09:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matt Stark <msta@google.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk,  Martin
 von Zweigbergk <martinvonz@google.com>,  remo@buenzli.dev,  Edwin Kempin
 <ekempin@google.com>,  schacon@gmail.com,  philipmetzger@bluewin.ch,
  konstantin@linuxfoundation.org,  newren@gmail.com,  tytso@mit.edu,
  nico@cryptonector.com,  rikingcoding@gmail.com
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
In-Reply-To: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
	(Matt Stark's message of "Tue, 7 Apr 2026 13:13:18 +1000")
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
Date: Mon, 06 Apr 2026 21:09:54 -0700
Message-ID: <xmqqqzor76nh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matt Stark <msta@google.com> writes:

> In the discussions on
> https://lore.kernel.org/git/Z_OGMb-1oV0Ex05e@pks.im/T/#m038be849b9b4020c16c562d810cf77bad91a2c87,
> it seems to be that:
> * There is consensus that a `change-id` header provides good value

I doubt it.

There are multiple people who wanted it, but as far as I can recall,
I did not get the sense that they had the same semantics in mind.

> * There is not consenus on what precise format that should take

Format is one thing, but what it means is much more important.  When
is it inherited?  What happens when you split a single commit into
three pieces, which piece, if any, among the resulting three will
inherit thee parent's?  Should rebase, cherry-pick, and replay
behave the same way (IIRC, rebase and cherry-pick behaves
differently while propagating notes).  Etc., etc.


