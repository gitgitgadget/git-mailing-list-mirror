Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DEAC4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 15:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiLPPbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPPbX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 10:31:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6263811A0E
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:31:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so2031862wml.4
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ1LUDs6Cxd7J5zrFmIc0LNAFO3w6Ytr93v982rTeo0=;
        b=VxMkGV3h9kQdkqcX/HlJP152Wx2yv126r0siW0BU3dbvEYnZoQLGitTBIfIT5yvT/9
         CHkxQv55ij78cqEeP7ydHKs83CkZI2V06QsY0R3ZmZqV+qqoy2760UbsTebbEbnypY9/
         /IbSjTiEz7nFGXaVAi68Qag4wiWpukZcdRsQt3OHOov9ix+iNfvlXirhk6oPVHL/NIX6
         mcRtU6DK7TJoSFZ7ilE5b6RAMvKVg/zO7bIz4b+yEMjM3dd+NlavCMDi+S/UhKfQyxoG
         3mh0emHb98+yeNicfLr5KehspbUMMn23zXY7kOq/dzk4C53Ux37F+at822GT6sOa5+Cj
         +HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ1LUDs6Cxd7J5zrFmIc0LNAFO3w6Ytr93v982rTeo0=;
        b=c2HQYlE89QY064kWnUPV//4bX4YEKspLq+x3M9YjpvZ0zc1WVHCmTUAU6dm8m1eglF
         X+G/ioLPRuNmVtY4o0ABxJWjaa5eEPfl81RsVVm0tMq3PnOao8OzfvctPkouPS6dn+P7
         TgD4hNeY5xCUL87NiIt7Z/bDWgzJ1gT1D9TWIOdj8nGfYwzbg/U2LfuvtmDgp3CHEBBe
         xwzkeaU+LrgBp9cj/LpiIPpvsCEscm04QiVa9jNaNVwnckrsOGkpQl5amHX4nd6CjDK/
         PBQ8HdyhQo+1b/BFyi68lofkHNdiT+W0Ek8FgU/NGk/NVujmIwYQBR7pfxBRs2g0Er3s
         3Umg==
X-Gm-Message-State: ANoB5pnRRTrzrnEOv7HqJdlRuevB+7aKypHHzut/YFFghmzfQ7i2Misc
        ih5WzLC58VzS/j35/5htnFEKWg/5Cyk=
X-Google-Smtp-Source: AA0mqf6VXyZ5dwo1g6/zPqG3WKyn3hJWazk2cLgN0XTUa5l3TNuanqIAJL05aYn+QA0o5KCPdyf+IQ==
X-Received: by 2002:a05:600c:4f52:b0:3cf:702b:2fd2 with SMTP id m18-20020a05600c4f5200b003cf702b2fd2mr25185272wmq.3.1671204680462;
        Fri, 16 Dec 2022 07:31:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c510300b003cfa3a12660sm19355561wms.1.2022.12.16.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:31:19 -0800 (PST)
Message-Id: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 15:31:14 +0000
Subject: [PATCH v4 0/4] Optionally skip hashing index on write
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
 t/t1600-index.sh                 | 20 ++++++++++++++++++++
 t/test-lib-functions.sh          |  8 ++++++++
 10 files changed, 79 insertions(+), 4 deletions(-)


base-commit: 805265fcf7a737664a8321aaf4a0587b78435184
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1439%2Fderrickstolee%2Fhashfile-skip-hash-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1439/derrickstolee/hashfile-skip-hash-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1439

Range-diff vs v3:

 1:  b582d681581 ! 1:  c99470d4676 hashfile: allow skipping the hash function
     @@ csum-file.h: struct hashfile {
       	unsigned char *check_buffer;
      +
      +	/**
     -+	 * If set to 1, skip_hash indicates that we should
     ++	 * If non-zero, skip_hash indicates that we should
      +	 * not actually compute the hash for this hashfile and
      +	 * instead only use it as a buffered write.
      +	 */
     -+	unsigned int skip_hash;
     ++	int skip_hash;
       };
       
       /* Checkpoint */
 2:  00738c81a12 ! 2:  aae047cbc9f read-cache: add index.skipHash config option
     @@ Commit message
      
          [1] https://github.com/microsoft/git/commit/21fed2d91410f45d85279467f21d717a2db45201
      
     +    We load this config from the repository config given by istate->repo,
     +    with a fallback to the_repository if it is not set.
     +
          While older Git versions will not recognize the null hash as a special
          case, the file format itself is still being met in terms of its
          structure. Using this null hash will still allow Git operations to
     @@ read-cache.c: static int verify_hdr(const struct cache_header *hdr, unsigned lon
       	the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
       	the_hash_algo->final_fn(hash, &c);
      -	if (!hasheq(hash, (unsigned char *)hdr + size - the_hash_algo->rawsz))
     -+	if (!hasheq(hash, end - the_hash_algo->rawsz))
     ++	if (!hasheq(hash, start))
       		return error(_("bad index file sha1 signature"));
       	return 0;
       }
      @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
     + 	int ieot_entries = 1;
     + 	struct index_entry_offset_table *ieot = NULL;
     + 	int nr, nr_threads;
     ++	struct repository *r = istate->repo ? istate->repo : the_repository;
       
       	f = hashfd(tempfile->fd, tempfile->filename.buf);
       
     -+	git_config_get_maybe_bool("index.skiphash", (int *)&f->skip_hash);
     ++	repo_config_get_maybe_bool(r, "index.skiphash", &f->skip_hash);
      +
       	for (i = removed = extended = 0; i < entries; i++) {
       		if (cache[i]->ce_flags & CE_REMOVE)
 3:  86370af1351 = 3:  27fbe52e748 test-lib-functions: add helper for trailing hash
 4:  6490bd445eb ! 4:  075921514f2 features: feature.manyFiles implies fast index writes
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       
       	f = hashfd(tempfile->fd, tempfile->filename.buf);
       
     --	git_config_get_maybe_bool("index.skiphash", (int *)&f->skip_hash);
     -+	if (istate->repo) {
     -+		prepare_repo_settings(istate->repo);
     -+		f->skip_hash = istate->repo->settings.index_skip_hash;
     -+	}
     +-	repo_config_get_maybe_bool(r, "index.skiphash", &f->skip_hash);
     ++	prepare_repo_settings(r);
     ++	f->skip_hash = r->settings.index_skip_hash;
       
       	for (i = removed = extended = 0; i < entries; i++) {
       		if (cache[i]->ce_flags & CE_REMOVE)

-- 
gitgitgadget
