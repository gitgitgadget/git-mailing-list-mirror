Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762F7C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 23:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiCIXE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCIXEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 18:04:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E20C972E3
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 15:03:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id p9so5244355wra.12
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 15:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E5PeJRVhgcnD3tYlz/DHJgraNjPcM8RvOvkul/YGijY=;
        b=qlR/F0Xl2FcAudL+lWkRB2NJx1fptnPfYvdfQYWSG9sJKn+MvofJfRnoBKS0Ztwxhd
         PvlrgCRn9z2QDadeswkixzuH2Ed4NbSWjsI8Y0I0/UsM2GlCktjsuKtXn8MuKYSvvXTX
         Y+muBMPpnOEgTYV1hlBDX/x7GvbM4rbSe4BFEXPLBIsBLX3VcfDCQGTvhFoyFhiyajPX
         3rOigllyZDfax+B4VO7K/GcRM+7kSVOGFJMLDGKB698Zf1+5DA3wsL15gQmssQPhrFr/
         VevAsWXroqp3rJLRda0rDdCDHNwzpPIvzDz5hw7+o1a+bQTNzRN8azdUMVJc6IM4p9G/
         ol3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E5PeJRVhgcnD3tYlz/DHJgraNjPcM8RvOvkul/YGijY=;
        b=C6lvcA5YT7gJOHgrNM0mZZHRfeDJjp5kqhFvFreWT0ArgF6qfcAHN9kBqWhPZEl+jL
         AfzbBrx94sYUZ/LtHFR5kaiGc8oRSZOYpszl5VAj6A4bMQqZpaxFRhNUFpo5BTqEeKGC
         quNbUdfTn/WPfl2k6M6vzF4BgiOwXThHT3XXXak1VQEIs35ONalYPjgcaxNvx1C5ucGp
         adA73T2JhGuG3f3N5zBTA7fKvgELMhHjgcWsqrdGkoDncUW5HGNAD9NwYv8yuWZaIB02
         orgzM0B8ZaXl4ys0pAGJW5+1+CjkTnUhTxSl3PDx235eA3eJ4RCLTh7j1JCCUSOCWAYQ
         Ezqg==
X-Gm-Message-State: AOAM533uX9NcceJoqClxcEw0G5G/BgAVYczfE19OBxi0mpBN/fbuDsNx
        hmwCn6IozOieH3TZkv3YqqYWAXbsydo=
X-Google-Smtp-Source: ABdhPJxjnQvi+Z1GMyjKOXu84IXrjWYjICym5TdJMeiV6SsANTOlrECt7avCClScxNsW8C9yiF+10w==
X-Received: by 2002:adf:d1e3:0:b0:1f1:f268:aea1 with SMTP id g3-20020adfd1e3000000b001f1f268aea1mr1387416wrd.463.1646867000114;
        Wed, 09 Mar 2022 15:03:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b003897e440047sm6604941wmq.28.2022.03.09.15.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 15:03:19 -0800 (PST)
Message-Id: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 23:03:13 +0000
Subject: [PATCH v5 0/5] A design for future-proofing fsync() configuration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an implementation of an extensible configuration mechanism for
fsyncing persistent components of a repo.

The main goals are to separate the "what" to sync from the "how". There are
now two settings: core.fsync - Control the 'what', including the index.
core.fsyncMethod - Control the 'how'. Currently we support writeout-only and
full fsync.

Syncing of refs can be layered on top of core.fsync. And batch mode will be
layered on core.fsyncMethod. Once this series reaches 'seen', I'll submit
ns/batched-fsync to introduce batch mode. Please see
https://github.com/gitgitgadget/git/pull/1134.

core.fsyncObjectfiles is removed and we will issue a deprecation warning if
it's seen.

I'd like to get agreement on this direction before submitting batch mode to
the list. The batch mode series is available to view at

Please see [1], [2], and [3] for discussions that led to this series.

After this change, new persistent data files added to the repo will need to
be added to the fsync_component enum and documented in the
Documentation/config/core.txt text.

V5 changes:

 * Rebase onto main at c2162907e9
 * Add a patch to move CSPRNG platform includes to wrapper.c. This avoids
   build errors in compat/win32/flush.c and other files.
 * Move the documentation and aggregate options to the final patch in the
   series.
 * Define new aggregate options and guidance in line with Junio's suggestion
   to present the user with 'levels of safety' rather than a morass of
   detailed options.

V4 changes:

 * Rebase onto master at b23dac905bd.
 * Add a comment to write_pack_file indicating why we don't fsync when
   writing to stdout.
 * I kept the configuration schema as-is rather than switching to
   multi-value. The thinking here is that a stateless last-one-wins config
   schema (comma separated) will make it easier to achieve some holistic
   self-consistent fsync configuration for a particular repo.

V3 changes:

 * Remove relative path from git-compat-util.h include [4].
 * Updated newly added warning texts to have more context for localization
   [4].
 * Fixed tab spacing in enum fsync_action
 * Moved the fsync looping out to a helper and do it consistently. [4]
 * Changed commit description to use camelCase for config names. [5]
 * Add an optional fourth patch with derived-metadata so that the user can
   exclude a forward-compatible set of things that should be recomputable
   given existing data.

V2 changes:

 * Updated the documentation for core.fsyncmethod to be less certain.
   writeout-only probably does not do the right thing on Linux.
 * Split out the core.fsync=index change into its own commit.
 * Rename REPO_COMPONENT to FSYNC_COMPONENT. This is really specific to
   fsyncing, so the name should reflect that.
 * Re-add missing Makefile change for SYNC_FILE_RANGE.
 * Tested writeout-only mode, index syncing, and general config settings.

[1] https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gmail.com/
[2]
https://lore.kernel.org/git/dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im/
[3]
https://lore.kernel.org/git/pull.1076.git.git.1629856292.gitgitgadget@gmail.com/
[4]
https://lore.kernel.org/git/CANQDOdf8C4-haK9=Q_J4Cid8bQALnmGDm=SvatRbaVf+tkzqLw@mail.gmail.com/
[5] https://lore.kernel.org/git/211207.861r2opplg.gmgdl@evledraar.gmail.com/

Neeraj Singh (5):
  wrapper: move inclusion of CSPRNG headers the wrapper.c file
  core.fsyncmethod: add writeout-only mode
  core.fsync: introduce granular fsync control
  core.fsync: new option to harden the index
  core.fsync: documentation and user-friendly aggregate options

 Documentation/config/core.txt       | 51 +++++++++++++---
 Makefile                            |  6 ++
 builtin/fast-import.c               |  2 +-
 builtin/index-pack.c                |  4 +-
 builtin/pack-objects.c              | 24 +++++---
 bulk-checkin.c                      |  5 +-
 cache.h                             | 53 ++++++++++++++++-
 commit-graph.c                      |  3 +-
 compat/mingw.h                      |  3 +
 compat/win32/flush.c                | 28 +++++++++
 compat/winansi.c                    |  5 --
 config.c                            | 92 ++++++++++++++++++++++++++++-
 config.mak.uname                    |  3 +
 configure.ac                        |  8 +++
 contrib/buildsystems/CMakeLists.txt | 16 +++--
 csum-file.c                         |  5 +-
 csum-file.h                         |  3 +-
 environment.c                       |  3 +-
 git-compat-util.h                   | 36 +++++++----
 midx.c                              |  3 +-
 object-file.c                       |  3 +-
 pack-bitmap-write.c                 |  3 +-
 pack-write.c                        | 13 ++--
 read-cache.c                        | 19 ++++--
 wrapper.c                           | 78 ++++++++++++++++++++++++
 write-or-die.c                      | 11 ++--
 26 files changed, 413 insertions(+), 67 deletions(-)
 create mode 100644 compat/win32/flush.c


base-commit: c2162907e9aa884bdb70208389cb99b181620d51
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1093%2Fneerajsi-msft%2Fns%2Fcore-fsync-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1093/neerajsi-msft/ns/core-fsync-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1093

Range-diff vs v4:

 -:  ----------- > 1:  685b1db8880 wrapper: move inclusion of CSPRNG headers the wrapper.c file
 1:  51a218d100d ! 2:  da8cfc10bb4 core.fsyncmethod: add writeout-only mode
     @@ contrib/buildsystems/CMakeLists.txt
      @@ contrib/buildsystems/CMakeLists.txt: if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
       				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
       				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
     - 				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
     + 				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
      -	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
     -+	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c
     -+		compat/win32/flush.c compat/win32/path-utils.c
     - 		compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
     - 		compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
     - 		compat/nedmalloc/nedmalloc.c compat/strdup.c)
     +-		compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
     +-		compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
     +-		compat/nedmalloc/nedmalloc.c compat/strdup.c)
     ++	list(APPEND compat_SOURCES
     ++		compat/mingw.c
     ++		compat/winansi.c
     ++		compat/win32/flush.c
     ++		compat/win32/path-utils.c
     ++		compat/win32/pthread.c
     ++		compat/win32mmap.c
     ++		compat/win32/syslog.c
     ++		compat/win32/trace2_win32_process_info.c
     ++		compat/win32/dirent.c
     ++		compat/nedmalloc/nedmalloc.c
     ++		compat/strdup.c)
     + 	set(NO_UNIX_SOCKETS 1)
     + 
     + elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
      
       ## environment.c ##
      @@ environment.c: int zlib_compression_level = Z_BEST_SPEED;
     @@ wrapper.c: int xmkstemp_mode(char *filename_template, int mode)
      +
      +#ifdef __APPLE__
      +		/*
     -+		 * on macOS, fsync just causes filesystem cache writeback but does not
     -+		 * flush hardware caches.
     ++		 * On macOS, fsync just causes filesystem cache writeback but
     ++		 * does not flush hardware caches.
      +		 */
      +		return fsync_loop(fd);
      +#endif
      +
      +#ifdef HAVE_SYNC_FILE_RANGE
      +		/*
     -+		 * On linux 2.6.17 and above, sync_file_range is the way to issue
     -+		 * a writeback without a hardware flush. An offset of 0 and size of 0
     -+		 * indicates writeout of the entire file and the wait flags ensure that all
     -+		 * dirty data is written to the disk (potentially in a disk-side cache)
     -+		 * before we continue.
     ++		 * On linux 2.6.17 and above, sync_file_range is the way to
     ++		 * issue a writeback without a hardware flush. An offset of
     ++		 * 0 and size of 0 indicates writeout of the entire file and the
     ++		 * wait flags ensure that all dirty data is written to the disk
     ++		 * (potentially in a disk-side cache) before we continue.
      +		 */
      +
      +		return sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
     @@ wrapper.c: int xmkstemp_mode(char *filename_template, int mode)
      +
      +	case FSYNC_HARDWARE_FLUSH:
      +		/*
     -+		 * On some platforms fsync may return EINTR. Try again in this
     -+		 * case, since callers asking for a hardware flush may die if
     -+		 * this function returns an error.
     ++		 * On macOS, a special fcntl is required to really flush the
     ++		 * caches within the storage controller. As of this writing,
     ++		 * this is a very expensive operation on Apple SSDs.
      +		 */
      +#ifdef __APPLE__
      +		return fcntl(fd, F_FULLFSYNC);
 2:  7a164ba9571 ! 3:  e31886717b4 core.fsync: introduce granular fsync control
     @@ Commit message
          syncable components:
          * We issue a warning rather than an error for unrecognized
            components, so new configs can be used with old Git versions.
     -    * We support negation, so users can choose one of the default
     -      aggregate options and then remove components that they don't
     -      want. The user would then harden any new components added in
     -      a Git version update.
     +    * We support negation, so users can choose one of the aggregate
     +      options and then remove components that they don't want.
     +      Aggregate options are defined in a later patch in this series.
      
          This also supports the common request of doing absolutely no
          fysncing with the `core.fsync=none` value, which is expected
          to make the test suite faster.
      
     +    Complete documentation for the new setting is included in a later patch
     +    in the series so that it can be reviewed in final form.
     +
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Documentation/config/core.txt ##
     -@@ Documentation/config/core.txt: core.whitespace::
     -   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
     -   errors. The default tab width is 8. Allowed values are 1 to 63.
     - 
     -+core.fsync::
     -+	A comma-separated list of parts of the repository which should be
     -+	hardened via the core.fsyncMethod when created or modified. You can
     -+	disable hardening of any component by prefixing it with a '-'. Later
     -+	items take precedence over earlier ones in the list. For example,
     -+	`core.fsync=all,-pack-metadata` means "harden everything except pack
     -+	metadata." Items that are not hardened may be lost in the event of an
     -+	unclean system shutdown.
     -++
     -+* `none` disables fsync completely. This must be specified alone.
     -+* `loose-object` hardens objects added to the repo in loose-object form.
     -+* `pack` hardens objects added to the repo in packfile form.
     -+* `pack-metadata` hardens packfile bitmaps and indexes.
     -+* `commit-graph` hardens the commit graph file.
     -+* `objects` is an aggregate option that includes `loose-objects`, `pack`,
     -+  `pack-metadata`, and `commit-graph`.
     -+* `default` is an aggregate option that is equivalent to `objects,-loose-object`
     -+* `all` is an aggregate option that syncs all individual components above.
     -+
     - core.fsyncMethod::
     - 	A value indicating the strategy Git will use to harden repository data
     - 	using fsync and related primitives.
      @@ Documentation/config/core.txt: core.fsyncMethod::
         filesystem and storage hardware, data added to the repository may not be
         durable in the event of a system crash. This is the default mode on macOS.
     @@ cache.h: void reset_shared_repository(void);
      +				  FSYNC_COMPONENT_PACK_METADATA | \
      +				  FSYNC_COMPONENT_COMMIT_GRAPH)
      +
     -+#define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
     -+				  FSYNC_COMPONENT_PACK | \
     -+				  FSYNC_COMPONENT_PACK_METADATA | \
     -+				  FSYNC_COMPONENT_COMMIT_GRAPH)
     -+
     -+#define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
     -+			      FSYNC_COMPONENT_PACK | \
     -+			      FSYNC_COMPONENT_PACK_METADATA | \
     -+			      FSYNC_COMPONENT_COMMIT_GRAPH)
     -+
     -+
      +/*
      + * A bitmask indicating which components of the repo should be fsynced.
      + */
     @@ cache.h: int copy_file_with_time(const char *dst, const char *src, int mode);
       void write_or_die(int fd, const void *buf, size_t count);
       void fsync_or_die(int fd, const char *);
       
     -+inline void fsync_component_or_die(enum fsync_component component, int fd, const char *msg)
     ++static inline void fsync_component_or_die(enum fsync_component component, int fd, const char *msg)
      +{
      +	if (fsync_components & component)
      +		fsync_or_die(fd, msg);
     @@ config.c: static int git_parse_maybe_bool_text(const char *value)
      +	{ "pack", FSYNC_COMPONENT_PACK },
      +	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
      +	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
     -+	{ "objects", FSYNC_COMPONENTS_OBJECTS },
     -+	{ "default", FSYNC_COMPONENTS_DEFAULT },
     -+	{ "all", FSYNC_COMPONENTS_ALL },
      +};
      +
      +static enum fsync_component parse_fsync_components(const char *var, const char *string)
     @@ config.c: static int git_parse_maybe_bool_text(const char *value)
      +	enum fsync_component output = 0;
      +
      +	if (!strcmp(string, "none"))
     -+		return output;
     ++		return FSYNC_COMPONENT_NONE;
      +
      +	while (string) {
      +		int i;
     @@ midx.c: static int write_midx_internal(const char *object_dir,
      +			  CSUM_FSYNC | CSUM_HASH_IN_STREAM);
       	free_chunkfile(cf);
       
     - 	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
     + 	if (flags & MIDX_WRITE_REV_INDEX &&
      
       ## object-file.c ##
      @@ object-file.c: int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 3:  f217dba77a1 ! 4:  9da808ba743 core.fsync: new option to harden the index
     @@ Commit message
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     - ## Documentation/config/core.txt ##
     -@@ Documentation/config/core.txt: core.fsync::
     - * `pack` hardens objects added to the repo in packfile form.
     - * `pack-metadata` hardens packfile bitmaps and indexes.
     - * `commit-graph` hardens the commit graph file.
     -+* `index` hardens the index when it is modified.
     - * `objects` is an aggregate option that includes `loose-objects`, `pack`,
     -   `pack-metadata`, and `commit-graph`.
     - * `default` is an aggregate option that is equivalent to `objects,-loose-object`
     -
       ## cache.h ##
      @@ cache.h: enum fsync_component {
       	FSYNC_COMPONENT_PACK			= 1 << 1,
     @@ cache.h: enum fsync_component {
       };
       
       #define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
     -@@ cache.h: enum fsync_component {
     - #define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
     - 			      FSYNC_COMPONENT_PACK | \
     - 			      FSYNC_COMPONENT_PACK_METADATA | \
     --			      FSYNC_COMPONENT_COMMIT_GRAPH)
     -+			      FSYNC_COMPONENT_COMMIT_GRAPH | \
     -+			      FSYNC_COMPONENT_INDEX)
     - 
     - 
     - /*
      
       ## config.c ##
      @@ config.c: static const struct fsync_component_entry {
     @@ config.c: static const struct fsync_component_entry {
       	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
       	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
      +	{ "index", FSYNC_COMPONENT_INDEX },
     - 	{ "objects", FSYNC_COMPONENTS_OBJECTS },
     - 	{ "default", FSYNC_COMPONENTS_DEFAULT },
     - 	{ "all", FSYNC_COMPONENTS_ALL },
     + };
     + 
     + static enum fsync_component parse_fsync_components(const char *var, const char *string)
      
       ## read-cache.c ##
      @@ read-cache.c: static int record_ieot(void)
 4:  5c22a41c1f3 ! 5:  2d71346b10e core.fsync: add a `derived-metadata` aggregate option
     @@ Metadata
      Author: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Commit message ##
     -    core.fsync: add a `derived-metadata` aggregate option
     +    core.fsync: documentation and user-friendly aggregate options
      
     -    This commit adds an aggregate option that currently includes the
     -    commit-graph file and pack metadata (indexes and bitmaps).
     +    This commit adds aggregate options for the core.fsync setting that are
     +    more user-friendly. These options are specified in terms of 'levels of
     +    safety', indicating which Git operations are considered to be sync
     +    points for durability.
      
     -    The user may want to exclude this set from durability since they can be
     -    recomputed from other data if they wind up corrupt or missing.
     -
     -    This is split out from the other patches in the series since it is
     -    an optional nice-to-have that might be controversial.
     +    The new documentation is also included here in its entirety for ease of
     +    review.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Documentation/config/core.txt ##
     -@@ Documentation/config/core.txt: core.fsync::
     - * `pack-metadata` hardens packfile bitmaps and indexes.
     - * `commit-graph` hardens the commit graph file.
     - * `index` hardens the index when it is modified.
     --* `objects` is an aggregate option that includes `loose-objects`, `pack`,
     --  `pack-metadata`, and `commit-graph`.
     --* `default` is an aggregate option that is equivalent to `objects,-loose-object`
     -+* `objects` is an aggregate option that includes `loose-objects` and `pack`.
     -+* `derived-metadata` is an aggregate option that includes `pack-metadata` and `commit-graph`.
     -+* `default` is an aggregate option that is equivalent to `objects,derived-metadata,-loose-object`
     - * `all` is an aggregate option that syncs all individual components above.
     +@@ Documentation/config/core.txt: core.whitespace::
     +   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
     +   errors. The default tab width is 8. Allowed values are 1 to 63.
       
     ++core.fsync::
     ++	A comma-separated list of parts of the repository which should be
     ++	hardened via the core.fsyncMethod when created or modified. You can
     ++	disable hardening of any component by prefixing it with a '-'. Later
     ++	items take precedence over earlier ones in the comma-separated list.
     ++	For example, `core.fsync=all,-pack-metadata` means "harden everything
     ++	except pack metadata." Items that are not hardened may be lost in the
     ++	event of an unclean system shutdown. Unless you have special
     ++	requirements, it is recommended that you leave this option as default
     ++	or pick one of `committed`, `added`, or `all`.
     +++
     ++* `none` disables fsync completely. This value must be specified alone.
     ++* `loose-object` hardens objects added to the repo in loose-object form.
     ++* `pack` hardens objects added to the repo in packfile form.
     ++* `pack-metadata` hardens packfile bitmaps and indexes.
     ++* `commit-graph` hardens the commit graph file.
     ++* `index` hardens the index when it is modified.
     ++* `objects` is an aggregate option that is equivalent to
     ++  `loose-object,pack`.
     ++* `derived-metadata` is an aggregate option that is equivalent to
     ++  `pack-metadata,commit-graph`.
     ++* `default` is an aggregate option that is equivalent to
     ++  `objects,derived-metadata,-loose-object`. This mode is enabled by default.
     ++  It has good performance, but risks losing recent work if the system shuts
     ++  down uncleanly, since commits, trees, and blobs in loose-object form may be
     ++  lost.
     ++* `committed` is an aggregate option that is currently equivalent to
     ++  `objects`. This mode sacrifices some performance to ensure that all work
     ++  that is committed to the repository with `git commit` or similar commands
     ++  is preserved.
     ++* `added` is an aggregate option that is currently equivalent to
     ++  `committed,index`. This mode sacrifices additional performance to
     ++  ensure that the results of commands like `git add` and similar operations
     ++  are preserved.
     ++* `all` is an aggregate option that syncs all individual components above.
     ++
       core.fsyncMethod::
     + 	A value indicating the strategy Git will use to harden repository data
     + 	using fsync and related primitives.
      
       ## cache.h ##
      @@ cache.h: enum fsync_component {
     - 				  FSYNC_COMPONENT_COMMIT_GRAPH)
     + 	FSYNC_COMPONENT_INDEX			= 1 << 4,
     + };
       
     - #define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
     --				  FSYNC_COMPONENT_PACK | \
     +-#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
      -				  FSYNC_COMPONENT_PACK_METADATA | \
      -				  FSYNC_COMPONENT_COMMIT_GRAPH)
     ++#define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
      +				  FSYNC_COMPONENT_PACK)
      +
      +#define FSYNC_COMPONENTS_DERIVED_METADATA (FSYNC_COMPONENT_PACK_METADATA | \
      +					   FSYNC_COMPONENT_COMMIT_GRAPH)
     ++
     ++#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENTS_OBJECTS | \
     ++				  FSYNC_COMPONENTS_DERIVED_METADATA | \
     ++				  ~FSYNC_COMPONENT_LOOSE_OBJECT)
     ++
     ++#define FSYNC_COMPONENTS_COMMITTED (FSYNC_COMPONENTS_OBJECTS)
     ++
     ++#define FSYNC_COMPONENTS_ADDED (FSYNC_COMPONENTS_COMMITTED | \
     ++				FSYNC_COMPONENT_INDEX)
     ++
     ++#define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
     ++			      FSYNC_COMPONENT_PACK | \
     ++			      FSYNC_COMPONENT_PACK_METADATA | \
     ++			      FSYNC_COMPONENT_COMMIT_GRAPH | \
     ++			      FSYNC_COMPONENT_INDEX)
       
     - #define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
     - 			      FSYNC_COMPONENT_PACK | \
     + /*
     +  * A bitmask indicating which components of the repo should be fsynced.
      
       ## config.c ##
      @@ config.c: static const struct fsync_component_entry {
     + 	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
       	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
       	{ "index", FSYNC_COMPONENT_INDEX },
     - 	{ "objects", FSYNC_COMPONENTS_OBJECTS },
     ++	{ "objects", FSYNC_COMPONENTS_OBJECTS },
      +	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
     - 	{ "default", FSYNC_COMPONENTS_DEFAULT },
     - 	{ "all", FSYNC_COMPONENTS_ALL },
     ++	{ "default", FSYNC_COMPONENTS_DEFAULT },
     ++	{ "committed", FSYNC_COMPONENTS_COMMITTED },
     ++	{ "added", FSYNC_COMPONENTS_ADDED },
     ++	{ "all", FSYNC_COMPONENTS_ALL },
       };
     + 
     + static enum fsync_component parse_fsync_components(const char *var, const char *string)

-- 
gitgitgadget
