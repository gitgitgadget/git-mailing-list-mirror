Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3D38757C
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388866; cv=none; b=lrJBsGd0xg28bdoj7uyujYRTSM8/hLFEAfWphs2Da4NzovpY9hhmfAXIVTr8lXzt73E+P5vxfSqMJJ/K1lup/Od/ukxvLZ3fypuhtz4CMGwYeJTKsl9/4/rzdBUzrY+A9N/29gOobn944m2ds67Cpl6AS/kZ9woiYDuKdPK2N+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388866; c=relaxed/simple;
	bh=K/0KePRruqJax8Sn9/2e7rClOLIQ69zoRm8AGJVG9Gc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GzS2GR6KOCfw9BBo7wfJdluhoM88EdAzr1AcS6s8vcKVz4AEt1ldXCAJu8S975cntcsZcVD8roOuRvGdtpgLQPQ1xSH76WvKUsZNg0ON04H9yGYcOc2BDgVx8Nc26YrahfRVbaczow/l0IOytEPZao3bVg8oFFGrpD18GhHvUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ww/ca57Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cE6yCNyP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ww/ca57Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cE6yCNyP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 384A5EC06B9;
	Tue,  2 Jun 2026 04:27:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 04:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780388864; x=1780475264; bh=K/0KePRruq
	Jax8Sn9/2e7rClOLIQ69zoRm8AGJVG9Gc=; b=Ww/ca57YebkKOA83im6eAKG+lW
	iJfNSD0l1ieDbxKAsOMFKJzsMP5FzHoyLQe53m3U3tA0ekdORWOgCNPmr8Wvr5D7
	5ETNkmvnSATA8jGIy0t+toYhQKSD7fW9Z1junhqfHPiIWqNWsXn8mc36kC9X4lPn
	/YzmAvpOeJnzff7oH9eEum4ErxS0fEnR5Rai9+GJDilhS0NDRZV8S2BISVz8luWW
	1puteFAq9pAk3DvhspKVKdbYvVF/YXy8HznTFPidWao0exjuur3lR/guzUuaQpOS
	jsgKcIbsCbeAYi8fVJ07edaL0v1WhTzIKbU74e1Vz0vtQ1B7DlVIaBprCKsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780388864; x=1780475264; bh=K/0KePRruqJax8Sn9/2e7rClOLIQ69zoRm8
	AGJVG9Gc=; b=cE6yCNyP5/ZmG+ZXsiDjhPgRyPBJ38s4KxpzHxiycvFnEq9dM5E
	8J5EloIQD3fehjPZL0ZMv7Jqlzn4ucZF/CLnSrYHztY+hGtUmNQqwu890uJWT7Bq
	j1dDIYSoW6Kxk56GalYFC+L60eXcrHqJMJ5zymd47w/hiErD4UMhasAgyFUtp/OP
	KRo8dLWWbtrZXHhmQ8Zu4yhSMi4KKWHYwS5v+HcnbRy4eKT7OYT5fp8ZA1JzQOKZ
	vVxlA5a7zX6XcEi/oMKK25FkJG9ATPTKuX6eKr81oV8wOkUlrYGMWxtRxFmXUUSX
	PjDBzWef6CHEYBU3sdm+DnAc0FGnHI1Db6Q==
X-ME-Sender: <xms:_5MeajeN81xe9XlrdSfONeGKwf0ZDTqBDay7rb68qr6IPQkHQ4v2cg>
    <xme:_5Meaqu058rPVco9yBFJRi5kAKLbBb-MO3Q1HB809F37GZQ2gd8TWQlXy7uPTY3M1
    ECO09A5uzGMLxmYxJupnxw7o2cL7fh2zEtz0lMfMM2Msi7kFp3oqg>
X-ME-Received: <xmr:_5MeaslLs52At9OKBB65wGDxiXb14mJMKVw4MRMhaCWttgePUDQbMDZvOt0jg1f_9O9Tw_CshAmokF52igAEVAihNXZIC-QrXh-R>
X-ME-Proxy-Cause: dmFkZTECfMDUMzuViaeCn+L4XAmtojzT4DVET9jwSZ3EP5xCL9q6Y17Oe58aAtde7Q5iZ2
    5oSCG7ma383fiAzlHm1iHWFyEkGtoU+hz6PI9KnoI+YG0TrNK8ozaqgMRUx3REeWdugOBz
    WrTHFa8ApmPC93qA1b4u3U85QltfJ4v4nQuO6l/x8lh9f6KnfMATEHzoUDVhiepjixi1l2
    mP1syIJr+VWvWfFGORy8+dFl6PLX1ogfCiGqCKK1bG7L1/rsxPHsfuQfxvj6doeS2jLloj
    aexgd9uUGfTq+RoC2N0WKQQ2w3aU235+X7f9oGzoANpZ60so/SU8jgDK2SI+TqeEmnaxJH
    tfNmIjDxADKNJl5atiDcp8ngteIIuuEFrUsn61EFUyS+wREUxCU9hKG5S4BdiY8Y6N0svP
    xakzUpG84FoK1fHZSowbnZ01NwlprBhD5KyOI1kU0CX2/vK1swFSeUHGEZ2HayAAOtOS8X
    xAC/chCGsJTt0g3i+0tuuTyzjcSto+sdcS3pbLZxleJGeXwFNvT/TzABKoLOlh4q8+5Ys2
    NXaMQgk1ZCKWP6fAnFXlImoYYzlwYTU1G8iPDRwmF+YgGnNZ7NSARDR5dopHEnDGwyp6UZ
    Vp87yIONNnRqYQG9z5//qGZgVJiCOgtRyLqk8Mtt5OCWq8tFvv+4W69lAfeg
X-ME-Proxy: <xmx:_5Meakw0tmqrQydEocIq7rQef3_UGQtWHDZA2va1cZDt-YpY4cEZhA>
    <xmx:_5MeamPU2ZYGpctqbz9Spaca9oIYzRHuKaR_ImtiQfInDOBtmG39IA>
    <xmx:_5MeaoqhRYwyZH1o42BJnqu1NVPbKspj-0Z3p7jb5Z9cYbBL0fNCPQ>
    <xmx:_5MeanEewyhsKo3ItQrdJw33G6m0-ybkRYoSemT9ekBo415aqLJSvA>
    <xmx:AJQearwBIXidOGfy8WPmxD3ieZP-0Ftb-daMBTpqs-3WznErmNqN80Ty>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 04:27:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
In-Reply-To: <ah58IJ8DgSZYRjMM@pks.im> (Patrick Steinhardt's message of "Tue,
	2 Jun 2026 08:45:52 +0200")
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
	<20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
	<276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
	<ah12uk7IFxS92OR1@pks.im>
	<042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
	<ah2VL-ftCQelNoOc@pks.im>
	<2e266786-4ccd-4300-9b53-6f13fbaa2933@app.fastmail.com>
	<xmqqcxy93nph.fsf@gitster.g> <ah58IJ8DgSZYRjMM@pks.im>
Date: Tue, 02 Jun 2026 17:27:41 +0900
Message-ID: <xmqqv7c1xs76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I wouldn't mind that outcome much, either. What triggered this series is
> that I'm always annoyed that it's "builtin/init-db.c" instead of
> "builtin/init.c", and the same for `cmd_init_db()`. But I intentionally
> constructed the series in a way that the first commit can be picked
> as-is, so that we can adjust our code to the modern world while not
> doing the deprecation dance.
>
> So I'd be equally happy if we just drop the second commit in this
> series.

I'd actually find myself annoyed by such a rename when looking for
builtin/init-db.c only to find it gone---much like how a previous
rename made ll-merge difficult to locate.

My point is that while static names may annoy some, renaming them
does not resolve the annoyance; it merely shifts it to someone else.

So, if the primary motivation is just the first patch, I would be
less inclined to support this series.
