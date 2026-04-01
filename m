Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ACE2F5337
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081919; cv=none; b=gwjpW9R2nLJsqbPsvOxJ63bXlbP9AsVVI0eMOvn/yIR9g/lrssBHsmegDazYeMoyWgCGJYStJcmNhX1IRaoSdAq2IFbs9+qFZjebn49YYNtT88WIwg+KPCGtm5s7lWUdGlhuMCw/hOMWAZSzRuTAB93m4Mso/sAo4tkHHF9K3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081919; c=relaxed/simple;
	bh=o0quo9/wShw3IaTcGqIKIFg0It/VRZHZzdvJA+FKypI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KsxiLzkWZbMaC7S3JDJPDLX4U1Hcg+Q9yIHLQxahuKeGw/o8QL4u187//F+gcsi1aRK+P2pZ0vMSoSU18FBMaDVyZEnN+wxl1kKWMJKn+aHVnPMcYz8LjA8KhPOemxIwMAKfjguFYDuA7rZtZjj6X7Y+FWWseaSoNDV+Wn3zv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QE3cKIlh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NQn66FtR; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QE3cKIlh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NQn66FtR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 896A17A016D;
	Wed,  1 Apr 2026 18:18:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 01 Apr 2026 18:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775081917; x=1775168317; bh=kb35TsApnq
	bBBMIqWp5qFU2gzK/rIZCeOZd2U91RAJM=; b=QE3cKIlhEqCQhTDOerDOk+CjSW
	9wk3+uWp8ABkUD2p+6koDtHpNJpR1ibBr1Ov9oJlCmoQiTXA8udpCKNxj7FWpYzH
	U6B5nOzBxpt/dzz+z189raIYetRlGDk+mBKmy+OsuaJAKyn5MXSX98yH+wYc7kjg
	tq9kxUovU0azhfPVNHmOvGp4MZQVuohrCLKnCEr4xdH45fvW7WtPjzNDRVvq8UuK
	RAnOxExChjiKDP3dyOuZphG/LAVX6a6jY3nk3bXEpGjqCqnUscWanwvHzX62G1J3
	nJgx9XmKKyLdAPsS+QxMr8r1qkS04cdGDj2wBIO1pl6MV54hDkduetudnNtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775081917; x=1775168317; bh=kb35TsApnqbBBMIqWp5qFU2gzK/rIZCeOZd
	2U91RAJM=; b=NQn66FtRr2Kesm9DdD5mrFy1eMJEHPD2OxlJCj5jQ3hoBZ6lQvK
	i13XqTWteYrpaTfaxiJyPYsiME/sJ95ZVT+BefhQNHGgN1c7gP/VhfQf2ZQroELo
	5Ts7LY/mbMBMsx+AdtJOiVd9l16hPbE7DzWKeCXOG/BqbqIuyfNA+idYmH5ds/PJ
	2zgth+xH27TMntjMIiBc+O/SyZVIIvC6iOrTYGD2GvyvQXLtgCWBMBdWeolotAHq
	/9/79oZAjLC8iJFnMVAKXsSXhTtgR0At6cyyztdiw/AKSAdTPTFSt1iAAbTrhIyb
	Eh3C839aLuXzYPSj8I39SWbYHJO3Z2bzeEg==
X-ME-Sender: <xms:vZnNabXDY5xs9lwsti9xNoV_dK72mUYM4Mkb917Y5GnR67SnCFsxMg>
    <xme:vZnNaafYV7Sv6lHozrNIRTDKQDVv_v5oMbKfD3RzSy9M8zqNbnSmuMILxEZnu1t12
    sCXwCx9N80HkLyzUmxBzesTkzuhl5ErJJFsCxFYbsCM--jPm7_e>
X-ME-Received: <xmr:vZnNafvbE-X8giDmILS0910uzU3rnFjqzoApHNR3bTMmMvhZRy5xFZnyp0V7ThYmauIK7b1Os0Ig2S_XKIZqq5hPXRqFnJ-9Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhn
    khdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesghhruhgsihigrdgvuhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vZnNaR9WHVwRFhHKKnPyP3vH5JpgfR3Rdxke2rsZNeg0LNmbyhZBGA>
    <xmx:vZnNaS1Chw-WYkkTFCgL4xsL-yKIbb4doUKy1UoA4_yogOMVgg0AJg>
    <xmx:vZnNaeD0gy0wsI4UNLLzjO5IIY060c1MuFsKYdRpNgSzhllfDnYzIg>
    <xmx:vZnNaWfL6UNorQyER48MlAcYa-x0CJgzhHuZAI3KBlbsWpUy_qjOBQ>
    <xmx:vZnNaQXzcX0mm0KkKtbtzHorG-dfskkiDQf1n1kfmV1HLV_X_MIaFMT9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 18:18:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Collin Funk <collin.funk1@gmail.com>,  Michael J
 Gruber <git@grubix.eu>
Subject: Re: [PATCH 09/12] pkt-line: make packet_reader.line non-const
In-Reply-To: <20260331235136.GI2328529@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 31 Mar 2026 19:51:36 -0400")
References: <20260331233856.GA2327197@coredump.intra.peff.net>
	<20260331235136.GI2328529@coredump.intra.peff.net>
Date: Wed, 01 Apr 2026 15:18:35 -0700
Message-ID: <xmqq4iluuxxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The "line" member of a packet_reader struct is marked as const. This
> kind of makes sense, because it's not its own allocated buffer that
> should be freed, and we often use const to indicate that.

This is interesting.  Once we go down this path, will we rethink the
use of "const" as "not ours" hint (which I always found confusing)?

> We can fix it by marking "line" as non-const, as well as a few
> intermediate variables (like "head" in the above example). Note that by
> itself, switching to a non-const variable would cause problems with this
> line in send-pack.c:
>
>   if (!skip_prefix(reader->line, "unpack ", &reader->line))
>
> But due to our skip_prefix() magic introduced in the previous commit,
> this compiles fine (both the in and out-parameters are non-const, so we
> know it is safe).

OK.

