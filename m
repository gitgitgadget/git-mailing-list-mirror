Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A39C25B07
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 23:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiHJXel (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiHJXek (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 19:34:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B8781B32
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso1826914wmb.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=U9mtIhkYxJCICc95xhlpHIYfV54LweOc3iTazGa8TME=;
        b=hpiMjCLnA1HjXsuJg1+vP+m2rFH0VibVyjyjgScL6imBiHfxpFQ+RKu34m4uBIbjVi
         +1QjShL7g0bTyPkj0sTw4vaDpYgabGruSYg68YYx26bexXvRwEWDt4Sa7tXmF58zn9gl
         A5ArcWDv7qetXwhZk8fn0IM1HMa0B3b6+i9ehOiwxF4jRI+f5bQvaNcW9yR6bpAyYo+y
         irn1J/BWG+gCMpFx5SrWiX0NCaOwP7Tk8LMhr156pQFrB+qdqufm/8uQjLYotJk7yxCs
         mVIWBl+3Tq+cItmL+k0ZTHPmbjncKXBrPcoh1qjkdUZbjsB3ghBybgDB5ICsfprU41TY
         ev4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=U9mtIhkYxJCICc95xhlpHIYfV54LweOc3iTazGa8TME=;
        b=iNLID/1eZizTzkGsukQmsLPbaLHEIzHSFHTvPO1uIwHWe092Onc1qpP6Mq280Zj2rt
         H+VBBIHQQG9JTtbMpYo6vzcOXyEwlhqjCHGW/eWBusgWN2+FdKCchbwGPwWlVIrdu78y
         NR0Fe1DL10yek3EuGAJ6OSUsGU+cFqA3vEYay7x/qSfbtNFeWgyLVDkrNKtyNMnoiO+n
         rcmINWnMA1LLWWWnc76f/Tb5qRnT8IHsBEi8bMW/QZWqEcVRJhURnhfw7Oypt6RT8eqM
         LrOLNMkIcdbyz3c2nrhevLGmYIrLM43A8WNH99qs020VOoJWs9zOGNRSRdt7LnIzYAVY
         L9Xg==
X-Gm-Message-State: ACgBeo0B4oFwsGuwoyUXkO+t18qFYkRq9lHGvuBQyCRJa7QBHnq3Fgnh
        sfKXa8X9WZnv6qLAj4/1V3cAbz4212Q=
X-Google-Smtp-Source: AA6agR4frDVEGKDncHhk3hP+bkEPY6nZI9Bs9cJjHomC1CQhDlXO0GaNxJNxWz0ZGlxgMWC+ULE0cg==
X-Received: by 2002:a05:600c:35c5:b0:3a5:664d:c556 with SMTP id r5-20020a05600c35c500b003a5664dc556mr3674730wmq.22.1660174475134;
        Wed, 10 Aug 2022 16:34:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20-20020a1cf714000000b003a5125049c9sm4905008wmh.9.2022.08.10.16.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:34:34 -0700 (PDT)
Message-Id: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 23:34:22 +0000
Subject: [PATCH v3 00/11] Generalize 'scalar diagnose' into 'git diagnose' and 'git bugreport
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


Changes since V2
================

 * Replaced 'int include_everything' arg to 'create_diagnostic_archive()'
   with 'enum diagnose_mode mode'.
 * Replaced '--all' with configurable '--mode' option in 'git diagnose';
   moved 'option_parse_diagnose()' into 'diagnose.c' so that it can be used
   for both 'git bugreport --diagnose' and 'git diagnose --mode'.
 * Split "builtin/diagnose.c: gate certain data behind '--all'" (formerly
   patch 7/10) into "diagnose.c: add option to configure archive contents"
   (patch 6/11) and "builtin/diagnose.c: add '--mode' option" (patch 8/11).
 * Added '--no-diagnose' for 'git bugreport'. I was initially going to use
   '--diagnose=none', but '--no-diagnose' was easier to configure when using
   the shared 'option_parse_diagnose()' function .
 * Updated usage strings, option descriptions, and documentation files for
   'mode' option. To avoid needing to keep multiple lists of valid 'mode'
   values up-to-date, format mode value as <mode> everywhere except option
   description in 'git-diagnose.txt', where the values are listed. The
   documentation of '--diagnose' in 'git-bugreport.txt' links to
   'git-diagnose.txt' and explicitly calls out that details on 'mode' can be
   found there.
 * Reworded 'git diagnose' and 'git bugreport' command & option
   documentation.
 * Added additional checks to 't0091-bugreport.sh' and 't0092-diagnose.sh'
   tests
 * Moved '#include "cache.h" from 'diagnose.h' to 'diagnose.c'.
 * Fixed '--output-directory' usage string in 'builtin/diagnose.c'.
 * Replaced 'die()' with 'die_errno()' in error triggered when leading
   directories of archive cannot be created.
 * Changed hardcoded '-1' error exit code in 'scalar diagnose' to returning
   the exit code from 'git diagnose --mode=all'.


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

Victoria Dye (11):
  scalar-diagnose: use "$GIT_UNZIP" in test
  scalar-diagnose: avoid 32-bit overflow of size_t
  scalar-diagnose: add directory to archiver more gently
  scalar-diagnose: move 'get_disk_info()' to 'compat/'
  scalar-diagnose: move functionality to common location
  diagnose.c: add option to configure archive contents
  builtin/diagnose.c: create 'git diagnose' builtin
  builtin/diagnose.c: add '--mode' option
  builtin/bugreport.c: create '--diagnose' option
  scalar-diagnose: use 'git diagnose --mode=all'
  scalar: update technical doc roadmap

 .gitignore                         |   1 +
 Documentation/git-bugreport.txt    |  18 ++
 Documentation/git-diagnose.txt     |  65 +++++++
 Documentation/technical/scalar.txt |   9 +-
 Makefile                           |   2 +
 builtin.h                          |   1 +
 builtin/bugreport.c                |  27 ++-
 builtin/diagnose.c                 |  61 +++++++
 compat/disk.h                      |  56 ++++++
 contrib/scalar/scalar.c            | 271 +----------------------------
 contrib/scalar/t/t9099-scalar.sh   |   8 +-
 diagnose.c                         | 254 +++++++++++++++++++++++++++
 diagnose.h                         |  17 ++
 git-compat-util.h                  |   1 +
 git.c                              |   1 +
 t/t0091-bugreport.sh               |  48 +++++
 t/t0092-diagnose.sh                |  60 +++++++
 17 files changed, 622 insertions(+), 278 deletions(-)
 create mode 100644 Documentation/git-diagnose.txt
 create mode 100644 builtin/diagnose.c
 create mode 100644 compat/disk.h
 create mode 100644 diagnose.c
 create mode 100644 diagnose.h
 create mode 100755 t/t0092-diagnose.sh


base-commit: 4af7188bc97f70277d0f10d56d5373022b1fa385
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1310%2Fvdye%2Fscalar%2Fgeneralize-diagnose-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1310/vdye/scalar/generalize-diagnose-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1310

Range-diff vs v2:

  1:  ad5b60bf11e =  1:  f5ceb9c7190 scalar-diagnose: use "$GIT_UNZIP" in test
  2:  7956dc24b30 =  2:  78a93eb95bb scalar-diagnose: avoid 32-bit overflow of size_t
  3:  23349bfaf8f =  3:  22ee8ea5a1e scalar-diagnose: add directory to archiver more gently
  4:  05bba1e699f =  4:  18f2ba4e0cd scalar-diagnose: move 'get_disk_info()' to 'compat/'
  5:  3a0cb33c658 !  5:  7a51fad87a8 scalar-diagnose: move functionality to common location
     @@ Commit message
          primary changes being that 'zip_path' is an input and "Enlistment root" is
          corrected to "Repository root" in the archiver log.
      
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Makefile ##
     @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
      
       ## diagnose.c (new) ##
      @@
     ++#include "cache.h"
      +#include "diagnose.h"
      +#include "compat/disk.h"
      +#include "archive.h"
     @@ diagnose.h (new)
      +#ifndef DIAGNOSE_H
      +#define DIAGNOSE_H
      +
     -+#include "cache.h"
      +#include "strbuf.h"
      +
      +int create_diagnostics_archive(struct strbuf *zip_path);
  -:  ----------- >  6:  0a6c55696d8 diagnose.c: add option to configure archive contents
  6:  73e139ee377 !  7:  bf3c073a985 builtin/diagnose.c: create 'git diagnose' builtin
     @@ Commit message
          diagnostics gathered are not specific to Scalar-cloned repositories and
          can be useful when diagnosing issues in any Git repository.
      
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## .gitignore ##
     @@ Documentation/git-diagnose.txt (new)
      +    stores
      +  * The total count of loose objects, as well as counts broken down by
      +    `.git/objects` subdirectory
     -+  * The contents of the `.git`, `.git/hooks`, `.git/info`, `.git/logs`, and
     -+    `.git/objects/info` directories
      +
      +This tool differs from linkgit:git-bugreport[1] in that it collects much more
      +detailed information with a greater focus on reporting the size and data shape
     @@ builtin/diagnose.c (new)
      +#include "parse-options.h"
      +#include "diagnose.h"
      +
     -+
      +static const char * const diagnose_usage[] = {
     -+	N_("git diagnose [-o|--output-directory <file>] [-s|--suffix <format>]"),
     ++	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]"),
      +	NULL
      +};
      +
     @@ builtin/diagnose.c (new)
      +	case SCLD_EXISTS:
      +		break;
      +	default:
     -+		die(_("could not create leading directories for '%s'"),
     -+		    zip_path.buf);
     ++		die_errno(_("could not create leading directories for '%s'"),
     ++			  zip_path.buf);
      +	}
      +
      +	/* Prepare diagnostics */
     -+	if (create_diagnostics_archive(&zip_path))
     ++	if (create_diagnostics_archive(&zip_path, DIAGNOSE_STATS))
      +		die_errno(_("unable to create diagnostics archive %s"),
      +			  zip_path.buf);
      +
     @@ t/t0092-diagnose.sh (new)
      +	test_when_finished rm -rf report &&
      +
      +	git diagnose -o report -s test >out &&
     ++	grep "Available space" out &&
      +
      +	zip_path=report/git-diagnostics-test.zip &&
     -+	grep "Available space" out &&
      +	test_path_is_file "$zip_path" &&
      +
      +	# Check zipped archive content
     @@ t/t0092-diagnose.sh (new)
      +	grep ".git/objects" out &&
      +
      +	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
     ++	grep "^Total: [0-9][0-9]*" out &&
     ++
     ++	# Should not include .git directory contents by default
     ++	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
      +	grep "^Total: [0-9][0-9]*" out
      +'
      +
  7:  a3e62a4a041 !  8:  3da0cb725c9 builtin/diagnose.c: gate certain data behind '--all'
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    builtin/diagnose.c: gate certain data behind '--all'
     +    builtin/diagnose.c: add '--mode' option
      
     -    Update 'git diagnose' to *not* include '.git/' directory contents by
     -    default, instead requiring specification of a '--all' option to include it.
     -    While helpful for debugging, the archived '.git/' directory contents may be
     -    sensitive, as they can be used to reconstruct an entire repository.
     +    Create '--mode=<mode>' option in 'git diagnose' to allow users to optionally
     +    select non-default diagnostic information to include in the output archive.
     +    Additionally, document the currently-available modes, emphasizing the
     +    importance of not sharing a '--mode=all' archive publicly due to the
     +    presence of sensitive information.
      
     -    To guard against users inadvertently including this information in
     -    diagnostics and sharing it (e.g., with the mailing list), '.git/' directory
     -    contents will only be included if '--all' is specified.
     +    Note that the option parsing callback - 'option_parse_diagnose()' - is added
     +    to 'diagnose.c' rather than 'builtin/diagnose.c' so that it may be reused in
     +    future callers configuring a diagnostics archive.
      
     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-diagnose.txt ##
     @@ Documentation/git-diagnose.txt: SYNOPSIS
       --------
       [verse]
       'git diagnose' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
     -+	       [-a | --all]
     ++	       [--mode=<mode>]
       
       DESCRIPTION
       -----------
     +@@ Documentation/git-diagnose.txt: repository state and packages that information into a zip archive. The
     + generated archive can then, for example, be shared with the Git mailing list to
     + help debug an issue or serve as a reference for independent debugging.
     + 
     +-The following information is captured in the archive:
     ++By default, the following information is captured in the archive:
     + 
     +   * 'git version --build-options'
     +   * The path to the repository root
      @@ Documentation/git-diagnose.txt: The following information is captured in the archive:
     -     stores
         * The total count of loose objects, as well as counts broken down by
           `.git/objects` subdirectory
     --  * The contents of the `.git`, `.git/hooks`, `.git/info`, `.git/logs`, and
     --    `.git/objects/info` directories
       
     ++Additional information can be collected by selecting a different diagnostic mode
     ++using the `--mode` option.
     ++
       This tool differs from linkgit:git-bugreport[1] in that it collects much more
       detailed information with a greater focus on reporting the size and data shape
     + of repository contents.
      @@ Documentation/git-diagnose.txt: OPTIONS
       	form of a strftime(3) format string; the current local time will be
       	used.
       
     -+-a::
     -+--all::
     -+	Include more complete repository diagnostic information in the archive.
     -+	Specifically, this will add copies of `.git`, `.git/hooks`, `.git/info`,
     -+	`.git/logs`, and `.git/objects/info` directories to the output archive.
     -+	This additional data may be sensitive; a user can reconstruct the full
     -+	contents of the diagnosed repository with this information. Users should
     -+	exercise caution when sharing an archive generated with this option.
     ++--mode=(stats|all)::
     ++	Specify the type of diagnostics that should be collected. The default behavior
     ++	of 'git diagnose' is equivalent to `--mode=stats`.
     +++
     ++The `--mode=all` option collects everything included in `--mode=stats`, as well
     ++as copies of `.git`, `.git/hooks`, `.git/info`, `.git/logs`, and
     ++`.git/objects/info` directories. This additional information may be sensitive,
     ++as it can be used to reconstruct the full contents of the diagnosed repository.
     ++Users should exercise caution when sharing an archive generated with
     ++`--mode=all`.
      +
       GIT
       ---
     @@ Documentation/git-diagnose.txt: OPTIONS
      
       ## builtin/diagnose.c ##
      @@
     - 
     + #include "diagnose.h"
       
       static const char * const diagnose_usage[] = {
     --	N_("git diagnose [-o|--output-directory <file>] [-s|--suffix <format>]"),
     -+	N_("git diagnose [-o|--output-directory <file>] [-s|--suffix <format>] [-a|--all]"),
     +-	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]"),
     ++	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>] [--mode=<mode>]"),
       	NULL
       };
       
     @@ builtin/diagnose.c: int cmd_diagnose(int argc, const char **argv, const char *pr
       	struct strbuf zip_path = STRBUF_INIT;
       	time_t now = time(NULL);
       	struct tm tm;
     -+	int include_everything = 0;
     ++	enum diagnose_mode mode = DIAGNOSE_STATS;
       	char *option_output = NULL;
       	char *option_suffix = "%Y-%m-%d-%H%M";
       	char *prefixed_filename;
     @@ builtin/diagnose.c: int cmd_diagnose(int argc, const char **argv, const char *pr
       			   N_("specify a destination for the diagnostics archive")),
       		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
       			   N_("specify a strftime format suffix for the filename")),
     -+		OPT_BOOL_F('a', "all", &include_everything,
     -+			   N_("collect complete diagnostic information"),
     -+			   PARSE_OPT_NONEG),
     ++		OPT_CALLBACK_F(0, "mode", &mode, N_("(stats|all)"),
     ++			       N_("specify the content of the diagnostic archive"),
     ++			       PARSE_OPT_NONEG, option_parse_diagnose),
       		OPT_END()
       	};
       
     @@ builtin/diagnose.c: int cmd_diagnose(int argc, const char **argv, const char *pr
       	}
       
       	/* Prepare diagnostics */
     --	if (create_diagnostics_archive(&zip_path))
     -+	if (create_diagnostics_archive(&zip_path, include_everything))
     +-	if (create_diagnostics_archive(&zip_path, DIAGNOSE_STATS))
     ++	if (create_diagnostics_archive(&zip_path, mode))
       		die_errno(_("unable to create diagnostics archive %s"),
       			  zip_path.buf);
       
      
     - ## contrib/scalar/scalar.c ##
     -@@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
     - 		goto diagnose_cleanup;
     - 	}
     - 
     --	res = create_diagnostics_archive(&zip_path);
     -+	res = create_diagnostics_archive(&zip_path, 1);
     - 
     - diagnose_cleanup:
     - 	strbuf_release(&zip_path);
     -
       ## diagnose.c ##
     -@@ diagnose.c: static int add_directory_to_archiver(struct strvec *archiver_args,
     - 	return res;
     - }
     +@@
     + #include "object-store.h"
     + #include "packfile.h"
       
     --int create_diagnostics_archive(struct strbuf *zip_path)
     -+int create_diagnostics_archive(struct strbuf *zip_path, int include_everything)
     ++struct diagnose_option {
     ++	enum diagnose_mode mode;
     ++	const char *option_name;
     ++};
     ++
     ++static struct diagnose_option diagnose_options[] = {
     ++	{ DIAGNOSE_STATS, "stats" },
     ++	{ DIAGNOSE_ALL, "all" },
     ++};
     ++
     ++int option_parse_diagnose(const struct option *opt, const char *arg, int unset)
     ++{
     ++	int i;
     ++	enum diagnose_mode *diagnose = opt->value;
     ++
     ++	if (!arg) {
     ++		*diagnose = unset ? DIAGNOSE_NONE : DIAGNOSE_STATS;
     ++		return 0;
     ++	}
     ++
     ++	for (i = 0; i < ARRAY_SIZE(diagnose_options); i++) {
     ++		if (!strcmp(arg, diagnose_options[i].option_name)) {
     ++			*diagnose = diagnose_options[i].mode;
     ++			return 0;
     ++		}
     ++	}
     ++
     ++	return error(_("invalid --%s value '%s'"), opt->long_name, arg);
     ++}
     ++
     + static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
     + 				   const char *file_name, void *data)
       {
     - 	struct strvec archiver_args = STRVEC_INIT;
     - 	char **argv_copy = NULL;
     -@@ diagnose.c: int create_diagnostics_archive(struct strbuf *zip_path)
     - 	loose_objs_stats(&buf, ".git/objects");
     - 	strvec_push(&archiver_args, buf.buf);
     - 
     --	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
     --	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
     --	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
     --	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
     --	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
     -+	/* Only include this if explicitly requested */
     -+	if (include_everything &&
     -+	    ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
     -+	     (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
     -+	     (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
     -+	     (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
     -+	     (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0))))
     - 		goto diagnose_cleanup;
     - 
     - 	strvec_pushl(&archiver_args, "--prefix=",
      
       ## diagnose.h ##
     -@@
     - #include "cache.h"
     - #include "strbuf.h"
     +@@ diagnose.h: enum diagnose_mode {
     + 	DIAGNOSE_ALL
     + };
       
     --int create_diagnostics_archive(struct strbuf *zip_path);
     -+int create_diagnostics_archive(struct strbuf *zip_path, int include_everything);
     ++int option_parse_diagnose(const struct option *opt, const char *arg, int unset);
     ++
     + int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode);
       
       #endif /* DIAGNOSE_H */
      
       ## t/t0092-diagnose.sh ##
      @@ t/t0092-diagnose.sh: test_expect_success UNZIP 'creates diagnostics zip archive' '
     - 	grep ".git/objects" out &&
       
     - 	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
     + 	# Should not include .git directory contents by default
     + 	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
      -	grep "^Total: [0-9][0-9]*" out
     -+	grep "^Total: [0-9][0-9]*" out &&
     ++'
     ++
     ++test_expect_success UNZIP '--mode=stats excludes .git dir contents' '
     ++	test_when_finished rm -rf report &&
      +
     -+	# Should not include .git directory contents
     ++	git diagnose -o report -s test --mode=stats >out &&
     ++
     ++	# Includes pack quantity/size info
     ++	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
     ++	grep ".git/objects" out &&
     ++
     ++	# Does not include .git directory contents
      +	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
      +'
      +
     -+test_expect_success UNZIP '--all includes .git data in archive' '
     ++test_expect_success UNZIP '--mode=all includes .git dir contents' '
      +	test_when_finished rm -rf report &&
      +
     -+	git diagnose -o report -s test --all >out &&
     ++	git diagnose -o report -s test --mode=all >out &&
     ++
     ++	# Includes pack quantity/size info
     ++	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
     ++	grep ".git/objects" out &&
      +
     -+	# Should include .git directory contents
     ++	# Includes .git directory contents
      +	"$GIT_UNZIP" -l "$zip_path" | grep ".git/" &&
      +
      +	"$GIT_UNZIP" -p "$zip_path" .git/HEAD >out &&
  8:  d81e7c10997 !  9:  1a1eb2c9806 builtin/bugreport.c: create '--diagnose' option
     @@ Commit message
          provide additional context to readers, ideally reducing some back-and-forth
          between reporters and those debugging the issue.
      
     -    Note that '--diagnose' may take an optional string arg (either 'basic' or
     -    'all'). If specified without the arg or with 'basic', the behavior
     -    corresponds to running 'git diagnose' without '--all'; this default is meant
     -    to help reduce unintentional leaking of sensitive information). However, a
     -    user can still manually specify '--diagnose=all' to generate the equivalent
     -    archive to one created with 'git diagnose --all'.
     +    Note that '--diagnose' may take an optional string arg (either 'stats' or
     +    'all'). If specified without the arg, the behavior corresponds to running
     +    'git diagnose' without '--mode'. As with 'git diagnose', this default is
     +    intended to help reduce unintentional leaking of sensitive information).
     +    Users can also explicitly specify '--diagnose=(stats|all)' to generate the
     +    respective archive created by 'git diagnose --mode=(stats|all)'.
      
          Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-bugreport.txt ##
     @@ Documentation/git-bugreport.txt: SYNOPSIS
       --------
       [verse]
       'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
     -+		[--diagnose[=(basic|all)]]
     ++		[--diagnose[=<mode>]]
       
       DESCRIPTION
       -----------
     @@ Documentation/git-bugreport.txt: OPTIONS
       	named 'git-bugreport-<formatted suffix>'. This should take the form of a
       	strftime(3) format string; the current local time will be used.
       
     -+--diagnose[=(basic|all)]::
     -+	Create a zip archive of information about the repository including logs
     -+	and certain statistics describing the data shape of the repository. The
     -+	archive is written to the same output directory as the bug report and is
     -+	named 'git-diagnostics-<formatted suffix>'.
     ++--no-diagnose::
     ++--diagnose[=<mode>]::
     ++	Create a zip archive of supplemental information about the user's
     ++	machine, Git client, and repository state. The archive is written to the
     ++	same output directory as the bug report and is named
     ++	'git-diagnostics-<formatted suffix>'.
      ++
     -+By default, `--diagnose` (equivalent to `--diagnose=basic`) will collect only
     -+statistics and summarized data about the repository and filesystem. Specifying
     -+`--diagnose=all` will create an archive with the same contents generated by `git
     -+diagnose --all`; this archive will be much larger, and will contain potentially
     -+sensitive information about the repository. See linkgit:git-diagnose[1] for more
     -+details on the contents of the diagnostic archive.
     ++Without `mode` specified, the diagnostic archive will contain the default set of
     ++statistics reported by `git diagnose`. An optional `mode` value may be specified
     ++to change which information is included in the archive. See
     ++linkgit:git-diagnose[1] for the list of valid values for `mode` and details
     ++about their usage.
      +
       GIT
       ---
     @@ builtin/bugreport.c
       #include "hook-list.h"
      +#include "diagnose.h"
       
     -+enum diagnose_mode {
     -+	DIAGNOSE_NONE,
     -+	DIAGNOSE_BASIC,
     -+	DIAGNOSE_ALL
     -+};
       
       static void get_system_info(struct strbuf *sys_info)
     - {
     -@@ builtin/bugreport.c: static void get_header(struct strbuf *buf, const char *title)
     - 	strbuf_addf(buf, "\n\n[%s]\n", title);
     +@@ builtin/bugreport.c: static void get_populated_hooks(struct strbuf *hook_info, int nongit)
       }
       
     -+static int option_parse_diagnose(const struct option *opt,
     -+				 const char *arg, int unset)
     -+{
     -+	enum diagnose_mode *diagnose = opt->value;
     -+
     -+	BUG_ON_OPT_NEG(unset);
     -+
     -+	if (!arg || !strcmp(arg, "basic"))
     -+		*diagnose = DIAGNOSE_BASIC;
     -+	else if (!strcmp(arg, "all"))
     -+		*diagnose = DIAGNOSE_ALL;
     -+	else
     -+		die(_("diagnose mode must be either 'basic' or 'all'"));
     -+
     -+	return 0;
     -+}
     -+
     - int cmd_bugreport(int argc, const char **argv, const char *prefix)
     - {
     - 	struct strbuf buffer = STRBUF_INIT;
     + static const char * const bugreport_usage[] = {
     +-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
     ++	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
     + 	NULL
     + };
     + 
      @@ builtin/bugreport.c: int cmd_bugreport(int argc, const char **argv, const char *prefix)
       	int report = -1;
       	time_t now = time(NULL);
     @@ builtin/bugreport.c: int cmd_bugreport(int argc, const char **argv, const char *
      +	size_t output_path_len;
       
       	const struct option bugreport_options[] = {
     -+		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("(basic|all)"),
     -+			       N_("create an additional zip archive of detailed diagnostics"),
     -+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, option_parse_diagnose),
     ++		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("mode"),
     ++			       N_("create an additional zip archive of detailed diagnostics (default 'stats')"),
     ++			       PARSE_OPT_OPTARG, option_parse_diagnose),
       		OPT_STRING('o', "output-directory", &option_output, N_("path"),
      -			   N_("specify a destination for the bugreport file")),
      +			   N_("specify a destination for the bugreport file(s)")),
     @@ builtin/bugreport.c: int cmd_bugreport(int argc, const char **argv, const char *
      +		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
      +		strbuf_addstr(&zip_path, ".zip");
      +
     -+		if (create_diagnostics_archive(&zip_path, diagnose == DIAGNOSE_ALL))
     ++		if (create_diagnostics_archive(&zip_path, diagnose))
      +			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
      +
      +		strbuf_release(&zip_path);
     @@ t/t0091-bugreport.sh: test_expect_success 'indicates populated hooks' '
      +	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
      +'
      +
     -+test_expect_success UNZIP '--diagnose=basic excludes .git dir contents' '
     ++test_expect_success UNZIP '--diagnose=stats excludes .git dir contents' '
      +	test_when_finished rm -rf report &&
      +
     -+	git bugreport --diagnose=basic -o report -s test >out &&
     ++	git bugreport --diagnose=stats -o report -s test >out &&
     ++
     ++	# Includes pack quantity/size info
     ++	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
     ++	grep ".git/objects" out &&
      +
     -+	# Should not include .git directory contents
     ++	# Does not include .git directory contents
      +	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
      +'
      +
     @@ t/t0091-bugreport.sh: test_expect_success 'indicates populated hooks' '
      +
      +	git bugreport --diagnose=all -o report -s test >out &&
      +
     -+	# Should include .git directory contents
     ++	# Includes .git directory contents
      +	"$GIT_UNZIP" -l "$zip_path" | grep ".git/" &&
      +
      +	"$GIT_UNZIP" -p "$zip_path" .git/HEAD >out &&
  9:  6834bdcaea8 ! 10:  d22674752f0 scalar-diagnose: use 'git diagnose --all'
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    scalar-diagnose: use 'git diagnose --all'
     +    scalar-diagnose: use 'git diagnose --mode=all'
      
          Replace implementation of 'scalar diagnose' with an internal invocation of
     -    'git diagnose --all'. This simplifies the implementation of 'cmd_diagnose'
     -    by making it a direct alias of 'git diagnose' and removes some code in
     -    'scalar.c' that is duplicated in 'builtin/diagnose.c'. The simplicity of the
     -    alias also sets up a clean deprecation path for 'scalar diagnose' (in favor
     -    of 'git diagnose'), if that is desired in the future.
     +    'git diagnose --mode=all'. This simplifies the implementation of
     +    'cmd_diagnose' by making it a direct alias of 'git diagnose' and removes
     +    some code in 'scalar.c' that is duplicated in 'builtin/diagnose.c'. The
     +    simplicity of the alias also sets up a clean deprecation path for 'scalar
     +    diagnose' (in favor of 'git diagnose'), if that is desired in the future.
      
          This introduces one minor change to the output of 'scalar diagnose', which
          is that the prefix of the created zip archive is changed from 'scalar_' to
          'git-diagnostics-'.
      
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## contrib/scalar/scalar.c ##
     @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
      +	setup_enlistment_directory(argc, argv, usage, options, &diagnostics_root);
      +	strbuf_addstr(&diagnostics_root, "/.scalarDiagnostics");
       
     --	res = create_diagnostics_archive(&zip_path, 1);
     -+	if (run_git("diagnose", "--all", "-s", "%Y%m%d_%H%M%S",
     -+		    "-o", diagnostics_root.buf, NULL) < 0)
     -+		res = -1;
     +-	res = create_diagnostics_archive(&zip_path, DIAGNOSE_ALL);
     ++	res = run_git("diagnose", "--mode=all", "-s", "%Y%m%d_%H%M%S",
     ++		      "-o", diagnostics_root.buf, NULL);
       
      -diagnose_cleanup:
      -	strbuf_release(&zip_path);
 10:  14925c3feed = 11:  b64475f5b17 scalar: update technical doc roadmap

-- 
gitgitgadget
