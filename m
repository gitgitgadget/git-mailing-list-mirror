Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906418AFE
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202461; cv=none; b=ZQ0cyx4Ppd1XthbBOcYJHy++lQ5EWrGVPIDyBHEEYLGep6SECfCQwVKNnTeWVyfgRZXJM3Q6dPIonR9nrRUmea7I6eMC45EtdVY8eYci4lLNWfhzTx2ScLCrehVAVphPyrNzUlWovs+R71NZge2XqiDVHsAhycjx6kngdHgn/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202461; c=relaxed/simple;
	bh=RWUJN1OYlJ7OSmDOa3aJ2BIPV/Uga0eIvBwNLj/KjhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ohd2wkYa89KpCiLokcB6W7xL9DSXnbxKOpTvNUPcAUSBaiP2jDLuWH1Z172GfRFedLrRlNAzyEbajKZG94+xE88IWLC83x0U29MYeBu3F+1/dXrNBqXOhIA6TRt10jSGa9SYbcUT7OGpU+dJ6/AmvcK20A94nZcBKBVZpTJCj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NCe/Oy8X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CkdsSgWM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NCe/Oy8X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CkdsSgWM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 18402EC0121;
	Tue, 14 Apr 2026 17:34:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 17:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776202459; x=1776288859; bh=swML0gFAmZ
	/nLRZ2EqgPNwKjyTcMB/qetclFSL9cxgg=; b=NCe/Oy8Xd2Kx0tyVo7REOmS9kq
	SPLc+vvhkKNRTheXTgBNhtUjDV3f2geoqbkYhiaLB0sqO1AGkAZEHUqfith/h+9U
	e8yReoKc5xHbdxhOHvxm8dTBaBn47UOrXcOrPeD+oPM3ZXJoDtbZ3axkP8rPjBMl
	x7km7fn9POgHUWSF6MS1TBepRglM6ZB4cm1PZqEZuGuFjykpkXcVBSoDlWwSefJX
	X7d7kjy3U1ge0dOy5ocdidlM2snBxCFJTHk6u1145ACTA36J5Pu+jCuVTYtB1GSa
	W79mrDUGuA+UaKuVmoiQ1lJDOaEJtYeh489Thb8G/cFg2etZiiU9rPHEFCgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776202459; x=1776288859; bh=swML0gFAmZ/nLRZ2EqgPNwKjyTcMB/qetcl
	FSL9cxgg=; b=CkdsSgWMbhjqUJN4enb1/LjURkulpPfAjHApUKHghwf5iO4S/fq
	Fc5JqghSx6MtvRqM0f9itrIFOK0gr5cnNNTGnO9kvakA37HeDC6lR/3/TjB5P4yl
	X+4vY0MXrrP5megdz2Gg6NI6+0sPp5UsWojRSGoB/mtRuRkVoAQKVrYFAQ7i1AQ5
	noGNeW5E4O7zQp83Xtp4jAsIFHSP3jai+kPKtk22BJSPAM3JB1R+Fjj52CnA9C1C
	QAT8n3ym+84BDKaTtUegFzwKIcWp6I+nu7fl5WO1NRWtPSPfsiIV1lLWuzfdGfpR
	Z8Qkdt2+Ph/dcDb3lsExtl3gDB8jPwA/akA==
X-ME-Sender: <xms:2rLeaTKDm5h4mM7hnhmK8hSkW3Rv2g0NtsEl_HCtSUlbHbwBeqVGKg>
    <xme:2rLeaeCuWhuFAT9mG9bifZrkXSo_eL_Qxa55LwKTF0WTDvGUCfon1MCSsT1y84Bj5
    AI4xJVBk72Nh6oUkrh21HGQ01hHhM8_7chUMyabeihTsD-z6GRFNA>
X-ME-Received: <xmr:2rLeaUBITDj0kdHlrF9QlrpYq85wnMvugqmO6Sj28A1quE8O6FGIlQHyiE5ywQUhnOL42zl6_dQ30YKFMzwxVwgaZAjtDbMfHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2rLeaYBtBSKmPWWjAS2yiTTz3MvETE0MTovjtkoc4PIE9jI-A2BiHg>
    <xmx:2rLeaXpcxoMWqBfpzp7SrRpPLtKO5munPs91bGQTiSr2-42NhfU7DQ>
    <xmx:2rLeaalV_2JRGCcTmoD8eTX6eG6-ijuQFSyvGG_h0g4zcgNtDVRDSw>
    <xmx:2rLeafyWsmm2JSmZ0YUD31xBzvoeikjBcbUP_3eUcDUugfP-HPRM7A>
    <xmx:27LeaUjDcDsTg9XG5UETboiLt96A9RIWNlB3Fs1ZanxmgzQkxVo1MvQl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 17:34:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 1/8] t/helper: add 'test-tool bitmap write' subcommand
In-Reply-To: <ad6xn6KmP3TsdpcH@nand.local> (Taylor Blau's message of "Tue, 14
	Apr 2026 17:29:03 -0400")
References: <cover.1776124588.git.me@ttaylorr.com>
	<d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
	<xmqqik9t9vby.fsf@gitster.g> <ad6xn6KmP3TsdpcH@nand.local>
Date: Tue, 14 Apr 2026 14:34:17 -0700
Message-ID: <xmqqqzoh8bvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> That's right, and to the point of your original question, I think a
> better name is warranted here, perhaps: "test-tool bitmap write limits
> bitmap selection" or something.

Perhaps.  Or "limits" -> "forces"?  Neither verb exactly conveys
that the outcome must be exactly the same as the input specifies,
nothing added, nothing removed, so I dunno.

> To the question of what it's testing, it's testing only its basic
> functionality of altering the selection of which commits receive
> bitmaps. In that sense I view it as a smoke test of that basic
> functionality more than anything else.

OK.

Thanks.
