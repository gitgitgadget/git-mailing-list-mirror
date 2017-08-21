Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293241F667
	for <e@80x24.org>; Mon, 21 Aug 2017 10:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbdHUKp0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 06:45:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37528 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbdHUKpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 06:45:25 -0400
Received: by mail-pg0-f65.google.com with SMTP id 83so23273750pgb.4
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 03:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MVQJ7QNhh7g2NEMKG9qntJPpDQLDaBM4KueSOt+oSqs=;
        b=GmFKxoKJj5QKcIwjiPeUNuhiO21lynpwpk8z7FJ16CaZx/pgyyV9XBSFPuwDmp7h9r
         DyExEl9S+rMTWvZnolCUfRNQpgnFBKK+K1y6j/w06Qt4qEIuJGq0izbwZRk5MOnCemzq
         HtkGxCRON0Og/i2lLgGKlUcDvD5ctTdOEA1zAGbtHiAK0rS5leP7yi8ER1uz6S2gz+xP
         0vIR0hWBncEfYoCtxnfROb4KiwFxeQ0Qx8lvxY1PI/0enA2T0IxVbCY74IYRsd44igrC
         wDXuRk50B96sOpWgtZYlO4+ffAHGgMwC0CfscOYnEz7JX0qXwoVMaLaR1qR2qTvCVDyT
         Hj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MVQJ7QNhh7g2NEMKG9qntJPpDQLDaBM4KueSOt+oSqs=;
        b=KTEfHaJdU03L/L5r7Zfarsz0vZaQGs/w+LZHc9I6XqIVe64tu3vdE8Y6xrluhfYPo5
         6aAJVd7mfovmeW8sMYhGeQLZZ0SJDbscqBaBBL6fAbaMAp+bSYpmzn4Fox6oi2Pruiit
         LyVXq9ZFpGqTxg5bpfIpxi67J8h+MTmuRpIasah/6w8vxeYVMRJ0T8n4WaLnrau0jL0q
         5f4XqkCBSFX+m731dtKCv/egusNpbRYh4YKv6HvyLfVh9Fb0wtUySB72iMCe2W6M6RQO
         yDd/Pmp6cCRvyQNoq2F8ZtN44mDXLINpitWgavePKvkQIupnc6xehA4KVi1bDayLRDGF
         bobw==
X-Gm-Message-State: AHYfb5gBVbHM/mMqjHvsdCeuOyV2BTn/PZHlh1/fNUljE1gDNeA5/eWq
        KDRVaGVnkqU4w5naNTE=
X-Received: by 10.101.91.203 with SMTP id o11mr16546339pgr.321.1503312324518;
        Mon, 21 Aug 2017 03:45:24 -0700 (PDT)
Received: from localhost.localdomain ([223.191.53.21])
        by smtp.gmail.com with ESMTPSA id l24sm20445785pgo.43.2017.08.21.03.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 03:45:24 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 1/4] submodule--helper: introduce get_submodule_displaypath()
Date:   Mon, 21 Aug 2017 21:45:12 +0530
Message-Id: <20170821161515.23775-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function get_submodule_displaypath() to replace the code
occurring in submodule_init() for generating displaypath of the
submodule with a call to it.

This new function will also be used in other parts of the system
in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
As said in the previous update,
a short patch series is floated for the maintainer's review,
and is consisting of the following changes:
* introduce function get_submodule_displaypath()
* introduce function for_each_submodule_list()
* port function set_name_rev() from shell to C
* port submodule subcommand 'status' from shell to C

The complete build report for the above series of patches is available
at:
https://travis-ci.org/pratham-pc/git/builds
Branch: week-14-1
Build #158
The above changes are also push on github and are available at:
https://github.com/pratham-pc/git/commits/week-14-1

The above changes were based on master branch.
But along with the above changes, the same series was also applied
to a separate branch based on the 'next' branch. The changes were
applicable without any additional changes to the patches.
Complete build report of that is also available at:
https://travis-ci.org/pratham-pc/git/builds
Branch: week-14-1-next
Build #159
The above changes are also push on github and are available at:
https://github.com/pratham-pc/git/commits/week-14-1-next

 builtin/submodule--helper.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 84562ec83..dcdbde963 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -220,6 +220,27 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+
+	if (prefix && super_prefix) {
+		BUG("cannot have prefix '%s' and superprefix '%s'",
+		    prefix, super_prefix);
+	} else if (prefix) {
+		struct strbuf sb = STRBUF_INIT;
+		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
+		strbuf_release(&sb);
+		return displaypath;
+	} else if (super_prefix) {
+		int len = strlen(super_prefix);
+		const char *format = is_dir_sep(super_prefix[len - 1]) ? "%s%s" : "%s/%s";
+		return xstrfmt(format, super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -339,16 +360,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 	/* Only loads from .gitmodules, no overlay with .git/config */
 	gitmodules_config();
-
-	if (prefix && get_super_prefix())
-		die("BUG: cannot have prefix and superprefix");
-	else if (prefix)
-		displaypath = xstrdup(relative_path(path, prefix, &sb));
-	else if (get_super_prefix()) {
-		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
-		displaypath = strbuf_detach(&sb, NULL);
-	} else
-		displaypath = xstrdup(path);
+	displaypath = get_submodule_displaypath(path, prefix);
 
 	sub = submodule_from_path(&null_oid, path);
 
@@ -363,7 +375,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * Set active flag for the submodule being initialized
 	 */
 	if (!is_submodule_active(the_repository, path)) {
-		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
 	}
-- 
2.13.0

