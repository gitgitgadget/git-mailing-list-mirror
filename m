Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B1384237
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756866; cv=none; b=BWwJZdDi2gpGtEM1ZnJKTbRLXfNYPhh5ruDPCtcm9/QQxt3iutnPnE1dnBk/kLPmTYn/EA8QIJBk4MGiZLpFdhZl5o4GWDfdSwOyjszhz2n1pSRbULBcd0yMShP5LMpgGRonRfQVzhRWpmXdMfbt7uTC4vR4B1OqkObjwokiYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756866; c=relaxed/simple;
	bh=kVXntVULMAMe/p7H56Qj4Daj4xOwUkONtG1B1iTARrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6rP160uhlntHhE3ccdslqpmW4r9aUzwJIz71xdniQWqFJ/Em29hRZNYeF+Awt5dx5hjASLoXbqRngfH8f2p/0qmDBkhsokr4RjQBUtR2Ur7AD8I7mAOseZyumZ96C4G9v8La5izUvieJ1oBnuqxj3EsyNe1oGMRHhRFjy2VhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PWt2uL0J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sTl7FQGk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PWt2uL0J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sTl7FQGk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 03F9A14000E7;
	Tue, 21 Apr 2026 03:34:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Apr 2026 03:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756865;
	 x=1776843265; bh=wIvIxWZl92n1CkBaSxTbqJKMXVBeY8fXtgNQ6camKrQ=; b=
	PWt2uL0JyX1mIgq4mY+oEbS1oDMd89JZty+qNJYxtkwpBLoMQCkb2p7v7g5XuV+0
	ZMJxiCuHJ9yIttN1v4mmtTE7T7gwfheA9d0ijqllX/Cw0uyLQ/Fpg8L+CN2czZV+
	BWPX09czUjAHiyPTzftunZm1QHYvJnlLkpLYdxlKPDJg4RFKZ66cv05Gv+c9GXXw
	xqUC8mCBOe1Ew4zjlg5ANpk/GjTkTBSD78Gp2yjPYID2ju5qHAa+1LWO/tfUZKsn
	XZ44/p7RIPgSRzAF0Gj35xq0wvJtVibJIrtLqbIiLLaGS/AX/gnGfX+v173U04Op
	13sUXmQyzp7AF3iGrR3hlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756865; x=
	1776843265; bh=wIvIxWZl92n1CkBaSxTbqJKMXVBeY8fXtgNQ6camKrQ=; b=s
	Tl7FQGkhkghSkg/uP00QA9iLOVLo1ePXCMRSRnr3bwvnEIFP6sVAU1+fEei6mJ67
	+y+8sJwxprgZbVwwPIctUn+nFJ2dUaskzGMGEUmJI0fMwmj8uagd8WpGyhafvabM
	QqrI+uf6LYmRekJY9JECnjvaO1yKhEBQl3p56Zy/Au+aB8ZeMAmLpa5BHJTfYrNO
	xr786hwZSmXrc19itLQ87xqswsdShkNK/kDx1R7BMSlJygM+cf4rMDlZx/k9bcFF
	0Ov5HwqPZBWDE9ByVHwEHBa0Ob8zh5Mp7fryTxwoIv8wusG+G3xUpSs2gB+yZwzn
	H3A9N+xYS3NFpJUbHTuBg==
X-ME-Sender: <xms:gCjnaRB-layVEWib67m59odlm9cRpmGI85kwtN2RLAOb9SXVGyW-Yw>
    <xme:gCjnaWjN10SJ4YFdsn3VvYndRPt9QQgGWX0lGtM6XYro6UMw1vv_BIkFSKsZPj87u
    pfkIVLyqu7j2sac5syI12KT-aLSKoHp0ryHTgyB1MX2K7uasQpr>
X-ME-Received: <xmr:gCjnaRnzNyyRXsQB5OnOey4rkNnriGCyXGfFl4ppAJhOy6GMhN11UOQqkGqytCvYzBNPH9-NR-nAG8FhlqmhCQZ8Gew6Wsh7taV6u4AVOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsiigvuggvrh
    druggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:gCjnaaoFZ7qmGE411rdzmrqiNECfqp1PnjthuUvOgRhstGr9GHHS5A>
    <xmx:gCjnaSFb7T6j7F0v8Eex_ajXTQf-YW8Xj_cTRFjPO_enbhGNBk_KLw>
    <xmx:gCjnaezA8fl65bozg3ijfYIyW1Bh_P_w0s01fAKKYycm44E_e9EEjg>
    <xmx:gCjnafo_vqj11YzlAXm3D_-XtNq8V1ZFowcFZbHh_beyzAYNVmemow>
    <xmx:gSjnabhltXCOXK03oIJKoKlQ6czcAp2ZU6bmC9h58nXesHa4GWbLuOKQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5473a1b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:15 +0200
Subject: [PATCH v6 02/12] t: prepare `test_must_fail ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-2-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

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
2.54.0.545.g6539524ca2.dirty

