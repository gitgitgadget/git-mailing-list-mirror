Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FA21FCC73
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624741; cv=none; b=Iin6ZwCeGnE5JjzZBbBNVM36Ms49z2a/orKqp+klePrBC2oqTLbTp0fhWDVhS9XVt8RTXPx6U83wWCdmyv2ZbdzWng/9FX3ok0F65TLHVQURKPHBValqWE+u3VzS1n43wJBG8Gq7gHPVLci6xyIPI3oBiI0X2H8KF574PLRD5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624741; c=relaxed/simple;
	bh=2ohlIo6gTE782gMCTf6Wfx2vydD8u3XotEyjzhTMUkc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcGfSsgpzEreI4MjnyrKnmIimwNdjiBcBlyM5/bhvxlyzVEffg0ZsIpkGg/4cMU6M0aMCm/K9j/MpKYjp8Xt4hZRvBwNP3fuyIlio0/X3EFsGipL2P/XaRCMjHGyrKxKX7mOYU/c2fKj5GQQlFH1BPdJ/Y5DSg2iLPYSXIJIuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iVLZMg0M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NbcPwu+O; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iVLZMg0M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NbcPwu+O"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E4D2A1140126
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 11 Oct 2024 01:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624738; x=1728711138; bh=w4odnqwsmr
	cJhwpfwJ5mx0IT0bPqbKXUKz0Wdy27sQ0=; b=iVLZMg0MOd/6T9DJuIMYEGqdLT
	vs/YtTkyUEinM7YYfp+MQrePtkP0SrfgnWZYE4x0/nV2ikY3Tw6BtL5irecu+xyc
	ZYwVTUXBi05+hn+/QG4Smh1kKcfd+lh9rtYIs1AdDeI71TkxyftH3cHyEw1ouZhw
	u3bfjqcdjMf3l7Y1rfJOYlnZI9h6lS+j26HXUAXATE1U6d+ArVULt/YGd2n7myg2
	GKU47ZBvbb3TYKtek6HEl5jRN/uh4jBlRliPMFbUdGGGwnOgC0QzHHif/twl7Ahl
	LkIXWsnvqMlvOKbYfjEoL0w5xruZh5Ge+h87pBP1ZhbO+d8R23Tp/BDlC0iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624738; x=1728711138; bh=w4odnqwsmrcJhwpfwJ5mx0IT0bPq
	bKXUKz0Wdy27sQ0=; b=NbcPwu+OtLtceXXzM0fqizXOnnz0yC82LJWvPQZtwwuU
	QCgAcAguMXwyaDP1B6jM8NkGpSCdTtKd7bL26ONivXq8auGKp116YOE/SKXJGOtf
	XITNxeBynxeHP+16XQdw0J/Y3fz+gaVGT6K+8wYQW+Y1ZGApnBY2DUYq3q7s0LnC
	OHZIIf4xNpzdlpHcvroxP+PDNKpZc9V/12SYf5Xn1aV3dtCr7I7+keHng1mm29/i
	HV4op3qCBXGmkz86K1441ylBUkdJk6NtTS38lGScb2BufyH2yZw0kYw7p+cyR5Qr
	fjomHCOHqiaWYWO4CQIIFmQN3hmvxXgIQptbV4q6vw==
X-ME-Sender: <xms:YrgIZ61YUbcuPhLgn8bbxrRM2j1xRt20_C1wcWQrGQike2qtfttFBA>
    <xme:YrgIZ9FLwDC94JOW5wSqP-8PP0rZVF0A94LbiSnAxgXLgKKsaFyUJP-NiPZcz9m0S
    yp5cULLk6fJCC845Q>
X-ME-Received: <xmr:YrgIZy5mCqCp-mTqj51Qu2xmVkFIc-kNUKorzYMvixhQClr34LOBBAB1TapqEOQcn7E0CLduskhOx3siyC_vhY_1GP892aY_QfyW3fT856KMKw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YrgIZ71Bhtdv9jGyvaqYHDDnQRw6_QcQtVdcy1_fZ6eqm3Nn2nERsw>
    <xmx:YrgIZ9GPuR859nnaL0kTkPeR_7aA3OPAbQ-zpQtR8rrOleTCQgYxrQ>
    <xmx:YrgIZ0-eyoykY1XLMCeV6-2jtUXFTYh58rLC9HYljxbwuRxI8eZ8VQ>
    <xmx:YrgIZynz8eHMBDlt-oWvLidbqFbmvqx4GoQz9JikV5vW0pEbFZCghw>
    <xmx:YrgIZ7PnyikFwRQ3_st53Ua7qxtD_dY5TV8sBb1SRRf3pN17EEH9SRUM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8c38ae81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:11 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/21] grep: fix leak in `grep_splice_or()`
Message-ID: <cb4eee37b4024a451a385f94ad57e7278e542de7.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

In `grep_splice_or()` we search for the next `TRUE` node in our tree of
grep exrpessions and replace it with the given new expression. But we
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
2.47.0.dirty

