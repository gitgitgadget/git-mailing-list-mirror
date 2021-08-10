Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC06C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED42460231
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhHJS32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhHJS3U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:29:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A333CC0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:28:58 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o13-20020a17090a9f8db0290176ab79fd33so2996875pjp.5
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+Vu0e8HWyExKevJfKr8agDTmd134b1/87ePU0sCd1Qw=;
        b=j2W99dLH5ND407pn3VDEDfr56C/B/+LrPcaUcUgKdCQyTMNDgS5gLxwaycFaBqRiNC
         EMKkpr2QZfpWelbelMVecHxK0cgfzi/fDjjkRQ7SRmTrpqH4XMpps6jNCsnmgrfuSW0G
         Admd4/TCK6+GkmnGlYW0hFQoE/oqwI/a+Z5R/lkIqv9CQ2fUlU/Dz1+gjvqr2LclPpae
         Y8DhGIuB21YXP5wbhBV59IOno11gVMB4dIJ4bb20EXpduRBbJqmlP6mZbFtnUOwIp2TX
         YXknw2fXD2EUpVpEGq6wrFyGQAnuXBIyTjIZ9bnzDvmep5zZIMheCrPlTNgZ18Ngys75
         z4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+Vu0e8HWyExKevJfKr8agDTmd134b1/87ePU0sCd1Qw=;
        b=ddbGLZdy4K+Ib0hgzGRHu+Zz9SoBNYR06hiKVEiGPaPRkosXreZTSr/r7mWfF1MD/r
         CxgMCF4DnikgqicGKzRAbwH4H83jLquMTaDtHI4RHPwKyqSvjWJeNiIkON42Fv4V7cvh
         tYQ357ZJ+W91BvNWefxI61y5mj5PN4MGid2Dy6FQrZ3HRI2RZuZ8NeKPU6YMJEw9gt0w
         0BVSwpG9tjeG+OHehZSpd0mZZupbapqQAoxd5NILLkEEfDzUOkxi3NLrmjgmSppcMzdL
         9AGSOgt03zCbehwrjCknZ5trXCQS8ja7hobbhJRaiXLZPGb1iAW0QmexabX7LhPyK6I0
         lIxw==
X-Gm-Message-State: AOAM532qco59Pr5ZY5TyRR0ZJ0SfEWXI5amJzSwPr6Nryd8OGilJ5ZOH
        dyb4ngb6L7PZdRGf8TMNikSM4LVotW8M8O+yttGSHXFtrlSCVvFh8yEUAjD8fYuYrW33Tlwvjpz
        N5s9Wk+nUD04+b9tBRFDrnSDrfUu2O7C0J/ZHEO/VsqLblnTMFPArc92g4BBqDTzM73yfoOQ4wt
        sm
X-Google-Smtp-Source: ABdhPJwPDfAX8vAASrmdZLnXcrz8GYZnmi66RxC6tVJFbxtwRyTYkZYP9bvywg01bi62dN0JKiirYOb0Ra89g9dKIER/
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:d4c3:b029:12c:e86f:63db with
 SMTP id o3-20020a170902d4c3b029012ce86f63dbmr24339518plg.18.1628620138028;
 Tue, 10 Aug 2021 11:28:58 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:28:42 -0700
In-Reply-To: <cover.1628618950.git.jonathantanmy@google.com>
Message-Id: <30ead880b38c5f572e609554b075ef81ff80ad87.1628618950.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 4/7] grep: read submodule entry with explicit repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace an existing parse_object_or_die() call (which implicitly works
on the_repository) with a function call that allows a repository to be
passed in. There is no such direct equivalent to parse_object_or_die(),
but we only need the type of the object, so replace with
oid_object_info().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/grep.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index e454335e9d..9e61c7c993 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -457,27 +457,27 @@ static int grep_submodule(struct grep_opt *opt,
 	subopt.repo = &subrepo;
 
 	if (oid) {
-		struct object *object;
+		enum object_type object_type;
 		struct tree_desc tree;
 		void *data;
 		unsigned long size;
 		struct strbuf base = STRBUF_INIT;
 
 		obj_read_lock();
-		object = parse_object_or_die(oid, NULL);
+		object_type = oid_object_info(&subrepo, oid, NULL);
 		obj_read_unlock();
 		data = read_object_with_reference(&subrepo,
-						  &object->oid, tree_type,
+						  oid, tree_type,
 						  &size, NULL);
 		if (!data)
-			die(_("unable to read tree (%s)"), oid_to_hex(&object->oid));
+			die(_("unable to read tree (%s)"), oid_to_hex(oid));
 
 		strbuf_addstr(&base, filename);
 		strbuf_addch(&base, '/');
 
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(&subopt, pathspec, &tree, &base, base.len,
-				object->type == OBJ_COMMIT);
+				object_type == OBJ_COMMIT);
 		strbuf_release(&base);
 		free(data);
 	} else {
-- 
2.33.0.rc1.237.g0d66db33f3-goog

