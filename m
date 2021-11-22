Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605A2C4332F
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 14:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbhKVOYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 09:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbhKVOYF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 09:24:05 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C0C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:20:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so9056881wmj.5
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LdW0rXJSsGpMHVFEoQSE2K69zFkANfrkuBMdPDlqoa8=;
        b=OxpWqSH4JMD9gBH3VBl0ViSV9Doaz1V8dVGw4DM5BCWU3UJ7OfnMViFOEUnGy9RMom
         RrBGzIDTAdpfFk2aw8Zz07SmIeidDTowcqzv0qd9Guh3ze+s3rjpeYdiLwDFAznJcy33
         XBcEsKplvvKQVZDQrYFJuoR1fjp9rXpQ2iKUg6lCF2t51/0u6BaCnEQsK94dYowZVS+x
         m/ZB0hGLRPUjq1z3HKsbPrJppsqAPjy3sKVyfon61ysoDq1QUp96vYOYrLRR1ozGzoce
         52P2T0JHO8S5Y59m/4Hg6k+qTdUB/ely/HsmQAZG6Iqg10f5Ov1S3Mf6R1zZ+UA/dhcR
         3BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LdW0rXJSsGpMHVFEoQSE2K69zFkANfrkuBMdPDlqoa8=;
        b=qGA1mUwOUhWl+p70f1qg7iWvoQjWby3/EksEzntaKWTFICuEW7QuDQcnRb0C9ippop
         WrrX5vrxJm7yBxafdgQkD6BEQ0EwGg0AxiHhnIo7USDNI4leVd43Folqjlh4Rbvn7muA
         bppBFsu3h5OOUFNP/aLjvlQ7UAqy9BbLwXA70I8p4BmdGUFBjyXVzy2iFdlIWpHeo9X6
         HdWVMZ2lOyV14eT6j+RrD462D0gsH4iFlNqRABbf0MZA1SYJboGIH9xVwabRzufQxiJ1
         QnvQd2QJSVBmvV4GOE+w7lRg0Cv9xWeBQx+WJ5VWiGDur/zMwnBfUqUqB7Nv9SR01eXy
         Xqag==
X-Gm-Message-State: AOAM532NrCemzv+St4EpRSamKvd90/jXuRjQNPsZ3Obz3NHSN0SDjntH
        BY3gz1v0JdceoIBqFwlvom3J92oBWDs=
X-Google-Smtp-Source: ABdhPJxWT1dlikMZgycP2oebrDdj6a1odl6fBbKX0O2cujq8MASLv4St9UBhBWql0a30Fb+28JZW6g==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr29864986wmc.176.1637590857611;
        Mon, 22 Nov 2021 06:20:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm26120507wmq.32.2021.11.22.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:20:57 -0800 (PST)
Message-Id: <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 14:20:53 +0000
Subject: [PATCH 2/4] refs: trim newline from reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Commit 523fa69c ("reflog: cleanse messages in the refs.c layer") standardizes
how write entries into the reflog. This commit standardizes how we get messages
out of the reflog. Before, the files backend implicitly added '\n' to the end of
reflog message on reading, which creates a subtle incompatibility with alternate
ref storage backends, such as reftable.

We address this by stripping LF from the message before we pass it to the
user-provided callback.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/show-branch.c          |  5 -----
 reflog-walk.c                  |  6 ++----
 refs/files-backend.c           | 30 +++++++++++++++---------------
 t/t1405-main-ref-store.sh      |  5 ++---
 t/t1406-submodule-ref-store.sh |  4 ++--
 5 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f1e8318592c..016ccdafd0f 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -761,7 +761,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			char *logmsg;
 			char *nth_desc;
 			const char *msg;
-			char *end;
 			timestamp_t timestamp;
 			int tz;
 
@@ -772,10 +771,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				break;
 			}
 
-			end = strchr(logmsg, '\n');
-			if (end)
-				*end = '\0';
-
 			msg = (*logmsg == '\0') ? "(none)" : logmsg;
 			reflog_msg[i] = xstrfmt("(%s) %s",
 						show_date(timestamp, tz,
diff --git a/reflog-walk.c b/reflog-walk.c
index 8ac4b284b6b..3ee59a98d2f 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -244,8 +244,6 @@ void get_reflog_message(struct strbuf *sb,
 
 	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 	len = strlen(info->message);
-	if (len > 0)
-		len--; /* strip away trailing newline */
 	strbuf_add(sb, info->message, len);
 }
 
@@ -284,10 +282,10 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
 		if (oneline) {
-			printf("%s: %s", selector.buf, info->message);
+			printf("%s: %s\n", selector.buf, info->message);
 		}
 		else {
-			printf("Reflog: %s (%s)\nReflog message: %s",
+			printf("Reflog: %s (%s)\nReflog message: %s\n",
 			       selector.buf, info->email, info->message);
 		}
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 151b0056fe5..583bbc5f8b9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1936,17 +1936,15 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 	int tz;
 	const char *p = sb->buf;
 
-	/* old SP new SP name <email> SP time TAB msg LF */
-	if (!sb->len || sb->buf[sb->len - 1] != '\n' ||
-	    parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
+	/* old SP new SP name <email> SP time TAB msg */
+	if (!sb->len || parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
 	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
-	    !(email_end = strchr(p, '>')) ||
-	    email_end[1] != ' ' ||
+	    !(email_end = strchr(p, '>')) || email_end[1] != ' ' ||
 	    !(timestamp = parse_timestamp(email_end + 2, &message, 10)) ||
 	    !message || message[0] != ' ' ||
-	    (message[1] != '+' && message[1] != '-') ||
-	    !isdigit(message[2]) || !isdigit(message[3]) ||
-	    !isdigit(message[4]) || !isdigit(message[5]))
+	    (message[1] != '+' && message[1] != '-') || !isdigit(message[2]) ||
+	    !isdigit(message[3]) || !isdigit(message[4]) ||
+	    !isdigit(message[5]))
 		return 0; /* corrupt? */
 	email_end[1] = '\0';
 	tz = strtol(message + 1, NULL, 10);
@@ -2038,6 +2036,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
 				scanp = bp;
 				endp = bp + 1;
+				strbuf_trim_trailing_newline(&sb);
 				ret = show_one_reflog_ent(&sb, fn, cb_data);
 				strbuf_reset(&sb);
 				if (ret)
@@ -2050,6 +2049,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 				 * Process it, and we can end the loop.
 				 */
 				strbuf_splice(&sb, 0, 0, buf, endp - buf);
+				strbuf_trim_trailing_newline(&sb);
 				ret = show_one_reflog_ent(&sb, fn, cb_data);
 				strbuf_reset(&sb);
 				break;
@@ -2099,7 +2099,7 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 	if (!logfp)
 		return -1;
 
-	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
+	while (!ret && !strbuf_getline(&sb, logfp))
 		ret = show_one_reflog_ent(&sb, fn, cb_data);
 	fclose(logfp);
 	strbuf_release(&sb);
@@ -3059,18 +3059,18 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
 				   message, policy_cb)) {
 		if (!cb->newlog)
-			printf("would prune %s", message);
+			printf("would prune %s\n", message);
 		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-			printf("prune %s", message);
+			printf("prune %s\n", message);
 	} else {
 		if (cb->newlog) {
-			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
-				oid_to_hex(ooid), oid_to_hex(noid),
-				email, timestamp, tz, message);
+			fprintf(cb->newlog, "%s %s %s %" PRItime " %+05d\t%s\n",
+				oid_to_hex(ooid), oid_to_hex(noid), email,
+				timestamp, tz, message);
 			oidcpy(&cb->last_kept_oid, noid);
 		}
 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-			printf("keep %s", message);
+			printf("keep %s\n", message);
 	}
 	return 0;
 }
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 49718b7ea7f..a600bedf2cd 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -89,13 +89,12 @@ test_expect_success 'for_each_reflog()' '
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep one &&
-	tail -n2 actual | head -n1 | grep recreate-main
+	tail -n1 actual | grep recreate-main
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
-	head -n1 actual | grep recreate-main &&
-	tail -n2 actual | head -n1 | grep one
+	tail -n1 actual | grep one
 '
 
 test_expect_success 'reflog_exists(HEAD)' '
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 0a87058971e..b0365c1fee0 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -74,13 +74,13 @@ test_expect_success 'for_each_reflog()' '
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep first &&
-	tail -n2 actual | head -n1 | grep main.to.new
+	tail -n1 actual | grep main.to.new
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
 	head -n1 actual | grep main.to.new &&
-	tail -n2 actual | head -n1 | grep first
+	tail -n1 actual | grep first
 '
 
 test_expect_success 'reflog_exists(HEAD)' '
-- 
gitgitgadget

