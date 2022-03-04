Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39812C433FE
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbiCDKnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiCDKnr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:43:47 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9966C1AAFF8
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:42:59 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 195so7192398pgc.6
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkkPlODKXHWQMMMa3BFGHFvscvruy/TjX1sgmxzPenc=;
        b=oxL80QJoosSH6V/0ZSoVDWKi3yrXMO7Kh7Wp+Ovu5WtraJAgBCgGNJBJ30vj3qbx03
         A59akjwO5E7ruGWLPN9kLy8Dd0U85OJOkVb9srtfiXdbJS7nA/Rn2Qx+uEtpPZNT3Be3
         B3OXMhwGTgSoCID31iTXfhCCigvubcWCOeYsVWnM+Zlr31phMGyEugxYco9GTLCljZn1
         Ybk+PNqoBZri5Y8ekh/9YeA+EyrfLnK0JZZmK4xzZz1ep1VPcN4APbY9hfT46NTvJ3sm
         0ul1snlZBIvGKbLx2N+99+L7yMDadUADq0CFDWsavGflmGdNWNx8EcEcGf6Pf77T6cU8
         FomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkkPlODKXHWQMMMa3BFGHFvscvruy/TjX1sgmxzPenc=;
        b=y0B6fqYP097aXjR4gLD5JJal/VPSDDsfbJ0x3bvUb+sg2G6QvKLVpfoAMaqBNArxdF
         +uD/VR7BrrOybzmKs1uBqVpMzIpLGJiDaaQMGy6XRCcZFunFIKm+QeDBrndM1n/B7hFk
         6BQIg0ScmY3/pdD1IqoYfoMQWuTn/j9jJFzMgO2bZA4R3HztkdmN20NSue0UzwhHuiUS
         u4DXSJ6ZOLQiEb4eKrRgUmd825hOdK5zvfh6NP6zC9Cv2M8xiRK+beaYGLlIXUeDb6n0
         z8HRkcZcOgt3q/tkAiL5rEWabPmy0ZuTivDxJ56BTQXC5Jnu4jimr6okuoASSwKM7B2r
         Iniw==
X-Gm-Message-State: AOAM5317BALUUoMGLuI0CAikMeaWyVIWCwkXvbN2wD+PhwcdtagtIECA
        SKC5bloDvSSfTNX0usUbe8o=
X-Google-Smtp-Source: ABdhPJzVQ8Pi01KdspTmU7DWbOWo+OpIV5cEWp0N0Qa1zRYwyt3eI6GBxQIPjJJeRn2VSUsc2VrHNQ==
X-Received: by 2002:a05:6a00:1ad3:b0:4e1:5623:fdd with SMTP id f19-20020a056a001ad300b004e156230fddmr42880990pfv.26.1646390579097;
        Fri, 04 Mar 2022 02:42:59 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.42.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:42:58 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v12 01/12] ls-tree: remove commented-out code
Date:   Fri,  4 Mar 2022 18:42:27 +0800
Message-Id: <2fcff7e0d40255e0be9496647787352dd0aeb784.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
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
2.34.1.402.gef0f5bd184

