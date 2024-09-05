Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA119995A
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530979; cv=none; b=TzXn2rmmGiEPykyyzzt9Wg/DkqC46Gi2lLAM5XfbD3g2IZ5st2aaOGFAs73LgZ7sYMWJZ8/XD3nEqFof4pg4b2DAPpBXMTXX1i7Yk06R9+dI4Q00tJ2y2sFigI38zfiGsdOa3dzzXQ+tpzbERW39hlbSMd/hK3tNpRmvV+okh/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530979; c=relaxed/simple;
	bh=OxOPufwWt4I+Xy6TVpcs4o6LK7uvwjctX6/R0lgP/Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Awj/6KTcCDSX19vPTGgB5Fx0Fj53tfkmTu+DkvifRR6+BTVQnPWbhzqyaU1a+wKyy1z5zOiDIh9ySE32dGlPQT1m6KTvyJYl+jC6q2rKWPICUinqwZvctX62YTb42heE6mfX8Yk3UKGTdHNVkwvjd8MoqPCHPLlAyL9XN2G/Aio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lKigbZ9B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FoZLBqxQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lKigbZ9B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FoZLBqxQ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A2F21140142;
	Thu,  5 Sep 2024 06:09:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Sep 2024 06:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530977; x=1725617377; bh=5b+CqJcTg4
	wpeAtbX8NmdmGooZQyZNQpuh8d6eXETFY=; b=lKigbZ9BuxRf052bPzfOxGOwWH
	Pec5UyhRdlRhsZhDKx2S4bqyb7GOnjYK6hEwBK/GbDEalSAu/YXWsnuSO3qbJsU4
	rDIEa/13dprN0ZBYwsjHidcfxPu4rzFADhQ3s6DkIJOk/DFThL5krhmF3HkrK3o+
	3h0PXSXRYF8aLqcfQN30ZElpKsJha0GN5FXIhIs8SGK9MP/8jyDrnYeqrxUvcSz0
	g4CBQaf15KlkKE+QyNE3PizNiJOOJDd6dhnR84jRKJdNhfXGEZUyBEuagFr9aGqd
	aeI4VtqkwWI0FNvgslnhsaJD/qU8zw2NGrZ8cyVEkCschyI2Kv/4QHTQ+FWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530977; x=1725617377; bh=5b+CqJcTg4wpeAtbX8NmdmGooZQy
	ZNQpuh8d6eXETFY=; b=FoZLBqxQvRcgssC67QwTPU40RZaXJzJyXbqDuVdAORYN
	OoVUIgVyUxKtcjRc9hisR9lnxjI9NBbw1UoJ43s63XbrJZQ7Mu+2vj6qTMYdBu2J
	XLzVGTPLY46KZjZSJBNpQ0pFQcNiDksQr33UeyX7gw/6C4t2z8MXqofsX4PgrZzl
	A3o9wTqOcZzYt8/Cm+E9/WOUsAtEGIjhlHhgaWSYwPvir55P5uRkLROEd8z+2wX8
	jlVAqnFix8SAI15XPmV683n4KicjVp/nOHhM2uDkFT5aZSIH68CwMzhnXPgw44al
	S+Od25kyZ1QY3nPwyZEeP4uCYezgcGrc1HmvYjKqUQ==
X-ME-Sender: <xms:YIPZZvPlDZxzB_dFO8QlamG-jTxa6AMAse-7ooaABheTTHxoMtJfOA>
    <xme:YIPZZp9WfewEsAaXLDegs0bxqWfumA3XLqojFDdNYnGZq_7PNq8EAYRoHiOCeT2pN
    80i-TagdxSd4P0dUQ>
X-ME-Received: <xmr:YIPZZuQTJQFwXKE7VuOQsrwim3BFXT9p7q-LNtc70gSC_c9SBFAUXuRQPzE3R_WS7biGlozD-_myecyGSdAIEXhflep941CpoI65atkmuhQuBZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegt
    rghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:YYPZZju8ux8P9yKxF7BV2rJfTtNlr0jfjctHN-nrFvc8Zce9GRLAGw>
    <xmx:YYPZZnfrsxpi-3bdfkBanaE4PPFF6gqe7QAuTjCisZ1msLHv-7977g>
    <xmx:YYPZZv3HwsjYQ8EkWy1tXV2CY2HkTQxBR1P7joSMeOhriQ0gv8_u4Q>
    <xmx:YYPZZj8GdrBmmxK6_s9nMSra5_Hq2nCQaA9mUPW0lz4A0Md5jkVqUQ>
    <xmx:YYPZZvSt3LiOzjH7Rqmk9AZuwzbq_3QzPrxVCcGSN602YCozvlhwSdcm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2aea191 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:24 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 19/22] builtin/fmt-merge-msg: fix leaking buffers
Message-ID: <84b68affa0d8420ee907a6bb1af15c7f37b13485.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

Fix leaking input and output buffers in git-fmt-merge-msg(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fmt-merge-msg.c  | 2 ++
 t/t6200-fmt-merge-msg.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 957786d1b3a..0b162f8fab1 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -67,6 +67,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		return ret;
 	write_in_full(STDOUT_FILENO, output.buf, output.len);
 
+	strbuf_release(&input);
+	strbuf_release(&output);
 	free(inpath);
 	return 0;
 }
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 5a221f8ef1f..ac57b0e4ae3 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -8,6 +8,7 @@ test_description='fmt-merge-msg test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-- 
2.46.0.519.g2e7b89e038.dirty

