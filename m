Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885DD1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeJFEcY (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:32:24 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:41749 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJFEcY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:32:24 -0400
Received: by mail-yw1-f74.google.com with SMTP id d23-v6so8280774ywd.8
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eo+qxEhYTUv3+lsEELI+YrG0h/e6PzpHh4BhzyK/WVc=;
        b=ETYmtsedM9mqSAX+wVOWfEJmpcRlDSPUgT2ISTsO96hzXPzH/uXklVb3JCU01TsvhM
         8oedMY16g89zj3LaFUKDbEkkuhoQbjtpl8JTIrj61GCCBruyjMP+akeI9Wj4t4NE5zC7
         7Doy4I5p1+gQDlp+8V20CfxSASGOeVJOYQlRzvGfFBXLy+j8yts2m1PdpeNaVK8YNclZ
         W/nXsrqsEKio9Zk1lK5ZjjBNe3BbxePv2y1C+yoAn5S2lWbwisUHhu4YjWQWvIyhoNiw
         RpO8KiCvyUHbIdKgilzsTogw5Lqm3RDqjZZVyC5cPz33WcvPkn2Dx3gl+zXvXWb2K8Fs
         K0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eo+qxEhYTUv3+lsEELI+YrG0h/e6PzpHh4BhzyK/WVc=;
        b=XhFPhAGj9bTYYNKRBw/SMmiD16u0BLF+da78iCHYwYPBk9/outfnfQv2JoOYGsfMD8
         rXVndkINTcSoopHBisNQUauv8ImGkYfEe7TAFKTjTP91FOLBobe2AMOjoB29XRX5iT9q
         UVl7MDposbVoHOrYV2Y0kFsq8Q9QzzYCi37kFqlYeo48XRDW51H2dX9lzPZRMqHHdMvf
         5ST1XQV9Yv4Q0aIu8RoFaYc4g8QibvuMYumyUtL4VgtyxVcPICCkf8SSw0JdhHg6MAsw
         k/vNJ3ARsRiVwnsVB9o+7AoG3+acxi8VqzT1+hQj5Ar3hjctbcp2Qt97/4R+Y52rWBk8
         sLwA==
X-Gm-Message-State: ABuFfoi3gny9l6vFQj8EvguLrpRmhtuvmQVi0p4mB7WN5V6FydfRQV9P
        GxwuMXIJkn4ubgZNKv+DWRE79JNBrgnBerfGG/ywBKxHjf0RHFx+XJNwKCZTJTAIcZ25gbZbbbw
        UAOCCF1acpvyxvDT9HQSGfWhzASI3XogVrZKECO0C56byM4wVMpEfgdFBdks=
X-Google-Smtp-Source: ACcGV61idjskI2uLtfqVa30PecLJxgbzbU6qbHUJyZYItVWc4IQL6pXalHBgqZoM2H1H3VMUqIuFKgw00Y8A
X-Received: by 2002:a25:bdc8:: with SMTP id g8-v6mr7943362ybk.101.1538775110120;
 Fri, 05 Oct 2018 14:31:50 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:31:25 -0700
In-Reply-To: <cover.1538774738.git.matvore@google.com>
Message-Id: <5b337881c3b6cf0f7a9483e578f613f59c609c44.1538774738.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1538774738.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v11 6/8] list-objects-filter: use BUG rather than die
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases in this file, BUG makes more sense than die. In such
cases, a we get there from a coding error rather than a user error.

'return' has been removed following some instances of BUG since BUG does
not return.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index a0ba78b20..5f8b1a002 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -44,8 +44,7 @@ static enum list_objects_filter_result filter_blobs_none(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -102,8 +101,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -208,8 +206,7 @@ static enum list_objects_filter_result filter_sparse(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -389,7 +386,7 @@ void *list_objects_filter__init(
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
 
 	if (filter_options->choice >= LOFC__COUNT)
-		die("invalid list-objects filter choice: %d",
+		BUG("invalid list-objects filter choice: %d",
 		    filter_options->choice);
 
 	init_fn = s_filters[filter_options->choice];
-- 
2.19.0.605.g01d371f741-goog

