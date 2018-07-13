Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A79F1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 00:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbeGMAPJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 20:15:09 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:49397 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbeGMAPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 20:15:09 -0400
Received: by mail-qt0-f201.google.com with SMTP id b8-v6so28774864qto.16
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 17:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=uwh6dciTOvgfrAvjB6C2TRK7vAStPdWIuZhsgzHxSWs=;
        b=uxncTylK7AJ34hf9ynq6NDjvIkqQTHlHEUjRFyD7vQxH6bBcoezR0U2Wy6TCslB42H
         jrpL7wtE6BWbSp7Q7IuqcVYMr8lAHhCMV8gPekPaF5NJ/DMeWmEpBQq5Uyhcf/gbaU3f
         1931TY8hlv7g461CZ5tute6r8quFwEwxdtkaNED0U0g0YV5gO+CbVX7wUyhr4vxI0OTw
         t471WFCNPkIV96nTNQHySWJvlBo70J7C7xXIdXMHJAC7Z/NdXzvELv5lxGzas6yB7za8
         /cYhy1QlHUFD1QwnJ9FZFi4i9K49jJyfewj+QSM3vpNpbcDOZqEjcBn5GbLAJpj3qnv9
         VQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=uwh6dciTOvgfrAvjB6C2TRK7vAStPdWIuZhsgzHxSWs=;
        b=OG5eMzubhi/dlVL0oEbJ617+JzGwpmaAJaj1Ul77sJ7UsZwq4M3vaIqJsm/yOzcvVS
         1WuvxB4whMOPNTrxiMJVjXFfRsXbKdB1XWW1VNErUduEUGqS1VkhiNET6mFb2y17bsey
         sFg8eH74tm9WDN3gPkWwLeXwUSlteaZz2hQkhsORNO5dDP7jMmEU7ZumWV3SeBRfomu+
         9Y6yGW4jaGLoIjN3JMcrqpKWiZ+8R/46R/JJb29Q3T6YcTltp8IlUnecKvUbjRhWUa2U
         Bfqg/D19hyJXZQZoqFuhEOcOfluhjLOh6JkK/xvOIKxmWrtJU+Imxn2hXMlrsp4HwiAa
         hqXw==
X-Gm-Message-State: AOUpUlEusft6ZvPrFXSDppPMZZC/UYuQjRaayfYUV8Q111AMGneThezA
        b2GdXbh+b88JNOpf5yQq8hwDjHbTkxnRspVzYoXkgByw7mQDGDSg4XgxInuEJknPO9pkzULJacC
        VKkU7aZQccTwY9NZfDo5GjNlkbdEh1c2LJ54lM7juHgcH8Ool5c5aXcy6GSJvzCLelncX4TbVYa
        0Y
X-Google-Smtp-Source: AAOMgpdLYY1U9q4BHyS6JMSjVosRLp8RNGDwKew+rZlHCAWvqdhzJjtXmZSbQ4cfOEwPrgMivA/DnAhS6l11bXPvxA/+
MIME-Version: 1.0
X-Received: by 2002:a0c:d2da:: with SMTP id x26-v6mr2731678qvh.36.1531440192508;
 Thu, 12 Jul 2018 17:03:12 -0700 (PDT)
Date:   Thu, 12 Jul 2018 17:03:06 -0700
In-Reply-To: <cover.1531438861.git.jonathantanmy@google.com>
Message-Id: <f010da153f228b59c47deb4b1005df3e0e2255a1.1531438861.git.jonathantanmy@google.com>
References: <cover.1531438861.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 1/2] revision: tolerate promised targets of tags
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In handle_commit(), it is fatal for an annotated tag to point to a
non-existent object. --exclude-promisor-objects should relax this rule
and allow non-existent objects that are promisor objects, but this is
not the case. Update handle_commit() to tolerate this situation.

This was observed when cloning from a repository with an annotated tag
pointing to a blob. The test included in this patch demonstrates this
case.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
---
 revision.c               |  3 +++
 t/t5616-partial-clone.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/revision.c b/revision.c
index 1b37da988..95546e6d4 100644
--- a/revision.c
+++ b/revision.c
@@ -248,6 +248,9 @@ static struct commit *handle_commit(struct rev_info *revs,
 		if (!object) {
 			if (revs->ignore_missing_links || (flags & UNINTERESTING))
 				return NULL;
+			if (revs->exclude_promisor_objects &&
+			    is_promisor_object(&tag->tagged->oid))
+				return NULL;
 			die("bad object %s", oid_to_hex(&tag->tagged->oid));
 		}
 		object->flags |= flags;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 44d8e8017..e8dfeafe7 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -216,6 +216,45 @@ test_expect_success 'upon cloning, check that all refs point to objects' '
 	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
 '
 
+test_expect_success 'when partial cloning, tolerate server not sending target of tag' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	rm -rf "$SERVER" repo &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" foo &&
+	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
+	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
+
+	# Create an annotated tag pointing to a blob.
+	BLOB=$(echo blob-contents | git -C "$SERVER" hash-object --stdin -w) &&
+	git -C "$SERVER" tag -m message -a myblob "$BLOB" &&
+
+	# Craft a packfile including the tag, but not the blob it points to.
+	printf "%s\n%s\n--not\n%s\n" \
+		$(git -C "$SERVER" rev-parse HEAD) \
+		$(git -C "$SERVER" rev-parse myblob) \
+		$(git -C "$SERVER" rev-parse myblob^{blob}) |
+		git -C "$SERVER" pack-objects --thin --stdout >incomplete.pack &&
+
+	# Replace the existing packfile with the crafted one. The protocol
+	# requires that the packfile be sent in sideband 1, hence the extra
+	# \x01 byte at the beginning.
+	printf "1,/packfile/!c %04x\\\\x01%s0000" \
+		"$(($(wc -c <incomplete.pack) + 5))" \
+		"$(sed_escape <incomplete.pack)" \
+		>"$HTTPD_ROOT_PATH/one-time-sed" &&
+
+	# Use protocol v2 because the sed command looks for the "packfile"
+	# section header.
+	test_config -C "$SERVER" protocol.version 2 &&
+
+	# Exercise to make sure it works.
+	git -c protocol.version=2 clone \
+		--filter=blob:none $HTTPD_URL/one_time_sed/server repo &&
+
+	# Ensure that the one-time-sed script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
+'
+
 stop_httpd
 
 test_done
-- 
2.18.0.203.gfac676dfb9-goog

