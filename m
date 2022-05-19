Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B96C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243782AbiESSSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243704AbiESSSI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:18:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D88BD18
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r6-20020a1c2b06000000b00396fee5ebc9so3142031wmr.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=czhivqJSR3F0vYsK9qDiZwOyW2CChtF5zxgZ4X6hmLc=;
        b=p6pJET5et/+6Sbrxj5EZgIh180wITqjnzSM/9FkABSjvrNtrsY7H3n5k1h+djP4Fzq
         vYNsIb9SDXJDaHWH2UcjsK7dXH2pS/NKbMC5Vqwtd8//ih7D5Jpne8ww/C4X7dCkcO3h
         mcAuPYDno2PRGXfX6qSb/P1wf3y6Gh4ek4ZCFUZJIcOisg1Ua8ASSds0tkf15LKsvXSn
         XNqh7HYs6vKfuUXSTNiqjkOejCswpLAtWL5Hwx6O2tGS/SrJiA4A1AyDbFbiOTB0ze30
         Fgy1PmX5z366mYRuCAZz6RyvuD5CF9JaNd59uyEQp1WDQ0AsG6+rgKWFkgL4cx3nJ2zO
         B3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=czhivqJSR3F0vYsK9qDiZwOyW2CChtF5zxgZ4X6hmLc=;
        b=JjN49MMSkq+xP9aTNrQbmx4coqWVCcV3ldAw71Pk4LCqrflBdQkNb8IMHU/DMQuCol
         e4fBvrmCSR1n389o/lLOtk54TQ45pVWR+9vlXE7tDrWb1qSSR+zpiMAV715yeRiRHkpt
         VHeGdxM+ClSlnnRUYVJgcAwmI9yEcJptaDWMqic+SW0F3jHXZxXGayLvzSVBBhH+pr5e
         taWpfFu5OPQVKqaaKLC0/39PJAW/bljOod/AmaMejttP/wUs5CTKC8vKTiwF28s6z4Sx
         904bHfCzBmgO4X11vWEQmBbgAdDrRiYwlURDNUNAI3ehllSLfr1FSc0JGpHbNW6szs1K
         Vkxg==
X-Gm-Message-State: AOAM532a6/D3JAFXO4dQVYtbPAvQpTPftqz3nI4/R+DzppEX7XGBAUzU
        F2rqemJ1GTf07ytNVJfjE7p58Qlp9A8=
X-Google-Smtp-Source: ABdhPJxIAFyTTQKLwyI6Q5kxsqdUY3r6fZRaKioKF3khyQib4s+F6nkiAknOpksaNnw3ZsSjPAyXQA==
X-Received: by 2002:a05:600c:3512:b0:394:7c3b:53d1 with SMTP id h18-20020a05600c351200b003947c3b53d1mr5440597wmq.197.1652984285002;
        Thu, 19 May 2022 11:18:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020adfb1d1000000b0020c5253d926sm178101wra.114.2022.05.19.11.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:18:04 -0700 (PDT)
Message-Id: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
References: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 18:17:56 +0000
Subject: [PATCH v5 0/7] scalar: implement the subcommand "diagnose"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over the course of the years, we developed a sub-command that gathers
diagnostic data into a .zip file that can then be attached to bug reports.
This sub-command turned out to be very useful in helping Scalar developers
identify and fix issues.

Changes since v4:

 * Squashed in Junio's suggested fixups
 * Renamed the option from --add-file-with-content=<name>:<content> to
   --add-virtual-file=<name>:<content>
 * Fixed one instance where I had used error() instead of error_errno().

Changes since v3:

 * We're now using unquote_c_style() instead of rolling our own unquoter.
 * Fixed the added regression test.
 * As pointed out by Scalar's Functional Tests, the
   add_directory_to_archiver() function should not fail when scalar diagnose
   encounters FSMonitor's Unix socket, but only warn instead.
 * Related: add_directory_to_archiver() needs to propagate errors from
   processing subdirectories so that the top-level call returns an error,
   too.

Changes since v2:

 * Clarified in the commit message what the biggest benefit of
   --add-file-with-content is.
 * The <path> part of the -add-file-with-content argument can now contain
   colons. To do this, the path needs to start and end in double-quote
   characters (which are stripped), and the backslash serves as escape
   character in that case (to allow the path to contain both colons and
   double-quotes).
 * Fixed incorrect grammar.
 * Instead of strcmp(<what-we-don't-want>), we now say
   !strcmp(<what-we-want>).
 * The help text for --add-file-with-content was improved a tiny bit.
 * Adjusted the commit message that still talked about spawning plenty of
   processes and about a throw-away repository for the sake of generating a
   .zip file.
 * Simplified the code that shows the diagnostics and adds them to the .zip
   file.
 * The final message that reports that the archive is complete is now
   printed to stderr instead of stdout.

Changes since v1:

 * Instead of creating a throw-away repository, staging the contents of the
   .zip file and then using git write-tree and git archive to write the .zip
   file, the patch series now introduces a new option to git archive and
   uses write_archive() directly (avoiding any separate process).
 * Since the command avoids separate processes, it is now blazing fast on
   Windows, and I dropped the spinner() function because it's no longer
   needed.
 * While reworking the test case, I noticed that scalar [...] <enlistment>
   failed to verify that the specified directory exists, and would happily
   "traverse to its parent directory" on its quest to find a Scalar
   enlistment. That is of course incorrect, and has been fixed as a "while
   at it" sort of preparatory commit.
 * I had forgotten to sign off on all the commits, which has been fixed.
 * Instead of some "home-grown" readdir()-based function, the code now uses
   for_each_file_in_pack_dir() to look through the pack directories.
 * If any alternates are configured, their pack directories are now included
   in the output.
 * The commit message that might be interpreted to promise information about
   large loose files has been corrected to no longer promise that.
 * The test cases have been adjusted to test a little bit more (e.g.
   verifying that specific paths are mentioned in the output, instead of
   merely verifying that the output is non-empty).

Johannes Schindelin (5):
  archive: optionally add "virtual" files
  archive --add-file-with-contents: allow paths containing colons
  scalar: validate the optional enlistment argument
  Implement `scalar diagnose`
  scalar diagnose: include disk space information

Matthew John Cheetham (2):
  scalar: teach `diagnose` to gather packfile info
  scalar: teach `diagnose` to gather loose objects information

 Documentation/git-archive.txt    |  17 ++
 archive.c                        |  63 ++++++-
 contrib/scalar/scalar.c          | 292 ++++++++++++++++++++++++++++++-
 contrib/scalar/scalar.txt        |  12 ++
 contrib/scalar/t/t9099-scalar.sh |  27 +++
 t/t5003-archive-zip.sh           |  20 +++
 6 files changed, 421 insertions(+), 10 deletions(-)


base-commit: ddc35d833dd6f9e8946b09cecd3311b8aa18d295
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1128%2Fdscho%2Fscalar-diagnose-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1128/dscho/scalar-diagnose-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1128

Range-diff vs v4:

 1:  45662cf582a ! 1:  42e73fb0aac archive: optionally add "virtual" files
     @@ Documentation/git-archive.txt: OPTIONS
       	by concatenating the value for `--prefix` (if any) and the
       	basename of <file>.
       
     -+--add-file-with-content=<path>:<content>::
     ++--add-virtual-file=<path>:<content>::
      +	Add the specified contents to the archive.  Can be repeated to add
      +	multiple files.  The path of the file in the archive is built
      +	by concatenating the value for `--prefix` (if any) and the
     @@ archive.c: static int add_file_cb(const struct option *opt, const char *arg, int
      +		if (!S_ISREG(info->stat.st_mode))
      +			die(_("Not a regular file: %s"), path);
      +		info->content = NULL; /* read the file later */
     -+	} else {
     ++	} else if (!strcmp(opt->long_name, "add-virtual-file")) {
      +		const char *colon = strchr(arg, ':');
      +		char *p;
      +
     @@ archive.c: static int add_file_cb(const struct option *opt, const char *arg, int
      +		info->stat.st_mode = S_IFREG | 0644;
      +		info->content = xstrdup(colon + 1);
      +		info->stat.st_size = strlen(info->content);
     ++	} else {
     ++		BUG("add_file_cb() called for %s", opt->long_name);
      +	}
      +	item = string_list_append_nodup(&args->extra_files, path);
      +	item->util = info;
     @@ archive.c: static int parse_archive_args(int argc, const char **argv,
       		{ OPTION_CALLBACK, 0, "add-file", args, N_("file"),
       		  N_("add untracked file to archive"), 0, add_file_cb,
       		  (intptr_t)&base },
     -+		{ OPTION_CALLBACK, 0, "add-file-with-content", args,
     ++		{ OPTION_CALLBACK, 0, "add-virtual-file", args,
      +		  N_("path:content"), N_("add untracked file to archive"), 0,
      +		  add_file_cb, (intptr_t)&base },
       		OPT_STRING('o', "output", &output, N_("file"),
     @@ t/t5003-archive-zip.sh: test_expect_success 'git archive --format=zip --add-file
       check_zip with_untracked
       check_added with_untracked untracked untracked
       
     -+test_expect_success UNZIP 'git archive --format=zip --add-file-with-content' '
     ++test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
      +	git archive --format=zip >with_file_with_content.zip \
     -+		--add-file-with-content=hello:world $EMPTY_TREE &&
     ++		--add-virtual-file=hello:world $EMPTY_TREE &&
      +	test_when_finished "rm -rf tmp-unpack" &&
      +	mkdir tmp-unpack && (
      +		cd tmp-unpack &&
 2:  fdba4ed6f4d ! 2:  b5ebd61066a archive --add-file-with-contents: allow paths containing colons
     @@ archive.c
      @@ archive.c: static int add_file_cb(const struct option *opt, const char *arg, int unset)
       			die(_("Not a regular file: %s"), path);
       		info->content = NULL; /* read the file later */
     - 	} else {
     + 	} else if (!strcmp(opt->long_name, "add-virtual-file")) {
      -		const char *colon = strchr(arg, ':');
      -		char *p;
      +		struct strbuf buf = STRBUF_INIT;
     @@ archive.c: static int add_file_cb(const struct option *opt, const char *arg, int
      -		info->content = xstrdup(colon + 1);
      +		info->content = xstrdup(p + 1);
       		info->stat.st_size = strlen(info->content);
     - 	}
     - 	item = string_list_append_nodup(&args->extra_files, path);
     + 	} else {
     + 		BUG("add_file_cb() called for %s", opt->long_name);
      
       ## t/t5003-archive-zip.sh ##
      @@ t/t5003-archive-zip.sh: check_zip with_untracked
       check_added with_untracked untracked untracked
       
     - test_expect_success UNZIP 'git archive --format=zip --add-file-with-content' '
     + test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
      +	if test_have_prereq FUNNYNAMES
      +	then
      +		QUOTED=quoted:colon
     @@ t/t5003-archive-zip.sh: check_zip with_untracked
      +		QUOTED=quoted
      +	fi &&
       	git archive --format=zip >with_file_with_content.zip \
     -+		--add-file-with-content=\"$QUOTED\": \
     - 		--add-file-with-content=hello:world $EMPTY_TREE &&
     ++		--add-virtual-file=\"$QUOTED\": \
     + 		--add-virtual-file=hello:world $EMPTY_TREE &&
       	test_when_finished "rm -rf tmp-unpack" &&
       	mkdir tmp-unpack && (
       		cd tmp-unpack &&
 3:  da9f52a8240 = 3:  f1ba69c02d7 scalar: validate the optional enlistment argument
 4:  87bdc22322b ! 4:  3fb90194744 Implement `scalar diagnose`
     @@ contrib/scalar/scalar.c: static int unregister_dir(void)
      +	int res = 0;
      +
      +	if (!dir)
     -+		return error(_("could not open directory '%s'"), path);
     ++		return error_errno(_("could not open directory '%s'"), path);
      +
      +	if (!at_root)
      +		strbuf_addf(&buf, "%s/", path);
     @@ contrib/scalar/scalar.c: cleanup:
      +	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
      +	write_or_die(stdout_fd, buf.buf, buf.len);
      +	strvec_pushf(&archiver_args,
     -+		     "--add-file-with-content=diagnostics.log:%.*s",
     ++		     "--add-virtual-file=diagnostics.log:%.*s",
      +		     (int)buf.len, buf.buf);
      +
      +	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
 5:  3f63b197d42 ! 5:  2e645b08a9e scalar diagnose: include disk space information
     @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
      +	get_disk_info(&buf);
       	write_or_die(stdout_fd, buf.buf, buf.len);
       	strvec_pushf(&archiver_args,
     - 		     "--add-file-with-content=diagnostics.log:%.*s",
     + 		     "--add-virtual-file=diagnostics.log:%.*s",
      
       ## contrib/scalar/t/t9099-scalar.sh ##
      @@ contrib/scalar/t/t9099-scalar.sh: SQ="'"
 6:  fc1319338fc ! 6:  0fa20d73750 scalar: teach `diagnose` to gather packfile info
     @@ contrib/scalar/scalar.c: cleanup:
       {
       	struct option options[] = {
      @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
     - 		     "--add-file-with-content=diagnostics.log:%.*s",
     + 		     "--add-virtual-file=diagnostics.log:%.*s",
       		     (int)buf.len, buf.buf);
       
      +	strbuf_reset(&buf);
     -+	strbuf_addstr(&buf, "--add-file-with-content=packs-local.txt:");
     ++	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
      +	dir_file_stats(the_repository->objects->odb, &buf);
      +	foreach_alt_odb(dir_file_stats, &buf);
      +	strvec_push(&archiver_args, buf.buf);
 7:  e8f5b42f7b7 ! 7:  62e173b47cf scalar: teach `diagnose` to gather loose objects information
     @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
       	strvec_push(&archiver_args, buf.buf);
       
      +	strbuf_reset(&buf);
     -+	strbuf_addstr(&buf, "--add-file-with-content=objects-local.txt:");
     ++	strbuf_addstr(&buf, "--add-virtual-file=objects-local.txt:");
      +	loose_objs_stats(&buf, ".git/objects");
      +	strvec_push(&archiver_args, buf.buf);
      +

-- 
gitgitgadget
