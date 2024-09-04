Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF91DB92B
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459435; cv=none; b=nAgfFxLwlAEQErLAT9Ef6EXupIOz2J7bW91meMV88tTXVKEUf88WMlkfmDkozAa5hP3n8ALPnScOAZFjO8FDoGqzUFutYkD52c9RiMxL6le0UV/uAQiK/tKhCjLQNCc533t7jO9bV6MJ/YMxHaKIKnrmkzTH+PZNYufn5uK2eCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459435; c=relaxed/simple;
	bh=dqzaETBGxdiHXzqB09JdVEn1V1p5auGjZ0UFeEQ/a5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQFnFrzFETO0aQcAwhOyZx2StnR8mO8UyHAHJ01pwzzBB/K3BEzkQ+xlQD5cWD+BBck++twsNXqdFHxrBFbpDfQSHn5+pWdlBlon/HJRMvJaiz2EddqOOk3Ckv6U2EFQk08lC3uIiJkL9rrEFt0vtLPdzeracqN2k06pmuiI28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DPxqxfCm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z/nyEPlP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DPxqxfCm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z/nyEPlP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id EFBE11380152;
	Wed,  4 Sep 2024 10:17:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 04 Sep 2024 10:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459432; x=1725545832; bh=NQhaS+XdM/
	vbXpQunNjkJZgeLFZHyJtFBNNSAXi4MTU=; b=DPxqxfCmREv94PTF4i8O4nN/ig
	vW5GZpoM+ga2y3YuaCstMjsdvP1ZOCdZ11Om3lcXtRDV/ZM1wJgTP3HB8f1/BVck
	NgcYHlKqXaMsg0rPy/VIpmJ0YCOopp0o/iIexzNIDjaNUratYW5Q8J7b8m6kvC5+
	A6puey3igzIQduLGjKHNGPSK+TIuvBZwoIYKVqz874lX7vhUeqkQMGT6O58XuD35
	WmuRujv6ilqmz8LwAycmWXRdRh262NQqEGyvYlqfnKhYaSEPWEhbZc6z3cVkM2im
	WHGnn2GQ/NmnvH4LezE1Wl2XoxgdVdoeqRx+UtJHx6knvmVww6G4YHx2aD3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459432; x=1725545832; bh=NQhaS+XdM/vbXpQunNjkJZgeLFZH
	yJtFBNNSAXi4MTU=; b=Z/nyEPlPz6hWEp4/t3TarXPx2MAAlRfQaOmqMqEPREFU
	wEOPQm78EZgnl7TVXM1gGAlSSuqpVsjvtDVZNMIRBAg08EUpvem5Qkgfsn+maire
	SfoBAub1U89yAIXGWkBZt7xUh1PHdkxgh0Lt7GNPwba0KFL7lcjkY8B5Fqw5/mUb
	Mr5xpEsxcqL0mGDXWe/LCeEb95fAP1QaoVPe04tBRaOjBeQoZ/0dJHhF6AKdZQgF
	JvEeJFgtTB1a6jxs128G8bMV2I5CIfqI/CJy+Spz4B0CpbS+af8f/f29QhegWobi
	ZLJxZp7I8ilKtux2x3UkEuD5fld+GEHYkMG6cY7sbw==
X-ME-Sender: <xms:6GvYZlvbLzUS2kzcsFHZJWJ00oFSxtD60aYakPaJsPNHj5h4xVjBOg>
    <xme:6GvYZudDTg5gXE7gCRtqTJa7zFd28eM1h8u2YAlVlJkJ5C-5bLPRBuW0UyRUMhBJu
    lmGALL8xpgRr4i4xA>
X-ME-Received: <xmr:6GvYZozLqErcipNPlchekGTfXOHI-hiwZi4f8c6fjJ7gbOuWaHtXilUXLvYbmgL9a0NPGeW9p9VUs4HFvqtBzKauPzUE8AFlVM0chEov-HsSYC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhn
    rdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgt
    phhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhope
    hsphgvtghtrhgrlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:6GvYZsPescIaU0-p-0WyaxttpAeqdgBwN7BMzoi5ecEcw19scMOqLg>
    <xmx:6GvYZl_P5mXfkdU1rIwQNOgPT7--z8JKTGr5gLG28jGdQe4CQC_RNQ>
    <xmx:6GvYZsVBENADh3x3opnBXAYpttSZTui6GolKMclztJ3Ao7cmYXdCyg>
    <xmx:6GvYZmeQPBx2VQtvMUcWQL7vjTFIG7YUZExMCGa19kvNy5wjqa0P1g>
    <xmx:6GvYZkY2WAB7-g6xRBtXb55_nvPUZyrWDYvtefdlH36mKhdp2pIHo3Za>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:17:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 86b7b96e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:17:01 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:17:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 09/14] Makefile: do not use sparse on third-party sources
Message-ID: <7d0f494850a48e5285e8823ff9252fdcf531439e.1725459142.git.ps@pks.im>
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

We have several third-party sources in our codebase that we have
imported from upstream projects. These sources are mostly excluded from
our static analysis, for example when running Coccinelle.

Do the same for our "sparse" target by filtering them out.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8c4487dd0c6..81a47b61327 100644
--- a/Makefile
+++ b/Makefile
@@ -3252,7 +3252,8 @@ t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
 
-SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
+SP_SRC = $(filter-out $(THIRD_PARTY_SOURCES),$(patsubst %.o,%.c,$(OBJECTS)))
+SP_OBJ = $(patsubst %.c,%.sp,$(SP_SRC))
 
 $(SP_OBJ): %.sp: %.c %.o $(GENERATED_H)
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
-- 
2.46.0.519.g2e7b89e038.dirty

