Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE975C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352992AbiETSlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352978AbiETSlF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B23E3B038
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k30so12626444wrd.5
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7G/VdwAtVGRvoNAXVAHD8mYVobGfON2UK0pjzu+4RVE=;
        b=KtNaVXDh1is8iR7frCLTvL/e0vizKWpJXnZb2/u/Xa7ypKJ31lTAKNRA7rEqJL2g36
         XTxTXQZ9wQIf6948T8WFVRTE9so1lcHsoKvAlG4XhP+UkVoh+ErutPTD4pQgFgGZzVfp
         BR+H43KXX7endO+I6yo/lx8AgU7CSwJzh4gGKDwya9HnFYW2LdN5m+SoPpMMxt662BG1
         7JOHFLN2SX80tPENKVl7NSGSBxxCv/8+3JQz73X/XXKFwcy50Lzl2fkNybredgGRWOpe
         w3a5/ooAdEBX0stB4QiciZOe8NTK7FOmY5dFkazs4u7m6XzUWk9TdmplVtOMeLvSP7JZ
         1vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7G/VdwAtVGRvoNAXVAHD8mYVobGfON2UK0pjzu+4RVE=;
        b=yUcJDRsMg7ifBUN1rvA/aizvsveW4PrT2K5h9H2Uj4OiRJIFCHtXlFsbrftlwssP8r
         Eo+nMEczd3hpgcuSp0MHEIxXkUwZN4DdFoSi6s1BDhUTssyZ1wFfC3yD9Iqfm+y79RcC
         ENQJJk2o4zqqvMXplcN/mYGPfZSWg9Ru4DeDQ1eAcMoiBi6gZ/6o/zHutQpXwqYoO1uH
         1akzeQrUZ3YGifkcnJ5qmHmjWS33mwGXBonJlMS5zo134POostx2AMZsHRn2SovOCLq7
         ZERyym0P+p2cRxlLW4SAShFaQ8q4zSaIHbFtc/BZHhlTq/gdVUFui6PYmYh4sq8auBpQ
         Ip8A==
X-Gm-Message-State: AOAM530T1TluxddlhyqZlbj9hleFbuKQ//64pJNgGdcSLfomiW9YSw+p
        yDjbWlS1VYYwcfwbtyFTk637FpXsneU=
X-Google-Smtp-Source: ABdhPJxNUjHDZlwgmjWqCCmFsOF7Q/DOqsG4I60qscx1Jgtc0bJB6gXlIlXZCDOS9dvx/3bObHWA0Q==
X-Received: by 2002:adf:deca:0:b0:20e:5b4f:2a57 with SMTP id i10-20020adfdeca000000b0020e5b4f2a57mr9039990wrn.575.1653072052228;
        Fri, 20 May 2022 11:40:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10-20020adfc70a000000b0020c66310845sm3137735wrg.55.2022.05.20.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:51 -0700 (PDT)
Message-Id: <7cb3bd1ddae2687724f2f514408d3c013d11bb78.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:25 +0000
Subject: [PATCH 07/24] clone: add --bundle-uri option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Cloning a remote repository is one of the most expensive operations in
Git. The server can spend a lot of CPU time generating a pack-file for
the client's request. The amount of data can clog the network for a long
time, and the Git protocol is not resumable. For users with poor network
connections or are located far away from the origin server, this can be
especially painful.

The 'git bundle fetch' command allows users to bootstrap a repository
using a set of bundles. However, this would require them to use 'git
init' first, followed by the 'git bundle fetch', and finally add a
remote, fetch, and checkout the branch they want.

Instead, integrate this workflow directly into 'git clone' with the
--bundle-uri' option. If the user is aware of a bundle server, then they
can tell Git to bootstrap the new repository with these bundles before
fetching the remaining objects from the origin server.

RFC-TODO: Document this option in git-clone.txt.

RFC-TODO: I added a comment about the location of this code being
necessary for the later step of auto-discovering the bundle URI from the
origin server. This is probably not actually a requirement, but rather a
pain point around how I implemented the feature. If a --bundle-uri
option is specified, but SSH is used for the clone, then the SSH
connection is left open while Git downloads bundles from another server.
This is sub-optimal and should be reconsidered when fully reviewed.

RFC-TODO: create tests for this option with a variety of URI types.

RFC-TODO: a simple end-to-end test is available at the end of the
series.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 52316563795..fd1ae82e57b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -34,6 +34,7 @@
 #include "list-objects-filter-options.h"
 #include "hook.h"
 #include "bundle.h"
+#include "bundle-uri.h"
 
 /*
  * Overall FIXMEs:
@@ -77,6 +78,7 @@ static int option_filter_submodules = -1;    /* unspecified */
 static int config_filter_submodules = -1;    /* unspecified */
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
+static const char *bundle_uri;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -160,6 +162,8 @@ static struct option builtin_clone_options[] = {
 		    N_("any cloned submodules will use their remote-tracking branch")),
 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
 		    N_("initialize sparse-checkout file to include only files at root")),
+	OPT_STRING(0, "bundle-uri", &bundle_uri,
+		   N_("uri"), N_("a URI for downloading bundles before fetching from origin remote")),
 	OPT_END()
 };
 
@@ -1232,6 +1236,24 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
 
+	/*
+	 * NOTE: The bundle URI download takes place after transport_get_remote_refs()
+	 * because a later change will introduce a check for recommended features,
+	 * which might include a recommended bundle URI.
+	 */
+
+	/*
+	 * Before fetching from the remote, download and install bundle
+	 * data from the --bundle-uri option.
+	 */
+	if (bundle_uri) {
+		/* At this point, we need the_repository to match the cloned repo. */
+		repo_init(the_repository, git_dir, work_tree);
+		if (fetch_bundle_uri(the_repository, bundle_uri))
+			warning(_("failed to fetch objects from bundle URI '%s'"),
+				bundle_uri);
+	}
+
 	if (refs)
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 
-- 
gitgitgadget

