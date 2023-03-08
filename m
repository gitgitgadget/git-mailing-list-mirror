Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5763C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 18:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCHSri (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCHSrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 13:47:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4660014EA1
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 10:47:35 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so1747822wmq.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 10:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678301253;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sM5HlbXEx524DrLtoddsX64xZG9UhZU6gpESQasp31A=;
        b=P4iDwScfBquWERaXyEz+uz+2CqjCNT/tJPhzbQTpz3Vpp8G1ixSuncsL61FosuGVLq
         dxq4JG8GZwr7KNZhfB5ikFlrEePm/h5YJQ+gVWiQ5trQUjguvtGokK99E4A0K1TKOL2a
         v5F7r/yE8kDl7uqyqNVJ4lyxN40sUSJHmodsj2s96k93Ecv5dZvhuIfmYAqQ3Jq1W8ho
         bQBUsrFbKquX0tS+r6mAVShyk3EqiFpGkI4cX7oQ5O7vYp6F7B9W6tPqgyOw7BAWYIfA
         X8evITu5bia2FD/Qfqj9GPV7Fuk/0LawWwJniStB79yYx4msGcmBsvaK61qXH+H/Gw9u
         4awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678301253;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sM5HlbXEx524DrLtoddsX64xZG9UhZU6gpESQasp31A=;
        b=GSZsIpZivwAd1O0kmASXuKnlf2SBwPBgmJ36tXZ9+mV5744+3dzEtrnvyzPZH24MLy
         zcS7AWd916Na8Jhx91dh2PV2N0EE+c2EP9xBDAXgy/sIKKRh3ni/KJncsH4uwEGJmGYX
         yY5wwIVWkUdbsIcZHhUE18o4YzpJvg7E2x+IjRzZMcZrPoAvwoWqBtyDyQdDIC6FHOBZ
         QjnuZ/ze9SkSfBsLy/5KkUmqWcKKFAovGV56HZPt7pz6+qBJ3RxOKMfybWvp0PJ9+05T
         EbLe4iAGMohbEhTBJ+TOWFD0H3Etfr3A4IpvSsvfNsOnVoLzpedGK8Rgvc0JCJwerWMW
         PJzw==
X-Gm-Message-State: AO0yUKV+Oza7iZJJp+URthepZLvSNzUJ7IMhzTKnpOsm7bOJTEfaZDOd
        lPK8b0YJm3G1graQBc5aHsLHFXn091M=
X-Google-Smtp-Source: AK7set/UJ/aExPuomC2h/4dslg9qlXcz/sHGwSuh9VLw1e/WmbAYbyZ3XFoJKyN/UyepENZANeSqGg==
X-Received: by 2002:a05:600c:3b87:b0:3e2:c67:1c7f with SMTP id n7-20020a05600c3b8700b003e20c671c7fmr17026702wms.10.1678301253397;
        Wed, 08 Mar 2023 10:47:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c3ac700b003e0015c8618sm271068wms.6.2023.03.08.10.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:47:33 -0800 (PST)
Message-Id: <pull.1490.v2.git.1678301252360.gitgitgadget@gmail.com>
In-Reply-To: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Mar 2023 18:47:32 +0000
Subject: [PATCH v2] object-file: reprepare alternates when necessary
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When an object is not found in a repository's object store, we sometimes
call reprepare_packed_git() to see if the object was temporarily moved
into a new pack-file (and its old pack-file or loose object was
deleted). This process does a scan of each pack directory within each
odb, but does not reevaluate if the odb list needs updating.

Extend reprepare_packed_git() to also reprepate the alternate odb list
by setting loaded_alternates to zero and calling prepare_alt_odb(). This
will add newly-discoverd odbs to the linked list, but will not duplicate
existing ones nor will it remove existing ones that are no longer listed
in the alternates file. Do this under the object read lock to avoid
readers from interacting with a potentially incomplete odb being added
to the odb list.

If the alternates file was edited to _remove_ some alternates during the
course of the Git process, Git will continue to see alternates that were
ever valid for that repository. ODBs are not removed from the list, the
same as the existing behavior before this change. Git already has
protections against an alternate directory disappearing from the
filesystem during the lifetime of a process, and those are still in
effect.

This change is specifically for concurrent changes to the repository, so
it is difficult to create a test that guarantees this behavior is
correct. I manually verified by introducing a reprepare_packed_git() call
into get_revision() and stepped into that call in a debugger with a
parent 'git log' process. Multiple runs of prepare_alt_odb() kept
the_repository->objects->odb as a single-item chain until I added a
.git/objects/info/alternates file in a different process. The next run
added the new odb to the chain and subsequent runs did not add to the
chain.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    object-file: reprepare alternates when necessary
    
    This subtlety was notice by Michael Haggerty due to how alternates are
    used server-side at $DAYJOB. Moving pack-files from a repository to the
    alternate occasionally causes failures because processes that start
    before the alternate exists don't know how to find that alternate at
    run-time.
    
    
    Update in v2
    ============
    
     * Instead of creating a new public reprepare_alt_odb() method, inline
       its implementation inside reprepare_packed_git().
     * Update commit message to be explicit about behavior with alternates
       being removed from the alternates file or from disk.
    
    Thanks,
    
     * Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1490%2Fderrickstolee%2Fstolee%2Freprepare-alternates-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1490/derrickstolee/stolee/reprepare-alternates-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1490

Range-diff vs v1:

 1:  3f42c9cdef7 ! 1:  9a5e1d9a9da object-file: reprepare alternates when necessary
     @@ Commit message
          deleted). This process does a scan of each pack directory within each
          odb, but does not reevaluate if the odb list needs updating.
      
     -    Create a new reprepare_alt_odb() method that is a similar wrapper around
     -    prepare_alt_odb(). Call it from reprepare_packed_git() under the object
     -    read lock to avoid readers from interacting with a potentially
     -    incomplete odb being added to the odb list.
     -
     -    prepare_alt_odb() already avoids adding duplicate odbs to the list
     -    during its progress, so it is safe to call it again from
     -    reprepare_alt_odb() without worrying about duplicate odbs.
     +    Extend reprepare_packed_git() to also reprepate the alternate odb list
     +    by setting loaded_alternates to zero and calling prepare_alt_odb(). This
     +    will add newly-discoverd odbs to the linked list, but will not duplicate
     +    existing ones nor will it remove existing ones that are no longer listed
     +    in the alternates file. Do this under the object read lock to avoid
     +    readers from interacting with a potentially incomplete odb being added
     +    to the odb list.
     +
     +    If the alternates file was edited to _remove_ some alternates during the
     +    course of the Git process, Git will continue to see alternates that were
     +    ever valid for that repository. ODBs are not removed from the list, the
     +    same as the existing behavior before this change. Git already has
     +    protections against an alternate directory disappearing from the
     +    filesystem during the lifetime of a process, and those are still in
     +    effect.
      
          This change is specifically for concurrent changes to the repository, so
          it is difficult to create a test that guarantees this behavior is
          correct. I manually verified by introducing a reprepare_packed_git() call
          into get_revision() and stepped into that call in a debugger with a
     -    parent 'git log' process. Multiple runs of reprepare_alt_odb() kept
     +    parent 'git log' process. Multiple runs of prepare_alt_odb() kept
          the_repository->objects->odb as a single-item chain until I added a
          .git/objects/info/alternates file in a different process. The next run
          added the new odb to the chain and subsequent runs did not add to the
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     - ## object-file.c ##
     -@@ object-file.c: void prepare_alt_odb(struct repository *r)
     - 	r->objects->loaded_alternates = 1;
     - }
     - 
     -+void reprepare_alt_odb(struct repository *r)
     -+{
     -+	r->objects->loaded_alternates = 0;
     -+	prepare_alt_odb(r);
     -+}
     -+
     - /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
     - static int freshen_file(const char *fn)
     - {
     -
     - ## object-store.h ##
     -@@ object-store.h: KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
     - 	struct object_directory *, 1, fspathhash, fspatheq)
     - 
     - void prepare_alt_odb(struct repository *r);
     -+void reprepare_alt_odb(struct repository *r);
     - char *compute_alternate_path(const char *path, struct strbuf *err);
     - struct object_directory *find_odb(struct repository *r, const char *obj_dir);
     - typedef int alt_odb_fn(struct object_directory *, void *);
     -
       ## packfile.c ##
      @@ packfile.c: void reprepare_packed_git(struct repository *r)
       	struct object_directory *odb;
       
       	obj_read_lock();
     -+	reprepare_alt_odb(r);
     ++
     ++	/*
     ++	 * Reprepare alt odbs, in case the alternates file was modified
     ++	 * during the course of this process. This only _adds_ odbs to
     ++	 * the linked list, so existing odbs will continue to exist for
     ++	 * the lifetime of the process.
     ++	 */
     ++	r->objects->loaded_alternates = 0;
     ++	prepare_alt_odb(r);
     ++
       	for (odb = r->objects->odb; odb; odb = odb->next)
       		odb_clear_loose_cache(odb);
       


 packfile.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/packfile.c b/packfile.c
index 79e21ab18e7..06419c8e8ca 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1008,6 +1008,16 @@ void reprepare_packed_git(struct repository *r)
 	struct object_directory *odb;
 
 	obj_read_lock();
+
+	/*
+	 * Reprepare alt odbs, in case the alternates file was modified
+	 * during the course of this process. This only _adds_ odbs to
+	 * the linked list, so existing odbs will continue to exist for
+	 * the lifetime of the process.
+	 */
+	r->objects->loaded_alternates = 0;
+	prepare_alt_odb(r);
+
 	for (odb = r->objects->odb; odb; odb = odb->next)
 		odb_clear_loose_cache(odb);
 

base-commit: d15644fe0226af7ffc874572d968598564a230dd
-- 
gitgitgadget
