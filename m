Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C17345CBE
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 05:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465200; cv=none; b=KZm2Qn7ZUdNCUlgmLEBFGFXiVGOHs6KA1iBeYLVFDqXwzZbDPse/A7GJqYKIhz1xW4rxDeWCtXk8bauS+fiPdNX2oCxBXqlKub6KlfILTr1GyhQdtBDprrALFMHPAPAiGixzJ8OzLuEb/7rOG6fDkH152ozMxIKK+Fhzw8SnZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465200; c=relaxed/simple;
	bh=Za0rpKbI5UnnydOnxLCS4/fIkmtX51xULZpg5+lBUDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKlQU0XVV0bDuvsM3B48pbkh29G4o3n6sMiVh/xsUwfvbcn7j/ckJNpM8fRtGeGrKy0hCbtXln0D2NyibSdlySo8ebHdskFF/eW51+fhmYC/Tp2qeOeZ82exb3q/dFk/DGaezfRCtz98va082rGAWcY9+OMfqYjFGUlbF3ET8GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V6VM89cC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LzLuYT40; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V6VM89cC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LzLuYT40"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 130601D00115;
	Wed,  3 Jun 2026 01:39:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Jun 2026 01:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780465198;
	 x=1780551598; bh=QGAx4F6tne9nETImDhMq1D8rCxR8er16xDO8t/8ER10=; b=
	V6VM89cCPtm+I/vm0vCA3Xa6JGhYFA8D5O4qHPxDrilhWPZJY6qeGUmhYQMcviVn
	1iNSYsbd02Dz77EvL/gfReZwcq+VcrpJHKSWiYVipXcpP3r7Gp25H49hC0DWKt6n
	YY3CAjR0UTJ1RC0HMu1x4bPNBsoJ0b+bcjQ5rq4E7XQy8PJbJ0S8t7qm8G4EhVfj
	yFYQ5+AN+KORLReYLwZFS5fzanD+5nKogO4hIzCUpeOWi09u18d2WkwZlaEcpxw0
	0b3k439TEXceeXJI/nPmMTnXalFIxSV8dLjctosQwpljcFsHzfNhNWhHv4i8Sekz
	4ko6dgzY4oa0LULA0bMHwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780465198; x=
	1780551598; bh=QGAx4F6tne9nETImDhMq1D8rCxR8er16xDO8t/8ER10=; b=L
	zLuYT40SbNYDKoLfEAXStsuUzvB0Gxd85woSJSyT2zqxciA5KPw4+S3GGvaMEVn0
	sUYvqCrVVB8jbeKu6XT8JLtHCRBpRGjK0FJYf65ZV13q2qd/dDnuDGQkBa3Z52CC
	TzFSfhw/QtGSs2Gcz9reypxjK+am79k8UHMCvEGyr5/RlP13HEeeh4HuiLzzRGub
	ZYlk8pnC1untwrL9HndV5fR/MVPGvEp4MG4NybiWnq8SQ+0akIXqIKEj5NhUT37E
	toZLHubNx64cmKCZlPv3rWSfp+60cZIouvtJcccDbJdOoWAjpQ0ZzYyr0rjNunFu
	XWwWa4NVakSKdZNtoYb6A==
X-ME-Sender: <xms:Lr4faqWcL9PO56Pf9go91WcuSSAhai_9MViREdic9G8mXDW4h0h8LQ>
    <xme:Lr4fasmPsQhFE8FbaxiroNns0keGSOQ-JMPaGhPkHjEkOC2RrD_yuPeyg4kEBbIir
    pP4awdNmdqEuaZZJ-SU2tbZVZ_NkKrUhNDaf8mauUhwGfwhAE_a>
X-ME-Received: <xmr:Lr4fasDEXUpNoSSdNp6IES7qQ6LvxBjZcfZg-yWt0uQHoe4upwm-Hl37lFReziAbvxgSkQsigChMllm9SQ7ChsihUOim0V_EVrsj0k_YHOWz>
X-ME-Proxy-Cause: dmFkZTFUCrC/B3GeJV6Wc3Opoypu9S9eFMRUE/E+0w3XMUTXL8HQa/6AC6L7OltLX26a2O
    NCw5UfFDMdSlJnEp87SnaK9aaP4qYyYyCVZEEX/5OfWChozr5XCwOQzUcixOwNIGdr/ANL
    HX0lvKBkcKX1GIbvxRg5F2sv6YBZ322xZ4PrgxfspTkCThVHrChE1teRunRHWQ/kayYcUk
    AM0hvsyz2pNSZzYNdK2FO+iL9i/JpdMlW0bb60yj9rKN6oUKE8y4fqjoFzTPANAoGHgZRf
    B3hxWFfUsjC/m+dvhnSBuLn00iFDwOGFk2eFx/x5niLa7l+HEtx2rufCMQWIgCzC8VF8XS
    l54gEc2BRcmhtCgAWKtuqlJYXQL03iuF3sg6iu4h+qlHFhm91hu/4U6p0GMvxZ+lDT/zyq
    x4mBEv8k2WKgocYdToGK0015Kc7txrv0KePGhs62MZv33GAJ/o7B8bVN4uu1rN9ENOOMx1
    sydlxPRwATGqpCda1d8lB0wItwpZxKPNYCaV8nntIfiXu7RZkck4Mz7Ay1pwooHpd8lfZb
    jS+NEHYNhEZKxV0YHQKfPfOL9Pn4YZKZVkAAFuxP3voYjMAaC2Z6GOcJhbGCNYJP9RetKv
    KW9JxljeNSvfsDZUH9CW8ECaV7ZgO/hi9Veb1NaX94w8i3ySx/IzBkIYj6Ig
X-ME-Proxy: <xmx:Lr4faseOi_Fr8ymCYbo2778wirt4c_edN2zDK6f7gh8augUzQ0TtKQ>
    <xmx:Lr4fanIS7VVjViVw81ic3lP085Q02A2d5EdbSCvnw4XbjWXiBAUjYw>
    <xmx:Lr4favcxMw-Udsq8o2mOqEIUgXN4g0R2r-tLiK2qqCBa5zGXFHTVJw>
    <xmx:Lr4fau3i-JT4temYwvr-pdYX2BbWpKHSnlRncTpRduiZiZAqriOf0g>
    <xmx:Lr4falvhUABTJ6rzzYMAfiCSgfiQLW_l5ybhomrjEE6oo88D0kSy9OTF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 01:39:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0f7c8c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 05:39:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 07:39:44 +0200
Subject: [PATCH v2 1/4] t7527: fix broken TAP output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-pks-t7527-fix-tap-output-v2-1-cf3af5694e20@pks.im>
References: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>
In-Reply-To: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Before running the tests in t7527 we first verify whether the fsmonitor
even works, which seems to depend on the actual filesystem that is in
use. The verification executes outside of any prerequisite or test body,
so its stdout/stderr is not being redirected.

The consequence of this is that any command that prints to stdout/stderr
may break the TAP specification by printing invalid lines. And in fact
we already do that, as git-init(1) prints the path to the created Git
repository by default.

Fix this issue by moving the logic into a lazy prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7527-builtin-fsmonitor.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index b63c162f9b..d881e27466 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -25,7 +25,8 @@ maybe_timeout () {
 		"$@"
 	fi
 }
-verify_fsmonitor_works () {
+
+test_lazy_prereq FSMONITOR_WORKS '
 	git init test_fsmonitor_smoke || return 1
 
 	GIT_TRACE_FSMONITOR="$PWD/smoke.trace" &&
@@ -50,9 +51,9 @@ verify_fsmonitor_works () {
 	ret=$?
 	rm -rf test_fsmonitor_smoke smoke.trace
 	return $ret
-}
+'
 
-if ! verify_fsmonitor_works
+if ! test_have_prereq FSMONITOR_WORKS
 then
 	skip_all="filesystem does not deliver fsmonitor events (container/overlayfs?)"
 	test_done

-- 
2.54.0.1064.gd145956f57.dirty

