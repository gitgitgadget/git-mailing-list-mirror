Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7115134A8
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385607; cv=none; b=O/T3PF06MANItpLcc/DjTyW1KVImw9iA0m85V4w1pGD5ukrmpGlB2mazxfUjpbuJcgRanV9aDgMelaTpppdctjmg5FnlbCWNtTuMHO8UgcTB0idN937H0CeKFUh03e6sOZQ0eXq+msIzP8G3hWMXg37kLWpRUL2CRmOF1QhXpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385607; c=relaxed/simple;
	bh=Df7pEUDLJAwKwwtTNnvRResUlBw4uoJaDcAlPMKrPVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EwtWuGuLUEPx3RygrTJor6/yL+MF1PBTPPgqFGW0S37HOkov0xmTJAJgl4Vb0h9s45UBblKSoqaVMRcpYhIEl6t5SqP63mjJg1T7kbXOGXigtY6OWcDUaJJ8bthVnDzy0wD9KAboEANu5Vpe/Y5JyHBrtkJrHJkwgxm/pEojOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=orYE+WsY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iC/37NNC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="orYE+WsY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iC/37NNC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE41A25401FD;
	Wed, 12 Feb 2025 13:40:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 12 Feb 2025 13:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739385603; x=1739472003; bh=Df7pEUDLJA
	wKwwtTNnvRResUlBw4uoJaDcAlPMKrPVM=; b=orYE+WsYZdIHeOnBtXaacrxFt6
	bAbs77OLyIYnCRAI6kHLE+LlzHU9gJinIoTjy8yq3YZV9C5/x9uy2hN24UtHh0wU
	0wCU3TSSduk8OQ9L8mEUVLK+0IwCNgNBKp3qnTtil/FTPCJWjnURsstxfUQyifno
	Lsxhe8UC8TdCLo0pGxIjPiR/ZNN1VjJfS+SfBC4gzymKy983Y+QGQ33E+oDFVZjy
	IbYWj5sZ6GRvh4gDLCDgyUWNyb0TgaIEq+XGXeA/a0ywVEqtIU5zovyWkKI4luHt
	9YPPNVuC1Nx/6SLCRjvExKl4zfEzteZVqtSMS7fF4hyxCZRKYkU/YY484t0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739385603; x=1739472003; bh=Df7pEUDLJAwKwwtTNnvRResUlBw4uoJaDcA
	lPMKrPVM=; b=iC/37NNCJH70IE/ZevdfDomh4phqPYCk53LygNvsfDR9cn0Cmh0
	LBdbxAbx28GrvM1WF0tKaiKFUP1ry+tGs+D/orKwhOgyLDBDuy/ETx3+BKYc3TXF
	cUcW6OVzh1xw4DBlwHnz8+SeLtNxZ0tKEivyU+NMxSqrhjAxHcBDCXraStZnVNYx
	U54fbD9s3e3g/OMNMUTD6nGd0Cn00e3zCdej/OW5bAsnLZGn76ze7vpLbKqmO8wO
	lwATNNvo+d7T8Hn5kYL8oG9UzXPXmOxrIkdW1aqHFUcM+aW/FypgAbZ/onlhIHV4
	w2zVpFHMJjvICWsFBpD0QtHEYgGB6vEwOJQ==
X-ME-Sender: <xms:A-usZ3cZXcykzlVnuIyZp_sp368KZd0-V3rzd69MRSDdGJdh4AhUQQ>
    <xme:A-usZ9PdLpzDEiSdLdSTSvAX7kfouxVtd10L-Xh8H9nio7Qbuw8sIBzD_AH-bqN7s
    CiFp21zlIlBC6G5vA>
X-ME-Received: <xmr:A-usZwhdJAuVnUnStauFBJHgKcZNFpDhoWLpBEFQ0dQBAFLywHTKlCl0G9_L5YWcBKspMd1rxVaebqyAU2h89OKehtTifnZxcEjVJ_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:A-usZ484VGIJoJM1LY9czG1ZivCjJMcFtE8cJuoBGBBIQqftYN3ULQ>
    <xmx:A-usZztTxOpoz1Cdr0LBjeycS6taq7CKihNq_L2Cw-X6rX8ggqoBsg>
    <xmx:A-usZ3EOqb2C96cAk83hCQAFe_xdS4yGdjbsh3rWWIPXYd7NmVtPhQ>
    <xmx:A-usZ6M9vmTZA6-V5uZSdDclnsw0jCZF-eIvdNekn2Uys04g45Br6Q>
    <xmx:A-usZ9K9Tp8kxelGW1YgXWNjMKlQYV00h4apLdLrT8l4p2BFC3PIL45m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 13:40:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Lucas Oshiro <lucasseikioshiro@gmail.com>, ps@pks.im 
Subject: Re: [GSoC][PATCH v2] t7603: replace test -f by test_path_is_file
In-Reply-To: <xmqqy0ybt4xi.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	12 Feb 2025 10:04:57 -0800")
References: <20250212172909.21257-1-lucasseikioshiro@gmail.com>
	<xmqqy0ybt4xi.fsf@gitster.g>
Date: Wed, 12 Feb 2025 10:40:01 -0800
Message-ID: <xmqqr043t3b2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> You can check what happened to your patch by observing
> https://git.kernel.org/pub/scm/git/git.git/log/?h=seen and
> https://git.kernel.org/pub/scm/git/git.git/log/?h=next; other
> hosting sites may have similar lists, but I find the one at k.org
> the handiest to view.

And according to the latter, the topic has been in 'next' already
with yesterday's pushout.

I updated the 'next' again this morning, by the way.

Thanks.

