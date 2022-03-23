Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572BCC433FE
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbiCWJPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiCWJO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:14:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C72B75C02
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d19so1026426pfv.7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ooJNt+bsWMSp7XCYJM+O8W0comcFHRBzqpGSoo+IqNM=;
        b=WFkE6Nn+G+vwnBGuf0w0vtlDCtidaRZT/s1t3VhU4bAMLUdIzhtd0fs29VcVghlz5V
         T9YHMj1ELZothD7niCE6irJeOk3aWJbyaVJsIW9o3hjp/RSQ+W/zYZ+mEjLY5j5BOWJm
         GvQ3JUwKgk6nL1aRQJojdN1dgyPiCgEGwEBtyNxPk+z6KDqGmAVUhIek0xvLg+6BmO4J
         EjDksX/24qgwS2Zqmzi0B1SA5KRMSEL2iuwilOGUR8esl36kDw/mpgMgU2jYvWr2PZe+
         PK0hcKBpUcGYoCMkaD+660zQgqrD+jmqZcxnYIYnAexwBEFryTU2EizqcKQXB4pR7dVK
         /lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ooJNt+bsWMSp7XCYJM+O8W0comcFHRBzqpGSoo+IqNM=;
        b=Jbu+c2yncVvnEMgg2radiZzO/0e0qJnoL9AnOzqoai5RpsLh8KP6w+wJ7peTsr4cSM
         Hh2wmDBQilPFXYdtIZnRD1goJSGdoz85HoG+SwzbuwfwmHpsMvSN5IgovsX7sT9O5dgC
         anJPLVUEKPFOM1+S9kELm8BRTdapsMYaEQvNVxdA5+wwp/MRqU7taNJFypGbyvk7bBCo
         XzdtQNF6bMYyeK0LpJJyV8XnbxGrEVbREXAJrmVtt8WMhxtQEc/J0ZHD/HF9mfb8ZYYg
         0N7QN4xd4pOx8eVwVLyAJIq3RpAGiuVKCmiDqOZ7/18laSwqSqqq291fE1XS08N4grCM
         YUAQ==
X-Gm-Message-State: AOAM531J771jcvWsX7IKJOjF08Vepw9v5gSZPsnbecPzXTwXwLYNG6d+
        lFlkb5Wgj0OB4x4X7LwN6RE=
X-Google-Smtp-Source: ABdhPJzB915lrm9asPFuK/4Sv2FCgkDomhEveJ3GO77hLWakZdoCm05alk3Anma6MVjUk6oE20t7gA==
X-Received: by 2002:a63:4d5a:0:b0:381:eef7:33f8 with SMTP id n26-20020a634d5a000000b00381eef733f8mr25464419pgl.193.1648026807147;
        Wed, 23 Mar 2022 02:13:27 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:26 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 02/15] ls-tree: remove commented-out code
Date:   Wed, 23 Mar 2022 17:13:02 +0800
Message-Id: <02779bfd5d0e9aa216b48ff5f738c75d2882fbd3.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
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
2.34.1.404.g92931a4a2c.dirty

