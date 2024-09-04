Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79921DC054
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459429; cv=none; b=qWO8iXI/AMP6H9FWnIfQGZwbVrFuMcJTY1vT7D1gM7Ov2nFJF8li6uNwDFNNV4AhvFVGYRHtadIiRnRnZe1xuv/gM7qQJ+atRCPTwhIBBPcufgh7ixguQ5KAZ0/5Ykph4Y9vJMNrXBEglsgtoI+7P2zkTpA8grFkVnG98Y2k/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459429; c=relaxed/simple;
	bh=SAHY+PdiUtzIBe+RK/fdpb33fipuVfGB2nKxKXSeyLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUpNmCw/xzitcOWGdRnLWFN7uSELTgPjOzZNR1u00UfUL4f1eXNv8er6xcqWzgC+FLhHHlkuvxsjonZfwo//6dTUg74LYisfgZ88cz/J5cL8HMraJLcX6rrRQaP1MSbiUpG51TaXbmbhDixsiaNpDv7OaiSh5h2NnaRguzEwu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z4PWlzAq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R5HgZfUM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z4PWlzAq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5HgZfUM"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 174941380230;
	Wed,  4 Sep 2024 10:17:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 04 Sep 2024 10:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459427; x=1725545827; bh=ixXb51MvR2
	NmbwtyEwguUi/dDme3vewRtZKE4RwCzmY=; b=Z4PWlzAqHYpGxyE70/Hmnq/wXO
	nmGKSgUvGguK/SmoMb2b+nScgMel7AFMYvYVuGuXQ5m5KIHBzbOaihefqAnSybc+
	dAkrRggK/zssf+XTwpiIofJbBOThtaut65vDg/GXXleEPbcpMsS25Mda4FuzkBRq
	VIg4NImiKm/CyaCSWahtNOpvfMj9JBgwX6Rx+fpbi7xVkb2qKvri08WijQIS2Usk
	1hBEjR0we73NdEMyB0t68N6GCAQVN+1KslrXvEp6IBf4kwTCmqIKQSKRP8dnAVDF
	ABdVXDUWwgkNX1zMpwjt35egn5K2QehmkSL83Uft6Clpy0XkESiHcxv/+gfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459427; x=1725545827; bh=ixXb51MvR2NmbwtyEwguUi/dDme3
	vewRtZKE4RwCzmY=; b=R5HgZfUMwPehcUGv+8uqoHlX+WijOK7hccSp+woNgnVE
	MPqbjB0DFLObLNbYKiBj1C9MWWGmeqTTYx3rQN59KhNTzxGpU2IvdxAI1E6Ckx7A
	H0OxCkHmrb6PYCYIMEoqcSMLifkMNyp3mmkxhnIzQWyJ3L6J7SJ0GJKFxkPl6mJ3
	dfTJay6wIK4NIkb8+I9RlKKmLCbDRNMmEZPXzeubVaD0cQh4YY1O7rqLAHcFlUIL
	54nKjuQIOOVzbbN09yxLYipBsDKDdMWUagSRlkbidHqvpLemn0KMCQ17k3rEvLjb
	ByqY4/MoAnPjbkiU/53AC3N02BlajB+O4TmpZjvDaA==
X-ME-Sender: <xms:4mvYZpkeKqqktfBSzJhEiLEYQmIIkyfYZyGN3Kmv8BjS8L5GDlLZkQ>
    <xme:4mvYZk2ZbnZcVNrcQrgOWV2uufzJkipTiRCRKqUaxyL49nU5QMC1i90kfqqUCTGZo
    SOhFCRRzEb4xSq6kg>
X-ME-Received: <xmr:4mvYZvrLLttVBoMh51zFJMJ2PLzB-89GLUVDhEI3f5AduWd5-HZQaCCpAWN0FIidKTOYAB7WDn6u_OWwG4f1aHteHMnsm12Ba0NoAYYOB1_ZMQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsth
    gvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhpvggtthhrrghlsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:4mvYZpnhinntKzJ_nBufrIy1-ERxZ4iMoZ-tMVd1S1J9xHaEhu1woA>
    <xmx:4mvYZn1IIWou-GzpAa2KtCsSpqV09K_9iFb7tx-D_vgZCvwaN8L4WQ>
    <xmx:4mvYZovHbtFuVd0Bjzk4schlJWvOiHCKWgzZ_yIhn8Xi0odTBqMSjQ>
    <xmx:4mvYZrVpM6QIg8bdyEyteuj8RasrGgGyYXGfhzf4GmxTJ7_ke9hpzw>
    <xmx:42vYZpyab6jsDKO_VklGdwlovUoQfvRembuYwvC_sUUGd4NuJg00_6Mb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:17:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 74174983 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:16:56 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:17:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 07/14] Makefile: fix sparse dependency on GENERATED_H
Message-ID: <b8f3f16dd2776b889922f7d07ee5d448268fac65.1725459142.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725459142.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725459142.git.ps@pks.im>

The "check" Makefile target is essentially an alias around the "sparse"
target. The one difference though is that it will tell users to instead
run the "test" target in case they do not have sparse(1) installed, as
chances are high that they wanted to execute the test suite rather than
doing semantic checks.

But even though the "check" target ultimately just ends up executing
`make sparse`, it still depends on our generated headers. This does not
make any sense though: they are irrelevant for the "test" target advice,
and if these headers are required for the "sparse" target they must be
declared as a dependency on the aliased target, not the alias.

But even moving the dependency to the "sparse" target is wrong, as
concurrent builds may then end up generating the headers and running
sparse concurrently. Instead, we make them a dependency of the specific
objects. While that is overly broad, it does ensure correct ordering.
The alternative, specifying which file depends on what generated header
explicitly, feels rather unmaintainable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 28742a60964..efd305ab358 100644
--- a/Makefile
+++ b/Makefile
@@ -3254,7 +3254,7 @@ check-sha1:: t/helper/test-tool$X
 
 SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
 
-$(SP_OBJ): %.sp: %.c %.o
+$(SP_OBJ): %.sp: %.c %.o $(GENERATED_H)
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		-Wsparse-error \
 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
@@ -3295,7 +3295,7 @@ style:
 	git clang-format --style file --diff --extensions c,h
 
 .PHONY: check
-check: $(GENERATED_H)
+check:
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
-- 
2.46.0.519.g2e7b89e038.dirty

