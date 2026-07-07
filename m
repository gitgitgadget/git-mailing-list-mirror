Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEAB3DCDA1
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408927; cv=none; b=TTqXlurZ91LXlXzb9yfb8P0fY6vl9jR/8JurIy8NyWzyVXXcauEW42rrUSR8J1LLzSHRs+sY4KTaca7dkQR6Ov9o0c5d5f42ogdtjI5gRqB8n9iUiKs0onUJy8oUKIGp+txerIeBwIiI1gnUKYia6yp2VtbJMkGFRo3xeFlcfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408927; c=relaxed/simple;
	bh=fJ8sAVzZ+u0tpBZED2yl/Rva0xQI6rxWA9jzoKrhb6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XeIwjjvbkMMMwASnxuvIUCtkhleQOkbtNua1H3sbbvT8vyBwbT7oHfsuA3qnNGiNHQoBRZvODiCrrAyP8KIIfQu+d/gCjwaXb3Cnt0KrTNtB2goPNFf2yh1DCKRSnvrJUs7dLBfXez230mZq7tMYQnrn/LoRi5I3Rh8EyvSTc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Di5Gkp4S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZ5/cJ1z; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Di5Gkp4S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZ5/cJ1z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE40A7A01AA;
	Tue,  7 Jul 2026 03:21:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 03:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408916;
	 x=1783495316; bh=faEA40i1q/eJ8SKmZ6VtaYOkazy4k3u8kqUQsVl9njo=; b=
	Di5Gkp4S31YSt/TXBuKd9zcMX+kz9FIJwVykjmzE9L84Sh5l8v5W58IrYmjTukhC
	4OhaTEM5rFtpNiOk7vp+YfdbDonUB7tBUPKrhbC7/BY8p4rNHwDit6JSFAhjMcDi
	Yr196DeXjeqe+zIvSrEkD5xH1uU9JWC/uMgZTnUXBY7zuegKOjVAylwDfxtNwKZs
	xA5pnb5JSC14Nq68R7YNMQZKbp97lXa46+3kUjPJAQcXUT91sUI1Xdse/sBEN0Ff
	t2FjKi/uTNVbP8BlXa6kWfF93x8Fmn4ZAwKOBlcvlIy6jOK3Gtclbly0NKv9vCbZ
	ULC8PrumNYgKTEWctP0h7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408916; x=
	1783495316; bh=faEA40i1q/eJ8SKmZ6VtaYOkazy4k3u8kqUQsVl9njo=; b=m
	Z5/cJ1z77J/ksRYT+xNnHmqFCUNNnchEX3kj0Jf2xKLGsZSNZkmFaChgjFSVEk0H
	9JiHDjsEYmULAUrN84oi8pm8+F0wu0figUmUMSrJuZt1TozzWyhCMQLfqZGmiQF2
	UQJwFVFHxGefurfwYZuCowP2zT89O8v8Q4zzVq6b237S/OO4LB434OeHuhnEoNhC
	4KuFBgOWFE3Eov1xqauYEEXhVyYxca6zB4rWRO5g6Fh+cvJ2An71Yil/WDYKRbBY
	QW40XFfnh5+Um5NiRnZWSIUvNdbUwIQs3cL4mlkLr85s48f6/O0HiE3lqcG1v0U4
	iyaBvYX6upTsbhvCx+AHQ==
X-ME-Sender: <xms:FKlMamRgx1HGycazFu3gNUOU0KMPngBXh7FHhQC0GNeWWmp3dFBq0g>
    <xme:FKlMajPafzjDZsBJaIVfi8XrH9NShuj7Pa8YG69vhpIqtPpH6o53gfKlsSxFQl9Gh
    Ozrs9lR5Zj4ZdnY7_UqHaUDE5ZfYPXsJyvUVn0irixx3ZLYzNLgxYc>
X-ME-Received: <xmr:FKlMahPC-4EFID6RsOMECn2Z2hYfK33fnERY-NKAvjMFWddKFmQYSOXDaMcKyVP37KUYZLIUkA3iZSelxGkoGa4RFFxDxQUAs0TEXMCANA>
X-ME-Proxy-Cause: dmFkZTG2qUw/Tgkoia2leiORO3CnT2psiSbTbZsVr+xn23PbGy2UA2WgQflYK7L4uHP8R7
    rxuh/iYf+X14txPdnnPRLBnJPnPvtBj7f5LYEGE2pFh93GhxIZlrMXBAaHJZFn6se1jZQv
    NO98+U308Rjsg5aEnzeOyb9eV8gqbASR/10N3jKyDmkJq1pSqJ01XEQSlQx1OITHPrraLA
    qX18YNBfup1eRrS5qtwbVy5+6KpUBJ8yMJxTa9LBaYGXwIfbwG8u3UaL3/XqHLOqFySXVs
    VXpo4geXrvi8M1kuj/cJv1f55LP5mMc11fkuX3ZKrB1spHPfoz5HaO4/pvXRYN1LxGSrhe
    W2Ig7Apc/JgAINflIRLFq7ni1ObSyrtb/v8AVKjYvioRC0mZt9ejCHBQAv0U0lc+Qbq+n3
    19p6mtasJ2MLariL8z4foAGR3tcV5RZiCcbtg51gkbq0z9T7AswmtErYRwVQj5NnW5UvIS
    syrNnSoD31+0RmmrFqWWLEcrepqOXk/IErowzoq01+u1JnAbqM6EQNBBRATWsOS7iq6wIZ
    Pqjj9K71xgkXbI1p8dnqwkGon5FvpRKqOh6dJDRRnbL5pu3dqTuS8b+aPn+ilr53e+98ix
    NussYjfzoUq7rcmbb6S750B+5L6VU0GaISX/1YAlWhksDCSEaPtclxLiXo7Q
X-ME-Proxy: <xmx:FKlMars33dTp8wRwTbWu0uBmmzFLNWJmrUFAQ0vvN4SDbKYPu2DhtQ>
    <xmx:FKlMajU4CFd0QDQTTkUW5FrqYZV1VMMWbeaeGEhHu64BRsy65vuc-g>
    <xmx:FKlMarsNbULTndXIMMpZcF8r5IaA9z2czMxkyD3DoBVvavtpDJJkLA>
    <xmx:FKlManXk-4JGOmvI9vQbNJVieaENvHieRIBXRBCmkjkhy314gMZjog>
    <xmx:FKlMajMiHvdI8zor2vBwKfYLDwI1Lg_RLTSX1F4_yU-XxTFzmnlmqltk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:21:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 92cbe5d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:29 +0200
Subject: [PATCH v2 10/13] setup: make repository discovery self-contained
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-10-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index d1db0a4ca0..d4de8c2900 100644
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
2.55.0.141.g00534a21ce.dirty

