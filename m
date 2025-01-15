Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73C35968
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904497; cv=none; b=iqP2qksFRBlfnmBCAJwVmAPiROB1Dc5e9lWwXsTILYlZx15yxmSmtXv6X/0EP/L9dc58qT5PXQ1NgKVFhWshz5M8mhf8ZaKpTGciNOhPIpjG83sSeoIDqbzSzdfJam8rT32J4iCy0twNTARp7A9GhxaOkKmgn4iZwj6cjKuPItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904497; c=relaxed/simple;
	bh=8i9HvM42eqHjU5ZdDbOUMwhnLv92KpgqNpgFcXo1phY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTq/lBT69cTgqdMXAG0iEawBaYU2bDgJte4fmKAie8JXarH4w7kMtuavXoF03i471tqJY1e9WloYbM+feKuCjnCUUQ6LbYwrq6t4V4OQCRU6JeyGIfS+PQaSYNAqUj+jicRkVr/+JQZcIb9VD6DOWugp5aEt9nNMMxOizXs7jLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tiYoPdAI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iifPbUyL; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tiYoPdAI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iifPbUyL"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7BC2A1140137;
	Tue, 14 Jan 2025 20:28:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 20:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736904494; x=1736990894; bh=pVqRGDpnne
	rE4hpKQPw6XGp7D/HVRYMGUHbIxjQ20Cc=; b=tiYoPdAIUZrFr+wBv0dKMOVFLK
	bhWbafJ9YSJVbtVZCagXQkJocA/3u4IJ7wZFKBDdrPwP8k45XWIYqDpF3rxIi+zA
	faQRDFSswKYA3nQxG/aajHo7hvX1+Hqsrpvp6iZog4EobtS1JO6AI8+tzmLsGjdF
	wu5fGkGLppLktT+nmlTy46dhDSPr8kzkd10FYI6IhWMzv+4iw7nn0PvZQ35Gv3lL
	9+MX9QTUoe0zpb4TYr2U4UryKtIvF8wybnHS3VDBZnz0yyDCam9835Uh/fj9JzR6
	CPaTywvkl0P0sl0yI6GVytTIobnds1C8/WOIonhX5ZJuBuynwjngJ/DE0K5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736904494; x=1736990894; bh=pVqRGDpnnerE4hpKQPw6XGp7D/HVRYMGUHb
	IxjQ20Cc=; b=iifPbUyL49T9FMcCxM+t3/7y/8pKtnKJw3z4PMxr7DnlweMrQdg
	hQPZlNtpCSoE5/H2/0kJKSK0oCdlBGF9TNNG14wZw0x2zCUQeoF6a2VJ8UDUmzn4
	IFgDMSC9wFdVGTAcrI8TvbBYPa2bfpd3UjEUl0iiKhemp2VtINJ7tu5f32pC+Ohj
	fL859eESbfT/1z2jxn2MuS4Ppvzsq51A6fISbGcXfmrKC2WT7Uh/rr+lOAVHrZgl
	Y4xZzPPiLUdwnOybB2Z4JBEj5hlsoDxJVC96vG7xdM1VTxB4x4nQh3ifnTfFEgl6
	A3qPlQ+1SeiF1Txc4+cmNdbrgMm+pLJiaYg==
X-ME-Sender: <xms:Lg-HZxJpQq9_8Fm1LQzaMBSRQJ7Eg79_z828KCPCl5UAqBThHvE42A>
    <xme:Lg-HZ9IEOwodlkonuhbHZejpSySDIIH0H_zaTMBb549N3ghosdCnWDbsKhzsP4heo
    SZiYoJ3_0Z-fkhbnw>
X-ME-Received: <xmr:Lg-HZ5sRbuZ2pT9Y7pIozFUSIFX0wHfnxz-teudZzExJvSfXqFkUsNwYyNQiJ916d-RRY41GFdby0J1TNyvnmA_b5Yo107N4em1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehjedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithdq
    phgrtghkrghgvghrshesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Lg-HZyYtdup2hkYOfVkjGqwcf370DWGJpp2Ht5u6z4JcvjeoB3vG5g>
    <xmx:Lg-HZ4YhLdDb-w5TdvFJJ4BqtBRXOMoThR_NYc5my0-w2nJwG3hktw>
    <xmx:Lg-HZ2BGxMv9qCgmrXYhzk9wOqjrJtXJDCEeacEkEknwpZRXrsxkXA>
    <xmx:Lg-HZ2bI6azeZuwgVSixL_-sjjSq959pp1MLqUcksHYI6wTNRPvybQ>
    <xmx:Lg-HZ3z1NA-9HUZRsSGVdEvkCjL86hSQ3o4mmnoKxyakFWcfFXNlHjd->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 20:28:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
  <git@vger.kernel.org>,  <git-packagers@googlegroups.com>
Subject: Re: [ANNOUNCE] Git v2.48.1 and friends
In-Reply-To: <045701db66da$36a358a0$a3ea09e0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 14 Jan 2025 18:15:28
	-0500")
References: <xmqq5xmh46oc.fsf@gitster.g>
	<4a3c949a-416f-734d-f63b-cb1b7f9b362f@gmx.de>
	<041901db66b7$c0c759a0$42560ce0$@nexbridge.com>
	<41d5de4e-c4b5-9564-6210-d9b8efddacb7@gmx.de>
	<045701db66da$36a358a0$a3ea09e0$@nexbridge.com>
Date: Tue, 14 Jan 2025 17:28:12 -0800
Message-ID: <xmqqo70827df.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> I will not be able to package this. The reason is that only official commits
> are
> permitted in the highly regulated customer base that I have to support.

Well, you probably want to be a bit more careful.

Think what *exactly* is *this* in "package this" in your message,
for example.

Will it be the resulting checkout of "git clone --single" of that
tag?  Then you can go there and say "make", and as Dscho explained,
what Dscho wrote in DEF_VER does not matter.  The tag that points at
that checked out commit is v2.47.2 and that is what resulting "git
version" would say.

Will it be the tarball extract from the git-2.47.2.tar.gz that is
available at https://www.kernel.org/pub/software/scm/git/?  Then you
can go there and say "make", and what Dscho wrote in DEF_VER does
not matter, either, because the official tarball contains the
'version' file that says "2.47.2" and that is the version used by
the resulting "git version".

