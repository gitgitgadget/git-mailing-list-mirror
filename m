Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA93D4108
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876679; cv=none; b=NIIXwU+e9ETIseYiefmgnQs4f0YiqQntwY1NxiGaWpd4THGNv3h9UUNW+1GbaoytgC0+C+38F4+to8QZqjFDOgfYidhUEll6iDksvK9yIEEkICO8IqFxFfF2RLxCYnDhgKoxnZHqVPiUnueW5ohleJqO0qNJ/vWK0xGUX2Zc95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876679; c=relaxed/simple;
	bh=yvdu3rrNnLSsm/dTyZxA3aZz73oD9ILbjHc+RkMrAo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xc8lKRhqOXg0A/Gli9k//NzjEjiI3QlH46aX6Zc9nTDbXbFLK3FbzC3BErdaeWGAXgpAhUzKD8D59RAHnbeBO1gk+OuLeEHoMV3vf8Bi8xBI6wt0p2RcToN6bK/85bkpigxi6fQPCbZ9T+WqGlx56KqpWVmC/9FRGByo7EqPNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZtPjoBD3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JNwXs2xq; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZtPjoBD3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JNwXs2xq"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D20EE1D0016F
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Mar 2026 09:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876677;
	 x=1774963077; bh=1enG6Au/blaye+We9iAiY1/vs/d9g8J+vUnS0WRDqZY=; b=
	ZtPjoBD3bI9bKNwAnyc/adO3QXhXAI4njOBO830Vlw1ZluDO4RPi9luEVdI8o79a
	NzA2M3hc+JdFRGFigeX1Zn/5q/VQ423eG9wvbj7/BLJaRNaLzlMoyJ7i0bbzWhoi
	tKumsSS/D26+bKKRUfZHopPy6NYFXigJnd8Dvp9JJzVkuOPT+JtKgG7c/M+G6CVT
	ritWZyxaH2rr3JdHE++14jiUYXbrPzp3zJox91G+83Wo4V469cG1HDwOvF0U3AU4
	IF0IGtp7UaVn9pAklLRG85sY5QKkLLP/DXbR6BkvR421SHRav7xAdKAvCAhMR4No
	uIopI4iR5MfhT2EO6wNMgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876677; x=
	1774963077; bh=1enG6Au/blaye+We9iAiY1/vs/d9g8J+vUnS0WRDqZY=; b=J
	NwXs2xqR0i7xpowNelvbl+8AdSASqEt8xtawcN3/j0i6YmFwXy+eZRGyAnzzXAIT
	ECiekImnQFIt5V7Al8NfgFIUbI9+7I70lOsEoL/++WnpMayl5fjoC6j5wot46nKP
	36859cA8iCAsZc/s5w5prLVRknfd10Gk6phIiKIB6gpkAqzaE6Ip7ZIWs2WA2t9Z
	H5w62pXl0urjZwu3T5bmQCarYzhXyYnbf7lqyUacI1Zxg+AdtGS14c24TEt06myW
	cGafjuTPH/Ew5Vmc7aoJ9duVICxdAWt9lFa4AYqYDfL/ASMpQwwk7s9bLlMNZdkT
	DF8xdNozGOEKGzIv3v0wQ==
X-ME-Sender: <xms:BXjKaXAXp4yp7c5SIEaNV0jCPv2b-MU2p53zJ-8ceAbNbhC2LwtDQA>
    <xme:BXjKaUevE2QSHEJFHz7u9oXlkaZPTYh5lmOsc6rH7TP4oN1EE5WVKaBqtghMvwQVV
    mZDCHKZbVowrEDsfRmYjVhDytgxcfngfOfloBSjJ1wBuvm9_8a0eQ>
X-ME-Received: <xmr:BXjKaYPWce9PWQDIKc2OEmQyTx0aKkiVcXta0zpKW-8ufqk_wsssQR8v2fEBZ71-rrazEpdZAye7vGmMGUrme_Zxt4rEbpxw0A4xpl11QEM12g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:BXjKae6Ia_0pQrapxUQRcC6gwxWbZTEJbYBks-V8M-M8WrHbfH93Mg>
    <xmx:BXjKacIWXMQUNqeQ7A46xbGNde5nl-qJXUPRB_qwDqWLCwj91xRe7Q>
    <xmx:BXjKaYfpKlBrfrSqI5DEY9TMbuW6COEdfpbexEBm1QfNEDp7COJjeg>
    <xmx:BXjKaffBhxmyxDvFmV6XEcMjdRR8M02ahQ12I8z-lPv-YRUdxsiaWQ>
    <xmx:BXjKaeDvK93qJ-QoFTxwhqmKU2PeliOPoiVKGI80WfyGl2JDrmomagwU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8b7eac4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:17:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:27 +0200
Subject: [PATCH 05/18] setup: stop using `the_repository` in
 `path_inside_repo()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-5-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Stop using `the_repository` in `path_inside_repo()` and instead accept
the repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c | 4 ++--
 setup.c        | 4 ++--
 setup.h        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 0b23c41456..7ddebce2ac 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -471,8 +471,8 @@ int cmd_diff(int argc,
 		 * as a colourful "diff" replacement.
 		 */
 		if (nongit || ((argc == i + 2) &&
-			       (!path_inside_repo(prefix, argv[i]) ||
-				!path_inside_repo(prefix, argv[i + 1]))))
+			       (!path_inside_repo(the_repository, prefix, argv[i]) ||
+				!path_inside_repo(the_repository, prefix, argv[i + 1]))))
 			no_index = DIFF_NO_INDEX_IMPLICIT;
 	}
 
diff --git a/setup.c b/setup.c
index 331ea86a40..6cfb05c527 100644
--- a/setup.c
+++ b/setup.c
@@ -160,10 +160,10 @@ char *prefix_path(struct repository *repo, const char *prefix, int len, const ch
 	return r;
 }
 
-int path_inside_repo(const char *prefix, const char *path)
+int path_inside_repo(struct repository *repo, const char *prefix, const char *path)
 {
 	int len = prefix ? strlen(prefix) : 0;
-	char *r = prefix_path_gently(the_repository, prefix, len, NULL, path);
+	char *r = prefix_path_gently(repo, prefix, len, NULL, path);
 	if (r) {
 		free(r);
 		return 1;
diff --git a/setup.h b/setup.h
index 24034572b1..c3247d7fc8 100644
--- a/setup.h
+++ b/setup.h
@@ -146,7 +146,7 @@ void verify_filename(const char *prefix,
 		     const char *name,
 		     int diagnose_misspelt_rev);
 void verify_non_filename(const char *prefix, const char *name);
-int path_inside_repo(const char *prefix, const char *path);
+int path_inside_repo(struct repository *repo, const char *prefix, const char *path);
 
 void sanitize_stdfds(void);
 int daemonize(void);

-- 
2.53.0.1185.g05d4b7b318.dirty

