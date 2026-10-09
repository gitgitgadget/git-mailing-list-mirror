Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D254D7D4B
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553218; cv=none; b=qpSd6qTlXYmZHc9RFi2r+JynAPoGCMBo9Te/x57GNCgaz9TA9/uv0I8pFZn6r/+06dzIOACgZX+sHU+11531XcdJVyOF54Scj+9RrjV38VL6C0ATst4QcG6tk6+aot/Ous8t9VWA8cGxtkxm1VSpCLXZfR9zZQgXmnigGUjYMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553218; c=relaxed/simple;
	bh=O39DMlHChtD77gi/pn8jzifGHlNu6OnCZsXx9PkRIU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpjm0poO4G5b+u6XF7Ss3GxcKoyynao8hk/IN8X+QKmKSvF5q4FgFRaLm+PyMC27HNMbuCLVWt8lcYhshYex5T8Hd0qsd1D+TI8TiyK5IxKXTNTn34uf9JIQhAortmROUKtwNRxBi/8ef9k6L8lfSxO3kkovBXmA4WdMSSPpqJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyqLdgS4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyqLdgS4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so5517150f8f.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791553214; x=1792158014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cyfBPM2X7EwkLzB1jLlA1gkgWKOOJo5tY5erMX/wG5A=;
        b=JyqLdgS4RI3YBAsipuaE/T6ZV3FR2velZQ/WlLUe6BHcImB0BC07N8qv/f/ZmNwOiq
         nfFIt4Yq8NTu38HgugCp7/H0/shATkIVULNSIWgDfcUx+jB3QiForJGekcFqxiHRHuzw
         BTeFQ4BEOETr8VwWd5zuvFSoW5DRbIf3COGdXmONiDvrXeCGIBVZsFU9Bkz0hlsjzZdl
         pRczrW5LwapoKMFdc6fx0leAHTY7cDKvp4Phh1oZt6YD6Z0wLn35EGf4ADDvuEyp9wgQ
         15Zd9H8xTkvAYghU3Jc1I4XY7v2FIRnTBjVzGVdTwwbwCBYuxn2EqgQg71zoRYMARz5n
         iNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553214; x=1792158014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyfBPM2X7EwkLzB1jLlA1gkgWKOOJo5tY5erMX/wG5A=;
        b=uJDmr9r781AkHBUO2ukaRMBwEiiezqtFFejyGojLk36xj3IGaR6/KoxHxvy9ZX/ncj
         V6gli2Q43rvFR1y4PL3UV4ecAyNEDiu5/0UJ3MkO7h/zMLSRIZ4FhtEJMcFEaywWey00
         UdiJ1LtJ9s3yNnCyx1qMAub8l9exlgHb4W49q/TASJl0Ey3GzVWsUaYw41wgsAJQdXT9
         zkbjt0IRuwpbSg6kJFVWAv5YmsyouoeMrOqX03+PhdquoXWdwZivbBDqggP8Ekuzv8of
         4vvJakKRlWlP7B73F2bU7o7Boom/4vPnIu40EDxTd4Bj1n2Z65QSJvxkiBC9Dyz7HOdV
         /cOQ==
X-Gm-Message-State: AFq9FYL50kzqzNRef87UYb2xflj3WaA59A/s8pCR3tMJnT3GTemrx+Wv
	82dOKlOJKTHFapSmd3eFkJLmu6DJJxpe3IOTQtwSX1TOeIScCigmv+I3718H/sJz
X-Gm-Gg: AYBFou2UslzuQQNrEUparTU7cbE9tomNgDmnYD/1GRuoczirowIRkkAQpSZ4RxBwgXS
	hjZo3Xx3J5VbABKbzPTG025RLWZc4aHhIe/nVS/g5HWGRNsp8SPeqnVi1veVEG++IF3spUTM8o4
	GuFrEpYtjGCUJJEJnNjhf4XD3RZevvTkJlRZhJESq+HdeeXNDN2H747hpANe7BgLUL78poQzXxc
	sKfivnU7qsDxwQ5yVZxDtkoZ5iNenVekHMXlM+U9zEr6tK3Fv9SqBoLml1nVI+WFYcHUfpJskTs
	98HTgZZ3x9huoEmIxPr1IK3nKmSqYCZNXy6cVtXQ/QJSamkMc8b1bMcCxbh6hfdFTlMtdIL5+AH
	Atbe5PUaZXYo6o/4c9OMzd4k+0TrSOVFv5UMWbq91k6DVXAZxkadctcxFMp7PxOsFHITzSEGPES
	p5ADqNBL0mpGcz6jfXNV8FBo01HH9+eT5sv8wYuMvvl+9CV/1T0UCb+AHMpF1vs1/QiCqO8izLu
	EB9zK7zbaor68VdT4MKyGeTzvo3UXA=
X-Received: by 2002:a05:6000:46d6:b0:488:83b1:16a1 with SMTP id ffacd0b85a97d-48dba789368mr2284405f8f.7.1791553214049;
        Fri, 09 Oct 2026 06:40:14 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.28.158.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9adf5e6sm3898850f8f.56.2026.10.09.06.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:40:13 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>
Subject: [RFC PATCH] status: reword message for a missing upstream branch
Date: Fri,  9 Oct 2026 15:40:04 +0200
Message-ID: <20261009134004.188952-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clone an empty repository, make a commit and run "git status":

    $ git init --bare empty.git
    $ git clone empty.git work && cd work
    $ git commit --allow-empty -m initial
    $ git status
    On branch master
    Your branch is based on 'origin/master', but the upstream is gone.
      (use "git branch --unset-upstream" to fixup)

The upstream is not gone, it was never there: the remote is empty,
so origin/master has not been created yet. The advice is also not
what the user needs; "git push" creates origin/master and the
message goes away.

The message was added in f2e087395b (branch: report invalid tracking
branch as gone, 2013-08-26), assuming that a configured upstream that
cannot be resolved must have been deleted. But "git clone" of an empty
repository configures the upstream anyway, and Git has no way to tell
"deleted" from "not created yet".

Since we cannot tell the two cases apart, change the message for both,
including the "deleted" case that has been reported as "gone" since
2013, so that it is correct either way:

    Your branch is set up to track 'origin/master', which does not exist.
      (use "git push" to create it)
      (use "git branch --unset-upstream" to stop tracking it)

Only suggest "git push" when it would actually create the upstream,
that is when the push destination of the branch (what "@{push}"
resolves to) is the upstream itself. This is not the case, for
example, with push.default set to "nothing", or when pushing to a
different remote (branch.<name>.pushRemote or remote.pushDefault).
It is also not the case with push.default set to "matching": it only
pushes branches that already exist on the remote, so it would not
create the missing upstream. In all these cases only suggest
"git branch --unset-upstream".

"git checkout" prints the same message, so it changes too. The
"[gone]" shown by "git status -sb", "git branch -vv" and
"%(upstream:track)" is not changed, as scripts may depend on it.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is an RFC mainly about the wording. The case of a freshly cloned
empty repository has been confusing users for a while, e.g.
https://stackoverflow.com/questions/24870145

I could not find a previous discussion of this case on the list.
Opinions on whether "status:" or "remote:" is the better area prefix
are also welcome, as "git checkout" shows the same message.

 remote.c                 |  34 +++++++++--
 t/t6040-tracking-info.sh | 120 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 71170f36a9..4ed4d1ee2f 100644
--- a/remote.c
+++ b/remote.c
@@ -2442,6 +2442,31 @@ static void format_branch_comparison(struct strbuf *sb,
 	}
 }
 
+/*
+ * Would a plain "git push" create the remote-tracking ref "upstream"?
+ * Not with "matching", which only updates branches that already exist
+ * on the remote.
+ */
+static bool push_creates(const char *push_ref, const char *upstream)
+{
+	return push_ref && !strcmp(push_ref, upstream) &&
+	       repo_config_values(the_repository)->push_default !=
+	       PUSH_DEFAULT_MATCHING;
+}
+
+static void format_missing_upstream(struct strbuf *sb, const char *name,
+				    bool suggest_push)
+{
+	strbuf_addf(sb, _("Your branch is set up to track '%s', "
+			  "which does not exist.\n"), name);
+	if (!advice_enabled(ADVICE_STATUS_HINTS))
+		return;
+	if (suggest_push)
+		strbuf_addstr(sb, _("  (use \"git push\" to create it)\n"));
+	strbuf_addstr(sb, _("  (use \"git branch --unset-upstream\" "
+			    "to stop tracking it)\n"));
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -2503,12 +2528,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 
 		if (cmp < 0) {
 			if (is_upstream) {
-				strbuf_addf(sb,
-					_("Your branch is based on '%s', but the upstream is gone.\n"),
-					short_ref);
-				if (advice_enabled(ADVICE_STATUS_HINTS))
-					strbuf_addstr(sb,
-						_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+				format_missing_upstream(sb, short_ref,
+							push_creates(push_ref,
+								     full_ref));
 				reported = 1;
 			}
 			free(full_ref);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index e95d420972..39cb755ccc 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -96,7 +96,7 @@ test_expect_success 'checkout (upstream is gone)' '
 		cd test &&
 		git checkout b5
 	) >actual &&
-	test_grep "is based on .*, but the upstream is gone." actual
+	test_grep "set up to track .*, which does not exist." actual
 '
 
 test_expect_success 'checkout (up-to-date with upstream)' '
@@ -123,7 +123,123 @@ test_expect_success 'status (upstream is gone)' '
 		# reports nothing to commit
 		test_must_fail git commit --dry-run
 	) >actual &&
-	test_grep "is based on .*, but the upstream is gone." actual
+	test_grep "set up to track .*, which does not exist." actual
+'
+
+test_expect_success 'setup clone of an empty repository' '
+	git init --bare empty.git &&
+	git clone empty.git empty-clone &&
+	git -C empty-clone commit --allow-empty -m initial
+'
+
+test_expect_success 'status (upstream not yet pushed after empty clone)' '
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+	  (use "git push" to create it)
+	  (use "git branch --unset-upstream" to stop tracking it)
+
+	nothing to commit, working tree clean
+	EOF
+	git -C empty-clone status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout (upstream not yet pushed after empty clone)' '
+	test_when_finished "git -C empty-clone branch -D tmp" &&
+	cat >expect <<-EOF &&
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+	  (use "git push" to create it)
+	  (use "git branch --unset-upstream" to stop tracking it)
+	EOF
+	git -C empty-clone checkout -b tmp &&
+	git -C empty-clone checkout main >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'status -s -b (upstream not yet pushed after empty clone)' '
+	echo "## main...origin/main [gone]" >expect &&
+	git -C empty-clone status -s -b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup expected output without "git push" advice' '
+	cat >expect-no-push <<-EOF
+	On branch main
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+	  (use "git branch --unset-upstream" to stop tracking it)
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'status (missing upstream, push.default=nothing)' '
+	git -C empty-clone -c push.default=nothing status >actual &&
+	test_cmp expect-no-push actual
+'
+
+# "matching" only updates branches that already exist on the remote
+test_expect_success 'status (missing upstream, push.default=matching)' '
+	git -C empty-clone -c push.default=matching status >actual &&
+	test_cmp expect-no-push actual
+'
+
+test_expect_success 'status (missing upstream, pushRemote is another remote)' '
+	git init --bare fork.git &&
+	git -C empty-clone remote add fork ../fork.git &&
+	git -C empty-clone -c branch.main.pushRemote=fork status >actual &&
+	test_cmp expect-no-push actual
+'
+
+test_expect_success 'status (missing upstream, advice.statusHints=false)' '
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+
+	nothing to commit, working tree clean
+	EOF
+	git -C empty-clone -c advice.statusHints=false status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup upstream deleted on the remote and pruned' '
+	git init --bare pruned.git &&
+	git clone pruned.git pruned-clone &&
+	(
+		cd pruned-clone &&
+		git commit --allow-empty -m initial &&
+		git push origin main &&
+		git checkout -b topic &&
+		git push -u origin topic
+	) &&
+	git -C pruned.git branch -D topic &&
+	git -C pruned-clone fetch --prune
+'
+
+test_expect_success 'status (upstream deleted on the remote and pruned)' '
+	cat >expect <<-EOF &&
+	On branch topic
+	Your branch is set up to track ${SQ}origin/topic${SQ}, which does not exist.
+	  (use "git push" to create it)
+	  (use "git branch --unset-upstream" to stop tracking it)
+
+	nothing to commit, working tree clean
+	EOF
+	git -C pruned-clone status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'short formats still show "gone" for a deleted upstream' '
+	echo "## topic...origin/topic [gone]" >expect &&
+	git -C pruned-clone status -s -b >actual &&
+	test_cmp expect actual &&
+	git -C pruned-clone branch -vv >actual &&
+	test_grep "^\* topic .* \[origin/topic: gone\] initial$" actual &&
+	echo "topic [gone]" >expect &&
+	git -C pruned-clone for-each-ref \
+		--format="%(refname:short) %(upstream:track)" \
+		refs/heads/topic >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'status (up-to-date with upstream)' '

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.56.0.116.g6de20f6092.dirty

