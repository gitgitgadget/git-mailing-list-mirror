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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B89FC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A2F613EE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhFXT01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhFXT00 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ABEC061756
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so6968202wms.1
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83v8P9S8ZAMFnZkZgplc5y6vm4QJ0B1liFiEYZoArR0=;
        b=Km+foLKfiJ2paNxPxte+VJRlKC4IXNca+wCEmNQoC4Hvp2aY/JV9YuR1xy1ZHm3pko
         jEXlGtHrYaZpmaDzyPNiRqWw7ZUqJPvNfgTVHLfTHfW/y7HKezFwAsmwhKrq56UIxLFl
         q3nRBJ/c44jU7+XP2DP2k7S4CF+mVL4nl7Sp9IT4N8u99aUEP7xu7fXBO9ibyDciXBL7
         +TaKxAFYG//6fJ2QmyW+crcJw4A9qEKFyQL4b80BMX2MzeKwRdx7CL9lJjYWKi6BJrjl
         emHTu/IY3lV2lYsKXm5zDp0zaHJEPHONXVyX80uvcibJ6dsTtnuf17i6ISjkR6xnQshR
         9ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83v8P9S8ZAMFnZkZgplc5y6vm4QJ0B1liFiEYZoArR0=;
        b=rUXmcwQrSNNpc+5nmZSGV8CslaWuAULjAyeX6lVPTRiqEzcgGuqWlSXkUKn9JcM2pU
         Xq/XTM097GZMghY3NIM+QiuQgUkBl8wG4eaCZga4ADiS5yOAajjrClOPhr7cHfM+dwbU
         cBPWUtoVKDaKhVxMRJGbXeOvhsjy6UJ6VTLHvRZ5VHycvv3E2dd2raMFZLZ48ABB/MU/
         BSXpvqI+tG2drP3ghl2TyeEP4qFvDgQgGoTUtBnqlU9zJvpnfdmgLTcQgIiwoT4Ib8MU
         OqTgVUhvWMNKbgtY3ENX7odhXVJEsH+qbDFdf+K698eY096YY40Lhv707+H3i3DfH7QC
         uf3A==
X-Gm-Message-State: AOAM532oYj/8Rf6j455a+bIfEy3Rp7PlyaRYdOxpK7utQE2aHVt1mcU6
        Ad+zsjeNXzRJZV9Q6GcRSWb0Ue25Jh3NOA==
X-Google-Smtp-Source: ABdhPJx2gRhG94ZEXYJifvL/LsCH0ByfnsJ2yorMwL0mvd7NDWl7IfbuQC5lbsZzO6gJrLGjyfg/Ow==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr6192923wml.87.1624562644576;
        Thu, 24 Jun 2021 12:24:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/21] fsck tests: refactor one test to use a sub-repo
Date:   Thu, 24 Jun 2021 21:23:39 +0200
Message-Id: <patch-01.21-2e37971c016-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor one of the fsck tests to use a throwaway repository. It's a
pervasive pattern in t1450-fsck.sh to spend a lot of effort on the
teardown of a tests so we're not leaving corrupt content for the next
test.

We should instead simply use something like this test_create_repo
pattern. It's both less verbose, and makes things easier to debug as a
failing test can have their state left behind under -d without
damaging the state for other tests.

But let's punt on that general refactoring and just change this one
test, I'm going to change it further in subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5071ac63a5b..1563b35f88c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -48,24 +48,22 @@ remove_object () {
 	rm "$(sha1_file "$1")"
 }
 
-test_expect_success 'object with bad sha1' '
-	sha=$(echo blob | git hash-object -w --stdin) &&
-	old=$(test_oid_to_path "$sha") &&
-	new=$(dirname $old)/$(test_oid ff_2) &&
-	sha="$(dirname $new)$(basename $new)" &&
-	mv .git/objects/$old .git/objects/$new &&
-	test_when_finished "remove_object $sha" &&
-	git update-index --add --cacheinfo 100644 $sha foo &&
-	test_when_finished "git read-tree -u --reset HEAD" &&
-	tree=$(git write-tree) &&
-	test_when_finished "remove_object $tree" &&
-	cmt=$(echo bogus | git commit-tree $tree) &&
-	test_when_finished "remove_object $cmt" &&
-	git update-ref refs/heads/bogus $cmt &&
-	test_when_finished "git update-ref -d refs/heads/bogus" &&
-
-	test_must_fail git fsck 2>out &&
-	test_i18ngrep "$sha.*corrupt" out
+test_expect_success 'object with hash mismatch' '
+	test_create_repo hash-mismatch &&
+	(
+		cd hash-mismatch &&
+		oid=$(echo blob | git hash-object -w --stdin) &&
+		old=$(test_oid_to_path "$oid") &&
+		new=$(dirname $old)/$(test_oid ff_2) &&
+		oid="$(dirname $new)$(basename $new)" &&
+		mv .git/objects/$old .git/objects/$new &&
+		git update-index --add --cacheinfo 100644 $oid foo &&
+		tree=$(git write-tree) &&
+		cmt=$(echo bogus | git commit-tree $tree) &&
+		git update-ref refs/heads/bogus $cmt &&
+		test_must_fail git fsck 2>out &&
+		test_i18ngrep "$oid.*corrupt" out
+	)
 '
 
 test_expect_success 'branch pointing to non-commit' '
-- 
2.32.0.606.g2e440ee2c94

