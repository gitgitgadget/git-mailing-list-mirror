Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C4153598
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886634; cv=none; b=syX0aQNjzuFvZtQRk3yAznyM4PP+Pfb2dNz+bMe0XHFzKObqaoII9drQp2j35tQyjBeGzjh1u4j0z735PQf2szHnSocTLPvitcoML/Ua03Q/3V81f7sV6lvQEzuZSBe/7pq3iCd9sf30yLeGZT5xx5JT/Iv5P+U5LlvWYlLJ/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886634; c=relaxed/simple;
	bh=cBzrlW6Lmii+JyM+225WMGg0wr0OzB9UwQV7b4o8FiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HOQfBoTLqDZj78t6izennzWw+lCIlnzcfXngcSl+qBKPvXDTXWPgqmINbttiphWUIL3QQk6RB7EUFEy4ZlnhN0gkcXB5SDooih+nhRHYe9soe/dn+1pe4VG8WJGJyAkuNIvY6XR7o64lZfBmS87cWaOxLa8IPnZ70yrXb2wOQYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bFM/1YXN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FeRYpsFo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bFM/1YXN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FeRYpsFo"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A71C1381127;
	Thu, 13 Mar 2025 13:23:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 13 Mar 2025 13:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741886632; x=1741973032; bh=bYSx9MYLjz
	fs/YoRCrP2PWxk5JDszsnBhmk4Ce2sXWs=; b=bFM/1YXNQtD2nFPiV5JLXNe0gH
	ENsPHJk6yj2v0ezu/FZI3kCcBNEpZS7Quo1EfDAqI2r0xhlx9ReNFLicrvzrF18A
	60fk6qD05OP9bmVRzbOhItOIUty73EJ5mFqOoP3ASUpHunH+2FYuEtHVzt+lPdqf
	MCfmFM/OlwmQfv31rpS2KsDHaTqccLiCZ1i95Kz0qsuWzuCUL4AqtdmtZcBlHD93
	eTz7yvF93iV4Nv3mDnFWHc3G6agmu32goQnjC5v7UlbyN59udc9ccSog1fJb4xQV
	5YdpuE+xdlT0B4FoLKdTP5L31mHdVXJ4YFViH+WSYrtDDh71F7TYPbQFMbWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741886632; x=1741973032; bh=bYSx9MYLjzfs/YoRCrP2PWxk5JDszsnBhmk
	4Ce2sXWs=; b=FeRYpsFoI6cVGmHwqbEfp7Im6QnQGYvQSc8xhOra8Un7ZEjb40P
	XSEGJKhpYYCCk71UTUf9zl1TSUHmra8ShyAwBNnzXJekVQD2hes9yC6vCoAXxl07
	RSgK+6jtE/XGmpTTGD9j/44hRJD1+blB0KknzT7f9H12XJmWLdqUfapAz2lTQJGF
	92myegaX5m6SLv2Ho+i4rJEY2E9aIWb053T04W8p4rOWTGBOZiU9Ip5OmeDY1emt
	nt5u39pJSl0mqAcKF85TzXWj9yyAb0U2JFLwhY/3pcRUAnbKbNIAfJ93PYwUmk9m
	iHyznL7fmOHk7cqg6WK6UB/253hI3QC31lQ==
X-ME-Sender: <xms:pxTTZ9J9N7svkr6MiajP_U6YwLPWyh5x8nSpNMe1gA57wDtO0-Jm6g>
    <xme:pxTTZ5JaOfOq1QvyAp70aEzh-pyNNvqZfDiyPWu4AxeRcdohHtvbwjIH3rdzCycR-
    BnaNnwwU9u_WaxyjA>
X-ME-Received: <xmr:pxTTZ1sUwygHPESiZP-PA-x8h9lj6zKT3iYr8Y1IxBkClnx9OK0Q2P8cqiY32MUXc4BMMHoxQJznamSAJOpPLar7AZaMnQKXbmgJOX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:pxTTZ-bYIJKb--6OG8FWZZExu-0jQqGxObNqKLPadCVGaYuKzE72lQ>
    <xmx:pxTTZ0bCJl-kCTAmOPqiy275j7F6ZUrlwv88cEljjr8M3Fq01Co_-g>
    <xmx:pxTTZyA4eqPFosu9aIfG8WEZxrkvPggAkSSbRJV2_rM1mDAtyNHk3Q>
    <xmx:pxTTZyY3lFnx31NM-9ufg41U0RqAGzU5G40RCQhgPcAxKi-BlBq0eQ>
    <xmx:qBTTZwRN9MrVSyD9sd9HIYa6o22_A2fxIAQeJiDoDWQLvAMEqhGAE8wo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 13:23:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] promisor-remote: fix segfault when remote URL is
 missing
In-Reply-To: <xmqqv7scq4iu.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	13 Mar 2025 09:28:09 -0700")
References: <20250312114628.2744747-1-christian.couder@gmail.com>
	<20250313103859.817127-1-christian.couder@gmail.com>
	<xmqqv7scq4iu.fsf@gitster.g>
Date: Thu, 13 Mar 2025 10:23:50 -0700
Message-ID: <xmqqsengondl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> In any case, why do we want to keep these unconfigured remotes in
> the list of candidate lop-remotes in the first place, and why do we
> want to treat empty URLs as being so special, more special than say
> a randomly misspelt URL?  I think I asked these questions on the
> previous round and I do not think I saw them addressed at all in
> this round.

Ah, sorry, I saw this new round before seeing the response to v3
review, in which these are covered.
