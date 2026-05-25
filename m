Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16391330662
	for <git@vger.kernel.org>; Mon, 25 May 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726212; cv=none; b=WTQhPIKCaeXpjerzP4weBT+XFBMf3zeVZ+O6hQ0DKRhF30WAx5HDnJ1bZ1uzwmPjaE6LpkN9QcbtbeAJZMTHvIN3CUj5NH7alk5mT4ZdShAwWZTzBrF8J1dXTO6wXtT5OU5u86DS5BHWEkfAt7sfMhYxrH9/GeG2pIRuYjy5g8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726212; c=relaxed/simple;
	bh=nrqpl7tL0e/GNHhQ1d8yXOQYZJWjSxBapl0LTSCK7eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emO1J780s7xN4Me5YmHJY/fyKGyGCSxjdcaGDTCNHpZAOk3tg/cq3hiSs58X83NXS9rFrh7PDub7a6miUFO4A1tJfxbu5Ou6pmYJdnsWfRoNTwF80JtUtoAyngGtMNZyQhF84JbYmB1OxmhjeacfKbwdWKsUeYuDCxACCCUyhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=st0rxdLM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nj40aae2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="st0rxdLM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nj40aae2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F052EC0022;
	Mon, 25 May 2026 12:23:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 25 May 2026 12:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779726209; x=
	1779812609; bh=T11Vl3LhqM1OSFhzUz0gt/cTNQ+sYxC4ZtYa75fjroc=; b=s
	t0rxdLM7vK5euIi49qjt1XkKXROj7y1Ac1sxB+bE1BXNlpBCs61dA5P+0dNxrK6K
	IkjqKmQP/HeMMmz7W6QQ3LPEr+s7cO+bzLTCO3wRu7Lao6xpTwZ9Ekttx2rR3qQT
	mJ8IBgi11B6MkyAs3wbma8mJyGyjX4ba1J1WO9E7dtTXR+a3Vc4wOYh7829y/oyt
	/1yUD2z0gU1hR5rwH2BEY4nKgqK4u7/Z6z2sfXi/wq3eEQJK2EffqAQ2RiV0Jxph
	EN1kzTVKEa5bHyco2ZypQUoiT0wHOc/Wozo/Wjpan1zdm7gcoE0QIEh1PqVZmubA
	5NYgjAhLqKMNJKCpOtYHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779726209; x=1779812609; bh=T
	11Vl3LhqM1OSFhzUz0gt/cTNQ+sYxC4ZtYa75fjroc=; b=Nj40aae2znyWbWVvs
	HokVKyIbkrzcgnTDyfwSVztHLZbHfmAt3JoeXBMEQVyXiSiZGAZqkM3iSfI4vAXT
	kClgKs4R3ZZHMNp8R4Ep5TuIV3SkDXiLNCKmyTtfScw2DipN+qoiMhGv+3coEkBa
	b67If88yRclz5/78O7QAFo3jgxx8PR7hYac1d06VJWeQ4VuM4vay1R2hiIQky4kt
	jeWWc4f/rDWjjIZNZNdekMVNHA5MlFT5IcThT4+8Is/5ZNPZ9rt0cbmswSgiCOig
	l4kw710RmLb27cf87jxnA38g24tRljJyBY0FHaR2GuM2zyjVttGtm6WB9WVG4f3C
	eO6UA==
X-ME-Sender: <xms:gHcUaiq4WDUdi3tucZ7jzqGGPtAylizlVD8BqFGQW6NtpFXo9belnA>
    <xme:gHcUanrmIgJHUejaxKw1qypMr06rYyRLgNCJcIrMdKD2JWo3pFjaU4I3VKMH18BSs
    txzgYJhxR9dRoLMZ2QnyL2460rTnhsW7Tr_nyzb4rF6Dm_B6trybQ>
X-ME-Received: <xmr:gHcUasPLT_b-nHBIOmykuJUv4TufvPVWjYOxTuZpK3GHNbt0O4052zDFigT_68a0F2bGl9mYwml8EZZmO1t98bvAjzyLjBQQFV261Gk1jQ>
X-ME-Proxy-Cause: dmFkZTFW4UGsTgiDqZmY04gZMBT2puaTt1Onjd8IimSSL3+PbsqCu7xdYp77r+J9TALp/A
    tgxCSwSORE1SyuvwmVfPQXtaLbmQvPmXjh0BopmXno2sm/rJPq9iB1ouhb5GinlVZpSBGd
    WEgb6Q+gNaddmWoKx/pb0rs2fhFltpyDTkPB96OlOV1z2H7L1aNtdc6++mSoDhDVB8SlfM
    2xyRhRZi/esa3fEYYJIWfI8cHdSFdlJRYVDGgVaLZPFacY2RGfLJFbHM1MsRi87G2SQZI2
    KS6AX+G0fviuVOmiEjuYHyTsSpShz0NMLY9xJqNG25HtvPoDVy3iv37F63T+WHWSKLsKW0
    NK+VkCju0JZyeR4SRSJOCqOcACos4mV8T9hTJce/JrdxJCXJlMEbs3Wm4ubEZQVYVwdx/W
    PXKS1HuVYzusRVL2a67YRp0EgMIVND0M436IBr06ODkqFj2JiLL3YPrHnDMtZGiZ2qLlfa
    NqGjOTUBod7Wez7XJz+deRPL6GZFKjrUpO5JBzeu7RcKnXhwIYQN3iJepIzCpWaXGAcIDa
    QNvloDjq7YRqdjUKanjD28GpdEav+Cds6EOaI0XDJ8pLjr8kKyuqgc1Q1/mVIjzAFg3mAh
    2tDmHDxEBkl8Uip3+VLOzm1ovp9pn/w0Ws21Y7uOaRsa5Q3ia1oymwMJsHPQ
X-ME-Proxy: <xmx:gHcUagwC71sHf9rhdnRbPlFDlrtdquHmBocAabVMi-T1uBJdz--x8Q>
    <xmx:gHcUatvc69hi9csPCfq9A3-A2G7hWSsGgjXzxFLzkPIUSwR9J8cm7g>
    <xmx:gHcUah4ZVBd4yiuwPp68kr2T_0O2XI62GHCIiYk3JUEjqBWNv29U-A>
    <xmx:gHcUakS58jA1Opq57tlg9wLWWAD6ohFGz7RiJDfdVrikLDkx514LvA>
    <xmx:gXcUarsjm5rRdOMBasWc4CD5uvwpDbwOsH81jzCdC4lSF4TrqgCLDjKT>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 12:23:28 -0400 (EDT)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
	id 570FDB28120E; Mon, 25 May 2026 18:23:27 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2] receive-pack: fix updateInstead with core.worktree
Date: Mon, 25 May 2026 18:23:12 +0200
Message-ID: <20260525162311.66240-2-hi@alyssa.is>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522154418.5883-1-hi@alyssa.is>
References: <20260522154418.5883-1-hi@alyssa.is>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, only one of push_to_checkout() or push_to_deploy() was
called.  In a8cc594333 (hooks: fix an obscure TOCTOU "did we just run a
hook?" race, 2022-03-07), this was changed to always call
push_to_checkout(), and then to call push_to_deploy() if
push_to_checkout() didn't run anything.  This change didn't take into
account that push_to_checkout() had a side effect of modifying env, and
that modified env broke updating the worktree in push_to_deploy() if
core.worktree was configured.  To fix this, only mutate the environment
used inside push_to_commit(), rather than the environment that might
later be passed to push_to_deploy().

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
v2: reword commit message in response to feedback

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
index 117cfa051f..db6cc18673 100755
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
+	test_commit raspberry &&
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

