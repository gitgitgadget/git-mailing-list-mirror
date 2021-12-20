Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A174C433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 14:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbhLTO4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 09:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbhLTOyo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 09:54:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C2CC08EC11
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:48:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y83-20020a1c7d56000000b003456dfe7c5cso8847375wmc.1
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qSkV5IXssLPUW8oA3/Utiud1oWpufaQ2bwLGTcc5WAg=;
        b=HCNQ9mez0MjVXvJ9oYiMf/OUUjkx11RFdc4ucLG89bocqSuytz2ibEf2+3o8moiEqo
         /K+58UPFa/3fHNy+w0rhr14xanhipcCGadxBLTu00FdOKjvDJ/xDRdmdceTzfr3f8RqJ
         fln9tvaL179AomKpWTq0yjdSicJwdWinWVEeW+SRFnbJUP853IFkfgOMR7Om0R1bA0Ud
         gGvRHzHVs+pC3YniFt9sRByf1Dluqal47+IuG1ExGZzIDpD7dcY509oOtj8lQk0rdc8G
         hDbeUKrROwqc4UB/4edIdEtLZrvz7+hSFuf9GavW7zMU4eU4v/S1C4B7UQesqWkbibbF
         1ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qSkV5IXssLPUW8oA3/Utiud1oWpufaQ2bwLGTcc5WAg=;
        b=OZGovLMqDJh73C/VnlsPLTme1vE1pZ1nm7sKqPC0389fuqIao01PBhhGk8Bl4184mU
         QdlcIUAH0wY6mvk1dnsPu/5SIPZHxowtseHF37b/DVZ+94jVEpoyHUzBvo3B+LDxVzIj
         5uBgONQ/NkPVHdG1tUEpM0gguvbpKdQz9w4PRHEWUns+I7hPubuVaFAyfF8wDgM1ZoTr
         ooY/r09rTGNG93Oky6r9Z1HCgaW8pmBnE6YHp6G9G3ASjdV6zIr4jg76drpdahLXkCpw
         O2eqULDWrQfQ/MgbdfhCkTAysdV3/QtVVBLHApK6ujv3cRcKKeeAuvT97MlS3rIlj28A
         oFEw==
X-Gm-Message-State: AOAM5321pm2YBjI7Cy9/uDTlr1W1hYf2v8MbdAs9M/LFtGN2ApS3/nD7
        wNiuJ1kzkpgAvzngewi7UnQa8xReK90=
X-Google-Smtp-Source: ABdhPJzHqmxUlnvoABA2Ng6gSkOaOvLVi134kwMLeL9IDcSLJpEE9ZjdC/udi+/LGESOf+TZ8WwteA==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr18354603wmi.105.1640011692942;
        Mon, 20 Dec 2021 06:48:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11sm15155207wrz.97.2021.12.20.06.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 06:48:12 -0800 (PST)
Message-Id: <pull.1098.v2.git.1640011691.gitgitgadget@gmail.com>
In-Reply-To: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 14:48:09 +0000
Subject: [PATCH v2 0/2] Two small 'git repack' fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was experimenting with some ideas in 'git repack' and discovered these two
bugs.

The first is a "real" bug in that it repacks much more data than is
necessary when repacking with '--write-midx -b' and there exists a .keep
pack. The fix is simple, which is to change a condition that was added for
the '-b' case before '--write-midx' existed.

The second is a UX bug in that '--quiet' did not disable all progress, at
least when stderr was interactive.


Updates in v2
=============

Thanks for the quick review!

 * Test for --honor-pack-keep is cleaner with a reusable helper.
 * TTY test is added.
 * Docs are updated.

Thanks, -Stolee

Derrick Stolee (2):
  repack: respect kept objects with '--write-midx -b'
  repack: make '--quiet' disable progress

 Documentation/git-repack.txt |  5 +++--
 builtin/repack.c             |  8 +++++---
 t/t7700-repack.sh            | 13 +++++++++++++
 t/test-lib-functions.sh      | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 5 deletions(-)


base-commit: 69a9c10c95e28df457e33b3c7400b16caf2e2962
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1098%2Fderrickstolee%2Frepack-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1098/derrickstolee/repack-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1098

Range-diff vs v1:

 1:  1ed91f6d255 ! 1:  747328a4dd6 repack: respect kept objects with '--write-midx -b'
     @@ Commit message
          some historical set of objects in a stable pack-file while only
          repacking more recent objects.
      
     +    To test, create a new 'test_subcommand_inexact' helper that is more
     +    flexible than 'test_subcommand'. This allows us to look for the
     +    --honor-pack-keep flag without over-indexing on the exact set of
     +    arguments.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/repack.c ##
     @@ t/t7700-repack.sh: test_expect_success '--write-midx with preferred bitmap tips'
       '
       
      +test_expect_success '--write-midx -b packs non-kept objects' '
     -+	git init midx-kept &&
     -+	test_when_finished "rm -fr midx-kept" &&
     -+	(
     -+		cd midx-kept &&
     -+		test_commit_bulk 100 &&
     -+		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
     -+			git repack --write-midx -a -b &&
     -+		cat trace.txt | \
     -+			grep \"event\":\"start\" | \
     -+			grep pack-objects | \
     -+			grep \"--honor-pack-keep\"
     -+	)
     ++	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
     ++		git repack --write-midx -a -b &&
     ++	test_subcommand_inexact git pack-objects --honor-pack-keep <trace.txt
      +'
      +
       test_done
     +
     + ## t/test-lib-functions.sh ##
     +@@ t/test-lib-functions.sh: test_subcommand () {
     + 	fi
     + }
     + 
     ++# Check that the given command was invoked as part of the
     ++# trace2-format trace on stdin, but without an exact set of
     ++# arguments.
     ++#
     ++#	test_subcommand [!] <command> <args>... < <trace>
     ++#
     ++# For example, to look for an invocation of "git pack-objects"
     ++# with the "--honor-pack-keep" argument, use
     ++#
     ++#	GIT_TRACE2_EVENT=event.log git repack ... &&
     ++#	test_subcommand git pack-objects --honor-pack-keep <event.log
     ++#
     ++# If the first parameter passed is !, this instead checks that
     ++# the given command was not called.
     ++#
     ++test_subcommand_inexact () {
     ++	local negate=
     ++	if test "$1" = "!"
     ++	then
     ++		negate=t
     ++		shift
     ++	fi
     ++
     ++	local expr=$(printf '"%s".*' "$@")
     ++	expr="${expr%,}"
     ++
     ++	if test -n "$negate"
     ++	then
     ++		! grep "\"event\":\"child_start\".*\[$expr\]"
     ++	else
     ++		grep "\"event\":\"child_start\".*\[$expr\]"
     ++	fi
     ++}
     ++
     + # Check that the given command was invoked as part of the
     + # trace2-format trace on stdin.
     + #
 2:  3eff83d9ae1 ! 2:  41260bf0829 repack: make '--quiet' disable progress
     @@ Commit message
          is true, and isatty(2) otherwise. This new expectation simplifies a
          later condition that checks both.
      
     -    This is difficult to test because the isatty(2) already prevents the
     -    progess indicators from appearing when we redirect stderr to a file.
     +    Update the documentation to make it clear that '-q' will disable all
     +    progress in addition to ensuring the 'git pack-objects' child process
     +    will receive the flag.
      
     +    Use 'test_terminal' to check that this works to get around the isatty(2)
     +    check.
     +
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + ## Documentation/git-repack.txt ##
     +@@ Documentation/git-repack.txt: to the new separate pack will be written.
     + 	linkgit:git-pack-objects[1].
     + 
     + -q::
     +-	Pass the `-q` option to 'git pack-objects'. See
     +-	linkgit:git-pack-objects[1].
     ++--quiet::
     ++	Show no progress over the standard error stream and pass the `-q`
     ++	option to 'git pack-objects'. See linkgit:git-pack-objects[1].
     + 
     + -n::
     + 	Do not update the server information with
     +
       ## builtin/repack.c ##
      @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
       	struct tempfile *refs_snapshot = NULL;
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
       			opts |= PRUNE_PACKED_VERBOSE;
       		prune_packed_objects(opts);
       
     +
     + ## t/t7700-repack.sh ##
     +@@ t/t7700-repack.sh: test_description='git repack works correctly'
     + . ./test-lib.sh
     + . "${TEST_DIRECTORY}/lib-bitmap.sh"
     + . "${TEST_DIRECTORY}/lib-midx.sh"
     ++. "${TEST_DIRECTORY}/lib-terminal.sh"
     + 
     + commit_and_pack () {
     + 	test_commit "$@" 1>&2 &&
     +@@ t/t7700-repack.sh: test_expect_success '--write-midx -b packs non-kept objects' '
     + 	test_subcommand_inexact git pack-objects --honor-pack-keep <trace.txt
     + '
     + 
     ++test_expect_success TTY '--quiet disables progress' '
     ++	test_terminal env GIT_PROGRESS_DELAY=0 \
     ++		git -C midx repack -ad --quiet --write-midx 2>stderr &&
     ++	test_must_be_empty stderr
     ++'
     ++
     + test_done

-- 
gitgitgadget
