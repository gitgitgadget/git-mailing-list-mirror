Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C773C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFAD2072D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VT/1bO8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgCSRoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:44:46 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33659 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgCSRoq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:44:46 -0400
Received: by mail-pf1-f201.google.com with SMTP id o5so2326328pfp.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Aw0xblq4BURIKkKM1vvIoCHmuZeSHkoqslaiaMkPmbg=;
        b=VT/1bO8+RacjLxrKiP0ap3J11kV0N3LwOXn3JQYrVDJSEniUrxGAhpKrPGzhGfWMfm
         dcLq79aOHrpkG+99Ki5gDfRdsa3Ymaj5fs1uXbiKIOYxBtOuxSNCHmqlGCa0Pe3OxwVB
         0/L/ulr67TbNZxQHs+d8fMI4QABc5FiD8eusZfWaD4yvoYiyPpU1rSilYu8la5itQPGK
         eJIiZmIL+f74yPmzhEuo2TozEpzc/Pc+4X08I1iK49dByWprTTIvgBWyVjm2E1X5G4tl
         HneATwdSuqx0FaM8tjH07h2hC24GZiWYTyusWzrVEcmt6wOkThrr7JGcoctM4+rJkCgN
         RG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Aw0xblq4BURIKkKM1vvIoCHmuZeSHkoqslaiaMkPmbg=;
        b=ZjIVtboz0YG+dIFDhT2aF/u9Vh39rhSWpSLLqajwyiuttbpIuwXvdO/KWzSkK6Y0+G
         QlevqssZ8e7N0/95qq3wc9AriNTc/joWNKpTkN3D2WB8495SabZ4sABA/nsFIpx88UJ4
         ST6VjQUngk6qIdAeYZ0fa+AxjerdNLnvHkA7wdSwyrkXY0eZ8eQQiTReIA9dqPoizzHK
         EzosgM91cvSTFY1mAwLLGtIIJb21bSX34P/rlDSO9oRe0+8drxjmKPGtTdv6NSWSeSD/
         VZOOsIS4M9tQ5Juqro/a8nLCGEFVQ6+cQ7uHMwu5YU+yZk7OTdWv2OfZJ8fP7bM+PEcm
         D4Lg==
X-Gm-Message-State: ANhLgQ3Qkwc/lcy2yjeAko8rX1LrGDp4dW2mhxcvqtXjiJe7bklCK5SV
        jyFtQt1h2hbYMjmUk0AfkZnyu079gtZG6CiaEAL0iPL7/OSTDiPjGoxldXnUegcRDvgC3Qn+TMm
        f0Mg4K9gbSet8iZZl37dXrkTiZvOKRaJevJqy7JwFT2AM85wsahF7sye4vGKW8SczVx57fzhf+b
        C7
X-Google-Smtp-Source: ADFU+vsIMZ5EbcZgFL97EcPSCo3oWUjf0vhehmkkYqQ72BAEdMeJQIuhX0LluRrVMrRjoE1O78gHwaE/Bj9Anxq5yG9c
X-Received: by 2002:a17:90a:208:: with SMTP id c8mr4956509pjc.153.1584639883755;
 Thu, 19 Mar 2020 10:44:43 -0700 (PDT)
Date:   Thu, 19 Mar 2020 10:44:39 -0700
Message-Id: <20200319174439.230969-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [RFC PATCH] fetch-pack: lazy fetch using tree:0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support for partial clones with filtered trees was added in bc5975d24f
("list-objects-filter: implement filter tree:0", 2018-10-07), but
whenever a lazy fetch of a tree is done, besides the tree itself, some
other objects that it references are also fetched.

The "blob:none" filter was added to lazy fetches in 4c7f9567ea
("fetch-pack: exclude blobs when lazy-fetching trees", 2018-10-04) to
restrict blobs from being fetched, but it didn't restrict trees.
("tree:0", which would restrict all trees as well, wasn't added then
because "tree:0" was itself new and may not have been supported by Git
servers, as you can see from the dates of the commits.)

Now that "tree:0" has been supported in Git for a while, teach lazy
fetches to use "tree:0" instead of "blob:none".

(An alternative to doing this is to teach Git a new filter that only
returns exactly the objects requested, no more - but "tree:0" already
does that for us for now, hence this patch. If we were to support
filtering of commits in partial clones later, I think that specifying a
depth will work to restrict the commits returned, so we won't need an
additional filter anyway.)
---
This looks like a good change to me - in particular, it makes Git align
with the (in my opinion, reasonable) mental model that when we lazily
fetch something, we only fetch that thing. Some issues that I can think
about:

 - Some hosts like GitHub support some partial clone filters, but not
   "tree:0".
 - I haven't figured out the performance implications yet. If we want a
   tree, I think that we typically will want some of its subtrees, but
   not all.

Any thoughts?
---
 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 1734a573b0..655ec5d4a3 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1747,14 +1747,14 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		/*
 		 * The protocol does not support requesting that only the
 		 * wanted objects be sent, so approximate this by setting a
-		 * "blob:none" filter if no filter is already set. This works
-		 * for all object types: note that wanted blobs will still be
+		 * "tree:0" filter if no filter is already set. This works
+		 * for all object types: note that wanted blobs and trees will still be
 		 * sent because they are directly specified as a "want".
 		 *
 		 * NEEDSWORK: Add an option in the protocol to request that
 		 * only the wanted objects be sent, and implement it.
 		 */
-		parse_list_objects_filter(&args->filter_options, "blob:none");
+		parse_list_objects_filter(&args->filter_options, "tree:0");
 	}
 
 	if (version != protocol_v2 && !ref) {
-- 
2.25.1.696.g5e7596f4ac-goog

