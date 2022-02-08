Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE93C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359587AbiBHNOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350205AbiBHMOu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:14:50 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1053DC03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:14:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x4so6090477plb.4
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ffNNihJnqCbLjL8fklpTgd0y3rLXxhaHEiiAvRIvao=;
        b=MRCDwcCsdNjwvXNSBafn94z76+LGbn95sCDizB55n8lAkKBW85MljQxISZ/7fcRc6S
         95yQ2TUEQgW8CSukI8isTvM+TqZ+CGvcNOnzJouYKPTcbPhzJYg/kXWTbx3UaQKIXkom
         vg0TmNFHf6YpSAFdYA6Z4I+DFZcb0viDVGRO+htxPA7pjn3l5LEI2CnQZ2nQaNir+tjj
         3RQNlPQ07ImULDU5tkaioj16Jk7x2yBRDnf1ncaX8z0cioAyQMy9XnBUi1KmAA3L2wjO
         E34VjpNH61TogETKbZhX/OZgq8bq5EICNeZkuVyDhFGpV+4dUtQx15foLZHNL34+pqur
         M1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ffNNihJnqCbLjL8fklpTgd0y3rLXxhaHEiiAvRIvao=;
        b=UrhInmy/jlTWtMGk5E4I95Oww1cUoz2T66FU3ZnQ6qufk7n3eP7PiqwtHBcSdPkwYg
         DABslQzcZIfeMYEJlBZ1j+Y8KGtT2DeYPU7COtX+3kYEZOa4PXap+8WUNhuJ6ecKA4HE
         4rqDcQYb29d0DfuZlA5TtODhQn3Xqrj/5wdGp4NCWF/r9YIXBcU4xkh66fPWXaVPDolw
         ioSr/+sFF3DUvFiad49rCDEPncZmO1deiJbH977nyPw02COzLmks3oQ6tB6Zmhm56i3h
         kXVBijMp32tf6Gb24erBRfGRb4L6ascYNYKT1VArprMo56+6WFJvm2Rx185WAhqdtidK
         RFvw==
X-Gm-Message-State: AOAM530iYu4ln1tYfv8mRAq+efUMhEPLcckZOh/+9E2a3Cy/tPxSXiUa
        Gc2qUiqbGHOpeGOqpY3X0sw=
X-Google-Smtp-Source: ABdhPJxPIfFjev9loyK5Js06o8Pte2o1DpzBUuotM0pJ/Qk3yUaW0aM7l+YETGJBrg2lvgkXK/TFIw==
X-Received: by 2002:a17:90b:3808:: with SMTP id mq8mr1033929pjb.203.1644322488576;
        Tue, 08 Feb 2022 04:14:48 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.14.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:14:48 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v11 01/13] ls-tree: remove commented-out code
Date:   Tue,  8 Feb 2022 20:14:26 +0800
Message-Id: <2fcff7e0d40255e0be9496647787352dd0aeb784.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
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
2.34.1.403.gb35f2687cf.dirty

