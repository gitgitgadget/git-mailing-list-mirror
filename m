Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AC4C433E4
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A1522CB3
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJNjS5KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGUAV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgGUAV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 20:21:56 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3331FC061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 17:21:56 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w15so1274441qti.21
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L0aPD88pOTPg0jsBwZgMfbN+v9Vp0+/UFSZPuIUO/78=;
        b=MJNjS5KXmuZdHV8OHtXoW3v0fpxA8wDiriPT7EC8oA944pNg0iSOauEc7jqnGh5Yt/
         Htwek8WybtoHNlbGgp5ui9dm8D63qaA3oMQMr89ywTnm4sTbpbfSEY8+Ean4LKjRvDFJ
         WFOAVwG6FcjQcM6trUdKmlUDyAUXpRZhaZ/0e3luG1WE1JXGZ1/HBkBe5Hi2iK44K1p4
         yqxuQEAqYQyCaiDapyNUiYTvI/Lyyl/WqjU5FlmhNbcBwLx2GtnoUlYoibCKLYb180ld
         ULdBbEpBpiAlPNg4KTwUKwn/4cZgVJq9LZSjP0bB7mGcHX4m9pLB7Fh0xo6oQRU//UOC
         /HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L0aPD88pOTPg0jsBwZgMfbN+v9Vp0+/UFSZPuIUO/78=;
        b=V4gXm7beFbAOTr2ZTJ0/FzAChQ+XgZ4jB5gmOnQGXs3YhoQOBOhjU7lnvZ28EJCb/F
         Z+BCAIgUF8j16xXReocVVXQlqpvn6V3bPyBL6DzTIfnH4QHOBxi8Z6lPk4gkGJOU0PV7
         UqvbkKbPAcW4Up+T/aWYtIvyWvj9D0Ubw3dXEDB141o5C3VhwEJ/kI+5PEpuTTMH/rzs
         ECq+MpWeYVFAa1hvUAvmfnseD2ZHzYjBnmTLfV86kV9RrzBfEb2E5HOJz1MWH+v9ijRn
         CsGAvMgMn3+HswHlcaQpFLTS2UpU55miju//earZwM6wNnZKfi6/S8Xkb7+9Z59/nFL8
         59/A==
X-Gm-Message-State: AOAM5303i+cBFYd+1Krt0L7Dhf+9V9btJGf0yxvkM5cGZ/gFSlZoLfLh
        qWGZYM5izMveqpUdGMwog3x/IKFOnBqAs6fUL3B7s/hXSuBHD5sNMRz2YmwfsNsXKGCfC8qDTyD
        vO9+S569IyQH5Q36NoSKaOuVCZzig3fQswDnsQKWymjrEpvW4RpKa2BK3zN+zmvelrt/kZt8Pug
        h7
X-Google-Smtp-Source: ABdhPJxE47WSnOdqDxMi8nDd5J479wRDiE8mCVknLBt/rkKNKocGJlT7Iphe7ivmSr9ALfwUmU5r3/SjxiNsLlEd6RDV
X-Received: by 2002:a05:6214:178c:: with SMTP id ct12mr24394334qvb.64.1595290915252;
 Mon, 20 Jul 2020 17:21:55 -0700 (PDT)
Date:   Mon, 20 Jul 2020 17:21:44 -0700
In-Reply-To: <cover.1595290841.git.jonathantanmy@google.com>
Message-Id: <b87764b711621ea3c614dbc8f9e49a8598a25cb1.1595290841.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1595290841.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 2/2] pack-objects: prefetch objects to be packed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sluongng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an object to be packed is noticed to be missing, prefetch all
to-be-packed objects in one batch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
There have been recent discussions about using QUICK whenever we use
SKIP_FETCH_OBJECT. I don't think it fully applies here, since here we
fully expect the object to be present in the non-partial-clone case.
Having said that, I wouldn't be opposed to adding QUICK and then, if the
object read fails and if the repo is not a partial clone, to retry the
object load (before setting the type to -1).
---
 builtin/pack-objects.c | 36 ++++++++++++++++++++++++++++++++----
 t/t5300-pack-object.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e09d140eed..ecef5cda44 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -35,6 +35,7 @@
 #include "midx.h"
 #include "trace2.h"
 #include "shallow.h"
+#include "promisor-remote.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
@@ -1704,7 +1705,26 @@ static int can_reuse_delta(const struct object_id *base_oid,
 	return 0;
 }
 
-static void check_object(struct object_entry *entry)
+static void prefetch_to_pack(uint32_t object_index_start) {
+	struct oid_array to_fetch = OID_ARRAY_INIT;
+	uint32_t i;
+
+	for (i = object_index_start; i < to_pack.nr_objects; i++) {
+		struct object_entry *entry = to_pack.objects + i;
+
+		if (!oid_object_info_extended(the_repository,
+					      &entry->idx.oid,
+					      NULL,
+					      OBJECT_INFO_FOR_PREFETCH))
+			continue;
+		oid_array_append(&to_fetch, &entry->idx.oid);
+	}
+	promisor_remote_get_direct(the_repository,
+				   to_fetch.oid, to_fetch.nr);
+	oid_array_clear(&to_fetch);
+}
+
+static void check_object(struct object_entry *entry, uint32_t object_index)
 {
 	unsigned long canonical_size;
 	enum object_type type;
@@ -1843,8 +1863,16 @@ static void check_object(struct object_entry *entry)
 	}
 
 	if (oid_object_info_extended(the_repository, &entry->idx.oid, &oi,
-				     OBJECT_INFO_LOOKUP_REPLACE) < 0)
-		type = -1;
+				     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0) {
+		if (has_promisor_remote()) {
+			prefetch_to_pack(object_index);
+			if (oid_object_info_extended(the_repository, &entry->idx.oid, &oi,
+						     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0)
+				type = -1;
+		} else {
+			type = -1;
+		}
+	}
 	oe_set_type(entry, type);
 	if (entry->type_valid) {
 		SET_SIZE(entry, canonical_size);
@@ -2065,7 +2093,7 @@ static void get_object_details(void)
 
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
-		check_object(entry);
+		check_object(entry, i);
 		if (entry->type_valid &&
 		    oe_size_greater_than(&to_pack, entry, big_file_threshold))
 			entry->no_try_delta = 1;
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 746cdb626e..d553d0ca46 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -497,4 +497,40 @@ test_expect_success 'make sure index-pack detects the SHA1 collision (large blob
 	)
 '
 
+test_expect_success 'prefetch objects' '
+	rm -rf server client &&
+
+	git init server &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server protocol.version 2 &&
+
+	echo one >server/one &&
+	git -C server add one &&
+	git -C server commit -m one &&
+	git -C server branch one_branch &&
+
+	echo two_a >server/two_a &&
+	echo two_b >server/two_b &&
+	git -C server add two_a two_b &&
+	git -C server commit -m two &&
+
+	echo three >server/three &&
+	git -C server add three &&
+	git -C server commit -m three &&
+	git -C server branch three_branch &&
+
+	# Clone, fetch "two" with blobs excluded, and re-push it. This requires
+	# the client to have the blobs of "two" - verify that these are
+	# prefetched in one batch.
+	git clone --filter=blob:none --single-branch -b one_branch \
+		"file://$(pwd)/server" client &&
+	test_config -C client protocol.version 2 &&
+	TWO=$(git -C server rev-parse three_branch^) &&
+	git -C client fetch --filter=blob:none origin "$TWO" &&
+	GIT_TRACE_PACKET=$(pwd)/trace git -C client push origin "$TWO":refs/heads/two_branch &&
+	grep "git> done" trace >donelines &&
+	test_line_count = 1 donelines
+'
+
 test_done
-- 
2.28.0.rc0.105.gf9edc3c819-goog

