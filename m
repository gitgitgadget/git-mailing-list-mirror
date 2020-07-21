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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18089C433E1
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 22:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D022073A
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 22:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mariqvrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgGUWu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUWu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 18:50:26 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A246EC061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 15:50:26 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id bf1so137117pjb.6
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=akUrN13DfTPdgY8IsXu9JPDplsedQtku5tHYpgata5Q=;
        b=mariqvrWRfxpNrWwnU0eE9REX4M0fSFXwkin5sGhsJcaeEv4YY+J1TvgQTCKRQWfMF
         mQUX827z+kSEhIPfRXVIGmhxhSVS0Zeva0P0px32KBW+vcc+BorcNWfnBWhKtiPDV+kW
         CX9pweJP3y4PftowYTgtCOgYxDvt7l5a0RjX9/NVaTEEqx2Mv2CFQxHoMDJU5FxWMWq1
         EmJ8WVMhfHuPMWXfHySqkZOyefoe6CmKMDIYVwFWZevjayJk2D+yH+9mXrkBzraJoeOO
         wP+MpcT2c2gC3omyLlBlLnS9azkqyb7EUeb2O3J39j44QRlyWLtrmwoeAvnqZMXYWZeV
         AkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=akUrN13DfTPdgY8IsXu9JPDplsedQtku5tHYpgata5Q=;
        b=Hly2sN/0d9N5ZMT9JbJqEEn+Brw4o2FOsD1jZriOC5pAG1WcMkZLpfSBKIYquAW9GQ
         zHsDxuZuymSjB3cEdP4rlkK4aHEvc/Nyy5oqfCoPkTkI+6LYDMsE4Xmb4X3BoodA1m+v
         IlQjNkKyqN6dOLOXhtBRC0VTFTgDakE5elp3llFA5l88dpD3Sh6Iiekpk5XPGlbgyu/+
         kgsgZnm504/F/gumzMumxVjvsq98riFUBJHmgXpcc5M4dxBWjtnCLXX3BPXVH0ACog1G
         iWkOBsQTrL0OHzhDo2/nICvBzmLMIweIqh20jkQCXVJEwHkl+h0zU5z9oC9P8CRNJSRa
         pgQw==
X-Gm-Message-State: AOAM5325QrKJSuUg5M87SUeTsdpWYJmOj0WMxeEhDWtzUOL70iKTfkOW
        RUKLAV0J4K1y0Tw2HHaxrPUCi9Ab6iulYUMyX0y+yCc5W437EkOqoixrhBOvGfj+hiCc5uou83B
        I5RW6Q3kAm5Kqap7322PETDKeiLPBy+5yT744o0SY6gW5jqlE9U3HWgrnAkoNaSYgQhWUReqiwl
        6o
X-Google-Smtp-Source: ABdhPJzpVgNEDdMf+zjGg+k0VK1QPlErU81VJlk04k3RrKQOd0DN+H+u8L48X2YR582+QYDi/LURFC98eMPVkwZV+WZy
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr746975pjz.1.1595371825707;
 Tue, 21 Jul 2020 15:50:25 -0700 (PDT)
Date:   Tue, 21 Jul 2020 15:50:20 -0700
Message-Id: <20200721225020.1352772-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH] sha1-file: make pretend_object_file() not prefetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pretend_object_file() is invoked with an object that does not exist
(as is the typical case), there is no need to fetch anything from the
promisor remote, because the caller already knows what the object is
supposed to contain. Therefore, suppress the fetch. (The
OBJECT_INFO_QUICK flag is added for the same reason.)

This was noticed at $DAYJOB when "blame" was run on a file that had
uncommitted modifications.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is another instance of the issue Junio raised here [1]:

> Fixing issues hit by real users reactively is a necessary and good
> thing, but this is not the first time we patch callers of
> has_object_file() for this kind of "we are merely trying to
> determine the boundary of what we have, so that we know what we need
> to add to this repository" queries, I am afraid.
>
> Perhaps it is a good idea to sweep all the hits from "git grep -e
> has_object_file \*.c" and audit the codebase to see if there are
> other problematic ones?

To make progress towards solving this, I'm thinking of making a new
function has_object() that takes a repository, an object ID, and flags,
and only supports one flag: HAS_OBJECT_RECHECK_PACKED (which has the
opposite meaning of OBJECT_INFO_QUICK). Checks that should not fetch
should use has_object(), and checks that should fetch (if they exist - I
think that most would want additional information about the object, so
they would use oid_object_info() or similar already) should use
oid_object_info() or a similar function. That way we can see how many
uses of has_object_file() we have checked, and at the same time make
behavior we usually want into the default behavior. Any opinions?

[1] https://lore.kernel.org/git/xmqqpn8wie21.fsf@gitster.c.googlers.com/
---
 sha1-file.c      |  3 ++-
 t/t8002-blame.sh | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/sha1-file.c b/sha1-file.c
index ccd34dd9e8..45fdb8415c 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1600,7 +1600,8 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 	struct cached_object *co;
 
 	hash_object_file(the_hash_algo, buf, len, type_name(type), oid);
-	if (has_object_file(oid) || find_cached_object(oid))
+	if (has_object_file_with_flags(oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
+	    find_cached_object(oid))
 		return 0;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
 	co = &cached_objects[cached_object_nr++];
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index eea048e52c..2ed6aaae35 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -122,4 +122,15 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git blame --exclude-promisor-objects one
 '
 
+test_expect_success 'blame with uncommitted edits in partial clone does not crash' '
+	git init server &&
+	echo foo >server/file.txt &&
+	git -C server add file.txt &&
+	git -C server commit -m file &&
+
+	git clone --filter=blob:none "file://$(pwd)/server" client &&
+	echo bar >>client/file.txt &&
+	git -C client blame file.txt
+'
+
 test_done
-- 
2.28.0.rc0.105.gf9edc3c819-goog

