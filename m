Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049EE3176F5
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446265; cv=none; b=ZYwrmUG4mRvl/eBQIcnRqhRkBRZJ01TG/CpRG8o+nGCQXFW1eN8S7vVtxLEJo6M006zqSBHZpRwxtwy0oQfvnwGBFQQYRGdxW6ChkH5PF7B2S+q30bmcyuvsWUIbM8TMd0+ZgIWpZQxAGbLNcHFhkVHIvE1EQyICBXXkEa80lto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446265; c=relaxed/simple;
	bh=37IOHU+1PjxPDhd61cPY6RZkeVqBzdYaIIj/rP07LGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iQ3y1DuRHZxTjQNMv1GTGyNtQ8OfWu6ekKJlDVxOKJ0g/VEtMFWs/DGk7gn82mztNzbR2piTi75KWUi0uKrR0LirCVOiKrYAwH407A8DwJWhaQIjPjrtFypwRlds/fqDqIlDZOeZdyxA6QXwVldgU8ViIfpeG95AjvddLW7eUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CRd7uivg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LjyfE73H; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CRd7uivg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LjyfE73H"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0CA31400042;
	Sun, 17 Aug 2025 11:57:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 17 Aug 2025 11:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755446261;
	 x=1755532661; bh=Nd/FH8DfftRqpKeNUAyOg+oseAFGz5SWctAplNjHbAY=; b=
	CRd7uivg/FJYONteeo4YpzZkk9tnNYKSA5mDiLgyCH8jf2N8a/MKGLemsYKAh5Es
	ydYnvSv1FssOUJeIKw6j+FZ9oS2A6WAg5FiTQprKLWYNf0chFDHWsqdW9iZUbG2w
	S7dsLd6SkpRMuOJyDPkJ9F80mdItMvqbFTt+gp4DKtuPz8iyoHZFrwy1TpCzpkG6
	SnMbrQtR1uxXSEB5kdWp5i+eyvA7jNLmuoGL4STMrOikfqGflFqW4ENG4DqVPtHm
	RmE6L0ydYiKeplWEEy8mZSHeJc1T7TaYrXJZx9DTqmVIA+OJisi3pXrKJ1KNcUET
	mLGYV8bys5Aj96jRDfCGQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755446261; x=
	1755532661; bh=Nd/FH8DfftRqpKeNUAyOg+oseAFGz5SWctAplNjHbAY=; b=L
	jyfE73HhlXiSRDtABCU+HLJuWC0oql393YjFSTTgKvtL6EeAk/6dQItWWKH7m2BQ
	kCQ9or1y9hZVgyoLdgdWRzBuRBiKRDkMxZ49CITYFqeZTeqdon3oYDZXAx8HnTxL
	1eYV+yAu+3p1nJtPgnSolEgtFRcdJoYGGBJri7kT4mbeT+0SBfOIS4nv3DnTYIEW
	59hKirTWTxz91wNRbsaoibObpXZBybwZGTJ1Mukp/NQPIaSTWQYBouiKcN7HE+X2
	vPzetNqDOjn1iGQazDV4Rhw5t9Vt98ablnzGQvFrZDvSZcVhWgyGE8pTKvyzIDyT
	Jl5JB4QI8YmAgYsFqhKFA==
X-ME-Sender: <xms:9PuhaPhSCwMxw6fRnjHjFjy3YVMI180eK5VVnOBFCac3jB0VepjVxQ>
    <xme:9PuhaBhDnE8SXWOsigp3cY4OzalxpQGDtSL5zLaIcQTF4aGF2d7fBzJ5qvvwYMqd6
    a49f4iVv9XI308TkA>
X-ME-Received: <xmr:9PuhaHa4ClaQXwYG-DGCDlvMGDYkzIIW16apecrXffysUhAGrG8Sxf4ajGjXcXnNRvCyn6MTgczRrdQgFtAAqDkWe5zpix_0NumcXH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhhrgduleelfeeslhhivhgvrdguvgdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvg
    hnthhoohdrohhrgh
X-ME-Proxy: <xmx:9PuhaKVNyUDSgJW-9Y4CE1-cDjgyWx5XO2yxBUXcT9Bc_H3s0IFtHA>
    <xmx:9PuhaOgDix_KfLlHrD5lI2hmliXaY3Ra5V0J7AnT2FpMVYkyfQuKNA>
    <xmx:9PuhaFkjOTOEwNjhGcxALrzx_Dw5oqbLKo962BShwOUXJLbHndJ5AQ>
    <xmx:9PuhaHxgBf67ctDEB9A1WKcqgzu-Dn6l3D5xIgS9YpbwIxb5PpKL3A>
    <xmx:9fuhaFgKVi05JTHWpU1idp4lVt_P85-QFIhGBYB_EMHO2UmBUER1mRQd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Aug 2025 11:57:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Taylor Blau <me@ttaylorr.com>,
  Christian Brabandt <cb@256bit.org>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,
  "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Sam James
 <sam@gentoo.org>,  Collin Funk <collin.funk1@gmail.com>,  Mike Hommey
 <mh@glandium.org>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 09/17] Do support Windows again after requiring Rust
In-Reply-To: <DB9P250MB0692F39EA259A4B31845C6B2A537A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
	("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Sat, 16 Aug 2025
 10:53:59 +0200")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<96041a10d545e0e431d05b93544771c6bdfc06f1.1755220973.git.gitgitgadget@gmail.com>
	<DB9P250MB0692900F30A3E71E4F01DFFFA534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
	<xmqq349sntms.fsf@gitster.g>
	<DB9P250MB0692F39EA259A4B31845C6B2A537A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Date: Sun, 17 Aug 2025 08:57:38 -0700
Message-ID: <xmqqjz32kkjx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Matthias Aßhauer <mha1993@live.de> writes:

>> It seems that Dscho did not respond on the list to your initial
>> objection in the discussion you cited.
>
> He didn't, but from various interactions surrounding Git for Windows,
> I do think he's currently in favour of keeping Windows 8.1 supported
> in Git for Windows.

OK, as long as folks with stakes in Git for Windows are in
agreement, I have no problem (except that in principle we should
avoid doing disservice to the end user population by doing things
that encourage their prolonged use of out-of-security-support
platforms).

> We don't do that in git.git, no. Git for Windows very explicitly
> spells out which versions of Windows are supported (though usually we
> just mention the Desktop versions and imply the corresponding Windows
> Server versions).

Yup, thanks for clarifying it to me.  Could you do the same for
future readers of the updated version of the commit 09/17 by telling
the author about that in your review comment, so that the log
message can talk about the reasons why a specific CARGO_BUILD_TARGET
was chosen (e.g. "as described in Git for Windows documentation at
$URL, we support Windows versions X or newer, so we use this cargo
build target to ensure we still work with that version").

> I'm not completely opposed, but I do think it should be a concious
> decision and not an unintended side effect of some change that our CI
> didn't catch.

Oh, absolutely.

Thanks for clarification.
