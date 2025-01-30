Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB328BE8
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738196627; cv=none; b=iw4Bi1E9S+95Jb1+xH8awq9u0PPWox1Ev1N85+7UgQPojtAu7mw4edwxzV+fD0KE1iHY0pEIB6Ad+jyUWOR4KcXCPwHEYh7yxmVXO8TMAZv0howGB9ukK1htgthQAh50ZiZE1/6+80Sj4j90usvcI8/vtHEtNBIt5yygbMsW6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738196627; c=relaxed/simple;
	bh=tYH6BX0BN2Tzo3mAvln/D+wEqD2mDBmTHEmGlG3Qb+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I3NZ/pojCyfA/frjewuNiyjRRYpZK6PslPLL6JoQau3DRDo9C48D4QqmLjeEJpKixdEXKE+QOBs8CtfwZK1MEc56QF54CX2gxZzL9E99LJGX38GVWiaWwlruSotwTxBsbaUkBpjeSp6PTXmHD/BaYavsYWXxYtr0yLel1HsU06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pXFeY8wT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZckvBmBl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pXFeY8wT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZckvBmBl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FE40114016D;
	Wed, 29 Jan 2025 19:23:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 29 Jan 2025 19:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738196623; x=1738283023; bh=tYH6BX0BN2
	Tzo3mAvln/D+wEqD2mDBmTHEmGlG3Qb+M=; b=pXFeY8wT/scfnwlfDtEcU3VgJP
	VWNuOfQRE5AACZHlM7LdLoLxt+0viJZE/ME/XGIbrFFuCOnDUwmPZSb57WpB7GVb
	oUi7wpfdQXY9webj2vzJglfX4nD/CktA5ecOezz6sXIIkzIydfqymdezPUSN+OlN
	JOgZPzYKLfEi2L3tN5zVUSfrh4cTuKJh7M8ImM/RaasPsfplhPHl81Fpdfr7s3lY
	YYk3xFib7C81v+Sk1lRWa6YqrsHJU7ImFvvdW9jr2Uy6kde6FyI7u1I9FQ9SePkZ
	DH+6AileMIAxp2/w1yIqoA/iXJv9duDLJDJA8u0yjAYwbxn3+GMslI0AF3og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738196623; x=1738283023; bh=tYH6BX0BN2Tzo3mAvln/D+wEqD2mDBmTHEm
	GlG3Qb+M=; b=ZckvBmBlWL13Mtm7Bx16J/NgMwjdroNETbdEl4ECbz7NNVxjSvQ
	dpAbPm9IzAZSttINSQFZrMY7fLbQ+qwwWfBgmu67ti6AnMM/eGxkLoJFnBNPpmGz
	3O49szf7smJ2refc2pPKTnrFanpPaM2W2/T4Fl5wI8dkCB9THxgCvmpUcbuzB7Uv
	Ug2KYZBMK/b0qw8L9G5U7E2wJVyJ9iZn5wdNdGQ8VbePqGnl9CnsWH0i6B2nLHxW
	qEQZ+gXKMNOA6wT+ekavz4omOoBL0lwhg5c1VohPK1KQz0+aBY3wZt65MiEAHxrI
	/tSEzKWZZkj2B+ED2IXJONA2FWFHoHHV0+A==
X-ME-Sender: <xms:jsaaZ8MWXD4yy1vNrmXu9OcGEGU4J7_A_wbcja12tpISivXZLmAQ6g>
    <xme:jsaaZy__YqcM9hrIhbMhubAvSHIVNzl7W5hG6K0hPcprQMKTzw6jV0H8rpL9Zx9dE
    pRmPfa2YloMT2gW8w>
X-ME-Received: <xmr:jsaaZzQ5Hy_wB-r5HDNFkn3ggCFZr4ABefuTDSzJB6JPd-urxa0IsQ8RbZIiVfJa3MVe_cvQ10g9lS8ev5jbaY0h989CAlbRr7vb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeike
    eufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:j8aaZ0t_gzYWcgnUc9zkMZZrbdcCeOXTn-nS_sxkGKkPyiDoM40M5A>
    <xmx:j8aaZ0dZwvkLqlZzoiTM5zSQVfbu_9oUQtWi97Te2Dtz4Ojem5S0XQ>
    <xmx:j8aaZ41pUFSojMzCN2XshTlh3dJb-Puhknkwr12_DBCyvLzXoVIDxw>
    <xmx:j8aaZ48wqyuYPmS3YcqANd77rqGOX6oExRKFkZmL3VitB-CG-J0qIw>
    <xmx:j8aaZ86T9Yn7aOPyDCtEuS5dZU2d4YngEsj4jOnrdPDzbUFrrJ5TdiUW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 19:23:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [BUG] PREFIX environment variable ignored by git config --system
In-Reply-To: <001501db72aa$fc812350$f58369f0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 29 Jan 2025 19:07:38
	-0500")
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>
	<xmqqbjvpk1wo.fsf@gitster.g>
	<008201db726f$6e6990b0$4b3cb210$@nexbridge.com>
	<xmqq5xlxidh6.fsf@gitster.g>
	<009c01db728d$164a60d0$42df2270$@nexbridge.com>
	<xmqqwmedgpkf.fsf@gitster.g>
	<001201db72a8$72719480$5754bd80$@nexbridge.com>
	<xmqqfrl1gosc.fsf@gitster.g>
	<001501db72aa$fc812350$f58369f0$@nexbridge.com>
Date: Wed, 29 Jan 2025 16:23:41 -0800
Message-ID: <xmqqbjvpgnea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> This appears to do exactly what I am looking for. When I create that file, git picks
> up config values from that file.The question is, is this environment variable actually
> sanctioned or is it just coincidence? It does exactly what I am looking for.

How about reading "git config --help"?
