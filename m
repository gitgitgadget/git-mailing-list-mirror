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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A8C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597B161168
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhIUQwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhIUQwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:52:47 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731E0C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id p75-20020a0c90d1000000b0037efc8547d4so77512355qvp.16
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5k53Oe1cPxBEVX28aZwTlKMNCC6Icjyz2KTay6HzpkU=;
        b=q+XBe4FPENVgTWQGzWSeM+/KNQYx+U7zyUKoqcA5wEZupl9Aznb+QzebknycPzWXES
         ldjZAS67N28iNVycUdxp8EQLfn5+JK/mnqHffE9T1D+QjE7RuRVZVW/yAwDpnFKflSje
         hgGua3+t+uoIay5dx/ePoIQHMtxTVO4Pl/MJKlaYVFJ3ugnYHaFkfBhSaJsOHSgQAvAK
         V8Mv85CYvUhvzEFvZkD3EVG/8Heud5PT2y3n32jKhGOCY2j1P3HRSB6t6XPcCTu6hg1e
         AMiVAL+a121xHNSEyoGpo4LR24nKhTSngCg3BOC2+TEjwU+xorJ5KgmQi3Ugv3U0iKz3
         8Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5k53Oe1cPxBEVX28aZwTlKMNCC6Icjyz2KTay6HzpkU=;
        b=AmkHrOb1RVjUoe7kc3hwS/LRaGgtxBHyTnDNuJt8kjX26uqj6igwkfTrerZMB0S2WF
         lXb5C4GQYht9ThmbohURD21+iw0G36x6Lb13oLW3iPwXtk0o5b9cVhXOWYkwFo6OzcrI
         xtiggfoCwXTYEopn5DrYFKOfaDkSjeEcLBRLbD03aHyop3jcZ36g1OtNqLT+3JT/HCcK
         HrvMmgHKBc5TKEyyy0k7jEBa9kCUkyDOP+WFBUrnPWhzOzS+7yZ9cMCQjHkk9igfi51y
         cCVSzL5z+hxw1DQTvmCe/mjCYtFeRiypu2917bggAwtRbEIjdCv/dJjtYAvFTBSruiRB
         P5AQ==
X-Gm-Message-State: AOAM5330ocE5Z9+u9GtzDmLlA/kRpKfbr7DSasiur/aJtxXfEgX7ywg7
        nlewew0xKW5dFkZ96V/+TA0jSwov1jl4NioOHEmru8XtTtNK67O/shIeYXHb9AkiFwSv5XxiLTj
        8QF/VSFKnEMjtLWvBKNXYdhZphBfdy8zO1MY5ztbuj7FG+ypzhldIwb8NGrcy7ZHRtHYGWyAdhw
        RN
X-Google-Smtp-Source: ABdhPJzztxOtud01dA7Q42vOZ7WmcVBJrODlBUugcbZuSh7xLEfLgKryD4yjJnC6sHfNrnfrWx5yXVvoJ+cqhekYI/SQ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:1392:: with SMTP id
 g18mr2248030qvz.15.1632243078631; Tue, 21 Sep 2021 09:51:18 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:51:05 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <3ed77eedb8a18a53931433eca741e27f84e51e4d.1632242495.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 3/9] refs iterator: support non-the_repository advance
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support repositories other than the_repository when advancing through an
iterator.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c               | 3 ++-
 refs/files-backend.c | 2 +-
 refs/iterator.c      | 7 +------
 refs/refs-internal.h | 1 +
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 3a57893032..6ed64bee1b 100644
--- a/refs.c
+++ b/refs.c
@@ -255,12 +255,13 @@ int refname_is_safe(const char *refname)
  * does not exist, emit a warning and return false.
  */
 int ref_resolves_to_object(const char *refname,
+			   struct repository *repo,
 			   const struct object_id *oid,
 			   unsigned int flags)
 {
 	if (flags & REF_ISBROKEN)
 		return 0;
-	if (!has_object_file(oid)) {
+	if (!repo_has_object_file(repo, oid)) {
 		error(_("%s does not point to a valid object!"), refname);
 		return 0;
 	}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1faab1cf66..24e5668d6c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1127,7 +1127,7 @@ static int should_pack_ref(const char *refname,
 		return 0;
 
 	/* Do not pack broken refs: */
-	if (!ref_resolves_to_object(refname, oid, ref_flags))
+	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
 		return 0;
 
 	return 1;
diff --git a/refs/iterator.c b/refs/iterator.c
index ee6b00a7be..59048523b8 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -12,15 +12,10 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator)
 {
 	int ok;
 
-	if (ref_iterator->repo && ref_iterator->repo != the_repository)
-		/*
-		 * NEEDSWORK: make ref_resolves_to_object() support
-		 * arbitrary repositories
-		 */
-		BUG("ref_iterator->repo must be NULL or the_repository");
 	while ((ok = ref_iterator->vtable->advance(ref_iterator)) == ITER_OK) {
 		if (ref_iterator->repo &&
 		    !ref_resolves_to_object(ref_iterator->refname,
+					    ref_iterator->repo,
 					    ref_iterator->oid,
 					    ref_iterator->flags))
 			continue;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4656ef83a3..57ad1262ab 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -66,6 +66,7 @@ int refname_is_safe(const char *refname);
  * referred-to object does not exist, emit a warning and return false.
  */
 int ref_resolves_to_object(const char *refname,
+			   struct repository *repo,
 			   const struct object_id *oid,
 			   unsigned int flags);
 
-- 
2.33.0.464.g1972c5931b-goog

