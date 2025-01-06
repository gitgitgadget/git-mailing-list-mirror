Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6FE1DC9BB
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162222; cv=none; b=blANXYHMLIiA2IkxD1EBGLbaSQodDBXRvI3td+kQYZkAAqKJGrxBJGY5XeNeiBwg2YLiUcu0ILm3HXHH1Pl1f8au5lI3XcajAIKL/nrKRBZMNerFQJPN3b/aFBM2rG0VUmEhtmcTl1YIyeShntPc4YYEDDrGQgt/g+uGFh3R+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162222; c=relaxed/simple;
	bh=z2yXrFIIx/kzY+XRyEzDmzKJ2mEeomjwJNLuoJsBiHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZve+PEm5Oj7a2XzonrdC5wE5ITTlNKk0PcSHKXB48uQY6KLu7/rI5dbOv5YZkL+23UphqHTvILHt7dQvlF9imKbMz33MvPQzO0DxbAbUa0d1FCkSbzTB54DmGrR1B8yckJwmFu7e6rcqEUhoxAhFvSzeCjn3ZC7vS6r3rNfwFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NWr/zaCB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t/eDSZiq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NWr/zaCB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t/eDSZiq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 020F0114015C;
	Mon,  6 Jan 2025 06:16:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jan 2025 06:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736162214;
	 x=1736248614; bh=xDGWAlUYMLnmvk9Zdzu5+T+r+PHSVzDC+gN0Cds64ls=; b=
	NWr/zaCB464kFWMFfvRUKMuITlJqaS4xc2tHqB27msrE3nL11tYutXRK4kYr9Akz
	ke77U7XxQxOKU6RbPTN/wn4dZEpHZmoLRD9kEiOAwbYcy9JRlds18Nk/CN/IwC+B
	VRWKYXzOqNuZcpBcbK8BCvqMiCNnz99qxcdYNA/WyInNQPeLLYbz5Pt2VHMsnue7
	ZxVGWiGWs0ftpiJkAW9Kgp+xDo702V2P5OXGIdsX4dsBSlzTBStdYt2aFM31KQ4x
	+Piuqz7rdzPSWyyAPufhpIzLL1jz+AhpBW79cSlactTiceXK8Oh3FuHtnuNliPCH
	kty40HNcbpZ+JLudPHhzvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736162214; x=
	1736248614; bh=xDGWAlUYMLnmvk9Zdzu5+T+r+PHSVzDC+gN0Cds64ls=; b=t
	/eDSZiqGoCyYsJ1YtTgwLNFvLMDsCssjJve+cVTxdAPF3iy/jQnOdhdwa/QJz0mv
	FPU/VMlgpMiMiyWY1KcKt8WDM3sTtRMxsrDQ3x2ZVbfWfPLLvSIU4rE4Y81get9w
	mc2+znGycqasgdAyp1mBygCuX6Kfri/tQV5bYpnrxHUGqhgIxCtoJPCikEchIZIX
	w2uGF4pLYVaLRmTG1aChZfysjM8oh20kl614y5BjHdjK4VjDaYO9etA1O87JQSN0
	G9cC+0Hv091McD8FYpXyqKh3EPtpJf/Q4HP9ujHXkBFuV04bNc2VtVxJTh1qgzwA
	xF4fux2TO9C0siXjnuNaA==
X-ME-Sender: <xms:prt7Z7Ac3B_Yyd4KgWmBeGFTY5Uv-iJP0DndcYWJTxDCj8M5boe8Bg>
    <xme:prt7ZxhztKy1bIF-ZeC8b584fTTgWLnQ6au-aARWuWd9-3g6wP00rNleNr_aSHpqu
    aiBR6D68Wu7ExSnIA>
X-ME-Received: <xmr:prt7Z2npvIkwEsLOwn2CcnsOhvOzYAXTVptMwf-Za9pFYZAOlsoxw1TL6t4tc6UmybL6L9csKmpvEoHP7W2berTq6iilXKskj0DhpFjzqmz_bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:prt7Z9wj0941Hx2UDOX9CRV5EiKpjWrhQsuw1w9OhfLfETPHNDl7bQ>
    <xmx:prt7ZwSxMaXbSi2XBhnNlHsZRWWDmD-4qDFQ2syONgPHbZW_EQgtkQ>
    <xmx:prt7ZwaTyCNLhEAuL1yAQJFH-OLAwh1o6OZHmCmsd0ZScd_BjMigVw>
    <xmx:prt7ZxSPo6A1T2b3af_W0foIFFr3xvYdmcbyvD6AG8e9Twph8xYs6Q>
    <xmx:prt7Z2cTsg8VmivicSAKe-ZAe5P21f_BZemgqZXG6Zcfg0OJMe-zBSCb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:16:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 799033a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:16:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 12:16:50 +0100
Subject: [PATCH v2 01/10] t0060: fix EBUSY in MinGW when setting up runtime
 prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-ci-fixes-v2-1-06ae540771b7@pks.im>
References: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
In-Reply-To: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Two of our tests in t0060 verify that the runtime prefix functionality
works as expected by creating a separate directory hierarchy, copying
the Git executable in there and then creating scripts relative to that
executable.

These tests fail quite regularly in GitLab CI with the following error:

    expecting success of 0060.218 '%(prefix)/ works':
            mkdir -p pretend/bin &&
            cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
            git config yes.path "%(prefix)/yes" &&
            GIT_EXEC_PATH= ./pretend/bin/git config --path yes.path >actual &&
            echo "$(pwd)/pretend/yes" >expect &&
            test_cmp expect actual
    ++ mkdir -p pretend/bin
    ++ cp /c/GitLab-Runner/builds/gitlab-org/git/git.exe pretend/bin/
    cp: cannot create regular file 'pretend/bin/git.exe': Device or resource busy
    error: last command exited with $?=1
    not ok 218 - %(prefix)/ works

Seemingly, the "git.exe" binary we are trying to overwrite is still
being held open. It is somewhat puzzling why exactly that is: while the
preceding test _does_ write to and execute the same path, it should have
exited and shouldn't keep any backgrounded processes around. So it must
be held open by something else, either in MinGW or in Windows itself.

While the root cause is puzzling, the workaround is trivial enough:
instead of writing the file twice we simply pull the common setup into a
separate test case so that we won't observe EBUSY in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0060-path-utils.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index dbb2e73bcd912ae6a804603ff54e4c609966fa5d..8545cdfab559b4e247cb2699965e637529fd930a 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -592,17 +592,19 @@ test_lazy_prereq CAN_EXEC_IN_PWD '
 	./git rev-parse
 '
 
+test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'setup runtime prefix' '
+	mkdir -p pretend/bin &&
+	cp "$GIT_EXEC_PATH"/git$X pretend/bin/
+'
+
 test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX works' '
-	mkdir -p pretend/bin pretend/libexec/git-core &&
+	mkdir -p pretend/libexec/git-core &&
 	echo "echo HERE" | write_script pretend/libexec/git-core/git-here &&
-	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
 	GIT_EXEC_PATH= ./pretend/bin/git here >actual &&
 	echo HERE >expect &&
 	test_cmp expect actual'
 
 test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' '
-	mkdir -p pretend/bin &&
-	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
 	git config yes.path "%(prefix)/yes" &&
 	GIT_EXEC_PATH= ./pretend/bin/git config --path yes.path >actual &&
 	echo "$(pwd)/pretend/yes" >expect &&

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

