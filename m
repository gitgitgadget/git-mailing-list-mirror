Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803845629C
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228861; cv=none; b=E4eMC6TB029vwMQXTTwCdbxvRNw/6lbAvf3kB70O4eeYPbwbmG5MOIm/9UGNm4E1I0YFxGdyqBlNlLrsvbCIT8RF5FTUDmFmCg0fa9ZW9Bt4Y1ThDVITb+3FomsLjWDINYQlj7RfXHC8F3qLl+f0kZ/GIRTdeZeeUqFu1j0EPSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228861; c=relaxed/simple;
	bh=/WWABBPaIcYVxHlWRock9Xd1CzGjbLe/gSmCp7OrgVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bt26nbuM4tthd7UiYU/RKMgJqWleWfG2Ks4lGZ9iKmdhwW72ESMmDlorRlr5eLMhNhkq9cNYS9ktZdxMvdYl/ctCzkDkp0svksG38ZitjQZX+i1JcgXytSN0IalqLO1SmewlDgUpGT25p0E6qpl3DPlPuNdH0OBBMMQW2M0POoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=ERBRujat; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fhAH4vI4; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="ERBRujat";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fhAH4vI4"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F21314000C2;
	Sat, 12 Sep 2026 12:00:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 12 Sep 2026 12:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789228859; x=
	1789315259; bh=VgDqBjBZ36XMTnt/dnjdqJete8ZuVsE5qYyAXv6B1wU=; b=E
	RBRujatIiaDmeU93yNqJ6BIGeW/yoXWvYUOuSyIpr4vWDtpEMVQuJpjZdcLyS7Bn
	kPJRb5w9PN7YZd9zAvpTVr1Ye1WJVF+3+aA6TEINakFcnW7NaPjQ6LHd7HTYz1B+
	nDrYtcAWbv+uAJH3DV+hPzYNWUglGeBwH2V6FeUGzUv8K/GneZhJhJPHszOqcswD
	sem8+eYCZJnpBthKmsXlS1a/rNMmqhzpfgpEfaH8X5L8/04SgSvcDPweKEGxCGLd
	bM6qlksCutOSMNCV4T2VAPnlF6vuV3WXyloqA+sxPdE+Ni4J85VBeAoVgS6mQ0W+
	0b8IF9ur//jisawAYRYww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789228859; x=1789315259; bh=V
	gDqBjBZ36XMTnt/dnjdqJete8ZuVsE5qYyAXv6B1wU=; b=fhAH4vI4pM8x9fTYQ
	22ZIMpEdY++iliVghJ8gnSqCYCgJIm9l7M7bJQrxBuNe8mRcRcfLazOc0V2o+OM5
	y5x50L6Rh8FxfNhZwul4Yr1SyubPYGykEMiDfKGDqSTPV3D+9aSulFrin8WdAfqD
	QfVbqWKFVeKG4Whq+rgI9XiBQx6w7FDvPgYFnkFOMiPgBS4AcuL552D2VgBtYKhO
	6YexSatNQGYaZjHT8uEC1F5cny6qpIHD7EQGHQk+9HgpsfmT3nVeEdfbqPr2Peqk
	tU+cq2hIPhH/uBK0zGad6r0LL5vhX2saX2uYEzaIcuFq5JUBz7k/G0L+djgazzHf
	zmP2Q==
X-ME-Sender: <xms:O3elagWWsRUO_E1vNtH0Fom7X_ZvQbcZNMUXhYymqZ6DiCzYPvHttA>
    <xme:O3elarkeMM-zQpoCkl47VrIeTi_VJvGFm6UiKyCph3oQm8JPQw3oc6Eg4DL820hdS
    DZy4ZaVCJ3XnP0TxxbLQuEJKssBfo6oAwLUZXrc85NMAOsOllHGMe3m>
X-ME-Received: <xmr:O3elapZYjaHsQ630-aDh9IWfgEDfFjtIc80WlUGZgbJDfW2zfJisJQwFFtvEVeyrsxd3LTc8dFfx0qEa03B94JnePMHPvUPT0EG6jkEyi2_Qtw>
X-ME-Proxy-Cause: dmFkZTEJzP3TrDj/EJZpEAQrG75aOaV9GM771ArQfABipHARsdFm0SHFh4/m+QKViygr2S
    2TjZ+j5UrVPSzOUMlDBf/nTGDzW6hkJ7V0NG9N5F1zk0/ktg+PZ61GmwJEyiUyrRcg0sr9
    fnxvk8Wu27LW35DrCgblsNn23raH4HZeP34IVmCoi2356wpSg0wYNq8tJoKbClnQeHq6Wu
    8TsU2OM0eNQLEYAa3cri9W8/RGzIS8RAhXrD51i7z97WE1Vv+RjFcUG2GUwGCu2ZYN3Tbj
    J5+pBAiRO8JX3pi7aHyHlbVy8zaNrdmBA2ezMGKVuxKf1mZIpXfKstvXYNtCSd5vVG2nUV
    UtIDo6lhea42JEuC92WIGC+hgffUU5ThW6eOT0n+d32cAMj5AhhB/21G6TZOd5HDltEnqi
    uEm2IeJoFpxqpgzf/ogME8nGm9yhdV/G7i7iF48q4oRskxGQYF4KfKHZfp9jRWp3K9EkZU
    wQWhyIkBmgay3qYKh5Wtd51AESZC1qXyNJyQ7sZnbFEmdClDVNyTiCTkWDw/N0G1nySOqr
    oY0IBA+wtHm8yD2CsPH/ZRlInL+RyKioJ1JXDiWqp20JdqSg5Y/WDcO7+bFGTFeaxZte9k
    c28GCpDPoDJW+eGiJ9Z9g00+DQMS+iA91PkUnYk//1INflw9hBvwjxX42A5w
X-ME-Proxy: <xmx:O3elauOJLV55Pnje1hx-oE8Hfv0au2NUthvvWuAXUJwHJ69Kpm0rCw>
    <xmx:O3elambdyqemOeusMkdiVHePbYWfFonZeu1NDNZRwEtmRh0H9zRkmA>
    <xmx:O3elak026JB5o-8hLLPekl9theov-O2qCBDLoTsxdReZGS8-iJnxNQ>
    <xmx:O3elakdgj7BpLU82jt3eHeOfuFyG5BYMiRf4hz5wvwKoezSAkJPfxQ>
    <xmx:O3elagDQ4G8IYBze0ocmhc0lNOn1ZNt1VmEUfeudA_-tpm9LITuELSGn>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 12:00:57 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v3 1/2] replay: allow callers to sign commits
Date: Sun, 13 Sep 2026 01:00:44 +0900
Message-ID: <20260912160045.36064-2-git@5ouma.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703145037.69832-1-git@5ouma.me>
References: <20260703145037.69832-1-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a signing-key option to replay_revisions_options and pass it to
commit_tree_extended() when creating replayed commits.

Signed-off-by: Souma <git@5ouma.me>
---
 replay.c | 13 ++++++++-----
 replay.h |  6 ++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/replay.c b/replay.c
index f415103023..3e8a70bce1 100644
--- a/replay.c
+++ b/replay.c
@@ -85,13 +85,13 @@ static struct commit *create_commit(struct repository *repo,
 				    struct tree *tree,
 				    struct commit *based_on,
 				    struct commit *parent,
-				    enum replay_mode mode)
+				    enum replay_mode mode,
+				    const char *sign_commit)
 {
 	struct object_id ret;
 	struct object *obj = NULL;
 	struct commit_list *parents = NULL;
 	char *author = NULL;
-	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra = NULL;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
@@ -288,7 +288,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result,
 					  enum replay_mode mode,
-					  enum replay_empty_commit_action empty)
+					  enum replay_empty_commit_action empty,
+					  const char *sign_commit)
 {
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
 
@@ -361,7 +362,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		}
 	}
 
-	return create_commit(repo, result->tree, pickme, replayed_base, mode);
+	return create_commit(repo, result->tree, pickme, replayed_base, mode,
+					    sign_commit);
 }
 
 void replay_result_release(struct replay_result *result)
@@ -481,7 +483,8 @@ int replay_revisions(struct rev_info *revs,
 
 			last_commit = pick_regular_commit(revs->repo, commit, base,
 							  &merge_opt, &result,
-							  mode, opts->empty);
+							  mode, opts->empty,
+							  opts->sign_commit);
 		}
 
 		if (!last_commit)
diff --git a/replay.h b/replay.h
index 2c71afbfde..2eb7704b74 100644
--- a/replay.h
+++ b/replay.h
@@ -57,6 +57,12 @@ struct replay_revisions_options {
 	 */
 	int contained;
 
+	/*
+	 * Key used to sign newly-created commits. An empty string requests the
+	 * default configured signing key, and NULL disables signing.
+	 */
+	const char *sign_commit;
+
 	/*
 	 * Controls what to do when a replayed commit becomes empty.
 	 * Defaults to REPLAY_EMPTY_COMMIT_DROP.
-- 
2.55.0

