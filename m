Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A332DA765
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816466; cv=none; b=pBYfWP+nd3Nr63TFEj/zSGKvY/VTLcuSvil7TJWusp37S56uAxThT8aai1pZEQ0NcipA8FVKdxYqHTP47qPw70WmU5nstz8x8IrqMVfIUVGVEvnjtOPn4YcG8s3+VJf01fL6G405p9myffXAGwRfAcEpm4sAm2eH6peSgevIyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816466; c=relaxed/simple;
	bh=FJBYdjBeuUprKDKMoirOaHtEWHCqy+hRRNk1iSFICds=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HtNIbwIZniMyE31mxGtIs8Q/KBFp5+9lXjCYmFy0jxi/7DQEqjx1Kw/vWBIYipaUJ20hUO/XELfoP2bpIQ9LlyVdLZi4bgKpPMKAYtsQsTg7QLWjIZaRGKKSm4TwcG8Po/n76KnkrTlJ1v1MxjPwdVXFKdzw8Q/7Ws08LPthNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lk98e42E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O1KUM4PN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lk98e42E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1KUM4PN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B52B2114016F;
	Fri, 13 Jun 2025 08:07:42 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 13 Jun 2025 08:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749816462;
	 x=1749902862; bh=GuAfWw8QwYaEe06R5i6g+RB1J/TFgRf6hCcdZSXHT5I=; b=
	lk98e42EF/UT8cutsJ2HWsLboM2URUrmqMNigUeJ6NEvc6Q7XAXx5VnMdV+0SmKY
	+ZkzyxOXLjs4OhIWptQGgj/4TmYCoRcktVyizt2dAKqH9w7maNRp58NQZbOpyyCL
	JAsA7OLXi6GkcvRAFz0HkMcNdTVWIjNfdHI+Kp7CCfgyj0cr/whDy+ztaJJHI8S1
	8Zs8VQao7MNfcGDX80EFxg3bOA7HsUdoKuBBen91o/1lhCLbE6RtQ0riCU890kzG
	nLPyulsMZEuE46z42LzzP3ljSdeiOLpAL03fduPGgvXwi+iuAGdO68C7NqDJ//oZ
	UtU8HSZ8qcymOy1ByquRRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1749816462; x=1749902862; bh=G
	uAfWw8QwYaEe06R5i6g+RB1J/TFgRf6hCcdZSXHT5I=; b=O1KUM4PNzcNEfdsZ2
	6iEJB2n8moyfZCmZ88Qbks37xIlHpZxDiF9uL6Ee5dRDBLRScv3Do/FPTDN8+GhD
	+WWX7vvxrbZPvYOKyCRRH8Hug+YfIwyWIai4zJQ7k2iVBQkZxI1d8zT7Yyi1Rbtf
	xKnnpo3KxSQ/qNpr9D22x0iwufSIXpcpNJEP+4JPdFl0DMbfAvQaB2cskw+WdACd
	xMfrfRf888ptuckm0IO1iEv7I1lgDiztm/W6mfu28cBZ+cFXag7//0UJAmwzTKGK
	O6ZPNLDSxKpLmPdocX0ZJ41GcDw6EFG4hPS4BHpA3QYPmWrYNZTUKpOhdCDCvLNq
	cAEjA==
X-ME-Sender: <xms:jhRMaMqge9khQ4KET7g6xmXuKSelCP5i_ukI0FsfyawFhfoH1W0wKeg>
    <xme:jhRMaCoOR1rVgqidGUowCwgXA7hQF9CqrjcFyw-BPwDf7voFFh0vSUNKaUswsDA-q
    ciClsGTFUYVVtf2ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeghfffteetledu
    veehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jhRMaBMcE7l-4SjTd6Csz-0ToT-iqVJwtO0IgZB6jSSKjDj31bZrZQ>
    <xmx:jhRMaD5yw5izHY_S6EqDq6LVFV44LjUrppdrWQvnfFGpof5GumuYcQ>
    <xmx:jhRMaL4cR_VW2y2Mur57q1LR4haqvE2FGXOAdH_bp5sgijzy9F59iA>
    <xmx:jhRMaDiNKBfLoPGzdO7uVZjW9wTp8Jhwa4t6sNGkIP8BTOM06FrNlw>
    <xmx:jhRMaMQulkGDhy-4y57luhD35Vqdd6DYBIJx1JTKMkuvGmRwxJRjPSWe>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7BB011EA0064; Fri, 13 Jun 2025 08:07:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tce9fade22d335609
Date: Fri, 13 Jun 2025 14:07:10 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <857ea4d4-2252-4d46-9f93-e78e9450bb8c@app.fastmail.com>
In-Reply-To: <20250612222537.2426059-2-gitster@pobox.com>
References: <20250612222537.2426059-1-gitster@pobox.com>
 <20250612222537.2426059-2-gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] merge/pull: --compact-summary
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jun 13, 2025, at 00:25, Junio C Hamano wrote:
>  static struct option builtin_merge_options[] = {
>  	OPT_SET_INT('n', NULL, &show_diffstat,
>  		N_("do not show a diffstat at the end of the merge"), 0),
>  	OPT_BOOL(0, "stat", &show_diffstat,
>  		N_("show a diffstat at the end of the merge")),
>  	OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
> +	OPT_CALLBACK_F(0, "compact-summary", &show_diffstat, N_("compact-summary"),
> +		       N_("show a compactstat at the end of the merge"),
> +		       PARSE_OPT_NOARG,
> +		       option_parse_compact_summary),

`compactstat` is very dense.  s/compactstat/compact stat/ ?
