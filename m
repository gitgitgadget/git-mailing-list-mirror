Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA692022A
	for <e@80x24.org>; Wed,  2 Nov 2016 17:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756635AbcKBR3j (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 13:29:39 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33237 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756628AbcKBR3h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 13:29:37 -0400
Received: by mail-pf0-f172.google.com with SMTP id d2so15407947pfd.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GQsCjt2emN0+q6ekFq7jhb53s9BtRFWh3ipWnUpm0CM=;
        b=oX18e8BdvBM/AUQr5iJZkob9esSS1xlOQj6vvkvO2aNXskRdTBWaUHTa3ImabTMziw
         /RXxZ7tXpBx6Lhu8FvUXP9WmmL5pFXVgzaXIL8LdWM4C+Me9/XDEQjRifOr7AT/NxlUs
         oSSWzKu6b3zUARVXAhStKMF5JP41tMQIocmOkgFE9UwjSiOLgkW2SPOOTOstyUHY/7d7
         LRV4jEFkMsNJVfrau0t9S+eprSoNw9xh7qTzSAZRh2pCfQXxD4FCgCov/WNN/nRs65Ie
         DuwG9gj7QuLU7GIdEK4j+/5edDB2NHn5kSxpsd2NlWk9EjdNElooFJ2VOKQvh1/v5f0b
         lBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GQsCjt2emN0+q6ekFq7jhb53s9BtRFWh3ipWnUpm0CM=;
        b=aqvHFfyDcIU/j3xjjXSt03TRYTb4zB0SkXaKkXjFJoPhztiZHpxOzn01We7psBn4m7
         ErgJQyZbZnRqAa3nDDIgFXzPL64BfMksnScX2ySzeGmx4tKmxXmi8uOtpqIB/JJ0u/fY
         HoT3NahC9/Aqxv6C+AzwxHm5mOMQS3ymtr/IUU0PWUi0uHnYLSEw3slSWS7Os1DA1xbi
         e9cV4Bkh8XYRvFHHEvnHv3FL6LBAScKj3G1Vs4mox4SDA0Kj3LjbqCtY0I5YjCifZBTF
         CMVsLjeX/iflDR8zCp9GNHBdyPF5kiULE3h5FeSkabFzjBkQ7YhPhrc8hChfF3Ce2ckq
         dktQ==
X-Gm-Message-State: ABUngvd7oRi5PesEH7AZiVhHUdDb4rPQEUH4zg4KFA0xiyrd1RasdQQpbkFvMPYquz89gQyn
X-Received: by 10.99.209.5 with SMTP id k5mr7375078pgg.13.1478107776474;
        Wed, 02 Nov 2016 10:29:36 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id f23sm6185167pff.59.2016.11.02.10.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 10:29:35 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 5/5] sequencer: use trailer's trailer layout
Date:   Wed,  2 Nov 2016 10:29:20 -0700
Message-Id: <092b31de2aef3f57aa36010d0d016b2d0937e243.1478107666.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1478107666.git.jonathantanmy@google.com>
References: <cover.1478107666.git.jonathantanmy@google.com>
In-Reply-To: <cover.1478107666.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com> <cover.1478107666.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make sequencer use trailer.c's trailer layout definition, as opposed to
parsing the footer by itself. This makes "commit -s", "cherry-pick -x",
and "format-patch --signoff" consistent with trailer, allowing
non-trailer lines and multiple-line trailers in trailer blocks under
certain conditions, and therefore suppressing the extra newline in those
cases.

Consistency with trailer extends to respecting trailer configs.  Tests
have been included to show that.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sequencer.c              | 75 +++++++++---------------------------------------
 t/t3511-cherry-pick-x.sh | 16 +++++++++--
 t/t4014-format-patch.sh  | 37 ++++++++++++++++++++----
 t/t7501-commit.sh        | 36 +++++++++++++++++++++++
 4 files changed, 95 insertions(+), 69 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5fd75f3..d64c973 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -16,6 +16,7 @@
 #include "refs.h"
 #include "argv-array.h"
 #include "quote.h"
+#include "trailer.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -56,30 +57,6 @@ static const char *get_todo_path(const struct replay_opts *opts)
 	return git_path_todo_file();
 }
 
-static int is_rfc2822_line(const char *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		int ch = buf[i];
-		if (ch == ':')
-			return 1;
-		if (!isalnum(ch) && ch != '-')
-			break;
-	}
-
-	return 0;
-}
-
-static int is_cherry_picked_from_line(const char *buf, int len)
-{
-	/*
-	 * We only care that it looks roughly like (cherry picked from ...)
-	 */
-	return len > strlen(cherry_picked_prefix) + 1 &&
-		starts_with(buf, cherry_picked_prefix) && buf[len - 1] == ')';
-}
-
 /*
  * Returns 0 for non-conforming footer
  * Returns 1 for conforming footer
@@ -89,49 +66,25 @@ static int is_cherry_picked_from_line(const char *buf, int len)
 static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	int ignore_footer)
 {
-	char prev;
-	int i, k;
-	int len = sb->len - ignore_footer;
-	const char *buf = sb->buf;
-	int found_sob = 0;
-
-	/* footer must end with newline */
-	if (!len || buf[len - 1] != '\n')
-		return 0;
+	struct trailer_info info;
+	int i;
+	int found_sob = 0, found_sob_last = 0;
 
-	prev = '\0';
-	for (i = len - 1; i > 0; i--) {
-		char ch = buf[i];
-		if (prev == '\n' && ch == '\n') /* paragraph break */
-			break;
-		prev = ch;
-	}
+	trailer_info_get(&info, sb->buf);
 
-	/* require at least one blank line */
-	if (prev != '\n' || buf[i] != '\n')
+	if (info.trailer_start == info.trailer_end)
 		return 0;
 
-	/* advance to start of last paragraph */
-	while (i < len - 1 && buf[i] == '\n')
-		i++;
-
-	for (; i < len; i = k) {
-		int found_rfc2822;
-
-		for (k = i; k < len && buf[k] != '\n'; k++)
-			; /* do nothing */
-		k++;
+	for (i = 0; i < info.trailer_nr; i++)
+		if (sob && !strncmp(info.trailers[i], sob->buf, sob->len)) {
+			found_sob = 1;
+			if (i == info.trailer_nr - 1)
+				found_sob_last = 1;
+		}
 
-		found_rfc2822 = is_rfc2822_line(buf + i, k - i - 1);
-		if (found_rfc2822 && sob &&
-		    !strncmp(buf + i, sob->buf, sob->len))
-			found_sob = k;
+	trailer_info_release(&info);
 
-		if (!(found_rfc2822 ||
-		      is_cherry_picked_from_line(buf + i, k - i - 1)))
-			return 0;
-	}
-	if (found_sob == i)
+	if (found_sob_last)
 		return 3;
 	if (found_sob)
 		return 2;
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 9cce5ae..bf0a5c9 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -25,9 +25,8 @@ Signed-off-by: B.U. Thor <buthor@example.com>"
 
 mesg_broken_footer="$mesg_no_footer
 
-The signed-off-by string should begin with the words Signed-off-by followed
-by a colon and space, and then the signers name and email address. e.g.
-Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+This is not recognized as a footer because Myfooter is not a recognized token.
+Myfooter: A.U. Thor <author@example.com>"
 
 mesg_with_footer_sob="$mesg_with_footer
 Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
@@ -112,6 +111,17 @@ test_expect_success 'cherry-pick -s inserts blank line after non-conforming foot
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -s recognizes trailer config' '
+	pristine_detach initial &&
+	git -c "trailer.Myfooter.ifexists=add" cherry-pick -s mesg-broken-footer &&
+	cat <<-EOF >expect &&
+		$mesg_broken_footer
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick -x inserts blank line when conforming footer not found' '
 	pristine_detach initial &&
 	sha1=$(git rev-parse mesg-no-footer^0) &&
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ba4902d..482112c 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1294,8 +1294,7 @@ EOF
 4:Subject: [PATCH] subject
 8:
 10:Signed-off-by: example happens to be wrapped here.
-11:
-12:Signed-off-by: C O Mitter <committer@example.com>
+11:Signed-off-by: C O Mitter <committer@example.com>
 EOF
 	test_cmp expected actual
 '
@@ -1368,7 +1367,7 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_success 'signoff: detect garbage in non-conforming footer' '
+test_expect_success 'signoff: tolerate garbage in conforming footer' '
 	append_signoff <<\EOF >actual &&
 subject
 
@@ -1383,8 +1382,36 @@ EOF
 8:
 10:
 13:Signed-off-by: C O Mitter <committer@example.com>
-14:
-15:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff: respect trailer config' '
+	append_signoff <<\EOF >actual &&
+subject
+
+Myfooter: x
+Some Trash
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+11:
+12:Signed-off-by: C O Mitter <committer@example.com>
+EOF
+	test_cmp expected actual &&
+
+	test_config trailer.Myfooter.ifexists add &&
+	append_signoff <<\EOF >actual &&
+subject
+
+Myfooter: x
+Some Trash
+EOF
+	cat >expected <<\EOF &&
+4:Subject: [PATCH] subject
+8:
+11:Signed-off-by: C O Mitter <committer@example.com>
 EOF
 	test_cmp expected actual
 '
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index d84897a..4003a27 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -460,6 +460,42 @@ $alt" &&
 	test_cmp expected actual
 '
 
+test_expect_success 'signoff respects trailer config' '
+
+	echo 5 >positive &&
+	git add positive &&
+	git commit -s -m "subject
+
+non-trailer line
+Myfooter: x" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	(
+		echo subject
+		echo
+		echo non-trailer line
+		echo Myfooter: x
+		echo
+		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+	) >expected &&
+	test_cmp expected actual &&
+
+	echo 6 >positive &&
+	git add positive &&
+	git -c "trailer.Myfooter.ifexists=add" commit -s -m "subject
+
+non-trailer line
+Myfooter: x" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	(
+		echo subject
+		echo
+		echo non-trailer line
+		echo Myfooter: x
+		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+	) >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&
-- 
2.8.0.rc3.226.g39d4020

