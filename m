Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A3EB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 19:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjFUTfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 15:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFUTfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 15:35:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5C10F2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 12:35:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-311183ef595so6267259f8f.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376116; x=1689968116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yiO9l/MVFe/If4DhjRtFB7xbcA61tk5JMXTK8XF1rk=;
        b=gUIpDzTG20Bqore+14PGubcgLKmxF0H34SOOLvnrYELbP8zZWqqdeTcfyUHzInLYmi
         VB9wGK7UqAWsqxD2opgdLsXIQgD+OUofu/wu+KzU1pqajxYto14w93qEuv5I+OBhwWHx
         IzKSu/HafZhkeXtKtguHri7Vsy8ZSTLHDODC2ySC2KgWghMPTO1wzIJfFtyu5nwbvEqd
         GIbZCqsi0ANdBHdxytXcku/e24qa1jEP8BeYQM4wbDC9MPzLFMF/rvA/PonkHgQrkHss
         BT1DI9z69bHs5tqy9322PP9kvWT4RJumlrPeUAJs3HEhYel1MWzG0t3JiEXo2OzPvzUd
         SIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376116; x=1689968116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yiO9l/MVFe/If4DhjRtFB7xbcA61tk5JMXTK8XF1rk=;
        b=Pi5jYxQPzxLrcDT8vTcdPPpxyhJcMVgue6CAyA2KcCR7SdqvOrXJH7WJZ/oWYngi/+
         /3k2XwiSP7g88CILcdOkOLO9ttDdR/gKg7CH29N7o47Iac+suzRDG/1AjTmxFki7EAM9
         O/Tlv1NgAuAfV5VvRPpdDdS2LTzvtHAv5nPjJ04YHi0MZrZwZvgV/Qt28ZS/65DIaaPf
         hge9f/vDiXbbkC6LO8W0akavmrY7qJuoH8tiARTIsdxg9Sp9johXfMDufu17iAidEmsf
         UsV9Qse0SsJ2ybx6Azu5nNOez625vY/a6NFE9etmV37Hm1QGo0KNz7PZr6NWkT6wrRBA
         qy7Q==
X-Gm-Message-State: AC+VfDzGpfWewYuO0tJ8FQAIOa88Jg1MK26Qn0lIDSg5DmKN9LIKSuBS
        dDaXlIXHk7ISfsi7vor6ui2xp+VD4UE=
X-Google-Smtp-Source: ACHHUZ4NQ08QTfYIDFPQfKDPWqKlfxRIb5FyQpj0YCC7gK3U1kbAqTFb6iOBfMQsSLBZoYxUgv4vlw==
X-Received: by 2002:a5d:6884:0:b0:30f:bb0c:d19d with SMTP id h4-20020a5d6884000000b0030fbb0cd19dmr12865186wru.64.1687376116437;
        Wed, 21 Jun 2023 12:35:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b002fae7408544sm5154039wrs.108.2023.06.21.12.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:35:16 -0700 (PDT)
Message-Id: <144ad0b48a4e8491c4e2609458be653087ced804.1687376112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jun 2023 19:35:12 +0000
Subject: [PATCH 3/3] pack-refs: use new ref_visible() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

replace the current logic in pack-refs that takes into account included
refs with the new ref_visible() helper.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/pack-refs.c       | 14 ++++++++------
 refs/files-backend.c      | 11 +----------
 t/helper/test-ref-store.c |  6 ++----
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index ff07986edaf..5d6dc363085 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -15,17 +15,16 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	unsigned int flags = PACK_REFS_PRUNE;
 	static struct ref_visibility visibility = REF_VISIBILITY_INIT;
-	static struct string_list included_refs = STRING_LIST_INIT_NODUP;
 	struct pack_refs_opts pack_refs_opts = { .visibility = &visibility,
-						 .includes = &included_refs,
 						 .flags = flags };
 	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
+	static struct string_list option_included_refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 
 	struct option opts[] = {
 		OPT_BIT(0, "all",   &pack_refs_opts.flags, N_("pack everything"), PACK_REFS_ALL),
 		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
-		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
+		OPT_STRING_LIST(0, "include", &option_included_refs, N_("pattern"),
 			N_("references to include")),
 		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
 			N_("references to exclude")),
@@ -38,11 +37,14 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	for_each_string_list_item(item, &option_excluded_refs)
 		add_ref_exclusion(pack_refs_opts.visibility, item->string);
 
+	for_each_string_list_item(item, &option_included_refs)
+		add_ref_inclusion(pack_refs_opts.visibility, item->string);
+
 	if (pack_refs_opts.flags & PACK_REFS_ALL)
-		string_list_append(pack_refs_opts.includes, "*");
+		add_ref_inclusion(pack_refs_opts.visibility, "*");
 
-	if (!pack_refs_opts.includes->nr)
-		string_list_append(pack_refs_opts.includes, "refs/tags/*");
+	if (!option_included_refs.nr)
+		add_ref_inclusion(pack_refs_opts.visibility, "refs/tags/*");
 
 	return refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2e716a3e201..2dfe7f7e787 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1179,8 +1179,6 @@ static int should_pack_ref(const char *refname,
 			   const struct object_id *oid, unsigned int ref_flags,
 			   struct pack_refs_opts *opts)
 {
-	struct string_list_item *item;
-
 	/* Do not pack per-worktree refs: */
 	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
 	    REF_WORKTREE_SHARED)
@@ -1194,14 +1192,7 @@ static int should_pack_ref(const char *refname,
 	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
 		return 0;
 
-	if (ref_excluded(opts->visibility, refname))
-		return 0;
-
-	for_each_string_list_item(item, opts->includes)
-		if (!wildmatch(item->string, refname, 0))
-			return 1;
-
-	return 0;
+	return ref_visible(opts->visibility, refname);
 }
 
 static int files_pack_refs(struct ref_store *ref_store,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 504935c1d84..81e0b5ea0a0 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -118,13 +118,11 @@ static int cmd_pack_refs(struct ref_store *refs, const char **argv)
 {
 	unsigned int flags = arg_flags(*argv++, "flags", pack_flags);
 	static struct ref_visibility visibility = REF_VISIBILITY_INIT;
-	static struct string_list included_refs = STRING_LIST_INIT_NODUP;
 	struct pack_refs_opts pack_opts = { .flags = flags,
-					    .visibility = &visibility,
-					    .includes = &included_refs };
+					    .visibility = &visibility };
 
 	if (pack_opts.flags & PACK_REFS_ALL)
-		string_list_append(pack_opts.includes, "*");
+		add_ref_inclusion(&visibility, "*");
 
 	return refs_pack_refs(refs, &pack_opts);
 }
-- 
gitgitgadget
