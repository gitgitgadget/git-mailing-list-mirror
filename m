Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1D85C47
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470604; cv=none; b=OwRgDC2OwFVdA1Cc7QoGHgZC21YyBf8lH7N5OW2yNlZkPpThemf1MarsJqE7sCfiSOaBb06yG3EY9iUeTNYoXFmzF7oFnutF3okB581P6+7Y68MiOJq0J+23l9IMg2L/shwkTOfIKLOPn9TleUUBBZMXYTC592bsgaAKGJBakK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470604; c=relaxed/simple;
	bh=mp87ps9UFvPv5w+P6hYsXpGM3J/qWW69j2kTa5JCuII=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n+d4UApj1mX2Bbylr1Js+AwrbjgRRCb8K7TSf/1ciCKxMsz275AJuQQGY096zeAi65Qi9zufOD8d9hTzmD22/TOvy0BLcp6uAs9Rlvka65l9dCSVKOTR2dL9H2LMcUsvqtCxijedFYs99a0jr1qdUz4pYkpfQdaaBk3mBqzmpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r8bpkCUF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qbE3M15S; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r8bpkCUF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qbE3M15S"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 85D4F138026F
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 16 Sep 2024 03:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1726470601; x=1726557001; bh=mG7MDgXs1l/raRYGq/3yqUAc2cVgNaUx
	ahKfDyS5teo=; b=r8bpkCUFG48KuGusmkNJR/j4TUcfNc1Dh4xBkgeqXVDeBbdC
	X9RIRVsrwi+IjfAerph/sgiJePk2WO1LS5FcQva9YXakYnlQ6+wXtjELhLhpWXjp
	tX/01zKGprI6JFuu0dkgzv3mlWGKC3z1jk5qcP1XRknrMQoglGQFb7XTpzcU0xOS
	KknDicr+MrIBcluslnIYtFGartiatU1HOrYmdRO1hRGGBYhLlrngX1qPe+Hgi8oy
	XzUFStHTRFMrtzyjF0mXzdmRRWFn2jtVvQvQML9ooBQbQvHuqqmvrHTOu8xq/4UC
	emCdJLNKwNuioPxTZSWzg0eubhbCgGxhKaHWEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1726470601; x=1726557001; bh=mG7MDgXs1l/raRYGq/3yqUAc2cVgNaUxahK
	fDyS5teo=; b=qbE3M15SCib/xWTmPxqIsKr77ubrqaESzg69Y+dJuU5u1IvrYIL
	wsmJ2hJkxbdTTst0VMhNVzNem7sKkFaGxTo7s85sEz9BwwzAKN1xnfuUVEngyieG
	uNpa7EXaKH9ho4EOxgmlN5/2wZh6H7sjKwQpoDOPw1v6jdX+K6Vsmz4+uRshTeo8
	IxRoTpA1zMTJ92PVh+qoAHdAJ74qVlb18YtSjcSC9Ml7XCb33LinZLg52+vRBNMc
	mPpMfJL7Q+eIZesVOjE6FWUNjC6H7E1TdZEnHlfuuUZvDf/uq6aiktC0e5E3PcaN
	NTdPAqZe5+5ETf2XOPxqkzoDBw2rI6J4CLg==
X-ME-Sender: <xms:ydnnZowb-1kz4Unp1OAks453cfybEMof7FwCYexdmPW-r0pF6vXu7A>
    <xme:ydnnZsSesP9oKdLt8hd8H-NBACUf8_TXHwlNXQ7K2c8D2osf0wOib-pw2iY8Jt_GT
    hdAqQP5eqPQm-_xYQ>
X-ME-Received: <xmr:ydnnZqUJ6NjO3DWzeovuHCmef7-ry-M89xZ5Dwv0RCgWA6d-6Vb-Ks_dFCN9HB73ew2VqUf-Rq9IN7GMA5KyXYVUdgFB-nONXzWHXEDOPMwIbfzJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeljeegveegffduje
    fhveehhfejgeekvddvleetkedtudffieejudeiudffveelfeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ydnnZmjFdRKlQh0BMXb8JZsUVx_ybW5iN2gT4WNC1_19dvSdfxsN2A>
    <xmx:ydnnZqBBpBOxhJoccfyc-ZDYSiWUIMhvihnSIFcH28-SHYAw4DClWQ>
    <xmx:ydnnZnJNTLCpc6SBom9ZOmxAO7f_aY_IPNUg-FOLq0oefIvt5K81sw>
    <xmx:ydnnZhD3xlH4N2x7sgD46kkYEjGW0D9onug1Et7semgrN-rOPUA1Ew>
    <xmx:ydnnZr4VKcIwwq-TSf_yO1KaRvaAZBVglSMnYd8BrY3bWtdMtfK0SOdR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98076562 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 07:09:42 +0000 (UTC)
Date: Mon, 16 Sep 2024 09:09:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/6] apply: fix leaking buffer of `struct image`
Message-ID: <cover.1726470385.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this patch series addresses memory leaks in "apply.c" revolving around
`struct image`. I've split the series out of the usual leak fix series
because I found the code really hard to reason about. So instead of just
trying to plug the leak with a least-effort patch I refactored it a bit
to make it more straight-forward. Most importantly, the last patch
converts the code to use a proper `struct strbuf` to modify the pre- and
postimages, which is both easier and allows for proper lifecycle
management of its buffer.

This series builds on top of ed155187b4 (Sync with Git 2.46.1,
2024-09-13).

Thanks!

Patrick

Patrick Steinhardt (6):
  apply: reorder functions to move image-related things together
  apply: rename functions operating on `struct image`
  apply: introduce macro and function to init images
  apply: refactor code to drop `line_allocated`
  apply: rename members that track line count and allocation length
  apply: refactor `struct image` to use a `struct strbuf`

 apply.c                            | 447 +++++++++++++----------------
 t/t3436-rebase-more-options.sh     |   1 +
 t/t4107-apply-ignore-whitespace.sh |   4 +-
 t/t4124-apply-ws-rule.sh           |   1 +
 t/t4125-apply-ws-fuzz.sh           |   1 +
 t/t4138-apply-ws-expansion.sh      |   1 +
 6 files changed, 204 insertions(+), 251 deletions(-)

-- 
2.46.0.551.gc5ee8f2d1c.dirty

