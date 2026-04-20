Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B360296BCF
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670057; cv=none; b=nypHYknEkoKhOadgJAFtCejpq2cx7Ue4uLNzPoG53SNwc5LQ25At/U0ZEZuDR39Dvwgk5uyU6TvAmPqo3dx4mzoehT54oQoe8enzHLHsaMkHb7tlk+m/U39Wbq827xgLmc3wYPOAhxnbrLEevm7TR+RhBlUOYItISAFkQ4Yf9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670057; c=relaxed/simple;
	bh=QwaFflupcgZGtUiTur+0TZkVNF0tju6K2qOV2/CElLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxc7G64Kprvf+QxfzsyhXOAR91YHiZ9/g4QpfBIuFnWV4E8goOioM2vlp5uvxehyaglnsm/sE2kogFZtoD1Qqz8xMWG4LJEu6z9GxFTqse0oK/g+HTc8D5WAKHXmXp0Zxnd3pkVQgDrz2cXkJkU3fP0x/Iw+1vlEU8+CqzPBO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UhCrOPCQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6hrSnfz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UhCrOPCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6hrSnfz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id ED726EC00DB;
	Mon, 20 Apr 2026 03:27:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 20 Apr 2026 03:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670055;
	 x=1776756455; bh=JH42nt/3fO7vfbU6MbHQgipsNo7cRzzerK9UINFMLgo=; b=
	UhCrOPCQo6GdscJ8qXO+tksi2GZsm8v+zB030XmgZI1XkdKhnokfBBnwBjfzdbg0
	huLiotZ8Gk2u2t5E9LOlFSAbPJcMoXNgyVwN4uhxmd0DAEjKGk/MmtaypD6u7XID
	doWDo98s7vfVgzDXjRJ8UgXsDG27PK/kJOW+Ocjh5zLLFIQku8m0G4zD+AW8Qc0q
	udj2OtyaabRf/SRpBOtSKHfUQrDSZEqQBkpMHgOb9S71gj+uYMkMWKOOrot5TBGr
	Lp8b7anIO6rjQkJbyMiPsHCfwKYz2f40gZiNW9GcJt4Bcn9QPc6v84FKc0tJcAjh
	xRO4nnDf7klU+Fd8AdntCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670055; x=
	1776756455; bh=JH42nt/3fO7vfbU6MbHQgipsNo7cRzzerK9UINFMLgo=; b=B
	6hrSnfzdLyv1csAJb6IXPlv0NLg7ai9uAB6E3Vt72D+xJsRdMg9QC9z/vqFqKXbY
	PFfaiB6R/X3bm3PiIWjL/DicrzR+wNWgLNfD5depM923ihyPcYUal55L8RXonyvg
	irpcHzq7+jS8UVyamYvvBr6eOVHnBEj3flSqX6sdGtFyM97OCmPfUyqrLiDonA/g
	IQlFp6XCIryZ8Vz1AmB/YFhmuNIQFopIb9jzPQI2zSaZaQ1N9LriXRe+dy5Omspu
	xzkd7B7nMsf2BlCVJ1IdbJNonEfqTssEWHw2Gy0rqUe06LNKLSpJSyJW7B6KCdsb
	uRThSWlDRDZGfu1+m5j/w==
X-ME-Sender: <xms:Z9XlaWH8eDKtlTt-qNciQVVtGGa4SDBt-eOGu3laiNwRjFWwk8BRRA>
    <xme:Z9XlaeVb3VouAN8ntb8kse7BFwqdtV8cjkK127kUemluHDWGh1g6BQKhqJWi3ebmI
    JdOtBEPFL7lDOps7iDel_JJ-RiIvVFm0HW0kNvJGPlX3uU2cglvXn4>
X-ME-Received: <xmr:Z9XlaVLs1UsG-X8pTxS-fzi7Ng8yyUfUefHMbD6ZeuOgBq7b7I5g_THr_C-3Wq022YteuiBrL9CDqZ8q8osODEogbPCosgrLXYlOPu8jznWr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:Z9Xlae9YH00E1lAhUtPc7RBNT0eokvUjL-x-nNCVhaKOT3WzShX3zA>
    <xmx:Z9XlaYLN1Otx4EUmW7_S1JRmD70qqZwJuunrGAuWIfEwRR_evAiJtw>
    <xmx:Z9XlaTmarBjJ9RStme6ycWOeF04bSK6DAzG02R7imPk7Hldb3baJvQ>
    <xmx:Z9XlacPzg7YEcU0ld_u3v7_wK83ONm8XqdGD_w0lurWufuC608NTHA>
    <xmx:Z9XlaVE2UtVUCEMtntir0NcgqV_PkRTekFBDvo1JIYIh3tIR415DRbKp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 275ad21f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:22 +0200
Subject: [PATCH v5 03/12] t: prepare `stop_git_daemon ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-3-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

We have a couple of calls to `stop_git_daemon ()` outside of specific
test cases that will kill a backgrounded git-daemon(1) process and
expect the process with a specific error code. While these function
calls do end up killing git-daemon(1), the error handling we have in
those contexts is basically ineffective. So while we expect the process
to exit with a specific error code, we will just continue with any error
in case it doesn't.

This will change once we enable `set -e` in a subsequent commit. There's
two issues though that will make this _always_ fail:

  - Our call to `wait` is expected to fail, but because it's not part of
    a condition it will cause us to bail out immediately with `set -e`.

  - We try to kill git-daemon(1) a second time via the pidfile. We can
    generally expect that this is the same PID though as we had in the
    "GIT_DAEMON_PID" environment variable, and thus it's more likely
    than not that we have already killed it, and the call to kill will
    fail.

Prepare for this change by handling the failure of `wait` with `||` and
by silencing failures of the second call to `kill`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-git-daemon.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index e62569222b..d172aa51f0 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -85,14 +85,16 @@ stop_git_daemon() {
 
 	# kill git-daemon child of git
 	say >&3 "Stopping git daemon ..."
+
 	kill "$GIT_DAEMON_PID"
-	wait "$GIT_DAEMON_PID" >&3 2>&4
-	ret=$?
+	ret=0; wait "$GIT_DAEMON_PID" >&3 2>&4 || ret=$?
+
 	if ! test_match_signal 15 $ret
 	then
 		error "git daemon exited with status: $ret"
 	fi
-	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null
+
+	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null || :
 	GIT_DAEMON_PID=
 	rm -f git_daemon_output "$GIT_DAEMON_PIDFILE"
 }

-- 
2.54.0.rc2.529.gd9106f7525.dirty

