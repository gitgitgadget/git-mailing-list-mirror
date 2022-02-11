Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD9AC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353525AbiBKU4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:56:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353474AbiBKU41 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F6ECFC
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j26so6338094wrb.7
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IHfyBt0l7IJm+4YsPZ1kKEV2rXhCIDqYIIPCPV2I1SQ=;
        b=QaQxc2Yc4ByJZoDCUxPZWH+knMl1qIBwbNf/qpTpB0awwox7fIQRBus4KyB2AgNRdA
         /wYYo9dwjV9fHYEKntVG3Ir/yYgc5R8qqwJWYcFTAflnckEINH5eY6vRa1YuQ929jxhK
         y2kgXFW8M67+Bwad/q2JnOGwNEqW5RoXlw3eDwk9BDB/+/C+oWmurqDWnbX7wCAaWgMY
         kfaf5uv+HnAfpep9z42+h5MX5UJJcc6Dklodv3AjX1Xu55tFlnmeFSCSDmovK88Dzicl
         9P5tt6jycLs0KqkiUHIYpiMbkpXvZEerwVylubAqgQDsQ82k88iZdnLtEWfiPIRA6M81
         zuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IHfyBt0l7IJm+4YsPZ1kKEV2rXhCIDqYIIPCPV2I1SQ=;
        b=2HJ7rHaIS9rqqj7ptVebW0grnhw344IILP1mnVaZGZRoRFS3im5eTQGN5GKWhFbFBO
         zM8yO47+iYF0TkA5x+mA4PBLLdD4h3WQrhSYdS0AE/fhjcXl+9jBomnmxSnH37F4kugK
         KGk779a0YyxjE/rKK+wXkIukNkVbNNh7k/18PsjPaPo+/jVOjitx2JkgqWAT+WtfUdoc
         sJxArlrWyZpDgIg3ABtn0jitNA56dL1y5T7ib0F7iczEt2eNNVJvPuchpqPJrV2Km3Xu
         7dl2hZVIhf/vwHkq6/L0+ATddMPAvirGA6lSmkFk+x3w1V/9ZYXM5k3RLNIIk4JMo7+h
         6xlA==
X-Gm-Message-State: AOAM531Vr3+HRwTuH9K+3a6JVmaRXqlIGjB/Epko8YDT1tdALUHqNGPL
        msZHryx7ZNf8dXayfTLDdc4q5rsuwJY=
X-Google-Smtp-Source: ABdhPJwDQ9HlIV9dEqSH+DbxN2GCgYiVQOKV8QTDrOu7Vjghu7wYwWEdJSHBsdL4a3p0TzQpwupeLQ==
X-Received: by 2002:adf:e8cd:: with SMTP id k13mr2731882wrn.270.1644612981007;
        Fri, 11 Feb 2022 12:56:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg23sm6316237wmb.5.2022.02.11.12.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:20 -0800 (PST)
Message-Id: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:55:49 +0000
Subject: [PATCH v5 00/30] Builtin FSMonitor Part 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V5 of Part 2 of my Builtin FSMonitor series. I apologize for the
delay since V4 that I submitted back in October. (Insert the usual $DayJob
excuse...)

I have rebased this branch onto the current "master" branch.

In this version I removed the core.useBuiltinFSMonitor config setting and
instead extended the existing core.fsmonitor. Previously it was defined as
containing the pathname to the FSMonitor hook script/application. Now it can
also have a boolean value to select the builtin FSMonitor daemon. This does
simplify a few things in the documentation and in the code.

There were other changes, but they are mostly just general cleanup and
coding style items. I also squashed in Junio's Dec 25 commits related to
coding style in the test scripts.

This version contains the client code and a MVP version of the daemon. It
can be be tested using t/t7527 and t/perf/p7519.

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
  compat/fsmonitor/fsm-listen-darwin: add macos header files for FSEvent
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
 Documentation/config/core.txt           |   46 +-
 Documentation/git-fsmonitor--daemon.txt |   75 ++
 Documentation/git-update-index.txt      |    8 +-
 Makefile                                |   17 +
 builtin.h                               |    1 +
 builtin/fsmonitor--daemon.c             | 1454 +++++++++++++++++++++++
 builtin/update-index.c                  |   19 +-
 cache.h                                 |    1 -
 compat/fsmonitor/fsm-listen-darwin.c    |  496 ++++++++
 compat/fsmonitor/fsm-listen-win32.c     |  586 +++++++++
 compat/fsmonitor/fsm-listen.h           |   49 +
 config.c                                |   14 -
 config.h                                |    1 -
 config.mak.uname                        |   20 +
 contrib/buildsystems/CMakeLists.txt     |   10 +
 environment.c                           |    1 -
 fsmonitor--daemon.h                     |  140 +++
 fsmonitor-ipc.c                         |  171 +++
 fsmonitor-ipc.h                         |   48 +
 fsmonitor-settings.c                    |  100 ++
 fsmonitor-settings.h                    |   21 +
 fsmonitor.c                             |  218 +++-
 fsmonitor.h                             |   18 +-
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
 37 files changed, 4229 insertions(+), 110 deletions(-)
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


base-commit: 2b9c1209706bc2ef0ab09fb0bdc7d405e225ce8b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1041%2Fjeffhostetler%2Fbuiltin-fsmonitor-part2-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1041/jeffhostetler/builtin-fsmonitor-part2-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1041

Range-diff vs v4:

  1:  ecc40795fa2 !  1:  a5ecabb4d02 fsmonitor: enhance existing comments
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor: enhance existing comments
     +    fsmonitor: enhance existing comments, clarify trivial response handling
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## fsmonitor.c ##
     +@@ fsmonitor.c: static int query_fsmonitor(int version, const char *last_update, struct strbuf *
     + 
     + 	if (result)
     + 		trace2_data_intmax("fsm_hook", NULL, "query/failed", result);
     +-	else {
     ++	else
     + 		trace2_data_intmax("fsm_hook", NULL, "query/response-length",
     + 				   query_result->len);
     + 
     +-		if (fsmonitor_is_trivial_response(query_result))
     +-			trace2_data_intmax("fsm_hook", NULL,
     +-					   "query/trivial-response", 1);
     +-	}
     +-
     + 	trace2_region_leave("fsm_hook", "query", NULL);
     + 
     + 	return result;
     + }
     + 
     +-int fsmonitor_is_trivial_response(const struct strbuf *query_result)
     +-{
     +-	static char trivial_response[3] = { '\0', '/', '\0' };
     +-
     +-	return query_result->len >= 3 &&
     +-		!memcmp(trivial_response,
     +-			&query_result->buf[query_result->len - 3], 3);
     +-}
     +-
     + static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
     + {
     + 	int i, len = strlen(name);
      @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     + 	struct strbuf last_update_token = STRBUF_INIT;
     + 	char *buf;
     + 	unsigned int i;
     ++	int is_trivial = 0;
     + 
     + 	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
     + 		return;
     +@@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     + 					query_success = 0;
     + 				} else {
     + 					bol = last_update_token.len + 1;
     ++					is_trivial = query_result.buf[bol] == '/';
     + 				}
     + 			} else if (hook_version < 0) {
     + 				hook_version = HOOK_INTERFACE_VERSION1;
     +@@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     + 		if (hook_version == HOOK_INTERFACE_VERSION1) {
     + 			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION1,
     + 				istate->fsmonitor_last_update, &query_result);
     ++			if (query_success)
     ++				is_trivial = query_result.buf[0] == '/';
     + 		}
     + 
     ++		if (is_trivial)
     ++			trace2_data_intmax("fsm_hook", NULL,
     ++					   "query/trivial-response", 1);
     ++
     + 		trace_performance_since(last_update, "fsmonitor process '%s'", core_fsmonitor);
     + 		trace_printf_key(&trace_fsmonitor, "fsmonitor process '%s' returned %s",
       			core_fsmonitor, query_success ? "success" : "failure");
       	}
       
      -	/* a fsmonitor process can return '/' to indicate all entries are invalid */
     +-	if (query_success && query_result.buf[bol] != '/') {
     +-		/* Mark all entries returned by the monitor as dirty */
      +	/*
      +	 * The response from FSMonitor (excluding the header token) is
      +	 * either:
     @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
      +	 *     information and that we should consider everything
      +	 *     invalid.  We call this a trivial response.
      +	 */
     - 	if (query_success && query_result.buf[bol] != '/') {
     --		/* Mark all entries returned by the monitor as dirty */
     ++	if (query_success && !is_trivial) {
      +		/*
      +		 * Mark all pathnames returned by the monitor as dirty.
      +		 *
     @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
      -		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
      -		 * if we actually changed entries or not */
      +		/*
     -+		 * We received a trivial response, so invalidate everything.
     ++		 * We failed to get a response or received a trivial response,
     ++		 * so invalidate everything.
      +		 *
      +		 * We only want to run the post index changed hook if
      +		 * we've actually changed entries, so keep track if we
  2:  82f17692128 !  2:  365964b7664 fsmonitor-ipc: create client routines for git-fsmonitor--daemon
     @@ fsmonitor-ipc.c (new)
      +
      +		trace2_data_intmax("fsm_client", NULL,
      +				   "query/response-length", answer->len);
     -+
     -+		if (fsmonitor_is_trivial_response(answer))
     -+			trace2_data_intmax("fsm_client", NULL,
     -+					   "query/trivial-response", 1);
     -+
      +		goto done;
      +
      +	case IPC_STATE__NOT_LISTENING:
  3:  882789b4dfe !  3:  384516ce1a1 fsmonitor: config settings are repository-specific
     @@ Commit message
          Create `fsm_settings__get_*()` getters to lazily look up fsmonitor-
          related config settings.
      
     -    Add support for the new `core.useBuiltinFSMonitor` config setting.
     -
          Get rid of the `core_fsmonitor` global variable.  Move the code to
          lookup the existing `core.fsmonitor` config value into the fsmonitor
          settings.
     @@ Commit message
          Create a hook pathname variable in `struct fsmonitor-settings` and
          only set it when in hook mode.
      
     +    Extend the definition of `core.fsmonitor` to be either a boolean
     +    or a hook pathname.  When true, the builtin FSMonitor is used.
     +    When false or unset, no FSMonitor (neither builtin nor hook) is
     +    used.
     +
          The existing `core_fsmonitor` global variable was used to store the
          pathname to the fsmonitor hook *and* it was used as a boolean to see
          if fsmonitor was enabled.  This dual usage and global visibility leads
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       	if (fsmonitor > 0) {
      -		if (git_config_get_fsmonitor() == 0)
      +		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
     -+
      +		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
     -+			warning(_("core.useBuiltinFSMonitor is unset; "
     -+				"set it if you really want to enable the "
     -+				"builtin fsmonitor"));
       			warning(_("core.fsmonitor is unset; "
     --				"set it if you really want to "
     --				"enable fsmonitor"));
     -+				"set it if you really want to enable the "
     -+				"hook-based fsmonitor"));
     + 				"set it if you really want to "
     + 				"enable fsmonitor"));
      +		}
       		add_fsmonitor(&the_index);
       		report(_("fsmonitor enabled"));
       	} else if (!fsmonitor) {
      -		if (git_config_get_fsmonitor() == 1)
      +		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
     -+		if (fsm_mode == FSMONITOR_MODE_IPC)
     -+			warning(_("core.useBuiltinFSMonitor is set; "
     -+				"remove it if you really want to "
     -+				"disable fsmonitor"));
     -+		if (fsm_mode == FSMONITOR_MODE_HOOK)
     ++		if (fsm_mode > FSMONITOR_MODE_DISABLED)
       			warning(_("core.fsmonitor is set; "
       				"remove it if you really want to "
       				"disable fsmonitor"));
     @@ fsmonitor-settings.c (new)
      +	char *hook_path;
      +};
      +
     -+void fsm_settings__set_ipc(struct repository *r)
     ++static void lookup_fsmonitor_settings(struct repository *r)
      +{
     -+	struct fsmonitor_settings *s = r->settings.fsmonitor;
     ++	struct fsmonitor_settings *s;
     ++	const char *const_str;
     ++	int bool_value;
      +
     -+	s->mode = FSMONITOR_MODE_IPC;
     -+}
     ++	if (r->settings.fsmonitor)
     ++		return;
      +
     -+void fsm_settings__set_hook(struct repository *r, const char *path)
     -+{
     -+	struct fsmonitor_settings *s = r->settings.fsmonitor;
     ++	CALLOC_ARRAY(s, 1);
      +
     -+	s->mode = FSMONITOR_MODE_HOOK;
     -+	s->hook_path = strdup(path);
     -+}
     ++	r->settings.fsmonitor = s;
      +
     -+void fsm_settings__set_disabled(struct repository *r)
     -+{
     -+	struct fsmonitor_settings *s = r->settings.fsmonitor;
     ++	fsm_settings__set_disabled(r);
      +
     -+	s->mode = FSMONITOR_MODE_DISABLED;
     -+	FREE_AND_NULL(s->hook_path);
     -+}
     ++	/*
     ++	 * Overload the existing "core.fsmonitor" config setting (which
     ++	 * has historically been either unset or a hook pathname) to
     ++	 * now allow a boolean value to enable the builtin FSMonitor
     ++	 * or to turn everything off.  (This does imply that you can't
     ++	 * use a hook script named "true" or "false", but that's OK.)
     ++	 */
     ++	switch (repo_config_get_maybe_bool(r, "core.fsmonitor", &bool_value)) {
     ++
     ++	case 0: /* config value was set to <bool> */
     ++		if (bool_value)
     ++			fsm_settings__set_ipc(r);
     ++		return;
      +
     -+static int check_for_ipc(struct repository *r)
     -+{
     -+	int value;
     ++	case 1: /* config value was unset */
     ++		const_str = getenv("GIT_TEST_FSMONITOR");
     ++		break;
      +
     -+	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) &&
     -+	    value) {
     -+		fsm_settings__set_ipc(r);
     -+		return 1;
     ++	case -1: /* config value set to an arbitrary string */
     ++		if (repo_config_get_pathname(r, "core.fsmonitor", &const_str))
     ++			return; /* should not happen */
     ++		break;
     ++
     ++	default: /* should not happen */
     ++		return;
      +	}
      +
     -+	return 0;
     ++	if (!const_str || !*const_str)
     ++		return;
     ++
     ++	fsm_settings__set_hook(r, const_str);
      +}
      +
     -+static int check_for_hook(struct repository *r)
     ++enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
      +{
     -+	const char *const_str;
     ++	lookup_fsmonitor_settings(r);
      +
     -+	if (repo_config_get_pathname(r, "core.fsmonitor", &const_str))
     -+		const_str = getenv("GIT_TEST_FSMONITOR");
     -+
     -+	if (const_str && *const_str) {
     -+		fsm_settings__set_hook(r, const_str);
     -+		return 1;
     -+	}
     -+
     -+	return 0;
     ++	return r->settings.fsmonitor->mode;
      +}
      +
     -+static void lookup_fsmonitor_settings(struct repository *r)
     ++const char *fsm_settings__get_hook_path(struct repository *r)
      +{
     -+	struct fsmonitor_settings *s;
     -+
     -+	CALLOC_ARRAY(s, 1);
     ++	lookup_fsmonitor_settings(r);
      +
     -+	r->settings.fsmonitor = s;
     -+
     -+	if (check_for_ipc(r))
     -+		return;
     ++	return r->settings.fsmonitor->hook_path;
     ++}
      +
     -+	if (check_for_hook(r))
     -+		return;
     ++void fsm_settings__set_ipc(struct repository *r)
     ++{
     ++	lookup_fsmonitor_settings(r);
      +
     -+	fsm_settings__set_disabled(r);
     ++	r->settings.fsmonitor->mode = FSMONITOR_MODE_IPC;
     ++	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
      +}
      +
     -+enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
     ++void fsm_settings__set_hook(struct repository *r, const char *path)
      +{
     -+	if (!r->settings.fsmonitor)
     -+		lookup_fsmonitor_settings(r);
     ++	lookup_fsmonitor_settings(r);
      +
     -+	return r->settings.fsmonitor->mode;
     ++	r->settings.fsmonitor->mode = FSMONITOR_MODE_HOOK;
     ++	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
     ++	r->settings.fsmonitor->hook_path = strdup(path);
      +}
      +
     -+const char *fsm_settings__get_hook_path(struct repository *r)
     ++void fsm_settings__set_disabled(struct repository *r)
      +{
     -+	if (!r->settings.fsmonitor)
     -+		lookup_fsmonitor_settings(r);
     ++	lookup_fsmonitor_settings(r);
      +
     -+	return r->settings.fsmonitor->hook_path;
     ++	r->settings.fsmonitor->mode = FSMONITOR_MODE_DISABLED;
     ++	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
      +}
      
       ## fsmonitor-settings.h (new) ##
     @@ fsmonitor-settings.h (new)
      +
      +enum fsmonitor_mode {
      +	FSMONITOR_MODE_DISABLED = 0,
     -+	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor */
     -+	FSMONITOR_MODE_IPC = 2,  /* core.useBuiltinFSMonitor */
     ++	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor=<hook_path> */
     ++	FSMONITOR_MODE_IPC = 2,  /* core.fsmonitor=<true> */
      +};
      +
      +void fsm_settings__set_ipc(struct repository *r);
     @@ fsmonitor.c: void write_fsmonitor_extension(struct strbuf *sb, struct index_stat
       	strvec_pushf(&cp.args, "%s", last_update);
       	cp.use_shell = 1;
      @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     - 	struct strbuf last_update_token = STRBUF_INIT;
       	char *buf;
       	unsigned int i;
     + 	int is_trivial = 0;
      +	struct repository *r = istate->repo ? istate->repo : the_repository;
      +	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
       
     @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
      +			query_success = !query_fsmonitor_hook(
      +				r, HOOK_INTERFACE_VERSION1,
       				istate->fsmonitor_last_update, &query_result);
     - 		}
     + 			if (query_success)
     + 				is_trivial = query_result.buf[0] == '/';
     +@@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     + 			trace2_data_intmax("fsm_hook", NULL,
     + 					   "query/trivial-response", 1);
       
      -		trace_performance_since(last_update, "fsmonitor process '%s'", core_fsmonitor);
      -		trace_printf_key(&trace_fsmonitor, "fsmonitor process '%s' returned %s",
     @@ repository.h: struct repo_settings {
       	int command_requires_full_index;
       	int sparse_index;
       
     -+	struct fsmonitor_settings *fsmonitor; /* lazy loaded */
     ++	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
      +
       	int index_version;
       	enum untracked_cache_setting core_untracked_cache;
     @@ t/README: every 'git commit-graph write', as if the `--changed-paths` option was
       GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
      -code path for utilizing a file system monitor to speed up detecting
      -new or changed files.
     -+code path for utilizing a (hook based) file system monitor to speed up
     ++code paths for utilizing a (hook based) file system monitor to speed up
      +detecting new or changed files.
       
       GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
  4:  de82c726182 !  4:  8e738a83bc5 fsmonitor: use IPC to query the builtin FSMonitor daemon
     @@ Commit message
          fsmonitor: use IPC to query the builtin FSMonitor daemon
      
          Use simple IPC to directly communicate with the new builtin file
     -    system monitor daemon when `core.useBuiltinFSMonitor` is set.
     -
     -    The `core.fsmonitor` setting has already been defined as a HOOK
     -    pathname.  Historically, this has been set to a HOOK script that will
     -    talk with Watchman.  For compatibility reasons, we do not want to
     -    overload that definition (and cause problems if users have multiple
     -    versions of Git installed).
     +    system monitor daemon when `core.fsmonitor` is set to true.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
      +			buf = query_result.buf;
      +			strbuf_addstr(&last_update_token, buf);
      +			bol = last_update_token.len + 1;
     ++			is_trivial = query_result.buf[bol] == '/';
     ++			if (is_trivial)
     ++				trace2_data_intmax("fsm_client", NULL,
     ++						   "query/trivial-response", 1);
      +		} else {
      +			/*
      +			 * The builtin daemon is not available on this
  5:  d365704d551 !  5:  49e4c146e02 fsmonitor: document builtin fsmonitor
     @@ Metadata
       ## Commit message ##
          fsmonitor: document builtin fsmonitor
      
     -    Document the new `core.useBuiltinFSMonitor` config value.
     +    Document how `core.fsmonitor` can be set to a boolean to enable
     +    or disable the builtin FSMonitor.
      
          Update references to `core.fsmonitor` and `core.fsmonitorHookVersion` and
          pointers to `Watchman` to refer to it.
     @@ Documentation/config/core.txt: core.protectNTFS::
      -	requested date/time. This information is used to speed up git by
      -	avoiding unnecessary processing of files that have not changed.
      -	See the "fsmonitor-watchman" section of linkgit:githooks[5].
     -+	If set, this variable contains the pathname of the "fsmonitor"
     ++	If set to true, enable the built-in file system monitor
     ++	daemon for this working directory (linkgit:git-fsmonitor--daemon[1]).
     +++
     ++Like hook-based file system monitors, the built-in file system monitor
     ++can speed up Git commands that need to refresh the Git index
     ++(e.g. `git status`) in a working directory with many files.  The
     ++built-in monitor eliminates the need to install and maintain an
     ++external third-party tool.
     +++
     ++The built-in file system monitor is currently available only on a
     ++limited set of supported platforms.  Currently, this includes Windows
     ++and MacOS.
     +++
     ++	Otherwise, this variable contains the pathname of the "fsmonitor"
      +	hook command.
      ++
      +This hook command is used to identify all files that may have changed
     @@ Documentation/config/core.txt: core.protectNTFS::
      +git by avoiding unnecessary scanning of files that have not changed.
      ++
      +See the "fsmonitor-watchman" section of linkgit:githooks[5].
     -++
     -+Note: The value of this config setting is ignored if the
     -+built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
       
       core.fsmonitorHookVersion::
      -	Sets the version of hook that is to be used when calling fsmonitor.
     @@ Documentation/config/core.txt: core.protectNTFS::
      +Version 2 uses an opaque string so that the monitor can return
      +something that can be used to determine what files have changed
      +without race conditions.
     -++
     -+Note: The value of this config setting is ignored if the
     -+built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
     -+
     -+core.useBuiltinFSMonitor::
     -+	If set to true, enable the built-in file system monitor
     -+	daemon for this working directory (linkgit:git-fsmonitor--daemon[1]).
     -++
     -+Like hook-based file system monitors, the built-in file system monitor
     -+can speed up Git commands that need to refresh the Git index
     -+(e.g. `git status`) in a working directory with many files.  The
     -+built-in monitor eliminates the need to install and maintain an
     -+external third-party tool.
     -++
     -+The built-in file system monitor is currently available only on a
     -+limited set of supported platforms.  Currently, this includes Windows
     -+and MacOS.
     -++
     -+Note: if this config setting is set to `true`, the values of
     -+`core.fsmonitor` and `core.fsmonitorHookVersion` are ignored.
       
       core.trustctime::
       	If false, the ctime differences between the index and the
     @@ Documentation/git-fsmonitor--daemon.txt (new)
      +increased if they just ask for a summary of changes to the working
      +directory and can avoid scanning the disk.
      +
     -+When `core.useBuiltinFSMonitor` is set to `true` (see
     -+linkgit:git-config[1]) commands, such as `git status`, will ask the
     -+daemon for changes and automatically start it (if necessary).
     ++When `core.fsmonitor` is set to `true` (see linkgit:git-config[1])
     ++commands, such as `git status`, will ask the daemon for changes and
     ++automatically start it (if necessary).
      +
      +For more information see the "File System Monitor" section in
      +linkgit:git-update-index[1].
     @@ Documentation/git-update-index.txt: FILE SYSTEM MONITOR
       "fsmonitor-watchman" section of linkgit:githooks[5]) that can
       inform it as to what files have been modified. This enables git to avoid
       having to lstat() every file to find modified files.
     -@@ Documentation/git-update-index.txt: performance by avoiding the cost of scanning the entire working directory
     - looking for new files.
     +@@ Documentation/git-update-index.txt: looking for new files.
       
       If you want to enable (or disable) this feature, it is easier to use
     --the `core.fsmonitor` configuration variable (see
     + the `core.fsmonitor` configuration variable (see
      -linkgit:git-config[1]) than using the `--fsmonitor` option to
      -`git update-index` in each repository, especially if you want to do so
     --across all repositories you use, because you can set the configuration
     --variable in your `$HOME/.gitconfig` just once and have it affect all
     --repositories you touch.
     --
     --When the `core.fsmonitor` configuration variable is changed, the
     --file system monitor is added to or removed from the index the next time
     --a command reads the index. When `--[no-]fsmonitor` are used, the file
     --system monitor is immediately added to or removed from the index.
     -+the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
     -+variable (see linkgit:git-config[1]) than using the `--fsmonitor`
     -+option to `git update-index` in each repository, especially if you
     -+want to do so across all repositories you use, because you can set the
     -+configuration variable in your `$HOME/.gitconfig` just once and have
     -+it affect all repositories you touch.
     -+
     -+When the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
     -+variable is changed, the file system monitor is added to or removed
     -+from the index the next time a command reads the index. When
     -+`--[no-]fsmonitor` are used, the file system monitor is immediately
     -+added to or removed from the index.
     - 
     - CONFIGURATION
     - -------------
     -
     - ## Documentation/githooks.txt ##
     -@@ Documentation/githooks.txt: fsmonitor-watchman
     - 
     - This hook is invoked when the configuration option `core.fsmonitor` is
     - set to `.git/hooks/fsmonitor-watchman` or `.git/hooks/fsmonitor-watchmanv2`
     --depending on the version of the hook to use.
     -+depending on the version of the hook to use, unless overridden via
     -+`core.useBuiltinFSMonitor` (see linkgit:git-config[1]).
     - 
     - Version 1 takes two arguments, a version (1) and the time in elapsed
     - nanoseconds since midnight, January 1, 1970.
     ++linkgit:git-config[1]) than using the `--fsmonitor` option to `git
     ++update-index` in each repository, especially if you want to do so
     + across all repositories you use, because you can set the configuration
     + variable in your `$HOME/.gitconfig` just once and have it affect all
     + repositories you touch.
  6:  78e682fc530 =  6:  bdd7334da31 fsmonitor--daemon: add a built-in fsmonitor daemon
  7:  ea64b5c9753 =  7:  9f00ada3dd3 fsmonitor--daemon: implement 'stop' and 'status' commands
  8:  5a40b33a00c =  8:  d6819bdad66 compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
  9:  ed5819e29f8 =  9:  7de3d01cccc compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
 10:  d3ac973a5f1 = 10:  6fe5a2bc79e fsmonitor--daemon: implement 'run' command
 11:  d08c28b549c = 11:  69fc0998286 fsmonitor--daemon: implement 'start' command
 12:  6fa71fdc825 = 12:  21c099c5197 fsmonitor--daemon: add pathname classification
 13:  65821da5b03 = 13:  72979c35ceb fsmonitor--daemon: define token-ids
 14:  429c48a5bad ! 14:  8d1db644409 fsmonitor--daemon: create token-based changed path cache
     @@ Commit message
          backends to accumulate changed paths in response to filesystem events.
      
          The platform-specific file system listener thread receives file system
     -    events containing one or more changed pathnames (with whatever bucketing
     -    or grouping that is convenient for the file system).  These paths are
     -    accumulated (without locking) by the file system layer into a `fsmonitor_batch`.
     +    events containing one or more changed pathnames (with whatever
     +    bucketing or grouping that is convenient for the file system).  These
     +    paths are accumulated (without locking) by the file system layer into
     +    a `fsmonitor_batch`.
      
          When the file system layer has drained the kernel event queue, it will
          "publish" them to our token queue and make them visible to concurrent
 15:  b04c460c619 = 15:  98c5adf8ca0 compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
 16:  862bbfcc32e ! 16:  a3b881315fa compat/fsmonitor/fsm-listen-darwin: add macos header files for FSEvent
     @@ Commit message
          currently fails with this error:
      
          In file included
     -       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/Security.framework/Headers/AuthSession.h:32,
     -       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/Security.framework/Headers/Security.h:42,
     -       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/OSServices.framework/Headers/CSIdentity.h:43,
     -       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/OSServices.framework/Headers/OSServices.h:29,
     -       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Headers/IconsCore.h:23,
     -       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Headers/LaunchServices.h:23,
     -       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/CoreServices.framework/Headers/CoreServices.h:45,
     -         /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/Security.framework/Headers/Authorization.h:193:7: error: variably modified 'bytes' at file scope
     +       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
     +       ...Library/Frameworks/Security.framework/Headers/AuthSession.h:32,
     +       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
     +       ...Library/Frameworks/Security.framework/Headers/Security.h:42,
     +       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
     +       ...Library/Frameworks/CoreServices.framework/Frameworks/...
     +       ...OSServices.framework/Headers/CSIdentity.h:43,
     +       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
     +       ...Library/Frameworks/CoreServices.framework/Frameworks/...
     +       ...OSServices.framework/Headers/OSServices.h:29,
     +       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
     +       ...Library/Frameworks/CoreServices.framework/Frameworks/...
     +       ...LaunchServices.framework/Headers/IconsCore.h:23,
     +       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
     +       ...Library/Frameworks/CoreServices.framework/Frameworks/...
     +       ...LaunchServices.framework/Headers/LaunchServices.h:23,
     +       from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
     +       ...Library/Frameworks/CoreServices.framework/Headers/CoreServices.h:45,
     +
     +         /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/...
     +         ...Library/Frameworks/Security.framework/Headers/Authorization.h:193:7:
     +         error: variably modified 'bytes' at file scope
                 193 | char bytes[kAuthorizationExternalFormLength];
                     |      ^~~~~
      
 17:  40d9a816b52 = 17:  162e357db72 compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
 18:  241962894f1 = 18:  3de1c43beaf fsmonitor--daemon: implement handle_client callback
 19:  704d37d2033 = 19:  3517c4a3c13 help: include fsmonitor--daemon feature flag in version info
 20:  de6c72a9ce0 ! 20:  4ffc2ddf516 t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
     @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
       	{ "getcwd", cmd__getcwd },
      
       ## t/helper/test-tool.h ##
     -@@ t/helper/test-tool.h: int cmd__dump_split_index(int argc, const char **argv);
     - int cmd__dump_untracked_cache(int argc, const char **argv);
     +@@ t/helper/test-tool.h: int cmd__dump_untracked_cache(int argc, const char **argv);
     + int cmd__dump_reftable(int argc, const char **argv);
       int cmd__example_decorate(int argc, const char **argv);
       int cmd__fast_rebase(int argc, const char **argv);
      +int cmd__fsmonitor_client(int argc, const char **argv);
 21:  eedaa787c2e ! 21:  d93310a7c64 t7527: create test for fsmonitor--daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	actual*
      +	EOF
      +
     -+	git -c core.useBuiltinFSMonitor= add . &&
     ++	git -c core.fsmonitor=false add . &&
      +	test_tick &&
     -+	git -c core.useBuiltinFSMonitor= commit -m initial &&
     ++	git -c core.fsmonitor=false commit -m initial &&
      +
     -+	git config core.useBuiltinFSMonitor true
     ++	git config core.fsmonitor true
      +'
      +
      +# The test already explicitly stopped (or tried to stop) the daemon.
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	test_subcommand git fsmonitor--daemon start <.git/trace_implicit_2
      +'
      +
     -+edit_files() {
     ++edit_files () {
      +	echo 1 >modified
      +	echo 2 >dir1/modified
      +	echo 3 >dir2/modified
      +	>dir1/untracked
      +}
      +
     -+delete_files() {
     ++delete_files () {
      +	rm -f delete
      +	rm -f dir1/delete
      +	rm -f dir2/delete
      +}
      +
     -+create_files() {
     ++create_files () {
      +	echo 1 >new
      +	echo 2 >dir1/new
      +	echo 3 >dir2/new
      +}
      +
     -+rename_files() {
     ++rename_files () {
      +	mv rename renamed
      +	mv dir1/rename dir1/renamed
      +	mv dir2/rename dir2/renamed
      +}
      +
     -+file_to_directory() {
     ++file_to_directory () {
      +	rm -f delete
      +	mkdir delete
      +	echo 1 >delete/new
      +}
      +
     -+directory_to_file() {
     ++directory_to_file () {
      +	rm -rf dir1
      +	echo 1 >dir1
      +}
      +
     -+verify_status() {
     ++verify_status () {
      +	git status >actual &&
      +	GIT_INDEX_FILE=.git/fresh-index git read-tree master &&
     -+	GIT_INDEX_FILE=.git/fresh-index git -c core.useBuiltinFSMonitor= status >expect &&
     ++	GIT_INDEX_FILE=.git/fresh-index git -c core.fsmonitor=false status >expect &&
      +	test_cmp expect actual &&
      +	echo HELLO AFTER &&
      +	cat .git/trace &&
 22:  4e96e0667ba = 22:  27e47108908 t/perf: avoid copying builtin fsmonitor files into test repo
 23:  de9c015d78c = 23:  6cba1d950b0 t/helper/test-chmtime: skip directories on Windows
 24:  1c2eccacff6 ! 24:  fcf843a0d42 t/perf/p7519: speed up test on Windows
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## t/perf/p7519-fsmonitor.sh ##
     -@@ t/perf/p7519-fsmonitor.sh: trace_stop() {
     +@@ t/perf/p7519-fsmonitor.sh: then
     + 	fi
     + fi
     + 
     +-trace_start() {
     ++trace_start () {
     + 	if test -n "$GIT_PERF_7519_TRACE"
     + 	then
     + 		name="$1"
     +@@ t/perf/p7519-fsmonitor.sh: trace_start() {
     + 	fi
     + }
     + 
     +-trace_stop() {
     ++trace_stop () {
     + 	if test -n "$GIT_PERF_7519_TRACE"
     + 	then
     + 		unset GIT_TRACE2_PERF
       	fi
       }
       
     -+touch_files() {
     ++touch_files () {
      +	n=$1
      +	d="$n"_files
      +
     @@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
       	fi &&
       
       	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
     --	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
     --	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
     --	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
     --	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
     +-	for i in $(test_seq 1 10); do touch 10_files/$i || return 1; done &&
     +-	for i in $(test_seq 1 100); do touch 100_files/$i || return 1; done &&
     +-	for i in $(test_seq 1 1000); do touch 1000_files/$i || return 1; done &&
     +-	for i in $(test_seq 1 10000); do touch 10000_files/$i || return 1; done &&
      +	touch_files 1 &&
      +	touch_files 10 &&
      +	touch_files 100 &&
     @@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
       	git add 1_file 10_files 100_files 1000_files 10000_files &&
       	git commit -qm "Add files" &&
       
     +@@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
     + 	fi
     + '
     + 
     +-setup_for_fsmonitor() {
     ++setup_for_fsmonitor () {
     + 	# set INTEGRATION_SCRIPT depending on the environment
     + 	if test -n "$INTEGRATION_PATH"
     + 	then
     +@@ t/perf/p7519-fsmonitor.sh: test_perf_w_drop_caches () {
     + 	test_perf "$@"
     + }
     + 
     +-test_fsmonitor_suite() {
     ++test_fsmonitor_suite () {
     + 	if test -n "$INTEGRATION_SCRIPT"; then
     + 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
     + 	else
      @@ t/perf/p7519-fsmonitor.sh: test_fsmonitor_suite() {
       
       	# Update the mtimes on upto 100k files to make status think
 25:  236b5966257 ! 25:  198f47bda5a t/perf/p7519: add fsmonitor--daemon test cases
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## t/perf/p7519-fsmonitor.sh ##
     -@@ t/perf/p7519-fsmonitor.sh: test_description="Test core.fsmonitor"
     - # GIT_PERF_7519_SPLIT_INDEX: used to configure core.splitIndex
     - # GIT_PERF_7519_FSMONITOR: used to configure core.fsMonitor. May be an
     - #   absolute path to an integration. May be a space delimited list of
     --#   absolute paths to integrations.
     -+#   absolute paths to integrations.  (This hook or list of hooks does not
     -+#   include the built-in fsmonitor--daemon.)
     - #
     - # The big win for using fsmonitor is the elimination of the need to scan the
     - # working directory looking for changed and untracked files. If the file
     -@@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
     - 
     - setup_for_fsmonitor() {
     - 	# set INTEGRATION_SCRIPT depending on the environment
     --	if test -n "$INTEGRATION_PATH"
     -+	if test -n "$USE_FSMONITOR_DAEMON"
     - 	then
     -+		git config core.useBuiltinFSMonitor true &&
     -+		INTEGRATION_SCRIPT=false
     -+	elif test -n "$INTEGRATION_PATH"
     -+	then
     -+		git config core.useBuiltinFSMonitor false &&
     - 		INTEGRATION_SCRIPT="$INTEGRATION_PATH"
     - 	else
     -+		git config core.useBuiltinFSMonitor false &&
     - 		#
     - 		# Choose integration script based on existence of Watchman.
     - 		# Fall back to an empty integration script.
      @@ t/perf/p7519-fsmonitor.sh: test_perf_w_drop_caches () {
       }
       
     - test_fsmonitor_suite() {
     + test_fsmonitor_suite () {
      -	if test -n "$INTEGRATION_SCRIPT"; then
      +	if test -n "$USE_FSMONITOR_DAEMON"
      +	then
     @@ t/perf/p7519-fsmonitor.sh: test_expect_success "setup without fsmonitor" '
      +	git fsmonitor--daemon start
      +
      +	trace_start fsmonitor--daemon--client
     -+	test_expect_success "setup for fsmonitor--daemon" 'setup_for_fsmonitor'
     ++
     ++	git config core.fsmonitor true
     ++	git update-index --fsmonitor
     ++
      +	test_fsmonitor_suite
      +
      +	git fsmonitor--daemon stop
 26:  54710a4830d = 26:  19993c130d2 fsmonitor--daemon: periodically truncate list of modified files
 27:  1e2bd77fcea = 27:  f47a763dc26 fsmonitor--daemon: use a cookie file to sync with file system
 28:  30e61b6d1ad ! 28:  aec44a21afd fsmonitor: force update index after large responses
     @@ fsmonitor.c: apply_results:
       	 */
      +	trace2_region_enter("fsmonitor", "apply_results", istate->repo);
      +
     - 	if (query_success && query_result.buf[bol] != '/') {
     + 	if (query_success && !is_trivial) {
       		/*
       		 * Mark all pathnames returned by the monitor as dirty.
       		 *
     @@ fsmonitor.c: apply_results:
      +
       	} else {
       		/*
     - 		 * We received a trivial response, so invalidate everything.
     + 		 * We failed to get a response or received a trivial response,
      @@ fsmonitor.c: apply_results:
       		if (istate->untracked)
       			istate->untracked->use_fsmonitor = 0;
 29:  507020bbef0 ! 29:  d6039987df8 t7527: test status with untracked-cache and fsmonitor--daemon
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'setup' '
      +	trace*
       	EOF
       
     - 	git -c core.useBuiltinFSMonitor= add . &&
     + 	git -c core.fsmonitor=false add . &&
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'cleanup worktrees' '
       	stop_daemon_delete_repo wt-base
       '
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'cleanup worktrees' '
      +# cause incorrect results when the untracked-cache is enabled.
      +
      +test_lazy_prereq UNTRACKED_CACHE '
     -+	{ git update-index --test-untracked-cache; ret=$?; } &&
     -+	test $ret -ne 1
     ++	git update-index --test-untracked-cache
      +'
      +
      +test_expect_success 'Matrix: setup for untracked-cache,fsmonitor matrix' '
     -+	test_might_fail git config --unset core.useBuiltinFSMonitor &&
     ++	test_unconfig core.fsmonitor &&
      +	git update-index --no-fsmonitor &&
      +	test_might_fail git fsmonitor--daemon stop
      +'
      +
      +matrix_clean_up_repo () {
     -+	git reset --hard HEAD
     ++	git reset --hard HEAD &&
      +	git clean -fd
      +}
      +
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'cleanup worktrees' '
      +	test_expect_success "Matrix[uc:$uc][fsm:$fsm] $fn" '
      +		matrix_clean_up_repo &&
      +		$fn &&
     -+		if test $uc = false -a $fsm = false
     ++		if test $uc = false && test $fsm = false
      +		then
      +			git status --porcelain=v1 >.git/expect.$fn
      +		else
     -+			git status --porcelain=v1 >.git/actual.$fn
     ++			git status --porcelain=v1 >.git/actual.$fn &&
      +			test_cmp .git/expect.$fn .git/actual.$fn
      +		fi
      +	'
     -+
     -+	return $?
      +}
      +
      +uc_values="false"
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'cleanup worktrees' '
      +		if test $fsm_val = false
      +		then
      +			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor" '
     -+				test_might_fail git config --unset core.useBuiltinFSMonitor &&
     ++				test_unconfig core.fsmonitor &&
      +				git update-index --no-fsmonitor &&
     -+				test_might_fail git fsmonitor--daemon stop 2>/dev/null
     ++				test_might_fail git fsmonitor--daemon stop
      +			'
      +		else
      +			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
     -+				git config core.useBuiltinFSMonitor true &&
     ++				git config core.fsmonitor true &&
      +				git fsmonitor--daemon start &&
      +				git update-index --fsmonitor
      +			'
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'cleanup worktrees' '
      +		if test $fsm_val = true
      +		then
      +			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor at end" '
     -+				test_might_fail git config --unset core.useBuiltinFSMonitor &&
     ++				test_unconfig core.fsmonitor &&
      +				git update-index --no-fsmonitor &&
     -+				test_might_fail git fsmonitor--daemon stop 2>/dev/null
     ++				test_might_fail git fsmonitor--daemon stop
      +			'
      +		fi
      +	done
  -:  ----------- > 30:  5117fbdfc63 update-index: convert fsmonitor warnings to advise

-- 
gitgitgadget
