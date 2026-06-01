Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869BE2F12AB
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300567; cv=none; b=SmAccVYmOGznrmjCM5qYUmuzE58vHovggkGjdhC1se/0phogLmeYGNRK+hHRenss6QELLnTtatd37MAYKtHG+hyOLoZ+PIJ+I18wB0wYxFT3NQvWtBnzNmZ9GkhhPBJhviaC8Xj6HOvuK9Efd5Nf/7xhqyovyNnNqEsbEOE6rAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300567; c=relaxed/simple;
	bh=luNiln/onyFrXC3PoTJHltB3ztkLuH8KD6JhAncE9mI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XDhNjUawbSUl+VUwgXxGLEg5AAK+vgw7KYEmu+ecy7g/ZtW+5D/eexg7PDw6a8ySKSx5irny+9Ykjg7xUPxaLsAXH6IAf128oTPrMpVp/zbJPnN7WryB+gxonVL3yKj7Go8d6lUyJppwCD/udiGD85Sfy5JZqG7OHc8tlZiPC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rahxcDWR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PE731U2d; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rahxcDWR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PE731U2d"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D394914000D0
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 03:56:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 03:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780300565;
	 x=1780386965; bh=q+YSE7orbKKzUmzSEKA2AKZsW1sMKAZ9SirdMSRlOL8=; b=
	rahxcDWRHC7J+1K18XdJOfCgwONxaUPGugmQIY54HSNmY8SqFhp4L5IfMi7NGIEO
	meeteOaTB3v02Y4dAFYw3EM5woBZBBLbwZLdMo4LPR8hMLHd8YWRTiVbBsq7KKo3
	pMkOXrAGN+AXqit4NlhwQWotExPdMV3u6VYvozCTGXkc3Mg1Udt9YoAfotvUKTE/
	vXfT9RLP9gKWVyPy9taLdCsBt9b/iOopFJX5PYwHd0rR9fsa9EUeRchMn+IZmOvY
	XktVKZzKIukwYTg2VSXERMTvd5aVsxHwQSjRvrD1qgrw16eCXFqAw2SRV1pDD8i0
	Dtz3pZlcbPDhEFC1q/iTRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780300565; x=
	1780386965; bh=q+YSE7orbKKzUmzSEKA2AKZsW1sMKAZ9SirdMSRlOL8=; b=P
	E731U2ddZ/Mq+77e9VWhqrO47UrQP4RYIi3RcEH2AmMNTZfLwGouddbsw7zuncEh
	hnbhwTQbAnBl7eTV84i/M7UjtGjyaMYulhUcs9PW/omlhJoTyrN4P3djgQwd1Amd
	wPt7zW9sjXLhqVevSjQOC7vS7KHTsOUSvqaN6X7+4OkvzARx1nrhh1LAiD/+bL0D
	fYsBUFkz7oI+SzZpUmgdDJ+IFCZDYO2U9BxmaS6wniANEHyBTn/3ECds0ksxiDfg
	BlPlDcZnlQhV3U7iFCdH0BFoilTPo8wqOQ2HGzQDGOvBYHzWB79rj2zKIqXuhEQq
	7O2pwalnZaMXBUXdtV5qw==
X-ME-Sender: <xms:FTsdaqHB2IEnQnEcjd5TEwAuk4_e2pwvmluFJbXs5RSjx3nSD6aXrg>
    <xme:FTsdaiQsTczbtnk8CznyvZfWAxO0mGU-PYonrX_dXoFl5_Lfhe9l3qGUDsRD96CJJ
    SIQqoGVm1OuH0KVSo-67GslAfFSYZ3u9V0MTnQKbS7dJi_hw_lK5w>
X-ME-Received: <xmr:FTsdapyO1rfBN6tqFa_p1LjULpbOsz9Uu2HYc08B1Uaov0FOXCWCcKZpSst5jw0uvcKFRdmmm1UjidY9aQBIqGidGRBjOAekGQxYMxMgRIOl>
X-ME-Proxy-Cause: dmFkZTF6uj/IYYPzUFJnl4nqFgUTilnPbbuhpfNwnTch6Rw3kNDNwIUSCPRkTUrVx+97ut
    Nh4mqMh0tc5/L5EFrIse4f5gNz/2WJe88uVk2S1gzZWw7UAuIilnO8glWqDstSEKZJDwFt
    pJbC5Dh1rdbJ5N5dAo3YkfQLAk9sy0yR2kLtpi+6LbkYfgLL4tyVJ1k8WRoX7dGMPorar0
    dVawh9ufGInx0PGd0I4P/eWth+Xu0Rrm/uRBI1iRBhecIbwuZDGLo2c/2YJpaToo18lYtI
    7f2ulHtiMqKakf7/nGBhj51BVmttmFWl7RnLNDAPK16jri+WMsTzatSihBIlIHV4MgR6M4
    dCdVfOO4fR7B10UvvHyp8lj/si0eHVqO/Y+UmCw3IKuGjJZxwTwxEQArEUIK9lg9hrVKo9
    GqCoKDxgcoA+xfVkPR3QzSC9H8yMA47zz+exIV2xlnS+49wOfZzEj4d5o5ybMSzhrqh6ru
    CZZn8yfLu3hc6VzA/qtvs1wHds6wpU/ZxDCBjSZNQqo7HH3akDFVEO5E/jSdGqogUicPSt
    WldXkjlkHbMIdrmE1JFstFg1xO9moggSewnBPJuRF5rCYN6vB9HLHI2ZFtqQ4X7wFU00jH
    TwDCj/rqXSavl9SBdia0hyk3ZCWpKcJHECGB23flxOD6D3JHKSM7zCmHms1Q
X-ME-Proxy: <xmx:FTsdapNhwDJyGAmeO27eVE1emCt6Xlx22mQouyo9Nj4VEUwQv5ec5A>
    <xmx:FTsdagOTPIJLoElRETV-JnkAszZZLhuZI_fOL02FMJue0lbBGqo5Eg>
    <xmx:FTsdajQ3TsJqb_49lpAGkgzwnnZG59GWHvh386EFIFi8QBuBIKk6-w>
    <xmx:FTsdaqBC1QtRGsvmKOywbbKMUBOjk1iJYqPJPelgbTNHx6d3djtYIw>
    <xmx:FTsdasU7LBxA7MQVO5YhUyzPSjYEDzu13sNfY_ioq8p8xRgifCGF_4HC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 1 Jun 2026 03:56:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d198d60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 1 Jun 2026 07:56:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 09:55:59 +0200
Subject: [PATCH 1/2] builtin/init-db: rename to "builtin/init.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-pks-deprecate-git-init-db-v1-1-ea3e6eebe674@pks.im>
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
In-Reply-To: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Rename "builtin/init-db.c" to "builtin/init.c" to match the modern
git-init(1) command name instead of its ancient alias git-init-db(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                      | 4 ++--
 builtin.h                     | 2 +-
 builtin/{init-db.c => init.c} | 8 ++++----
 git.c                         | 4 ++--
 meson.build                   | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index b31ecb0756..b03f74ee8c 100644
--- a/Makefile
+++ b/Makefile
@@ -894,7 +894,7 @@ BUILT_INS += git-cherry-pick$X
 BUILT_INS += git-format-patch$X
 BUILT_INS += git-format-rev$X
 BUILT_INS += git-fsck-objects$X
-BUILT_INS += git-init$X
+BUILT_INS += git-init-db$X
 BUILT_INS += git-maintenance$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-restore$X
@@ -1428,7 +1428,7 @@ BUILTIN_OBJS += builtin/help.o
 BUILTIN_OBJS += builtin/history.o
 BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
-BUILTIN_OBJS += builtin/init-db.o
+BUILTIN_OBJS += builtin/init.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
 BUILTIN_OBJS += builtin/last-modified.o
 BUILTIN_OBJS += builtin/log.o
diff --git a/builtin.h b/builtin.h
index 4e47a4ebd3..bd072aa0e4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -200,7 +200,7 @@ int cmd_help(int argc, const char **argv, const char *prefix, struct repository
 int cmd_history(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_hook(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
-int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_init(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_last_modified(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_log_reflog(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/init-db.c b/builtin/init.c
similarity index 98%
rename from builtin/init-db.c
rename to builtin/init.c
index c55517ad94..9184f2fc2c 100644
--- a/builtin/init-db.c
+++ b/builtin/init.c
@@ -69,10 +69,10 @@ static const char *const init_db_usage[] = {
  * On the other hand, it might just make lookup slower and messier. You
  * be the judge.  The default case is to have one DB per managed directory.
  */
-int cmd_init_db(int argc,
-		const char **argv,
-		const char *prefix,
-		struct repository *repo UNUSED)
+int cmd_init(int argc,
+	     const char **argv,
+	     const char *prefix,
+	     struct repository *repo UNUSED)
 {
 	char *git_dir;
 	const char *real_git_dir = NULL;
diff --git a/git.c b/git.c
index 36f08891ef..a72394b599 100644
--- a/git.c
+++ b/git.c
@@ -590,8 +590,8 @@ static struct cmd_struct commands[] = {
 	{ "history", cmd_history, RUN_SETUP },
 	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
-	{ "init", cmd_init_db },
-	{ "init-db", cmd_init_db },
+	{ "init", cmd_init },
+	{ "init-db", cmd_init },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
 	{ "last-modified", cmd_last_modified, RUN_SETUP },
 	{ "log", cmd_log, RUN_SETUP },
diff --git a/meson.build b/meson.build
index 064fe2e2f1..682e46e7eb 100644
--- a/meson.build
+++ b/meson.build
@@ -634,7 +634,7 @@ builtin_sources = [
   'builtin/history.c',
   'builtin/hook.c',
   'builtin/index-pack.c',
-  'builtin/init-db.c',
+  'builtin/init.c',
   'builtin/interpret-trailers.c',
   'builtin/last-modified.c',
   'builtin/log.c',

-- 
2.54.0.926.g75ba10bac6.dirty

