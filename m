Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A880FC3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 16:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjAFQcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 11:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjAFQcC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 11:32:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3972C76EF0
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 08:32:00 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w13so475025wrk.9
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 08:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg23B6HiCukPC/Q8dJv7nOdOII71PiEc4O+lkz361uI=;
        b=onSJMzeDmCE0Jmdbufhgw6edoVmiRYTiZxVJT9qRmEPyxftT6OfE5Dh6W+Km+aCDrT
         IQ3FB4QsOGdTJ+YFH9GFwrrUNEplXK2oDadTalVxtgs+YDvtbBvalOl9G/QvcVS1AgJ2
         4ry1WqzA7+ZNOK+0fcSbT+eTG2BzmiVlUX8xrW6wsXHL/JwQxGxa3xEahb8HMYZR2lQy
         sVkUyl7PgmG8CuHdeugpsVP6e2A1xmFYvdfqiiCMTLaKll8tUmPxK/YDCqY0biAvDCJK
         vqYQMs/14f6YICW608ckEUf0HaKZkV6vDGp/meoThv21KfNMaFcE837B4xbILgFdzXqN
         n2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xg23B6HiCukPC/Q8dJv7nOdOII71PiEc4O+lkz361uI=;
        b=3E4H6lopPuOT1eMSsf5q4FFqMPWhrJm706iWsHY0lAWqnBi6IECMMXUwbB4F5AjwwI
         1yiBzz81tJUWJz/IaZ1y/1eJs6WzY5xN6HOICOT7RoMSAeqT9PkwXBC1v06p/NZcCg78
         Hd2Wsp8M2REbfi5Puy3dIsCxJn3SkKTqAyreOK6o0H2W6+Zhcr+KGaYxntw5hg2s/26+
         R6xOWi1Ql7ze1MwAVgOxBYYQgkUwmdKZHmu8rTtyoSZIbFGBEw8IdCCLoX0An1VOnAuD
         wyrAkoGvs7dqxH6QGrwJLkv4aNFSzhPCE5krPdMiz1B074PfnF9bQWGmNIPL3mm9oC3C
         Qiww==
X-Gm-Message-State: AFqh2kojzQwWI0b8saqsiYu7cvq7B55VSzgTmv2r054evF3xUxpvBnmb
        qSucxnAz4Rke4ZOoe966Bc4SmoNNd8I=
X-Google-Smtp-Source: AMrXdXs88bVLjXCJNKHtvYxyC8a4TBykQ6oZeJp+5o35W11oiz7cVcp/w0nCa81/8HjFPNIlsR3oww==
X-Received: by 2002:a5d:5c0e:0:b0:269:70f0:8142 with SMTP id cc14-20020a5d5c0e000000b0026970f08142mr37581113wrb.56.1673022718440;
        Fri, 06 Jan 2023 08:31:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bo30-20020a056000069e00b0027a57c1a6fbsm1645891wrb.22.2023.01.06.08.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 08:31:58 -0800 (PST)
Message-Id: <pull.1439.v5.git.1673022717.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
References: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 16:31:52 +0000
Subject: [PATCH v5 0/4] Optionally skip hashing index on write
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Writing the index is a critical action that takes place in multiple Git
commands. The recent performance improvements available with the sparse
index show how often the I/O costs around the index can affect different Git
commands, although reading the index takes place more often than a write.

The index is written through the hashfile API, both as a buffered write and
as a computation of its trailing hash. This trailing hash is an expectation
of the file format: several optional index extensions are provided using
indicators immediately preceding the trailing hash. 'git fsck' will complain
if the trailing hash does not match the contents of the file up to that
point.

However, computing the hash is expensive. This is even more expensive now
that we've moved to sha1dc instead of hardware-accelerated SHA1
computations.

This series provides a new config option, index.skipHash, that allows users
to disable computing the hash as Git writes the index. In this case, the
trailing hash is stored as the null hash (all bytes are zero).

The implementation is rather simple, but the patches organize different
aspects in a way that we could split things out:

 * Patch 1 adds a 'skip_hash' option to 'struct hashfile' that creates this
   as a general option to the hashwrite API.
 * The motivation in Patch 1 avoids the talk about the chunk-format API and
   instead focuses on the index as the first example that could make use of
   this.
 * Patch 2 creates the index.skipHash config option and updates 'git fsck'
   to ignore a null hash on the index. This is demonstrated by a very simple
   test.
 * Patch 3 creates a test helper to get the trailing hash of a file, and
   adds a concrete check on the trailing hash when index.skipHash=true.
 * Patch 4 (which could be deferred until later) adds index.skipHash=true as
   an implication of feature.manyFiles and as a setting in Scalar.

The end result is that index writes speed up significantly, enough that 'git
update-index --force-write' improves by 1.75x.

Similar patches appeared in my earlier refs RFC [1].

[1]
https://lore.kernel.org/git/pull.1408.git.1667846164.gitgitgadget@gmail.com/


Updates since v4
================

 * Patch 2 now uses repo_config_get_bool() instead of
   repo_config_get_maybe_bool().
 * A test is added for submodule-level config.


Updates since v3
================

 * Patch 1 uses an "int" instead of "unsigned int". This was a carry-over
   from Kevin's patch in microsoft/git, but our use of it in patch 2 is
   different and thus is better with a signed int.
 * Patch 2 uses a fallback to the_repository if istate->repo is NULL. This
   allows the setting to be applied to more cases where istate->repo is not
   set.
 * Patch 2 also uses 'start' in more places, since it already computed the
   beginning of the hash.
 * Patch 4 slightly modifies its use of prepare_repo_settings() due to Patch
   2's fallback to the_repository.


Updates since v2
================

 * Patch 2 now has additional details about why to use the config option in
   its message. The discussion about why the index is special is included in
   the commit message.


Updates since v1
================

 * In Patch 1, use hashcler() instead of memset().
 * In Patches 2 and 4, be explicit about which Git versions will exhibit
   different behavior when reading an index with a null trailing hash.
 * In Patch 2, used a more compact way of loading from config.
 * In Patch 2 (and following) dropped the sub-shell in t1600-index.sh.
 * In Patch 3, dropped back-ticks when using a multi-line pipe.
 * In Patch 4, use "! cmp" instead of "! test_cmp"


Updates since RFC
=================

 * The config name is now index.skipHash to make it more clear that the
   default is to not skip the hash, and choosing this option requires a true
   value.
 * Use oidread() instead of an ad-hoc loop.
 * Patches 3 and 4 are new. 3 adds some extra test verification that wasn't
   in the RFC.
 * I think that patch 4 is helpful to see now, but I could understand if we
   wanted to defer that patch until after index.skipHash has had more time
   to bake.

Thanks, -Stolee

Derrick Stolee (4):
  hashfile: allow skipping the hash function
  read-cache: add index.skipHash config option
  test-lib-functions: add helper for trailing hash
  features: feature.manyFiles implies fast index writes

 Documentation/config/feature.txt |  5 +++++
 Documentation/config/index.txt   | 11 +++++++++++
 csum-file.c                      | 14 +++++++++++---
 csum-file.h                      |  7 +++++++
 read-cache.c                     | 14 +++++++++++++-
 repo-settings.c                  |  2 ++
 repository.h                     |  1 +
 scalar.c                         |  1 +
 t/t1600-index.sh                 | 30 ++++++++++++++++++++++++++++++
 t/test-lib-functions.sh          |  8 ++++++++
 10 files changed, 89 insertions(+), 4 deletions(-)


base-commit: 805265fcf7a737664a8321aaf4a0587b78435184
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1439%2Fderrickstolee%2Fhashfile-skip-hash-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1439/derrickstolee/hashfile-skip-hash-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1439

Range-diff vs v4:

 1:  c99470d4676 = 1:  c99470d4676 hashfile: allow skipping the hash function
 2:  aae047cbc9f ! 2:  a3c79308171 read-cache: add index.skipHash config option
     @@ Commit message
          ability to opt-in to this feature, even with the potential confusion
          with older 'git fsck' versions.
      
     +    Test this new config option, both at a command-line level and within a
     +    submodule. The confirmation is currently limited to confirm that 'git
     +    fsck' does not complain about the index. Future updates will make this
     +    test more robust.
     +
          It is critical that this test is placed before the test_index_version
          tests, since those tests obliterate the .git/config file and hence lose
          the setting from GIT_TEST_DEFAULT_HASH, if set.
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       
       	f = hashfd(tempfile->fd, tempfile->filename.buf);
       
     -+	repo_config_get_maybe_bool(r, "index.skiphash", &f->skip_hash);
     ++	repo_config_get_bool(r, "index.skiphash", &f->skip_hash);
      +
       	for (i = removed = extended = 0; i < entries; i++) {
       		if (cache[i]->ce_flags & CE_REMOVE)
     @@ t/t1600-index.sh: test_expect_success 'out of bounds index.version issues warnin
      +test_expect_success 'index.skipHash config option' '
      +	rm -f .git/index &&
      +	git -c index.skipHash=true add a &&
     -+	git fsck
     ++	git fsck &&
     ++
     ++	test_commit start &&
     ++	git -c protocol.file.allow=always submodule add ./ sub &&
     ++	git config index.skipHash false &&
     ++	git -C sub config index.skipHash true &&
     ++	>sub/file &&
     ++	git -C sub add a &&
     ++	git -C sub fsck
      +'
      +
       test_index_version () {
 3:  27fbe52e748 ! 3:  dab9b15de47 test-lib-functions: add helper for trailing hash
     @@ Commit message
      
          Add a new test_trailing_hash helper and use it in t1600 to verify that
          index.skipHash=true really does skip the hash computation, since
     -    'git fsck' does not actually verify the hash.
     +    'git fsck' does not actually verify the hash. This confirms that when
     +    the config is disabled explicitly in a super project but enabled in a
     +    submodule, then the use of repo_config_get_bool() loads config from the
     +    correct repository in the case of 'git add'. There are other cases where
     +    istate->repo is NULL and thus this config is loaded instead from
     +    the_repository, but that's due to many different code paths initializing
     +    index_state structs in their own way.
      
          Keep the 'git fsck' call to ensure that any potential future change to
          check the index hash does not cause an error in this case.
     @@ t/t1600-index.sh: test_expect_success 'out of bounds index.version issues warnin
      +	test_trailing_hash .git/index >hash &&
      +	echo $(test_oid zero) >expect &&
      +	test_cmp expect hash &&
     - 	git fsck
     + 	git fsck &&
     + 
     + 	test_commit start &&
     +@@ t/t1600-index.sh: test_expect_success 'index.skipHash config option' '
     + 	git -C sub config index.skipHash true &&
     + 	>sub/file &&
     + 	git -C sub add a &&
     ++	test_trailing_hash .git/modules/sub/index >hash &&
     ++	test_cmp expect hash &&
     + 	git -C sub fsck
       '
       
      
 4:  075921514f2 ! 4:  1beedcb5ba1 features: feature.manyFiles implies fast index writes
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       
       	f = hashfd(tempfile->fd, tempfile->filename.buf);
       
     --	repo_config_get_maybe_bool(r, "index.skiphash", &f->skip_hash);
     +-	repo_config_get_bool(r, "index.skiphash", &f->skip_hash);
      +	prepare_repo_settings(r);
      +	f->skip_hash = r->settings.index_skip_hash;
       
     @@ scalar.c: static int set_recommended_config(int reconfigure)
      
       ## t/t1600-index.sh ##
      @@ t/t1600-index.sh: test_expect_success 'index.skipHash config option' '
     - 	test_trailing_hash .git/index >hash &&
     - 	echo $(test_oid zero) >expect &&
       	test_cmp expect hash &&
     --	git fsck
     -+	git fsck &&
     -+
     + 	git fsck &&
     + 
      +	rm -f .git/index &&
      +	git -c feature.manyFiles=true add a &&
      +	test_trailing_hash .git/index >hash &&
     -+	test_cmp expect hash &&
     ++	cmp expect hash &&
      +
      +	rm -f .git/index &&
      +	git -c feature.manyFiles=true \
     -+		-c index.skipHash=false add a &&
     ++	    -c index.skipHash=false add a &&
      +	test_trailing_hash .git/index >hash &&
     -+	! cmp expect hash
     - '
     - 
     - test_index_version () {
     ++	! cmp expect hash &&
     ++
     + 	test_commit start &&
     + 	git -c protocol.file.allow=always submodule add ./ sub &&
     + 	git config index.skipHash false &&

-- 
gitgitgadget
