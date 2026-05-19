Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961947ECC3
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184341; cv=none; b=n14R7fua3csKhUCLbH2LHv+LLbub4++3blPbae+75FBB6ePM/D5LOSlDIGjHI44vBD5xk/5NQ4aaigErI/sE57z2iA6qMY98aHi+Hx+X5NgGsCPS0nSGVIqVehpTgPXQHR8gi2NhxkFfLeGdb09nsNgMbC9mbA1l1OfrLQv4d08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184341; c=relaxed/simple;
	bh=GnwUCNLCf/sr6bSJbEPk5jco0UbCElNl37KEInXd1ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCkzs50gjCLEz/O+A7FJJix+Gm3ktOMZQIXLeMJju/L+YOpJwsGxayKQhhe9kFRNXyU5vQCwpFsi6ZW24ne++PugdkNNm6PC5fCiCaoZZ7sOWajJXQy2ahe8Y2OqI/k8TN6upAytfnEWagvtsA9A0gSWjEmF5qHsdqhDwpRZlrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QQcv45pS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oR/aKXYZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QQcv45pS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oR/aKXYZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A34157A00DA;
	Tue, 19 May 2026 05:52:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 05:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184338;
	 x=1779270738; bh=TnYGAzHlfZLhT+fbz/TvMN2vmRstwAVjr11iiqTNY3M=; b=
	QQcv45pSTj8StJ0jU1xmTs021L72uOSCj5TnQaA4elrVAtJV3ee7SnZ2XfiPOETZ
	L1P7LgplhtIsxDcnus6hlZq0/b2XKTKSHjPcWyjLG0i2nF6NAQx5vBZVhGNGAFZZ
	NW+lE8j4lkoce7fdjzikfgJsGHa7RuA9rrNrzF9bVBtNP4NQkANQUTKhh9p+FKvd
	NpN7PlfUfjC5guNuxT5qEIuuQmnnQ7LyHqaYS+9whqNdTrIYyjg8E2FZBPjcHuPn
	KuwWTTwfZ/7Ji6I2swR++nfu5VuUwXRrDvGSDaVIwgAPgCkyq79eRU9Xm2L8YFQb
	lS/iYebnp6+TXtrRFM1H2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184338; x=
	1779270738; bh=TnYGAzHlfZLhT+fbz/TvMN2vmRstwAVjr11iiqTNY3M=; b=o
	R/aKXYZLWi2UFuGoE2bAio/se7AXtSQ06xlFVVT3AxdVqawF6eVff+FqdShV0x3v
	kxuYjrHz8RV471l2lcoQk/uxhGhfpDJl2/OmXe9Y79DbZxPxIykfybi5VzIYrkYG
	g56gkfkp1rEB7F4PqEKsuA+gPAZHsxUkLxJTVx1wk2VlagnbGScM0g1CxAQ126XQ
	4zbi7sz5ucPAqfg81Bqxa1jtnR7Oua8f3VIr3WB2c0zzVV3ZGbD15IPl7R3+YJfR
	0MX9nZP0KWntHG5JeTB9egSVs+R0zAFzjzug6d1iIisLPgqu1snFml0f4kBUQK+G
	NpOAhLyZ2OHWBu5iTBJIQ==
X-ME-Sender: <xms:0jIMalOxJUCZGyaNY1ILOgfnBo6rn0Pz9vbwiUoKwO-RqF6CkANyaA>
    <xme:0jIMau34DbsFEHEMZPk12ZGnZZrrV2ollgU8VwztHo6RP7hoNXrt44d1uNHeX8JSm
    ZnmcWFSOo-3xCTtlL_WzREDNos3U1vQMnf4P47Gdq-0g4Qowt5fiQc>
X-ME-Received: <xmr:0jIMasl9JtYJvWXP_rap46Rq7DGGgzCl6aAA3s5Ofyqx4B1YLoggKxM1hPNbg1n8LnWJgpEM5tsKSdOaD0yXHRAcwukWiJgO_S3hLKV5FLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrthesmhgrlh
    honhdruggvvhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0jIMatVOU4z4HQ_mFITp0bLqfaOpFUF5Yf0jsstmv4UISEqy40uRcg>
    <xmx:0jIMaqurvS9ZToy5RGn7SBDBhYh7YDFnI7IA6dVUPu4lMlEu86D2-g>
    <xmx:0jIMaoYTnks1L0RHNps9hWGVpnGpNmeLR5PgCXL5dGLQ_GP1KwAE2g>
    <xmx:0jIMahX8mcFYbdDTdMKlCjBsns3CZTWv8-lElFi6K5ryZBUblN4UoQ>
    <xmx:0jIMagFijBQuDHQ8EyGzLcIq8mq_HjVLhgJgQzZKTLcVI8WbHD_HNhHg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ca64003 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:06 +0200
Subject: [PATCH v3 02/18] setup: stop using `the_repository` in
 `is_inside_git_dir()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-2-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

The function `is_inside_git_dir()` verifies whether or not the current
working directory is located inside the gitdir of `the_repository`. This
is done by taking the gitdir path and verifying that it's a prefix of
the current working directory.

This information is cached so that we don't have to re-do this change
multiple times. Furthermore, we proactively set the value in multiple
locations so that we don't even have to perform the check when we have
discovered the repository.

While we could simply move the caching variable into the repository, the
current layout doesn't really feel sensible in the first place:

  - It can easily lead to false positives or negatives if at any point
    in time we may switch the current working directory.

  - We don't call the function in a hot loop, and neither is it overly
    expensive to compute.

Drop the caching infrastructure and instead compute the property ad-hoc
via an injected repository.

Note that there is one small gotcha: we often end up with relative
gitdir paths, and if so `is_inside_dir()` might fail. This wasn't an
issue before because of how we proactively set the cached value during
repository discovery. Now that we stop doing that it becomes a problem
though, which we work around by resolving the gitdir via `realpath()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c |  2 +-
 setup.c             | 14 ++++++--------
 setup.h             |  2 +-
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 218b5f34d6..a216be63cf 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1063,7 +1063,7 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
-				printf("%s\n", is_inside_git_dir() ? "true"
+				printf("%s\n", is_inside_git_dir(the_repository) ? "true"
 						: "false");
 				continue;
 			}
diff --git a/setup.c b/setup.c
index ba2898473a..80f3ba0d62 100644
--- a/setup.c
+++ b/setup.c
@@ -26,7 +26,6 @@
 #include "trace2.h"
 #include "worktree.h"
 
-static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
 enum allowed_bare_repo {
@@ -299,7 +298,7 @@ void verify_filename(const char *prefix,
  */
 void verify_non_filename(const char *prefix, const char *arg)
 {
-	if (!is_inside_work_tree() || is_inside_git_dir())
+	if (!is_inside_work_tree() || is_inside_git_dir(the_repository))
 		return;
 	if (*arg == '-')
 		return; /* flag */
@@ -470,11 +469,12 @@ int is_nonbare_repository_dir(struct strbuf *path)
 	return ret;
 }
 
-int is_inside_git_dir(void)
+int is_inside_git_dir(struct repository *repo)
 {
-	if (inside_git_dir < 0)
-		inside_git_dir = is_inside_dir(repo_get_git_dir(the_repository));
-	return inside_git_dir;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = is_inside_dir(strbuf_realpath(&buf, repo_get_git_dir(repo), 1));
+	strbuf_release(&buf);
+	return ret;
 }
 
 int is_inside_work_tree(void)
@@ -1251,7 +1251,6 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	set_git_work_tree(".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		set_git_dir(repo, gitdir, 0);
-	inside_git_dir = 0;
 	inside_work_tree = 1;
 	if (offset >= cwd->len)
 		return NULL;
@@ -1287,7 +1286,6 @@ static const char *setup_bare_git_dir(struct repository *repo,
 		return setup_explicit_git_dir(repo, gitdir, cwd, repo_fmt, nongit_ok);
 	}
 
-	inside_git_dir = 1;
 	inside_work_tree = 0;
 	if (offset != cwd->len) {
 		if (chdir(cwd->buf))
diff --git a/setup.h b/setup.h
index 80bc6e5f07..115bda647c 100644
--- a/setup.h
+++ b/setup.h
@@ -4,7 +4,7 @@
 #include "refs.h"
 #include "string-list.h"
 
-int is_inside_git_dir(void);
+int is_inside_git_dir(struct repository *repo);
 int is_inside_work_tree(void);
 int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 int get_common_dir(struct strbuf *sb, const char *gitdir);

-- 
2.54.0.771.g3ed373ac14.dirty

