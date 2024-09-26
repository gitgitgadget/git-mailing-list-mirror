Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B01779BC
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351204; cv=none; b=trB/137JPueJzuFashAxAK1RrR0x26Hp4BUd8eqCH1tfXIc+TWKcpjnwvwQWDpMiSTYdWCh72jGb22TZARshwBG7D4FyFMGuQYmEayN7rgiRy71V8hnEvJlKd/2A8+UNPNchl2I4Km588rSeWe3X+yszmQxwHEvP5wVDVjAk6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351204; c=relaxed/simple;
	bh=34byaM45nlnPecc6+tcFvJyINJECNEBrNB1+QZpJ72g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VghcVo2u7E2onL4O2JDyuVgDX9Q72c/WwVvBdNYIXc7n3pd868I6Hx31vz0AMX/HvFWbGPL+VybvWTzdOfEaojZLDKrhZgc89Ee8NdKYYo95bhcUmYzJByn05/SqLRM7PMVUQtBafc7cLA9eF+jdPIJqoBZ1jbxYSmkmA1dRiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jngGqiWT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hq4BlTPp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jngGqiWT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hq4BlTPp"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBC5A114024B;
	Thu, 26 Sep 2024 07:46:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 26 Sep 2024 07:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351201; x=1727437601; bh=GxrpDBeRqm
	1BntXZg7goCJOp/eWEPJvxKOW9ewDUZbo=; b=jngGqiWTviq+YMqtzG6DRaekHG
	5unmYu7aUNedi5YM2dOfPpf+3ji3ExVLpttRl+wymhfJlUIFWEYojz6p5Jst+x1R
	KqllSnukdJh1RRgtducwVj9tpHPBzjYiS+f9T30SiM2BnHUThjcict5yJKCKyWqG
	JgezRLyGsVH6O4IunHKfklPZgWvWC1FN43xvVkWbi046QfJQ/MiAYRY5vIxTT+h0
	shZgCsZwzSH4sKUXPnLCxxQAIQPiZ4ByhaX7SIMmaEYk1AD5LZsdaIQEs0w89JP0
	D2Mcc4aA7AA+uKVh41r2GRFgJzYYTD1dz3yn9GldMdtrM0F898ozqZcNIA5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351201; x=1727437601; bh=GxrpDBeRqm1BntXZg7goCJOp/eWE
	PJvxKOW9ewDUZbo=; b=Hq4BlTPpFiA/tC255KDwPtdfsHdbErmT8YBTgpGzUerw
	gz9zfkhMbhph4iNnbkS05TrJeub16+C9yZAi9HZsh+LQ9b6JR9TqeNx+85gdPoUR
	c5SiNc3N9/qi2SDa//N1vlDnyvlJRgPVmlPa1oGP9nhyqYSHTMwwTH1czMUGBjzC
	2o5CfNBepLM3U+mBb1qvCu1v7qVPqqM0K0Qds4EqyWyKkppCsWzYjpo9UO30/X0w
	CxP8n3AOfevDtZDAgNqITZqnBjHi4jb+ZKcFLxLmqJLq+BcKZTFr08Z0FYWI6Ksd
	MIeKVuQfmNwPF4yFLs/OwfrVbSe79gjWyDlyKRCjnA==
X-ME-Sender: <xms:oUn1ZoUA3x7bbpTD89k1LD3vU5-LdbiW-eQhlX563FpiWMS3xfdtWw>
    <xme:oUn1ZsnS_JdtjSD4fBg8I6C2Cav2ZtqV61xqvQCrVewB_xht15maYR-N-YKdzQsb2
    NASsYfjNIVoWFMVCg>
X-ME-Received: <xmr:oUn1ZsatsnJVXJyAIMAAWzw47Pufh-hTKaMWbYN8lYwZxC1oI4lHd07qcbxC2rEWFLtVKuHP4icxzf_dkws9X9uVhZ-FXa-07fCEDz9g1wNILQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oUn1ZnVNn4k1DHov9EZqZHQkZu1T6mL5d8kzml_a7KADYwyKCWvUOA>
    <xmx:oUn1ZinditKJjgoLSPbbJaH6DCWYK1oA1qYprtXe4lN23dqi9IvzIw>
    <xmx:oUn1ZsechVh2DP3TuOKkzlSCRpoBu6cWgXsMr488tnmRkQgn64CJLQ>
    <xmx:oUn1ZkEc0EcoRTG4u6rUtCC7oniCsLBrDfAiORQcxXJAphIfxegXow>
    <xmx:oUn1Zkg0BI0PE_nK2KClamYNm0yprYhP9XTF9jMjxcjUaQVCz6etUFOk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 325dc1d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:46:02 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/23] diffcore-order: fix leaking buffer when parsing
 orderfiles
Message-ID: <cd794220878a5bd77e864e293e011d2e300cfd9b.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

In `prepare_order()` we parse an orderfile and assign it to a global
array. In order to save on some allocations, we replace newlines with
NUL characters and then assign pointers into the allocated buffer to
that array. This can cause the buffer to be completely unreferenced
though in some cases, e.g. because the order file is empty or because we
had to use `xmemdupz()` to copy the lines instead of NUL-terminating
them.

Refactor the code to always `xmemdupz()` the strings. This is a bit
simpler, and it is rather unlikely that saving a handful of allocations
really matters. This allows us to release the string buffer and thus
plug the memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diffcore-order.c      | 19 +++++++------------
 t/t4056-diff-order.sh |  1 +
 t/t4204-patch-id.sh   |  1 +
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/diffcore-order.c b/diffcore-order.c
index e7d20ebd2d..912513d3e6 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -14,8 +14,7 @@ static void prepare_order(const char *orderfile)
 {
 	int cnt, pass;
 	struct strbuf sb = STRBUF_INIT;
-	void *map;
-	char *cp, *endp;
+	const char *cp, *endp;
 	ssize_t sz;
 
 	if (order)
@@ -24,14 +23,13 @@ static void prepare_order(const char *orderfile)
 	sz = strbuf_read_file(&sb, orderfile, 0);
 	if (sz < 0)
 		die_errno(_("failed to read orderfile '%s'"), orderfile);
-	map = strbuf_detach(&sb, NULL);
-	endp = (char *) map + sz;
+	endp = sb.buf + sz;
 
 	for (pass = 0; pass < 2; pass++) {
 		cnt = 0;
-		cp = map;
+		cp = sb.buf;
 		while (cp < endp) {
-			char *ep;
+			const char *ep;
 			for (ep = cp; ep < endp && *ep != '\n'; ep++)
 				;
 			/* cp to ep has one line */
@@ -40,12 +38,7 @@ static void prepare_order(const char *orderfile)
 			else if (pass == 0)
 				cnt++;
 			else {
-				if (*ep == '\n') {
-					*ep = 0;
-					order[cnt] = cp;
-				} else {
-					order[cnt] = xmemdupz(cp, ep - cp);
-				}
+				order[cnt] = xmemdupz(cp, ep - cp);
 				cnt++;
 			}
 			if (ep < endp)
@@ -57,6 +50,8 @@ static void prepare_order(const char *orderfile)
 			ALLOC_ARRAY(order, cnt);
 		}
 	}
+
+	strbuf_release(&sb);
 }
 
 static int match_order(const char *path)
diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index aec1d9d1b4..32c5fcb9a2 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -5,6 +5,7 @@ test_description='diff order & rotate'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_files () {
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index dc8ddb10af..c0a4a02dcf 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -5,6 +5,7 @@ test_description='git patch-id'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.2.852.g229c0bf0e5.dirty

