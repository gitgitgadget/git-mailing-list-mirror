Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB23E215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754354AbeD3WID (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:08:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46139 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753683AbeD3WH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:07:58 -0400
Received: by mail-wr0-f194.google.com with SMTP id o2-v6so6476826wrj.13
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yFiEFicsnwGp2r9RtGyBGWQ5w8j8g14wMekCoKk1oGk=;
        b=mawUkNUrDSijUo3dTmhyIeW9qePk+xH5PiZTiFsxtjXh3+QY6EChojELhk4xOCLr63
         VmfVbslRfzymPeEl2V9rvZre9cYG9PpPM9w5CoG8+U9Tt3nN7BRZYav71sb/1mpltn6k
         Qs9jQWBTOPWWeOMoX5F6djsh1yNNo0UEexO/FPdTyCNdGFBwNBZAt5A2FHkQ17M7wLOx
         isJettgwRPeaxjvgGaHLxd3BqdJygjmFCJzrxevgj1ORDzLq57j7sNbE6jKtfKjR5xvm
         sd/WZAeccJwhp4uoaXms6S97v8XfKAjilG6361qTnzW71oZDvpHjUImK0Ir894lEU+mR
         GyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yFiEFicsnwGp2r9RtGyBGWQ5w8j8g14wMekCoKk1oGk=;
        b=GIWlR1ioRMUHSft58x4EbMOqpmHBCu8aPPnMb68I6ezrPEZuSodxAUOQPP5UJuy6ki
         dtFYZT8My4ntQkexSCw+Chue0utMpT7G3CBkkR6xKVHXALqkhZGMJi++suHlXu4yIm+7
         tcfyt/p1rCXBGrCod2WDLpTTNiyXRWoHE/3IEpnq6QET0MH2mn6Gu3vJW97siJyeYrlk
         96UnGTtnQ+t7/ddCm7Ag71v/EeEojdUPx6kOl1r3kpISWbesQ/F0QLOH7WhoZpN8fwJn
         dgTyVxZGkVA2XvaI84N01X+vfqgUUjFfDe48O3zxxSzmeLlndPzg5az7w1xEVZ050OFH
         oGBQ==
X-Gm-Message-State: ALQs6tADQF2dI97JiajIOAuXtHfEDgQ8mpwfruzGGQeYoKruqiNjyMP5
        Xk22wG1hf10MwbT9DJYMJ1lHu+Fg
X-Google-Smtp-Source: AB8JxZpGDSbFonL9h9HRUnyO8lE0E1lgOJSoWWrVOwcuWAfA7uG3dp8+wEb2OO1hU+nR0UoYim9CYA==
X-Received: by 2002:adf:afe4:: with SMTP id y36-v6mr9831926wrd.107.1525126076978;
        Mon, 30 Apr 2018 15:07:56 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l53-v6sm24014633wrc.80.2018.04.30.15.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 15:07:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/9] get_short_oid: learn to disambiguate by ^{tag}
Date:   Mon, 30 Apr 2018 22:07:30 +0000
Message-Id: <20180430220734.30133-6-avarab@gmail.com>
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

Add support for ^{tag} to the disambiguation logic. Before this ^{tag}
would simply be ignored:

    $ git rev-parse e8f2^{tag}
    error: short SHA1 e8f2 is ambiguous
    hint: The candidates are:
    hint:   e8f2650052 tag v2.17.0
    hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
    hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
    hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
    hint:   e8f2093055 tree
    hint:   e8f25a3a50 tree
    hint:   e8f28d537c tree
    hint:   e8f2cf6ec0 tree
    hint:   e8f21d02f7 blob
    hint:   e8f21d577c blob
    hint:   e8f2867228 blob
    hint:   e8f2a35526 blob
    e8f2^{tag}

Now the logic added in ed1ca6025f ("peel_onion: disambiguate to favor
tree-ish when we know we want a tree-ish", 2013-03-31) has been
extended to support it.

    $ git rev-parse e8f2^{tag}
    e8f2650052f3ff646023725e388ea1112b020e79

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h                             |  5 +++--
 sha1-name.c                         | 13 ++++++++++++-
 t/t1512-rev-parse-disambiguation.sh |  5 ++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 77b7acebb6..3f6a292ba6 100644
--- a/cache.h
+++ b/cache.h
@@ -1322,8 +1322,9 @@ struct object_context {
 #define GET_OID_TREE             010
 #define GET_OID_TREEISH          020
 #define GET_OID_BLOB             040
-#define GET_OID_FOLLOW_SYMLINKS 0100
-#define GET_OID_RECORD_PATH     0200
+#define GET_OID_TAG             0100
+#define GET_OID_FOLLOW_SYMLINKS 0200
+#define GET_OID_RECORD_PATH     0400
 #define GET_OID_ONLY_TO_DIE    04000
 
 #define GET_OID_DISAMBIGUATORS \
diff --git a/sha1-name.c b/sha1-name.c
index 46d8b1afa6..68d5f65362 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -221,6 +221,12 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 	return 0;
 }
 
+static int disambiguate_tag_only(const struct object_id *oid, void *cb_data_unused)
+{
+	int kind = oid_object_info(oid, NULL);
+	return kind == OBJ_TAG;
+}
+
 static int disambiguate_commit_only(const struct object_id *oid, void *cb_data_unused)
 {
 	int kind = oid_object_info(oid, NULL);
@@ -288,7 +294,8 @@ int set_disambiguate_hint_config(const char *var, const char *value)
 		{ "committish", disambiguate_committish_only },
 		{ "tree", disambiguate_tree_only },
 		{ "treeish", disambiguate_treeish_only },
-		{ "blob", disambiguate_blob_only }
+		{ "blob", disambiguate_blob_only },
+		{ "tag", disambiguate_tag_only }
 	};
 	int i;
 
@@ -429,6 +436,8 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 		ds.fn = disambiguate_treeish_only;
 	else if (flags & GET_OID_BLOB)
 		ds.fn = disambiguate_blob_only;
+	else if (flags & GET_OID_TAG)
+		ds.fn = disambiguate_tag_only;
 	else
 		ds.fn = default_disambiguate_hint;
 
@@ -958,6 +967,8 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	lookup_flags &= ~GET_OID_DISAMBIGUATORS;
 	if (expected_type == OBJ_COMMIT)
 		lookup_flags |= GET_OID_COMMITTISH;
+	else if (expected_type == OBJ_TAG)
+		lookup_flags |= GET_OID_TAG;
 	else if (expected_type == OBJ_TREE)
 		lookup_flags |= GET_OID_TREEISH;
 
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 711704ba5a..c7ceda2f21 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -334,7 +334,10 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguity hints respect type' '
 	test_must_fail git rev-parse 000000000^{commit} 2>stderr &&
 	grep ^hint: stderr >hints &&
 	# 5 commits, 1 tag (which is a commitish), plus intro line
-	test_line_count = 7 hints
+	test_line_count = 7 hints &&
+	git rev-parse 000000000^{tag} >stdout &&
+	test_line_count = 1 stdout &&
+	grep -q ^0000000000f8f stdout
 '
 
 test_expect_success C_LOCALE_OUTPUT 'failed type-selector still shows hint' '
-- 
2.17.0.290.gded63e768a

