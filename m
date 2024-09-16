Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF848157476
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487166; cv=none; b=DV+U003/YKWgDpHSodcajGTpYYiJlHoqnKaFm9tpQtyzs96WXcqF/3DCEnC8hi/DZbW9ESF4O7O3yyJyKqsAObCwgTzkz+Fkz2ZJcRKrLWmzPfX1id052yJzDMOXRjNm2UAx+FChBeLAJjOz8GhqkDAj7j42WeCb1W0RXMxbDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487166; c=relaxed/simple;
	bh=qBEPRQvlxemZhQvyWNjTgnneRAZSg3GbNnrKOGmRMro=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swVWUA1IoMRiWRCvbVZDwYaZcQqUx4trOmEUCRyLO/zAEFKozwkttjk2riwlrCjaFs0Os+o/B0TPHe07nqIAv0VSbXKBkT3lg+yEKDV5RALGx68sRarAYjZQ2Z/3GH9fx5Js0EuXKql+s03kGJZ96bHu8f+kZ2AL0CHYOCGHLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kM+CmYAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jhI/Ri7i; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kM+CmYAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jhI/Ri7i"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id E28FD13802D9
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 16 Sep 2024 07:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487163; x=1726573563; bh=iZCyIkM3+c
	DWiX1gyqpos3rXPi080AUguuyvKb/GWQA=; b=kM+CmYANaFoMiC/twG/9cCS0Nr
	naUTethv8TN6z1bErHXMYR5Bin6sosfD3P1+ny6piKOSNoDubiERAr8k9mwVRY+j
	wXKBrwKZMs5brgJut53DnUgvjUUBbhouXAydJXCJT2cxbxSVY36vXmrswQkodkZu
	kFChZIs9J/iuaJXo0mCOYeHDHutouoi0qnCmz0nRciESTtPra4p8Y51OqEZh5UDg
	Fd0LKuD+rLKfrRCeyPHGXlDQ+JL1F+NjkaFzvD79gQJPk5SHuHzt1KtAm6Q0WsT1
	hSVDkwltDxccbSZiVHxgIebLxoomrVeDGatvvckEOivimveMlL45/nYDbHaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487163; x=1726573563; bh=iZCyIkM3+cDWiX1gyqpos3rXPi08
	0AUguuyvKb/GWQA=; b=jhI/Ri7iB2fxIkaZfYs246m6YHFfxRG45ASJAEd/ppqE
	+ZaZkW+zL/O+3HXwJK9dTDfF/Y/SdaC6545cD0+CWXUAZVE9CjdTsMGHDv5iQUkf
	TryNV0eXbhfRYDf+xfEV/Z3jjtHjhRpJzHi8+EwSfItgmaQZ32awfSlyyloJ0unA
	XZRHt6wnKsiMKjbkImFtptmzwX4jJb5MsjUAg31LORWwLRJgsGCC/Io75h41fv2o
	9cZ6mCqlZXpYI1UTaG2UAZUejC6ZyNV8+wrb2Eik+9wgnaMeTBFFgiDMqLpLyTpK
	X2LemWyQA9EgkgoW29iqXd77g17MqkawIwHhX16+WA==
X-ME-Sender: <xms:exroZjzYDXAXwoH3TV09qEoHCqB8Y_TBlnKnaqLa-DEP-rwj7S8rww>
    <xme:exroZrQVcc191eXtHvVmJMnxnHVzvNg9wpRe_d8kEu-KUXmSdSRL2OAxPm8TYDfgq
    6exCAb9gtNF8TZgvw>
X-ME-Received: <xmr:exroZtVN9iMDFAF-aYC_yzCHhOBWuky_yR5GPLYUtYh_P_FJE116Gj24d99Xf13Ca-0ToTXAPRfQUEvjXZ3ctA4h1b1McX9bcmK1OFHRA3Vl0Jmr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:exroZtjtC1W6ssFXI5RkqneH-kBO1v_LjoJEW-SomTLeTFcSdPOWOQ>
    <xmx:exroZlAZKL2ZUXR3ccTgqlTdMqqS4LFIoIt7xodnJYaY-aJyvmKFTA>
    <xmx:exroZmJDd8dqybh3DEXgjxR5fo4Fy9zH3kvqsu6p5-QqiE7r_DXHQg>
    <xmx:exroZkBOR6GrwgIvdPp1ZIyDBIRzm3XT4ZlD-LUuvgxmKSiVQ1CtQw>
    <xmx:exroZi7c0QLMPwW6Dr1BKeLkRl3nCZgcKEsCrZwfshdDmHrZ-IIflV1l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4697787f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:45 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:46:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/23] diffcore-order: fix leaking buffer when parsing
 orderfiles
Message-ID: <c975dfe462e321252bd4c83f4ed18bc7757204b7.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

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
index e7d20ebd2d1..912513d3e67 100644
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
index aec1d9d1b42..32c5fcb9a27 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -5,6 +5,7 @@ test_description='diff order & rotate'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_files () {
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index dc8ddb10aff..c0a4a02dcfa 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -5,6 +5,7 @@ test_description='git patch-id'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.0.551.gc5ee8f2d1c.dirty

