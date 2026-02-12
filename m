Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FFF3590DB
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900292; cv=none; b=Q9skaojrxFzNAHhuDCpGS7LZ2QB1TWuLBFSmmyu7S/nXLi47mbfarDLue7GFnsZ3ZGLhbEYD/yDGymmpuENJl3DPOcRdP25VIkWK/4hWBIJdjJd2HeMm9seiPGokIz6jvo7YADaWWzKPsFBapypXpWnOJ8MG9tniWRgMaSD95WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900292; c=relaxed/simple;
	bh=9/lzBZB3U97LXPIs98rhxIw7K3p9lvngKIa7Ig2jrvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q2BTF7UgS8jNQ8Wd6prodTIKXTEVMwxZZYr28HrFTPUjsFrA/HbJyxHtb/Fc7YMGhqAcz9vPem1pxL67KfpAkzKrr6z1MlTAiV/kKPwkDPVoMPoM7d9AvMFaX1JdAdbNuvnkunIeiIKABmZPxI8BGDjHVcADsxYXzJDc6a6NxF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e3NG3ppo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVOhCC6X; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e3NG3ppo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVOhCC6X"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A03F9140010F
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:44:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Feb 2026 07:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770900289;
	 x=1770986689; bh=Y2SKO3A4uLgIH1KrSCsOfJTF+xkkK8RI3neVMsdZkXs=; b=
	e3NG3pporgRAj+n/a50rUpMDNkLLRuT1BnzRnI5+FnxA0Eb14S3Yh1ET7eKXpfac
	9+a0Q2lfiWfKnRMOCHSYRnVTavfmhdshv18wYSFtajww2pQrH1SOAHFCiSRRyola
	PP3jG8xT9hFF2RxM/Bz+2/2vKHGuQ5L+v3pXyicQmv3J4So+asQH9+iNtU+7J1OS
	dXm+fHpuBIFsar3+G48XZFft3CaoESCG3G03wmNLF2R6zsCvatlzZaROo0IKEUU8
	RX8SsiVzeCZ9HxPnYKsRA3BgGzhUidnAEu/5GqMr0RCiha4hGJyweccL0fOC6zQz
	+O2QQARAQ3IE8KwGQOW11g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770900289; x=
	1770986689; bh=Y2SKO3A4uLgIH1KrSCsOfJTF+xkkK8RI3neVMsdZkXs=; b=C
	VOhCC6XPtplp0zNnAmTQby2E8ccNKEwMLDDcpiswDlqqOrK3mGT1xXXJU6qxTNqw
	Ce7wNYKYIzj7mpcJF7tPtr9w54fh9n5srbMFSjjTTtLgz5XWtFpBPaJYduFGzyym
	XCIz+k7KJte+fC6pfEd6wxU60MSn+F03B6+h7y+mOaaksVoR1dQXwT0ina9rfty+
	hUABNsMKcZ8eCjOuDNCR5KVi3m7+GmehQE6vV6UGaUGTp/BLOpG6UN+lk859SRPx
	h+V8aGNGzTdUeRySV1owoqTx7GGoPxwnZMELT82SskQ4vzAorvpSD5c0Zkrpcull
	KSlm3xbwu0OZhtJQEWdeg==
X-ME-Sender: <xms:QcuNaV7hfm6samLl2Jg29C43ICbEsay1ReF8yitA5dHZrGxbB7peng>
    <xme:QcuNaZ19yPe3ubGHQ8hLecPWHHLivdGtGu9sekIBL0mA8-JxXDw4G_Pj_QGD39ndt
    s1Ai46q5sC4jUbB6qc7-FkUcg1-DueSvC7GnuF4PjEoFL6rPZV4>
X-ME-Received: <xmr:QcuNaSH1FhAVbr8fXv3nJhsb0a9zYtcuT31fTr8yMHNco-jASKAyuu8Yuac-m8lQojOjFV-goi0wDvSWlDl7kuSo9mV2RqOAUmJQnIQ-Juo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:QcuNaTSG43qSPmZY17huaBLYKQkPeaY_0BtpgtnukjqFKtg_kQfkyQ>
    <xmx:QcuNaZDRhy7qZXXQYa61ucMR57JMYw2VwGXdLb6G6OYSM3mYsStb7w>
    <xmx:QcuNaT2Hhqh2ClfpOzWNrqwiSrfUIbI2XDdwl-fRyoWSPiCpjVtsZw>
    <xmx:QcuNaXVsA0DYF7zptHcp9SPUdRSPwu9nBycBxphwRbM842WU8xM9Fw>
    <xmx:QcuNaabKVayvNUdnc11Tyk4hhgT98XseKV9tf3XMlncnIVie1xx53PzV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 12 Feb 2026 07:44:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8923748b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 12 Feb 2026 12:44:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Feb 2026 13:44:37 +0100
Subject: [PATCH 4/4] builtin/history: rename "--ref-action=" to
 "--update-refs="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-b4-pks-history-dry-run-v1-4-1ce03d631c1b@pks.im>
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
In-Reply-To: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

With the preceding commit we have changed "--ref-action=" to only
control which refs are supposed to be updated, not what happens with
them. As a consequence, the option is now somewhat misnamed, as we don't
control the action itself anymore.

Rename it to "--update-refs=" to better align it with its new use.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc | 4 ++--
 builtin/history.c              | 8 ++++----
 t/t3451-history-reword.sh      | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 33353815cb..b73fb009ab 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
-git history reword <commit> [--dry-run] [--ref-action=(branches|head)]
+git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 
 DESCRIPTION
 -----------
@@ -64,7 +64,7 @@ OPTIONS
 	Do not update any references, but instead print any ref updates in a
 	format that can be consumed by linkgit:git-update-ref[1].
 
-`--ref-action=(branches|head)`::
+`--update-refs=(branches|head)`::
 	Control which references will be updated by the command, if any. With
 	`branches`, all local branches that point to commits which are
 	descendants of the original commit will be rewritten. With `head`, only
diff --git a/builtin/history.c b/builtin/history.c
index 40e2925cea..30ab10442c 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -18,7 +18,7 @@
 #include "wt-status.h"
 
 #define GIT_HISTORY_REWORD_USAGE \
-	N_("git history reword <commit> [--dry-run] [--ref-action=(branches|head)]")
+	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -259,7 +259,7 @@ static int setup_revwalk(struct repository *repo,
 			goto out;
 		} else if (!ret) {
 			ret = error(_("rewritten commit must be an ancestor "
-				      "of HEAD when using --ref-action=head"));
+				      "of HEAD when using --update-refs=head"));
 			goto out;
 		}
 
@@ -417,8 +417,8 @@ static int cmd_history_reword(int argc,
 	enum ref_action action = REF_ACTION_DEFAULT;
 	int dry_run = 0;
 	struct option options[] = {
-		OPT_CALLBACK_F(0, "ref-action", &action, N_("<action>"),
-			       N_("control ref update behavior (branches|head)"),
+		OPT_CALLBACK_F(0, "update-refs", &action, N_("<action>"),
+			       N_("control which refs should be updated (branches|head)"),
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 702d40dc06..de7b357685 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -233,7 +233,7 @@ test_expect_success '--dry-run prints ref updates without modifying repo' '
 		test_commit theirs &&
 
 		git refs list >refs-expect &&
-		reword_with_message --dry-run --ref-action=head base >updates <<-\EOF &&
+		reword_with_message --dry-run --update-refs=head base >updates <<-\EOF &&
 		reworded commit
 		EOF
 		git refs list >refs-actual &&
@@ -258,7 +258,7 @@ test_expect_success '--dry-run prints ref updates without modifying repo' '
 	)
 '
 
-test_expect_success '--ref-action=head updates only HEAD' '
+test_expect_success '--update-refs=head updates only HEAD' '
 	test_when_finished "rm -rf repo" &&
 	git init repo --initial-branch=main &&
 	(
@@ -271,10 +271,10 @@ test_expect_success '--ref-action=head updates only HEAD' '
 
 		# When told to update HEAD, only, the command will refuse to
 		# rewrite commits that are not an ancestor of HEAD.
-		test_must_fail git -c core.editor=false history reword --ref-action=head theirs 2>err &&
+		test_must_fail git -c core.editor=false history reword --update-refs=head theirs 2>err &&
 		test_grep "rewritten commit must be an ancestor of HEAD" err &&
 
-		reword_with_message --ref-action=head base >updates <<-\EOF &&
+		reword_with_message --update-refs=head base >updates <<-\EOF &&
 		reworded base
 		EOF
 		expect_log HEAD <<-\EOF &&

-- 
2.53.0.295.g64333814d3.dirty

