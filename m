Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D7EB20248
	for <e@80x24.org>; Sun, 31 Mar 2019 13:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfCaNrd (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 09:47:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43998 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfCaNrc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 09:47:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so8393766wrx.10
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YuF7poVuZpGgkVepodOt8kdUjGgzM3PxHwrOPrmsA9A=;
        b=rQBoXoo1BovO0lHKVHLDBB641yTRf1SBOfxc7FYDFkaqyhCn/hmn6z8XHLPJSabX3H
         hoqtZOMN/MRBvvRJE2QzRTCS78baq9u8pdCmiuTVSELnDgEK9EATtMS3g8qA3xt5R7cy
         wyrWlZWmZO/u7oeUTQuLulEZcJPrk1+FEqi5Vf+RcAZtwuOoSP+o+eH6SWSxcZxxdVRp
         X56n5zLF914vzlCQVU07f/ifEPvgrSKmaiKFWVrKTFsTj5zB4FgRyRr3eFqnTUFxk79x
         Jr50vs08WeJWN+fRQNR88+eeyuZetDJWDblvqhuNMW6AG4ogAPK2sb/vR/CRckjDZEK2
         UzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YuF7poVuZpGgkVepodOt8kdUjGgzM3PxHwrOPrmsA9A=;
        b=mDrsQelhwVFXYmc1Ub6eej2GTDBex0SrEhCfn9CTV1P3Kxmi+W5OS8I7HAt0QG94zv
         iUrRVAnEL/h/Xowz6cD+nfH7iA9jH483BUnzHjMU8tbYPR7wUZSFrD6vsm3B3axPF+eM
         cUOzJbLQByKTarBhj3LiCTLnRlaTk0neeqx9ksj7uC78OQvthnffPQFaM+O9tNpj+eko
         nO7CpfAY1qVVVNCXAPh0qByxL4jZ294YT/Cufy2wyO+v/2ivmKXW2+2bh3IdYRd+w1TI
         26X1lNIJweEJHWkG1p94tDOxP1PcxiK80IEsGKHXkf4CnaythlGL4S1AegLT80+WznNE
         ALIg==
X-Gm-Message-State: APjAAAVCDYR/lhBwxHNi9OSVH1ZacqTVZK76EGZYM9Mk+e9cqmbejXRc
        Q7PLj26lM27qN+cwi6Q2ZhiN8g0L
X-Google-Smtp-Source: APXvYqzKQWMcsuXbN/3/Wa17w+x2RSKvZR+Z/bzeX49PD7HSteGggdV97aj6kpBolFks1YDF/Bfh7g==
X-Received: by 2002:adf:c788:: with SMTP id l8mr28441106wrg.143.1554040050669;
        Sun, 31 Mar 2019 06:47:30 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10ce:4d96:49c5:28f4:744c:fa99])
        by smtp.gmail.com with ESMTPSA id o10sm10290490wru.54.2019.03.31.06.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 06:47:30 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/4] replace: fix --graft when passing a tag first
Date:   Sun, 31 Mar 2019 15:46:59 +0200
Message-Id: <20190331134659.28808-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.69.g2d86a08d09
In-Reply-To: <20190331134659.28808-1-chriscool@tuxfamily.org>
References: <20190331134659.28808-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When passing a tag as the first argument to `git replace --graft`,
it can be useful to accept it and use the underlying commit as a
the commit that will be replaced.

This already works for lightweight tags, but unfortunately
for annotated tags we have been using the hash of the tag object
instead of the hash of the underlying commit.

Especially we would pass the hash of the tag object to
replace_object_oid() where we would likely fail with an error
like:

"error: Objects must be of the same type.
'annotated_replaced_object' points to a replaced object of type 'tag'
while 'replacement' points to a replacement object of type 'commit'."

This patch fixes that by using the hash of the underlying commit
when an annotated tag is passed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c  | 11 +++++++----
 t/t6050-replace.sh | 11 +++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b0a9227f9a..644b21ca8d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -481,15 +481,18 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 
 	strbuf_release(&buf);
 
-	if (oideq(&old_oid, &new_oid)) {
+	if (oideq(&commit->object.oid, &new_oid)) {
 		if (gentle) {
-			warning(_("graft for '%s' unnecessary"), oid_to_hex(&old_oid));
+			warning(_("graft for '%s' unnecessary"),
+				oid_to_hex(&commit->object.oid));
 			return 0;
 		}
-		return error(_("new commit is the same as the old one: '%s'"), oid_to_hex(&old_oid));
+		return error(_("new commit is the same as the old one: '%s'"),
+			     oid_to_hex(&commit->object.oid));
 	}
 
-	return replace_object_oid(old_ref, &old_oid, "replacement", &new_oid, force);
+	return replace_object_oid(old_ref, &commit->object.oid,
+				  "replacement", &new_oid, force);
 }
 
 static int convert_graft_file(int force)
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 2385a60f68..e7e64e085d 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -417,6 +417,17 @@ test_expect_success '--graft using a tag as the new parent' '
 	git replace -d $HASH7
 '
 
+test_expect_success '--graft using a tag as the replaced object' '
+	git tag replaced_object $HASH7 &&
+	git replace --graft replaced_object $HASH5 &&
+	commit_has_parents $HASH7 $HASH5 &&
+	git replace -d $HASH7 &&
+	git tag -a -m "annotated replaced object tag" annotated_replaced_object $HASH7 &&
+	git replace --graft annotated_replaced_object $HASH5 &&
+	commit_has_parents $HASH7 $HASH5 &&
+	git replace -d $HASH7
+'
+
 test_expect_success GPG 'set up a signed commit' '
 	echo "line 17" >>hello &&
 	echo "line 18" >>hello &&
-- 
2.21.0.69.g2d86a08d09

