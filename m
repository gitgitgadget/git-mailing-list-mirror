Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8CAC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7296661440
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347435AbhI2XIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 19:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347409AbhI2XIK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 19:08:10 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14CC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id d6-20020a63d646000000b00268d368ead8so2972948pgj.6
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QSVipK78ocQ4QOgxGOjqphNLR1i1LNQLQiYx4Fxx1cs=;
        b=mLAJNyvV+xsmRcfZWULbTQe3uk2xv1fKeka4ERglA1cvUu4Yu1VeauUqfkT40j3odM
         jbHpSczezOix+RK2cEovfsuKPGL9izUajE8GeZBf4v7UJ05URmAROnHspUcROW+pOkor
         CtKKF5ZfDhdXrkFkJt3s3L31taRpg2OziAkYZEKjkhCtsI1XGGqtUc25VaMyf8uv0QdJ
         9KkqspHDo/184DERdRs2a0/W65vBjT/WYWIywxhYD+DChe6nQkpProNmcSyHoxKKS6aj
         HaQrZTWQd/pSXfgSEDY6PQvRt/lpaWwiAbRH2X5BvWdcDdvngOHyd+cnXDMjoJrXZGag
         I26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QSVipK78ocQ4QOgxGOjqphNLR1i1LNQLQiYx4Fxx1cs=;
        b=SuxZdnT5TA4nEkU+j9bhtEd0a0yB5oJANJn+AaHe5YwLg1LyOxcgTlIm76D2N3+lZ3
         8cl0Cy+bTAtMXbY9a6xbbmDwHQfUoyN5PwQE2WB1r5As7NQj7fAWC4L8SsXLWY6HKefR
         IScCtDkqPq2cqWZJK8lAIyPhhqdloS3WtaY2Ez6YO2Z1QruMfpsy/IaIPKSWBBLlgysD
         pymS3c+SVXOGDK6XZK8YFetWsRazacrI2wkOz4nn3udd52hudMjlifkz3nlptKaVfTFt
         EFC/tX/MutIXB6HuYO9/UBeFN1gDGGenSjAOKar55O4Iwy+MWtPbFaVkv3Md1e3nir1S
         d1WQ==
X-Gm-Message-State: AOAM53328Gji09NbXYCxI0SuOwMtA7xUm1D+ol2jB3xGrLb1K/Rnl73B
        9ZEJIgMYxoG01bYlFVJAD9QZpEKggXDu+jgGBotZZxw/69Pp7R4qhXUAWgb0YxSS0kdIvaVWc6a
        cwEG4N/nes5qtTCxi6MHTKajk0UGs8+gg86pXzVdL87XE2mdAvjLxyrV0DekC47iUEYfHRQMlfn
        vE
X-Google-Smtp-Source: ABdhPJw9fjO0+SHwsPvvb0v+Lv27NKgPXfcxSkXIqlBx9ofpas6f+3IME6Aszp9Y788R+pD31tocuc///jInqg+Xa7gh
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1013:: with SMTP id
 gm19mr226618pjb.1.1632956787561; Wed, 29 Sep 2021 16:06:27 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:06:16 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <cover.1632956589.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 0/7] No more adding submodule ODB as alternate
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on a merge of jk/ref-paranoia and jt/add-submodule-odb-clean-up
(same as v2).

Here's the same patch set except that the repo is plumbed into the ref
stores. (Iterators currently do not have any reference to their ref
stores, so some of them still need repo fields. But because the ref
stores now know their repos, calling code does not need to pass a repo
when these iterators are instantiated.)

As you can see from the shorter patch list, this eliminates the need for
some patches.

Jonathan Tan (7):
  refs: plumb repo into ref stores
  refs: teach arbitrary repo support to iterators
  refs: peeling non-the_repository iterators is BUG
  merge-{ort,recursive}: remove add_submodule_odb()
  object-file: only register submodule ODB if needed
  submodule: pass repo to check_has_commit()
  submodule: trace adding submodule ODB as alternate

 merge-ort.c                            | 18 +++--------
 merge-recursive.c                      | 41 +++++++++++++-------------
 object-file.c                          |  3 +-
 refs.c                                 | 32 +++++++++++++++-----
 refs/files-backend.c                   | 16 ++++++----
 refs/packed-backend.c                  | 13 ++++++--
 refs/packed-backend.h                  |  3 +-
 refs/ref-cache.c                       | 10 +++++++
 refs/ref-cache.h                       |  1 +
 refs/refs-internal.h                   | 11 +++++--
 strbuf.c                               | 12 ++++++--
 strbuf.h                               |  6 ++--
 submodule.c                            | 18 +++++++++--
 t/t5526-fetch-submodules.sh            |  3 ++
 t/t5531-deep-submodule-push.sh         |  3 ++
 t/t5545-push-options.sh                |  3 ++
 t/t5572-pull-submodule.sh              |  3 ++
 t/t6437-submodule-merge.sh             |  3 ++
 t/t7418-submodule-sparse-gitmodules.sh |  3 ++
 19 files changed, 139 insertions(+), 63 deletions(-)

Range-diff against v2:
 1:  e364b13a37 <  -:  ---------- refs: plumb repo param in begin-iterator functions
 -:  ---------- >  1:  8067397538 refs: plumb repo into ref stores
 2:  ec153eff7b !  2:  c8799d408f refs: teach arbitrary repo support to iterators
    @@ refs/files-backend.c: static struct ref_iterator *files_ref_iterator_begin(
      	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable,
      			       overlay_iter->ordered);
      	iter->iter0 = overlay_iter;
    -+	iter->repo = repo;
    ++	iter->repo = ref_store->repo;
      	iter->flags = flags;
      
      	return ref_iterator;
    @@ refs/packed-backend.c: static struct ref_iterator *packed_ref_iterator_begin(
      
      	iter->base.oid = &iter->oid;
      
    -+	iter->repo = repo;
    ++	iter->repo = ref_store->repo;
      	iter->flags = flags;
      
      	if (prefix && *prefix)
 3:  dd1a8871f4 !  3:  e7fb60b7e7 refs: peeling non-the_repository iterators is BUG
    @@ refs/files-backend.c: static struct ref_iterator *files_ref_iterator_begin(
      
      	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
     -					      prefix, 1);
    -+					      prefix, repo, 1);
    ++					      prefix, ref_store->repo, 1);
      
      	/*
      	 * The packed-refs file might contain broken references, for
 4:  da0c9c2d44 <  -:  ---------- refs: teach refs_for_each_ref() arbitrary repos
 5:  dd70820d66 =  4:  e4a1be22c8 merge-{ort,recursive}: remove add_submodule_odb()
 6:  9c5ce004b2 =  5:  0200f1880b object-file: only register submodule ODB if needed
 7:  1fca3b1a25 !  6:  7a6a1ee5f9 submodule: pass repo to check_has_commit()
    @@ Commit message
     
         Pass the repo explicitly when calling check_has_commit() to avoid
         relying on add_submodule_odb(). With this commit and the parent commit,
    -    several tests no longer rely on add_submodule_odb(), so mark these tests
    -    accordingly.
    +    the last remaining tests no longer rely on add_submodule_odb(), so mark
    +    these tests accordingly.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
    @@ t/t5526-fetch-submodules.sh: test_description='Recursive "git fetch" for submodu
      
      pwd=$(pwd)
     
    + ## t/t5531-deep-submodule-push.sh ##
    +@@ t/t5531-deep-submodule-push.sh: test_description='test push with submodules'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
    ++export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
    ++
    + . ./test-lib.sh
    + 
    + test_expect_success setup '
    +
    + ## t/t5545-push-options.sh ##
    +@@ t/t5545-push-options.sh: test_description='pushing to a repository using push options'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
    ++export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
    ++
    + . ./test-lib.sh
    + 
    + mk_repo_pair () {
    +
      ## t/t5572-pull-submodule.sh ##
     @@
      
 8:  7b5087a14d <  -:  ---------- refs: change refs_for_each_ref_in() to take repo
 9:  cef2a97840 =  7:  e4b6ee2186 submodule: trace adding submodule ODB as alternate
-- 
2.33.0.685.g46640cef36-goog

