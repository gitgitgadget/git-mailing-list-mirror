Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC48C19F2D
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 01:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiHDBpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiHDBpx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 21:45:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F95C2E9CC
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 18:45:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h13so4309800wrf.6
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 18:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=WoYSiJFuk51KaBGeFFz/f81Sllpa0Ns44iSwMmZxPiM=;
        b=bFooQjArg3bcOZGrmz63QuPe2BSC+i2EX6XlNI3qvilJjt5tgIqsio8l2zVBTcydOn
         xQadj3K9gO0flIVuA3kSP0i+oLNq8vtOwG08wkHglUzqgi18dSmFD4H6mkpQBhYY5Ljz
         XjyTq7vDF0wKaYzlRdTBbAdKrT1r1Z3J6tF5yJYzFe745sCpvElrzRfwJ+FjDYJ8WtKy
         XT1VseUHAraSMPzK50olCcPGDUpTsBu9UGaIBi9SfxXcv1iPfyJcsCZB+TA466qVBUoo
         NiMHpk/ngMfkfjbYEA3XiPbGI0dVuwdFUIX5dni3btEZa8q1eH7jFRTHQo3edWMJTdLX
         6C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=WoYSiJFuk51KaBGeFFz/f81Sllpa0Ns44iSwMmZxPiM=;
        b=yLk6FBnRVAvkqsj4C0FoIdI/lbrcKypFOb5NpO+AgleSCbvLQNFS89Wb1IrfnN51g8
         hQVBzgGu9EzUB3g/uMNDvd3xPPRTMO4WxVdtM8/VoZ+IV2ugrCHswYM3OxL4+JuhSYWZ
         Asuvy6egDOTyEuBykPSFVP/Yl1+6TV4u+f5YBxYVP0WCHxcUo66D6Jrr/ZR4QVb83JWs
         vGNrVdFYGtL7y3Ns0qi4Sf+M9nJbMASbpc/JXjAL4dupy1WnK19csIgHZkdy7oBrIoPH
         XjhHL+xiyxuAzErSJnpxBtpHBQulzs90wl5alUijIF2rFtALCDnY3q3owq+C1V0UlKzU
         fEtQ==
X-Gm-Message-State: ACgBeo0pxTORBwUv2VBhwDHEMQC5t9ZIgCuFQ7kYK5QebPkGkqlfYp0f
        g//0j3YRfzisDchV8A3Q9U/fd2GeSt8=
X-Google-Smtp-Source: AA6agR5kN9NR+jP7OJTs4xXx4CD8nwqeO/8rrpE3BRexEbekIzYrUIZmD75R1dO7yTx6vkZKv9CD8A==
X-Received: by 2002:a5d:64ed:0:b0:220:703f:6dac with SMTP id g13-20020a5d64ed000000b00220703f6dacmr6444275wri.28.1659577546958;
        Wed, 03 Aug 2022 18:45:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az11-20020a05600c600b00b003a50924f1c0sm684980wmb.18.2022.08.03.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:45:45 -0700 (PDT)
Message-Id: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 01:45:33 +0000
Subject: [PATCH v2 00/10] Generalize 'scalar diagnose' into 'git diagnose' and 'git bugreport
 --diagnose'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the preparation for moving Scalar out of 'contrib/' and into Git,
this series moves the functionality of 'scalar diagnose' into a new builtin
('git diagnose') and a new option ('--diagnose') for 'git bugreport'. This
change further aligns Scalar with the objective [1] of having it only
contain functionality and settings that benefit large Git repositories, but
not all repositories. The diagnostics reported by 'scalar diagnose' relevant
for investigating issues in any Git repository, so generating them should be
part of a "normal" Git builtin.

The series is organized as follows:

 * Miscellaneous fixes for the existing 'scalar diagnose' implementation
 * Moving the code for generating diagnostics into a common location in the
   Git tree
 * Implementing 'git diagnose'
 * Implementing 'git bugreport --diagnose'
 * Updating the Scalar roadmap

Finally, despite 'scalar diagnose' now being nothing more than a wrapper for
'git bugreport --diagnose', it is not being deprecated in this series.
Although deprecation -> removal could be a future cleanup effort, 'scalar
diagnose' is kept around for now as an alias for users already accustomed to
using it in 'scalar'.


Changes since V1
================

 * Reorganized patches to fix minor issues (e.g., more gently adding
   directories to the archive) of 'scalar diagnose' in 'scalar.c', before
   the code is moved out of that file.
 * (Almost) entirely redesigned the UI for generating diagnostics. The new
   approach avoids cluttering 'git bugreport' with a mode that doesn't
   actually generate a report. Now, there are distinct options for different
   use cases: generating extra diagnostics with a bug report ('git bugreport
   --diagnose') and generating diagnostics for personal debugging/addition
   to an existing bug report ('git diagnose').
 * Moved 'get_disk_info()' into 'compat/'.
 * Moved 'create_diagnostics_archive()' into a new 'diagnose.c', as it now
   has multiple callers.
 * Updated command & option documentation to more clearly guide users on how
   to use the new options.
 * Added the '--all' (and '--diagnose=all') option to change the default
   behavior of diagnostics generation to exclude '.git' directory contents.
   For many bug reporters, this would reveal private repository contents
   they don't want to expose to the public mailing list. This has the added
   benefit of creating much smaller archives by default, which will be more
   likely to successfully send to the mailing list.

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/pull.1275.v2.git.1657584367.gitgitgadget@gmail.com/

Victoria Dye (10):
  scalar-diagnose: use "$GIT_UNZIP" in test
  scalar-diagnose: avoid 32-bit overflow of size_t
  scalar-diagnose: add directory to archiver more gently
  scalar-diagnose: move 'get_disk_info()' to 'compat/'
  scalar-diagnose: move functionality to common location
  builtin/diagnose.c: create 'git diagnose' builtin
  builtin/diagnose.c: gate certain data behind '--all'
  builtin/bugreport.c: create '--diagnose' option
  scalar-diagnose: use 'git diagnose --all'
  scalar: update technical doc roadmap

 .gitignore                         |   1 +
 Documentation/git-bugreport.txt    |  18 ++
 Documentation/git-diagnose.txt     |  60 +++++++
 Documentation/technical/scalar.txt |   9 +-
 Makefile                           |   2 +
 builtin.h                          |   1 +
 builtin/bugreport.c                |  47 ++++-
 builtin/diagnose.c                 |  62 +++++++
 compat/disk.h                      |  56 ++++++
 contrib/scalar/scalar.c            | 272 +----------------------------
 contrib/scalar/t/t9099-scalar.sh   |   8 +-
 diagnose.c                         | 218 +++++++++++++++++++++++
 diagnose.h                         |   9 +
 git-compat-util.h                  |   1 +
 git.c                              |   1 +
 t/t0091-bugreport.sh               |  44 +++++
 t/t0092-diagnose.sh                |  43 +++++
 17 files changed, 575 insertions(+), 277 deletions(-)
 create mode 100644 Documentation/git-diagnose.txt
 create mode 100644 builtin/diagnose.c
 create mode 100644 compat/disk.h
 create mode 100644 diagnose.c
 create mode 100644 diagnose.h
 create mode 100755 t/t0092-diagnose.sh


base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1310%2Fvdye%2Fscalar%2Fgeneralize-diagnose-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1310/vdye/scalar/generalize-diagnose-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1310

Range-diff vs v1:

  1:  a7a766de29b !  1:  ad5b60bf11e scalar: use "$GIT_UNZIP" in 'scalar diagnose' test
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    scalar: use "$GIT_UNZIP" in 'scalar diagnose' test
     +    scalar-diagnose: use "$GIT_UNZIP" in test
      
          Use the "$GIT_UNZIP" test variable rather than verbatim 'unzip' to unzip the
          'scalar diagnose' archive. Using "$GIT_UNZIP" is needed to run the Scalar
  3:  e8abfdfa892 !  2:  7956dc24b30 builtin/bugreport.c: avoid size_t overflow
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    builtin/bugreport.c: avoid size_t overflow
     +    scalar-diagnose: avoid 32-bit overflow of size_t
      
     -    Avoid size_t overflow when reporting the available disk space in
     +    Avoid 32-bit size_t overflow when reporting the available disk space in
          'get_disk_info' by casting the block size and available block count to
     -    'uint64_t' before multiplying them. Without this change, 'st_mult' would
     -    (correctly) report size_t overflow on 32-bit systems at or exceeding 2^32
     +    'off_t' before multiplying them. Without this change, 'st_mult' would
     +    (correctly) report a size_t overflow on 32-bit systems at or exceeding 2^32
          bytes of available space.
      
     +    Note that 'off_t' is a 64-bit integer even on 32-bit systems due to the
     +    inclusion of '#define _FILE_OFFSET_BITS 64' in 'git-compat-util.h' (see
     +    b97e911643 (Support for large files on 32bit systems., 2007-02-17)).
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     - ## builtin/bugreport.c ##
     -@@ builtin/bugreport.c: static int get_disk_info(struct strbuf *out)
     + ## contrib/scalar/scalar.c ##
     +@@ contrib/scalar/scalar.c: static int get_disk_info(struct strbuf *out)
       	}
       
       	strbuf_addf(out, "Available space on '%s': ", buf.buf);
      -	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
     -+	strbuf_humanise_bytes(out, (uint64_t)stat.f_bsize * (uint64_t)stat.f_bavail);
     ++	strbuf_humanise_bytes(out, (off_t)stat.f_bsize * (off_t)stat.f_bavail);
       	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
       	strbuf_release(&buf);
       #endif
  4:  4bc290fbf43 !  3:  23349bfaf8f builtin/bugreport.c: add directory to archiver more gently
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    builtin/bugreport.c: add directory to archiver more gently
     +    scalar-diagnose: add directory to archiver more gently
      
     -    If a directory added to the '--diagnose' archiver does not exist, warn and
     -    return 0 from 'add_directory_to_archiver()' rather than failing with a fatal
     -    error. This handles a failure edge case where the '.git/logs' has not yet
     -    been created when running 'git bugreport --diagnose', but extends to any
     +    If a directory added to the 'scalar diagnose' archiver does not exist, warn
     +    and return 0 from 'add_directory_to_archiver()' rather than failing with a
     +    fatal error. This handles a failure edge case where the '.git/logs' has not
     +    yet been created when running 'scalar diagnose', but extends to any
          situation where a directory may be missing in the '.git' dir.
      
          Now, when a directory is missing a warning is captured in the diagnostic
     -    logs. This provides a user with more complete information than if 'git
     -    bugreport' simply failed with an error.
     +    logs. This provides a user with more complete information than if 'scalar
     +    diagnose' simply failed with an error.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     - ## builtin/bugreport.c ##
     -@@ builtin/bugreport.c: static int add_directory_to_archiver(struct strvec *archiver_args,
     - 				     const char *path, int recurse)
     + ## contrib/scalar/scalar.c ##
     +@@ contrib/scalar/scalar.c: static int add_directory_to_archiver(struct strvec *archiver_args,
     + 					  const char *path, int recurse)
       {
       	int at_root = !*path;
      -	DIR *dir = opendir(at_root ? "." : path);
     @@ builtin/bugreport.c: static int add_directory_to_archiver(struct strvec *archive
       	size_t len;
       	int res = 0;
       
     -+	if (!file_exists(at_root ? "." : path)) {
     -+		warning(_("directory '%s' does not exist, will not be archived"), path);
     -+		return 0;
     -+	}
     -+
     +-	if (!dir)
      +	dir = opendir(at_root ? "." : path);
     - 	if (!dir)
     ++	if (!dir) {
     ++		if (errno == ENOENT) {
     ++			warning(_("could not archive missing directory '%s'"), path);
     ++			return 0;
     ++		}
       		return error_errno(_("could not open directory '%s'"), path);
     ++	}
       
     -
     - ## t/t0091-bugreport.sh ##
     -@@ t/t0091-bugreport.sh: test_expect_success 'indicates populated hooks' '
     - 	test_cmp expect actual
     - '
     - 
     --test_expect_failure UNZIP '--diagnose creates diagnostics zip archive' '
     -+test_expect_success UNZIP '--diagnose creates diagnostics zip archive' '
     - 	test_when_finished rm -rf report &&
     - 
     - 	git bugreport --diagnose -o report -s test >out &&
     -@@ t/t0091-bugreport.sh: test_expect_failure UNZIP '--diagnose creates diagnostics zip archive' '
     - 	grep "^Total: [0-9][0-9]*" out
     - '
     - 
     -+test_expect_success '--diagnose warns when archived dir does not exist' '
     -+	test_when_finished rm -rf report &&
     -+
     -+	# Remove logs - not guaranteed to exist
     -+	rm -rf .git/logs &&
     -+	git bugreport --diagnose -o report -s test 2>err &&
     -+	grep "directory .\.git/logs. does not exist, will not be archived" err
     -+'
     -+
     - test_done
     + 	if (!at_root)
     + 		strbuf_addf(&buf, "%s/", path);
  -:  ----------- >  4:  05bba1e699f scalar-diagnose: move 'get_disk_info()' to 'compat/'
  6:  4eb3c43d488 !  5:  3a0cb33c658 scalar: use 'git bugreport --diagnose' in 'scalar diagnose'
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    scalar: use 'git bugreport --diagnose' in 'scalar diagnose'
     +    scalar-diagnose: move functionality to common location
      
     -    Replace implementation of 'scalar diagnose' with an internal invocation of
     -    'git bugreport --diagnose --no-report'. The '--diagnose' option of 'git
     -    bugreport' was implemented to mirror what 'scalar diagnose' does, taking
     -    most of its code directly from 'scalar.c'. Remove the now-duplicate code in
     -    'scalar.c' and have 'scalar diagnose' call 'git bugreport' to create the
     -    diagnostics archive.
     +    Move the core functionality of 'scalar diagnose' into a new 'diagnose.[c,h]'
     +    library to prepare for new callers in the main Git tree generating
     +    diagnostic archives. These callers will be introduced in subsequent patches.
      
     -    This introduces two (minor) changes to the output of 'scalar diagnose':
     -    changing "Enlistment root" to "Repository root" in 'diagnostics.log'
     -    ("enlistment root" was inaccurate anyway, as the reported path always
     -    pointed to the root of the repository), and changing the prefix of the zip
     -    archive from 'scalar_' to 'git-diagnostics-'.
     +    While this patch appears large, it is mostly made up of moving code out of
     +    'scalar.c' and into 'diagnose.c'. Specifically, the functions
     +
     +    - dir_file_stats_objects()
     +    - dir_file_stats()
     +    - count_files()
     +    - loose_objs_stats()
     +    - add_directory_to_archiver()
     +
     +    are all copied verbatim from 'scalar.c'. The 'create_diagnostics_archive()'
     +    function is a mostly identical (partial) copy of 'cmd_diagnose()', with the
     +    primary changes being that 'zip_path' is an input and "Enlistment root" is
     +    corrected to "Repository root" in the archiver log.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     + ## Makefile ##
     +@@ Makefile: LIB_OBJS += ctype.o
     + LIB_OBJS += date.o
     + LIB_OBJS += decorate.o
     + LIB_OBJS += delta-islands.o
     ++LIB_OBJS += diagnose.o
     + LIB_OBJS += diff-delta.o
     + LIB_OBJS += diff-merges.o
     + LIB_OBJS += diff-lib.o
     +
       ## contrib/scalar/scalar.c ##
      @@
       #include "dir.h"
       #include "packfile.h"
       #include "help.h"
      -#include "archive.h"
     - #include "object-store.h"
     +-#include "object-store.h"
     +-#include "compat/disk.h"
     ++#include "diagnose.h"
       
       /*
     +  * Remove the deepest subdirectory in the provided path string. Path must not
      @@ contrib/scalar/scalar.c: static int unregister_dir(void)
       	return res;
       }
     @@ contrib/scalar/scalar.c: static int unregister_dir(void)
      -					  const char *path, int recurse)
      -{
      -	int at_root = !*path;
     --	DIR *dir = opendir(at_root ? "." : path);
     +-	DIR *dir;
      -	struct dirent *e;
      -	struct strbuf buf = STRBUF_INIT;
      -	size_t len;
      -	int res = 0;
      -
     --	if (!dir)
     +-	dir = opendir(at_root ? "." : path);
     +-	if (!dir) {
     +-		if (errno == ENOENT) {
     +-			warning(_("could not archive missing directory '%s'"), path);
     +-			return 0;
     +-		}
      -		return error_errno(_("could not open directory '%s'"), path);
     +-	}
      -
      -	if (!at_root)
      -		strbuf_addf(&buf, "%s/", path);
     @@ contrib/scalar/scalar.c: static int unregister_dir(void)
      -	strbuf_release(&buf);
      -	return res;
      -}
     --
     --#ifndef WIN32
     --#include <sys/statvfs.h>
     --#endif
     --
     --static int get_disk_info(struct strbuf *out)
     --{
     --#ifdef WIN32
     --	struct strbuf buf = STRBUF_INIT;
     --	char volume_name[MAX_PATH], fs_name[MAX_PATH];
     --	DWORD serial_number, component_length, flags;
     --	ULARGE_INTEGER avail2caller, total, avail;
     --
     --	strbuf_realpath(&buf, ".", 1);
     --	if (!GetDiskFreeSpaceExA(buf.buf, &avail2caller, &total, &avail)) {
     --		error(_("could not determine free disk size for '%s'"),
     --		      buf.buf);
     --		strbuf_release(&buf);
     --		return -1;
     --	}
     --
     --	strbuf_setlen(&buf, offset_1st_component(buf.buf));
     --	if (!GetVolumeInformationA(buf.buf, volume_name, sizeof(volume_name),
     --				   &serial_number, &component_length, &flags,
     --				   fs_name, sizeof(fs_name))) {
     --		error(_("could not get info for '%s'"), buf.buf);
     --		strbuf_release(&buf);
     --		return -1;
     --	}
     --	strbuf_addf(out, "Available space on '%s': ", buf.buf);
     --	strbuf_humanise_bytes(out, avail2caller.QuadPart);
     --	strbuf_addch(out, '\n');
     --	strbuf_release(&buf);
     --#else
     --	struct strbuf buf = STRBUF_INIT;
     --	struct statvfs stat;
     --
     --	strbuf_realpath(&buf, ".", 1);
     --	if (statvfs(buf.buf, &stat) < 0) {
     --		error_errno(_("could not determine free disk size for '%s'"),
     --			    buf.buf);
     --		strbuf_release(&buf);
     --		return -1;
     --	}
     --
     --	strbuf_addf(out, "Available space on '%s': ", buf.buf);
     --	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
     --	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
     --	strbuf_release(&buf);
     --#endif
     --	return 0;
     --}
      -
       /* printf-style interface, expects `<key>=<value>` argument */
       static int set_config(const char *fmt, ...)
     @@ contrib/scalar/scalar.c: cleanup:
       {
       	struct option options[] = {
      @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
     - 		N_("scalar diagnose [<enlistment>]"),
       		NULL
       	};
     --	struct strbuf zip_path = STRBUF_INIT;
     + 	struct strbuf zip_path = STRBUF_INIT;
      -	struct strvec archiver_args = STRVEC_INIT;
      -	char **argv_copy = NULL;
      -	int stdout_fd = -1, archiver_fd = -1;
     --	time_t now = time(NULL);
     --	struct tm tm;
     + 	time_t now = time(NULL);
     + 	struct tm tm;
      -	struct strbuf buf = STRBUF_INIT;
     -+	struct strbuf diagnostics_path = STRBUF_INIT;
       	int res = 0;
       
       	argc = parse_options(argc, argv, NULL, options,
     - 			     usage, 0);
     - 
     --	setup_enlistment_directory(argc, argv, usage, options, &zip_path);
     --
     --	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
     --	strbuf_addftime(&zip_path,
     --			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
     --	strbuf_addstr(&zip_path, ".zip");
     --	switch (safe_create_leading_directories(zip_path.buf)) {
     --	case SCLD_EXISTS:
     --	case SCLD_OK:
     --		break;
     --	default:
     --		error_errno(_("could not create directory for '%s'"),
     --			    zip_path.buf);
     --		goto diagnose_cleanup;
     --	}
     +@@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
     + 			    zip_path.buf);
     + 		goto diagnose_cleanup;
     + 	}
      -	stdout_fd = dup(1);
      -	if (stdout_fd < 0) {
      -		res = error_errno(_("could not duplicate stdout"));
     @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
      -	strvec_pushf(&archiver_args,
      -		     "--add-virtual-file=diagnostics.log:%.*s",
      -		     (int)buf.len, buf.buf);
     -+	setup_enlistment_directory(argc, argv, usage, options, &diagnostics_path);
     -+	strbuf_addstr(&diagnostics_path, "/.scalarDiagnostics");
     - 
     +-
      -	strbuf_reset(&buf);
      -	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
      -	dir_file_stats(the_repository->objects->odb, &buf);
     @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
      -		error(_("failed to write archive"));
      -		goto diagnose_cleanup;
      -	}
     --
     + 
      -	if (!res)
      -		fprintf(stderr, "\n"
      -		       "Diagnostics complete.\n"
      -		       "All of the gathered info is captured in '%s'\n",
      -		       zip_path.buf);
     --
     --diagnose_cleanup:
     ++	res = create_diagnostics_archive(&zip_path);
     + 
     + diagnose_cleanup:
      -	if (archiver_fd >= 0) {
      -		close(1);
      -		dup2(stdout_fd, 1);
      -	}
      -	free(argv_copy);
      -	strvec_clear(&archiver_args);
     --	strbuf_release(&zip_path);
     + 	strbuf_release(&zip_path);
      -	strbuf_release(&buf);
     -+	if (run_git("bugreport", "--diagnose", "--no-report",
     -+		    "-s", "%Y%m%d_%H%M%S", "-o", diagnostics_path.buf, NULL) < 0)
     -+		res = -1;
     - 
     -+	strbuf_release(&diagnostics_path);
     +-
       	return res;
       }
       
     +
     + ## diagnose.c (new) ##
     +@@
     ++#include "diagnose.h"
     ++#include "compat/disk.h"
     ++#include "archive.h"
     ++#include "dir.h"
     ++#include "help.h"
     ++#include "strvec.h"
     ++#include "object-store.h"
     ++#include "packfile.h"
     ++
     ++static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
     ++				   const char *file_name, void *data)
     ++{
     ++	struct strbuf *buf = data;
     ++	struct stat st;
     ++
     ++	if (!stat(full_path, &st))
     ++		strbuf_addf(buf, "%-70s %16" PRIuMAX "\n", file_name,
     ++			    (uintmax_t)st.st_size);
     ++}
     ++
     ++static int dir_file_stats(struct object_directory *object_dir, void *data)
     ++{
     ++	struct strbuf *buf = data;
     ++
     ++	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
     ++
     ++	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
     ++				  data);
     ++
     ++	return 0;
     ++}
     ++
     ++static int count_files(char *path)
     ++{
     ++	DIR *dir = opendir(path);
     ++	struct dirent *e;
     ++	int count = 0;
     ++
     ++	if (!dir)
     ++		return 0;
     ++
     ++	while ((e = readdir(dir)) != NULL)
     ++		if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG)
     ++			count++;
     ++
     ++	closedir(dir);
     ++	return count;
     ++}
     ++
     ++static void loose_objs_stats(struct strbuf *buf, const char *path)
     ++{
     ++	DIR *dir = opendir(path);
     ++	struct dirent *e;
     ++	int count;
     ++	int total = 0;
     ++	unsigned char c;
     ++	struct strbuf count_path = STRBUF_INIT;
     ++	size_t base_path_len;
     ++
     ++	if (!dir)
     ++		return;
     ++
     ++	strbuf_addstr(buf, "Object directory stats for ");
     ++	strbuf_add_absolute_path(buf, path);
     ++	strbuf_addstr(buf, ":\n");
     ++
     ++	strbuf_add_absolute_path(&count_path, path);
     ++	strbuf_addch(&count_path, '/');
     ++	base_path_len = count_path.len;
     ++
     ++	while ((e = readdir(dir)) != NULL)
     ++		if (!is_dot_or_dotdot(e->d_name) &&
     ++		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
     ++		    !hex_to_bytes(&c, e->d_name, 1)) {
     ++			strbuf_setlen(&count_path, base_path_len);
     ++			strbuf_addstr(&count_path, e->d_name);
     ++			total += (count = count_files(count_path.buf));
     ++			strbuf_addf(buf, "%s : %7d files\n", e->d_name, count);
     ++		}
     ++
     ++	strbuf_addf(buf, "Total: %d loose objects", total);
     ++
     ++	strbuf_release(&count_path);
     ++	closedir(dir);
     ++}
     ++
     ++static int add_directory_to_archiver(struct strvec *archiver_args,
     ++				     const char *path, int recurse)
     ++{
     ++	int at_root = !*path;
     ++	DIR *dir;
     ++	struct dirent *e;
     ++	struct strbuf buf = STRBUF_INIT;
     ++	size_t len;
     ++	int res = 0;
     ++
     ++	dir = opendir(at_root ? "." : path);
     ++	if (!dir) {
     ++		if (errno == ENOENT) {
     ++			warning(_("could not archive missing directory '%s'"), path);
     ++			return 0;
     ++		}
     ++		return error_errno(_("could not open directory '%s'"), path);
     ++	}
     ++
     ++	if (!at_root)
     ++		strbuf_addf(&buf, "%s/", path);
     ++	len = buf.len;
     ++	strvec_pushf(archiver_args, "--prefix=%s", buf.buf);
     ++
     ++	while (!res && (e = readdir(dir))) {
     ++		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
     ++			continue;
     ++
     ++		strbuf_setlen(&buf, len);
     ++		strbuf_addstr(&buf, e->d_name);
     ++
     ++		if (e->d_type == DT_REG)
     ++			strvec_pushf(archiver_args, "--add-file=%s", buf.buf);
     ++		else if (e->d_type != DT_DIR)
     ++			warning(_("skipping '%s', which is neither file nor "
     ++				  "directory"), buf.buf);
     ++		else if (recurse &&
     ++			 add_directory_to_archiver(archiver_args,
     ++						   buf.buf, recurse) < 0)
     ++			res = -1;
     ++	}
     ++
     ++	closedir(dir);
     ++	strbuf_release(&buf);
     ++	return res;
     ++}
     ++
     ++int create_diagnostics_archive(struct strbuf *zip_path)
     ++{
     ++	struct strvec archiver_args = STRVEC_INIT;
     ++	char **argv_copy = NULL;
     ++	int stdout_fd = -1, archiver_fd = -1;
     ++	struct strbuf buf = STRBUF_INIT;
     ++	int res;
     ++
     ++	stdout_fd = dup(STDOUT_FILENO);
     ++	if (stdout_fd < 0) {
     ++		res = error_errno(_("could not duplicate stdout"));
     ++		goto diagnose_cleanup;
     ++	}
     ++
     ++	archiver_fd = xopen(zip_path->buf, O_CREAT | O_WRONLY | O_TRUNC, 0666);
     ++	if (dup2(archiver_fd, STDOUT_FILENO) < 0) {
     ++		res = error_errno(_("could not redirect output"));
     ++		goto diagnose_cleanup;
     ++	}
     ++
     ++	init_zip_archiver();
     ++	strvec_pushl(&archiver_args, "git-diagnose", "--format=zip", NULL);
     ++
     ++	strbuf_reset(&buf);
     ++	strbuf_addstr(&buf, "Collecting diagnostic info\n\n");
     ++	get_version_info(&buf, 1);
     ++
     ++	strbuf_addf(&buf, "Repository root: %s\n", the_repository->worktree);
     ++	get_disk_info(&buf);
     ++	write_or_die(stdout_fd, buf.buf, buf.len);
     ++	strvec_pushf(&archiver_args,
     ++		     "--add-virtual-file=diagnostics.log:%.*s",
     ++		     (int)buf.len, buf.buf);
     ++
     ++	strbuf_reset(&buf);
     ++	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
     ++	dir_file_stats(the_repository->objects->odb, &buf);
     ++	foreach_alt_odb(dir_file_stats, &buf);
     ++	strvec_push(&archiver_args, buf.buf);
     ++
     ++	strbuf_reset(&buf);
     ++	strbuf_addstr(&buf, "--add-virtual-file=objects-local.txt:");
     ++	loose_objs_stats(&buf, ".git/objects");
     ++	strvec_push(&archiver_args, buf.buf);
     ++
     ++	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
     ++	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
     ++	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
     ++	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
     ++	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
     ++		goto diagnose_cleanup;
     ++
     ++	strvec_pushl(&archiver_args, "--prefix=",
     ++		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
     ++
     ++	/* `write_archive()` modifies the `argv` passed to it. Let it. */
     ++	argv_copy = xmemdupz(archiver_args.v,
     ++			     sizeof(char *) * archiver_args.nr);
     ++	res = write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
     ++			    the_repository, NULL, 0);
     ++	if (res) {
     ++		error(_("failed to write archive"));
     ++		goto diagnose_cleanup;
     ++	}
     ++
     ++	if (!res)
     ++		fprintf(stderr, "\n"
     ++			"Diagnostics complete.\n"
     ++			"All of the gathered info is captured in '%s'\n",
     ++			zip_path->buf);
     ++
     ++diagnose_cleanup:
     ++	if (archiver_fd >= 0) {
     ++		dup2(stdout_fd, STDOUT_FILENO);
     ++		close(stdout_fd);
     ++		close(archiver_fd);
     ++	}
     ++	free(argv_copy);
     ++	strvec_clear(&archiver_args);
     ++	strbuf_release(&buf);
     ++
     ++	return res;
     ++}
     +
     + ## diagnose.h (new) ##
     +@@
     ++#ifndef DIAGNOSE_H
     ++#define DIAGNOSE_H
     ++
     ++#include "cache.h"
     ++#include "strbuf.h"
     ++
     ++int create_diagnostics_archive(struct strbuf *zip_path);
     ++
     ++#endif /* DIAGNOSE_H */
  -:  ----------- >  6:  73e139ee377 builtin/diagnose.c: create 'git diagnose' builtin
  -:  ----------- >  7:  a3e62a4a041 builtin/diagnose.c: gate certain data behind '--all'
  2:  932dc8cddac !  8:  d81e7c10997 builtin/bugreport.c: create '--diagnose' option
     @@ Commit message
          Create a '--diagnose' option for 'git bugreport' to collect additional
          information about the repository and write it to a zipped archive.
      
     -    The "diagnose" functionality was originally implemented for Scalar in
     -    aa5c79a331 (scalar: implement `scalar diagnose`, 2022-05-28). However, the
     -    diagnostics gathered are not specific to Scalar-cloned repositories and
     -    could be useful when diagnosing issues in any Git repository.
     +    The '--diagnose' option behaves effectively as an alias for simultaneously
     +    running 'git bugreport' and 'git diagnose'. In the documentation, users are
     +    explicitly recommended to attach the diagnostics alongside a bug report to
     +    provide additional context to readers, ideally reducing some back-and-forth
     +    between reporters and those debugging the issue.
      
     -    Note that, while this patch appears large, it is mostly copied directly out
     -    of 'scalar.c'. Specifically, the functions
     -
     -    - dir_file_stats_objects()
     -    - dir_file_stats()
     -    - count_files()
     -    - loose_objs_stats()
     -    - add_directory_to_archiver()
     -    - get_disk_info()
     -
     -    are all copied verbatim from 'scalar.c'. The 'create_diagnostics_archive()'
     -    function is a mostly unmodified copy of 'cmd_diagnose()', with the primary
     -    changes being that 'zip_path' is an input and "Enlistment root" is corrected
     -    to "Repository root" in the logs.
     -
     -    The remainder of the patch is made up of adding the '--diagnose' option to
     -    'cmd_bugreport()' (including generation of the archive's 'zip_path'),
     -    updating documentation, and adding a test. Note that the test is
     -    'test_expect_failure' due to bugs in the original 'scalar diagnose'. These
     -    will be fixed in subsequent patches.
     +    Note that '--diagnose' may take an optional string arg (either 'basic' or
     +    'all'). If specified without the arg or with 'basic', the behavior
     +    corresponds to running 'git diagnose' without '--all'; this default is meant
     +    to help reduce unintentional leaking of sensitive information). However, a
     +    user can still manually specify '--diagnose=all' to generate the equivalent
     +    archive to one created with 'git diagnose --all'.
      
          Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-bugreport.txt ##
     -@@ Documentation/git-bugreport.txt: git-bugreport - Collect information for user to file a bug report
     - SYNOPSIS
     +@@ Documentation/git-bugreport.txt: SYNOPSIS
       --------
       [verse]
     --'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
     -+'git bugreport' [<options>]
     + 'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
     ++		[--diagnose[=(basic|all)]]
       
       DESCRIPTION
       -----------
     @@ Documentation/git-bugreport.txt: The following information is captured automatic
        - $SHELL
       
      +Additional information may be gathered into a separate zip archive using the
     -+`--diagnose` option.
     ++`--diagnose` option, and can be attached alongside the bugreport document to
     ++provide additional context to readers.
      +
       This tool is invoked via the typical Git setup process, which means that in some
       cases, it might not be able to launch - for example, if a relevant config file
     @@ Documentation/git-bugreport.txt: OPTIONS
       	named 'git-bugreport-<formatted suffix>'. This should take the form of a
       	strftime(3) format string; the current local time will be used.
       
     -+--diagnose::
     ++--diagnose[=(basic|all)]::
      +	Create a zip archive of information about the repository including logs
      +	and certain statistics describing the data shape of the repository. The
      +	archive is written to the same output directory as the bug report and is
      +	named 'git-diagnostics-<formatted suffix>'.
     +++
     ++By default, `--diagnose` (equivalent to `--diagnose=basic`) will collect only
     ++statistics and summarized data about the repository and filesystem. Specifying
     ++`--diagnose=all` will create an archive with the same contents generated by `git
     ++diagnose --all`; this archive will be much larger, and will contain potentially
     ++sensitive information about the repository. See linkgit:git-diagnose[1] for more
     ++details on the contents of the diagnostic archive.
      +
       GIT
       ---
     @@ builtin/bugreport.c
       #include "compat/compiler.h"
       #include "hook.h"
       #include "hook-list.h"
     -+#include "dir.h"
     -+#include "object-store.h"
     -+#include "packfile.h"
     -+#include "archive.h"
     ++#include "diagnose.h"
       
     ++enum diagnose_mode {
     ++	DIAGNOSE_NONE,
     ++	DIAGNOSE_BASIC,
     ++	DIAGNOSE_ALL
     ++};
       
       static void get_system_info(struct strbuf *sys_info)
     -@@ builtin/bugreport.c: static void get_populated_hooks(struct strbuf *hook_info, int nongit)
     - }
     - 
     - static const char * const bugreport_usage[] = {
     --	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
     -+	N_("git bugreport [<options>]"),
     - 	NULL
     - };
     - 
     + {
      @@ builtin/bugreport.c: static void get_header(struct strbuf *buf, const char *title)
       	strbuf_addf(buf, "\n\n[%s]\n", title);
       }
       
     -+static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
     -+				   const char *file_name, void *data)
     -+{
     -+	struct strbuf *buf = data;
     -+	struct stat st;
     -+
     -+	if (!stat(full_path, &st))
     -+		strbuf_addf(buf, "%-70s %16" PRIuMAX "\n", file_name,
     -+			    (uintmax_t)st.st_size);
     -+}
     -+
     -+static int dir_file_stats(struct object_directory *object_dir, void *data)
     -+{
     -+	struct strbuf *buf = data;
     -+
     -+	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
     -+
     -+	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
     -+				  data);
     -+
     -+	return 0;
     -+}
     -+
     -+static int count_files(char *path)
     -+{
     -+	DIR *dir = opendir(path);
     -+	struct dirent *e;
     -+	int count = 0;
     -+
     -+	if (!dir)
     -+		return 0;
     -+
     -+	while ((e = readdir(dir)) != NULL)
     -+		if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG)
     -+			count++;
     -+
     -+	closedir(dir);
     -+	return count;
     -+}
     -+
     -+static void loose_objs_stats(struct strbuf *buf, const char *path)
     -+{
     -+	DIR *dir = opendir(path);
     -+	struct dirent *e;
     -+	int count;
     -+	int total = 0;
     -+	unsigned char c;
     -+	struct strbuf count_path = STRBUF_INIT;
     -+	size_t base_path_len;
     -+
     -+	if (!dir)
     -+		return;
     -+
     -+	strbuf_addstr(buf, "Object directory stats for ");
     -+	strbuf_add_absolute_path(buf, path);
     -+	strbuf_addstr(buf, ":\n");
     -+
     -+	strbuf_add_absolute_path(&count_path, path);
     -+	strbuf_addch(&count_path, '/');
     -+	base_path_len = count_path.len;
     -+
     -+	while ((e = readdir(dir)) != NULL)
     -+		if (!is_dot_or_dotdot(e->d_name) &&
     -+		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
     -+		    !hex_to_bytes(&c, e->d_name, 1)) {
     -+			strbuf_setlen(&count_path, base_path_len);
     -+			strbuf_addstr(&count_path, e->d_name);
     -+			total += (count = count_files(count_path.buf));
     -+			strbuf_addf(buf, "%s : %7d files\n", e->d_name, count);
     -+		}
     -+
     -+	strbuf_addf(buf, "Total: %d loose objects", total);
     -+
     -+	strbuf_release(&count_path);
     -+	closedir(dir);
     -+}
     -+
     -+static int add_directory_to_archiver(struct strvec *archiver_args,
     -+				     const char *path, int recurse)
     -+{
     -+	int at_root = !*path;
     -+	DIR *dir = opendir(at_root ? "." : path);
     -+	struct dirent *e;
     -+	struct strbuf buf = STRBUF_INIT;
     -+	size_t len;
     -+	int res = 0;
     -+
     -+	if (!dir)
     -+		return error_errno(_("could not open directory '%s'"), path);
     -+
     -+	if (!at_root)
     -+		strbuf_addf(&buf, "%s/", path);
     -+	len = buf.len;
     -+	strvec_pushf(archiver_args, "--prefix=%s", buf.buf);
     -+
     -+	while (!res && (e = readdir(dir))) {
     -+		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
     -+			continue;
     -+
     -+		strbuf_setlen(&buf, len);
     -+		strbuf_addstr(&buf, e->d_name);
     -+
     -+		if (e->d_type == DT_REG)
     -+			strvec_pushf(archiver_args, "--add-file=%s", buf.buf);
     -+		else if (e->d_type != DT_DIR)
     -+			warning(_("skipping '%s', which is neither file nor "
     -+				  "directory"), buf.buf);
     -+		else if (recurse &&
     -+			 add_directory_to_archiver(archiver_args,
     -+						   buf.buf, recurse) < 0)
     -+			res = -1;
     -+	}
     -+
     -+	closedir(dir);
     -+	strbuf_release(&buf);
     -+	return res;
     -+}
     -+
     -+#ifndef WIN32
     -+#include <sys/statvfs.h>
     -+#endif
     -+
     -+static int get_disk_info(struct strbuf *out)
     ++static int option_parse_diagnose(const struct option *opt,
     ++				 const char *arg, int unset)
      +{
     -+#ifdef WIN32
     -+	struct strbuf buf = STRBUF_INIT;
     -+	char volume_name[MAX_PATH], fs_name[MAX_PATH];
     -+	DWORD serial_number, component_length, flags;
     -+	ULARGE_INTEGER avail2caller, total, avail;
     -+
     -+	strbuf_realpath(&buf, ".", 1);
     -+	if (!GetDiskFreeSpaceExA(buf.buf, &avail2caller, &total, &avail)) {
     -+		error(_("could not determine free disk size for '%s'"),
     -+		      buf.buf);
     -+		strbuf_release(&buf);
     -+		return -1;
     -+	}
     ++	enum diagnose_mode *diagnose = opt->value;
      +
     -+	strbuf_setlen(&buf, offset_1st_component(buf.buf));
     -+	if (!GetVolumeInformationA(buf.buf, volume_name, sizeof(volume_name),
     -+				   &serial_number, &component_length, &flags,
     -+				   fs_name, sizeof(fs_name))) {
     -+		error(_("could not get info for '%s'"), buf.buf);
     -+		strbuf_release(&buf);
     -+		return -1;
     -+	}
     -+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
     -+	strbuf_humanise_bytes(out, avail2caller.QuadPart);
     -+	strbuf_addch(out, '\n');
     -+	strbuf_release(&buf);
     -+#else
     -+	struct strbuf buf = STRBUF_INIT;
     -+	struct statvfs stat;
     ++	BUG_ON_OPT_NEG(unset);
      +
     -+	strbuf_realpath(&buf, ".", 1);
     -+	if (statvfs(buf.buf, &stat) < 0) {
     -+		error_errno(_("could not determine free disk size for '%s'"),
     -+			    buf.buf);
     -+		strbuf_release(&buf);
     -+		return -1;
     -+	}
     ++	if (!arg || !strcmp(arg, "basic"))
     ++		*diagnose = DIAGNOSE_BASIC;
     ++	else if (!strcmp(arg, "all"))
     ++		*diagnose = DIAGNOSE_ALL;
     ++	else
     ++		die(_("diagnose mode must be either 'basic' or 'all'"));
      +
     -+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
     -+	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
     -+	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
     -+	strbuf_release(&buf);
     -+#endif
      +	return 0;
      +}
     -+
     -+static int create_diagnostics_archive(struct strbuf *zip_path)
     -+{
     -+	struct strvec archiver_args = STRVEC_INIT;
     -+	char **argv_copy = NULL;
     -+	int stdout_fd = -1, archiver_fd = -1;
     -+	struct strbuf buf = STRBUF_INIT;
     -+	int res = 0;
     -+
     -+	stdout_fd = dup(1);
     -+	if (stdout_fd < 0) {
     -+		res = error_errno(_("could not duplicate stdout"));
     -+		goto diagnose_cleanup;
     -+	}
     -+
     -+	archiver_fd = xopen(zip_path->buf, O_CREAT | O_WRONLY | O_TRUNC, 0666);
     -+	if (archiver_fd < 0 || dup2(archiver_fd, 1) < 0) {
     -+		res = error_errno(_("could not redirect output"));
     -+		goto diagnose_cleanup;
     -+	}
     -+
     -+	init_zip_archiver();
     -+	strvec_pushl(&archiver_args, "scalar-diagnose", "--format=zip", NULL);
     -+
     -+	strbuf_reset(&buf);
     -+	strbuf_addstr(&buf, "Collecting diagnostic info\n\n");
     -+	get_version_info(&buf, 1);
     -+
     -+	strbuf_addf(&buf, "Repository root: %s\n", the_repository->worktree);
     -+	get_disk_info(&buf);
     -+	write_or_die(stdout_fd, buf.buf, buf.len);
     -+	strvec_pushf(&archiver_args,
     -+		     "--add-virtual-file=diagnostics.log:%.*s",
     -+		     (int)buf.len, buf.buf);
     -+
     -+	strbuf_reset(&buf);
     -+	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
     -+	dir_file_stats(the_repository->objects->odb, &buf);
     -+	foreach_alt_odb(dir_file_stats, &buf);
     -+	strvec_push(&archiver_args, buf.buf);
     -+
     -+	strbuf_reset(&buf);
     -+	strbuf_addstr(&buf, "--add-virtual-file=objects-local.txt:");
     -+	loose_objs_stats(&buf, ".git/objects");
     -+	strvec_push(&archiver_args, buf.buf);
     -+
     -+	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
     -+	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
     -+	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
     -+	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
     -+	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
     -+		goto diagnose_cleanup;
     -+
     -+	strvec_pushl(&archiver_args, "--prefix=",
     -+		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
     -+
     -+	/* `write_archive()` modifies the `argv` passed to it. Let it. */
     -+	argv_copy = xmemdupz(archiver_args.v,
     -+			     sizeof(char *) * archiver_args.nr);
     -+	res = write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
     -+			    the_repository, NULL, 0);
     -+	if (res) {
     -+		error(_("failed to write archive"));
     -+		goto diagnose_cleanup;
     -+	}
     -+
     -+	if (!res)
     -+		fprintf(stderr, "\n"
     -+			"Diagnostics complete.\n"
     -+			"All of the gathered info is captured in '%s'\n",
     -+			zip_path->buf);
     -+
     -+diagnose_cleanup:
     -+	if (archiver_fd >= 0) {
     -+		close(1);
     -+		dup2(stdout_fd, 1);
     -+	}
     -+	free(argv_copy);
     -+	strvec_clear(&archiver_args);
     -+	strbuf_release(&buf);
     -+
     -+	return res;
     -+}
      +
       int cmd_bugreport(int argc, const char **argv, const char *prefix)
       {
     @@ builtin/bugreport.c: int cmd_bugreport(int argc, const char **argv, const char *
       	int report = -1;
       	time_t now = time(NULL);
       	struct tm tm;
     -+	int diagnose = 0;
     ++	enum diagnose_mode diagnose = DIAGNOSE_NONE;
       	char *option_output = NULL;
       	char *option_suffix = "%Y-%m-%d-%H%M";
       	const char *user_relative_path = NULL;
     @@ builtin/bugreport.c: int cmd_bugreport(int argc, const char **argv, const char *
      +	size_t output_path_len;
       
       	const struct option bugreport_options[] = {
     -+		OPT_BOOL(0, "diagnose", &diagnose,
     -+			 N_("generate a diagnostics zip archive")),
     ++		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("(basic|all)"),
     ++			       N_("create an additional zip archive of detailed diagnostics"),
     ++			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, option_parse_diagnose),
       		OPT_STRING('o', "output-directory", &option_output, N_("path"),
      -			   N_("specify a destination for the bugreport file")),
      +			   N_("specify a destination for the bugreport file(s)")),
     @@ builtin/bugreport.c: int cmd_bugreport(int argc, const char **argv, const char *
       	}
       
      +	/* Prepare diagnostics, if requested */
     -+	if (diagnose) {
     ++	if (diagnose != DIAGNOSE_NONE) {
      +		struct strbuf zip_path = STRBUF_INIT;
      +		strbuf_add(&zip_path, report_path.buf, output_path_len);
      +		strbuf_addstr(&zip_path, "git-diagnostics-");
      +		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
      +		strbuf_addstr(&zip_path, ".zip");
      +
     -+		if (create_diagnostics_archive(&zip_path))
     ++		if (create_diagnostics_archive(&zip_path, diagnose == DIAGNOSE_ALL))
      +			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
      +
      +		strbuf_release(&zip_path);
     @@ t/t0091-bugreport.sh: test_expect_success 'indicates populated hooks' '
       	test_cmp expect actual
       '
       
     -+test_expect_failure UNZIP '--diagnose creates diagnostics zip archive' '
     ++test_expect_success UNZIP '--diagnose creates diagnostics zip archive' '
      +	test_when_finished rm -rf report &&
      +
      +	git bugreport --diagnose -o report -s test >out &&
     @@ t/t0091-bugreport.sh: test_expect_success 'indicates populated hooks' '
      +	grep ".git/objects" out &&
      +
      +	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
     -+	grep "^Total: [0-9][0-9]*" out
     ++	grep "^Total: [0-9][0-9]*" out &&
     ++
     ++	# Should not include .git directory contents by default
     ++	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
     ++'
     ++
     ++test_expect_success UNZIP '--diagnose=basic excludes .git dir contents' '
     ++	test_when_finished rm -rf report &&
     ++
     ++	git bugreport --diagnose=basic -o report -s test >out &&
     ++
     ++	# Should not include .git directory contents
     ++	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
     ++'
     ++
     ++test_expect_success UNZIP '--diagnose=all includes .git dir contents' '
     ++	test_when_finished rm -rf report &&
     ++
     ++	git bugreport --diagnose=all -o report -s test >out &&
     ++
     ++	# Should include .git directory contents
     ++	"$GIT_UNZIP" -l "$zip_path" | grep ".git/" &&
     ++
     ++	"$GIT_UNZIP" -p "$zip_path" .git/HEAD >out &&
     ++	test_file_not_empty out
      +'
      +
       test_done
  5:  d6527049a4f <  -:  ----------- builtin/bugreport.c: add '--no-report' option
  -:  ----------- >  9:  6834bdcaea8 scalar-diagnose: use 'git diagnose --all'
  7:  86d40a4bd15 ! 10:  14925c3feed scalar: update technical doc roadmap
     @@ Commit message
          scalar: update technical doc roadmap
      
          Update the Scalar roadmap to reflect the completion of generalizing 'scalar
     -    diagnose' into 'git bugreport --diagnose'.
     +    diagnose' into 'git diagnose' and 'git bugreport --diagnose'.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     @@ Documentation/technical/scalar.txt: series have been accepted:
       - `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
       
      +- `scalar-generalize-diagnose`: Move the functionality of `scalar diagnose`
     -+  into `git bugreport --diagnose`.
     ++  into `git diagnose` and `git bugreport --diagnose`.
      +
       Roughly speaking (and subject to change), the following series are needed to
       "finish" this initial version of Scalar:

-- 
gitgitgadget
