Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE84C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 19:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiEJT1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 15:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiEJT1L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 15:27:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185BF24091
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d5so8072wrb.6
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tXdRXQoYEKhnNYnuNod4ajNPIpVQa9TzrFCZUZ709Fc=;
        b=CPfq7Z9ugPBzv78AYMHZjHVHb80vLv/DGVPnCoPQnWM6jafh1xzMVa03GE1mius9P1
         g7rNwGB05K+kGqgvBaZBqvoAZBQ6puMNnN1a9tPhVb7tL+DOVY7a4m02+SWVMnPoJsQi
         FJEoHXvcDWjt9bygnnxexUNcpFFeImVFaCKW1F9J2T9Nl3KNH8UOWNGUH1KnNVJ1SwK+
         afupT7KVACf2ahoqfCAMU0BIK9nR5dutfKKk6qdAMmE6YhQU2Ofp70JylmVOc8Xp2Hsw
         2zsowZKHLKt0zo2eNWGA+e8C9+J7dpfVBrJdj8vEr95LNKqj8C03ZMGZnetXZDt0JfY/
         y4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tXdRXQoYEKhnNYnuNod4ajNPIpVQa9TzrFCZUZ709Fc=;
        b=kzOZRtXAAObku2c8i3KFfP0dHeA1Gi9EHZFNVCRb8QnTG3V+xlV1edYAV7JMXbaFmm
         JNfxG6E0K3xaYuodJ+fWYpO2/pmr4eyj4a0kNYorEO973GqJseMQQXxx3RxplX4Z+t12
         eSsm2ubp5dhOO6lnfgBz0aQdcKuvgxOrIpoyEv8l0YLIViqYTA0gLeTS80Fp52uEdClZ
         lQjbUqvsbIAkecBZCTjdVxfB8RXLwKUrotCmMEAw7kEJYKg5Wu+dB5C2yusCa/LsyG7G
         byweuUphiDx9qGErzW7hJq2xGg2WZecjPq64YcWx5Nvy0LqwkElNaGnTqaQI4pIK1yhZ
         DPgw==
X-Gm-Message-State: AOAM53113ah+E/EpsxvEzrnMQHTQARhzS7/7v09BtbklVSQit70extml
        KBmZRYDH5BINUcb1PZdxysgYEDh2QIE=
X-Google-Smtp-Source: ABdhPJw1km12sTwa01XLqYrq/mvVSjgpc2OjYskUqD7wrvCDmJ5803tGSqy8NvS4vwoZasSmvGAJcQ==
X-Received: by 2002:a5d:5221:0:b0:20c:9a6f:50be with SMTP id i1-20020a5d5221000000b0020c9a6f50bemr19805303wra.494.1652210826132;
        Tue, 10 May 2022 12:27:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l68-20020a1c2547000000b003947b59dfdesm3814978wml.36.2022.05.10.12.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:27:04 -0700 (PDT)
Message-Id: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 19:26:57 +0000
Subject: [PATCH v4 0/7] scalar: implement the subcommand "diagnose"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over the course of the years, we developed a sub-command that gathers
diagnostic data into a .zip file that can then be attached to bug reports.
This sub-command turned out to be very useful in helping Scalar developers
identify and fix issues.

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
 archive.c                        |  61 ++++++-
 contrib/scalar/scalar.c          | 292 ++++++++++++++++++++++++++++++-
 contrib/scalar/scalar.txt        |  12 ++
 contrib/scalar/t/t9099-scalar.sh |  27 +++
 t/t5003-archive-zip.sh           |  20 +++
 6 files changed, 419 insertions(+), 10 deletions(-)


base-commit: ddc35d833dd6f9e8946b09cecd3311b8aa18d295
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1128%2Fdscho%2Fscalar-diagnose-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1128/dscho/scalar-diagnose-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1128

Range-diff vs v3:

 1:  45662cf582a = 1:  45662cf582a archive: optionally add "virtual" files
 2:  ce4b1b680c9 ! 2:  fdba4ed6f4d archive --add-file-with-contents: allow paths containing colons
     @@ Documentation/git-archive.txt: OPTIONS
      -command-line limits. For non-trivial cases, write an untracked file
      -and use `--add-file` instead.
      +The `<path>` argument can start and end with a literal double-quote
     -+character. In this case, the backslash is interpreted as escape
     -+character. The path must be quoted if it contains a colon, to avoid
     -+the colon from being misinterpreted as the separator between the
     -+path and the contents.
     ++character; The contained file name is interpreted as a C-style string,
     ++i.e. the backslash is interpreted as escape character. The path must
     ++be quoted if it contains a colon, to avoid the colon from being
     ++misinterpreted as the separator between the path and the contents, or
     ++if the path begins or ends with a double-quote character.
      ++
      +The file mode is limited to a regular file, and the option may be
      +subject to platform-dependent command-line limits. For non-trivial
     @@ Documentation/git-archive.txt: OPTIONS
       	Look for attributes in .gitattributes files in the working tree
      
       ## archive.c ##
     +@@
     + #include "parse-options.h"
     + #include "unpack-trees.h"
     + #include "dir.h"
     ++#include "quote.h"
     + 
     + static char const * const archive_usage[] = {
     + 	N_("git archive [<options>] <tree-ish> [<path>...]"),
      @@ archive.c: static int add_file_cb(const struct option *opt, const char *arg, int unset)
       			die(_("Not a regular file: %s"), path);
       		info->content = NULL; /* read the file later */
       	} else {
      -		const char *colon = strchr(arg, ':');
     - 		char *p;
     +-		char *p;
     ++		struct strbuf buf = STRBUF_INIT;
     ++		const char *p = arg;
     ++
     ++		if (*p != '"')
     ++			p = strchr(p, ':');
     ++		else if (unquote_c_style(&buf, p, &p) < 0)
     ++			die(_("unclosed quote: '%s'"), arg);
       
      -		if (!colon)
     --			die(_("missing colon: '%s'"), arg);
     -+		if (*arg != '"') {
     -+			const char *colon = strchr(arg, ':');
     -+
     -+			if (!colon)
     -+				die(_("missing colon: '%s'"), arg);
     -+			p = xstrndup(arg, colon - arg);
     -+			arg = colon + 1;
     -+		} else {
     -+			struct strbuf buf = STRBUF_INIT;
     -+			const char *orig = arg;
     -+
     -+			for (;;) {
     -+				if (!*(++arg))
     -+					die(_("unclosed quote: '%s'"), orig);
     -+				if (*arg == '"')
     -+					break;
     -+				if (*arg == '\\' && *(++arg) == '\0')
     -+					die(_("trailing backslash: '%s"), orig);
     -+				else
     -+					strbuf_addch(&buf, *arg);
     -+			}
     -+
     -+			if (*(++arg) != ':')
     -+				die(_("missing colon: '%s'"), orig);
     -+
     -+			p = strbuf_detach(&buf, NULL);
     -+			arg++;
     -+		}
     ++		if (!p || *p != ':')
     + 			die(_("missing colon: '%s'"), arg);
       
      -		p = xstrndup(arg, colon - arg);
     - 		if (!args->prefix)
     - 			path = p;
     - 		else {
     -@@ archive.c: static int add_file_cb(const struct option *opt, const char *arg, int unset)
     +-		if (!args->prefix)
     +-			path = p;
     +-		else {
     +-			path = prefix_filename(args->prefix, p);
     +-			free(p);
     ++		if (p == arg)
     ++			die(_("empty file name: '%s'"), arg);
     ++
     ++		path = buf.len ?
     ++			strbuf_detach(&buf, NULL) : xstrndup(arg, p - arg);
     ++
     ++		if (args->prefix) {
     ++			char *save = path;
     ++			path = prefix_filename(args->prefix, path);
     ++			free(save);
       		}
       		memset(&info->stat, 0, sizeof(info->stat));
       		info->stat.st_mode = S_IFREG | 0644;
      -		info->content = xstrdup(colon + 1);
     -+		info->content = xstrdup(arg);
     ++		info->content = xstrdup(p + 1);
       		info->stat.st_size = strlen(info->content);
       	}
       	item = string_list_append_nodup(&args->extra_files, path);
 3:  5a3eeb55409 = 3:  da9f52a8240 scalar: validate the optional enlistment argument
 4:  dfe821d10fe ! 4:  87bdc22322b Implement `scalar diagnose`
     @@ contrib/scalar/scalar.c: static int unregister_dir(void)
      +		if (e->d_type == DT_REG)
      +			strvec_pushf(archiver_args, "--add-file=%s", buf.buf);
      +		else if (e->d_type != DT_DIR)
     ++			warning(_("skipping '%s', which is neither file nor "
     ++				  "directory"), buf.buf);
     ++		else if (recurse &&
     ++			 add_directory_to_archiver(archiver_args,
     ++						   buf.buf, recurse) < 0)
      +			res = -1;
     -+		else if (recurse)
     -+		     add_directory_to_archiver(archiver_args, buf.buf, recurse);
      +	}
      +
      +	closedir(dir);
     @@ contrib/scalar/t/t9099-scalar.sh: test_expect_success '`scalar [...] <dir>` erro
      +SQ="'"
      +test_expect_success UNZIP 'scalar diagnose' '
      +	scalar clone "file://$(pwd)" cloned --single-branch &&
     -+	scalar diagnose cloned >out &&
     -+	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
     ++	scalar diagnose cloned >out 2>err &&
     ++	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
      +	zip_path=$(cat zip_path) &&
      +	test -n "$zip_path" &&
      +	unzip -v "$zip_path" &&
 5:  bb162abd383 ! 5:  3f63b197d42 scalar diagnose: include disk space information
     @@ contrib/scalar/t/t9099-scalar.sh
      @@ contrib/scalar/t/t9099-scalar.sh: SQ="'"
       test_expect_success UNZIP 'scalar diagnose' '
       	scalar clone "file://$(pwd)" cloned --single-branch &&
     - 	scalar diagnose cloned >out &&
     + 	scalar diagnose cloned >out 2>err &&
      +	grep "Available space" out &&
     - 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
     + 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
       	zip_path=$(cat zip_path) &&
       	test -n "$zip_path" &&
 6:  32aaad7cce1 ! 6:  fc1319338fc scalar: teach `diagnose` to gather packfile info
     @@ contrib/scalar/t/t9099-scalar.sh: test_expect_success '`scalar [...] <dir>` erro
       	scalar clone "file://$(pwd)" cloned --single-branch &&
      +	git repack &&
      +	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
     - 	scalar diagnose cloned >out &&
     + 	scalar diagnose cloned >out 2>err &&
       	grep "Available space" out &&
     - 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
     + 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
      @@ contrib/scalar/t/t9099-scalar.sh: test_expect_success UNZIP 'scalar diagnose' '
       	folder=${zip_path%.zip} &&
       	test_path_is_missing "$folder" &&
 7:  322932f0bb8 ! 7:  e8f5b42f7b7 scalar: teach `diagnose` to gather loose objects information
     @@ contrib/scalar/t/t9099-scalar.sh: test_expect_success UNZIP 'scalar diagnose' '
       	git repack &&
       	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
      +	test_commit -C cloned/src loose &&
     - 	scalar diagnose cloned >out &&
     + 	scalar diagnose cloned >out 2>err &&
       	grep "Available space" out &&
     - 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
     + 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
      @@ contrib/scalar/t/t9099-scalar.sh: test_expect_success UNZIP 'scalar diagnose' '
       	unzip -p "$zip_path" diagnostics.log >out &&
       	test_file_not_empty out &&

-- 
gitgitgadget
