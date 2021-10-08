Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF2AC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124EF60FF2
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbhJHVKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbhJHVKV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:10:21 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922B9C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:08:25 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id x61-20020a17090a6c4300b0019f789f61bdso8230562pjj.0
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EaTst7AXo8+NOR7cepzwDxPg+y2kLs4h6ZPm614S3ZE=;
        b=p3/gJbk/Ix3F8CEheCuwsmoCEPitjahiXvh0Jp5NvFWoQEagVcUHTrd/Eb93brb5pg
         ynRJtWkIkqC82VZN9gskAEYG/9yU6xNBEU2zkl46QAoLU64BCUAbqHg4kH6vjM1PLYb+
         hUosdSJOW7sJmkQmdmohMMF2FqiZ5D+lE0lkGFfL/EEXfl4xhlTqJgYsZJcS/6UlCs8X
         lKEoO95iboqGssEEumZgamEilOg7DUspDTzxqhxgP1eweJ2febQoqcS1ujNuBNTT7glN
         3pO2PhsTIOwbSMq2SuMezWjdM01Wp42S560koSaPbNQC0uTx/h1rF38GpLjx5N2mp4Iu
         R8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EaTst7AXo8+NOR7cepzwDxPg+y2kLs4h6ZPm614S3ZE=;
        b=tpToKqeVYuP6sfFyEHUUaiBDafxoPa+Dn+af2JHc55MsYYgZQAXKhsovNzOIPRJTpi
         32jo2ZWI9cRXqsXOiR/azM4avI7TmLdbZQ7P9Vzblc+C8rNhAiPZY0pNto0K3kc0eu02
         JyCRY2UUVcTXt0NrFOLc7BW+zCuQfAwhCoedUCYKZ7BGMUE9zbf7+o6naSscNWs0EnbZ
         0UEqVgimMl9RGM5wGsaGD9mwTGE+UOIzwKOb8ly2XRjIeo8h/zSxGmMWkcPJVe2Tl1kN
         Ne6tC1CMS7+FW7LYTlMuvt9X96jfw/ItbDUdYgBlwfJUFc6cu+k8BC6FiAiD+XWmTN2B
         yYhA==
X-Gm-Message-State: AOAM531hnpB8sVhh5GhPhgpdNTh03S3Dt0i4Cp6+bCaL9RLCVS5sumum
        PJWk8NepY95FyyKw8nTL+zimYRA+9ibYvhaM+BdPY2r9JUS2bWMF6Dy345UgbQxV/zi5FSkHU17
        G5SSjtEPB8SU0CIfkdhgDtvJXowVuElg4RmzusrwCc+aw5aQ8GdgFaCom1aPPoH09kuqv/vQjWy
        iK
X-Google-Smtp-Source: ABdhPJzonb2My/ftyKD0QNowVAnvOB99tbzIneROC/62agLEqV5yoPe03oudLl4VoT9NEunGp2gCCP41iOuteCXsBCrS
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:e544:b0:13e:e863:6cd2 with
 SMTP id n4-20020a170902e54400b0013ee8636cd2mr11316825plf.41.1633727305016;
 Fri, 08 Oct 2021 14:08:25 -0700 (PDT)
Date:   Fri,  8 Oct 2021 14:08:13 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <cover.1633727270.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 0/7] No more adding submodule ODB as alternate
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, carenas@gmail.com,
        chooglen@google.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your reviews. Here's an updated patch set, including
Carlo's fixup squashed.

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
 object-file.c                          |  9 +++++-
 refs.c                                 | 32 +++++++++++++++-----
 refs/files-backend.c                   | 16 ++++++----
 refs/packed-backend.c                  | 13 ++++++--
 refs/packed-backend.h                  |  4 ++-
 refs/ref-cache.c                       | 10 +++++++
 refs/ref-cache.h                       |  1 +
 refs/refs-internal.h                   | 11 +++++--
 strbuf.c                               | 12 ++++++--
 strbuf.h                               |  6 ++--
 submodule.c                            | 18 +++++++++--
 t/README                               |  7 ++---
 t/t5526-fetch-submodules.sh            |  3 ++
 t/t5531-deep-submodule-push.sh         |  3 ++
 t/t5545-push-options.sh                |  3 ++
 t/t5572-pull-submodule.sh              |  3 ++
 t/t6437-submodule-merge.sh             |  3 ++
 t/t7418-submodule-sparse-gitmodules.sh |  3 ++
 20 files changed, 148 insertions(+), 68 deletions(-)

Range-diff against v3:
1:  878c4dd288 ! 1:  f050191d4c refs: plumb repo into ref stores
    @@ Commit message
         arbitrary repositories to ref iterators, plumb a repository into all ref
         stores. There are no changes to program logic.
     
    -    (The repository is plumbed into the ref stores instead of directly into
    -    the ref iterators themselves, so that existing code that operates on ref
    -    stores do not need to be modified to also handle repositories.)
    -
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ refs/packed-backend.c: static int release_snapshot(struct snapshot *snapshot)
      
     
      ## refs/packed-backend.h ##
    +@@
    + #ifndef REFS_PACKED_BACKEND_H
    + #define REFS_PACKED_BACKEND_H
    + 
    ++struct repository;
    + struct ref_transaction;
    + 
    + /*
     @@ refs/packed-backend.h: struct ref_transaction;
       * even among packed refs.
       */
2:  7180f622b1 = 2:  6418256919 refs: teach arbitrary repo support to iterators
3:  1a2e2e3e08 = 3:  d624c198d6 refs: peeling non-the_repository iterators is BUG
4:  89347503af = 4:  f3df7a31cb merge-{ort,recursive}: remove add_submodule_odb()
5:  17d6c0a793 ! 5:  78473b0f89 object-file: only register submodule ODB if needed
    @@ object-file.c: static int do_oid_object_info_extended(struct repository *r,
      		}
      
     -		if (register_all_submodule_odb_as_alternates())
    ++		/*
    ++		 * If r is the_repository, this might be an attempt at
    ++		 * accessing a submodule object as if it were in the_repository
    ++		 * (having called add_submodule_odb() on that submodule's ODB).
    ++		 * If any such ODBs exist, register them and try again.
    ++		 */
     +		if (r == the_repository &&
     +		    register_all_submodule_odb_as_alternates())
      			/* We added some alternates; retry */
6:  1eb2dda2dc = 6:  f4241ea2e7 submodule: pass repo to check_has_commit()
7:  36e741dda8 ! 7:  8922bf48a2 submodule: trace adding submodule ODB as alternate
    @@ submodule.c: int register_all_submodule_odb_as_alternates(void)
      		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
      			BUG("register_all_submodule_odb_as_alternates() called");
      	}
    +
    + ## t/README ##
    +@@ t/README: GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=<boolean>, when true, makes
    + registering submodule ODBs as alternates a fatal action. Support for
    + this environment variable can be removed once the migration to
    + explicitly providing repositories when accessing submodule objects is
    +-complete (in which case we might want to replace this with a trace2
    +-call so that users can make it visible if accessing submodule objects
    +-without an explicit repository still happens) or needs to be abandoned
    +-for whatever reason (in which case the migrated codepaths still retain
    +-their performance benefits).
    ++complete or needs to be abandoned for whatever reason (in which case the
    ++migrated codepaths still retain their performance benefits).
    + 
    + Naming Tests
    + ------------
-- 
2.33.0.882.g93a45727a2-goog

