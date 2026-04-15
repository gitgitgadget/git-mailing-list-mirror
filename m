Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4B38CFEF
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258403; cv=none; b=RtSRdLLhAA6QmO9VCGk7xa6geqHKp3DnCzs4ssYRbK7EbpdH380b8QX4a2IJbaPfFekboGsi3Fz9j57/K/rvrwzfXFIEExIneOv5ejaTYfSkBSZkisljCc3HYg66bmZMcoIxaZ5pfsq+L0/MU9ZOVF90rVcroVS+4uZLtj4UGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258403; c=relaxed/simple;
	bh=lmjd6jABCfzK5fPx877BE/eObZiFxqYx+2mXAW8HDF4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=qOqWQo47nobqLgqDEH/v0M43MOLHF78YaQljvQnKfMvvSJKoOzt15tyxKQ+nuKUcmVtFWGMvLun7jdk4XQBSHaf3Ld2ojP5IRxka41TrJ4wpLnCb7k64uTF1HOX1xfB3Qh9Ept5opO6IdZ3wirTi9gWUWpNK5xtWtejng7mOHkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bZaYtmU6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3zf2NRL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bZaYtmU6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3zf2NRL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F2DC4EC0233;
	Wed, 15 Apr 2026 09:06:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 15 Apr 2026 09:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258399;
	 x=1776344799; bh=EOpz4EOekOLXCbRS3IiGt15i6ABX//EccmHwqIbh8KA=; b=
	bZaYtmU65wHYqVl5+lDxQxkihV+xDOBnmmUe8jlQvstvQqLI8oYN6vtCUmeTLp2f
	mF9erzlzel9JkTthTNROZtyXNttuI4c/tJuvKxgNEPHcTYbKggCGuO/5owsOiDuy
	waXjHNcHj3zn4/zSn2hjBtu8ADVqCKi2yW7DPjNdb4nwOrG//DliD+JzeCuj5dui
	gBFo3XlZ47Mrqpeqq12pTam9muZrJrmRKXHJH/GIraZhBQTWUTbXFWB/dD61N5D7
	xwGxCU8Lq0lVgv+x7THaNfXnvnUsThjy1DeCYs7mW8Kqwhn3qkAeZ5PC8jQj/kF3
	BVchtc5frTxbk+XXzTaYlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258399; x=
	1776344799; bh=EOpz4EOekOLXCbRS3IiGt15i6ABX//EccmHwqIbh8KA=; b=k
	3zf2NRLZ4+iHNsmb5Gak+q1uagXVMhRriQfQM2RXMO50W/1x+CKiunaKzsfj2mHq
	feqCQ3rU2ii/0AQU5d7eZbMbMZYTLYAjtYTaX10p1KHzw7ugeHYhJQeUyP/dCgAR
	7tLRJFS/IblxyfUHp+myHEPC1ii+i+rKqwqG/hHKCT86EyH/q1SZgSHWF661s8uL
	cOzRYnb4itQaH7EwQfA/Mj0bECk7Er0a2OZHNkRcpGZgsaNyMR4bqdlbhM/iPhPm
	ERJNFfyrg9ENXf3b99Pn/qGv7teGdZtsYZMeJSvfsD+789pa9aKHPpM0qa1tdA3Y
	0luCi0+mpL0IIUjgzEFlA==
X-ME-Sender: <xms:X43faQCfL_LHsnxgrupUMz2xsxown5ZZ2GuZouUNgd641pJ4w0h-Og>
    <xme:X43faZ-q8izYiDTBzveRmKIVB55R8A8pn750x1pNYhwgr-NJ0vkcS1UnJYP8JFS15
    us6yYUavPjon0jot44Ydpb7YjtjQoNojc-y3PY3E2y-oU659Ha_Kkg>
X-ME-Received: <xmr:X43faQ-Ir4ms2Sc00cP-dgX5qXCu4fzRuS1F3hAkYh2y8WF8Zx0FwRNSFCModdgnR60fHiYtEn4K5q70F_1fq003eUtli05sQVg8RBMSe9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedttdefledvueekvefhudegtdffteeftdetle
    evkefhteffgfelhfffjeejieelveenucffohhmrghinhepmhhsghhiugdrlhhinhhkpdhg
    ihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmpdhhthhtphgurdhshhdpghhnuhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:X43faQfsmKyJg8pKwDVK6NpTfYj9_HIo-VUEZH7e6WramqpMFgGTig>
    <xmx:X43faZFEAPRi94ClENb9eLDe1_ve27NbkG3XuTc78EjbimZqTEh62Q>
    <xmx:X43faef49B-d0hhjIgFEqU_hvyW4F-onO9yIngReoVnbQJKwrQuNSA>
    <xmx:X43faTGOtOdqNlZ3vGZQm-UUIWNO-_NAPhpvObPL4e8U5vIOuJNlHw>
    <xmx:X43faUsrmxRT9YWEDJDGpRt0NgqRKIZQGEuKGKiapmUOBnvkn7g2j-Dq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:06:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id da78df97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:06:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/12] t: detect errors outside of test cases
Date: Wed, 15 Apr 2026 15:06:33 +0200
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFmN32kC/3WNyw6CMBBFf4V07Zi+eOjK/zAsKI4yGoF0KmpI/
 92CcenyJOfeMwtGT8hin83C40RMQ59AbzLRdk1/QaBTYqGlLqRVEpyF8cYQkAPDk0IHjAEQTIO
 23DltXa5EWo8ez/Ran4/1l/nhrtiG5W4xOuIw+PeantTi/Srmb2VSICF3lSkL00is7CFpW7qLO
 sb4Afhib3bNAAAA
X-Change-ID: 20260410-b4-pks-tests-with-set-e-3ae479b24b51
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

Hi,

this is a follow-up to the recent discussion we had around `set -e` to
make our tests more robust and basically supersedes Junio's [1].

I've tested the patches with both Bash and Dash, and all tests are
passing on my machine with both of them. CI seems to be happy, as
well. But I would expect that this change probably has some fallout,
even though I hope that it's generally going to be small and contained.

This series is based on 8c9303b1ff (Merge branch
'jc/no-writev-does-not-work', 2026-04-10).

I've created an MR with GitLab [2] and a PR with GitHub [3] to verify
that these changes work on both platforms.

Changes in v2:
  - Use `ret=0; $command || ret=$?` pattern.
  - Restore `echo 0` in SIGPIPE tests.
  - Fix "lib-git-svn.sh" to gracefully handle the case where SVN Perl
    modules aren't installed.
  - Use `|| :` consistently instead of `|| true`.
  - Fix up a couple of tests that fail on FreeBSD 15. The test suite is
    now passing on this system, too.
  - Only enable `set -e` on Bash 5 and newer.
  - Link to v1: https://patch.msgid.link/20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im

Thanks!

Patrick

[1]: <20260325062114.2067946-1-gitster@pobox.com>
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/541
[3]: https://github.com/git/git/pull/2270

---
Patrick Steinhardt (12):
      t: prepare `test_match_signal ()` calls for `set -e`
      t: prepare `test_must_fail ()` for `set -e`
      t: prepare `stop_git_daemon ()` for `set -e`
      t: prepare `git config --unset` calls for `set -e`
      t: prepare conditional test execution for `set -e`
      t: prepare execution of potentially failing commands for `set -e`
      t: prepare `test_when_finished ()`/`test_atexit()` for `set -e`
      t0008: silence error in subshell when using `grep -v`
      t1301: don't fail in case setfacl(1) doesn't exist or fails
      t6002: fix use of `expr` with `set -e`
      t9902: fix use of `read` with `set -e`
      t: detect errors outside of test cases

 t/lib-git-daemon.sh                |  8 +++++---
 t/lib-git-svn.sh                   |  7 +++----
 t/lib-httpd.sh                     |  3 +--
 t/t0005-signals.sh                 |  4 ++--
 t/t0008-ignores.sh                 |  4 ++--
 t/t1301-shared-repo.sh             |  2 +-
 t/t3600-rm.sh                      |  2 +-
 t/t3901-i18n-patch.sh              |  3 ++-
 t/t4032-diff-inter-hunk-context.sh | 14 ++++++++------
 t/t5000-tar-tree.sh                |  4 ++--
 t/t6002-rev-list-bisect.sh         | 17 ++++++++++-------
 t/t7422-submodule-output.sh        |  2 +-
 t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
 t/t7508-status.sh                  |  4 ++--
 t/t9138-git-svn-authors-prog.sh    |  4 ++--
 t/t9200-git-cvsexportcommit.sh     |  3 +--
 t/t9400-git-cvsserver-server.sh    |  5 +++--
 t/t9401-git-cvsserver-crlf.sh      |  4 ++--
 t/t9402-git-cvsserver-refs.sh      |  4 ++--
 t/t9902-completion.sh              |  2 +-
 t/test-lib-functions.sh            | 12 ++++++------
 t/test-lib.sh                      | 19 +++++++++++++++----
 22 files changed, 85 insertions(+), 66 deletions(-)

Range-diff versus v1:

 1:  210ccb018c !  1:  6e3147dbb1 t: prepare `test_match_signal ()` calls for `set -e`
    @@ Commit message
         but as we expect `foo` to fail this will cause the overall subshell to
         fail once we `set -e`.
     
    -    Fix this issue by using `foo || echo $?` instead.
    +    Fix this issue by using `foo && echo 0 || echo $?` instead.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ t/t0005-signals.sh: test_expect_success 'create blob' '
      
      test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
     -	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
    -+	OUT=$( ((large_git || echo $? 1>&3) | :) 3>&1 ) &&
    ++	OUT=$( ((large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
      	test_match_signal 13 "$OUT"
      '
      
      test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
     -	OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
    -+	OUT=$( ((trap "" PIPE && large_git || echo $? 1>&3) | :) 3>&1 ) &&
    ++	OUT=$( ((trap "" PIPE && large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
      	test_match_signal 13 "$OUT"
      '
      
    @@ t/t3600-rm.sh: test_expect_success 'choking "git rm" should not let it die with
      test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
      	choke_git_rm_setup &&
     -	OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
    -+	OUT=$( ((trap "" PIPE && git rm -n "some-file-*" || echo $? 1>&3) | :) 3>&1 ) &&
    ++	OUT=$( ((trap "" PIPE && git rm -n "some-file-*" && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
      	test_match_signal 13 "$OUT" &&
      	test_path_is_missing .git/index.lock
      '
 2:  c056357f6d <  -:  ---------- t: prepare `test_must_fail ()` for `set -e`
 -:  ---------- >  2:  393374871a t: prepare `test_must_fail ()` for `set -e`
 3:  d9076a67ba !  3:  2ff2e3fb7d t: prepare `stop_git_daemon ()` for `set -e`
    @@ Commit message
             than not that we have already killed it, and the call to kill will
             fail.
     
    -    Prepare for this change by making the call to `wait` part of a condition
    -    and by silencing failures of the second call to `kill`.
    +    Prepare for this change by handling the failure of `wait` with `||` and
    +    by silencing failures of the second call to `kill`.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ t/lib-git-daemon.sh: stop_git_daemon() {
      	kill "$GIT_DAEMON_PID"
     -	wait "$GIT_DAEMON_PID" >&3 2>&4
     -	ret=$?
    -+	if wait "$GIT_DAEMON_PID" >&3 2>&4
    -+	then
    -+		ret=0
    -+	else
    -+		ret=$?
    -+	fi
    ++	ret=0; wait "$GIT_DAEMON_PID" >&3 2>&4 || ret=$?
     +
      	if ! test_match_signal 15 $ret
      	then
 4:  50be774536 =  4:  2c51b9d9fa t: prepare `git config --unset` calls for `set -e`
 5:  b1ac21d4dd =  5:  adba2b830f t: prepare conditional test execution for `set -e`
 6:  19518eeac5 !  6:  61f949e1fb t: prepare execution of potentially failing commands for `set -e`
    @@ t/lib-git-svn.sh: GIT_SVN_DIR=$GIT_DIR/svn/refs/remotes/git-svn
      then
      	skip_all='skipping git svn tests, svn not found'
      	test_done
    +@@ t/lib-git-svn.sh: export svnrepo
    + svnconf=$PWD/svnconf
    + export svnconf
    + 
    ++x=0
    + perl -w -e "
    + use SVN::Core;
    + use SVN::Repos;
    + \$SVN::Core::VERSION gt '1.1.0' or exit(42);
    + system(qw/svnadmin create --fs-type fsfs/, \$ENV{svnrepo}) == 0 or exit(41);
    +-" >&3 2>&4
    +-x=$?
    ++" >&3 2>&4 || x=$?
    + if test $x -ne 0
    + then
    + 	if test $x -eq 42; then
     
      ## t/lib-httpd.sh ##
     @@ t/lib-httpd.sh: start_httpd() {
    @@ t/lib-httpd.sh: start_httpd() {
      		cat "$HTTPD_ROOT_PATH"/error.log >&4 2>/dev/null
      		test_skip_or_die GIT_TEST_HTTPD "web server setup failed"
     
    + ## t/t3901-i18n-patch.sh ##
    +@@ t/t3901-i18n-patch.sh: check_encoding () {
    + 		8859)
    + 			grep "^encoding ISO8859-1" ;;
    + 		*)
    +-			grep "^encoding ISO8859-1"; test "$?" != 0 ;;
    ++			ret=0; grep "^encoding ISO8859-1" || ret=$?
    ++			test "$ret" != 0 ;;
    + 		esac || return 1
    + 		j=$i
    + 		i=$(($i+1))
    +
    + ## t/t5000-tar-tree.sh ##
    +@@ t/t5000-tar-tree.sh: test_expect_success LONG_IS_64BIT 'set up repository with huge blob' '
    + # would generate the whole 64GB).
    + test_expect_success LONG_IS_64BIT 'generate tar with huge size' '
    + 	{
    +-		git archive HEAD
    +-		echo $? >exit-code
    ++		{ ret=0 && git archive HEAD || ret=$?; } &&
    ++		echo "$ret" >exit-code
    + 	} | test_copy_bytes 4096 >huge.tar &&
    + 	echo 141 >expect &&
    + 	test_cmp expect exit-code
    +
    + ## t/t7422-submodule-output.sh ##
    +@@ t/t7422-submodule-output.sh: test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE'
    + 	(
    + 		cd repo &&
    + 		GIT_ALLOW_PROTOCOL=file git submodule add "$(pwd)"/../submodule &&
    +-		{ git submodule status --recursive 2>err; echo $?>status; } |
    ++		{ { ret=0 && git submodule status --recursive 2>err || ret=$?; } && echo $ret >status; } |
    + 			grep -q recursive-submodule-path-1 &&
    + 		test_must_be_empty err &&
    + 		test_match_signal 13 "$(cat status)"
    +
      ## t/t9200-git-cvsexportcommit.sh ##
     @@ t/t9200-git-cvsexportcommit.sh: if ! test_have_prereq PERL; then
      	test_done
    @@ t/t9402-git-cvsserver-refs.sh: check_diff() {
      then
      	skip_all='skipping git-cvsserver tests, perl not available'
     
    + ## t/test-lib-functions.sh ##
    +@@ t/test-lib-functions.sh: test_might_fail () {
    + test_expect_code () {
    + 	want_code=$1
    + 	shift
    +-	"$@" 2>&7
    +-	exit_code=$?
    ++	exit_code=0; "$@" 2>&7 || exit_code=$?
    + 	if test $exit_code = $want_code
    + 	then
    + 		return 0
    +
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      ################################################################
    @@ t/test-lib.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      then
      	if test -n "$GIT_TEST_INSTALLED"
      	then
    +@@ t/test-lib.sh: then
    + 	# from any previous runs.
    + 	>"$GIT_TEST_TEE_OUTPUT_FILE"
    + 
    +-	(GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;
    +-	 echo $? >"$TEST_RESULTS_BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
    ++	(
    ++		ret=0 && GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1 || ret=$?
    ++		echo "$ret" >"$TEST_RESULTS_BASE.exit"
    ++	) | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
    + 	test "$(cat "$TEST_RESULTS_BASE.exit")" = 0
    + 	exit
    + fi
 7:  7d7583d1ea =  7:  697830e576 t: prepare `test_when_finished ()`/`test_atexit()` for `set -e`
 8:  749a350716 !  8:  d5d1ea03ab t0008: silence error in subshell when using `grep -v`
    @@ t/t0008-ignores.sh: test_expect_success_multiple () {
      
     -	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
     -	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
    -+	expect_verbose=$(echo "$expect_all" | grep -v '^::	' || true)
    ++	expect_verbose=$(echo "$expect_all" | grep -v '^::	' || :)
     +	expect=$(echo "$expect_verbose" | sed -e 's/.*	//')
      
      	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
 9:  14c8dd5148 !  9:  75a150e2dd t1301: don't fail in case setfacl(1) doesn't exist or fails
    @@ t/t1301-shared-repo.sh: TEST_CREATE_REPO_NO_TEMPLATE=1
      
      # Remove a default ACL from the test dir if possible.
     -setfacl -k . 2>/dev/null
    -+setfacl -k . 2>/dev/null || true
    ++setfacl -k . 2>/dev/null || :
      
      # User must have read permissions to the repo -> failure on --shared=0400
      test_expect_success 'shared = 0400 (faulty permission u-w)' '
10:  a81e602616 = 10:  ba22bab22d t6002: fix use of `expr` with `set -e`
11:  dcf5c849e9 = 11:  5a8e2df836 t9902: fix use of `read` with `set -e`
12:  691e1c9b58 ! 12:  8266ee6035 t: detect errors outside of test cases
    @@ Commit message
         Improve the status quo by enabling the errexit option so that any such
         unchecked failures will cause us to abort immediately.
     
    +    Note that for now, we only enable this option for Bash 5 and newer. This
    +    is because other shells have wildly different behaviour, and older
    +    versions of Bash (especially on macOS) are buggy. The list of enabled
    +    shells may be extended going forward.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## t/test-lib.sh ##
    @@ t/test-lib.sh
      # along with this program.  If not, see https://www.gnu.org/licenses/ .
      
     +# Enable the use of errexit so that any unexpected failures will cause us to
    -+# abort tests, even when outside of a specific test case.
    -+set -e
    ++# abort tests, even when outside of a specific test case. Note that we only
    ++# enable this on Bash 5 and newer, as `set -e` has wildly different behaviour
    ++# across shells. The list of allowed shells may be extended going forward.
    ++if test "${BASH_VERSINFO:=0}" -ge 5
    ++then
    ++	set -e
    ++fi
     +
      # Test the binaries we have just built.  The tests are kept in
      # t/ subdirectory and are run in 'trash directory' subdirectory.

---
base-commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
change-id: 20260410-b4-pks-tests-with-set-e-3ae479b24b51

