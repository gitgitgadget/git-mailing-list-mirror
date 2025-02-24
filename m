Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D24EF9F8
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407269; cv=none; b=XYjT1MedOisLKfuBTMvTF2XqBdbFw3RxF1hLUUxqjGyszAEyRi+hBlrN9kiUOWMTPiruUlRtZdwFriKyHrMI6eM6ymjK4ru2USL7HxK6Y59UIX9AXegvl5UGown9pvJszT3Vh2iNYDj8LdoqHgskwkQWs2PQd0sHIiQHtS83K60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407269; c=relaxed/simple;
	bh=ZnNfB75q8bCg4WyTOnohqaD7xTNAfUMkmNRKAwiYY6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VRsRkkbsNRFvyyuzofXjG01SlYV6RGWjKWQhYxectdb/2Do0mygaEmQZAHifl/PSmj4F9wCZNSg9+Odlu98H9XQF14MnCdFB4bP0ApMdqnqR01xyX2XdymVHi/22OM6AYq2ne0KAbdI/ucCwmfJT6OdnmXCSLhjCvJhy4CLCJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yk6oTGSp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5vqRWcY4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yk6oTGSp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5vqRWcY4"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 569C51380C16;
	Mon, 24 Feb 2025 09:27:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-13.internal (MEProxy); Mon, 24 Feb 2025 09:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740407265; x=1740493665; bh=93OiloWish
	XNfta3PgRbxxEVZwVFdnvAjY1+L9SO7k4=; b=Yk6oTGSpNQ42lfiLYVoTDls/iL
	4UPkwRHj+YFmWUhknlE6MObVrgtDWIOoF3ZBHBmJHBZR7vawHc6PBAbqGN/J17nD
	hBM6uJlnQikJCNMQN6xwHw6HFG/B4qLOE/aRSBA4JYDg4YeLvc/Y+3uRplYnIAG4
	bOXWU20bwKmXnxSLPoPdGpm6CHN5vC/UuQEEBufhRm4897MrgM146Eiq3SGqcMhy
	k1acdUe0TVbvE/55MKelq+7ANYoKm+4h8uQCXpqQYNtvch8qroxxC4MMI9JIAV+n
	p2nHmpG1uXVLzdUqOq6OXVRgkgiEfuFJUiAyPJMuS6Ti83DI4Z0DQpNbYYag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740407265; x=1740493665; bh=93OiloWishXNfta3PgRbxxEVZwVFdnvAjY1
	+L9SO7k4=; b=5vqRWcY47J4mjBL9BFImY5qOdG6rBfRcNWIEW/tXEd2FuRxb79H
	2dGpyyH8ay83iX8rJ4UxvXvSDcERvDKkFXlND+W08k5Bke/85XMmHw5JGnwalRZM
	IfjVAEKfOA/jtRwQQUeTSEZYY1LtHURlPx8EGZVpXYO6Kfchfao7hGG23MQ3DGK9
	+Fm+X8BDSS6yZhi0yXFGOIVMfLBy+Ok3v8vtBdoPBbOq8MShstuocSxyulvPQxzK
	5/hoetPASMTI8cD3rofONjMb02/YFCAj9oSWWSaB9HnUdp4XsnnNMpTtYIj1ZBes
	HinSz7kDWr/gN7Mh4vYtuQOHpAYQ0Te+oVg==
X-ME-Sender: <xms:4IG8Z1viYuiJjyTMTU-E28P8FZzEWcBJpJGhd-lGjnpXKSXYranEsw>
    <xme:4IG8Z-c-UqfRc8yz6cGRcIHSjw9syNZiZ2Cu_XwtwJgVA_AtjXKPFmKC1qLpRDa8L
    AITuLdesx8Lv9MYAw>
X-ME-Received: <xmr:4IG8Z4yq3Gh0MY4joD1t4qB7zHUUNGj8-0YgmKYx0rzXkLLvl251kIxO9QD6rPxMUZtwRMf6K42nhVeCIf5y4fTx6BE4IhrMObtcItQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejledtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    pefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevuc
    fjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgv
    rhhnpeejgeefieefiefgueetfeevtdefudekkeekhedvueeuiefggfduleetjedvfeeike
    enucffohhmrghinhepfihorhguphhrvghsshdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehj
    vghllhihrdiihhgrohdrgedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:4IG8Z8PRIc1ApJIiOuzdvSbby5auIHMI6RgV2RpLajKzH4DBzI-1fw>
    <xmx:4IG8Z19G42-rZPb5ZP27Z3pb4aDsEoU7Z_uvuEuEm06yPxMk9klB1w>
    <xmx:4IG8Z8XseJe-hAZvhUVZK0qD8wBIUtIPF8dx10Dgp5IbhZgOYHcWow>
    <xmx:4IG8Z2dfb7HQb8FlImn8C6BRyQ1SExRKjqtCIAZFyJ8iWR_6L479lA>
    <xmx:4YG8Z1yUiSPogV50dZV-6Ad9WDVb3PbpLO_TJAOk4a0Gbyx85QuyluEK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 09:27:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  newren@gmail.com,  ps@pks.im
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
In-Reply-To: <20250223173629.16489-1-jelly.zhao.42@gmail.com> (Zejun Zhao's
	message of "Sun, 23 Feb 2025 17:36:28 +0000")
References: <xmqq34g7cjf2.fsf@gitster.g>
	<20250223173629.16489-1-jelly.zhao.42@gmail.com>
Date: Mon, 24 Feb 2025 06:27:42 -0800
Message-ID: <xmqqv7sz76zl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zejun Zhao <jelly.zhao.42@gmail.com> writes:

> Now I'd like to ask for your advice on this issue, which I may be supposed to 
> do before sending any actual patches, should I push forward this patchset 
> further or pick another microproject?

It really depends on what "this patchset" you mean.

I do think that there are still places in our code base where we
truncate size_t values that we eventually use for allocation by
mistakenly mix arithmetic with smaller type, and I do think it is
worth finding and fixing them.  So a patch that fixes a code path
with such an issue would still be a nice thing to do.  If there such
a change (I do not offhand recall) in the 6 patches from you, that
part of the series may want to be resurrected; but I do not think
changing "int" for line numbers to "size_t" is one of such changes.

If you mean "find anything that -Wsign-compare warns about and
squelch the warning by using widest type common among the quantities
involved in the expression the compiler warns about", I do not think
it is a good idea [*1*].


[Reference]

*1* https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/
