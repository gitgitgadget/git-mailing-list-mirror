Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED8DC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 11:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJMLgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 07:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJMLgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 07:36:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B05F53EE
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 04:36:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a10so2325511wrm.12
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 04:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRgleM6G/KxT1LrNGNfEMbPBb1Kf5JGFsVfoSrGwAPA=;
        b=Ypp+EOV+6zwulUsykjtxBVNdFwnHK5TXg2LVypaJ/aYKASJmjVfWt5K9axmiAYwNPY
         A5WRz5usa7NHTb9y1QhLpIx9Y8RvghIKEsoSpzcxQz67qiMF54RbPStAfORoDs3V9LoR
         rZ5D7f4i2N0x0PmNuiOlx2utPbMiidYxTvFmwf1zqhHFPp2vH+Zm+he1LObGc2KGUDhj
         MtG7W6F5+wwmRZ95WhhaoSPUulHiTRKe2XUFBSp/dAv5pl5Nv67aWBk+AiCU7vKCDJby
         01etJqujcxyAlHsvF37T9DSQ7eOEsI7+SQMKZibgmRVGdQFe3fxji6uzDRIRK2eRjIRr
         or3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRgleM6G/KxT1LrNGNfEMbPBb1Kf5JGFsVfoSrGwAPA=;
        b=EeNF8NJMWXlxWBDnEtIMjWURw/va20ytUYUxdAV2o+AE3s7aTlfdQvj5pkhEdLNlQk
         nuibaw6kHUwRCHOVjr+i3WIsVJMR4TDm12Jw2pT4it+/FEgkzOLBncsky+DGZfPZp4RI
         wE9bXAEN7TbLOsWHU4A8qmBgO87SKW7uSHuZrL9o7Se168aOQYi+y2gGhndgRy2oY8dp
         Y8cFz5Yzrcubj236Z/nckhwq9yCGqKqZTkhOcJ0ixrYxjMAwwFVY7OJtzPc1wE3ZR5+d
         1RImRkxgIWNoj4PdLahHs2GZ7HFYEP0TuoIUWz5X5+0NMGcLpuPiDrJzfPt2NDWSH/Bw
         lHJg==
X-Gm-Message-State: ACrzQf2WbxMdLYNY635APJ1bBu2gzg5lTn3Muez8CI6ZfDaAE6yAxk6l
        pICninNjUpHDMMFm8fM+KA3n7tVAkxw=
X-Google-Smtp-Source: AMsMyM5OWMlBDiGbg+x4FcODYfRjUvYddGKn4lKyHeRKMiLvrFwwODiEXSHJyfumaSLcPeovEK77nA==
X-Received: by 2002:adf:f40e:0:b0:22e:2ce4:e6a2 with SMTP id g14-20020adff40e000000b0022e2ce4e6a2mr22364105wro.30.1665660966248;
        Thu, 13 Oct 2022 04:36:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t21-20020a1c7715000000b003b4de550e34sm4155190wmi.40.2022.10.13.04.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 04:36:05 -0700 (PDT)
Message-Id: <68f7830c6d99187aa599dd608fa6c6a916bbd017.1665660960.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
References: <pull.1359.git.git.1665597148042.gitgitgadget@gmail.com>
        <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
From:   "Alphadelta14 via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 11:36:00 +0000
Subject: [PATCH v2 2/2] archive: fix a case of submodule in submodule
 traversal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heather Lapointe <alpha@alphaservcomputing.solutions>,
        Alphadelta14 <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alphadelta14 <alpha@alphaservcomputing.solutions>

repo_submodule_init actually expects the path relative to submodule_prefix.
We preform a simple strip to the correct path.

Signed-off-by: Alphadelta14 <alpha@alphaservcomputing.solutions>
---
 tree.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/tree.c b/tree.c
index c5b5a0ac08f..c327d210f47 100644
--- a/tree.c
+++ b/tree.c
@@ -64,35 +64,52 @@ int read_tree_at(struct repository *r,
 			struct repository subrepo;
 			struct repository* subrepo_p = &subrepo;
 			struct tree* submodule_tree;
+			char *submodule_rel_path;
+			int name_base_len = 0;
 
-			if (repo_submodule_init(subrepo_p, r, entry.path, null_oid()))
-				die("couldn't init submodule %s%s", base->buf, entry.path);
+			len = tree_entry_len(&entry);
+			strbuf_add(base, entry.path, len);
+			submodule_rel_path = base->buf;
+			// repo_submodule_init expects a path relative to submodule_prefix
+			if (r->submodule_prefix) {
+				name_base_len = strlen(r->submodule_prefix);
+				// we should always expect to start with submodule_prefix
+				assert(!strncmp(submodule_rel_path, r->submodule_prefix, name_base_len));
+				// strip the prefix
+				submodule_rel_path += name_base_len;
+				// if submodule_prefix doesn't end with a /, we want to get rid of that too
+				if (is_dir_sep(submodule_rel_path[0])) {
+					submodule_rel_path++;
+				}
+			}
+
+			if (repo_submodule_init(subrepo_p, r, submodule_rel_path, null_oid()))
+				die("couldn't init submodule %s", base->buf);
 
 			if (repo_read_index(subrepo_p) < 0)
 				die("index file corrupt");
 
 			commit = lookup_commit(subrepo_p, &entry.oid);
 			if (!commit)
-				die("Commit %s in submodule path %s%s not found",
+				die("Commit %s in submodule path %s not found",
 				    oid_to_hex(&entry.oid),
-				    base->buf, entry.path);
+				    base->buf);
 
 			if (repo_parse_commit(subrepo_p, commit))
-				die("Invalid commit %s in submodule path %s%s",
+				die("Invalid commit %s in submodule path %s",
 				    oid_to_hex(&entry.oid),
-				    base->buf, entry.path);
+				    base->buf);
 
 			submodule_tree = repo_get_commit_tree(subrepo_p, commit);
 			oidcpy(&oid, submodule_tree ? &submodule_tree->object.oid : NULL);
 
-			len = tree_entry_len(&entry);
-			strbuf_add(base, entry.path, len);
 			strbuf_addch(base, '/');
+
 			retval = read_tree_at(subrepo_p, lookup_tree(subrepo_p, &oid),
 						base, pathspec,
 						fn, context);
 			if (retval) {
-			    die("failed to read tree for %s%s", base->buf, entry.path);
+			    die("failed to read tree for %s", base->buf);
 			    return -1;
 			}
 			strbuf_setlen(base, oldlen);
-- 
gitgitgadget
