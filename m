Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918BC2D738A
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670054; cv=none; b=RfIQPHRt5IYth5oK45GNF8G+H2EDwm5rfZbNWc0Jd8XTFIcWRbqGEREFMmyT7CiJf+dws3YIE3pqjQRcfn+A5nUvXcr8AwJv0tfct1ZqqeiSykyxiFe52zFBS4XhgqgNaE1r4iFxv9QW14RCEquroCNvIqkUJohQwagNH3C4Rxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670054; c=relaxed/simple;
	bh=M86DqBMf8uVizZ/m2UEhAdaZAuCt/HhSBndih+XWFrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIgorPw0rDlxGKLseA8Z8udr9HM6x9FvtqwfwGpV/KNPhTPY22oP5cAYHaqo2LDaOopGftyarCO6tsfuOF3pdRTX97IKd5eoA+p0jUDdzjxUf/xzM4fLlWtzYjQoR4H389Wv58SBPQYv9kuZaoMi8uVxeAY1ohoy8ItGcKS0SPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HL7NZb93; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R5OgHKWl; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HL7NZb93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5OgHKWl"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFC7E14000A7;
	Mon, 20 Apr 2026 03:27:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 20 Apr 2026 03:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670052;
	 x=1776756452; bh=T6sX7uQ1AtNiPCB02afxWPBmrUQ2j9xv41uy9ejsvLs=; b=
	HL7NZb93l6RtzsclFCfkkQKAXmRk5/F+QSma2nY7BCudMkfbkA5DXMBNoZDO5j4S
	viLjk66zaZHC2BEnnmLR9blz7ts/5t8P9hD2PO0nNF1Vte0fkzEnDPqKEPiwwsSU
	Cmktpqc5BnFJAEJ5e+K7OA7BEQb2Yck9bGHxpWg2a1gODAv/HulsHtyGhjto6dJ6
	+0YPHpr7TSTeid1MdrTG/MUpfLkR5v1DPxCXm2qItyblkLufCuE7UAI83nEzMbK2
	uX77h1cqp7o9XSvaz4Hn1JHQNkyUJUNuo71AXznpZ/P9vn71+wYHDqvG1av7Jwku
	fsPoaynl2cWhWBUIJ6t4Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670052; x=
	1776756452; bh=T6sX7uQ1AtNiPCB02afxWPBmrUQ2j9xv41uy9ejsvLs=; b=R
	5OgHKWlkRjm5KDjLjtfFMUDnIjgm60b1h3P1IAkfL1ycYtSZfSPa9eKGnKfgI9FO
	JvAPb05zOlTzvTaPTNwEcZG/Kh6ozn01ouc+7Os8BJl63edt9LQDBt/ru2eMF0AB
	3FFUPGSn331IQ3UO6sGZIFLUHdUMqRJ0PamP5Xqp6rlIBEoygFgLPxqMNUuk9F3J
	PnO14pRhH6M2c2Zl4Az+1TbOwt1fBlnOL1qMtY59u1b3LZ/1kzKRaftuxQ/8W2HM
	5WgnOnLcdTzymtpP0FhQwLOeequT6GZFiIbezmmfulv/r4JBe+vCV1UU3IkJpJ4B
	RS/MDfzucUAjcH6+nktaA==
X-ME-Sender: <xms:ZNXlaZScuWQGhbCXLUBiaepxMOvVzBNlSLToGIZkV03Vse1wBhV9dg>
    <xme:ZNXlaZxjU7nKulGh1kZvN8D83V_jyxfiRtBWdFkBU8SaI20FNlAfDp-bQn5Q3Jqet
    dCZ97ILeiy0IAzu_J4ifGB6OMYRrNyAnHhVzrTofFOJkuZGo5ECLeo>
X-ME-Received: <xmr:ZNXlaT2fuV1PO1gRBfoX9eBwAwMJHvb7hh9ghIudQwZYpPCDpGv00orzQiuHhXR5DR0JqpS4jnGUoEQ61Z1EA-dKn6jO127UOnXyNYG7OYuv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:ZNXlaf6odThbvNQrYOqWtlG2gtKcBL26TZRuBcHtC7wfYoJ0NAp4HQ>
    <xmx:ZNXlaeVdVnveqTqtvO5RM4Xg4KKSYDg2tHTsq2t4oviEZAEoJuyflw>
    <xmx:ZNXlaWAG1I_Y9VeUbfjFxqNbJ6AfxqlNvpJmQbSQ_HHZh6Ny2GvP8g>
    <xmx:ZNXlaV4KbGPKrXRz627LgxJvwRkNTt-_C4G0Wy5AUK2Hd2dpO1aNfA>
    <xmx:ZNXlaVynF6wToyN8P05xHpG_ArzX6Kt8eA_hozB_j4u7UUdES3JPiti8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 163c8c3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:21 +0200
Subject: [PATCH v5 02/12] t: prepare `test_must_fail ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-2-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

The helper function `test_must_fail ()` executes a specific Git command
that may or may not fail in a specific way. This is done by executing
the command in question and then comparing its exit code against a set
of conditions.

This works, but once we run our test suite with `set -e` we may bail out
of `test_must_fail ()` early in case the command actually fails, even
though we expect it to fail. Prepare for this change by handling the
failed case with `||`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib-functions.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f3af10fb7e..5fd5494ef1 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1195,8 +1195,9 @@ test_must_fail () {
 		echo >&7 "test_must_fail: only 'git' is allowed: $*"
 		return 1
 	fi
-	"$@" 2>&7
-	exit_code=$?
+
+	exit_code=0; "$@" 2>&7 || exit_code=$?
+
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
 	then
 		echo >&4 "test_must_fail: command succeeded: $*"

-- 
2.54.0.rc2.529.gd9106f7525.dirty

