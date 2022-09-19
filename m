Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED790ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 19:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiISTiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISTiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 15:38:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CE115A1A
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t14so729367wrx.8
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=AHsuauBjGSxRMNuthPW5xE+SxBgQlG0mbrtL7YQn7k4=;
        b=mxPhIqAAM2eDtOUanWdDCrGvkMcPgv5qUsV36VifeAJQM4NV0JkzheWupr5fX8yslQ
         c5IAK9p8GezQD21cKIa++wmkgdTnF1jRg+DPfwot88AnktiBcpZ+ybiiZuG4bucsyMp/
         0YBKzLeDCeYt3H5urGLk1G50umT+gLrUGPd2zF9zyr5atD5DdMgL//U3FEuy0MU0dgua
         oJ4e+joK/1t4eF5moEjwTYK8IqNhIszfdLs7eOJ4F06slkqKPBqtjV4VxolMeKdKXkDE
         dc134CcojVQt+dXC2Qp+LI94SqazioRKOfdWzpw4ikgnRo9OsZG4c/+oABBJl56wWBSg
         mSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AHsuauBjGSxRMNuthPW5xE+SxBgQlG0mbrtL7YQn7k4=;
        b=l8alL6IwrJfey38sApf1HXreuhvkdki1fjFxqmTDMcUuOITn3Q3+JqQOdbREh/SRf3
         lyljZOYBpQ2Q7mg8Af+/dYSe9ODUKPruNHXnBZhhGNhf14zEmyX583Ezl1802zj1oRfD
         UIE3aGr/EO47f6O+GvQkgVDCWVQg6m8VNQ/KchSShhAyyycUDqJxIKXmU0Vxk94irESt
         pkyMTBQfPXzyehexSpEF1nAwZJP/E9mnBvQ9PDTsHMYQUUes0x8W9D5LUjRsnuYOH1HO
         1FDoO3FdjEWo2+gG4G6jORsCTzJjafPuZr8MXF/JpJdYDGzFd9+LOGG69kY7rL5dg1ES
         m3Wg==
X-Gm-Message-State: ACrzQf373kFbyfWuGjDZntInkUMFh4YS5Y4cjqVL45051Ng3YPKoll2w
        zPiZma44zoaJB4qx8tdxvIKMUuWuwWg=
X-Google-Smtp-Source: AMsMyM5fJxgwGRAfnqVOyKfb21bAJVkTEZ6/7e6vOD7bs9bUXugZLu2zk3Rai8VYyydqEIIYf3S9YQ==
X-Received: by 2002:adf:de8d:0:b0:22a:e4b5:6791 with SMTP id w13-20020adfde8d000000b0022ae4b56791mr9208060wrl.1.1663616278729;
        Mon, 19 Sep 2022 12:37:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c228700b003a604a29a34sm14572756wmf.35.2022.09.19.12.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:37:58 -0700 (PDT)
Message-Id: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
References: <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 19:37:51 +0000
Subject: [PATCH v9 0/6] fsmonitor: option to allow fsmonitor to run against network-mounted repos
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

v9 differs from v8:

 * incorporates code review feedback
 * check for incompatibility before communicating with fsmonitor

v8 differs from v7:

 * incorporates code review feedback
 * gets the rebase right

v7 differs from v6:

 * incorporates code review feedback

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
  fsmonitor: refactor filesystem checks to common interface
  fsmonitor: relocate socket file if .git directory is remote
  fsmonitor: avoid socket location check if using hook
  fsmonitor: deal with synthetic firmlinks on macOS
  fsmonitor: check for compatability before communicating with fsmonitor
  fsmonitor: add documentation for allowRemote and socketDir options

 Documentation/git-fsmonitor--daemon.txt  |  48 ++++++-
 Makefile                                 |   2 +
 builtin/fsmonitor--daemon.c              |  11 +-
 compat/fsmonitor/fsm-ipc-darwin.c        |  48 +++++++
 compat/fsmonitor/fsm-ipc-win32.c         |   9 ++
 compat/fsmonitor/fsm-listen-darwin.c     |   6 +-
 compat/fsmonitor/fsm-path-utils-darwin.c | 132 +++++++++++++++++
 compat/fsmonitor/fsm-path-utils-win32.c  | 145 +++++++++++++++++++
 compat/fsmonitor/fsm-settings-darwin.c   |  70 +++------
 compat/fsmonitor/fsm-settings-win32.c    | 174 +----------------------
 contrib/buildsystems/CMakeLists.txt      |   4 +
 fsmonitor--daemon.h                      |   3 +
 fsmonitor-ipc.c                          |  18 ++-
 fsmonitor-ipc.h                          |   4 +-
 fsmonitor-path-utils.h                   |  59 ++++++++
 fsmonitor-settings.c                     |  60 +++++++-
 fsmonitor-settings.h                     |   2 +-
 fsmonitor.c                              |   4 +
 18 files changed, 559 insertions(+), 240 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 fsmonitor-path-utils.h


base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v8:

 1:  155a6890806 = 1:  155a6890806 fsmonitor: refactor filesystem checks to common interface
 2:  b5356497228 ! 2:  68709d788d5 fsmonitor: relocate socket file if .git directory is remote
     @@ compat/fsmonitor/fsm-ipc-darwin.c (new)
      +	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
      +
      +	/* Create the socket file in either socketDir or $HOME */
     -+	if (sock_dir && *sock_dir)
     ++	if (sock_dir && *sock_dir) {
      +		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
      +					sock_dir, hash_to_hex(hash));
     -+	else
     ++		free(sock_dir);
     ++	} else {
      +		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
     ++	}
      +
      +	ipc_path = interpolate_path(ipc_file.buf, 1);
      +	if (!ipc_path)
 3:  6719ca2b24d = 3:  6ddd922917a fsmonitor: avoid socket location check if using hook
 4:  d736cb8fa90 ! 4:  73afd9f3122 fsmonitor: deal with synthetic firmlinks on macOS
     @@ Commit message
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
     -    fsmonitor: deal with synthetic firmlinks on macOS
     -
     -    Starting with macOS 10.15 (Catalina), Apple introduced a new feature
     -    called 'firmlinks' in order to separate the boot volume into two
     -    volumes, one read-only and one writable but still present them to the
     -    user as a single volume. Along with this change, Apple removed the
     -    ability to create symlinks in the root directory and replaced them with
     -    'synthetic firmlinks'. See 'man synthetic.conf'
     -
     -    When FSEevents reports the path of changed files, if the path involves
     -    a synthetic firmlink, the path is reported from the point of the
     -    synthetic firmlink and not the real path. For example:
     -
     -    Real path:
     -    /System/Volumes/Data/network/working/directory/foo.txt
     -
     -    Synthetic firmlink:
     -    /network -> /System/Volumes/Data/network
     -
     -    FSEvents path:
     -    /network/working/directory/foo.txt
     -
     -    This causes the FSEvents path to not match against the worktree
     -    directory.
     -
     -    There are several ways in which synthetic firmlinks can be created:
     -    they can be defined in /etc/synthetic.conf, the automounter can create
     -    them, and there may be other means. Simply reading /etc/synthetic.conf
     -    is insufficient. No matter what process creates synthetic firmlinks,
     -    they all get created in the root directory.
     -
     -    Therefore, in order to deal with synthetic firmlinks, the root directory
     -    is scanned and the first possible synthetic firmink that, when resolved,
     -    is a prefix of the worktree is used to map FSEvents paths to worktree
     -    paths.
     -
     -    Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
     -
     -    fsmonitor: deal with synthetic firmlinks on macOS
     -
     -    Starting with macOS 10.15 (Catalina), Apple introduced a new feature
     -    called 'firmlinks' in order to separate the boot volume into two
     -    volumes, one read-only and one writable but still present them to the
     -    user as a single volume. Along with this change, Apple removed the
     -    ability to create symlinks in the root directory and replaced them with
     -    'synthetic firmlinks'. See 'man synthetic.conf'
     -
     -    When FSEevents reports the path of changed files, if the path involves
     -    a synthetic firmlink, the path is reported from the point of the
     -    synthetic firmlink and not the real path. For example:
     -
     -    Real path:
     -    /System/Volumes/Data/network/working/directory/foo.txt
     -
     -    Synthetic firmlink:
     -    /network -> /System/Volumes/Data/network
     -
     -    FSEvents path:
     -    /network/working/directory/foo.txt
     -
     -    This causes the FSEvents path to not match against the worktree
     -    directory.
     -
     -    There are several ways in which synthetic firmlinks can be created:
     -    they can be defined in /etc/synthetic.conf, the automounter can create
     -    them, and there may be other means. Simply reading /etc/synthetic.conf
     -    is insufficient. No matter what process creates synthetic firmlinks,
     -    they all get created in the root directory.
     -
     -    Therefore, in order to deal with synthetic firmlinks, the root directory
     -    is scanned and the first possible synthetic firmink that, when resolved,
     -    is a prefix of the worktree is used to map FSEvents paths to worktree
     -    paths.
     -
     -    Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
     -
       ## builtin/fsmonitor--daemon.c ##
      @@
       #include "parse-options.h"
 -:  ----------- > 5:  02afeaa01be fsmonitor: check for compatability before communicating with fsmonitor
 5:  ddf4e3e6442 ! 6:  0e8ea28acc1 fsmonitor: add documentation for allowRemote and socketDir options
     @@ Commit message
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
       ## Documentation/git-fsmonitor--daemon.txt ##
     -@@ Documentation/git-fsmonitor--daemon.txt: the change (as happening against the super repo).  However, the client
     +@@ Documentation/git-fsmonitor--daemon.txt: git-fsmonitor{litdd}daemon(1)
     + 
     + NAME
     + ----
     +-git-fsmonitor--daemon - A Built-in File System Monitor
     ++git-fsmonitor--daemon - A Built-in Filesystem Monitor
     + 
     + SYNOPSIS
     + --------
     +@@ Documentation/git-fsmonitor--daemon.txt: DESCRIPTION
     + -----------
     + 
     + A daemon to watch the working directory for file and directory
     +-changes using platform-specific file system notification facilities.
     ++changes using platform-specific filesystem notification facilities.
     + 
     + This daemon communicates directly with commands like `git status`
     + using the link:technical/api-simple-ipc.html[simple IPC] interface
     +@@ Documentation/git-fsmonitor--daemon.txt: CAVEATS
     + -------
     + 
     + The fsmonitor daemon does not currently know about submodules and does
     +-not know to filter out file system events that happen within a
     ++not know to filter out filesystem events that happen within a
     + submodule.  If fsmonitor daemon is watching a super repo and a file is
     + modified within the working directory of a submodule, it will report
     + the change (as happening against the super repo).  However, the client
       will properly ignore these extra events, so performance may be affected
       but it will not cause an incorrect result.
       
      +By default, the fsmonitor daemon refuses to work against network-mounted
     -+repositories; this my be overridden by setting `fsmonitor.allowRemote` to
     ++repositories; this may be overridden by setting `fsmonitor.allowRemote` to
      +`true`. Note, however, that the fsmonitor daemon is not guaranteed to work
     -+correctly with all network-mounted repositores and such use is considered
     ++correctly with all network-mounted repositories and such use is considered
      +experimental.
      +
      +On Mac OS, the inter-process communication (IPC) between various Git
     -+commands and the fsmonitor daemon is done via a Unix domain socket (UDS).
     -+Usage of UDS requires the creation of a file which, by default, is created
     -+in the .git directory.  If the fsmonitor daemon detects that the .git directory
     -+is on a network-mounted file system, it will create the UDS file in $HOME.  If
     -+$HOME itself is on a network-mounted file system or if $HOME is not the desired
     -+location for the UDS file, 'fsmonitor.socketDir' may be set to any valid, local
     -+directory on a file system with proper support.  Mac OS native file systems have
     -+the required support.  File systems known to lack support include FAT32 and
     -+NTFS.  Other file systems may or many not have the needed support; the fsmonitor
     -+daemon is not guaranteed to work with these file systems and such use is
     -+considered experimental.
     ++commands and the fsmonitor daemon is done via a Unix domain socket (UDS) -- a
     ++special type of file -- which is supported by native Mac OS filesystems,
     ++but not on network-mounted filesystems, NTFS, or FAT32.  Other filesystems
     ++may or may not have the needed support; the fsmonitor daemon is not guaranteed
     ++to work with these filesystems and such use is considered experimental.
     ++
     ++By default, the socket is created in the `.git` directory, however, if the
     ++`.git` directory is on a network-mounted filesystem, it will be instead be
     ++created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
     ++network-mounted filesystem in which case you must set the configuration
     ++variable `fsmonitor.socketDir` to the path of a directory on a Mac OS native
     ++filesystem in which to create the socket file.
     ++
     ++If none of the above directories (`.git`, `$HOME`, or `fsmonitor.socketDir`)
     ++is on a native Mac OS file filesystem the fsmonitor daemon will report an
     ++error that will cause the daemon and the currently running command to exit.
      +
      +CONFIGURATION
      +-------------
     ++
      +When `core.fsmonitor` is set to `true` (see linkgit:git-config[1])
      +the fsmonitor daemon will pay attention to the following configuration
      +variables:
      +
     -+fsmonitor.allowRemote::
     ++`fsmonitor.allowRemote`::
      +	By default, the daemon refuses to work against network-mounted
      +	repositories. Setting `fsmonitor.allowRemote` to `true` overrides
      +	this behavior.
      +
     -+fsmonitor.socketDir::
     -+	This option is only used by the Mac OS implementation of the fsmonitor
     -+	daemon.	If set, 'fsmonitor.socketDir' must be set to a valid, local
     -+	directory on a file system that can support Unix domain sockets (UDS).
     ++`fsmonitor.socketDir`::
     ++    This Mac OS-specific option, if set, specifies the directory in
     ++    which to create the Unix domain socket used for communication
     ++    between fsmonitor and various Git commands. The directory must
     ++    reside on a native Mac OS filesystem as discussed above.
      +
       GIT
       ---

-- 
gitgitgadget
