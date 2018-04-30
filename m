Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB50C215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755164AbeD3WIL (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:08:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42873 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755058AbeD3WII (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:08:08 -0400
Received: by mail-wr0-f193.google.com with SMTP id v5-v6so9384195wrf.9
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5xmzHrTSN+A270ByUyvqMd2ebwjc/yDwKKCFn5UYsc=;
        b=qilToI5R/qg+bOPruQkUkWY42pzrWJaS5DlrA1Idb9XPKcLJ1CTstpSqXre5zELEMl
         emo1LdP1MxtmXLuf6ahAEu28sySYtQw19z1SGtUAbteE6wou1zjul9g3t+KtibHcNar7
         KeT0OhYH4k9pldV6NWbDk9Fs9n5LG0h8IDz0in4FoGrAQ2Z8z5k0aoRtBdZY7Zy3lhQ+
         X/y+bJMAc5kOYLp3PboiouPLMTuLjTPwNbJ1mKWojJFN2dZ/WxjSTMIu5SURNohRrk7t
         qoes9pF4GVCHR3nl22zBl50/H38aOYmbd/evkZpLIrYnqoVSygkOEB1WyOVC9Qf7iJXt
         QDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5xmzHrTSN+A270ByUyvqMd2ebwjc/yDwKKCFn5UYsc=;
        b=LuXOEkJgkE+hek9eU+0pFRlyng5ghS6DEYOJuf1thtAr++tOEpZxvHPUQ7CJ/sNfrl
         67RRODbp6p5k85Pk+GmujiBfk3kGs4NBUAWfWGviIh7Z3Vdz0oMZMYr6LaYPuQhnId19
         JEetlUNfDq8cbfe2YJ6WhNOeD4ky980NVGrBVf2LTrOp3GdsqiOBjcKA7TA52i/jQyQV
         0CjPATwotzYbMYRrSSCyoUJzo2N1uPbXM0VtzIOpmgL3zNpy4GSU4jK/UW7Tz/q8Qms2
         IaGRsgaYwdt4DedPX6ZWnfwHeWQYf3saotUyVZ7npiFCN8qz+MpC+43MgbeluH7yQIgy
         fiNw==
X-Gm-Message-State: ALQs6tDMZY4S/zmk0Ol8i2fTODuQEekWZdSrflE/oZX3e0XBtDg3jPS3
        H5dBxZxuKSq6tcbOrWTG5UpIYrD0
X-Google-Smtp-Source: AB8JxZrT40YYirWkrXIP1TMhZtM8aESSN+wgembb/Zy9isky5p6Ja6uoFu36zvUj6IpHe19oCIVI/w==
X-Received: by 2002:adf:82ce:: with SMTP id 72-v6mr10636179wrc.60.1525126087158;
        Mon, 30 Apr 2018 15:08:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l53-v6sm24014633wrc.80.2018.04.30.15.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 15:08:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/9] get_short_oid / peel_onion: ^{tree} should mean commit, not commitish
Date:   Mon, 30 Apr 2018 22:07:33 +0000
Message-Id: <20180430220734.30133-9-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the untangling of peel disambiguation syntax. Before this
e8f2^{commit} would show the v2.17.0 tag, but now it'll just show
ambiguous commits:

    $ git rev-parse e8f2^{commit}
    error: short SHA1 e8f2 is ambiguous
    hint: The candidates are:
    hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
    hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
    hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
    [...]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c                         | 2 +-
 t/t1512-rev-parse-disambiguation.sh | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index b61c0558d9..1d2a74a29c 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -966,7 +966,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 
 	lookup_flags &= ~GET_OID_DISAMBIGUATORS;
 	if (expected_type == OBJ_COMMIT)
-		lookup_flags |= GET_OID_COMMITTISH;
+		lookup_flags |= GET_OID_COMMIT;
 	else if (expected_type == OBJ_TAG)
 		lookup_flags |= GET_OID_TAG;
 	else if (expected_type == OBJ_TREE)
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 2acf564714..b3ef236db8 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -341,8 +341,8 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguity hints' '
 test_expect_success C_LOCALE_OUTPUT 'ambiguity hints respect type' '
 	test_must_fail git rev-parse 000000000^{commit} 2>stderr &&
 	grep ^hint: stderr >hints &&
-	# 5 commits, 1 tag (which is a commitish), plus intro line
-	test_line_count = 7 hints &&
+	# 5 commits plus intro line
+	test_line_count = 6 hints &&
 	git rev-parse 000000000^{tag} >stdout &&
 	test_line_count = 1 stdout &&
 	grep -q ^0000000000f8f stdout &&
@@ -366,7 +366,8 @@ test_expect_success 'core.disambiguate config can prefer types' '
 	# ambiguous between tree and tag
 	sha1=0000000000f &&
 	test_must_fail git rev-parse $sha1 &&
-	git rev-parse $sha1^{commit} &&
+	# there is no commit so ^{commit} comes up empty
+	test_must_fail git rev-parse $sha1^{commit} &&
 	git -c core.disambiguate=committish rev-parse $sha1
 '
 
-- 
2.17.0.290.gded63e768a

