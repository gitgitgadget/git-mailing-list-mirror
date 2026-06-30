Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626240683C
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820102; cv=none; b=TtWq2wA5hMScGZI0SIMXlyrPYnzbEfU96YjaLGGH+Q9vUgptptXHsglRjSrG+NmIaO+gWedc8j1Jb2CKaRXILDNcZyTt22+eft0fKf/Cesoh7cFs7tDA9FPQrLLZjf8AR0GWuyv8VQIHLZPy7ajV4+h2+oWv5eAtv90iRMEp7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820102; c=relaxed/simple;
	bh=e0HIyOlE0ACG9oJeF+Ib2amBvbAkCdnDU5B1CY7Dbqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/85Q2q2P/w//0o+HxDWhCDj0QPfYxcu/xolYCqRDHWevNoX+jdGAmEM529RduvAK+niA55H4kU4+7ZHxQKedS+Z8hOJKmDLBFhTWJKTBa2nMcaywMcD0uENsxG1BuvORuDIndSHEiKy6XSzPSXQuC1470a4PhfbY5CCht7t0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TohxKlzJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xxh3ocKM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TohxKlzJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xxh3ocKM"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DBBE91D00132
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 30 Jun 2026 07:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820100;
	 x=1782906500; bh=OnxtLQ8uEdcSU8PaFZJGk5HfkQLdoCfm/kcr4m8RSEo=; b=
	TohxKlzJyrUXewKCyqh9YPwKT9RbwfU5pXe+e4KH60hn5O5KBSpDdWxqs/YbpiLf
	vHEhhjfUkqvgDdtxYfDotcAEOrWNKfA7bL05ifXxmrrL56PoTAx8EFQyXjx9BMw8
	rpoabkQ+OtQnPWuQ6iXYvrz8Vl+/7zuIPYtTApdD5i/RrM2uVkJveCDsz0a5xjPY
	/EQs1J18UQ8bO2mOZYjk595hzXYSHbejxq6EuT9TuD0Jkl5v4kMi80e7Zqy5vgC3
	hel2+Y0LR1JOymLSPNFlMWwv8n/f6vzFeahXWsmFUH29xRbYt7v7ynT7lfrJRz+B
	+rgfUAcGeRYMQcjisaMF+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820100; x=
	1782906500; bh=OnxtLQ8uEdcSU8PaFZJGk5HfkQLdoCfm/kcr4m8RSEo=; b=X
	xh3ocKMXQ2LhgbsT7SkpN00U78Beeh28bWPh+4Lnb1dGiZkAMxd/yTkfhqL22A1c
	g0bzQ3tPT32FaW0Dc5YY1kdTrfVhS5ow2APlfjA7r7RKHazEN31XP5oB7ZMZyigE
	ALrFJ8jRZcdctemoBQkr5Q7Rhq5Zm8eigLPnZIH2uhqS7Cb7t3pvRS1RFtGOZklJ
	2GBBCj6ccO66MUYqrvSA6fQmby8vMmmVPdaOoxWLtonnH0X5IGLhkheIi3AYOV5/
	OrzZHrzicPeMqUiNShl41ec1ML5RSDWghjTUOGTjjFFyaTZ6UOj+VkWSXJbA98zU
	iUppHhVPv8nJlBiFrVWtg==
X-ME-Sender: <xms:BK1Dat7E3VT2qonbT1dfO_zQo9NRnW_yQpshJYCO4KkF9CkbEIHESA>
    <xme:BK1Dah1blAiMvdzQzAMR10D0b_cejk-AIoYDb6qO1NiqAUhQrkYMYOGENjDFHWiBQ
    AsWyoNEj1L-KZGs36hVUDMs0V7mMkjK52fJuJY8pEDrLkwgLDSbeQ>
X-ME-Received: <xmr:BK1DaqFE5ZGGxuhzxYgQZzTiH15CrSGlo3QnG9LctwCO0RjJP_tCB6iqqlZ0R1ix5rhKbkKK2MR2jw2mUc9QCuCEI7whnl3KGkLn5XJQsbdCpA>
X-ME-Proxy-Cause: dmFkZTFDZ8EBIRkLTKt14TuSGr1p9PVZekTad1c/wqf+J4rUdU57yUeNCpU56+znu8nsjb
    fYDR646+CJ3TGFv8kQTHR4VNBrT/tkMeSXjzT67aaHpKiIdg7Ex7ASQFMr3pvovOMeWRc2
    b+Hb+9BEYhuDH+pmqgJy7oGhS1oPcxj3Hy28pR4Uz81T3ewRUNKEnbf7HExREqmx77S7CO
    8q4+s9ohDmUs11CzmmSQpKP0fvZO9hDzS3HZYuZIL2rRpsr/my7MnY/OfRKNFc3m22a8aE
    0HfNWlTaLhp/UB/uVY+/uRI7kUgfffb/QcAn+DT1zAl/2aW3MU8z9wRoF8TwRTtj2JqpL7
    pH33r1qstpTW2ZTvMkwgmdLprb/kdNGDqNUaU4BNyQKRkgj16/tIHOFOMBylCfqk+DzRO/
    n1/QYuePTzaMx6JcP937mF5SXV/TZ8fRCwChwyfIsb7pCBoxiaTE+HSyYKdKSBWPVLHk4j
    yu02qn1G2L+inX85tyQh06tg3QjuO6i2ywySVymGzY6fiT/uRz/zU13SHO6DnaWJT5pwV6
    IECKRuqN2ccbUejhaxLAj1jd/o7sTL4sr5ON+HZ5o+myIc1uxH2P1frs49tXzzNOIOv4T4
    frohvCFipWW8Bpv3Ss6VlKJtNIBxG13sjijLY4exRS2O1JQ5fG+3I0ZyswPQ
X-ME-Proxy: <xmx:BK1DarRfKGU6C1OyfjYpKnz7vY9yfDPzpQXcmK7w_8_VasMQgWt40A>
    <xmx:BK1DahBtQUvMYvIz5UwqPDyKDC7tdjGK-VRAqO656BrS-gZ9BWU0nA>
    <xmx:BK1Dar28Qv-qtjcH1RpdeIxwXmEe9dqQ8S6qrozWbWxoCqrL2IfKZw>
    <xmx:BK1DavUzN5hrYxby0jUYVeW5bTrgNZznZFHQfogMqnXW0CeJnV5jYw>
    <xmx:BK1DaiYEhD9z4fu07vykSbFj0KW7oEMMsRxnm3qMGqPO4ypTTiC7u1nE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e0f4fe72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:48:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:49 +0200
Subject: [PATCH 10/13] setup: make repository discovery self-contained
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-10-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the preceding commits we have introduced a separate repository
discovery phase and refactored the logic so that we have two clear
phases:

  1. Repository discovery, which doesn't modify the repository itself at
     all.

  2. Repository configuration, which takes the information we have
     discovered to set up the repository.

Extract the first phase into a new function `repo_discover()` to further
stress these two different phases.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/setup.c b/setup.c
index fc73276149..7715f3ea85 100644
--- a/setup.c
+++ b/setup.c
@@ -1922,20 +1922,10 @@ void set_git_work_tree(struct repository *repo, const char *new_work_tree)
 	repo_set_worktree(repo, new_work_tree);
 }
 
-const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
+static void repo_discover(struct repo_discovery *discovery, int *nongit_ok)
 {
 	struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
-	struct repo_discovery discovery = REPO_DISCOVERY_INIT;
-
-	/*
-	 * We may have read an incomplete configuration before
-	 * setting-up the git directory. If so, clear the cache so
-	 * that the next queries to the configuration reload complete
-	 * configuration (including the per-repo config file that we
-	 * ignored previously).
-	 */
-	repo_config_clear(repo);
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -1951,19 +1941,19 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 	switch (repo_discovery_find_dir(&dir, &gitdir, &report, 1)) {
 	case GIT_DIR_EXPLICIT:
-		repo_discover_explicit_gitdir(&discovery, gitdir.buf, &cwd,
+		repo_discover_explicit_gitdir(discovery, gitdir.buf, &cwd,
 					      nongit_ok);
 		break;
 	case GIT_DIR_DISCOVERED:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
-		repo_discover_implicit_gitdir(&discovery, gitdir.buf, &cwd, dir.len,
+		repo_discover_implicit_gitdir(discovery, gitdir.buf, &cwd, dir.len,
 					      nongit_ok);
 		break;
 	case GIT_DIR_BARE:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
-		repo_discover_bare_gitdir(&discovery, &cwd, dir.len, nongit_ok);
+		repo_discover_bare_gitdir(discovery, &cwd, dir.len, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
 		if (!nongit_ok)
@@ -2013,6 +2003,27 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		BUG("unhandled repo_discovery_find_dir() result");
 	}
 
+	strbuf_release(&dir);
+	strbuf_release(&cwd);
+	strbuf_release(&gitdir);
+	strbuf_release(&report);
+}
+
+const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
+{
+	struct repo_discovery discovery = REPO_DISCOVERY_INIT;
+
+	/*
+	 * We may have read an incomplete configuration before
+	 * setting-up the git directory. If so, clear the cache so
+	 * that the next queries to the configuration reload complete
+	 * configuration (including the per-repo config file that we
+	 * ignored previously).
+	 */
+	repo_config_clear(repo);
+
+	repo_discover(&discovery, nongit_ok);
+
 	/*
 	 * At this point, nongit_ok is stable. If it is non-NULL and points
 	 * to a non-zero value, then this means that we haven't found a
@@ -2104,10 +2115,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	setup_original_cwd(repo);
 
 	repo_discovery_release(&discovery);
-	strbuf_release(&dir);
-	strbuf_release(&cwd);
-	strbuf_release(&gitdir);
-	strbuf_release(&report);
 	return repo->prefix;
 }
 

-- 
2.55.0.795.g602f6c329a.dirty

