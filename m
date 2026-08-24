Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD6138AC65
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603140; cv=none; b=GNQ8f4UBv/2OKz67UedGDpFv+OYwkq0YhBh2oivoNnTEkQw6bvzdC/NC1Ibyp+B6BmGBHLhlomOd+EWpf7fFR9kyuYiRNdnVpDzeA3yGx8HxQtmUlG7LV6XOjE6E1SOIUQ6PR9dRi5CBgxQ6LGZtBVT3bRmzM4rH6B8hw5NB15c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603140; c=relaxed/simple;
	bh=Uke8Faqd4dnTpo2t8ZUHZzjuA9jaP4nu8/dbvAX3m0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1OzZtUevaDlD4VgVd4KHCKbz3CFwgATBRL/UjhTxRtFHtdcdvtNzcTqQX7x++YcW6e3cYO71mvM/1qGsMMl0nPiY5+qjwSJa9DAZ/+L/I315xIbAelOyyZaclyqkN/ecSfluVJzolNnfMizf6bRegfTTOuylNMIuqdOL0vyts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lRCvshPx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GdlH+Hcw; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lRCvshPx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GdlH+Hcw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAD2214000EB;
	Mon, 24 Aug 2026 16:25:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 24 Aug 2026 16:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787603137; x=1787689537; bh=Iir4SmAHYR
	jKnFKy+KGAZZAm3bujD5b8nLqUJbA/n7Y=; b=lRCvshPxuDGxSxufUnoOnf30+m
	ZxbY9QYyEsbVlGjNBUQMljPYAP8aTozLfo2kNEP34JKt8G7roYfjYw0QGerKJ68a
	sxmy6pCUIatho8chVKd5URQP0jogpnQiOr15c6smKAEioWTLLCk7cMsdM04QaVn8
	YIQeMBLeXWJ/1szd6JJsd920N3ZxVHVktYTFOMJD4sBht7/MDbpxaD1JAU9NRdlK
	l8OGbqDdITbjUOvBa36I/J10HIGnaMQvFpe/aN1ckm88UChIc+WzLk/TeGyK/dqB
	d9uqYXgS5lKe7GbuAjf5LctirIc2RMGSkpnjJTdTeIMX/vQQbYn5xfpzTABg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787603137; x=1787689537; bh=Iir4SmAHYRjKnFKy+KGAZZAm3bujD5b8nLq
	UJbA/n7Y=; b=GdlH+Hcwv5JKfBvthEsjyMHmSC8b4stGK5hKTYHaC2xJHDGXcG0
	kQtmv5YjkMq7XcjvH7xQTxtZAzEolfGl/HNqBlKqYvgnEjGy4zrm2zpPgya3uey/
	eYx63A22bJouqd/OYXnREZOgRjslq4oTvOeyY/yJqpj4smU+XRq/27z5ThvdIy+3
	Ut90gjtArVh/ivINIR7AOaW9e+CIxu6cJTbTlpYmBG1uP01WUs1CH/sCZF7su1JA
	S77wzZpWU2s362iZ5RgIIp2VpF2eO1eYzq/kWp7xt7YfjOxBB3JNPSgrhw7J5coT
	fOH0xuXXDs7dAi3OagaLP/48lbUYRKg2yHQ==
X-ME-Sender: <xms:waiMauat5Sue5PqUTKaLoONhKfsyZbGj1CDIMM4hJCF1a69RhqAjrA>
    <xme:waiMaoZvPjKTuo7BgCmaTm2j1LIJiAfFDLzdBff7J4lyvGhhhs_QgWx3rkTPoSxI7
    c94L2eJP5HZKV9QkeoEKJiketo-FNuph2Jo5xa6pXj2XHFEcy90mDc>
X-ME-Received: <xmr:waiMat_tOe4uruHi-RDiKug4Jg9O70RH0jj3zI760gd7iZrVS6IZYKROYSUltThae1LU4GMcmogiEcB3fj-DcPt8rv6QcVbBOw>
X-ME-Proxy-Cause: dmFkZTGIhhcsBkp7IQ8idfS3s4nSts64QOfLjQx5gIyUhPMpr+YV7fKsnuJ6GlxYYkyaWI
    LcbX5dxL+EGpcD5zY9WDle0Kx5k31FRDlNwnSBSrW25eETrjL1T4MJMc6lyGwQjS+GLd7H
    1sLUlv26SsY66fdyb3k4466VihLMpAohXfefGuNHzDJtjFwltj35S/AG6z8a1gjKlKXhFD
    tuuj4WogZ/ej2b+vLt6s4KTaruvbcm74E6O4FnK+XUX+9lhxjLnlEQEWY+iPJIAoMtQRwq
    yyZ1SkPvhppG50Npes57C4xZNmxN/47WFjad/jnxcfs/iwVecRaXMeMpdLaTQgPeCXytAU
    QDB5bDRlA2gVS8Bdew0za2Eg0Wjq0WuIV+fPdNoey1SKmhNOIPij0IJDT56iMsJSRRp4Ku
    WZrxRYZIUjGJV/tSR8DJO3nTn/H9o1bgaJ6LS7IXfBzkTVoIB+E+5eagBvpB63C9acBCre
    5gDrcIaNb6obTGSqfPCXfk0fvzxd71DcZbOGkJwlN+12IJn891DgrdpTt7KRcjbaEPDX6f
    vz/KwjHBYVhjyjfJMvcIgI2Zd3lF5aU55+BmAVPBbLuUPh3eRFuty6SFfncrIkgmOP8gqu
    p1EnCIxpPoOxIi12ZNtA/eagpjo6TCZKNIaLXDHQXLDGUwTnOIs+s7ZIkqtA
X-ME-Proxy: <xmx:waiMavivFP-bhmcKKivcwgDRVEyGaXBSDnMRfVkWyb9H7V6bABrWgw>
    <xmx:waiMalfyyCdHmD5ydLZlN3LCETqbNlAmMl6CEufcm_Hl_1qsMbI8lw>
    <xmx:waiMauqmE6OlrVBjxH5grP1w6zaLTNewoUepB1vlIKmOBLxi7mwoYg>
    <xmx:waiMaiBh92rVplx7Y_MnLmdJECMdBiP4nmbyVmF3rBKHkXN4e5FU-Q>
    <xmx:waiMaoQph9i7qugcL8CKTS3Njjs7F4YyVLH1MZbyOZCX6zQAFCilIYva>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 16:25:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>,
  git@vger.kernel.org
Subject: Re: Questions about --ext-diff
In-Reply-To: <20260824182302.GA177524@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 24 Aug 2026 14:23:02 -0400")
References: <1c1567ec-c81a-45be-8b92-2c995dd34c16@anselmschueler.com>
	<20260824182302.GA177524@coredump.intra.peff.net>
Date: Mon, 24 Aug 2026 13:25:36 -0700
Message-ID: <xmqq33w3qn9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> For many cases, I think textconv is a better experience. It is less
> flexible (you must be able to transform the binary into something
> textual, which is then diffed). But because of that it fits more neatly
> into existing commands. I may be biased as the author of textconv,
> though. ;)

As the author of ext-diff, I very much agree.  The daily maintenance
of the drafts of "What's cooking" report is very much the only thing
that I find a custom --ext-diff program very useful, but I suspect
that even its use can probably be substituted with creative use of
the textconv filter, diff hunk header patterns, and the -W option.

