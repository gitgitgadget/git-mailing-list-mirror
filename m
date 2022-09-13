Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1DDC6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 20:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIMU1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiIMU1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 16:27:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694F65830
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bo13so6055639wrb.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=XKV+vovml7faohNUdMUvxK7Lm30vplL89158aord9TQ=;
        b=HuRlOFspJ51+b9kyVjt5Vr54xJFz7pL+yiQ86x12iJ1LkwFFuXT16bz1sviJKJwLjW
         EIHcmsOC7Z8+GPkXLog9QS/zKw3kItncjkybGsm8gQ+mhWY15NgQI6QSNW4BhO7IyXM8
         5nvctc/BNBz/MOjrk2TLZ75oLTt3x9JocA8L4AOIDUmXnFXcvb/l6mnzu5KGQf8ooQrr
         4P7Qfh30eA5324rrI4hqOMdX1UUW+wqSZeFfAy1C6TprEq9Ok5jSjPDY4qZDAs6dviL7
         Je79S/YNz/+91sQcHc/GdGz7bu1yLlw1U1AETcKQWC5fguhqqT/lzjOp1tpquL0fpEl7
         zjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XKV+vovml7faohNUdMUvxK7Lm30vplL89158aord9TQ=;
        b=uSkbVsKt4PpZXIchsFIRK5kaJ3cznF8CynpXCYC4qLWhEZ+Ada0Ewy/zbrDMy/3OIt
         Gk4UZwiOEtTZZzAzm5Bad/1BWoJfOAMW+7GEusGm6FFoBsfHT+pSdmW5UTi73S1AXSIl
         xgyThT1N8OfxpozqVAw+L0zP+QK4fELMdqV6nHLn9c+4nbDt+FzN50qYeMqSliKuAEE8
         lGNiwS0W7slTe8NJQ7LSqd8gQgKG0B0WKq8vpSaNTcUmLvRWna+54QKTrhBZLG/N4MWA
         kUunvXHwu4a4BfJUikKr/ua0mo/WN0N7OEwVDk6KxJQ7kQ+A1vS4m9SDN0tEyu6D7vpA
         94dg==
X-Gm-Message-State: ACgBeo2UsNN1jx1+8F3Gm4de/Um+so6hE6yaPU30qD7zuJOOqPXU7E4L
        c288a5/waGCAbKSQloKsk5yKre8ff24=
X-Google-Smtp-Source: AA6agR5Q7yjsakvAe/DY3HA6MpUEcSJiO4xn/sSJSZZmwrUNYxL2NFKaMel76ZA3efDzDp2EIdX0eQ==
X-Received: by 2002:a5d:5888:0:b0:22a:72a1:5140 with SMTP id n8-20020a5d5888000000b0022a72a15140mr8292482wrf.408.1663100860543;
        Tue, 13 Sep 2022 13:27:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a7bca43000000b003b341a2cfadsm14888734wml.17.2022.09.13.13.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 13:27:40 -0700 (PDT)
Message-Id: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
References: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 20:27:32 +0000
Subject: [PATCH v6 0/6] fsmonitor: option to allow fsmonitor to run against network-mounted repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-on to the work done to allow Windows to work against network-mounted
repos for macOS.

Have macOS take advantage of the same configuration option,
'fsmonitor.allowRemote' that was introduced for Windows. Setting this option
to true will override the default behavior (erroring-out) when a
network-mounted repo is detected by fsmonitor.

The added wrinkle being that the Unix domain socket (UDS) file used for IPC
cannot be created in a network location; instead $HOME is used if the
default location is on the network. The user may, optionally, set the
'fsmonitor.socketDir' configuration option to a valid, local directory if
$HOME itself is on the network or is simply not the desired location for the
UDS file.

An additional issue is that for mount points in the root directory, FSEvents
does not report a path that matches the worktree directory due to the
introduction of 'synthetic firmlinks'. fsmonitor must map the FSEvents paths
to the worktree directory by interrogating the root filesystem for synthetic
firmlinks and using that information to translate the path.

v6 differs from v5:

 * incorporates earlier, Windows-specific changes that have not made it back
   yet to the master branch
 * incorporates code review feedback
 * adds documentation for 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'

v5 differs significantly from earlier versions:

 * redesign of handling 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'
   such that these options are no longer added to the settings data
   structure but are rather read from config at point of use
 * refactoring of code for handling platform-specific file system checks via
   a common interface to avoid platform #ifdef in IPC code and be in-model
   with other platform-specific fsmonitor code
 * dealing with 'synthetic firmlinks' on macOS

Eric DeCosta (6):
  fsmonitor: option to allow fsmonitor to run against network-mounted
    repos
  fsmonitor: refactor filesystem checks to common interface
  fsmonitor: relocate socket file if .git directory is remote
  fsmonitor: avoid socket location check if using hook
  fsmonitor: deal with synthetic firmlinks on macOS
  fsmonitor: add documentation for allowRemote and socketDir options

 Documentation/git-fsmonitor--daemon.txt  |  35 ++++++
 Makefile                                 |   2 +
 builtin/fsmonitor--daemon.c              |   8 ++
 compat/fsmonitor/fsm-ipc-darwin.c        |  46 +++++++
 compat/fsmonitor/fsm-ipc-win32.c         |   4 +
 compat/fsmonitor/fsm-listen-darwin.c     |   6 +-
 compat/fsmonitor/fsm-path-utils-darwin.c | 132 +++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-win32.c  | 145 +++++++++++++++++++++++
 compat/fsmonitor/fsm-settings-darwin.c   |  70 ++++-------
 compat/fsmonitor/fsm-settings-win32.c    | 106 +----------------
 contrib/buildsystems/CMakeLists.txt      |   4 +
 fsmonitor--daemon.h                      |   6 +
 fsmonitor-ipc.c                          |   2 -
 fsmonitor-path-utils.h                   |  59 +++++++++
 fsmonitor-settings.c                     |  58 ++++++++-
 fsmonitor-settings.h                     |   2 +-
 16 files changed, 526 insertions(+), 159 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 fsmonitor-path-utils.h


base-commit: dd3f6c4cae7e3b15ce984dce8593ff7569650e24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v5:

 -:  ----------- > 1:  3233c908c4a fsmonitor: option to allow fsmonitor to run against network-mounted repos
 1:  2f647b53e4d ! 2:  d2a8fc6b707 fsmonitor: refactor filesystem checks to common interface
     @@ compat/fsmonitor/fsm-path-utils-win32.c (new)
      +#include "fsmonitor-path-utils.h"
      +
      +/*
     ++ * Check remote working directory protocol.
     ++ *
     ++ * Return -1 if client machine cannot get remote protocol information.
     ++ */
     ++static int check_remote_protocol(wchar_t *wpath)
     ++{
     ++	HANDLE h;
     ++	FILE_REMOTE_PROTOCOL_INFO proto_info;
     ++
     ++	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
     ++			FILE_FLAG_BACKUP_SEMANTICS, NULL);
     ++
     ++	if (h == INVALID_HANDLE_VALUE) {
     ++		error(_("[GLE %ld] unable to open for read '%ls'"),
     ++		      GetLastError(), wpath);
     ++		return -1;
     ++	}
     ++
     ++	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
     ++		&proto_info, sizeof(proto_info))) {
     ++		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
     ++		      GetLastError(), wpath);
     ++		CloseHandle(h);
     ++		return -1;
     ++	}
     ++
     ++	CloseHandle(h);
     ++
     ++	trace_printf_key(&trace_fsmonitor,
     ++				"check_remote_protocol('%ls') remote protocol %#8.8lx",
     ++				wpath, proto_info.Protocol);
     ++
     ++	return 0;
     ++}
     ++
     ++/*
      + * Notes for testing:
      + *
      + * (a) Windows allows a network share to be mapped to a drive letter.
     @@ compat/fsmonitor/fsm-path-utils-win32.c (new)
      +			 "DriveType '%s' L'%ls' (%u)",
      +			 path, wfullpath, driveType);
      +
     -+	if (driveType == DRIVE_REMOTE)
     ++	if (driveType == DRIVE_REMOTE) {
      +		fs_info->is_remote = 1;
     -+	else
     ++		if (check_remote_protocol(wfullpath) < 0)
     ++			return -1;
     ++	} else {
      +		fs_info->is_remote = 0;
     ++	}
      +
      +	trace_printf_key(&trace_fsmonitor,
      +				"'%s' is_remote: %d",
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4gi
       	return FSMONITOR_REASON_OK;
       }
       
     +-/*
     +- * Check if monitoring remote working directories is allowed.
     +- *
     +- * By default, monitoring remote working directories is
     +- * disabled.  Users may override this behavior in enviroments where
     +- * they have proper support.
     +- */
     +-static int check_config_allowremote(struct repository *r)
     +-{
     +-	int allow;
     +-
     +-	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
     +-		return allow;
     +-
     +-	return -1; /* fsmonitor.allowremote not set */
     +-}
     +-
     +-/*
     +- * Check remote working directory protocol.
     +- *
     +- * Error if client machine cannot get remote protocol information.
     +- */
     +-static int check_remote_protocol(wchar_t *wpath)
     +-{
     +-	HANDLE h;
     +-	FILE_REMOTE_PROTOCOL_INFO proto_info;
     +-
     +-	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
     +-			FILE_FLAG_BACKUP_SEMANTICS, NULL);
     +-
     +-	if (h == INVALID_HANDLE_VALUE) {
     +-		error(_("[GLE %ld] unable to open for read '%ls'"),
     +-		      GetLastError(), wpath);
     +-		return -1;
     +-	}
     +-
     +-	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
     +-		&proto_info, sizeof(proto_info))) {
     +-		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
     +-		      GetLastError(), wpath);
     +-		CloseHandle(h);
     +-		return -1;
     +-	}
     +-
     +-	CloseHandle(h);
     +-
     +-	trace_printf_key(&trace_fsmonitor,
     +-				"check_remote_protocol('%ls') remote protocol %#8.8lx",
     +-				wpath, proto_info.Protocol);
     +-
     +-	return 0;
     +-}
     +-
      -/*
      - * Remote working directories are problematic for FSMonitor.
      - *
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4gi
      - */
      -static enum fsmonitor_reason check_remote(struct repository *r)
      -{
     +-	int ret;
      -	wchar_t wpath[MAX_PATH];
      -	wchar_t wfullpath[MAX_PATH];
      -	size_t wlen;
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4gi
      -		trace_printf_key(&trace_fsmonitor,
      -				 "check_remote('%s') true",
      -				 r->worktree);
     +-
     +-		ret = check_remote_protocol(wfullpath);
     +-		if (ret < 0)
     +-			return FSMONITOR_REASON_ERROR;
     +-
     +-		switch (check_config_allowremote(r)) {
     +-		case 0: /* config overrides and disables */
     +-			return FSMONITOR_REASON_REMOTE;
     +-		case 1: /* config overrides and enables */
     +-			return FSMONITOR_REASON_OK;
     +-		default:
     +-			break; /* config has no opinion */
     +-		}
     +-
      -		return FSMONITOR_REASON_REMOTE;
      -	}
      -
 2:  28d08bcf808 = 3:  edef029a298 fsmonitor: relocate socket file if .git directory is remote
 3:  ff54b6e0bb5 = 4:  3428bcf8763 fsmonitor: avoid socket location check if using hook
 4:  b7d6cf44695 ! 5:  9c1f408ae6d fsmonitor: deal with synthetic firmlinks on macOS
     @@ Commit message
          ability to create symlinks in the root directory and replaced them with
          'synthetic firmlinks'. See 'man synthetic.conf'
      
     -    When FSEevents reports the path of changed files, if the path invloves
     +    When FSEevents reports the path of changed files, if the path involves
          a synthetic firmlink, the path is reported from the point of the
          synthetic firmlink and not the real path. For example:
      
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
       	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
       	state.nr_paths_watching = 1;
       
     -+	strbuf_init(&state.alias.alias, 0);
     -+	strbuf_init(&state.alias.points_to, 0);
     ++	state.alias.alias = NULL;
     ++	state.alias.points_to = NULL;
      +	if (fsmonitor__get_alias(state.path_worktree_watch.buf, &state.alias)) {
      +		err = error(_("could not get worktree alias"));
      +		goto done;
     @@ compat/fsmonitor/fsm-path-utils-darwin.c: int fsmonitor__is_fs_remote(const char
      + * information, but for now there is only one caller of this function.
      + *
      + * If there is more than one alias for the path, that is another
     -+ * matter altogteher.
     ++ * matter altogether.
      + */
      +int fsmonitor__get_alias(const char *path, struct alias_info *info)
      +{
     @@ compat/fsmonitor/fsm-path-utils-darwin.c: int fsmonitor__is_fs_remote(const char
      +			strbuf_setlen(&points_to, read);
      +			if ((strncmp(points_to.buf, path, points_to.len) == 0)
      +				&& path[points_to.len] == '/') {
     -+				strbuf_addbuf(&info->alias, &alias);
     -+				strbuf_addbuf(&info->points_to, &points_to);
     ++				info->alias = strbuf_detach(&alias, NULL);
     ++				info->points_to = strbuf_detach(&points_to, NULL);
      +				trace_printf_key(&trace_fsmonitor,
      +					"Found alias for '%s' : '%s' -> '%s'",
     -+					path, info->alias.buf, info->points_to.buf);
     ++					path, info->alias, info->points_to);
      +				retval = 0;
      +				goto done;
      +			}
     @@ compat/fsmonitor/fsm-path-utils-darwin.c: int fsmonitor__is_fs_remote(const char
      +char *fsmonitor__resolve_alias(const char *path,
      +	const struct alias_info *info)
      +{
     -+	int len = info->alias.len;
     ++	int len = info->alias ? strlen(info->alias) : 0;
      +
      +	if (!len)
      +		return NULL;
      +
     -+	if ((strncmp(info->alias.buf, path, len) == 0)
     ++	if ((strncmp(info->alias, path, len) == 0)
      +		&& path[len] == '/') {
      +		struct strbuf tmp;
      +		const char *remainder = path + len;
     ++		int ptr_len = strlen(info->points_to);
      +		int rem_len = strlen(remainder);
      +
     -+		strbuf_init(&tmp, info->points_to.len + rem_len);
     -+		strbuf_addbuf(&tmp, &info->points_to);
     ++		strbuf_init(&tmp, ptr_len + rem_len);
     ++		strbuf_add(&tmp, info->points_to, ptr_len);
      +		strbuf_add(&tmp, remainder, rem_len);
      +		return strbuf_detach(&tmp, NULL);
      +	}
     @@ fsmonitor-path-utils.h
      +
      +struct alias_info
      +{
     -+	struct strbuf alias;
     -+	struct strbuf points_to;
     ++	char *alias;
     ++	char *points_to;
      +};
      +
       struct fs_info {
     @@ fsmonitor-path-utils.h: int fsmonitor__get_fs_info(const char *path, struct fs_i
      + *
      + * Sets alias to the first alias that matches any part of the path.
      + *
     ++ * If an alias is found, info.alias and info.points_to are set to the
     ++ * found mapping.
     ++ *
      + * Returns -1 on error, 0 otherwise.
     ++ *
     ++ * The caller owns the storage that is occupied by set info.alias and
     ++ * info.points_to and is responsible for releasing it with `free(3)`
     ++ * when done.
      + */
      +int fsmonitor__get_alias(const char *path, struct alias_info *info);
      +
     @@ fsmonitor-path-utils.h: int fsmonitor__get_fs_info(const char *path, struct fs_i
      + * Resolve the path against the given alias.
      + *
      + * Returns the resolved path if there is one, NULL otherwise.
     ++ *
     ++ * The caller owns the storage that the returned string occupies and
     ++ * is responsible for releasing it with `free(3)` when done.
      + */
      +char *fsmonitor__resolve_alias(const char *path,
      +	const struct alias_info *info);
 -:  ----------- > 6:  d2c95e34d3a fsmonitor: add documentation for allowRemote and socketDir options

-- 
gitgitgadget
