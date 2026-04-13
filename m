Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BCF351C31
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101285; cv=none; b=EegZ21w/xp4xaIEIPXDE/NG5jKKvQk7BwDYSPlluoP8aKue2WZFP4eyV+hJKXT/M6/WjRHQaAP7XxqjcfWkfVNIKRvlwPEN8eIo2nSxKL+nPv5vnVWY/oV3kXF2GaAl58YCJOcl0s4GdSmy1YFgNz1T+WjJ+OYslksqbIJe12ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101285; c=relaxed/simple;
	bh=d6FI3g5w7Nz6UX1/IYzvaGxUyfiwq+PccmVKdzIXC/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rGzkNy2of68Gt2DLxjJvGeTLCpqsWBmbPR1LeJj9JlUVOqJVnR44CUPOY22JJDPy/6kR7AyxTfEv1ShDFyV7iavSDLw3D54cxBdJ+1MQoLGhe2zSYBDIGzadSwk1d09O6gvkiILB3vNU44vD0Dbbz8OjFvHQIxiAKN9ZkX2dZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D62XoblR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K9mmuBD1; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D62XoblR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K9mmuBD1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1AE837A0265;
	Mon, 13 Apr 2026 13:28:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 13:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776101282; x=1776187682; bh=o25Gjbw1h1
	wTkrbuSlO/B4SATy4s6tgDImdHnGei+iQ=; b=D62XoblRk6LNPooJ7Hc3ZT4aJX
	wPZTh2Wv4Hwb8wggpJvteJdhtF1MTJcEDr6K+xJHQ6TRl+8u9uwakx9COGw29d3I
	mwgT3OAkhGGgBUMoDtUNkRAUieOBqI47NMhxrLAgAx7bx8VzrVRmdapBOTT3/kxe
	qAjG8X9+TqxUBy8bDwWLo0kCwvNr/tq9XdGItzaxqjlYMpzZzlYmSp5sHdphhx9l
	ZeM70Yh0msDn+xqb9q8yupMv1v5WBxUM3cseodRye8n6rhgcNFby4qfAjRiIlBLo
	oXkBMAsKg3tPiZpux2bE1RCiai8QfMaWO4Do1QHLmg8+WMJyZKk12QQNkWLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776101282; x=1776187682; bh=o25Gjbw1h1wTkrbuSlO/B4SATy4s6tgDImd
	HnGei+iQ=; b=K9mmuBD1u/ZiEWLNz2pDu11rCxrHoSaf41nj8PsMrzDon2QOLLS
	W3cekGz7atmoAH5PE+yt5CldGvdh2qWlvsiLIo4DW/9r5K4p6EuqVyEzFX/y7ris
	UEgIg11AhJXXxPQofuh14pqsCCgKOmECRcpI9/655b7F8N8NLpX5K7dk27F2jE6P
	eVqZprqJE0d0wsKsu11BRHQmgR0xOZCadgz+BdQCN0B8zYIwRr8vb85b8R83OEUe
	g2rYM5OGjxDctvlS+Y5WKhFmuobh/g0b0wy0U2rXrYXAv2Rkc7ftIRQnKQbrxJPJ
	XbbA/NMt9ooGSJGyH/JNtQvSvz7kltP9rpg==
X-ME-Sender: <xms:oifdaWD5l8fu5r_KdrGXbWYCPdSOtCG6jsQC9Sv1-d1fcq_Z9YPLJA>
    <xme:oifdaX9lE1yEsmePARATZNc77RVlSTCJtzka5nJlkWC8qsNzuUiyvGceOB-2Ltn8o
    Sz58nz_93QjjshZeabAysiYgkOBVBJFzZ9_ux7tkEUQo_Z__zhNsX0>
X-ME-Received: <xmr:oifdaW9ZBImmJ3B4vOkfO4npyo5mJeCZszkow87SoQ-YkNObcmOKBcs3-nHyQcAt-RGG4USqockJCal6k_HPxv6vMNOmhgouww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:oifdaedRUtxfGkgBSICjBARUULDKbyDC7MHSRAw5Qg-kbezYVy-HpA>
    <xmx:oifdafHk9wEmRHi3wmkUrhsPr-fg40pclAaiFISqSa81V_3Kk5usdA>
    <xmx:oifdaceB-qSdsPDHjkAksiImNbETKPzVqaNpalSBe0P8XXy8PenBuA>
    <xmx:oifdaZEVifLkH3PG2PjhXSN1gMd4MyK_PB-fpar5EkFWmc16veJ_pw>
    <xmx:oifdaQF_grqr7xRJsJdTL-a6gCk6doHamiAuFhCldIFSgbgctDHqvsdi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 13:28:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/12] t0008: silence error in subshell when using `grep
 -v`
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-8-5b83763a0e84@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Apr 2026 11:49:29 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-8-5b83763a0e84@pks.im>
Date: Mon, 13 Apr 2026 10:28:00 -0700
Message-ID: <xmqqjyuaixcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In t0008 we use `grep -v` in a subshell, but expect that this command
> will sometimes not match anything. This would cause grep(1) to return an
> error code, but given that we don't run with `set -e` we swallow this
> error.
>
> We're about to enable `set -e`. Prepare for this by ignoring any errors.

It is curious that true is explicitly spelled out, unlike the
earlier steps in the series that used ":" in "|| :".

Loss of extra spaces around the statement inside $() is a good
touch.


> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0008-ignores.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index e716b5cdfa..1218005b54 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -122,8 +122,8 @@ test_expect_success_multiple () {
>  	fi
>  	testname="$1" expect_all="$2" code="$3"
>  
> -	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
> -	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
> +	expect_verbose=$(echo "$expect_all" | grep -v '^::	' || true)
> +	expect=$(echo "$expect_verbose" | sed -e 's/.*	//')
>  
>  	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
>  		expect "$expect" &&
