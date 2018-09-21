Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E2651F453
	for <e@80x24.org>; Fri, 21 Sep 2018 20:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391513AbeIVCXI (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 22:23:08 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41036 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391426AbeIVCXI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 22:23:08 -0400
Received: by mail-pf1-f201.google.com with SMTP id u13-v6so6965210pfm.8
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 13:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fb1ZOsUg8OZt+qOtOwoizl8zOK6GtkO7XgtEA0jfOxM=;
        b=sj2PoxYuSaVAuQn4o4DQ2SmpbKzDIcg3LlE4kbGT86pc5i7Jv5C5xrQsTqhu6s4+Ei
         bTboFXa2xjAmTKWWvpxxdjPVBux/oGJBRhpVU52+DsPnfFp9nV7Z0NObpjl8YoFtOb7e
         1ch7ZDfRZ8l7KBDcYx9BbxA5GtgGcNvkzJ7a1evGt4gk1SNRCpClQRthy9MwzvCalQHX
         bXUbGL8iDeIKV6ATIXPep/rynr9F6+ex0FO7/qguooj44UMz5mopzAr/994+sg8tiNjS
         e334YcjwMcfSgnsEpu+719E1gIOCGQ5lb25nEvj6P0dz5c0QzqsqCuiOHKc5cJkFhzPn
         Q4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fb1ZOsUg8OZt+qOtOwoizl8zOK6GtkO7XgtEA0jfOxM=;
        b=uTLj6bVbteIG2x7x8H7phqAwmoR+HRtv/At8l7HY98CYk+RFTuMHYn32GOh+YpvIoJ
         YT/2xggRYAjUEZLmpNd8AhG15E5PfYOjc+waiGlZll6Rq9Ar2icHYmIRfFIJmxrFpN6l
         uhDEAOIBZiG2/p/plStkBgFpOexFtYYACmeyk5W94pmcpbbWmIcriX+HegLFqOCy0ecs
         OTII3EN1WNJ+vzteOmjHOWIWefPP50j4Llb81TVvlgoiFqrguVYSDnSCYBOvpcq6S/bV
         V6a0+/MVUFiQfiL5oS96nmvj1bmizvdtftLorXBwvTFdr92HN6YlWB+Og+1m9Py/coqQ
         Ov2w==
X-Gm-Message-State: APzg51AGRmWLJiHgwgHOZMNpK59EiZTBktVNDeiXmpSgT+ZkHvnC5KDp
        VI6833fobCIcaN48UhTpkQeuV3LWdn1ui3vgTE+JazsAQYx/k31qlaC9xFQVPxQvegdXS/W4xXF
        wl/YIW/h4F0yeO3CPqiC33xHuRj3cEuAH4LlVWqzUsP3u4OjIpUus60NqKxY=
X-Google-Smtp-Source: ANB0VdYTj39oEbMyIBWU6lrCjWzJRwfNMer46DP7EDOADlOMwFuy2JEpxNN6O1fDxwIooUzx1avvt7Ucf7e0
X-Received: by 2002:a62:c016:: with SMTP id x22-v6mr2981261pff.56.1537561956555;
 Fri, 21 Sep 2018 13:32:36 -0700 (PDT)
Date:   Fri, 21 Sep 2018 13:32:02 -0700
In-Reply-To: <cover.1537561420.git.matvore@google.com>
Message-Id: <a16413f2388ef2d08448e4326c0f010a0b81501b.1537561420.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1537561420.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v9 6/8] list-objects-filter: use BUG rather than die
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
2.19.0.444.g18242da7ef-goog

