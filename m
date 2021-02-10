Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB49EC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1AD64E42
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhBJLnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhBJLk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:40:29 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2A1C0617A9
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:43 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c11so1074301pfp.10
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQ4uj3P+eSGYTxlxQLGxF+O8ESGuLu2Ut9am5347RXk=;
        b=M1uDcVaov0U42vs5AZxlLyiqqYYuNvm5K+n211ZpbQQv6Nw4L0Ow1zJZ9Gv1QqNcsu
         NM5Hyfg/XLff8Z0rY0OfQUoqKa9VbbDwCZKygkCE4M3AGbTypTDTgLmyKdTVzW4z2Wx2
         CK1URVVBS48XMtm2ZxXXzYtf8bW0pWH6w50Cb7eZaWj+Ae4T7YpC2FMnWJrtS6qj/ws8
         rw+mp5syGPzDdj9vvDkQmNsS1ya/PTZPWvhJZ0MSr1VsXlopIW2bKDSx7fmoMWP078n5
         5w2pFFirWiHH2IHTLuiP8j2gwqPtJsTb/hT4PqH1aYkfFD0oJ8/ivo/je5Cj8lIIIBj6
         FRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQ4uj3P+eSGYTxlxQLGxF+O8ESGuLu2Ut9am5347RXk=;
        b=UQBhDO5YO0p9LXf4W/e7FJeizX+ncHvsbmoXItzdRxRZayyLCCzsnW8uporjUGsYlP
         L3Y2yFs2odwIH424/ajbS3o0hCiWYjdSp50qEqmpuIvohdO7AEKP+AYvEGrBJSLBkDre
         Lq1O14hX60aTdz029iiDqgVN9HAT+J49JUb3K0gv9fkUEOEG0AXzpN5d5X3JwuVZARbG
         c0Yxpo93xDO6DjaSBTwj1bmC0q5xspwkPTEKvqN6QW3vWzZwjNbuDG0f7zfrp7hH8yvX
         rvi9KRNloLgp+24mYMlSP8XsuGVfSB1b1tL9T7OY9OnDomyeGG35ZPuipujUVvIH0UWS
         5OoA==
X-Gm-Message-State: AOAM532+WLJnjIwOgLgpoWCqF7T6Gs37U7RrHsL5m51+4c6HAevbbLXO
        GR1yv2B6cjDooOcLtM24JYd6Tw027YNYKA==
X-Google-Smtp-Source: ABdhPJwXzdMjPhdtbvy3H9PcJR9B1sREj4Fhmm/GhmTbFIOV2s10HSb72Az7QdlwH33QED1z32kRfA==
X-Received: by 2002:a63:d20d:: with SMTP id a13mr2594087pgg.357.1612957123199;
        Wed, 10 Feb 2021 03:38:43 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:38:42 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 08/11] t/t3437: simplify and document the test helpers
Date:   Wed, 10 Feb 2021 17:06:48 +0530
Message-Id: <20210210113650.19715-9-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's simplify the test_commit_message() helper function and add
comments to the function.

This patch also document the working of 'fixup -C' with "amend!" in the
test-description.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 505211a589..6b464989e9 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -9,7 +9,9 @@ This test checks the "fixup [-C|-c]" command of rebase interactive.
 In addition to amending the contents of the commit, "fixup -C"
 replaces the original commit message with the message of the fixup
 commit. "fixup -c" also replaces the original message, but opens the
-editor to allow the user to edit the message before committing.
+editor to allow the user to edit the message before committing. Similar
+to the "fixup" command that works with "fixup!", "fixup -C" works with
+"amend!" upon --autosquash.
 '
 
 . ./test-lib.sh
@@ -18,17 +20,19 @@ editor to allow the user to edit the message before committing.
 
 EMPTY=""
 
+# test_commit_message <rev> -m <msg>
+# test_commit_message <rev> <path>
+# Verify that the commit message of <rev> matches
+# <msg> or the content of <path>.
 test_commit_message () {
-	rev="$1" && # commit or tag we want to test
-	file="$2" && # test against the content of a file
-	git show --no-patch --pretty=format:%B "$rev" >actual-message &&
-	if test "$2" = -m
-	then
-		str="$3" && # test against a string
-		printf "%s\n" "$str" >tmp-expected-message &&
-		file="tmp-expected-message"
-	fi
-	test_cmp "$file" actual-message
+	git show --no-patch --pretty=format:%B "$1" >actual &&
+	case "$2" in
+	-m)
+		echo "$3" >expect &&
+		test_cmp expect actual ;;
+	*)
+		test_cmp "$2" actual ;;
+	esac
 }
 
 get_author () {
-- 
2.29.0.rc1

