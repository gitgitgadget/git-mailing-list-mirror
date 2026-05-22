Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D4344036
	for <git@vger.kernel.org>; Fri, 22 May 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464715; cv=none; b=GeCdZ5GTavtALyq+nTqYxxUXsW4m3pVm3wqA502QDv5kLcwahlXYEbquDeE7lXVU3JFL7Ta+tEJ1zVXWut8wUA2O5qKQf7qwy8dN3C0mvBbejDvw1rkJujgZZTDlskGAExreop5DJb5eP8K5Sw23aV1whM1X6qKC3Etj5TqlrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464715; c=relaxed/simple;
	bh=rX8Wc1ADV7FhqS3ZwOk210e9igFMvIIYMx+nM6dpt50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJSOW+6C4RHn/fHVkgCq0VHfzibQOE/p+JxengRFcIhOuo01k+ngHisraP8zAQu6j50fxxos3imE8jqDXOrJLAK3RvFNBeWWLnqccomjdut9cCggz1nGmSWjldIUf8aBBF5OWJTSZ4+8m2yT4ov29bQaVpGr9g7bYb3JHPNLtcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=t23+VoC1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMc6CBHM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="t23+VoC1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMc6CBHM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D1A77A0082;
	Fri, 22 May 2026 11:45:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 22 May 2026 11:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1779464711; x=1779551111; bh=NzBFZJhyR+ND10FwcMRW/
	+iIBdmXtSwK0DFfLHxX4mk=; b=t23+VoC1UNLaViOCV9ZRLH3E7/CgfQz3yt6zf
	u4rnmmwDyzJKX6BvQAuoZvVvpLxOx2ns+4o2Dqb/6C7QVwq9SKX4LuIseI1zAKLr
	lPbwy7lYOcIlGQASOmAYqbYjXZVtYOYshxrsyBbPMm9popd68+ECMM1L7rWEaovT
	XDv20xxTKkFfLEY4eFXvmpfiomIRTuHkKE6yUPdsVUSTLbnT7KgxacIj8pbbG6kl
	izrYIXJJxtGnU3IRnZTecUI33a475ACeg1pHmjggVUHDOZ/D/2TeIiMRMhTUA/Tp
	9IDbh0RKK3A+iF85QiFBynYzU+dntFZJIF1vmHxe08OWOXS8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779464711; x=1779551111; bh=NzBFZJhyR+ND10FwcMRW/+iIBdmXtSwK0DF
	fLHxX4mk=; b=AMc6CBHMHURmmL4k8HrMtFF6M2B7/fGbQpOeQJIDZNZgQoFsOi8
	OE2Ph6aUj9m/5bHgSnCz+xUAIiKPe6GjXGyTE6sBLkFqUrJky8TLuCG5AHfP9Sm4
	wQ4z3LJmIOqtbGuwKi53Ex+29MYew7SGRDp32WdbC7KY0xN9DdoxLZSjYybHHuve
	GqJPe3nwPxmr3SAbm8kMBa1gFSoYRLRGInNpxCXZjRTCRkDBr/7oz+6en1KqzVtC
	9iMp8lj4+11iRXr/GyrBiHZmKD2W32DefqHZnlasVOJpYQTOLHsvtAeZcKoAHbjv
	QKlkKQ3cbqJmJNg9LVyufZ+Xk4qIIU76yNQ==
X-ME-Sender: <xms:B3oQauen5EpqA4T9kc6vqiQKiZEgFz-K19QDVgYsTLIKA9Qgh5q_KA>
    <xme:B3oQavr--h6XdBEh0FxnAehhMptE2fG03ckzIvKsezJieJHFFKURCy1I6HkB-HWoN
    K6Fuw2m_MTD2n1hAwcytzgesxyw6p8RWWxixidxvSjpj9J6iUKy>
X-ME-Received: <xmr:B3oQas406cB_qfh6YLV3zGWjUTxUDFYOyLkeXd6fdB_9WlzXP1-TrWA9aqM8nAK_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeen
    ucggtffrrghtthgvrhhnpeehkefgtdevtedtkeduudeguefgudejheeugfelgeettdfhff
    duhfehudfhudeuhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehhihesrghlhihsshgrrdhishdpnhgspghrtghpthhtohepfedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B3oQaloTb-Mn9EH6qMTlFBRC9_FJonVApDbNNvIohVCkYkcEqGwIEQ>
    <xmx:B3oQauiUB-_yMc36x0yi44gxiK2PdjwH6wD32oxY0IfzWJ6BB529cA>
    <xmx:B3oQavJXdBbiynKO2pTgu-HNsBmYhOxUL_XoXZCQ6yWM1Z3uz-OIqw>
    <xmx:B3oQauDnd3Oxdf-yl_YHKPwVy4yqLDWzGDUjWFeI8-dCRjZ74JFoYw>
    <xmx:B3oQarplBUopHvPR56_YKaFNkC7KT4fiv3yE36bYx4Qp2unPDQl1ZSG_>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 11:45:10 -0400 (EDT)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
	id F2AA6B207992; Fri, 22 May 2026 17:45:09 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] receive-pack: fix updateInstead with core.worktree
Date: Fri, 22 May 2026 17:44:18 +0200
Message-ID: <20260522154418.5883-1-hi@alyssa.is>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This used to work, but when push_to_checkout() started being called
before push_to_deploy(), push_to_checkout()'s side effect of adding
GIT_WORK_TREE to the same environment that would be used by
push_to_deploy() wasn't taken into account.  Fix by only mutating the
environment for push_to_commit(), rather than the shared environment.

Fixes: a8cc594333 ("hooks: fix an obscure TOCTOU "did we just run a hook?" race")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 builtin/receive-pack.c |  2 +-
 t/t5516-fetch-push.sh  | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c7b2818f20..7ee157532d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1460,8 +1460,8 @@ static const char *push_to_checkout(unsigned char *hash,
 
 	opt.invoked_hook = invoked_hook;
 
-	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
 	strvec_pushv(&opt.env, env->v);
+	strvec_pushf(&opt.env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
 	strvec_push(&opt.args, hash_to_hex(hash));
 	if (run_hooks_opt(the_repository, push_to_checkout_hook, &opt))
 		return "push-to-checkout hook declined";
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 117cfa051f..f51fb11a6d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1791,6 +1791,17 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	)
 '
 
+test_expect_success 'denyCurrentBranch and core.worktree' '
+	test_when_finished "rm -fr cloned cloned.git" &&
+	git clone --separate-git-dir cloned.git . cloned &&
+	git --git-dir cloned.git config receive.denyCurrentBranch updateInstead &&
+	git --git-dir cloned.git config core.worktree "$PWD/cloned" &&
+        test_commit raspberry &&
+	git push cloned.git HEAD:main &&
+	test_path_exists cloned/raspberry.t &&
+	test_must_fail git push --delete cloned.git main
+'
+
 test_expect_success 'denyCurrentBranch and worktrees' '
 	test_when_finished "rm -fr cloned && git worktree remove --force new-wt" &&
 	git worktree add new-wt &&

base-commit: aec3f587505a472db67e9462d0702e7d463a449d
-- 
2.53.0

