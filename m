Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4353A7820
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344439; cv=none; b=qKzqGD6K/N/eTIi2RoTNF89nuZ42UmXr7/d8LBidlnfak1PCoX0If4eM3j4ix4XJRh172Y0y/3OOu2d6pSyz67Jp5tvbYPYT+ZOW4pjjE/cQSndGnz4spPvdvn+cI3slMK9UdXFkwujhJABxgtmCCkysxt2UDzTHVLVlOLdU31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344439; c=relaxed/simple;
	bh=0lM5kNcTgsU4JbDoTlJNVMaW2/Rwubr1SqbyF2SjVh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4cWNJra5LDqPwMj/wh+AVOAcj8M/cc/HUDsanmXUrTiCom0XuUr5s3L2h3NCDmBMl5A12MDDN34IfGkU7pUSdSDpGEH3JT72weNt9DqJEAfZHLeKD8gMjwvy1nG5WEepPEYhMVEdapgWuJv1XamTAp7dr1BE14Jf+2BceqaoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M/IcPe9W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a27id/wP; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M/IcPe9W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a27id/wP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 553601D000E0;
	Mon,  6 Jul 2026 09:27:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 06 Jul 2026 09:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783344433;
	 x=1783430833; bh=yxLIIH0g8jmlhDsdFYVigKr15qaZnSQ93Krkkb7vIhs=; b=
	M/IcPe9WdeLezuUQyzqupEPzfJ2elGOyvsAOPI5shG6N9cCyR+JrhOuZg6oa87zr
	olTP/8FXc4LwDygReQpGvmyQhenBITY45Tr3fIDt/MXfD8V4i6DeLLjlhlB/DtA2
	xdPV6zBXd99y6eUD1WIgYNqrIJSEfouGjo5WVpDQ9wonQDeBl9W8qXKqOlrzD+Tl
	J0Gkhn5k185W0yYSpBRFhhHb7r909emX7q2IHYTsCaLRoEkf0+FK+LvsMS5Dlgwa
	yr88NdexpO7RJEE+ruDPWYZBTarVsdNdnP0Onp7o7Ri01mtvK/9hv7uLMFVjMQr4
	nqPjVDRnpZRxR686oHXQOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783344433; x=
	1783430833; bh=yxLIIH0g8jmlhDsdFYVigKr15qaZnSQ93Krkkb7vIhs=; b=a
	27id/wPYJWaoY/GpkBo0vIk3fa1LbN/H1ypkBI2U1/S3Zu6fZda5bLTJgPOLo61Q
	WY2x3S+KkXDf39LWi+EK7UtxHAMTlTpSlqYeJRm2FsU+jVMmbtZThvoKmGpust1b
	FxwOEh+bwpAPs2CvPJc1QzwnT8BsoObgM6DMDrv1pq4VyJak82yKJdbd6/jjASpM
	HdDybz9LPv7GEUUwTC1Bcjt5WKYMo6pi2eUH4iUAXDqxUx1nZwPR2jfcxI8X2N83
	NdYMIQ9Msz4O6gb0xPY4LEh6KQvE02tZSHG1EbTTx88udU0F/z89g2R4uvkPlZBa
	kgsG37VMIEZQshREn+69w==
X-ME-Sender: <xms:Ma1LajiUkTVriYla2hE2HkGgr_WktFB0ZNcTDe5ZK-mZdXD3B2VjWw>
    <xme:Ma1LandjmH-zr3MwTKIa2xAIMg9rwnElN3-O8Qmut8Jb3qPR3uieMrXveduWxmUHY
    GUXoC5QdLEcE2Hx1KLGQc2lqRyH3DQh0usif3wKKjeof5O7rcu0vw>
X-ME-Received: <xmr:Ma1LagdMcVXQyyVbJ-z-XUm-1R_IrJAiMLX5D0Xhi7DRQdRPRxfEO-1o_Igy969R9u8iGsSKaWT5w-Hm--tjh7aSwYs-Mi_ptA-SSSlGilE>
X-ME-Proxy-Cause: dmFkZTFR8BSsgj9yGLbcThYqht4HncC1VEaOUbBQu4UfJsd5ghRAShg/uIFc1qfW46rkSi
    19i0PU7UsC1XanMOpYtFwFIhncZk/BsQP23FmOHSYMXM6heDzZzICDVCpVmXqMtSaxI8sX
    +mvhhAO7G8dqzUwTuSFm48I5Pj02qZyiGHBy3G7MJ6iuFifEITMmicg/pjcjOQ96cSAjJ7
    b7l0nJ5zHaaD54nts8ILC9oEoA8h+g5mQIKtdnkK1eRvGZt/021Vl0adss1EkhjZreZs4C
    eB43C3C7/rtDEaQE+cEqs1P4e7bjLpMwWSs5HvIKtv9Z5sIqd1Ha7F9ZtGIlR1kamnxIHR
    ztYmcbibo+xQLyQPy0vf8ufcgMYSmxIdHS5wJDw+fvKnkPyYKPvXHFqmZ+40vKP3lNYD5v
    qu4wIsuHFtf4B17eoUUOC2OFsZup81M1fjLoTZHWQpxoczButBi1ndFCYVGYuwbI1G/9pj
    0vodD/dP2aQayrIdKMbUp8SqfBSE2zZmHpt1eQaaabD84WED5VAqDWN3OVhM9qw4Y24A5B
    e3NPd81suu/3FBi5aU0tCOx5/1XBX4xbpdXCLPntrTDAFtT31Otc6+nfqcDHOiCjz5S5zZ
    bC1Hv+KNilawdo50Q+P66GVo6h5nCmsucR4cJopqSrdTnKGoHgXvpvuF823A
X-ME-Proxy: <xmx:Ma1Lap8syjzPI9YegEq-t3Ttlov81zV9I6wPkHLLKVVKWx3nC_Kopg>
    <xmx:Ma1LaklVIfXTAcgYwjcc5RDuN0QvCjPgBYa1GlKQ3e8nStsCvmZX9Q>
    <xmx:Ma1Laj9nrkmJzAfIx2brA06n8hEPTq3dFJjMg1pBtV1W_XYSddSrNw>
    <xmx:Ma1LaqmZ6022jwbbMx4M2Bo0co0POVqIZQM8cl_ue_u35EXY7gAG3Q>
    <xmx:Ma1LaiGPrLMJYdnPgb-pLGrkP7wbcOAN7J40NvHkjL4PETd6CYJ3E_DP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 09:27:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46b30d23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 13:27:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 15:27:04 +0200
Subject: [PATCH v4 1/5] builtin/refs: drop `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pks-refs-writing-subcommands-v4-1-d51f6ce7f830@pks.im>
References: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
In-Reply-To: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

We still have a couple of uses of `the_repository` in "builtin/refs.c".
All of those are trivial to convert though as the command always
requires a repository to exist.

Convert them to use the passed-in repository and drop
`USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/refs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index e3125bc61b..f0faabf45a 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "fsck.h"
@@ -23,7 +22,7 @@
 	N_("git refs optimize " PACK_REFS_OPTS)
 
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
-			    struct repository *repo UNUSED)
+			    struct repository *repo)
 {
 	const char * const migrate_usage[] = {
 		REFS_MIGRATE_USAGE,
@@ -59,13 +58,13 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 		goto out;
 	}
 
-	if (the_repository->ref_storage_format == format) {
+	if (repo->ref_storage_format == format) {
 		err = error(_("repository already uses '%s' format"),
 			    ref_storage_format_to_name(format));
 		goto out;
 	}
 
-	if (repo_migrate_ref_storage_format(the_repository, format, flags, &errbuf) < 0) {
+	if (repo_migrate_ref_storage_format(repo, format, flags, &errbuf) < 0) {
 		err = error("%s", errbuf.buf);
 		goto out;
 	}
@@ -99,8 +98,8 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	if (argc)
 		usage(_("'git refs verify' takes no arguments"));
 
-	repo_config(the_repository, git_fsck_config, &fsck_refs_options);
-	prepare_repo_settings(the_repository);
+	repo_config(repo, git_fsck_config, &fsck_refs_options);
+	prepare_repo_settings(repo);
 
 	worktrees = get_worktrees_without_reading_head();
 	for (size_t i = 0; worktrees[i]; i++)
@@ -124,7 +123,7 @@ static int cmd_refs_list(int argc, const char **argv, const char *prefix,
 }
 
 static int cmd_refs_exists(int argc, const char **argv, const char *prefix,
-			   struct repository *repo UNUSED)
+			   struct repository *repo)
 {
 	struct strbuf unused_referent = STRBUF_INIT;
 	struct object_id unused_oid;
@@ -145,7 +144,7 @@ static int cmd_refs_exists(int argc, const char **argv, const char *prefix,
 		die(_("'git refs exists' requires a reference"));
 
 	ref = *argv++;
-	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
+	if (refs_read_raw_ref(get_main_ref_store(repo), ref,
 			      &unused_oid, &unused_referent, &unused_type,
 			      &failure_errno)) {
 		if (failure_errno == ENOENT || failure_errno == EISDIR) {

-- 
2.55.0.795.g602f6c329a.dirty

