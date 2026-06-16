Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B44183DE
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599462; cv=none; b=KyG20/xr9n0gpij/LWrwu+Su7yn45m1BPqTHOK5WIltY9oDGNjyo3jNeXyxDzIsBQQMN9U/X36OnRphWwKm0rnT4eNrI5hUuKDrpPtZp5x0v3cltESn7HRyeENNAFH7lrsClxOD8yaupC1f5FcnJfv1nmxW7tVC74mQwz2i1UiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599462; c=relaxed/simple;
	bh=2evZpYNQBlRQOqh1Gqpg17+0TKDrUWilStkPBTt82j0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ClPFd2OhOuqT16gQNC+DpjZNCiKgdYsCPbtBOJikj7xgFj239GkNjjCfz2lIGBCc2nto9FlVbVEQ85ART5Egl5QiD2Pww6w9wH2DN2T79DXEHAlzr17djdyAA3Kf+fbr8HpYgwZMsTjt0NBANtijX24kxXPhyiCNe9S7Zpxb8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j/85ZC6b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5hR1k/K; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j/85ZC6b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5hR1k/K"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 98A017A01BD;
	Tue, 16 Jun 2026 04:44:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 04:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781599460;
	 x=1781685860; bh=GYdRAyXYWci6N1HNeu3Z8fGKwFL/fKevNLaj+jtrsLo=; b=
	j/85ZC6bMsjNYepmDc/T7mprUH5SmwQLk+MaZIAyJIAcn1OBZNOwVdavwHzOA0OR
	D4f1MGDxjdf+jRg0mjCBtqqa/h5hBXSVTofek9McP2SHqKTWWOmik3lYzJjMZHCi
	YCV+ep9xTc2yDax18vhsYX4bCyIYGbs/WxASaV28uCZlblseriVEPqv56wM3Muhl
	HTNarhEGFa+oYXFXP+VmR//uBsRC7dIah1ye4TOm9s/KZS0yse4jzQrMv7ErDsJL
	7SQrXb8r+rQpH6J8gvbqTkozG4Y4f0G2YSVIsESlX0pED8ljD7lIM9u1gPX1GbtL
	3hMsgcdny/SGkw+GTxAF1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781599460; x=
	1781685860; bh=GYdRAyXYWci6N1HNeu3Z8fGKwFL/fKevNLaj+jtrsLo=; b=d
	5hR1k/KmTZmoznMXPZm7vjG9qz6dQMxlvFSBvqkg3J5Pb3I8ednRLQxTjY02mAlJ
	aeK9m6cAuryUSgFS+IN1MQI/BaDKs8ZGUHQzjeGG5vD11S/f+Z+tr+CkZtDrDey0
	Nge/o1v6+aps0SMCRps6ohrtGeTJXVIdAbExWQwixqgD3oZGOXiNZ+HDWQ9yj7c6
	N4MH4ft29zLYHgnCq4HNIPTF7M8VEo997H/NULcb7uTPadDAT8u8aRMsvxYBfYmm
	imz7GzGOiS2boOekOgKW34XTP33zTPAMXe75z7RECNaG2bosoeun4ftLmjd6J5u+
	Ez/I6OgImTRE8uPxfi28A==
X-ME-Sender: <xms:5Awxalf4lPZ3dTaGaKr4PnT42G4nmQn6FWMYPz1hvAT_FW1UEhYMDQ>
    <xme:5AwxapOGUw_tHU5ajXVLlRu6ky0rnRIuoz3HuEpgTuqf8utD2VixnyHwB4ttozdwB
    SUmbOGtSMC5mXH3y0CaOnkZGuOdHThHn7mlXiRZ3gilDZhC78ZUEw>
X-ME-Received: <xmr:5AwxasJURU-69fm2j5X5R1ZBxI0Db1hmnsP8ldkHZZpey9PGP4tj135LmOsPhWpT5OcXzuw-yEb0HbFCTRjajpu0HFzoO7fqrFsdaRzra0Mjlg>
X-ME-Proxy-Cause: dmFkZTFBk5CWSueBh1W9d8KzddL0zCsFFQZw01Xrj+/G5WsDERV5CEq8iQgMA6rkpb01Ha
    XO2sPvtgztpkfBWoASmLj0xbcH+OHbEp/Ntqa65jJ4lH6/LQsqzJ7SHT2FgmtGJB1bHeOC
    XIiagSI94YMf3JJr8g7IUXkjs6Pr+wY/2pTVtxWi1fdmXxZn+NBj8tS76E8hIvNsBuZH+U
    ZHkSQm05igjvDv2JMx40FszLieL925SSqFNBjj2D1t/vQhNyThEajaqNQ/yZQKKtGC60AS
    8hoKIO7fl2Xgg5O+wx88z/9O8HKF0b73BMtkEJnjSrGaDQbnxxwJdEfVcGMAxHBIm2BdUE
    EeUZPQ472B6fhpF4TJikZyrpbXRDyY0TmxAqzk1+MeWjKeFfSgjlzbAVEPBXhCFcuH68IC
    D7qoR7dDkn085XGJSe/HDyVqTczcwNjnEEdLv4kmZ51blOM/deQ2kT/uBxjUHm5v/DGB3c
    As/xtUDDvwHJ8g6BLoZrO/GXEflieQHkGQ0UTJGWnB9cjs2qgF6nLCz2otT+IA5IEjoFzd
    Xcr9pqwFPsN0Fo4df4+wAg2UgXbZtzEO/mCZuTsTWZFJ3wumaOyU2PHIdDogYNVA4LrQOM
    VMtYcczP29Xne/zsV8yhuSXAaQSEE9ArSYt3Z2PO+9IwTmADk66Nbp27lIMw
X-ME-Proxy: <xmx:5AwxaqGrXZHyT-Jr13MWg0XYFBez93lCVtl6uYb1l8i3W-p02BmJ2Q>
    <xmx:5AwxakQ3R807QJLxikL3e-_gW6vOUbPVKT0DE4Xvfqq5L-UPsQb7rw>
    <xmx:5AwxamGLQevEvkf3HxldV8POV2xhoHQOoZK4ud19HZDig6NsIsWLdg>
    <xmx:5Awxag8xIoW8e2ueqvzIW3rvBXpHcbFT2JnVmiF0i2y8lrkNa_AcDQ>
    <xmx:5Awxag3-VxmugMpuOpIiKUsLqXE92OQq5VUy_W9l2MSsFgm1PKck-KQy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 04:44:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3cb06d1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Jun 2026 08:44:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 16 Jun 2026 10:44:06 +0200
Subject: [PATCH 1/4] builtin/refs: drop `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-pks-refs-writing-subcommands-v1-1-9f5219b6109d@pks.im>
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
In-Reply-To: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.rc0.786.g65d90a0328.dirty

