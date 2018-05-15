Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B4A1F406
	for <e@80x24.org>; Tue, 15 May 2018 20:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeEOUAq (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 16:00:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35479 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752727AbeEOUAo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 16:00:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id x9-v6so575672pfm.2
        for <git@vger.kernel.org>; Tue, 15 May 2018 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U2RqBv/3hKToq7euyUCJFz2icdTgs5uWwsqUOTCGyT0=;
        b=K3J5PHBTXQh3O6Y1MuvXshjsGjN3uA3Es4Yb2Kbo0/qP7vim+LUR4qwC6V0NTYNulz
         9dHV+r5N38Q4HqIBDsKx/+AU3tIQ/PScrvg9+Qg/Tdc25C7Q+IaKn+MWkO4uSX8CrKC4
         2hXay12Bh2keqWFDWr/AFsSIGagni54ERUnfNY0sL9rb2Gv8FruSMN6Z3f1dhXrVn+gK
         U9CaeqgM6Sbefr+2CtAbinurAmiK8D8dUYR0MZQznEuzVbuLhdMQVcTkZRxnKUI3guZA
         yq5LErAw/5Oa6xk3Mi9ikTG11CraDwte3vXZ+i2/ozLt+iWQwN8KX6FfOTr+UZdXwDkR
         Akfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U2RqBv/3hKToq7euyUCJFz2icdTgs5uWwsqUOTCGyT0=;
        b=jxj0TB2gH/9poTew96dVdfM4gKwd+MQMg2JfEOlQK5AM3gtSfyn3nAH3MQSO+S65+c
         d2K+8cpVCE0bbgBoWtYQW0hKuPGkbgNq+0lmA7fEnpuUD78ossTDNp0ZOH9FAwrf+5ec
         c0t/MMmNef3eX+jzr+dF8E0axbQKhk5UXET4YLs5GjgJg/X8JpBix7UMZnHYGOm3pqtD
         qWKh7F2625OmGzSZsvg/QIVT7pvb5jgvDIhe03YZAQdaa8/98pj4fXtFITEnxjghvoJJ
         5I6T7MAOhy1GSBtOBtuw+J1St4GafJzdR11cpdaVFr5wiUUG2HXWzNu4VFGQ6CHVOlIo
         30pg==
X-Gm-Message-State: ALKqPwf64bv/U2NKX61o4LssEk++iWVzgHqddNNIGqrh4UWlu+4EjAae
        fd1FtBN1ci8SenCgO6JK23YHwcBG2PI=
X-Google-Smtp-Source: AB8JxZqHlgRI0y9N7UIg5MEKtz4HcA83EnUH2r5voJaobN0g510NCxIC75ic0nIlJzCe9b/rei49ew==
X-Received: by 2002:a63:3d0a:: with SMTP id k10-v6mr13566952pga.11.1526414442369;
        Tue, 15 May 2018 13:00:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm1149551pfn.38.2018.05.15.13.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 13:00:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, leif.middelschulte@gmail.com
Cc:     gitster@pobox.com, newren@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] merge-recursive: i18n submodule merge output and respect verbosity
Date:   Tue, 15 May 2018 13:00:29 -0700
Message-Id: <20180515200030.88731-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515200030.88731-1-sbeller@google.com>
References: <20180515200030.88731-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule merge code now uses the output() function that is used by
all the rest of the merge-recursive-code. This allows for respecting
internationalisation as well as the verbosity setting.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 merge-recursive.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 700ba15bf88..0571919ee0a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1048,18 +1048,17 @@ static void print_commit(struct commit *commit)
 	strbuf_release(&sb);
 }
 
-#define MERGE_WARNING(path, msg) \
-	warning("Failed to merge submodule %s (%s)", path, msg);
-
-static int merge_submodule(struct object_id *result, const char *path,
+static int merge_submodule(struct merge_options *o,
+			   struct object_id *result, const char *path,
 			   const struct object_id *base, const struct object_id *a,
-			   const struct object_id *b, int search)
+			   const struct object_id *b)
 {
 	struct commit *commit_base, *commit_a, *commit_b;
 	int parent_count;
 	struct object_array merges;
 
 	int i;
+	int search = !o->call_depth;
 
 	/* store a in result in case we fail */
 	oidcpy(result, a);
@@ -1073,21 +1072,21 @@ static int merge_submodule(struct object_id *result, const char *path,
 		return 0;
 
 	if (add_submodule_odb(path)) {
-		MERGE_WARNING(path, "not checked out");
+		output(o, 1, _("Failed to merge submodule %s (not checked out)"), path);
 		return 0;
 	}
 
 	if (!(commit_base = lookup_commit_reference(base)) ||
 	    !(commit_a = lookup_commit_reference(a)) ||
 	    !(commit_b = lookup_commit_reference(b))) {
-		MERGE_WARNING(path, "commits not present");
+		output(o, 1, _("Failed to merge submodule %s (commits not present)"), path);
 		return 0;
 	}
 
 	/* check whether both changes are forward */
 	if (!in_merge_bases(commit_base, commit_a) ||
 	    !in_merge_bases(commit_base, commit_b)) {
-		MERGE_WARNING(path, "commits don't follow merge-base");
+		output(o, 1, _("Failed to merge submodule %s (commits don't follow merge-base)"), path);
 		return 0;
 	}
 
@@ -1116,25 +1115,24 @@ static int merge_submodule(struct object_id *result, const char *path,
 	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
 	switch (parent_count) {
 	case 0:
-		MERGE_WARNING(path, "merge following commits not found");
+		output(o, 1, _("Failed to merge submodule %s (merge following commits not found)"), path);
 		break;
 
 	case 1:
-		MERGE_WARNING(path, "not fast-forward");
-		fprintf(stderr, "Found a possible merge resolution "
-				"for the submodule:\n");
+		output(o, 1, _("Failed to merge submodule %s (not fast-forward)"), path);
+		output(o, 2, _("Found a possible merge resolution for the submodule:\n"));
 		print_commit((struct commit *) merges.objects[0].item);
-		fprintf(stderr,
+		output(o, 2, _(
 			"If this is correct simply add it to the index "
 			"for example\n"
 			"by using:\n\n"
 			"  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
-			"which will accept this suggestion.\n",
+			"which will accept this suggestion.\n"),
 			oid_to_hex(&merges.objects[0].item->oid), path);
 		break;
 
 	default:
-		MERGE_WARNING(path, "multiple merges found");
+		output(o, 1, _("Failed to merge submodule %s (multiple merges found)"), path);
 		for (i = 0; i < merges.nr; i++)
 			print_commit((struct commit *) merges.objects[i].item);
 	}
@@ -1205,12 +1203,11 @@ static int merge_file_1(struct merge_options *o,
 				return ret;
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result->clean = merge_submodule(&result->oid,
+			result->clean = merge_submodule(o, &result->oid,
 						       one->path,
 						       &one->oid,
 						       &a->oid,
-						       &b->oid,
-						       !o->call_depth);
+						       &b->oid);
 		} else if (S_ISLNK(a->mode)) {
 			switch (o->recursive_variant) {
 			case MERGE_RECURSIVE_NORMAL:
-- 
2.17.0.582.gccdcbd54c44.dirty

