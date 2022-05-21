Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01089C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 15:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbiEUPIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243649AbiEUPIV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 11:08:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348D92D22
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bg25so5917368wmb.4
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZY4Wzr7HCIkNPy6Wrc04/3TCo0BqMaNLvmNhYQjOzUY=;
        b=kXMKbRgAUeYbqndJa+Cs/Wj9L8sUr0O4aHy9H5R0u5QlHrFxE6Y8g8B6qcEmTu7xa5
         mJ1WoA4WKncpm+jMKeVDZnVzPDhVEGvJ+lerpkv/lzTqaIbg3gACD0DWy4gdj1wcwnH/
         eh7pS8MS7/wtaBohUcQCxVH7KkTsvVXKkap/k9ow+AnFqYP6wNqICv/C2tJLpSWY7kFK
         b+s9qLcnQ2+hoZA/R58CLgjar9Uyu8k1icFpZJg2BFPrNX3jDAs0R5BHYmbJ3Ho3ogdW
         okrta7CkpGIOlzNKk6/HiWy8zfIgqvWiyAZMDrid3jXj42mAg68rR7zxe8DTpqi2o9iW
         XlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZY4Wzr7HCIkNPy6Wrc04/3TCo0BqMaNLvmNhYQjOzUY=;
        b=kZiUsQuLwOfLmmAKzvtiumODSrBfRJgcBKU5nhP1drFnUB4XUcq0cSMe0mMGJEgE+R
         GbpoSWfrlb+mwQ9ZR4iGGBb2ZvLonGiqMIjVhaoGnMLoaOs5w7ZvbB1GQCX5NVyBvXOZ
         2VuHVWsV+EBIS5bhOwrXIWdq8bhw+sqIJcw4+JtKojrZS8LLdCX7UuZ0xvdJhnPUpOQx
         EqKoBRN0N0SkqCVzSL3H93U0KxL1lJa6RTrtn5o0NYOT3HxXYJQt6lev8s+kWbel10E3
         xnunSKj7KpM+AWyCoZ/VFQqUOX2SV1jKX9ezUksr0W+75HOYq/Ze8vIAWgQQEHuAN42N
         CnGA==
X-Gm-Message-State: AOAM533Olpv7AU28reI7DQ7c/GIpQ62bgsoXduabi1w7Ylmh0YP7xFGT
        djyLoIIUwHYLFGGS8uiNlvPOZpjOPtc=
X-Google-Smtp-Source: ABdhPJxytHxtomBL0vP9e1MdDS7FgRGQ1m+6/dXXHoQXVEwJqCaybmcSUAIl8OyR5UhhNDFvqm/Q/A==
X-Received: by 2002:a7b:c414:0:b0:394:21dd:e24f with SMTP id k20-20020a7bc414000000b0039421dde24fmr12829415wmi.133.1653145697946;
        Sat, 21 May 2022 08:08:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t4-20020a1c7704000000b003942a244ed1sm4527055wmi.22.2022.05.21.08.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 08:08:17 -0700 (PDT)
Message-Id: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 15:08:09 +0000
Subject: [PATCH v6 0/7] scalar: implement the subcommand "diagnose"
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

Changes since v5:

 * Reworded the missed mentions of the old name of the --add-virtual-file
   option (thanks René!).
 * Renamed misleading variable name from $QUOTED to $PATHNAME (thanks
   Junio!).

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
  archive --add-virtual-file: allow paths containing colons
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1128%2Fdscho%2Fscalar-diagnose-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1128/dscho/scalar-diagnose-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1128

Range-diff vs v5:

 1:  42e73fb0aac ! 1:  0005cfae31d archive: optionally add "virtual" files
     @@ Metadata
       ## Commit message ##
          archive: optionally add "virtual" files
      
     -    With the `--add-file-with-content=<path>:<content>` option, `git
     -    archive` now supports use cases where relatively trivial files need to
     -    be added that do not exist on disk.
     +    With the `--add-virtual-file=<path>:<content>` option, `git archive` now
     +    supports use cases where relatively trivial files need to be added that
     +    do not exist on disk.
      
          This will allow us to generate `.zip` files with generated content,
          without having to add said content to the object database and without
 2:  b5ebd61066a ! 2:  7eebcf27b45 archive --add-file-with-contents: allow paths containing colons
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    archive --add-file-with-contents: allow paths containing colons
     +    archive --add-virtual-file: allow paths containing colons
      
          By allowing the path to be enclosed in double-quotes, we can avoid
          the limitation that paths cannot contain colons.
     @@ t/t5003-archive-zip.sh: check_zip with_untracked
       test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
      +	if test_have_prereq FUNNYNAMES
      +	then
     -+		QUOTED=quoted:colon
     ++		PATHNAME=quoted:colon
      +	else
     -+		QUOTED=quoted
     ++		PATHNAME=quoted
      +	fi &&
       	git archive --format=zip >with_file_with_content.zip \
     -+		--add-virtual-file=\"$QUOTED\": \
     ++		--add-virtual-file=\"$PATHNAME\": \
       		--add-virtual-file=hello:world $EMPTY_TREE &&
       	test_when_finished "rm -rf tmp-unpack" &&
       	mkdir tmp-unpack && (
       		cd tmp-unpack &&
       		"$GIT_UNZIP" ../with_file_with_content.zip &&
       		test_path_is_file hello &&
     -+		test_path_is_file $QUOTED &&
     ++		test_path_is_file $PATHNAME &&
       		test world = $(cat hello)
       	)
       '
 3:  f1ba69c02d7 = 3:  ca83ddd5eed scalar: validate the optional enlistment argument
 4:  3fb90194744 = 4:  89c13a45e00 Implement `scalar diagnose`
 5:  2e645b08a9e = 5:  8ffbaad3086 scalar diagnose: include disk space information
 6:  0fa20d73750 = 6:  15cd7f17896 scalar: teach `diagnose` to gather packfile info
 7:  62e173b47cf = 7:  a4a74d5ef58 scalar: teach `diagnose` to gather loose objects information

-- 
gitgitgadget
