Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1683E3D9E
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137688; cv=none; b=eqm8qRddqj4taJXRpob0sm+zboO0eu15LPI4B7QZKJwwkcuaDYtZoWzMab+AUuLZubQttUb6HwUc47VsIZF1qC/Fw8i5x+7aSAtyES30xgg1Ronc0XxlDhiFKlNNjOSGmWt0vah/ttVmcEgiaeIp7XwUKZ26IcOfRagTi7WBm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137688; c=relaxed/simple;
	bh=N6MwUamsAWImBEiUM2QDb9xGF3WriinJ7mQznulnSPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3ASZQUkpO+kg9KHT2kHW24MCbVLVuTB4hZc/Dzbj2MXbP5hRk/dLR0v/YvTteWRjv9nhCZ0+QH6Woxj2UuxTuv8Q/cDlD8dUZ3S5gdcuDLi3oaWa1dt2+S0dPAnuoHvi2fP0Qj2X03LxsEc/iPMNFQG/uKNrR5rFmSWaLK78BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u1flsq1J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZ7Uq55+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u1flsq1J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZ7Uq55+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E14C314000A1
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 04:01:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 16 Oct 2026 04:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792137686; x=1792224086; bh=t9XyrlfdeB
	RDyaalgFW8e5C0fICnNCkDIvR1v6ug/S8=; b=u1flsq1JJbUORyOMiEcfo8u9a4
	AjVM5/sVq84MC9r/oqgyuweq5Qdx0wsl5Jxmk+KBHAi7F9+G3pTXFpOXDV1gdh0x
	RWhKoqANn61liR8BeEB2zNWwGz6P3LwXvYIMxI47XSem5W9A31BbBqxZD3RCUdn6
	Ox0XEAe2Wl9CT+0fOhy34YPmPEm5edbB1mI63Nn5FtmhReEfyEEq8qZNdjxOkEpm
	X42yRugXGKrsoxpU0PipVBkJ7zMH2thMDkl58jCnNK/Hagwb9bnmvbevZKNOyLOI
	0ZTaEkJ/UC9/K/ieGaJrnwtF1Ye9JLSS9r25WKs7LudbzrleM+qczHz+elGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792137686; x=1792224086; bh=t9XyrlfdeBRDyaalgFW8e5C0fICnNCkDIvR
	1v6ug/S8=; b=WZ7Uq55+7/CsOoS6+za1K1ZLqk7bew8KX9VNSb/ux/YZK02T0ex
	PLKormuTQW9gm5wFWS64AlWOac3wGYsbpSXpKv+PdFIUt3kLW+WD8RMwPrY/n3e+
	L7t/54IOJ5uQDnzTwV3plDO/dyzy50lpKkWh7Uv8mz2p12KQ7AsTWZjdRw0aqn6T
	kvccyfwgztiHJjJVcuYWuj3zRS8AoIOXABJ6W0Me/pFLj19HoWpqrjC/EXiokv4Y
	W7FVixoMAmtisejcXq4l6i4SqK4TD5DLnSsarlUoCf9rhoV5X17SEWNMl0PYJ01a
	DqWMRlH4bmpYUG0Una9TMF5pqGvYgiO2khQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792137686; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:c0tWFJptLwh0THYkQ62l7oWjXNhVl1Rj63njXrJXewk5ceg
	Ejmg4b9S8EfWtUAuBSA5nEIb7qb7bppu5IvFyX7c8ows499hPidDwz6EzBTVceB8
	nlMt1Jjnze4KEHR9tMvzOsJlWwybtabtoa0d729mpNAC+UA02i1SII9ze/8A9i0o
	BZ85Nx8kp/y8WkFnZ0P5oJyw88CQonBZiwWJYuvu11ws9c7yaN9hzYXOh25YvZ1U
	VmZS1lkjjOee9II5lTdYz08lQ0+gR3wKPntEr4rA8sT87PpZe9IFJGkHejJD3W9q
	KvdxDWzk6N0pnM+C5gW1alHt/1raZbZycO+d7Tg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:O5mz8HZQFDEFIAedCn5kRRAWTTyTEEeRN7SZwf1lcvA=:N6MwUamsAWImBEiUM2QDb9xGF3WriinJ7mQznulnSPs=;
X-ME-Sender: <xms:1tnRaqC3xWe3OZrz5ieTdaxeQXY38xZDejAYK7WsPpjQjTRgt94iHg>
    <xme:1tnRarbV1fRAkPjDGbYdVuYpg-HMAOI5xUmUpDLxNUVj3-Cg1tx-n3ZXn8uuOKhJI
    XiBkQeeNqki6Zs75-eJ6T7OJ7z49_5bZA6cW6T9c1an1GYQxS-wQmo>
X-ME-Received: <xmr:1tnRal4V6NdHia5HAKSzeD7TlcCaSGKSAcykIMai1EtI0DtzrIWvmw>
X-ME-Proxy-Cause: dmFkZTFTxrl4vij0eX7NpmRMess7sE4iw44g5Rq+2/xoj31ftHVhs5TpoqnpzmTTdhj5Yr
    6MPocx+bsQzIvseuLoeU9O0LYYBtGOqbY388XhTOvnkF9hlGy0yvjJwkQHhVbi1K7MThQT
    RhJMFjxZ1DzdPfzHJ12ikY+4DpCxEmAM8x0hdGEKuSs1pVKS7WecUkzAK+vwGYjniCFb31
    ZxNMXGMYwkobeO21Hmr1LPQu/Rrnv4RR+VxwPlxmjdgMfc5yWS5ttwFm7CzeEcFYR9d+9H
    qcz9QwnH3k0k2Vkk22Uyrg/ChRdPo0sZyTIUauUcoE8yA1Kv4C3ls7D8bc5W2L7IqtLCJJ
    WOz76dsXu+LIh+gOMHjm7nyU8AQJWgbdCDgRF4eHUQQfKL1LcW17TJ3RHLr37OEHSaanjN
    YFtqA7ufKTqRp4qhxTDKIQvaf0fihNPjphZIJIZvOgzU/BmLWSEyCWDGxuigMkUEj/2QVq
    ifcsDR+EwxgDy5golXMDchDUULNx27ssikEtU25U31XjisVZsZlK810U2pO1b9knd0b8oO
    G/6LMPKnbgeK0FmEuMpg3vLWcNevyPx3H89WJUBbF0iQY4G6xmCFMXbHFDtvx4JIYnvOFb
    3zSRP7FGKO8W0fGWY1Yyq1J2l8IQLouPUFA7FxAtkSPy57d38xASh3hi5Zow
X-ME-Proxy: <xmx:1tnRaka3TC2hYRa3vksrZ6t0hVEsUwOFxoLFmq-HNF_cVWg29qchsQ>
    <xmx:1tnRasip8BPUpo6VlT7Ab-oZXexywUpioffyjn_l6TwCZ2gyoBZQvQ>
    <xmx:1tnRat9TXq7GPscLArXeX66c1VWxRrBjNcA10U8x9fcLv3zaAuH1FQ>
    <xmx:1tnRavpXUQfotv52ChKQx2eGmuKUIH6XtI1XdW2VrsOENxmi940cUA>
    <xmx:1tnRavqsuLOoV8At_7GA2hxFPwivoeoQ7Z3v3sJ0g94D0PTkodb3kO_R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 04:01:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d9f0ab9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 08:01:24 +0000 (UTC)
Date: Fri, 16 Oct 2026 10:01:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/5] completion: drop "stash save" completion altogether
Message-ID: <atHZ0gV5Pz80l3ho@pks.im>
References: <cover.1791827304.git.ben.knoble@gmail.com>
 <4d228e79bb23c6c4a9b2996a3c8cf55efdeda7c0.1791827304.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d228e79bb23c6c4a9b2996a3c8cf55efdeda7c0.1791827304.git.ben.knoble@gmail.com>

On Mon, Oct 12, 2026 at 01:48:31PM -0400, D. Ben Knoble wrote:
> It's been deprecated since fd2ebf14db (stash: mark "git stash save"
> deprecated in the man page, 2017-10-22) and the previous commit removed
> further documentation suggesting to use it.
> 
> Since we recommend push instead, stop completing for "save" and remove a
> special case in completion code.

This is the only part I'm a bit torn on. I think it's reasonable to not
autocomplete the "save" command, but if the user manually types it,
should we really stop autocompleting its options altogether?

Maybe the answer is "yes". After all, as you mentioned in the preceding
commit, the command is deprecated since 2017 already! And after almost
10 years I think it's fair to start giving users more nudges into the
direction of using "push" instead.

One note though: the command _will_ be completed in the case where you
have GIT_COMPLETION_SHOW_ALL set.

Patrick
