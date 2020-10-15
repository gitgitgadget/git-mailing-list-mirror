Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB86C43457
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511BC2222B
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoH3hX6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbgJONi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 09:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbgJONi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 09:38:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C4CC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:38:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t9so3485316wrq.11
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFGUeazmN8IA86N71XkqLUHEi7UNYWpGhbDRPTEdlpw=;
        b=OoH3hX6MyjEC4auChnDxyXoLTXGSFRZzd+EcoHw56sGk+ulrBgB2GlfLd/CsZ3HYhf
         jE8lQWHE0NbO7n7kau5cuxKI413K2j0oVzPLS8Q/ERZGKTJ0fKJ+gprpuvi+VWGG5fwM
         cCmxxjDBQvtTtPjOOERegxkrTRrC4uc5vfvbgZCnlsly7UMvIik2ZEVWvAk8sseFvphj
         G7E6QPRDa+qPS0PQd4GIsMDzUCtVFTd7I95rF2hczUG+iKcOsBiQ8NdGy9Sw5BMZXcz9
         3m8hGSZflVM5ugIHJE1iNvnp83A3TW7HfMqsb3q2DXq5ckQkpqEvtKRl2gAw/4e9fC2h
         363g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFGUeazmN8IA86N71XkqLUHEi7UNYWpGhbDRPTEdlpw=;
        b=M9CsjPD4R+eHUZVgOPv7ef+RIkRGumXzhEj4KrIGnGBr3OidDdWhIqxFbkQ6HW7RLa
         Gh0vE4zGZ2b5qvculYOje5ub1iUehEfW983857xA0Ro9LVLnTNe+ZXeankvNVrVPnHpN
         XN6nV+pOP6asj2BPeWRkGcz/VPJSMQDQJKJS2fyvrLJyZMjVA8XpieyovAYtpKU9JxeX
         YjCDj5mmGnUa0vUjEJ0aR7dLOh5IP6stQBE29z+6mT4g+mwmRwfee5Pf7fHJTUGgoGC5
         C6i7o877jYcON6ddBqR0Pq44tKhOJAB95gG/IKreLl/HLtpGk8g5KF4CyFSuMvEQe+MG
         9zwg==
X-Gm-Message-State: AOAM5308u8Wj49es8OwSVnOkCm1EABUbmgRYNfmyAzfb0N+TiUZQYZ4M
        87my8SOBBJ/mW3dVyZSXDTNDpkYeW0Y=
X-Google-Smtp-Source: ABdhPJykqdakcBPkyqzCqWnDuxamva261mzqA5PJ8yOtVVb4Vbq+tVxNGt5AhPU8q6psZN1qaRzLZA==
X-Received: by 2002:adf:f7d1:: with SMTP id a17mr4458430wrq.396.1602769135012;
        Thu, 15 Oct 2020 06:38:55 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id o4sm4709434wrv.8.2020.10.15.06.38.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:38:54 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v11 1/7] bisect--helper: finish porting `bisect_start()` to C
Date:   Thu, 15 Oct 2020 15:38:32 +0200
Message-Id: <20201015133838.85524-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201015133838.85524-1-mirucam@gmail.com>
References: <20201015133838.85524-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Add the subcommand to `git bisect--helper` and call it from
git-bisect.sh.

With the conversion of `bisect_auto_next()` from shell to C in a
previous commit, `bisect_start()` can now be fully ported to C.

So let's complete the `--bisect-start` subcommand of
`git bisect--helper` so that it fully implements `bisect_start()`,
and let's use this subcommand in `git-bisect.sh` instead of
`bisect_start()`.

Note that the `eval` in the changed line of `git-bisect.sh` cannot be
dropped: it is necessary because the `rev` and the `tail`
variables may contain multiple, quoted arguments that need to be
passed to `bisect--helper` (without the quotes, naturally).

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 41 ++++++++++++++++++++++++++--------------
 git-bisect.sh            | 26 ++-----------------------
 2 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7512b880f0..8adad68268 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -85,6 +85,19 @@ static int one_of(const char *term, ...)
 	return res;
 }
 
+/*
+ * return code BISECT_INTERNAL_SUCCESS_MERGE_BASE
+ * and BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND are codes
+ * that indicate special success.
+ */
+
+static int is_bisect_success(enum bisect_error res)
+{
+	return !res ||
+		res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND ||
+		res == BISECT_INTERNAL_SUCCESS_MERGE_BASE;
+}
+
 static int write_in_file(const char *path, const char *mode, const char *format, va_list args)
 {
 	FILE *fp = NULL;
@@ -609,12 +622,13 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char
 	return bisect_next(terms, prefix);
 }
 
-static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
+static enum bisect_error bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 {
 	int no_checkout = 0;
 	int first_parent_only = 0;
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
-	int flags, pathspec_pos, res = 0;
+	int flags, pathspec_pos;
+	enum bisect_error res = BISECT_OK;
 	struct string_list revs = STRING_LIST_INIT_DUP;
 	struct string_list states = STRING_LIST_INIT_DUP;
 	struct strbuf start_head = STRBUF_INIT;
@@ -753,14 +767,7 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 	 * Get rid of any old bisect state.
 	 */
 	if (bisect_clean_state())
-		return -1;
-
-	/*
-	 * In case of mistaken revs or checkout error, or signals received,
-	 * "bisect_auto_next" below may exit or misbehave.
-	 * We have to trap this to be able to clean up using
-	 * "bisect_clean_state".
-	 */
+		return BISECT_FAILED;
 
 	/*
 	 * Write new start state
@@ -777,7 +784,7 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 		}
 		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
 			       UPDATE_REFS_MSG_ON_ERR)) {
-			res = -1;
+			res = BISECT_FAILED;
 			goto finish;
 		}
 	}
@@ -789,25 +796,31 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 	for (i = 0; i < states.nr; i++)
 		if (bisect_write(states.items[i].string,
 				 revs.items[i].string, terms, 1)) {
-			res = -1;
+			res = BISECT_FAILED;
 			goto finish;
 		}
 
 	if (must_write_terms && write_terms(terms->term_bad,
 					    terms->term_good)) {
-		res = -1;
+		res = BISECT_FAILED;
 		goto finish;
 	}
 
 	res = bisect_append_log_quoted(argv);
 	if (res)
-		res = -1;
+		res = BISECT_FAILED;
 
 finish:
 	string_list_clear(&revs, 0);
 	string_list_clear(&states, 0);
 	strbuf_release(&start_head);
 	strbuf_release(&bisect_names);
+	if (res)
+		return res;
+
+	res = bisect_auto_next(terms, NULL);
+	if (!is_bisect_success(res))
+		bisect_clean_state();
 	return res;
 }
 
diff --git a/git-bisect.sh b/git-bisect.sh
index ea7e684ebb..dda386bc3a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -49,27 +49,6 @@ bisect_head()
 	fi
 }
 
-bisect_start() {
-	git bisect--helper --bisect-start $@ || exit
-
-	#
-	# Change state.
-	# In case of mistaken revs or checkout error, or signals received,
-	# "bisect_auto_next" below may exit or misbehave.
-	# We have to trap this to be able to clean up using
-	# "bisect_clean_state".
-	#
-	trap 'git bisect--helper --bisect-clean-state' 0
-	trap 'exit 255' 1 2 3 15
-
-	#
-	# Check if we can proceed to the next bisect state.
-	#
-	git bisect--helper --bisect-auto-next || exit
-
-	trap '-' 0
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -163,8 +142,7 @@ bisect_replay () {
 		get_terms
 		case "$command" in
 		start)
-			cmd="bisect_start $rev $tail"
-			eval "$cmd" ;;
+			eval "git bisect--helper --bisect-start $rev $tail" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
@@ -264,7 +242,7 @@ case "$#" in
 	help)
 		git bisect -h ;;
 	start)
-		bisect_start "$@" ;;
+		git bisect--helper --bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
 		bisect_state "$cmd" "$@" ;;
 	skip)
-- 
2.25.0

