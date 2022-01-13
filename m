Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43CEC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiAMDmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiAMDmW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:42:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1599BC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u11so2436553plh.13
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EivWN4tKjC9qJD4S7qofZ34VHlI0C7dKN2uPAx0RUo0=;
        b=eOrexc14PSnoEKzopww3WguV6a9pNolg5P5FBNXuJv4pDQZLSE+AfwAjtKPcFpwACb
         FOZ1t5NHl8747tLddhTC8ps8i1Hnf507ooOh7qJdWCOfWfPyIV+lStFoNsAS0egc8c5j
         Yh9nVDkj/BE4Vke8wu8EqxsY7+drsTubiqgUawLNggPyPkL/p5eTQMsGiqSxQsQk65Z/
         xOI7jEY1yGHgB+bnFPHHKec0is7auo1bOhv7WuGcGByQnixKY9lEaeX/22g65MJtgVif
         3RYEjDeNtge71AglUKB+hKVKUGOu8ZAcUNkxsPP9xGFwV55QF4DQBl3W1ah+tiOIk/yq
         ORYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EivWN4tKjC9qJD4S7qofZ34VHlI0C7dKN2uPAx0RUo0=;
        b=Dy4CESrmaohIaiGzyfWOFfVmVdG4oorDL8vFsk6eRSp0Upw6pCgh8V1gDQV8nWiv4p
         ikxzFHhClo6ZcJ5CgAa3hNPbWUYAkZhpUIaJYlGsUDeZRqlRuodPOyxh1jddp3XMBYHY
         CyioqAC0ixbeNp7qFeiqQmFGlqQUoRqnE4m7c9dIyqrm3PvLWYp7zTkrqy60uYraZZ5l
         2UXmyoveXuAlOetph/C4NWHpfZh5RfhEI6Ot10h2/xCKQhN9C8kEdx+RkHYIwySMAhx5
         IyF56eaqtf2RDIcz1zVJIsXsG5/dWnsoRPmKyQqiB4SV/3QgpI33FzJsYOT5mvI6QQHh
         F2JA==
X-Gm-Message-State: AOAM530clPSSd970GQlM4OBrMD2BwzpcFyEkvg3HTsT7BGk4fHqORV6U
        q7grT0QnSgGPkkd9wx3NCgzk+6Ke1+9EeWczsEs=
X-Google-Smtp-Source: ABdhPJxHZNjZllcvLoFYC1o8mhvnaFk8/bYwezopxonsRdLQCDqZh246vRb4VJCoaQ8AxLFfMP19EA==
X-Received: by 2002:a63:7c5e:: with SMTP id l30mr2409544pgn.158.1642045341630;
        Wed, 12 Jan 2022 19:42:21 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.48])
        by smtp.gmail.com with ESMTPSA id c20sm879436pgk.75.2022.01.12.19.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 19:42:21 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com
Subject: [PATCH v10 1/9] ls-tree: remove commented-out code
Date:   Thu, 13 Jan 2022 11:42:04 +0800
Message-Id: <2fcff7e0d40255e0be9496647787352dd0aeb784.1641978175.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.390.g2ae0a9cb82.dirty
In-Reply-To: <cover.1641978175.git.dyroneteng@gmail.com>
References: <cover.1641978175.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Remove code added in f35a6d3bce7 (Teach core object handling functions
about gitlinks, 2007-04-09), later patched in 7d0b18a4da1 (Add output
flushing before fork(), 2008-08-04), and then finally ending up in its
current form in d3bee161fef (tree.c: allow read_tree_recursive() to
traverse gitlink entries, 2009-01-25). All while being commented-out!

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3a442631c7..5f7c84950c 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -69,15 +69,6 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	const char *type = blob_type;
 
 	if (S_ISGITLINK(mode)) {
-		/*
-		 * Maybe we want to have some recursive version here?
-		 *
-		 * Something similar to this incomplete example:
-		 *
-		if (show_subprojects(base, baselen, pathname))
-			retval = READ_TREE_RECURSIVE;
-		 *
-		 */
 		type = commit_type;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
-- 
2.34.1.390.g2ae0a9cb82.dirty

