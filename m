Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3127002C
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614600; cv=none; b=fuwYkXeFS7eguvtrXOgubbASnKeKyT2cugNovZLHT3RA28Co/kO1ixzOkkeYRoKgMSUHmZR60dRt7h8ilk2thHyVQdm9lY3bniGUxx7b+Vxtq7aEu8zBoG+latMWBjhcZLWilmNbnCwtPb+aGZ9za/OyOv6846q4chw7A6y3hqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614600; c=relaxed/simple;
	bh=hhswwE/3Tx6+XdZWg7MDl+VOSZ+cLlojrT0hzBeuhDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o7D+57Q+QhoqM+vLjQPFLO+tP4OnD05Lf6qyBGq/qj67KeMYxUsm6EWsH4VGlOUKbdxvCVpnS8aFn3cu0cmbIP+zoXzxaYJ6xkI64AKvuiZ8wewV0X70qTJjMqOoWTmtfrsJ1n2DrJ3twD+eK3rLpNfnqQH/SD9m1IFOlkfSPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qiDET2Vc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=8MEPWT0v; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qiDET2Vc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8MEPWT0v"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 116141381137;
	Wed, 26 Feb 2025 19:03:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 26 Feb 2025 19:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740614596; x=1740700996; bh=EtSlCwbtGA
	pDqdAWAbwt2bPs87XzCwwPo6Yg+0rggIs=; b=qiDET2VcdB3VvhrzkJsDpFf0un
	IEVYpVss2kXZK7nDtojDIEhh2Wq1n5DOJatuj5iFPOEgt3iy9kBZuLhgCxTfoFx2
	iFpBimp8FrwnysBAx4/FD+v4mWYHXYg2QyM+O7J9Vp21n1VhRw6tvLdzu6pZtRW6
	G4GPdF99tXFmzDo95T1x9YQMK2Bh7ZxHydeUdaS6HNunyLnUUc+hAqPSso1cUPWX
	31quNxjk1tE86Q9E+cDspX0ApwAgt449Ka0nGkepP+1v/Cu7efVwAnem9Pc+eHTP
	pYpA+RpJv0+SiFxc9ij//tD4RwEIVy0lnOdeWEbxEqO91gw9apc/8TocpEmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740614596; x=1740700996; bh=EtSlCwbtGApDqdAWAbwt2bPs87XzCwwPo6Y
	g+0rggIs=; b=8MEPWT0vyQUu+ujmVrz34QpNW6SNNdLs1qNOGLNXEZacBzKa2vY
	ft336KN0BYUlnWXUG8mZ4Wsn2ptTRoUc9Abpp36hAO8rWEGl7sWzI5tsjfaQ3PSL
	p5v6qELjLbhsgydu1KRock3dy+2m3fP4/cyfWShPyyOGjbN2HJOXlax0fabSh0Ya
	siEOQYYkibvFVg7SyJPkdxRBTrWgyZ8ikoAumFY4jMhwfgCRjk44ObRLwZed3/A7
	E39hsGt6BIT2lPh7Uh8dj2p2DRiG20lmH8lkh7feSlPQz63gikDgQ6YUihlr0HPw
	YaPQHYmB03uV7i1i4S7vZo4E4nC4lz71mig==
X-ME-Sender: <xms:w6u_Z1S8l3HctJKiINkVnULR9d3E55JQK2fnzDgeYyEUXC0oAEXyQA>
    <xme:w6u_Z-zDNG4QWaoKU481Z1Q14HVdYB0lwKSuii6C0daJ91Anep1yYTiOI8Fkh-hg3
    idYk5y2mHAjsmpD3g>
X-ME-Received: <xmr:w6u_Z63LbZHlVlL0Z2y2sc36WeSFBT5Q-nPzOIzMf2L2HmfaNrtDbZ2AASbtirnXe2hr2DnBSywRYFHcnijKJWbas__izcDG0KGT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohephigrrghkohhvrdhsmhhithhhseifihhsvghtvggthh
    hglhhosggrlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:w6u_Z9CSHJ931ZKi3MPTuroq01nASB5BMwUVj-odVi2h0DcDdFVGxw>
    <xmx:w6u_Z-gmFV_aCk7SE0PgGfCmMY0VaZLNmWawMYzOdYi49XV7qQ--ag>
    <xmx:w6u_ZxqdvAvnZD_asGe9_3NJHGLUG8P7uwCa_XX2BQM-_Jt_Sf76Tg>
    <xmx:w6u_Z5jRCUdCrIW0IM0udYs7kmW3HxsAFriUD_u9cxNTxu6rvBLXKQ>
    <xmx:xKu_ZwaL2ELmWgd9sOsQHSHh69squuEsoAocm5cOTUgQmCa4bvhDJuZ6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 19:03:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,  Yaakov Smith
 <Yaakov.Smith@wisetechglobal.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: \b character escapes in CLI usage
In-Reply-To: <Z7-lbGnlzGbhrHZN@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 26 Feb 2025 23:36:12 +0000")
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
	<20250226073822.GA21138@coredump.intra.peff.net>
	<Z7-lbGnlzGbhrHZN@tapette.crustytoothpaste.net>
Date: Wed, 26 Feb 2025 16:03:14 -0800
Message-ID: <xmqqplj49rul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I agree this is the right choice in general.  I wonder if we might want
> some sort of human-readable output option that might escape these that
> users could use.
> The output might still be machine-readable, ...

I wonder if isatty(1) is a good way to say "ah, we are not captured
in 'foo=$(git blah)' and not feeding somebody in 'git blah |
somebody', so we do not have to worry about being machine readable".
If that is a reliable way to tell that we could butcher our output
for the sake of keeping the terminal state sane, we then can always
do the C-quote escaping, or even information losing '?' redaction.

