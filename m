Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239E2C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 12:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiGUMBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiGUMBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 08:01:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1178E4AD5D
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m17so1645697wrw.7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vLPPpuU7WbdprO6gajo/JGuRX8akGkF1itLUd7X0YM=;
        b=aDXOcYYyK0h6jJfCLVNa25aKp0FnySpcfH5s30kCiQeiZktUgc8FADncxW4a8y2ZpW
         kJXt6uCxB8hkb9CBosM3O3FyDSOXB/2m2whDl5s3au90ntU9TxUIOHbe6bEaCAbel50n
         2p9tWLmPX3jh3mdP93mpK+8HM8eqGr0ocR9P+KYiBu4yysWKdfPwmkncTcBmuXVUtEAx
         SuEmbcweEWtf8IS+0TX3eaAZw1XaxUigMHF7FGFGwQFCQKKT/VHxEKnHYBXDWYoS85S1
         kNGemt4eZH//Wc4LHQxXj8dGzMTQp9UrIduV6PsfZIg1oVZ4tPc86rJMPtTl0PAtZPPB
         3Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vLPPpuU7WbdprO6gajo/JGuRX8akGkF1itLUd7X0YM=;
        b=HPml6gZYCXghrAnyIDjtdORWDNSrewRcnzxTpOgHk/56pltY2tYFVk/Y5ylSb4eHJJ
         Hia2yUgfhkN9jlEV3xwOwhIW6RXCgzvB75JyzKOrMUa+eOsEo++Qtgf8L++WQLHy5Z5r
         4ZKpRwPkPw5Ysm3IX/pr9LHIqJyXzT4UdogHoqx8sTPEbL8lF7C3f0X6HwdPmJXZpT0n
         aH8NokouNJeU9upkdZYjqQYIIz/FsYNoj/odoeh1sFoZdvT007mIwERvocBXQ0+oOrTd
         P2H/irjob73KbYB4ux4aElhFAoA16EJus/yMIaUhrd6ndXTr9PBkVa7VZuEawDsUURy+
         0n9g==
X-Gm-Message-State: AJIora/gFo3aMKSPfZ+vh6UM9R6cDFlkVu100wzDr2t0vNHp/bu7TOtt
        Z55df7xfOE8yOJJdMRODxLUoC8Zjf90koA==
X-Google-Smtp-Source: AGRyM1t0IkRU8y/V7Djsmd3nOCRin1AFneRcsHSFgACO3ICqbQR550K1dWYOHfvBcRmH0hrrPBpbOQ==
X-Received: by 2002:a5d:66c5:0:b0:21d:7f61:5a22 with SMTP id k5-20020a5d66c5000000b0021d7f615a22mr32881876wrw.564.1658404874245;
        Thu, 21 Jul 2022 05:01:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm5226069wmh.33.2022.07.21.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:01:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] string-list API users: don't tweak "strdup_strings" to free dupes
Date:   Thu, 21 Jul 2022 14:00:52 +0200
Message-Id: <patch-v2-5.6-8c0ac6cbd96-20220721T111808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in [1] and [2] used in notes.c and bisect.c to
initialize a "struct string_list" as "DUP" and append with "nodup",
rather than doing it the other way around.

Settings up a "struct string_list" as "NODUP" and then manually
freeing its items by flipping the "strdup_strings" breaks the
encapsulation of the "struct string_list". It's also both more verbose
than the alternative, and not as safe. If we miss one of the codepaths
that appends to the list we'll end up freeing a constant string.

It's better to declare it as "dup", and then when we insert into the
list declare that the particular string we're inserting should be
owned by the "struct string_list" with string_list_append_nodup(). The
worst case with that API use is that we'll miss a caller, end up
double-dup-ing the string, and have a memory leak as a result.

1. 92e0d42539a (revision.c: make --no-notes reset --notes list,
   2011-03-29)
2. fb71a329964 (bisect--helper: `bisect_clean_state` shell function in
   C, 2017-09-29)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c | 7 +++----
 notes.c  | 8 ++------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/bisect.c b/bisect.c
index b63669cc9d7..8412feb1f69 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1159,7 +1159,7 @@ static int mark_for_removal(const char *refname, const struct object_id *oid,
 {
 	struct string_list *refs = cb_data;
 	char *ref = xstrfmt("refs/bisect%s", refname);
-	string_list_append(refs, ref);
+	string_list_append_nodup(refs, ref);
 	return 0;
 }
 
@@ -1168,11 +1168,10 @@ int bisect_clean_state(void)
 	int result = 0;
 
 	/* There may be some refs packed during bisection */
-	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
+	struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
 	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
-	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
+	string_list_append_nodup(&refs_for_removal, xstrdup("BISECT_HEAD"));
 	result = delete_refs("bisect: remove", &refs_for_removal, REF_NO_DEREF);
-	refs_for_removal.strdup_strings = 1;
 	string_list_clear(&refs_for_removal, 0);
 	unlink_or_warn(git_path_bisect_expected_rev());
 	unlink_or_warn(git_path_bisect_ancestors_ok());
diff --git a/notes.c b/notes.c
index 7452e71cc8d..acc35b580b6 100644
--- a/notes.c
+++ b/notes.c
@@ -1064,19 +1064,15 @@ void enable_ref_display_notes(struct display_notes_opt *opt, int *show_notes,
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addstr(&buf, ref);
 	expand_notes_ref(&buf);
-	string_list_append(&opt->extra_notes_refs,
-			strbuf_detach(&buf, NULL));
+	string_list_append_nodup(&opt->extra_notes_refs,
+				 strbuf_detach(&buf, NULL));
 	*show_notes = 1;
 }
 
 void disable_display_notes(struct display_notes_opt *opt, int *show_notes)
 {
 	opt->use_default_notes = -1;
-	/* we have been strdup'ing ourselves, so trick
-	 * string_list into free()ing strings */
-	opt->extra_notes_refs.strdup_strings = 1;
 	string_list_clear(&opt->extra_notes_refs, 0);
-	opt->extra_notes_refs.strdup_strings = 0;
 	*show_notes = 0;
 }
 
-- 
2.37.1.1095.g64a1e8362fd

