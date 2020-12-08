Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABD5C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9987E23A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgLHAGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgLHAGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:06:34 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491FEC061794
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:05:48 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id i6so8222342otr.2
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/3ATCqzziAQFVwBi3ny+EmDvKvp43Oa289NvDRWL6DI=;
        b=WJE5/+PDOsdM5cx7TTmDZKVjZRkDLzTesBZdhNhsWGoGVqWasTo0FQz4DrlaRcBdup
         6yOnszfh/hL5B3hmKBen1TMkrAXx+AUAIhMI8XGUxX7SPh98bSaRC9/w4vVV7prQ0cm9
         vXJWCfV60+E8Fp3630QQFkQ2kb2O72bulDlPXpCgPMfqFPCvpwkYV6DbzNXfUZJKWCIz
         vUoh28TduATJl8KdkcSJC5mI3QyLjl+A1nf+TTtqKv3qvvplIarApEujzyrQm87rooAe
         wsMvI9nFD2wpeV3jUfFbITHlp0+qdWBiGcwmo7bDj4jPAOjNhch2K55qLPatp5F+yHBu
         50MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3ATCqzziAQFVwBi3ny+EmDvKvp43Oa289NvDRWL6DI=;
        b=g9cWJu4MCBCMFoZ5+L1DfO+9vzUgZA8AeN7FL0SAbuo5zKXkRgQ0TYUNnPlO4ngmfq
         IPGxPKP0P1TL98eA1EYMriCo2ls9E7SdK/QSGv88LtMwYb31CSj5YicVT1fORZ+sl2m1
         sDaatLQNrp7tx70hrG/HVa8kvfJZ/Wha9MSb9meNk209ta1oEQZZDe8CG1c1peQJiAn1
         478LtSYOxNdTkW/GL+d7OWC9OK1mAty8R8SXs7BY2kMYKjrNQOFPwbEMcu0Kn9E4B/la
         3eTFh8DWisre1YSmcw71RmxJ7iWpDp3uCeqXp0muCkwajbIep/tZYrZez+oogfbYcmoF
         KPqA==
X-Gm-Message-State: AOAM530rmUWN9BZzygs+7HPnMngCVAN5G0VBnNPag9H5swz7yNJYZY2k
        72YkymJ6hssDSeUQuzZ+6Y1KFLlQkDNoaGAj
X-Google-Smtp-Source: ABdhPJx8bIObmDKpvbNwnAuYC4EhKRmisXWXmWWfvp8jdlhjyh5zI0IlvuuWJN9qJGmRu8R3ZlVCgw==
X-Received: by 2002:a05:6830:1551:: with SMTP id l17mr14716154otp.279.1607385947425;
        Mon, 07 Dec 2020 16:05:47 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id u10sm3542348oig.54.2020.12.07.16.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:05:46 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:05:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 21/24] pack-bitmap: factor out 'add_commit_to_bitmap()'
Message-ID: <f0500190f02643aa5b88d58efe72f826bf616ade.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'find_objects()' currently needs to interact with the bitmaps khash
pretty closely. To make 'find_objects()' read a little more
straightforwardly, remove some of the khash-level details into a new
function that describes what it does: 'add_commit_to_bitmap()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5efb8af121..d88745fb02 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -521,6 +521,23 @@ static int should_include(struct commit *commit, void *_data)
 	return 1;
 }
 
+static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
+				struct bitmap **base,
+				struct commit *commit)
+{
+	struct ewah_bitmap *or_with = bitmap_for_commit(bitmap_git, commit);
+
+	if (!or_with)
+		return 0;
+
+	if (*base == NULL)
+		*base = ewah_to_bitmap(or_with);
+	else
+		bitmap_or_ewah(*base, or_with);
+
+	return 1;
+}
+
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
@@ -544,21 +561,10 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		struct object *object = roots->item;
 		roots = roots->next;
 
-		if (object->type == OBJ_COMMIT) {
-			khiter_t pos = kh_get_oid_map(bitmap_git->bitmaps, object->oid);
-
-			if (pos < kh_end(bitmap_git->bitmaps)) {
-				struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
-				struct ewah_bitmap *or_with = lookup_stored_bitmap(st);
-
-				if (base == NULL)
-					base = ewah_to_bitmap(or_with);
-				else
-					bitmap_or_ewah(base, or_with);
-
-				object->flags |= SEEN;
-				continue;
-			}
+		if (object->type == OBJ_COMMIT &&
+		    add_commit_to_bitmap(bitmap_git, &base, (struct commit *)object)) {
+			object->flags |= SEEN;
+			continue;
 		}
 
 		object_list_insert(object, &not_mapped);
-- 
2.29.2.533.g07db1f5344

