Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6CEC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D95B206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoTr+Uqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404799AbgFYMtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404764AbgFYMtB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6091DC061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so5713910wrm.4
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sooaKVhXSrJT5mgEU6o4Adku7L6SEhIg0nBV8aETOk=;
        b=OoTr+UqblIYiGOr5Rx1TBKfdRFcEos5ZaQwSOXLu30/UvsFS34sOds65j3Sfik9rKW
         T8Z+MZTwHfef4hEwiFS8uQJboFhJ8dbZS8ospcIhiJEFDWK7q549AH2iETgSHOjkZuM5
         hiWoctJxgEflQPh6ZPFufvn7e+1NzVJsNENvpkLE1GxXnela4dpRtLJij185i+E0vxBt
         rXB4qbakCnIvyiKn4OkwUMjuRd4j9xGcmEwzb9vQYd6gEiWSnCTGcPD8Lk18ceGAaQAA
         QwofEuzYHKdKcKgf2d5Fy60ecGWN4gqqcMROyCdtpM5TPKiE6O0/qqWSXOtqrUsnyIRW
         aFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sooaKVhXSrJT5mgEU6o4Adku7L6SEhIg0nBV8aETOk=;
        b=S1FdYttO9x66rkJL+ert94czPEbQv7gT+HdLkwDqvYwiujQbIbY3qTL116OO6Dqfe2
         2PKsAmcNOnpRMVwO5fKcAkmINoPjr+GWu8U132Zp3Xvp0szGqp0SmwZD2/BsER5Plxnc
         FqM3MQj47UC7DBU1Du2QhopI26Pfd7lX3VjU6g5Ab/7PF/t1ny+bm3L632B3SzbeBV0l
         BTF2E2PtKg0lnOlavgXP3FYpuZ/OpIEgQb5kkN1DjxB2qhy1yARXUuqqVYJt/CLExYOu
         1fWZEr681K4s51mqsTK2IQmlgaJVqPTGJFd/2nb/IUr6c08zMQRsO0h19JUWROhFLh6h
         +p3w==
X-Gm-Message-State: AOAM530zlALE8zHSGvxCcX4Hq0MgVQE+yQ7wkgwQ8MF9ZKuOmu3+ylPu
        qMKLN/rfx7ZWRHAED+cblguxFd1Z
X-Google-Smtp-Source: ABdhPJyiT4AiSIutscbXScwxiRKvnyPfvtuMkQwIJkJR6xVsWslV0IFcCfJoYVUl8bBz2EXchUCFbQ==
X-Received: by 2002:a5d:4607:: with SMTP id t7mr29238716wrq.251.1593089338574;
        Thu, 25 Jun 2020 05:48:58 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:48:58 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 04/17] merge-one-file: use error() instead of fprintf(stderr, ...)
Date:   Thu, 25 Jun 2020 14:19:40 +0200
Message-Id: <20200625121953.16991-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a handy helper function to display errors and return a value.
Use it instead of fprintf(stderr, ...).

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-one-file.c | 43 +++++++++++++---------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
index d9ebd820cb..d612885723 100644
--- a/builtin/merge-one-file.c
+++ b/builtin/merge-one-file.c
@@ -77,11 +77,9 @@ static int merge_one_file_deleted(const struct object_id *orig_blob,
 				  unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
 {
 	if ((our_blob && orig_mode != our_mode) ||
-	    (their_blob && orig_mode != their_mode)) {
-		fprintf(stderr, "ERROR: File %s deleted on one branch but had its\n", path);
-		fprintf(stderr, "ERROR: permissions changed on the other.\n");
-		return 1;
-	}
+	    (their_blob && orig_mode != their_mode))
+		return error(_("File %s deleted on one branch but had its "
+			       "permissions changed on the other."), path);
 
 	if (our_blob) {
 		printf("Removing %s\n", path);
@@ -146,19 +144,11 @@ static int do_merge_one_file(const struct object_id *orig_blob,
 	free(result.ptr);
 
 	if (ret) {
-		fprintf(stderr, "ERROR: ");
-
-		if (!orig_blob) {
-			fprintf(stderr, "content conflict");
-			if (our_mode != their_mode)
-				fprintf(stderr, ", ");
-		}
-
+		if (!orig_blob)
+			error(_("content conflict in %s"), path);
 		if (our_mode != their_mode)
-			fprintf(stderr, "permissions conflict: %o->%o,%o",
-				orig_mode, our_mode, their_mode);
-
-		fprintf(stderr, " in %s\n", path);
+			error(_("permission conflict: %o->%o,%o in %s"),
+			      orig_mode, our_mode, their_mode, path);
 
 		return 1;
 	}
@@ -181,22 +171,18 @@ static int merge_one_file(const struct object_id *orig_blob,
 	} else if (!orig_blob && !our_blob && their_blob) {
 		printf("Adding %s\n", path);
 
-		if (file_exists(path)) {
-			fprintf(stderr, "ERROR: untracked %s is overwritten by the merge.\n", path);
-			return 1;
-		}
+		if (file_exists(path))
+			return error(_("untracked %s is overwritten by the merge."), path);
 
 		if (add_to_index_cacheinfo(their_mode, their_blob, path))
 			return 1;
 		return checkout_from_index(path);
 	} else if (!orig_blob && our_blob && their_blob &&
 		   oideq(our_blob, their_blob)) {
-		if (our_mode != their_mode) {
-			fprintf(stderr, "ERROR: File %s added identically in both branches,", path);
-			fprintf(stderr, "ERROR: but permissions conflict %o->%o.\n",
-				our_mode, their_mode);
-			return 1;
-		}
+		if (our_mode != their_mode)
+			return error(_("File %s added identically in both branches, "
+				       "but permissions conflict %o->%o."),
+				     path, our_mode, their_mode);
 
 		printf("Adding %s\n", path);
 
@@ -216,9 +202,8 @@ static int merge_one_file(const struct object_id *orig_blob,
 		if (their_blob)
 			their_hex = oid_to_hex(their_blob);
 
-		fprintf(stderr, "ERROR: %s: Not handling case %s -> %s -> %s\n",
+		return error(_("%s: Not handling case %s -> %s -> %s"),
 			path, orig_hex, our_hex, their_hex);
-		return 1;
 	}
 
 	return 0;
-- 
2.27.0.139.gc9c318d6bf

