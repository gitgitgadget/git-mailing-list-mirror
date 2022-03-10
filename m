Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C94C433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344447AbiCJWov (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344422AbiCJWog (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:44:36 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A1196834
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r65so4160511wma.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MBhgy0RI+eerTuv4y0wEuXciH5AR6JGlTZdrnsvhmIc=;
        b=cK8/Axo+eXRNwIcVC8MrQSeaIeOyBvUMDjSaT9VLcdOykPtuVSAh+0Ve84BUKrVNXx
         Kv4JT3Dv4M967wihneWbVkB0SWcVaThKVbs9PoI3CcrleLv7kTaZgJxU9oLeVTFHwR3s
         /eQ2f5CucYCF1YflTl2qeti0sEecEm0BTgR4Tl9pqJ8qGb8L5ODHzNJf2V+M/GPirTGK
         cH4AgOG+ENbdhM3Y+/HP6y6oNZvyM+h20MNQ63/7TZeV0EdN8fVSUQFJmeqDtiYOUewB
         80W9Oh10VMxGz703/xmS/b7Xf07c51ee8HwkEf0GduHg+/BbdPX5AoJ+UkedMmlbxRoX
         SV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MBhgy0RI+eerTuv4y0wEuXciH5AR6JGlTZdrnsvhmIc=;
        b=4aNt8BgWJHoKuMGJAgDKxMroPBCKhpe192JbNSNK2X8xgdblsoKIkbK1qVMqqfjcV6
         5BjehO8+NJZ3u+asT3/nbu071fBe6yCe9DJdmh5SJygo9FBRSKLR5al5QiKQkSmza283
         YHq6AYqmXVGswKlIjaI4SJOToYfGxY6oe+YomZjbIGWF1B2YfVkzj6mdlYzWiTgEKbDI
         NHVAynCnnYyyJzAv1daoOYiLA5m5sicwzsQ42AeuuKlMkbs++EF2T8hYFmyJpVnqKGpV
         fxDhTLKfbdha5t5QriDzuBP70+ZaoJyCANvyBcUyP7SJI8IyAJzNIB9WGVTAKU5Odj88
         I4rw==
X-Gm-Message-State: AOAM530K78TySoW/M7O/Plfl87UGYJsgSBhrUT/9cxGbcPb73ZI7MF6k
        IcDCRGPmeAqMQL7ShTnGivUM4Y8y8yI=
X-Google-Smtp-Source: ABdhPJzV9ZJxkxSIiqXucI09Gswb6fjxDQE2SPqjTRoSk3PGHDlLr4l+Pbo0JlJa9y/KPctGL0hvog==
X-Received: by 2002:a05:600c:3583:b0:381:6974:e9d4 with SMTP id p3-20020a05600c358300b003816974e9d4mr13353700wmq.72.1646952207189;
        Thu, 10 Mar 2022 14:43:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8-20020a1c5408000000b00389bf11ba0csm8965616wmb.38.2022.03.10.14.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:43:26 -0800 (PST)
Message-Id: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 22:43:18 +0000
Subject: [PATCH v6 0/6] A design for future-proofing fsync() configuration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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

V6 changes:

 * Move only the windows csprng includes into wrapper.c rather than all of
   them. This fixes the specific build issue due to broken Windows headers.
   [6]
 * Split the configuration parsing of core.fsync from the mechanism to focus
   the review.
 * Incorporate Patrick's patch at [7] into the core.fsync mechanism patch.
 * Pick the stricter one of core.fsyncObjectFiles and (fsync_components &
   FSYNC_COMPONENT_LOOSE_OBJECTS), to respect the older setting.
 * Issue a deprecation warning but keep parsing and honoring
   core.fsyncObjectFiles.
 * Change configuration parsing of core.fsync to always start with the
   platform default. none resets to the empty set. The comma separated list
   implies a set without regards to ordering now. This follows Junio's
   suggestion in [8].
 * Change the documentation of the core.fsync option to reflect the way the
   new parsing code works.
 * The patch 7 and 8 of Patrick's series at [7] can be cherry-picked after
   being applied to ns/core-fsyncmethod.

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
[6]
https://lore.kernel.org/git/CANQDOdfZbOHZQt9Ah0t1AamTO2T7Gq0tmWX1jLqL6njE0LF6DA@mail.gmail.com/
[7]
https://lore.kernel.org/git/50e39f698a7c0cc06d3bc060e6dbc539ea693241.1646905589.git.ps@pks.im/
[8] https://lore.kernel.org/git/xmqqk0d1cxsv.fsf@gitster.g/

Neeraj Singh (6):
  wrapper: make inclusion of Windows csprng header tightly scoped
  core.fsyncmethod: add writeout-only mode
  core.fsync: introduce granular fsync control infrastructure
  core.fsync: add configuration parsing
  core.fsync: new option to harden the index
  core.fsync: documentation and user-friendly aggregate options

 Documentation/config/core.txt       | 58 ++++++++++++++++--
 Makefile                            |  6 ++
 builtin/fast-import.c               |  2 +-
 builtin/index-pack.c                |  4 +-
 builtin/pack-objects.c              | 24 +++++---
 bulk-checkin.c                      |  5 +-
 cache.h                             | 48 +++++++++++++++
 commit-graph.c                      |  3 +-
 compat/mingw.h                      |  3 +
 compat/win32/flush.c                | 28 +++++++++
 compat/winansi.c                    |  5 --
 config.c                            | 94 +++++++++++++++++++++++++++++
 config.mak.uname                    |  3 +
 configure.ac                        |  8 +++
 contrib/buildsystems/CMakeLists.txt | 16 +++--
 csum-file.c                         |  5 +-
 csum-file.h                         |  3 +-
 environment.c                       |  4 +-
 git-compat-util.h                   | 30 +++++++--
 midx.c                              |  3 +-
 object-file.c                       | 13 ++--
 pack-bitmap-write.c                 |  3 +-
 pack-write.c                        | 13 ++--
 read-cache.c                        | 19 ++++--
 wrapper.c                           | 71 ++++++++++++++++++++++
 write-or-die.c                      | 33 ++++++++--
 26 files changed, 444 insertions(+), 60 deletions(-)
 create mode 100644 compat/win32/flush.c


base-commit: c2162907e9aa884bdb70208389cb99b181620d51
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1093%2Fneerajsi-msft%2Fns%2Fcore-fsync-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1093/neerajsi-msft/ns/core-fsync-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1093

Range-diff vs v5:

 1:  685b1db8880 ! 1:  825079b6aa1 wrapper: move inclusion of CSPRNG headers the wrapper.c file
     @@ Metadata
      Author: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Commit message ##
     -    wrapper: move inclusion of CSPRNG headers the wrapper.c file
     +    wrapper: make inclusion of Windows csprng header tightly scoped
      
          Including NTSecAPI.h in git-compat-util.h causes build errors in any
     -    other file that includes winternl.h. That file was included in order to
     +    other file that includes winternl.h. NTSecAPI.h was included in order to
          get access to the RtlGenRandom cryptographically secure PRNG. This
     -    change scopes the inclusion of all PRNG headers to just the wrapper.c
     -    file, which is the only place it is really needed.
     +    change scopes the inclusion of ntsecapi.h to wrapper.c, which is the only
     +    place that it's actually needed.
     +
     +    The build breakage is due to the definition of UNICODE_STRING in
     +    NtSecApi.h:
     +        #ifndef _NTDEF_
     +        typedef LSA_UNICODE_STRING UNICODE_STRING, *PUNICODE_STRING;
     +        typedef LSA_STRING STRING, *PSTRING ;
     +        #endif
     +
     +    LsaLookup.h:
     +        typedef struct _LSA_UNICODE_STRING {
     +            USHORT Length;
     +            USHORT MaximumLength;
     +        #ifdef MIDL_PASS
     +            [size_is(MaximumLength/2), length_is(Length/2)]
     +        #endif // MIDL_PASS
     +            PWSTR  Buffer;
     +        } LSA_UNICODE_STRING, *PLSA_UNICODE_STRING;
     +
     +    winternl.h also defines UNICODE_STRING:
     +        typedef struct _UNICODE_STRING {
     +            USHORT Length;
     +            USHORT MaximumLength;
     +            PWSTR  Buffer;
     +        } UNICODE_STRING;
     +        typedef UNICODE_STRING *PUNICODE_STRING;
     +
     +    Both definitions have equivalent layouts. Apparently these internal
     +    Windows headers aren't designed to be included together. This is
     +    an oversight in the headers and does not represent an incompatibility
     +    between the APIs.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     @@ git-compat-util.h
       #endif
       
       #include <unistd.h>
     -@@
     - #else
     - #include <stdint.h>
     - #endif
     --#ifdef HAVE_ARC4RANDOM_LIBBSD
     --#include <bsd/stdlib.h>
     --#endif
     --#ifdef HAVE_GETRANDOM
     --#include <sys/random.h>
     --#endif
     - #ifdef NO_INTPTR_T
     - /*
     -  * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
      
       ## wrapper.c ##
      @@
     @@ wrapper.c
      +#include <NTSecAPI.h>
      +#undef SystemFunction036
      +#endif
     -+
     -+#ifdef HAVE_ARC4RANDOM_LIBBSD
     -+#include <bsd/stdlib.h>
     -+#endif
     -+#ifdef HAVE_GETRANDOM
     -+#include <sys/random.h>
     -+#endif
      +
       static int memory_limit_check(size_t size, int gentle)
       {
 2:  da8cfc10bb4 = 2:  a41bd4a06af core.fsyncmethod: add writeout-only mode
 3:  e31886717b4 ! 3:  64e2bdcdfd9 core.fsync: introduce granular fsync control
     @@ Metadata
      Author: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Commit message ##
     -    core.fsync: introduce granular fsync control
     +    core.fsync: introduce granular fsync control infrastructure
      
     -    This commit introduces the `core.fsync` configuration
     -    knob which can be used to control how components of the
     -    repository are made durable on disk.
     +    This commit introduces the infrastructure for the core.fsync
     +    configuration knob. The repository components we want to sync
     +    are identified by flags so that we can turn on or off syncing
     +    for specific components.
      
     -    This setting allows future extensibility of the list of
     -    syncable components:
     -    * We issue a warning rather than an error for unrecognized
     -      components, so new configs can be used with old Git versions.
     -    * We support negation, so users can choose one of the aggregate
     -      options and then remove components that they don't want.
     -      Aggregate options are defined in a later patch in this series.
     +    If core.fsyncObjectFiles is set and the core.fsync configuration
     +    also includes FSYNC_COMPONENT_LOOSE_OBJECT, we will fsync any
     +    loose objects. This picks the strictest data integrity behavior
     +    if core.fsync and core.fsyncObjectFiles are set to conflicting values.
      
     -    This also supports the common request of doing absolutely no
     -    fysncing with the `core.fsync=none` value, which is expected
     -    to make the test suite faster.
     +    This change introduces the currently unused fsync_component
     +    helper, which will be used by a later patch that adds fsyncing to
     +    the refs backend.
      
     -    Complete documentation for the new setting is included in a later patch
     -    in the series so that it can be reviewed in final form.
     +    Actual configuration and documentation of the fsync components
     +    list are in other patches in the series to separate review of
     +    the underlying mechanism from the policy of how it's configured.
      
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     - ## Documentation/config/core.txt ##
     -@@ Documentation/config/core.txt: core.fsyncMethod::
     -   filesystem and storage hardware, data added to the repository may not be
     -   durable in the event of a system crash. This is the default mode on macOS.
     - 
     --core.fsyncObjectFiles::
     --	This boolean will enable 'fsync()' when writing object files.
     --+
     --This is a total waste of time and effort on a filesystem that orders
     --data writes properly, but can be useful for filesystems that do not use
     --journalling (traditional UNIX filesystems) or that only journal metadata
     --and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
     --
     - core.preloadIndex::
     - 	Enable parallel index preload for operations like 'git diff'
     - +
     -
       ## builtin/fast-import.c ##
      @@ builtin/fast-import.c: static void end_packfile(void)
       		struct tag *t;
     @@ cache.h: void reset_shared_repository(void);
       extern int read_replace_refs;
       extern char *git_replace_ref_base;
       
     --extern int fsync_object_files;
     --extern int use_fsync;
      +/*
      + * These values are used to help identify parts of a repository to fsync.
      + * FSYNC_COMPONENT_NONE identifies data that will not be a persistent part of the
     @@ cache.h: void reset_shared_repository(void);
      + * A bitmask indicating which components of the repo should be fsynced.
      + */
      +extern enum fsync_component fsync_components;
     + extern int fsync_object_files;
     + extern int use_fsync;
       
     - enum fsync_method {
     - 	FSYNC_METHOD_FSYNC,
     -@@ cache.h: enum fsync_method {
     - };
     - 
     - extern enum fsync_method fsync_method;
     -+extern int use_fsync;
     - extern int core_preload_index;
     - extern int precomposed_unicode;
     - extern int protect_hfs;
      @@ cache.h: int copy_file_with_time(const char *dst, const char *src, int mode);
     + 
       void write_or_die(int fd, const void *buf, size_t count);
       void fsync_or_die(int fd, const char *);
     ++int fsync_component(enum fsync_component component, int fd);
     ++void fsync_component_or_die(enum fsync_component component, int fd, const char *msg);
       
     -+static inline void fsync_component_or_die(enum fsync_component component, int fd, const char *msg)
     -+{
     -+	if (fsync_components & component)
     -+		fsync_or_die(fd, msg);
     -+}
     -+
       ssize_t read_in_full(int fd, void *buf, size_t count);
       ssize_t write_in_full(int fd, const void *buf, size_t count);
     - ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
      
       ## commit-graph.c ##
      @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
       
       	if (ctx->split) {
      
     - ## config.c ##
     -@@ config.c: static int git_parse_maybe_bool_text(const char *value)
     - 	return -1;
     - }
     - 
     -+static const struct fsync_component_entry {
     -+	const char *name;
     -+	enum fsync_component component_bits;
     -+} fsync_component_table[] = {
     -+	{ "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
     -+	{ "pack", FSYNC_COMPONENT_PACK },
     -+	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
     -+	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
     -+};
     -+
     -+static enum fsync_component parse_fsync_components(const char *var, const char *string)
     -+{
     -+	enum fsync_component output = 0;
     -+
     -+	if (!strcmp(string, "none"))
     -+		return FSYNC_COMPONENT_NONE;
     -+
     -+	while (string) {
     -+		int i;
     -+		size_t len;
     -+		const char *ep;
     -+		int negated = 0;
     -+		int found = 0;
     -+
     -+		string = string + strspn(string, ", \t\n\r");
     -+		ep = strchrnul(string, ',');
     -+		len = ep - string;
     -+
     -+		if (*string == '-') {
     -+			negated = 1;
     -+			string++;
     -+			len--;
     -+			if (!len)
     -+				warning(_("invalid value for variable %s"), var);
     -+		}
     -+
     -+		if (!len)
     -+			break;
     -+
     -+		for (i = 0; i < ARRAY_SIZE(fsync_component_table); ++i) {
     -+			const struct fsync_component_entry *entry = &fsync_component_table[i];
     -+
     -+			if (strncmp(entry->name, string, len))
     -+				continue;
     -+
     -+			found = 1;
     -+			if (negated)
     -+				output &= ~entry->component_bits;
     -+			else
     -+				output |= entry->component_bits;
     -+		}
     -+
     -+		if (!found) {
     -+			char *component = xstrndup(string, len);
     -+			warning(_("ignoring unknown core.fsync component '%s'"), component);
     -+			free(component);
     -+		}
     -+
     -+		string = ep;
     -+	}
     -+
     -+	return output;
     -+}
     -+
     - int git_parse_maybe_bool(const char *value)
     - {
     - 	int v = git_parse_maybe_bool_text(value);
     -@@ config.c: static int git_default_core_config(const char *var, const char *value, void *cb)
     - 		return 0;
     - 	}
     - 
     -+	if (!strcmp(var, "core.fsync")) {
     -+		if (!value)
     -+			return config_error_nonbool(var);
     -+		fsync_components = parse_fsync_components(var, value);
     -+		return 0;
     -+	}
     -+
     - 	if (!strcmp(var, "core.fsyncmethod")) {
     - 		if (!value)
     - 			return config_error_nonbool(var);
     -@@ config.c: static int git_default_core_config(const char *var, const char *value, void *cb)
     - 	}
     - 
     - 	if (!strcmp(var, "core.fsyncobjectfiles")) {
     --		fsync_object_files = git_config_bool(var, value);
     -+		warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));
     - 		return 0;
     - 	}
     - 
     -
       ## csum-file.c ##
      @@ csum-file.c: static void free_hashfile(struct hashfile *f)
       	free(f);
     @@ csum-file.h: int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint
       void crc32_begin(struct hashfile *);
      
       ## environment.c ##
     -@@ environment.c: const char *git_attributes_file;
     - const char *git_hooks_path;
     - int zlib_compression_level = Z_BEST_SPEED;
     - int pack_compression_level = Z_DEFAULT_COMPRESSION;
     --int fsync_object_files;
     +@@ environment.c: int pack_compression_level = Z_DEFAULT_COMPRESSION;
     + int fsync_object_files;
       int use_fsync = -1;
       enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
      +enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
     @@ midx.c: static int write_midx_internal(const char *object_dir,
      
       ## object-file.c ##
      @@ object-file.c: int hash_object_file(const struct git_hash_algo *algo, const void *buf,
     + /* Finalize a file on disk, and close it. */
       static void close_loose_object(int fd)
       {
     - 	if (!the_repository->objects->odb->will_destroy) {
     +-	if (!the_repository->objects->odb->will_destroy) {
      -		if (fsync_object_files)
      -			fsync_or_die(fd, "loose object file");
     -+		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd, "loose object file");
     - 	}
     +-	}
     ++	if (the_repository->objects->odb->will_destroy)
     ++		goto out;
       
     ++	if (fsync_object_files > 0)
     ++		fsync_or_die(fd, "loose object file");
     ++	else
     ++		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
     ++				       "loose object file");
     ++
     ++out:
       	if (close(fd) != 0)
     + 		die_errno(_("error when closing loose object file"));
     + }
      
       ## pack-bitmap-write.c ##
      @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       	if (close_tempfile_gently(tempfile)) {
       		error(_("could not close '%s'"), get_tempfile_path(tempfile));
       		return -1;
     +
     + ## write-or-die.c ##
     +@@ write-or-die.c: void fprintf_or_die(FILE *f, const char *fmt, ...)
     + 	}
     + }
     + 
     +-void fsync_or_die(int fd, const char *msg)
     ++static int maybe_fsync(int fd)
     + {
     + 	if (use_fsync < 0)
     + 		use_fsync = git_env_bool("GIT_TEST_FSYNC", 1);
     + 	if (!use_fsync)
     +-		return;
     ++		return 0;
     + 
     + 	if (fsync_method == FSYNC_METHOD_WRITEOUT_ONLY &&
     + 	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0)
     +-		return;
     ++		return 0;
     ++
     ++	return git_fsync(fd, FSYNC_HARDWARE_FLUSH);
     ++}
     + 
     +-	if (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0)
     ++void fsync_or_die(int fd, const char *msg)
     ++{
     ++	if (maybe_fsync(fd) < 0)
     + 		die_errno("fsync error on '%s'", msg);
     + }
     + 
     ++int fsync_component(enum fsync_component component, int fd)
     ++{
     ++	if (fsync_components & component)
     ++		return maybe_fsync(fd);
     ++	return 0;
     ++}
     ++
     ++void fsync_component_or_die(enum fsync_component component, int fd, const char *msg)
     ++{
     ++	if (fsync_components & component)
     ++		fsync_or_die(fd, msg);
     ++}
     ++
     + void write_or_die(int fd, const void *buf, size_t count)
     + {
     + 	if (write_in_full(fd, buf, count) < 0) {
 -:  ----------- > 4:  6adc8dc1385 core.fsync: add configuration parsing
 4:  9da808ba743 ! 5:  757f6d0bbd2 core.fsync: new option to harden the index
     @@ cache.h: enum fsync_component {
       #define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
      
       ## config.c ##
     -@@ config.c: static const struct fsync_component_entry {
     +@@ config.c: static const struct fsync_component_name {
       	{ "pack", FSYNC_COMPONENT_PACK },
       	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
       	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
 5:  2d71346b10e ! 6:  7e4cc6e10a5 core.fsync: documentation and user-friendly aggregate options
     @@ Documentation/config/core.txt: core.whitespace::
         errors. The default tab width is 8. Allowed values are 1 to 63.
       
      +core.fsync::
     -+	A comma-separated list of parts of the repository which should be
     -+	hardened via the core.fsyncMethod when created or modified. You can
     -+	disable hardening of any component by prefixing it with a '-'. Later
     -+	items take precedence over earlier ones in the comma-separated list.
     -+	For example, `core.fsync=all,-pack-metadata` means "harden everything
     -+	except pack metadata." Items that are not hardened may be lost in the
     -+	event of an unclean system shutdown. Unless you have special
     -+	requirements, it is recommended that you leave this option as default
     -+	or pick one of `committed`, `added`, or `all`.
     ++	A comma-separated list of components of the repository that
     ++	should be hardened via the core.fsyncMethod when created or
     ++	modified.  You can disable hardening of any component by
     ++	prefixing it with a '-'.  Items that are not hardened may be
     ++	lost in the event of an unclean	system shutdown. Unless you
     ++	have special requirements, it is recommended that you leave
     ++	this option empty or pick one of `committed`, `added`,
     ++	or `all`.
      ++
     -+* `none` disables fsync completely. This value must be specified alone.
     ++When this configuration is encountered, the set of components starts with
     ++the platform default value, disabled components are removed, and additional
     ++components are added. `none` resets the state so that the platform default
     ++is ignored.
     +++
     ++The empty string resets the fsync configuration to the platform
     ++default. The platform default on most platform is equivalent to
     ++`core.fsync=committed,-loose-object`, which has good performance,
     ++but risks losing recent work in the event of an unclean system shutdown.
     +++
     ++* `none` clears the set of fsynced components.
      +* `loose-object` hardens objects added to the repo in loose-object form.
      +* `pack` hardens objects added to the repo in packfile form.
      +* `pack-metadata` hardens packfile bitmaps and indexes.
     @@ Documentation/config/core.txt: core.whitespace::
      +  `loose-object,pack`.
      +* `derived-metadata` is an aggregate option that is equivalent to
      +  `pack-metadata,commit-graph`.
     -+* `default` is an aggregate option that is equivalent to
     -+  `objects,derived-metadata,-loose-object`. This mode is enabled by default.
     -+  It has good performance, but risks losing recent work if the system shuts
     -+  down uncleanly, since commits, trees, and blobs in loose-object form may be
     -+  lost.
      +* `committed` is an aggregate option that is currently equivalent to
     -+  `objects`. This mode sacrifices some performance to ensure that all work
     ++  `objects`. This mode sacrifices some performance to ensure that work
      +  that is committed to the repository with `git commit` or similar commands
     -+  is preserved.
     ++  is hardened.
      +* `added` is an aggregate option that is currently equivalent to
      +  `committed,index`. This mode sacrifices additional performance to
      +  ensure that the results of commands like `git add` and similar operations
     -+  are preserved.
     ++  are hardened.
      +* `all` is an aggregate option that syncs all individual components above.
      +
       core.fsyncMethod::
     @@ cache.h: enum fsync_component {
        * A bitmask indicating which components of the repo should be fsynced.
      
       ## config.c ##
     -@@ config.c: static const struct fsync_component_entry {
     +@@ config.c: static const struct fsync_component_name {
       	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
       	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
       	{ "index", FSYNC_COMPONENT_INDEX },
      +	{ "objects", FSYNC_COMPONENTS_OBJECTS },
      +	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
     -+	{ "default", FSYNC_COMPONENTS_DEFAULT },
      +	{ "committed", FSYNC_COMPONENTS_COMMITTED },
      +	{ "added", FSYNC_COMPONENTS_ADDED },
      +	{ "all", FSYNC_COMPONENTS_ALL },

-- 
gitgitgadget
