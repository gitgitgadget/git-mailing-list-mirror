Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749D1CACEF
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787421; cv=none; b=XcePBgCXaPH2wzaUaUD//Wv7PrRQ2bG18GbrSF7YxnJJOCwqJ0xMjnRarcb3BfcAksF2tPXPc8fUX66sHu4d43fS1kxaCVhc1rN/YfDY2qnFiQ3qcNkcaDUItaLdRgyK9us8Aea3mPUxE0oRAxHVVfRPMU/a9Q2RDqOuKQhdqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787421; c=relaxed/simple;
	bh=G7tZqCi0CVju4B2rtHxuoVkvqGJbrcrJxaQ2Ji1Mc5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap8sbmkq98vIINhR9Wxt891o+iUCg6hvp8rBlWs6NObyYebkWOcppt6Ag8tIM3QQGAGZoDcxh5wY+XduzFiQ9Q5K9G0SQ+3nl7E4Gv7uSb+lgVjn2YOR1IhABMOHs4mXWto6+fy55NOKuoGFhq+4yIBGwSjBQrKHqRhwIYhUQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2QppbHde; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iihp0I1h; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2QppbHde";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iihp0I1h"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 05B2225401A9;
	Tue,  5 Nov 2024 01:16:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 01:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787418; x=1730873818; bh=1Xevuea/r4
	DjKYwI98hRImH/XC9cv9WAastaqy4Zjiw=; b=2QppbHdeaDhQIb96n8Ro3n1pfN
	s0D1jE1AQn8euQpwopW/5lepmwpF7FpjKWdEh1W+/OL7JRfGZd3xFAhwkHQYlN7i
	THABvAx3AFObEYTsUePdOC2H/7Em/0YDO7JTW+7LqIuHdaRGTsOLEIYAjm4W+dgF
	jqEAEuKBGZNjBlkDD5k7U3OEBpSF1efZp5xOGZEqq7SgGov/Xi/BJFZm4UBtMBfe
	VPhdAdaCg2P42rk/40Dfn1W8//MC/AN0egdPqryw5dj7Medierr7gf6EomuQAGjS
	W5HTePrTgdwPPm9onTItqK5HXFXxGqg/Z2HP9ROPCKVpzYN1NROKmQwtOd3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787418; x=1730873818; bh=1Xevuea/r4DjKYwI98hRImH/XC9cv9WAast
	aqy4Zjiw=; b=Iihp0I1hDCUj+l+X9vogVYNyvMqbEv4inbOubsLkoFUtUm9wcbe
	CGNZ9qtFshv7qjta3laWOotPqWlqqOpMi5+seTYkjzfFn0ey8FqHpOmJ/vGKOpPS
	w+1puyYvi7cXDHHDULjA7yx6ZnEPOxgkjrH4UR23KgzKPysS3AoPfQwhx0Vw2pb0
	TLaB6b1S8W2Gy6C+lWagDNDGxucceomkGb/EMn85mPttBYQRKQLlxLAbpW6NG25Y
	4oW6JA3QUfXDvXvVYa9CqL/jMdZBYzApc4thys+0CbVcacFXL3UGA38HeljElFaG
	Wcz+g418ZfYUL2BLvDhg7K2OKsTL5LxnYCA==
X-ME-Sender: <xms:WrgpZ2pNVGalSw7EHGGn7MwLMbum3NK-dRduw4nHnJduTcp9fRf9gA>
    <xme:WrgpZ0pOIOHME9HDEdNB7LbJrMt3RAZ7Sjg5c2ys-2KwXya4Ql9af6fLRrwq_UgXc
    xiGalfHDlLQ3ei7-w>
X-ME-Received: <xmr:WrgpZ7MpsDAsuMDzuhEbitSvFw8IReJfqAvxlZlD1gFiEp8CxKmLN18V7qeoB1oU57c7VSlWvmCZrgPJcPG8mx-6bo-q3qP5y25-Us6uTRMEVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghl
    rdgtohhm
X-ME-Proxy: <xmx:WrgpZ17_X_BOw3iR8a7nTN_bjEBWZ6WTTQfZ6X9jcbGcRHt7mD2hLQ>
    <xmx:WrgpZ17zOcNXZ1KrYTkAXGUR1Ve2gsJMZfPmD1dTH4yX_cH4LnCk0g>
    <xmx:WrgpZ1iv4Y_vwID6J5IYxevYUnf1yUW3Nzgv4MUZYbT5Iroftw044w>
    <xmx:WrgpZ_5JXm4F0wPiTSym1jOYvsS4AotsgpjywpkAW31h-h10Zfscbg>
    <xmx:WrgpZzSyA2gXzPoCVLLfFOvjQkyqM-O9H4KjuiU-e3fZvWLnIZioNxT2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:16:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 604fc5e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:16:35 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:16:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 03/22] grep: fix leak in `grep_splice_or()`
Message-ID: <74b214701942b6412965b53b3aec4580ef6fd242.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

In `grep_splice_or()` we search for the next `TRUE` node in our tree of
grep expressions and replace it with the given new expression. But we
don't free the old node, which causes a memory leak. Plug it.

This leak is exposed by t7810, but plugging it alone isn't sufficient to
make the test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/grep.c b/grep.c
index 701e58de04e..e9337f32cbf 100644
--- a/grep.c
+++ b/grep.c
@@ -756,6 +756,7 @@ static struct grep_expr *grep_splice_or(struct grep_expr *x, struct grep_expr *y
 		assert(x->node == GREP_NODE_OR);
 		if (x->u.binary.right &&
 		    x->u.binary.right->node == GREP_NODE_TRUE) {
+			free(x->u.binary.right);
 			x->u.binary.right = y;
 			break;
 		}
-- 
2.47.0.229.g8f8d6eee53.dirty

