Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FABC4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA28420776
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXXdZ+lW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgCUQN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:13:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33673 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCUQN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 12:13:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so11235436wrd.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLzkw1A45ECqV1oE/u4ObEfiUhk3zfOSQEotwGzLmIg=;
        b=UXXdZ+lW5HKiUMza9jeQHy4K7XjhLn4/1CSaBYbUsrmc1b/JgzY10IL/SWg6HbZb7T
         3FfhpRgmRUFaLrLd7lpi4piMwR8c4oh+7CIyBqCFmjwxNfjXHZLUQaYZE/fX4NWtVe9O
         wbG2WJu3uzM4wv7iPd6aMcWtbNtmu5piDyPp4hz6QoO9c6aawDMyk6by7N7R/wStB4Bb
         JTCxDKk/ATgxo9jXxL+z7hv1VYmh7spDv2p2zZh037uH8FeuI3EbQS48FT3rVY3LWB4b
         64X29RVXIBJHAfY+8wQpzCQO1TpRKqO8QiPkqOFW+7b3rUxhXablT8svrlt/oFNnjjJY
         GGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLzkw1A45ECqV1oE/u4ObEfiUhk3zfOSQEotwGzLmIg=;
        b=qYax5JAW1+90QsnYPSAjnoh6gJB98a+vd4aRtWGWJdZ2XVcKloUBrvtK2R3C4ZY1Kf
         BDurVpM9I/zSE2h3kZrLbACM6NbKLMz29xG3MLTloNG8C0brqJkSpBVS1aDHdU23Zb3a
         g3CHUHNt+qX3Gro69s3QudbHLNfnX6AjGM7AF0Rz+Z+1qiCWw+PFDgbM/NRIvEzCEIek
         2SDOQZ4sXcnFWCZCkVOg0E/qe2/XQBwc8o6M8+LxezIS3fHCbHEAXPiVG++Db59Zdvi/
         B+GMHMIt13UO6BZw36BedtLJ5ST3rZKURh2VPlajMGxKyHa1pZwXI/OYECVmIJaTEUNv
         yHiQ==
X-Gm-Message-State: ANhLgQ2PfXG6iabep3dYkBQu5Z2kGLPGDw6LVOLsSp0adYE4eDvunK+F
        HrlwkIYIjBMw4YTz0zUfsVMJUok+
X-Google-Smtp-Source: ADFU+vvXtmFVuNz9dCsA8baP6LAlDBSHOKu8Qk8obWfMi+QCEoY2MQMEo9ahJy70l6wohRz6hnfaSw==
X-Received: by 2002:adf:c648:: with SMTP id u8mr18740626wrg.185.1584807233521;
        Sat, 21 Mar 2020 09:13:53 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id f22sm13992285wmf.2.2020.03.21.09.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 09:13:53 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 04/11] bisect--helper: finish porting `bisect_start()` to C
Date:   Sat, 21 Mar 2020 17:10:13 +0100
Message-Id: <20200321161020.22817-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200321161020.22817-1-mirucam@gmail.com>
References: <20200321161020.22817-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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

This removes the signal handling we had in `bisect_start()` as we
don't really need it. While at it, "trap" is changed to "handle".
As "trap" is a reference to the shell "trap" builtin, which isn't
used anymore.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 54 +++++++++++++++++++++++++++++++---------
 git-bisect.sh            | 28 +++------------------
 2 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 447e9e75db..84aac08ced 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -582,11 +582,12 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char
 	return bisect_next(terms, prefix);
 }
 
-static int bisect_start(struct bisect_terms *terms, int no_checkout,
+static enum bisect_error bisect_start(struct bisect_terms *terms, int no_checkout,
 			const char **argv, int argc)
 {
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
-	int flags, pathspec_pos, res = 0;
+	int flags, pathspec_pos;
+	enum bisect_error res = BISECT_OK;
 	struct string_list revs = STRING_LIST_INIT_DUP;
 	struct string_list states = STRING_LIST_INIT_DUP;
 	struct strbuf start_head = STRBUF_INIT;
@@ -639,9 +640,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			return error(_("unrecognized option: '%s'"), arg);
 		} else {
 			char *commit_id = xstrfmt("%s^{commit}", arg);
-			if (get_oid(commit_id, &oid) && has_double_dash)
-				die(_("'%s' does not appear to be a valid "
-				      "revision"), arg);
+			if (get_oid(commit_id, &oid) && has_double_dash) {
+				error(_("'%s' does not appear to be a valid "
+					"revision"), arg);
+				free(commit_id);
+				return BISECT_FAILED;
+			}
 
 			string_list_append(&revs, oid_to_hex(&oid));
 			free(commit_id);
@@ -719,12 +723,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	 * Get rid of any old bisect state.
 	 */
 	if (bisect_clean_state())
-		return -1;
+		return BISECT_FAILED;
 
 	/*
-	 * In case of mistaken revs or checkout error, or signals received,
+	 * In case of mistaken revs or checkout error,
 	 * "bisect_auto_next" below may exit or misbehave.
-	 * We have to trap this to be able to clean up using
+	 * We have to handle this to be able to clean up using
 	 * "bisect_clean_state".
 	 */
 
@@ -740,7 +744,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		}
 		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
 			       UPDATE_REFS_MSG_ON_ERR)) {
-			res = -1;
+			res = BISECT_FAILED;
 			goto finish;
 		}
 	}
@@ -752,25 +756,51 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
+	/*
+	 * In case of mistaken revs or checkout error, or signals received,
+	 * "bisect_auto_next" below may exit or misbehave.
+	 * We have to handle this to be able to clean up using
+	 * "bisect_clean_state".
+	 * return code BISECT_INTERNAL_SUCCESS_MERGE_BASE is special code
+	 * that indicates special success.
+	 *	-> bisect_start()
+	 *	   . res = bisect_auto_next()
+	 *	    -> bisect_auto_next()
+	 *	       . return bisect_next()
+	 *	       -> bisect_next()
+	 *		  . res = bisect_next_all()
+	 *		  -> bisect_next_all()
+	 *		     . res = check_good_are_ancestors_of_bad()
+	 *		     -> check_good_are_ancestors_of_bad()
+	 *			. res = check_merge_bases()
+	 *			-> check_merge_bases()
+	 *			   . res = BISECT_INTERNAL_SUCCESS_MERGE_BASE
+	 */
+	if (res && res != BISECT_INTERNAL_SUCCESS_MERGE_BASE)
+		bisect_clean_state();
 	return res;
 }
 
diff --git a/git-bisect.sh b/git-bisect.sh
index e03f210d55..166f6a64dd 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -63,34 +63,13 @@ bisect_autostart() {
 			[Nn]*)
 				exit ;;
 			esac
-			bisect_start
+			git bisect--helper --bisect-start
 		else
 			exit 1
 		fi
 	}
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
@@ -183,8 +162,7 @@ bisect_replay () {
 		get_terms
 		case "$command" in
 		start)
-			cmd="bisect_start $rev"
-			eval "$cmd" ;;
+			eval "git bisect--helper --bisect-start $rev" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
@@ -283,7 +261,7 @@ case "$#" in
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

