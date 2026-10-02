Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF193EB7F4
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967755; cv=none; b=iTsn1b7KrkYG2lHtgKZD7MzHTpbAVwoMMVE9LIknO0or6y8AqILXAhjnYnDoqqKQ/Y14jk7iNw4T18R6EJNob8wOOXvtvd8/RRt+ZIScYoOXYRrOPIv7R5JPRcMjqgoFZD8CaSd44DEW3oKkFeMv0SrTcYb6LZuej7/VxS/Cvns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967755; c=relaxed/simple;
	bh=MjLAFjw/pOxsb0Aac5jsa7qZe0XJDVrdSgca2nidUvQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=sA/tBd+eQVFk9q3RW4WMF4WzYW5jbju/QzYr6+RHoMRkGayycnqeuFkC2R3KYDFmzlZaAUUUPHrPOOFQqhKjbxQp5sIlqGr9U30rrXNX9HcyHPACZWg8ix/bH3amSsCrBL1RrTswVosVoOkl52COCnVnAS052OD4Rkxd8t1FAnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=m7rEy/uv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ff9Piqwz; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="m7rEy/uv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ff9Piqwz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 56AF213800B6
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 15:02:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 15:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790967752;
	 x=1790971352; bh=MjLAFjw/pOxsb0Aac5jsa7qZe0XJDVrdSgca2nidUvQ=; b=
	m7rEy/uvg90B7sPR6FDSIx5wiveNxJWojIknJzSemcJhJudILXeSNwga8sTu/FXE
	bTwkMgcb5hVwK6cPtSISQcMCdXlZg+trP02gJJ/XBsn002lVAkhti8moiVbJNhrG
	2QBfkeXt+4eRwLMdNOI23A9MSLv4dYXEJuSfzso/yD9wabNWbzbmYLKDrMLMEJla
	wsY8YuBBDaryMLK1qVPKfYRpI0fH5wTbB2ziSjECFmFylRP1hgFGAH2SDoNZId7v
	Gtr3C6F3bsJU4FZ+OuJ/iL19eH2J7iu0fdO49TqTLQ3S8VNrn6DMqfjUMYONnGcF
	jdrJ4iFxyfGOayhEHgJXTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790967752; x=
	1790971352; bh=MjLAFjw/pOxsb0Aac5jsa7qZe0XJDVrdSgca2nidUvQ=; b=F
	f9PiqwzNr82JkE+hXrViMgLRujRwLFi6Tr7tJYautLzBCWofEbusTKtT+P9oMpni
	pO4I8+xQFAQ9K8zdFW0qEZY9zpuERu9TAmpvmgL1kTeKS4iP9dTpWj3FfGr8E/Xq
	HA+HIbIZ3m9tRfCofMtjF1+ukSHn+b/e+FYZ0dIo2lGlP4rnTCJdjfLLczrh60nL
	hxaPEO4m5EV6THgjLVCCjCPQHq5B+d5zrhb61QrVqLRcpfCVYvSK+dTDerTnNDJS
	T9QJS7iUcM7AXVmKyGFl1nVekK5e3cUbjSj5WskJhIzbHNofWSSqRabh/OhSHcea
	SmwfohjyA34ZFUsOKyviw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790967752; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VBVpnBBaq8DQtujHBfoBlB0XN6YPzbApHtqSBA3jyXDSNkv
	TYvwqFH5HZ/ELeOo/K1o0EFaSHlJJhGl3u1tZApAqeMn3i/FdjX2KsTCo+lKP+2V
	E1ij5jdbnTK9y2gDPDddi4h1uS07PTLpeQQQ1zSvR1PHI9EV1eG44VFMqFu8AjYI
	f3WJLMXW9c4TmSYtXo2zwicVNrv6ls+A6lkwSQ/yyoXVEVryir4o3+n4iQ3riQca
	9CAzpc6VWX+d9C6TvAPrKwmnD75hf7hE2b06mfDxOmMo8TwMaFEcqxNeGo9puCkz
	T6GjugjrIGDmkZYOotDLGNQvjJL22SZ8B/lIUpw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kKRS3YKJg+rB/vy9/LinHZ4twsRJNGcYer10aqMbS9o=:MjLAFjw/pOxsb0Aac5jsa7qZe0XJDVrdSgca2nidUvQ=;
X-ME-Sender: <xms:x_-_akAUl99zlYobCxQbK0Vo31XK84uFfOqhFmHZk_bRB3mnmxctHQ>
    <xme:x_-_atjfs31Z4TlDKSt5FDXZHcjdvuiZzn8M4UPSOmVKqdCd66hcYDTCGW1_Veci4
    HvMmx2oiOChqZi6yoZtJtHtWFBgLYB4US5pUd_0COCYqah6pGyfFZ8g>
X-ME-Received: <xmr:x_-_aslsvDkUdi9mOrWE_t0jlFxYwZDZSWzCaeHOxUik--Pnh3rWh353Sjgre54LCd4KMU_HvMahmrGx-q5R_bjWGj15meWJjTWxOnjiskrlfw-vzwSvxCzzKQ>
X-ME-Proxy-Cause: dmFkZTGVZqdWyn8PYJ6kb3nJNKjb5lror50D6xmRsDd03SQtUAJ8ObCrUFptWTNXD4ORQS
    HauJ+Cpphr3GQ6NtA0iVG4m+xoZBYpvU9wyX3Z2qpEChx7cbRdrOzJ1UbhKlyKQiMK7UGq
    S+Ujxf4oAWokbK9ompwOCTkmjWRIHXnMrmZXeK/CDi79/Q4/hLMK+O+iKoEqJYyuGyLnDX
    tAdtdReIi7l/d54DyYrdQ34OiPVgzzMGGgrTLZgcWpx8oaTMx0H7FixuQiVTvo04riTmm2
    E9nl5TNBUC3b3OJdQRpD21HE11IKeodxswJBu6d2+jkYNXt3EcZ6kevvL+oAT4N7ldR1Fj
    Qy3x9te5C90dsGzPeD9hBNU7s6jPDhzN+Ml+I0WBji2ptJZhfZgBz8RogyWeVVjJAPhx7L
    0hanZTBQ5Df++qjv0YozicwM9Ym9/uD5wDBQlX3tAEXwacI0nCDAyy5DZCyc0ZZMAIIyqu
    fsRg1De9ENGA3tvCrjFX4F23TG83Xl8i6mlGE0g73+w9rCAVo/u8MZqtYZyxTkdUXniSv9
    9zMM1X487liZTBGY0m9EMGKcirFRf8xbNIT214AImomCu44SeYL2eMsPWRPUQPRHjHCUVn
    a3hl1VM6HIokPn/ghY14Bojz8jFSg30pLQ3g8BAGOslyBbru7DPwwHcvWFTQ
X-ME-Proxy: <xmx:x_-_apr1Yk9ICzyLn6qOhAqGf3vaGdR8Ux-71yRhZaSjbp1z1fiJxw>
    <xmx:x_-_alEkBFks9k1yhXwN03ov1qnUmFwocrs5wzSxwpPO_Xj6ondrkw>
    <xmx:x_-_alyKpqY__pB63H5mXdVxPzV2gSdG2Sim8D2CDhjiNUNfmrS82Q>
    <xmx:x_-_aqqk8nEA-pKwtwUhuqilvDALQo8TEA9GAnB6YJSwxqWCrPxunw>
    <xmx:x_-_aj5sFteC0SXxdnbdZhPedG2Hrh-9HFIn_bMODNKWKrJXxUxCzamW>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 15:02:31 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 15:02:30 -0400
Message-Id: <DLUL2YDALTAV.15LO4AB7BDMLR@fastmail.com>
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
Cc: "Guillaume Chauvel" <guillaume.chauvel@gmail.com>, "Philippe Blain"
 <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] packfile: move around `close_pack()`
X-Mailer: aerc 0.21.0
References: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im> <20261002-pks-packfile-stale-delta-base-cache-v1-1-7592a3e31ae0@pks.im>
In-Reply-To: <20261002-pks-packfile-stale-delta-base-cache-v1-1-7592a3e31ae0@pks.im>

On Fri Oct 2, 2026 at 3:34 AM EDT, Patrick Steinhardt wrote:
> In the next commit we'll want to access the delta base cache in
> `close_pack()`. Move the function after the declaration of the cache to
> prepare for this.

Maybe I'm just being clueless, but how does moving an unmodified function
help with the subsequent change?

--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

