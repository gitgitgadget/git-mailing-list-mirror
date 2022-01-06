Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FB6C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 04:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiAFEbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiAFEbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 23:31:49 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB3BC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 20:31:49 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso1898952pjg.4
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 20:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8CyCo84CERA+hWqvBNuUUTSqg6HBUea36tRvi4YNpE=;
        b=UX0mTgM7cH41vb0A235UjosVTONCqE4b3+ayggZg06v51p3OLtI/NWS1eUetwYu8w/
         OwWIMI0swRbslnrtfYOaUi7sTwl0Rc+5phz3UC+zKuULYJaHhK99LGSYcaXlcOjl3g3G
         l7MfxecTLX3wbGWQZoZl3i5JFEVvUkbRE8VEAJpLHe+zbxi08XcFClLJdhnx8YNV0/VN
         Ufe40E/mlJQaq5F51HRY8sogymAhFmPEk9V1TnHqFkDTQnndzoFfYEVt1Mz+23iRtRqs
         aNqYKQBePnwqKPiuf5YmW+t0+Y4PCXpFu2ORGlwN5sH00arZ37mav5rb16Zi9OCoI4u+
         I2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8CyCo84CERA+hWqvBNuUUTSqg6HBUea36tRvi4YNpE=;
        b=EPsH9PYCWLlQ+X+FRdmkE7KDa/tfRg0EVBGZ58TrYeXiNQnOG45pIADng1moEYWk+M
         TqaW6M+Dz9tveiGZFiegNDsTpkyVsbXxKFsqQs/yDD6zs/7TViLNEs6tru/gT1dkqp7h
         BDaUi4CMc8GEI2lOruqiczP53Y+uz7IJZh/isbzB2iJ6e6GZFj4V577V74aj2dCEW3NF
         aBoXe9Tnfg7CWscCfw0TsOmSnpeHoQa1Q228ktAgYZ41zfSyWDhR4OTlDfDr3lcbKk/V
         YX9tGJf5gJn8rdrW/2G8i1O3PG5c0uhX3KaShuc2jeLskV/avzYyMBbjtSXOkljdSnL4
         j7Dw==
X-Gm-Message-State: AOAM533lJTllAh0t+moekub5Nij8fxxN1P/B8YwXlEByZOjX/etzQ1lF
        ifRDkIpmIfWDZQZ2PKdIHZw=
X-Google-Smtp-Source: ABdhPJzPfZk/MrI401S31C2AFH0+WAJqjHBMgHXi1vp0pVGUjrULkZt0u3GkmzoeYcLlHhy9cqojRQ==
X-Received: by 2002:a17:902:d484:b0:149:95f1:fcd8 with SMTP id c4-20020a170902d48400b0014995f1fcd8mr37764057plg.41.1641443509065;
        Wed, 05 Jan 2022 20:31:49 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id 13sm636491pfm.161.2022.01.05.20.31.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 20:31:48 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v9 1/9] ls-tree: remove commented-out code
Date:   Thu,  6 Jan 2022 12:31:24 +0800
Message-Id: <2fcff7e0d40255e0be9496647787352dd0aeb784.1641440700.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1794.g2ae0a9cb82
In-Reply-To: <cover.1641440700.git.dyroneteng@gmail.com>
References: <cover.1641440700.git.dyroneteng@gmail.com>
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
2.33.0.rc1.1794.g2ae0a9cb82

