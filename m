Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD483115B0
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629063; cv=none; b=ssk8yXkgZjVHTQ7dFbBBn95g85vSu8NpOY7/06/lZ3rQprj4lsD4gxgQWCzqdSYPoFBk0AAwSp+YuTO/MQCzMMxmeSkq5djyFvgofF5Zxlfe/wV0fuB0QM4GWs6Uu/z8hPhOaOGdHOFup2UAb6SMQtfjX6e0me8DUQyPzIvYFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629063; c=relaxed/simple;
	bh=ZDpwCS9o7TFxUYLOklNR4UFlrbXik/TXvNRHvPlVxc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA8sWfgDScjhKQ3jHJR5QIB+qlLdW38j9+vm79q56Ier27ME+X+pN8uZ5mn8a8weEhydYFlpWG+VFaYJ7E5n1agjSWUB7ANX+mC8BNfkPCTtoMVwTk32xksDlEPRTKvJ7tD4MFVa0RMDhDBc/q1Em2yyrLiesZ9lvKTIni4jIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S2iBsA5G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pDRAG9pf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S2iBsA5G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pDRAG9pf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9CACC1D000FD;
	Mon,  9 Feb 2026 04:24:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Feb 2026 04:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770629062;
	 x=1770715462; bh=/rsV1v0CF21tc6z0BPKxhDp3C1oPfs9Yt6ifB/b/5ts=; b=
	S2iBsA5GeqXMW/tYM9PSSaa7OnONgz8h0xaqZE3kmZq0m0aYCyMG+V7CVDnfy/fD
	t7nl9S9NEAIwptlkBavlMXpOKp+mfR8kR4Ez3jOJ53VpZmvE91OjeW2eEco7a0z4
	1XR5HXsIX9z8zd9H64nMhi1MdGcAenAuJPF0wNlWafSgoE/ueQ0DOQ++fyv6w2Ow
	1J4KU+/BrtIJ1t5IJLn37FmDhWeROeYXzR+Bc1wSa4/9+A6I3JPEqwBwg2mbFLTg
	l8I9w4ZgMdcl16UzvU5VUXpJ+mavfpsXCZzyWPZh8HqHTpkupJgoS0Zyog004HaU
	tQK6waDO0ssFhe9BK56tUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770629062; x=
	1770715462; bh=/rsV1v0CF21tc6z0BPKxhDp3C1oPfs9Yt6ifB/b/5ts=; b=p
	DRAG9pfZfBwOke9I9JEOibb9T+t2DANUGrK3W4qQog0ejaEeu2vfe8MbhsoxKRaa
	RjvnqHzdUgLmUYyDDybdHMbSTqc+dkxNI++es+rOkY8JIOcLZrzp9TVn3dRakEZZ
	OXb6TazXXt3jmz/yAXJsHg5aI0t0hluyBvt0A21iP0+wYGQ6m9e0ErrE6XnJ3VPd
	8hbQCi9kwFLKm3VqawNWp6g8Q4O3CnCekBCpf+dIoJ7AWrI1bwtTfoz5iuwx6Cb+
	UJrgRH7sSO6loj57DKSLNWTbRvngqhSaYj5rB+dgeh0eoJh7g4L+IWnn29N6ItNb
	m5kk6Gzyh3q5+/Plu0ZQg==
X-ME-Sender: <xms:xqeJaT5oUAffTKerZBfUDazjVku2DzwP1SzERT06ruAgiCbBxjWV-A>
    <xme:xqeJae61nxBR72vGsIoe8f0UqezJkwnxdbLVhLUsvDPT1pNtOsgpUGmL0_rSHv535
    WYjKtSQw8HQujyUv81xSSXsdkuWstpFAQj9Wekt-Gn10fAq_7JlTOs>
X-ME-Received: <xmr:xqeJaYFAJeFFMuPBaLk6WvPPLmqylhtuqUuzbMPO5_F5zHvVJBQpIHPJDB_nDlOMFcOzSChPhMFwbDBdNbD3KyU6I2Su8owa2igkC_vvLBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeigeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:xqeJafSlltFjcRnB5DuORmq6m_hSg9jtWXFPHGh5QSsN8CwcLImT6w>
    <xmx:xqeJaZte9BTL4Du6lvXCU_PgScXHOAz-w1--7oTdoNA0YueBmEFNVw>
    <xmx:xqeJaWx1h7efJJPTr7BhXVhqOhtyuWcQoUO8QK9MpgSY928YvtMszg>
    <xmx:xqeJab65UJtJnZVCbHuj8TUXU6SSL1Dmy9zxOE5sHSVR6GB6VXF19A>
    <xmx:xqeJaXRtZAt4wg4cfF1CXWHqLc690-SHmIm-ZvStNmBNU1kYZBdwG1ju>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 04:24:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 195c7cdf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 09:24:20 +0000 (UTC)
Date: Mon, 9 Feb 2026 10:24:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] version: stop using the_repository
Message-ID: <aYmnwcFFmbjE5UPe@pks.im>
References: <afccdc3a-8672-49a7-b260-e77e617d8976@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afccdc3a-8672-49a7-b260-e77e617d8976@web.de>

On Sun, Feb 08, 2026 at 06:01:24PM +0100, René Scharfe wrote:
> Actually it has never been used in version.c since cf7ee481902 (agent:
> advertise OS name via agent capability, 2025-02-15) added the dependency
> macro.  Remove it, along with the also unused struct declaration.

Quite straight forward, looks good to me. Thanks!

Patrick
