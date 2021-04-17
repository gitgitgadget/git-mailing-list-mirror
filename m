Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6206C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE7C611C2
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhDQMyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhDQMyF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:54:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB5AC061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y20-20020a1c4b140000b029011f294095d3so17913141wma.3
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJW88+EY2PbyBNiZws+dFpeW9pP5vyQ6Y82L/9a62P0=;
        b=C/NO/YGvUWonQDPZaI4ccJiBLV9sil0icMbZrQNSioFtAnPyCVyKyKs7DWJbNjBEPZ
         E8fjprzA1kFC6oKnG9xGoK0xtCWktX6UOoWqGsFRPMr79NluQtF/MhbVBYEIKW75W6zd
         /YcndfEqz9+4vnFTT643kwIh6IzgOnaAxF3eogKkwp/pB4bDGU9U/2T7uUlUhK1U7uCQ
         DOQ40K6iDbzDn0nwgr2pXsdvQzBrmdpU5yxUOYHzAPAkPCnfPV0GroXXof+1WwcfdyAl
         I9upektj7bGKa9FkXc49vkWcUDPygujremAmaO9TDvI+EuCgoGAtjtEQm4+pOpARDpSL
         o+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJW88+EY2PbyBNiZws+dFpeW9pP5vyQ6Y82L/9a62P0=;
        b=cHXWKLysCQHKo2fuvkAewS+Bfd8JFWJ2pZnm4lb5K7w0Nq/lbRpFBCjRqspG6aGmvH
         CiUkt2GZu3YKH3ssFTxnFjqn9/Qj9zamc3256uYQHGHsBcFfLZsjFrT6Ygs8HNzq2G5s
         xF9MbBLCm3Gy6db2ZxjXAmggnhJXDfIK4p6oqpx3+GWpjTp6kqkh/0Pbn1huMEoaDDpC
         ZPPDfpyomlebdsWZhecwQYY3G/FEWxpdF9W6HbkaotO2hCpTJew5T47CuVGw3tvWScMx
         bvWqkzz0cA0zbyeGnxh9UHxE8A/K4MgmKBn8/aR9w9U5uLi1X5U3lSsv7U5KYceYJB5U
         Dgpg==
X-Gm-Message-State: AOAM530HLuxYcrO1mnSJ/dGOru+UjKfB3EDL0sJTq8zZ4D4kHwu8t6TD
        1z7LR74sHY6YRw2nAN+aft8rkM4ND5CsEw==
X-Google-Smtp-Source: ABdhPJzVNKes+RO46BGwD2zfCXR15509rEoJLUoTRsmlE099Q+MR17i/TQG2oQbrP6Hi0JliaS7C4w==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr12657538wmc.59.1618664016111;
        Sat, 17 Apr 2021 05:53:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm11594529wme.14.2021.04.17.05.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:53:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/12] test-lib.sh: new test_commit args, simplification & fixes
Date:   Sat, 17 Apr 2021 14:52:33 +0200
Message-Id: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a "various small fixes" series to test-lib.sh,
test-lib-functions.sh.

I've addressed the feedback on v1, the "test_create_repo" function is
now purely a dumb "git init" wrapper without any arguments, thanks to
SZEDER's observation.

The trickery with "test" arguments and "$@" later in the series seemed
more controversial, so I've peeled those patches off. I'll submit them
as another series, I've got various other serieses waiting on the
"test_commit" functions here so I'd like to get this in sooner than
later, rather than having it hang on the discussion around that.

Ævar Arnfjörð Bjarmason (12):
  check-non-portable-shell: check for "test <cond> -a/-o <cond>"
  test-lib: bring $remove_trash out of retirement
  test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
  test-lib-functions: reword "test_commit --append" docs
  test-lib-functions: document test_commit --no-tag
  test-lib functions: add an --annotated option to "test_commit"
  describe tests: convert setup to use test_commit
  test-lib functions: add --printf option to test_commit
  submodule tests: use symbolic-ref --short to discover branch name
  test-lib: reformat argument list in test_create_repo()
  test-lib: do not show advice about init.defaultBranch under --verbose
  test-lib: split up and deprecate test_create_repo()

 t/check-non-portable-shell.pl       |  2 +
 t/lib-submodule-update.sh           |  3 +-
 t/t0000-basic.sh                    |  4 --
 t/t1307-config-blob.sh              |  4 +-
 t/t1403-show-ref.sh                 |  6 +--
 t/t2030-unresolve-info.sh           |  3 +-
 t/t4006-diff-mode.sh                |  6 +--
 t/t4030-diff-textconv.sh            |  8 +---
 t/t5406-remote-rejects.sh           |  1 -
 t/t5407-post-rewrite-hook.sh        |  2 -
 t/t5409-colorize-remote-messages.sh |  1 -
 t/t5520-pull.sh                     | 10 +----
 t/t6120-describe.sh                 | 58 +++++++---------------------
 t/test-lib-functions.sh             | 60 ++++++++++++++++++-----------
 t/test-lib.sh                       | 41 ++++++++++++--------
 15 files changed, 90 insertions(+), 119 deletions(-)

Range-diff against v1:
 1:  8e4b4a2a216 !  1:  a8b483bc771 check-non-portable-shell: complain about "test" a/-o instead of &&/||
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    check-non-portable-shell: complain about "test" a/-o instead of &&/||
    +    check-non-portable-shell: check for "test <cond> -a/-o <cond>"
     
    -    Expand the t/check-non-portable-shell.pl checks to complain about the
    -    use of "-a" and "-o" to the "test" shell built-in to to mean "and" and
    -    "or", as opposed to using two "test" invocations with "&&" or "||".
    +    Add a check for -a/-o in "test", as a follow-up to the
    +    CodingGuidelines having recommended against their use since
    +    897f964c0dc (CodingGuidelines: avoid "test <cond> -a/-o <cond>",
    +    2014-05-20).
     
    -    There aren't any portability issues with using that construct that I
    -    know of, but since Junio expressed a dislike of it in [1] and we've
    -    currently got no such constructs let's add it to the lint checking. I
    -    had various in-flight and WIP patches that used this construct.
    +    These constructs are considered obsolescent by POSIX[1]. GNU has
    +    likewise warned against them[2] for a few decades.
     
    -    1. https://lore.kernel.org/git/xmqqa6qkb5fi.fsf@gitster.g/
    +    These will only match the simplistic forms of `test -X blah` (where
    +    "-X" is some single letter option), but will miss expressions such as
    +    `test "$foo" = bar`. We stop at "&" or "|" to try not to overmatch
    +    things like:
    +
    +        test whatever && ls -a foo
    +        test whatever && foo -o outfile
    +
    +    1. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html#tag_20_128_16
    +    2. https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.70/html_node/Limitations-of-Builtins.html
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/check-non-portable-shell.pl ##
     @@ t/check-non-portable-shell.pl: sub err {
    - 	next if $line =~ s/\\$//;
    - 
    - 	$_ = $line;
    -+	# Portability issues
    - 	/\bcp\s+-a/ and err 'cp -a is not portable';
    - 	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
    - 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
    -@@ t/check-non-portable-shell.pl: sub err {
    - 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
    - 	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
    - 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
    -+	# Coding style preferences
    -+	/\btest\s+-[a-z]\s+.*?\s+-a\s+/ and err '"test A && test B" preferred to "test A -a B"';
    -+	/\btest\s+-[a-z]\s+.*?\s+-o\s+/ and err '"test A || test B" preferred to "test A -o B"';
    - 	$line = '';
    - 	# this resets our $. for each file
    - 	close ARGV if eof;
    + 	/^\s*declare\s+/ and err 'arrays/declare not portable';
    + 	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
    + 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (use =)';
    ++	/\btest\s+-[a-z]\s+[^&|]+\s+-a\s+/ and err '"test A && test B" preferred to "test A -a B"';
    ++	/\btest\s+-[a-z]\s+[^&|]+\s+-o\s+/ and err '"test A || test B" preferred to "test A -o B"';
    + 	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
    + 	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
    + 	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
 2:  44223ae777e !  2:  39759d00adf test-lib: bring $remove_trash out of retirement
    @@ Commit message
         test-lib: bring $remove_trash out of retirement
     
         There's no point in creating a repository or directory only to decide
    -    right afterwards that we're skipping all the tests.
    +    right afterwards that we're skipping all the tests. We can save
    +    ourselves the redundant "git init" or "mkdir" and "rm -rf" in this
    +    case.
    +
    +    We carry around the "$remove_trash" variable because if the directory
    +    is unexpectedly gone at test_done time we'll hit the error about it
    +    being unexpectedly gone added in df4c0d1a792 (test-lib: abort when
    +    can't remove trash directory, 2017-04-20).
     
         So let's partially revert 06478dab4c (test-lib: retire $remove_trash
         variable, 2017-04-23) and move the decision about whether to skip all
 3:  3d04553d710 =  3:  d669ce31961 test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
 4:  4ecce153b99 =  4:  9313d35bf86 test-lib-functions: reword "test_commit --append" docs
 5:  6df03776940 !  5:  c916d648e49 test-lib-functions: document test_commit --no-tag
    @@ t/test-lib-functions.sh: debug () {
      #   --author <author>
      #	Invoke "git commit" with --author <author>
     +#   --no-tag
    -+#	Do not tag the resulting commit, if supplied giving the
    -+#	optional "<tag>" argument is an error.
    ++#	Do not tag the resulting commit
      #
      # This will commit a file with the given contents and the given commit
      # message, and tag the resulting commit with the given tag name.
 6:  8d43fdd5865 !  6:  9b6bf65ce1c test-lib functions: add an --annotated-tag option to "test_commit"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib functions: add an --annotated-tag option to "test_commit"
    +    test-lib functions: add an --annotated option to "test_commit"
     
    -    Add an --annotated-tag option to test_commit. The tag will share the
    -    same message as the commit, and we'll call test_tick before creating
    -    it (unless --notick) is provided.
    +    Add an --annotated option to test_commit to create annotated tags. The
    +    tag will share the same message as the commit, and we'll call
    +    test_tick before creating it (unless --notick) is provided.
     
         There's quite a few tests that could be simplified with this
         construct. I've picked one to convert in this change as a
    @@ t/t1403-show-ref.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     
      ## t/test-lib-functions.sh ##
     @@ t/test-lib-functions.sh: debug () {
    + #	Invoke "git commit" with --author <author>
      #   --no-tag
    - #	Do not tag the resulting commit, if supplied giving the
    - #	optional "<tag>" argument is an error.
    + #	Do not tag the resulting commit
     +#   --annotate
     +#	Create an annotated tag with "--annotate -m <message>". Calls
    -+#	test_tick between making the commit and tag unless --notick is
    -+#	given.
    ++#	test_tick between making the commit and tag, unless --notick
    ++#	is given.
      #
      # This will commit a file with the given contents and the given commit
      # message, and tag the resulting commit with the given tag name.
    @@ t/test-lib-functions.sh: test_commit () {
     -	fi
     +		;;
     +	annotate)
    -+		if test "$tag$notick" = "annotate"
    ++		if test -z "$notick"
     +		then
     +			test_tick
     +		fi &&
 7:  ec4809e7466 =  7:  683b3ba3dd9 describe tests: convert setup to use test_commit
 8:  352eeff41c9 =  8:  dc0a863db72 test-lib functions: add --printf option to test_commit
 9:  e7432294215 =  9:  90bf55d2d42 submodule tests: use symbolic-ref --short to discover branch name
10:  634038c3a8d = 10:  e0a1e2fd529 test-lib: reformat argument list in test_create_repo()
11:  cdbff4df362 = 11:  cedf5d383b0 test-lib: do not show advice about init.defaultBranch under --verbose
12:  424caad189f ! 12:  a3e20ef18f7 test-lib: modernize test_create_repo() function
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib: modernize test_create_repo() function
    +    test-lib: split up and deprecate test_create_repo()
     
    -    Remove redundant "mkdir -p", argument number checking', test
    -    environment sanity checking, and disabling of hooks from
    -    test_create_repo(). As we'll see below these were all either redundant
    -    to other test other framework code, or to changes in git itself.
    +    Remove various redundant or obsolete code from the test_create_repo()
    +    function, and split up its use in test-lib.sh from what tests need
    +    from it, leaving us with a pass-through wrapper for "git init" in
    +    test-lib-functions.sh
     
    -    Respectively:
    +    Reasons for why we can remove various code from test_create_repo():
     
          1. "mkdir -p" isn't needed because "git init" itself will create
             leading directories if needed.
     
    -     2. We don't need to check the number of arguments anymore, instead
    -        we'll feed "git init" with "$@". It will die if given too many
    -        arguments.
    +     2. Since we're now a simple wrapper for "git init" we don't need to
    +        check that we have only one argument. If someone wants to run
    +        "test_create_repo --bare x" that's OK.
     
          3. We won't ever hit that "Cannot setup test environment"
             error.
    @@ Commit message
          5. Since we don't need to move the .git/hooks directory we don't need
             the subshell here either.
     
    +        That wasn't really needed for the .git/hooks either, but was being
    +        done for the convenience of not having to quote the path to the
    +        repository as we moved the hooks.
    +
    +     6. We can drop the --template argument and instead rely on the
    +        GIT_TEMPLATE_DIR set to the same path earlier in test-lib.sh. See
    +        8683a45d669 (Introduce GIT_TEMPLATE_DIR, 2006-12-19)
    +
    +     7. We only needed that ">&3 2>&4" redirection when invoked from
    +        test-lib.sh, and the same goes for needing the full path to "git".
    +
    +        Let's move that special behavior into test-lib.sh itself.
    +
         In the end it turns out that all we needed was a plain "git init"
    -    invocation with a custom --template directory.
    +    invocation.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t5409-colorize-remote-messages.sh: test_description='remote messages are color
     
      ## t/test-lib-functions.sh ##
     @@ t/test-lib-functions.sh: test_atexit () {
    - # Most tests can use the created repository, but some may need to create more.
    + 		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
    + }
    + 
    +-# Most tests can use the created repository, but some may need to create more.
    ++# Deprecated wrapper for "git init", use "git init" directly instead
      # Usage: test_create_repo <directory>
      test_create_repo () {
     -	test "$#" = 1 ||
    @@ t/test-lib-functions.sh: test_atexit () {
     -		error "cannot run git init -- have you built things yet?"
     -		mv .git/hooks .git/hooks-disabled
     -	) || exit
    -+	"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
    -+		init \
    -+		"--template=$GIT_BUILD_DIR/templates/blt/" "$@" >&3 2>&4
    ++	git init "$@"
      }
      
      # This function helps on symlink challenged file systems when it is not
    +
    + ## t/test-lib.sh ##
    +@@ t/test-lib.sh: rm -fr "$TRASH_DIRECTORY" || {
    + remove_trash=t
    + if test -z "$TEST_NO_CREATE_REPO"
    + then
    +-	test_create_repo "$TRASH_DIRECTORY"
    ++	"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" \
    ++		init \
    ++		"$TRASH_DIRECTORY" >&3 2>&4 ||
    ++	error "cannot run git init"
    + else
    + 	mkdir -p "$TRASH_DIRECTORY"
    + fi
13:  0813aa8e34e <  -:  ----------- test-lib-functions: normalize test_path_is_missing() debugging
14:  b6e9d971b40 <  -:  ----------- test-lib-functions: use "return 1" instead of "false"
15:  0cd511206c4 <  -:  ----------- Revert and amend "test-lib-functions: assert correct parameter count"
16:  b4a018a63f3 <  -:  ----------- test-lib-functions: remove last two parameter count assertions
-- 
2.31.1.722.g788886f50a2

