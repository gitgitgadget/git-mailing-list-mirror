Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2E51F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 20:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJMDhC (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 23:37:02 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:46750 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJMDhB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 23:37:01 -0400
Received: by mail-qk1-f201.google.com with SMTP id p128-v6so12901130qke.13
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=28VDdY616D/cCKWwfi9l1wVomTdVaoYFRuyHjWokAPY=;
        b=Ysl1KOeBg9FpP0bl0EPhxxB1CsdSUb50uRQGmueKQMrC9JGg7NFAVonQwia9xJmrpu
         YoRM8L9cChqHP/6JMs5MJJ6bUkvbVtCpy0470kDC1ssqo45ZC0G/DCKo64R1YpCLw5BZ
         QhDYbODeHH10C/9pC/1+YQjdnTfbsZr7tlVS/P8ICtp4y5SXXMG0ywIk/3s/hwsfGe//
         /xszvcMS44WtPL6OafhtPeIIY0gbm6aV9aQFSq/3YBQMcBoS8l12GcqYZTEyTCpzOsVp
         1bLZUb+KI0YF4e7ndPWvQ7sUhVsonnybavVg8QB83Tdy2x2gkxlhGVVHkGcDB+ImE1MH
         NRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=28VDdY616D/cCKWwfi9l1wVomTdVaoYFRuyHjWokAPY=;
        b=tfntiDh3veAdr1kty+6w7BM7C7h5vH3ncBrLumR8Vrf1kin/4CZw9os5gcgapH8rij
         homD4QSySesjyaHzzDyAUU435zXlpqCVz0RLzTQlnSglX4nuARF1dkERyK7eLkVkEFFD
         pOz9ivyt0FV6HdMV1BF3DeS8b7fXYKhVUIOkqQiZTnukVDJ/Quvx1Hkd8XH8spO9J1Q/
         LwIymNqfJOLoi6Al8jlyYYJpDl0EYNWC+2WZZx15TNuUs6ZsYtwXDiywafCeWMQ8OWPY
         STknzHWMPekRWsLSdk7WczD9OHxyH6bCo794CaDtqu2pawaIiT9J38TJkNjgHvkKrCkb
         Lhmw==
X-Gm-Message-State: ABuFfojz0gNC1FbvaOl+pEyRgqkYzgQbHBGvLf22uv1THNTk5QtA62rk
        E2H4uJLle4bUK6UhF1fjLWuCgPlO1CmJoX1OMtFFjAx9tDwo6sObHuIjVPszyHyu1FIx0ya1P/Z
        ppBadrx6xLCKZSj1mSCPe2h5p3x+2G+IccCQLRjjZf59QfMLHzf9PivYQg00=
X-Google-Smtp-Source: ACcGV62fg2bexmTlnPXw9/bwHpVcc4Thm+jrcvyGPk9tNkxWa1RUyzxrYbWcSsqGnAC6kmnYaBka1J1evbzM
X-Received: by 2002:ac8:7108:: with SMTP id z8-v6mr6288515qto.56.1539374574005;
 Fri, 12 Oct 2018 13:02:54 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:01:47 -0700
In-Reply-To: <cover.1539373969.git.matvore@google.com>
Message-Id: <65e48449b387a427c94117a76791656a4bfdb977.1539373969.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1539373969.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH v12 6/8] list-objects-filter: use BUG rather than die
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
2.19.1.331.ge82ca0e54c-goog

