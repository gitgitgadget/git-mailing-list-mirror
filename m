Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30595C4332F
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiCASoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbiCASoU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860D654D
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:36 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i8so4872242wrr.8
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nBFhkXu/Cmv9uB4rWSilNPbVUx4HmoaAaTEPrztCAMU=;
        b=Z6guyHjwTcNl8aAeauB3vvLbC7uWud1lrsINSHvajquvx9CK4lirf9biUhCJA1FkM/
         PRMTzw4Ckk0b6I5wrN5PQ8aH5UDoMVswdIhdFu1swpGs21N4qs6XgXO+SPRwFAov2RGx
         fTpUxZZe+GHAmu+HTP3XMDJtZPULwPpO1A7c1T9hOl5kXIXSkp2nIEi7v2DhuO0CJThE
         pSsm15gTDsVtgx1RKcIlQZf+0RUIWvmlo1ZYu/NyOGQtZcGFxubgbTrtAwQ7oigGy3sb
         JkLcU0BYeSC/+CbnkwgwpJqvhnwK3mzU+wgnS/pVJ08K+jqJkLFjJ6lnYL7RS/fPIlc8
         DBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nBFhkXu/Cmv9uB4rWSilNPbVUx4HmoaAaTEPrztCAMU=;
        b=brN2gIzy/xvayiV23NDMG1DSJpDmBrrWAaZpfQ4zDltK3tDhF+BxjSsO+UDLZbO7k1
         YBQuoUxUwbxYZcznn7CykmSf8CvlFwREv8YaUoW/urc4iBWP0kJqP8qnnVR23BL3wMcR
         rUbUXP32JK7g46LXDInu5FWZ5VUk0W8eOD51kgalueLdJinALweH4etpIFMrFQZXkPyk
         Rx3gQpC1RsnJZvfb7QNuFwkwwX9HeYUOZz0qijyeLuWLjOVCG+1yugoWYkI6cEa7/shG
         tMfIOvBjm0mUirmAxSwR8mxtHPRoHfknTO3WbZu7szJEOZM8ln8zOvGbEs2tUIjXoiMS
         63Uw==
X-Gm-Message-State: AOAM532AH+bXQx6/HQhrn7DuyExAmZE/pA9UceroC76vwuwA6iTQP8yF
        8YuaMPS2Rs4Yvz8wsp/oZmG5YY7d7eg=
X-Google-Smtp-Source: ABdhPJzBYdY82NJS1GPBzTdAhtXOPSyF3eX3dITRS5leNa28HfHoD2nPUHSzNnZMQxUW3oRskMDjfw==
X-Received: by 2002:adf:a319:0:b0:1ef:7cc6:d03 with SMTP id c25-20020adfa319000000b001ef7cc60d03mr14749330wrb.411.1646160214550;
        Tue, 01 Mar 2022 10:43:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c1d1000b003816edb5711sm3524405wms.26.2022.03.01.10.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:33 -0800 (PST)
Message-Id: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:02 +0000
Subject: [PATCH v6 00/30] Builtin FSMonitor Part 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V6 of Part 2 of my builtin FSmonitor series.

This version contains mostly cleanup based on feedback from V5. Of note:

 * I squashed in the 1_file fix for p7519.
 * I squashed in a commit from part 3 to optionally print the "running
   daemon on..." message on stderr.
 * I added a note to the documentation about incompatible changes around
   core.fsmonitor.
 * Removed/rephrased some obsolete NEEDSWORK items.

Tao has an ongoing parallel series to fix test-chmtime on Windows.
https://lore.kernel.org/all/pull.1166.git.1646041236.gitgitgadget@gmail.com/

If that lands first, we should be able to drop my 't/helper/test-chmtime:
skip directories on Windows' commit.

A followup Part 3 will contain additional refinements to the daemon and
additional tests. I drew the line here between Part 2 and 3 to make it
easier to review.

Jeff Hostetler (30):
  fsmonitor: enhance existing comments, clarify trivial response
    handling
  fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  fsmonitor: config settings are repository-specific
  fsmonitor: use IPC to query the builtin FSMonitor daemon
  fsmonitor: document builtin fsmonitor
  fsmonitor--daemon: add a built-in fsmonitor daemon
  fsmonitor--daemon: implement 'stop' and 'status' commands
  compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
  compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
  fsmonitor--daemon: implement 'run' command
  fsmonitor--daemon: implement 'start' command
  fsmonitor--daemon: add pathname classification
  fsmonitor--daemon: define token-ids
  fsmonitor--daemon: create token-based changed path cache
  compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on
    Windows
  compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
  compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on
    MacOS
  fsmonitor--daemon: implement handle_client callback
  help: include fsmonitor--daemon feature flag in version info
  t/helper/fsmonitor-client: create IPC client to talk to FSMonitor
    Daemon
  t7527: create test for fsmonitor--daemon
  t/perf: avoid copying builtin fsmonitor files into test repo
  t/helper/test-chmtime: skip directories on Windows
  t/perf/p7519: speed up test on Windows
  t/perf/p7519: add fsmonitor--daemon test cases
  fsmonitor--daemon: periodically truncate list of modified files
  fsmonitor--daemon: use a cookie file to sync with file system
  fsmonitor: force update index after large responses
  t7527: test status with untracked-cache and fsmonitor--daemon
  update-index: convert fsmonitor warnings to advise

 .gitignore                              |    1 +
 Documentation/config/core.txt           |   60 +-
 Documentation/git-fsmonitor--daemon.txt |   75 ++
 Documentation/git-update-index.txt      |    8 +-
 Makefile                                |   17 +
 builtin.h                               |    1 +
 builtin/fsmonitor--daemon.c             | 1473 +++++++++++++++++++++++
 builtin/update-index.c                  |   19 +-
 cache.h                                 |    1 -
 compat/fsmonitor/fsm-listen-darwin.c    |  499 ++++++++
 compat/fsmonitor/fsm-listen-win32.c     |  586 +++++++++
 compat/fsmonitor/fsm-listen.h           |   49 +
 config.c                                |   14 -
 config.h                                |    1 -
 config.mak.uname                        |   20 +
 contrib/buildsystems/CMakeLists.txt     |   10 +
 environment.c                           |    1 -
 fsmonitor--daemon.h                     |  166 +++
 fsmonitor-ipc.c                         |  171 +++
 fsmonitor-ipc.h                         |   48 +
 fsmonitor-settings.c                    |  115 ++
 fsmonitor-settings.h                    |   21 +
 fsmonitor.c                             |  216 +++-
 fsmonitor.h                             |   15 +-
 git.c                                   |    1 +
 help.c                                  |    4 +
 repo-settings.c                         |    1 +
 repository.h                            |    3 +
 t/README                                |    4 +-
 t/helper/test-chmtime.c                 |   15 +
 t/helper/test-fsmonitor-client.c        |  121 ++
 t/helper/test-tool.c                    |    1 +
 t/helper/test-tool.h                    |    1 +
 t/perf/p7519-fsmonitor.sh               |   61 +-
 t/perf/perf-lib.sh                      |    2 +-
 t/t7527-builtin-fsmonitor.sh            |  604 ++++++++++
 t/test-lib.sh                           |    6 +
 37 files changed, 4301 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt
 create mode 100644 builtin/fsmonitor--daemon.c
 create mode 100644 compat/fsmonitor/fsm-listen-darwin.c
 create mode 100644 compat/fsmonitor/fsm-listen-win32.c
 create mode 100644 compat/fsmonitor/fsm-listen.h
 create mode 100644 fsmonitor--daemon.h
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h
 create mode 100644 fsmonitor-settings.c
 create mode 100644 fsmonitor-settings.h
 create mode 100644 t/helper/test-fsmonitor-client.c
 create mode 100755 t/t7527-builtin-fsmonitor.sh


base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1041%2Fjeffhostetler%2Fbuiltin-fsmonitor-part2-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1041/jeffhostetler/builtin-fsmonitor-part2-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1041

Range-diff vs v5:

  1:  a5ecabb4d02 !  1:  10a34082fcc fsmonitor: enhance existing comments, clarify trivial response handling
     @@ Commit message
          fsmonitor: enhance existing comments, clarify trivial response handling
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## fsmonitor.c ##
      @@ fsmonitor.c: static int query_fsmonitor(int version, const char *last_update, struct strbuf *
  2:  365964b7664 !  2:  e1c946af2c5 fsmonitor-ipc: create client routines for git-fsmonitor--daemon
     @@ Commit message
          Stub in empty fsmonitor_ipc__*() functions for unsupported platforms.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Makefile ##
      @@ Makefile: LIB_OBJS += fetch-pack.o
     @@ fsmonitor-ipc.c (new)
      +#include "strbuf.h"
      +#include "trace2.h"
      +
     -+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
     ++#ifndef HAVE_FSMONITOR_DAEMON_BACKEND
     ++
     ++/*
     ++ * A trivial implementation of the fsmonitor_ipc__ API for unsupported
     ++ * platforms.
     ++ */
     ++
     ++int fsmonitor_ipc__is_supported(void)
     ++{
     ++	return 0;
     ++}
     ++
     ++const char *fsmonitor_ipc__get_path(void)
     ++{
     ++	return NULL;
     ++}
     ++
     ++enum ipc_active_state fsmonitor_ipc__get_state(void)
     ++{
     ++	return IPC_STATE__OTHER_ERROR;
     ++}
     ++
     ++int fsmonitor_ipc__send_query(const char *since_token,
     ++			      struct strbuf *answer)
     ++{
     ++	return -1;
     ++}
     ++
     ++int fsmonitor_ipc__send_command(const char *command,
     ++				struct strbuf *answer)
     ++{
     ++	return -1;
     ++}
     ++
     ++#else
      +
      +int fsmonitor_ipc__is_supported(void)
      +{
     @@ fsmonitor-ipc.c (new)
      +	return 0;
      +}
      +
     -+#else
     -+
     -+/*
     -+ * A trivial implementation of the fsmonitor_ipc__ API for unsupported
     -+ * platforms.
     -+ */
     -+
     -+int fsmonitor_ipc__is_supported(void)
     -+{
     -+	return 0;
     -+}
     -+
     -+const char *fsmonitor_ipc__get_path(void)
     -+{
     -+	return NULL;
     -+}
     -+
     -+enum ipc_active_state fsmonitor_ipc__get_state(void)
     -+{
     -+	return IPC_STATE__OTHER_ERROR;
     -+}
     -+
     -+int fsmonitor_ipc__send_query(const char *since_token,
     -+			      struct strbuf *answer)
     -+{
     -+	return -1;
     -+}
     -+
     -+int fsmonitor_ipc__send_command(const char *command,
     -+				struct strbuf *answer)
     -+{
     -+	return -1;
     -+}
     -+
      +#endif
      
       ## fsmonitor-ipc.h (new) ##
  3:  384516ce1a1 !  3:  ae622a517cf fsmonitor: config settings are repository-specific
     @@ Commit message
          restrictions to override the config values used.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Makefile ##
      @@ Makefile: LIB_OBJS += fmt-merge-msg.o
     @@ fsmonitor-settings.c (new)
      +
      +enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
      +{
     ++	if (!r)
     ++		r = the_repository;
     ++
      +	lookup_fsmonitor_settings(r);
      +
      +	return r->settings.fsmonitor->mode;
     @@ fsmonitor-settings.c (new)
      +
      +const char *fsm_settings__get_hook_path(struct repository *r)
      +{
     ++	if (!r)
     ++		r = the_repository;
     ++
      +	lookup_fsmonitor_settings(r);
      +
      +	return r->settings.fsmonitor->hook_path;
     @@ fsmonitor-settings.c (new)
      +
      +void fsm_settings__set_ipc(struct repository *r)
      +{
     ++	if (!r)
     ++		r = the_repository;
     ++
      +	lookup_fsmonitor_settings(r);
      +
      +	r->settings.fsmonitor->mode = FSMONITOR_MODE_IPC;
     @@ fsmonitor-settings.c (new)
      +
      +void fsm_settings__set_hook(struct repository *r, const char *path)
      +{
     ++	if (!r)
     ++		r = the_repository;
     ++
      +	lookup_fsmonitor_settings(r);
      +
      +	r->settings.fsmonitor->mode = FSMONITOR_MODE_HOOK;
     @@ fsmonitor-settings.c (new)
      +
      +void fsm_settings__set_disabled(struct repository *r)
      +{
     ++	if (!r)
     ++		r = the_repository;
     ++
      +	lookup_fsmonitor_settings(r);
      +
      +	r->settings.fsmonitor->mode = FSMONITOR_MODE_DISABLED;
     @@ fsmonitor.c: void remove_fsmonitor(struct index_state *istate)
       {
       	unsigned int i;
      -	int fsmonitor_enabled = git_config_get_fsmonitor();
     -+	struct repository *r = istate->repo ? istate->repo : the_repository;
     -+	int fsmonitor_enabled = (fsm_settings__get_mode(r) > FSMONITOR_MODE_DISABLED);
     ++	int fsmonitor_enabled = (fsm_settings__get_mode(istate->repo)
     ++				 > FSMONITOR_MODE_DISABLED);
       
       	if (istate->fsmonitor_dirty) {
       		if (fsmonitor_enabled) {
     @@ fsmonitor.h: int fsmonitor_is_trivial_response(const struct strbuf *query_result
       static inline int is_fsmonitor_refreshed(const struct index_state *istate)
       {
      -	return !core_fsmonitor || istate->fsmonitor_has_run_once;
     -+	struct repository *r = istate->repo ? istate->repo : the_repository;
     -+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
     ++	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(istate->repo);
      +
      +	return fsm_mode <= FSMONITOR_MODE_DISABLED ||
      +		istate->fsmonitor_has_run_once;
     @@ fsmonitor.h: static inline int is_fsmonitor_refreshed(const struct index_state *
       static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce)
       {
      -	if (core_fsmonitor && !(ce->ce_flags & CE_FSMONITOR_VALID)) {
     -+	struct repository *r = istate->repo ? istate->repo : the_repository;
     -+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
     ++	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(istate->repo);
      +
      +	if (fsm_mode > FSMONITOR_MODE_DISABLED &&
      +	    !(ce->ce_flags & CE_FSMONITOR_VALID)) {
     @@ fsmonitor.h: static inline void mark_fsmonitor_valid(struct index_state *istate,
       static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
       {
      -	if (core_fsmonitor) {
     -+	struct repository *r = istate->repo ? istate->repo : the_repository;
     -+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
     ++	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(istate->repo);
      +
      +	if (fsm_mode > FSMONITOR_MODE_DISABLED) {
       		ce->ce_flags &= ~CE_FSMONITOR_VALID;
  4:  8e738a83bc5 !  4:  55974867da5 fsmonitor: use IPC to query the builtin FSMonitor daemon
     @@ Commit message
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## fsmonitor.c ##
      @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
  5:  49e4c146e02 !  5:  ce42d5bbaf6 fsmonitor: document builtin fsmonitor
     @@ Commit message
          Create `git-fsmonitor--daemon` manual page and describe its features.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/config/core.txt ##
      @@ Documentation/config/core.txt: core.protectNTFS::
     @@ Documentation/config/core.txt: core.protectNTFS::
      +git by avoiding unnecessary scanning of files that have not changed.
      ++
      +See the "fsmonitor-watchman" section of linkgit:githooks[5].
     +++
     ++Note that if you concurrently use multiple versions of Git, such
     ++as one version on the command line and another version in an IDE
     ++tool, that the definition of `core.fsmonitor` was extended to
     ++allow boolean values in addition to hook pathnames.  Git versions
     ++2.35.1 and prior will not understand the boolean values and will
     ++consider the "true" or "false" values as hook pathnames to be
     ++invoked.  Git versions 2.26 thru 2.35.1 default to hook protocol
     ++V2 and will fall back to no fsmonitor (full scan).  Git versions
     ++prior to 2.26 default to hook protocol V1 and will silently
     ++assume there were no changes to report (no scan), so status
     ++commands may report incomplete results.  For this reason, it is
     ++best to upgrade all of your Git versions before using the built-in
     ++file system monitor.
       
       core.fsmonitorHookVersion::
      -	Sets the version of hook that is to be used when calling fsmonitor.
  6:  bdd7334da31 !  6:  9ce938c69b5 fsmonitor--daemon: add a built-in fsmonitor daemon
     @@ Commit message
      
          Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## .gitignore ##
      @@
  7:  9f00ada3dd3 !  7:  3bd7e6a051e fsmonitor--daemon: implement 'stop' and 'status' commands
     @@ Commit message
          system.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/fsmonitor--daemon.c ##
      @@
  8:  d6819bdad66 !  8:  92d3e54da7f compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
     @@ Commit message
          Stub in empty filesystem listener backend for fsmonitor--daemon on Windows.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Makefile ##
      @@ Makefile: all::
  9:  7de3d01cccc !  9:  f1219221270 compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
     @@ Commit message
          backend for Darwin (aka MacOS).
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## compat/fsmonitor/fsm-listen-darwin.c (new) ##
      @@
 10:  6fe5a2bc79e ! 10:  a3f94627cf6 fsmonitor--daemon: implement 'run' command
     @@ Commit message
          backends are still just stubs.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/fsmonitor--daemon.c ##
      @@
     @@ builtin/fsmonitor--daemon.c
      +#define FSMONITOR__IPC_THREADS "fsmonitor.ipcthreads"
      +static int fsmonitor__ipc_threads = 8;
      +
     ++#define FSMONITOR__ANNOUNCE_STARTUP "fsmonitor.announcestartup"
     ++static int fsmonitor__announce_startup = 0;
     ++
      +static int fsmonitor_config(const char *var, const char *value, void *cb)
      +{
      +	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
     @@ builtin/fsmonitor--daemon.c
      +		return 0;
      +	}
      +
     ++	if (!strcmp(var, FSMONITOR__ANNOUNCE_STARTUP)) {
     ++		int is_bool;
     ++		int i = git_config_bool_or_int(var, value, &is_bool);
     ++		if (i < 0)
     ++			return error(_("value of '%s' not bool or int: %d"),
     ++				     var, i);
     ++		fsmonitor__announce_startup = i;
     ++		return 0;
     ++	}
     ++
      +	return git_default_config(var, value, cb);
      +}
      +
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
      +		die("fsmonitor--daemon is already running '%s'",
      +		    the_repository->worktree);
      +
     -+	printf(_("running fsmonitor-daemon in '%s'\n"),
     -+	       the_repository->worktree);
     -+	fflush(stdout);
     ++	if (fsmonitor__announce_startup) {
     ++		fprintf(stderr, _("running fsmonitor-daemon in '%s'\n"),
     ++			the_repository->worktree);
     ++		fflush(stderr);
     ++	}
      +
      +	return !!fsmonitor_run_daemon();
      +}
 11:  69fc0998286 ! 11:  8de40b0fe8b fsmonitor--daemon: implement 'start' command
     @@ Commit message
          because they don't have a Win32 console attached to them.)
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/fsmonitor--daemon.c ##
      @@
     @@ builtin/fsmonitor--daemon.c: static const char * const builtin_fsmonitor__daemon
      +#define FSMONITOR__START_TIMEOUT "fsmonitor.starttimeout"
      +static int fsmonitor__start_timeout_sec = 60;
      +
     - static int fsmonitor_config(const char *var, const char *value, void *cb)
     - {
     - 	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
     + #define FSMONITOR__ANNOUNCE_STARTUP "fsmonitor.announcestartup"
     + static int fsmonitor__announce_startup = 0;
     + 
      @@ builtin/fsmonitor--daemon.c: static int fsmonitor_config(const char *var, const char *value, void *cb)
       		return 0;
       	}
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_config(const char *var, const
      +		return 0;
      +	}
      +
     - 	return git_default_config(var, value, cb);
     - }
     - 
     + 	if (!strcmp(var, FSMONITOR__ANNOUNCE_STARTUP)) {
     + 		int is_bool;
     + 		int i = git_config_bool_or_int(var, value, &is_bool);
      @@ builtin/fsmonitor--daemon.c: done:
       	return err;
       }
       
      -static int try_to_run_foreground_daemon(void)
     -+static int try_to_run_foreground_daemon(int free_console)
     ++static int try_to_run_foreground_daemon(int detach_console)
       {
       	/*
       	 * Technically, we don't need to probe for an existing daemon
      @@ builtin/fsmonitor--daemon.c: static int try_to_run_foreground_daemon(void)
     - 	       the_repository->worktree);
     - 	fflush(stdout);
     + 		fflush(stderr);
     + 	}
       
      +#ifdef GIT_WINDOWS_NATIVE
     -+	if (free_console)
     ++	if (detach_console)
      +		FreeConsole();
      +#endif
      +
     @@ builtin/fsmonitor--daemon.c: static int try_to_run_foreground_daemon(void)
      +		die("fsmonitor--daemon is already running '%s'",
      +		    the_repository->worktree);
      +
     -+	printf(_("starting fsmonitor-daemon in '%s'\n"),
     -+	       the_repository->worktree);
     -+	fflush(stdout);
     ++	if (fsmonitor__announce_startup) {
     ++		fprintf(stderr, _("starting fsmonitor-daemon in '%s'\n"),
     ++			the_repository->worktree);
     ++		fflush(stderr);
     ++	}
      +
      +	cp.git_cmd = 1;
      +
      +	strvec_push(&cp.args, "fsmonitor--daemon");
      +	strvec_push(&cp.args, "run");
     -+	strvec_push(&cp.args, "--free-console");
     ++	strvec_push(&cp.args, "--detach");
      +	strvec_pushf(&cp.args, "--ipc-threads=%d", fsmonitor__ipc_threads);
      +
      +	cp.no_stdin = 1;
     @@ builtin/fsmonitor--daemon.c: static int try_to_run_foreground_daemon(void)
       int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
       {
       	const char *subcmd;
     -+	int free_console = 0;
     ++	int detach_console = 0;
       
       	struct option options[] = {
     -+		OPT_BOOL(0, "free-console", &free_console, N_("free console")),
     ++		OPT_BOOL(0, "detach", &detach_console, N_("detach from console")),
       		OPT_INTEGER(0, "ipc-threads",
       			    &fsmonitor__ipc_threads,
       			    N_("use <n> ipc worker threads")),
      +		OPT_INTEGER(0, "start-timeout",
      +			    &fsmonitor__start_timeout_sec,
     -+			    N_("Max seconds to wait for background daemon startup")),
     ++			    N_("max seconds to wait for background daemon startup")),
      +
       		OPT_END()
       	};
     @@ builtin/fsmonitor--daemon.c: int cmd_fsmonitor__daemon(int argc, const char **ar
      +
       	if (!strcmp(subcmd, "run"))
      -		return !!try_to_run_foreground_daemon();
     -+		return !!try_to_run_foreground_daemon(free_console);
     ++		return !!try_to_run_foreground_daemon(detach_console);
       
       	if (!strcmp(subcmd, "stop"))
       		return !!do_as_client__send_stop();
 12:  21c099c5197 ! 12:  e5d419b1ea0 fsmonitor--daemon: add pathname classification
     @@ Commit message
          When we register for filesystem notifications on a directory,
          we get events for everything (recursively) in the directory.
          We want to report to clients changes to tracked and untracked
     -    paths within the working directory.  We do not want to report
     -    changes within the .git directory, for example.
     +    paths within the working directory proper.  We do not want to
     +    report changes within the .git directory, for example.
      
          This classification will be used in a later commit by the
          different backends to classify paths as events are received.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/fsmonitor--daemon.c ##
      @@ builtin/fsmonitor--daemon.c: static int handle_client(void *data,
     @@ fsmonitor--daemon.h: struct fsmonitor_daemon_state {
      + * that to decide whether clients are told about them.  (And to watch
      + * for file system synchronization events.)
      + *
     ++ * The daemon only collects and reports on the set of modified paths
     ++ * within the working directory (proper).
     ++ *
      + * The client should only care about paths within the working
      + * directory proper (inside the working directory and not ".git" nor
      + * inside of ".git/").  That is, the client has read the index and is
      + * asking for a list of any paths in the working directory that have
      + * been modified since the last token.  The client does not care about
     -+ * file system changes within the .git directory (such as new loose
     ++ * file system changes within the ".git/" directory (such as new loose
      + * objects or packfiles).  So the client will only receive paths that
      + * are classified as IS_WORKDIR_PATH.
      + *
     ++ * Note that ".git" is usually a directory and is therefore inside
     ++ * the cone of the FS watch that we have on the working directory root,
     ++ * so we will also get FS events for disk activity on and within ".git/"
     ++ * that we need to respond to or filter from the client.
     ++ *
     ++ * But Git also allows ".git" to be a *file* that points to a GITDIR
     ++ * outside of the working directory.  When this happens, we need to
     ++ * create FS watches on both the working directory root *and* on the
     ++ * (external) GITDIR root.  (The latter is required because we put
     ++ * cookie files inside it and use them to sync with the FS event
     ++ * stream.)
     ++ *
     ++ * Note that in the context of this discussion, I'm using "GITDIR"
     ++ * to only mean an external GITDIR referenced by a ".git" file.
     ++ *
     ++ * The platform FS event backends will receive watch-specific
     ++ * relative paths (except for those OS's that always emit absolute
     ++ * paths).  We use the following enum and routines to classify each
     ++ * path so that we know how to handle it.  There is a slight asymmetry
     ++ * here because ".git/" is inside the working directory and the
     ++ * (external) GITDIR is not, and therefore how we handle events may
     ++ * vary slightly, so I have different enums for "IS...DOT_GIT..." and
     ++ * "IS...GITDIR...".
     ++ *
      + * The daemon uses the IS_DOT_GIT and IS_GITDIR internally to mean the
     -+ * exact ".git" directory or GITDIR.  If the daemon receives a delete
     -+ * event for either of these directories, it will automatically
     -+ * shutdown, for example.
     ++ * exact ".git" file/directory or GITDIR directory.  If the daemon
     ++ * receives a delete event for either of these paths, it will
     ++ * automatically shutdown, for example.
      + *
      + * Note that the daemon DOES NOT explicitly watch nor special case the
     -+ * ".git/index" file.  The daemon does not read the index and does not
     -+ * have any internal index-relative state.  The daemon only collects
     -+ * the set of modified paths within the working directory.
     ++ * index.  The daemon does not read the index nor have any internal
     ++ * index-relative state, so there are no "IS...INDEX..." enum values.
      + */
      +enum fsmonitor_path_type {
      +	IS_WORKDIR_PATH = 0,
 13:  72979c35ceb ! 13:  c2f3668a866 fsmonitor--daemon: define token-ids
     @@ Commit message
          overall token naming scheme.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/fsmonitor--daemon.c ##
      @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
 14:  8d1db644409 ! 14:  bd492d13fb1 fsmonitor--daemon: create token-based changed path cache
     @@ Commit message
          paths within these batches for efficient presentation to clients.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/fsmonitor--daemon.c ##
      @@ builtin/fsmonitor--daemon.c: struct fsmonitor_token_data {
     @@ builtin/fsmonitor--daemon.c: static struct fsmonitor_token_data *fsmonitor_new_t
      + *     We should create a new token and start fresh (as if we just
      + *     booted up).
      + *
     -+ * If there are no concurrent threads readering the current token data
     ++ * If there are no concurrent threads reading the current token data
      + * series, we can free it now.  Otherwise, let the last reader free
      + * it.
      + *
 15:  98c5adf8ca0 ! 15:  6b5b3d08227 compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
     @@ Commit message
          into batches and publish.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## compat/fsmonitor/fsm-listen-win32.c ##
      @@
 16:  a3b881315fa ! 16:  cdef9730b3f compat/fsmonitor/fsm-listen-darwin: add macos header files for FSEvent
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    compat/fsmonitor/fsm-listen-darwin: add macos header files for FSEvent
     +    compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
      
          Include MacOS system declarations to allow us to use FSEvent and
     -    CoreFoundation APIs.  We need GCC and clang versions because of
     -    compiler and header file conflicts.
     +    CoreFoundation APIs.  We need different versions of the declarations
     +    for GCC vs. clang because of compiler and header file conflicts.
      
          While it is quite possible to #include Apple's CoreServices.h when
          compiling C source code with clang, trying to build it with GCC
     @@ Commit message
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## compat/fsmonitor/fsm-listen-darwin.c ##
      @@
     -+#if defined(__GNUC__)
     ++#ifndef __clang__
      +/*
      + * It is possible to #include CoreFoundation/CoreFoundation.h when compiling
      + * with clang, but not with GCC as of time of writing.
 17:  162e357db72 ! 17:  aabfebd3a41 compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
     @@ Commit message
          Co-authored-by: Kevin Willford <Kevin.Willford@microsoft.com>
          Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## compat/fsmonitor/fsm-listen-darwin.c ##
     -@@
     --#if defined(__GNUC__)
     -+#ifndef __clang__
     - /*
     -  * It is possible to #include CoreFoundation/CoreFoundation.h when compiling
     -  * with clang, but not with GCC as of time of writing.
      @@ compat/fsmonitor/fsm-listen-darwin.c: void FSEventStreamRelease(FSEventStreamRef stream);
       #include "cache.h"
       #include "fsmonitor.h"
     @@ compat/fsmonitor/fsm-listen-darwin.c: void FSEventStreamRelease(FSEventStreamRef
      +}
      +
      +/*
     -+ * NEEDSWORK: Investigate the proper value for the `latency` argument
     -+ * in the call to `FSEventStreamCreate()`.  I'm not sure that this
     -+ * needs to be a config setting or just something that we tune after
     -+ * some testing.
     ++ * In the call to `FSEventStreamCreate()` to setup our watch, the
     ++ * `latency` argument determines the frequency of calls to our callback
     ++ * with new FS events.  Too slow and events get dropped; too fast and
     ++ * we burn CPU unnecessarily.  Since it is rather obscure, I don't
     ++ * think this needs to be a config setting.  I've done extensive
     ++ * testing on my systems and chosen the value below.  It gives good
     ++ * results and I've not seen any dropped events.
      + *
      + * With a latency of 0.1, I was seeing lots of dropped events during
      + * the "touch 100000" files test within t/perf/p7519, but with a
     -+ * latency of 0.001 I did not see any dropped events.  So the
     -+ * "correct" value may be somewhere in between.
     ++ * latency of 0.001 I did not see any dropped events.  So I'm going
     ++ * to assume that this is the "correct" value.
      + *
      + * https://developer.apple.com/documentation/coreservices/1443980-fseventstreamcreate
      + */
 18:  3de1c43beaf ! 18:  0896e72e2b8 fsmonitor--daemon: implement handle_client callback
     @@ Commit message
          relative to the provided token.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/fsmonitor--daemon.c ##
      @@
 19:  3517c4a3c13 ! 19:  bc240a9e665 help: include fsmonitor--daemon feature flag in version info
     @@ Commit message
      
          This can be used by test scripts for prereq testing.  Granted, tests
          could just try `git fsmonitor--daemon status` and look for a 128 exit
     -    code or grep for a "not supported" message on stderr, but this is
     -    rather obscure.
     +    code or grep for a "not supported" message on stderr, but these
     +    methods are rather obscure.
      
          The main advantage is that the feature message will automatically
          appear in bug reports and other support requests.
      
     +    This concept was also used during the development of Scalar for
     +    similar reasons.
     +
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## help.c ##
      @@
 20:  4ffc2ddf516 ! 20:  2b563c240eb t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
     @@ Commit message
          Create an IPC client to send query and flush commands to the daemon.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Makefile ##
      @@ Makefile: TEST_BUILTINS_OBJS += test-dump-split-index.o
 21:  d93310a7c64 ! 21:  db8809da089 t7527: create test for fsmonitor--daemon
     @@ Commit message
          t7527: create test for fsmonitor--daemon
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## t/t7527-builtin-fsmonitor.sh (new) ##
      @@
 22:  27e47108908 ! 22:  15bd5aaff36 t/perf: avoid copying builtin fsmonitor files into test repo
     @@ Commit message
          .git/fsmonitor--daemon*, so it is simple to exclude them.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## t/perf/perf-lib.sh ##
      @@ t/perf/perf-lib.sh: test_perf_copy_repo_contents () {
 23:  6cba1d950b0 ! 23:  4cb97918d20 t/helper/test-chmtime: skip directories on Windows
     @@ Commit message
          an empty directory on disk.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## t/helper/test-chmtime.c ##
      @@ t/helper/test-chmtime.c: int cmd__chmtime(int argc, const char **argv)
 24:  fcf843a0d42 ! 24:  a70748b4640 t/perf/p7519: speed up test on Windows
     @@ Commit message
          on Windows because of process creation overhead.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## t/perf/p7519-fsmonitor.sh ##
      @@ t/perf/p7519-fsmonitor.sh: then
     @@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
      -	for i in $(test_seq 1 100); do touch 100_files/$i || return 1; done &&
      -	for i in $(test_seq 1 1000); do touch 1000_files/$i || return 1; done &&
      -	for i in $(test_seq 1 10000); do touch 10000_files/$i || return 1; done &&
     -+	touch_files 1 &&
     ++	: 1_file directory should be left empty &&
      +	touch_files 10 &&
      +	touch_files 100 &&
      +	touch_files 1000 &&
 25:  198f47bda5a ! 25:  b0c9c9c7a40 t/perf/p7519: add fsmonitor--daemon test cases
     @@ Commit message
          the "Simple IPC" interface.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## t/perf/p7519-fsmonitor.sh ##
      @@ t/perf/p7519-fsmonitor.sh: test_perf_w_drop_caches () {
 26:  19993c130d2 ! 26:  64a5b741670 fsmonitor--daemon: periodically truncate list of modified files
     @@ Commit message
          they are considered obsolete.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/fsmonitor--daemon.c ##
      @@ builtin/fsmonitor--daemon.c: static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
 27:  f47a763dc26 ! 27:  5b06eb5d0e6 fsmonitor--daemon: use a cookie file to sync with file system
     @@ Commit message
          of `FSeventStreamCreate()`.  The kernel only signals every `latency`
          seconds, but does not guarantee that the kernel queue is completely
          drained, so we may have to wait more than one interval.  If we
     -    increase the frequency, the system is more likely to drop events.
     +    increase the latency, the system is more likely to drop events.
          We avoid these issues by having each client thread create a unique
          cookie file and then wait until it is seen in the event stream.
      
          Co-authored-by: Kevin Willford <Kevin.Willford@microsoft.com>
          Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/fsmonitor--daemon.c ##
      @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
      +		unlink(cookie_pathname.buf);
      +
      +		/*
     -+		 * NEEDSWORK: This is an infinite wait (well, unless another
     ++		 * Technically, this is an infinite wait (well, unless another
      +		 * thread sends us an abort).  I'd like to change this to
      +		 * use `pthread_cond_timedwait()` and return an error/timeout
     -+		 * and let the caller do the trivial response thing.
     ++		 * and let the caller do the trivial response thing, but we
     ++		 * don't have that routine in our thread-utils.
     ++		 *
     ++		 * After extensive beta testing I'm not really worried about
     ++		 * this.  Also note that the above open() and unlink() calls
     ++		 * will cause at least two FS events on that path, so the odds
     ++		 * of getting stuck are pretty slim.
      +		 */
      +		while (cookie->result == FCIR_INIT)
      +			pthread_cond_wait(&state->cookies_cond,
     @@ builtin/fsmonitor--daemon.c: static void fsmonitor_free_token_data(struct fsmoni
      + * [2] Some of those lost events may have been for cookie files.  We
      + *     should assume the worst and abort them rather letting them starve.
      + *
     -  * If there are no concurrent threads readering the current token data
     +  * If there are no concurrent threads reading the current token data
        * series, we can free it now.  Otherwise, let the last reader free
        * it.
      @@ builtin/fsmonitor--daemon.c: static void with_lock__do_force_resync(struct fsmonitor_daemon_state *state)
     @@ builtin/fsmonitor--daemon.c: done:
       	strbuf_release(&state.path_worktree_watch);
       	strbuf_release(&state.path_gitdir_watch);
      +	strbuf_release(&state.path_cookie_prefix);
     -+
     -+	/*
     -+	 * NEEDSWORK: Consider "rm -rf <gitdir>/<fsmonitor-dir>"
     -+	 */
       
       	return err;
       }
 28:  aec44a21afd ! 28:  1fd5439de03 fsmonitor: force update index after large responses
     @@ Commit message
          unnecessarily spend time actually scanning them during each command.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## fsmonitor.c ##
      @@ fsmonitor.c: static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
     @@ fsmonitor.c: static void fsmonitor_refresh_callback(struct index_state *istate,
      + * will be updated automatically the first time the user touches
      + * a tracked file and causes a command like `git status` to
      + * update an mtime to be updated and/or set a flag bit.
     -+ *
     -+ * NEEDSWORK: Does this need to be a config value?
      + */
      +static int fsmonitor_force_update_threshold = 100;
      +
 29:  d6039987df8 ! 29:  6fc1430285f t7527: test status with untracked-cache and fsmonitor--daemon
     @@ Commit message
          identical.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## t/t7527-builtin-fsmonitor.sh ##
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'setup' '
 30:  5117fbdfc63 ! 30:  b915b95cc2f update-index: convert fsmonitor warnings to advise
     @@ Commit message
          update-index: convert fsmonitor warnings to advise
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/update-index.c ##
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)

-- 
gitgitgadget
