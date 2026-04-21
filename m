Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FE2AF1D
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756864; cv=none; b=AXVWyGYMVAWrGXTfl5ENzwnmAnB2+PhpQwUd3CvDSk6XmBwOgWQaU/Bl9sjMocV4bL/04xkVdhxRpF8QNGbUKEqvy3Mqnvc8mKaOH9jhqQ4qc5h1njypXy4wjMRMlrSTEqqo2DIZZbHd3ejhaZX7ZNXm9TC6joZh2fzbes14M4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756864; c=relaxed/simple;
	bh=B4V9KSiUKcEiLcnd23IyKMcQIEFjwQCMnhNrxVtnSCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaJS4k66bqLnX8sG3MfELdpMy9QDPNDeY+jmzYtT6HZAsKvnESQueEcdCjUF6ZhRfxp75C9rSdo09wGbeFLYOml3Px1j2iPdzuGilampE6rL5VhbTwMwDbh+rfwd3Dpz0lkOuN5y6yx+IK0ruKZjeBCb3ciCWnJVv9PKFtc+yoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b5jaNvKr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=um86f6lR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b5jaNvKr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="um86f6lR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E56BA14000BD;
	Tue, 21 Apr 2026 03:34:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Apr 2026 03:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756861;
	 x=1776843261; bh=rOLkG4RwpD7JHBqVeDOoa6Z958u2dtCW4Ixt04WU6RI=; b=
	b5jaNvKrUkHKdgeaqE5Ii0HdwmhYFm0CeJjXrIgO0ajDBHd4nZv1JqyOpqL9Ytxb
	Z64L1S9H3I7JxT4C53E7I4ngEanYvAu25+2z10HDt9+FNs3e4RuHRNYdNR9VWgnT
	0Dhncv1tvPt7YqkgBfiUt9JD2TTDlK5JrwIBHybPNZTCbawb6cUG1RfbfoS1t8A1
	bn8it2M4xidwVoGTwyeQVSGH7D+sXOJnnAYhy+da/xNjEflvMpOxti6iC+qmjXA+
	nGV+jYNWr/sXkhdTutpP4/7PfMfkv6elUobb4xyl8aOm3/sAJ8lWRhmjydYWeDJL
	xqdbQ7aBnzHKRLLpwwTm2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756861; x=
	1776843261; bh=rOLkG4RwpD7JHBqVeDOoa6Z958u2dtCW4Ixt04WU6RI=; b=u
	m86f6lRiAod/9ipOKrWjhibfDhlfdfMkLiMBYlS/DZMPzboS+57XmioqmnLZNHjc
	uCZtsAIHmyqFMFB7Oa+r0JJGc47+rHfydAw+a3+2el20d1/+iAM2yYRML9DfnvIn
	mBdapb8G4VYsrYd912lCYAEdqgVu5qtugmLzl+mzBI3DcB6NBtD+nFPJfuf/HaXD
	CeUzq4v0P+GDIxw3MJyt8XOuMuQENvcu9wYPTlPwOjpiKHyegrNOsvCCLnwSm4YS
	eP74Lhx2Z+n6gjNk629kKQOSZz7CUB8Xua+JdHfrFvtBbXca42BlUiRv1zkbYsj/
	nigKuvOETozXy8dVrDwNw==
X-ME-Sender: <xms:fSjnaZet7TXu-z2-GDXYtQhlBTtCIkxlWAplIpZ3yq5vu4WQE3eoKQ>
    <xme:fSjnaeNTi9zXrGV-gBG3o4NZniDh8eKWwNEJ8ncEQI9pQOmRF6u_rOXXiHNCeztjm
    9BiGuluKOkMRPuZGvhXgNIs92FpfHPsqkY3xnuuq9eJLF2FV0S_QQ>
X-ME-Received: <xmr:fSjnaXi33rEVvlmgpHEA_eEo09P91kOFVyf9BAC236v3V40p0AEBK4wNOPC_y4aMKRXacoEbfwCotsRALIi2MONjZBXzec5tOh8HvOS9_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:fSjnaR38aeDAoKIJTWnVtv7dfh2x_rR3R5-rDic8QuR6rweubkNP2w>
    <xmx:fSjnaRicnwPr3ND35CQpI1Y0U5ZmlrlqwarFGgs9sWw5NfYU-kQFgw>
    <xmx:fSjnaRdU6fVWmKZgGtpAqLlgoXulJnJwmERzFV44kQ_mTd_zSzhHXw>
    <xmx:fSjnaUmLBFWXfiSk5LoPJoO-dVgbp6IISOGHNELy1hu7a3rOz-Oceg>
    <xmx:fSjnaZ_SyNATPWCfzdQfsmumpJCVf3ACV4ruRVjAn-saxXBrSRCAXR-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc4685dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:14 +0200
Subject: [PATCH v6 01/12] t: prepare `test_match_signal ()` calls for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-1-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

We have a couple of calls to `test_match_signal ()` where we execute a
Git command and expect it to die with a specific signal. These calls
will essentially execute the process in a subshell via `foo; echo $?`,
but as we expect `foo` to fail this will cause the overall subshell to
fail once we `set -e`.

Fix this issue by using `foo && echo 0 || echo $?` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0005-signals.sh | 4 ++--
 t/t3600-rm.sh      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index afba0fc3fc..84319cf169 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -42,12 +42,12 @@ test_expect_success 'create blob' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 1f16e6b522..a371ea690e 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -260,7 +260,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft (induce S
 
 test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
 	choke_git_rm_setup &&
-	OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && git rm -n "some-file-*" && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT" &&
 	test_path_is_missing .git/index.lock
 '

-- 
2.54.0.545.g6539524ca2.dirty

