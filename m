Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B1A20D500
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905996; cv=none; b=gPi9CtnKmGlcDrk6H1KeqZnCs6ec7p/HZD0y7+T1LxBOO/JSs33C/duJ1rG13z3hG5pz9u6ajDRCn8O2P9WeVtouK+GY+1JwlOXJ0A2ijgGLPx8hbIMh+xFund8LhBjm++NodkpbDljKxalPfNHcPAaAlXl98qMVInuOAJP6i+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905996; c=relaxed/simple;
	bh=LDIaxCQDq12aCChlgloT3bgrL7ynZb4stPZCVF9ui4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DWIuaDobmAsLZZZY0NdUYLnelzCfd1lLZeWH5QtKyz6wzwPSPjL4dljQFmxl3vGFMsb0istTqWCA99k2Aan2/VZym7mhXMZwZ4wDwUAbVfI2muSsm3/nSC+peItLRToD6coTdYfVvninhx/0JRojBzzIFYdplssOZrHkrhjW7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oc/8PgSL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=inQ16daa; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oc/8PgSL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="inQ16daa"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5496F1400536;
	Wed, 30 Jul 2025 16:06:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 30 Jul 2025 16:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753905993;
	 x=1753992393; bh=LDIaxCQDq12aCChlgloT3bgrL7ynZb4stPZCVF9ui4c=; b=
	Oc/8PgSLEThlIA4uaw0J6H6ydFw3IyE5aEUHKl55Ke6DNCmVR/PTupIRYFexFGKg
	qMnbKL6LVf8tSaCFd7v/78q1jS9WBXCXWFz6w/DSpWJCaxTbCVJeat4xlikj63JA
	7O5aoWWIT7rjWfIXEgEx0XXMs6PnM4nD834zueHhja8CwY/yem77QLxI40bEAT/O
	8uNS3xTPxVrCSDP80veORRYG9n7tLEMAIhyp9Jh+XFLqJhb2ZIjHY3UMOQ9QkHdV
	yZZT6n2mfC0DOshtsPak5/wvzlAXgkB8xgR3fcL3r7v5OEXDs/MxU8OVp8yHlduG
	5YX6TTRCopm4Vnxpg15aBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753905993; x=
	1753992393; bh=LDIaxCQDq12aCChlgloT3bgrL7ynZb4stPZCVF9ui4c=; b=i
	nQ16daaROo+yUAWaDFHef6ES/vmXLqifAf45BH8LzCwz+DykewyCMRZfG0DQQw4m
	kDwZqqhhug2w5iyRlcKJy4jDsFBl6+qRlpsFiqZyhnnbSlUxnsyBWnT7eujZK5iz
	WaDhJnyAJm3Pvri7MvvYqcXBnBWWVATY2QbDHgFMlVixYVLQ23uwjStIifHQUb1Y
	aPRWe83NCCMxNqPtF3jhkXmbJsuOBvVLHMltQy1UELJbzei60yKseWNGWbynVCnN
	WwhqK3sYJkuQV6KFMeoeAi/G1j3OP4Hq6NEDd0CYBz5ex4b3iz9gIs9SzkXQjEzI
	g+vJnEunxf0coZCVDhZRQ==
X-ME-Sender: <xms:SXuKaEutrgrWOvri0k5gSiUcygksPr8wvGx7j0kVrv340n92DoaNLg>
    <xme:SXuKaPAGeTK1_zDiLUlzY1AGPSeiak86hbHaJVPDvRFE69dvuMdG14QmmuKPal5t4
    QAB3QT2URoVpRniHA>
X-ME-Received: <xmr:SXuKaGMCs00H7e9FlNUM0stXMBJB_SmUwoaojFv2Ou-fSLfXolWHmul1ZDex6Esozz64KLcaZmyTCZJxs61XyWtjXs0LH3QNu8Lk6Mo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhgffffkgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieehudehleevveetgfeugeeutdeuudeigefhgeeuhfeviefhvdevkedufedv
    ffejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheithes
    khgusghgrdhorhhgpdhrtghpthhtohepmhhlvghvvggurghhlhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:SXuKaIzKVT4MZrr9BnJnYUQvahcuuUX20c21SB6jutKRBkewZDxyMA>
    <xmx:SXuKaGVl3hGnGJZDntYmmU90sqos0MMnm3W6u2TCAwYcTZluTzuOiA>
    <xmx:SXuKaKNFwO0cR3JuPv_1s8wS07-X1dim6hao59xTbUHbJqnk_49A5w>
    <xmx:SXuKaIATGxQ0eB-AonHvyog5RwltsVrxOHS1wn88fXJaNG-NrmdhWw>
    <xmx:SXuKaJiXEUzKwbH9XxHqy0c316jvdDQveSsDMqGedR6RJznQ06gN5nhq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 16:06:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Mark Levedahl
 <mlevedahl@gmail.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/5] git-gui: workaround deprecation of Tcl/TK 8.5 in macOS
In-Reply-To: <20250730164052.15371-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 30 Jul 2025 09:40:47 -0700")
References: <20250730164052.15371-1-carenas@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 30 Jul 2025 13:06:31 -0700
Message-ID: <xmqqtt2tl9yw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> This series, add improvements to allow running `git-gui` in macOS, which is
> stuck in an ancient version of Tcl/TK that is no longer supported by git.

A naïve question.

Just like Git is a third-party software from macOS's point of view,
wouldn't Tcl/Tk be equally a third-party software, or is it more
ingrained to the base operation system offering for some reason?

The reason why I ask this question is because I do not see how it
would make it a lot more hassle having to upgrade the version of
tcl/tk on their macOS machine than having to upgrade the Git to the
version that ships with this change, from an end-user's point of
view.

