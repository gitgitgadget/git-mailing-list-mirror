Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5722EEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 23:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjF0X5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 19:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjF0X5j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 19:57:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC4A2103
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 16:57:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3110ab7110aso5978736f8f.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687910256; x=1690502256;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0H7mlgxmZC6CxuLm0UlnX0dffY6VbzmK+U7LJHQG+nA=;
        b=BC2QQolZd0MI2TkLiCHwXAEwIjw8XgkxdnMAQu+gHsgq5X6dbKM8hQc2q0SHgZiHsR
         bldBv1M7JzUpQfHFAboufJh+fVmG2DGQ5Pwm34k/1noQLaD5k7Cw9rxYZavkOGniaNQ8
         +uhKdS+I1FDecnSSPacHAEJwWkh6V+eG6JJfQR7s7LHpwNKLxiuIHnIdiSZn5VxLlvNs
         MmvUQTY1MElEcriLwCgUMW6BUf3FABhr8gPj70noDj/6Ka20VjzhDMG/8SLis3RhYN0Y
         rnVvnr/uw9+nxFMsv1aWwaFOys4vDMpXnrypgltIq8n9cNlnOo4xT8+MKnBN0lsut7pR
         m6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687910256; x=1690502256;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0H7mlgxmZC6CxuLm0UlnX0dffY6VbzmK+U7LJHQG+nA=;
        b=TYcdlwPbLa0IXkaOMXadVFzT8MifAnkNjFtIl6j5w15dEiVFMSVkI6cHvfUyakJ/VD
         rleG4eDZRDR/4Ni9z0h17hx6ZQTL6TFwnMxvRBaMX+ETKlgaM1572MzqDs/yf63Hzjt2
         KRWj3lXGqgBnCfuEMv7sQclXUqzz58xUX7S+LF5Ynf6IkrsZr0F7rb77FECl9C+OD7ex
         lEXlGKePPmJsiXE4pIgN5sAk3w0Ppk9iuj3z61cEm8Hl0E0Go53Zmb2EirjTkWXWF0IK
         6lCE/39bRqQhbKmovsYAizGNY6YRCzkf0yGl4uRyszvMe3sPLgZFuqSQYmoW/wFlZwW7
         PbxA==
X-Gm-Message-State: AC+VfDy2612AuAqdW24KR/sNh1tY1NxnWiE5Wb9nmGZapjnEA4/67Npr
        K2M9W73S2eylMCR8e4RQiO2Dt/Qbj5o=
X-Google-Smtp-Source: ACHHUZ7jMUHoq/wHVFaiNckyo+lPWwrs3sjcUyCpQ/5qxawwleSLuJxkahb7h6J2c631n0zp8YHIbQ==
X-Received: by 2002:adf:fb04:0:b0:30f:bb81:d056 with SMTP id c4-20020adffb04000000b0030fbb81d056mr24330549wrr.60.1687910255586;
        Tue, 27 Jun 2023 16:57:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b00313de682eb3sm11706807wrp.65.2023.06.27.16.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 16:57:35 -0700 (PDT)
Message-Id: <pull.1538.git.git.1687910254473.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 23:57:34 +0000
Subject: [PATCH] submodule: show inconsistent .gitmodules precedence
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Demonstrate, using tests, an inconsistency in how Git treats repeated
configuration keys in .gitmodules depending on whether we read it from
the working tree or from an object. Do not attempt to fix it yet,
because we don't know how much test coverage we have here, and what the
'right' fix is.

When a .gitmodules file contains multiple configurations for a submodule
like so:

  [submodule "sub"]
    path = path1
    path = path2

It's clearly misconfigured, but our docs don't state what we do in this
situation. If one checks this with "test-tool submodule-config", you'd
see that we ignore every value after the first (aka first-one-wins) and
issue a warning. *But* if you actually tried this with "git submodule",
you'd find it practically impossible to trigger this behavior - what you
actually see is last-one-wins!

The difference between the two is somewhat complicated because there are
two factors at play. The first is a probable bug in how
parse_config_parameter.overwrite affects the way submodule config is
cached. In submodule-config.c:parse_config(), when ".overwrite = 1", the
submodule machinery gladly overwrites the existing value (last-one-wins)
instead of issuing the warning (first-one-wins). This is probably a bug
because it seems that .overwrite is intended to overwrite cached values
from a previous .gitmodules (e.g. if we read .gitmodules from the index
and want to overwrite it with a newer version), not to overwrite values
that we read in the same file.

The second factor is that the two are reading differently cached values:
"git submodule" is reading cached values with ".overwrite = 1", but
test-tool is reading from cached values with ".overwrite = 0". The
submodule cache stores each submodule config based on the submodule name
and the .gitmodules oid it was read from (null_oid() if it's from the
working tree). Both code paths eventually call repo_read_gitmodules() to
eagerly cache .gitmodules from the working tree, and which happens to
use ".overwrite = 1". "git submodule" typically passes null_oid(), which
reads back this value. However, test-tool reads back values from the
actual .gitmodules oid. This causes a cache miss, but when we try to
populate the cache at that oid, we do it with ".overwrite = 0", causing
the difference in behavior.

To make this behavior easy to demonstrate, I've opted to teach test-tool
how to use null_oid() rather than use a real Git command, but this is
almost certainly affecting us in real Git. It's probably flying under
the radar due to some combination of submodule_from_[path|name]() being
relatively uncommon in the codebase, and such misconfigurations being
rare in practice.

We could fix this bug by targeting either of these factors:

- Make ".overwrite = 1" and ".overwrite = 0" do the same thing with
  repeated values in a .gitmodules.
- Remove the eager caching (repo_read_gitmodules()). It seems like we
  can lazily populate the cache on a miss, so we might not need this.

But I'm not sure how long this has been around, and whether users have
come to expect one over the other, so I've opted not to send a fix yet.

Signed-off-by: Glen Choo <chooglen@google.com>
---
    submodule: show inconsistent .gitmodules precedence
    
    While I was writing a .gitmodules parser for jj
    (https://github.com/martinvonz/jj, check it out, it's great!), a
    reviewer asked what would happen if a submodule had repeated fields
    (like .path). It turns out that the answer isn't just undefined (it's
    nowhere in the docs), it's inconsistent!
    
    Here's a bug report patch that demonstrates the issue using test-tool.
    I've stopped short of sending a fix because 1) I'm frankly not sure what
    behavior users have come to rely on 2) this problem is multi-faceted, so
    we could fix this in quite a few ways, but I'm not sure which way is
    'right'.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1538%2Fchooglen%2Fpush-lzmyuzkpxxxq-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1538/chooglen/push-lzmyuzkpxxxq-v1
Pull-Request: https://github.com/git/git/pull/1538

 submodule-config.c               |  7 +++++++
 t/helper/test-submodule-config.c | 22 +++++++++++++++++++++-
 t/t7411-submodule-config.sh      | 22 ++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/submodule-config.c b/submodule-config.c
index 7eb7a0d88d2..1c4b5afa8e4 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -441,6 +441,13 @@ static int parse_config(const char *var, const char *value, void *data)
 					     me->gitmodules_oid,
 					     name.buf);
 
+	/*
+	 * FIXME me->overwrite=1 is only meant to overwrite existing submodule
+	 * configurations when we're reading from another .gitmodules (e.g. from
+	 * another commit), but it also unintentionally changes behavior when
+	 * there are multiple configurations in a single .gitmodules - instead
+	 * of respecting the first value, we now respect the last value.
+	 */
 	if (!strcmp(item.buf, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 9df2f03ac80..1bb1dc45878 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -29,11 +29,31 @@ int cmd__submodule_config(int argc, const char **argv)
 		my_argc--;
 	}
 
-	if (my_argc % 2 != 0)
+	if (my_argc > 1 && my_argc % 2 != 0)
 		die_usage(argc, argv, "Wrong number of arguments.");
 
 	setup_git_directory();
 
+	if (my_argc == 1) {
+		const struct submodule *submodule;
+		const char *path_or_name;
+
+		path_or_name = arg[0];
+		if (lookup_name) {
+			submodule = submodule_from_name(the_repository,
+							null_oid(), path_or_name);
+		} else
+			submodule = submodule_from_path(the_repository,
+							null_oid(), path_or_name);
+		if (!submodule)
+			die_usage(argc, argv, "Submodule not found.");
+
+		printf("Submodule name: '%s' for path '%s'\n", submodule->name,
+		       submodule->path);
+
+		return 0;
+	}
+
 	while (*arg) {
 		struct object_id commit_oid;
 		const struct submodule *submodule;
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index c0167944abd..b67eea7e085 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -258,4 +258,26 @@ test_expect_success 'reading nested submodules config when .gitmodules is not in
 	)
 '
 
+test_expect_success 'multiple config fields in .gitmodules' '
+	test_when_finished "rm -fr super-duplicate" &&
+	mkdir super-duplicate &&
+	(cd super-duplicate &&
+		git init &&
+		git submodule add ../submodule &&
+		git config --file .gitmodules --add submodule.submodule.path ignored &&
+		git config --file .gitmodules --add submodule.submodule.url ignored &&
+		git add .gitmodules &&
+		git commit -m "duplicate fields in .gitmodules" &&
+		test-tool submodule-config HEAD submodule >actual 2>warning &&
+		grep "Skipping second one" warning &&
+		echo "Submodule name: ${SQ}submodule${SQ} for path ${SQ}submodule${SQ}" >expect &&
+		test_cmp expect actual &&
+		# FIXME this should give the same result as "HEAD", but there is
+		#   a bug where if we use null_oid() instead of the real commit
+		#   id, the second .path gets respected instead of the first.
+		test_must_fail test-tool submodule-config submodule 2>null-oid-error &&
+		grep "Submodule not found" null-oid-error
+	)
+'
+
 test_done

base-commit: 6ff334181cfb6485d3ba50843038209a2a253907
-- 
gitgitgadget
