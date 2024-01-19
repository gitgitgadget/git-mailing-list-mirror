Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3A41C98
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695546; cv=none; b=lYj1FxlauBrbBtABROc13WnkQdWPPfDMJcuSCdR61QO8ox1c3DeEqXg/HpW2k4AEMcDr4ySjeJV//A/JG0W4vaF7OEu2DGKieaHTFYNLtUV2baVTynErE44kgKNF5nTn+G7Hl5cC03URGkVfsn4PxQx5UihXRfGck77ffeRAARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695546; c=relaxed/simple;
	bh=aIBGKnNr9mULJXLwWsjh8pjfsdkG9ojMh7GpVORvSmg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HA5um9R4lKaU8sxuY9PmRILwLJuvSi8q5Sr0kNcOCkNP4WVi/OiuUtLXsrkoqUa+QlERU5y/FL0zwgK1LlKMNTas51M5IKFZ2EibiYrSqbXVNYf3bcTbg7vpvbWV2X8ELWQ7PCamIFTRY/nXfVM/8K2CPF5NDRMacIchS2Vjnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksw6uBJm; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksw6uBJm"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337cf4ac600so943486f8f.3
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695542; x=1706300342; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79edVzwe9NXc1ZZhtsDGDZXd+0dbHvZ3Xm54OgzO5kE=;
        b=ksw6uBJmoYfArBB7mAlx4chflbHDmwa5AlezIkv0hV1BR9x3ziChEIjWG5zqlhR73u
         4QxzRtdeBIsaB/CiZas+0xtHwMfoI3/YM1FPvGfyUsvdWut3xCykOxdnx2qSSQVeR89U
         u50C8ePE6Sj4W5AY5IVh0kRJ/qWguogGswrrBcI11gSBQyggyDm9MmiLhYHqIr/glJbn
         61v6zvS0wE4H0pNISNhM0hnSB3UJlblPD2hHn552/IqaCxSxXq71ks2q07pIws33WhQn
         c/hNQSKBHhh19Vd2iLCPEW6SiRrc5vRirBJohkwkD4gLPvhK6YhBQgaQIhLuSjD5MzHq
         IRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695542; x=1706300342;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79edVzwe9NXc1ZZhtsDGDZXd+0dbHvZ3Xm54OgzO5kE=;
        b=Pz8L0Dzm31e9kmmkXmugNrmEkf2nRHuhX2vtCALlSZbNjBeb1xMCz/gbr5u9yAychZ
         Ub1R1WNw6p/2e9jibHqUOqSRCQ0f09JDJhcTt1khEuZ3OSu5U1crpLmwu7JNFMpD3hGd
         F/jTFoKLJXhwLl4ZWDqtlamu3I465vimydZBVRdcc6Blcb7A3pa65O16Z1iXy4aiex1s
         nEsmKTpu5EK9ddkp82SRdke31Vinbattl9OMxTuvZLmieph+XxhwFsBEl+/m6qb1C9Un
         qUEWtq8b03R7x+d2DJ329CYIWnGr6B61fonbMxMzOx6mhFHoIaqb4dT6wORbmEOY3Mcs
         uMoA==
X-Gm-Message-State: AOJu0YzjKBbxIRVy3q7OtlkMnDGdC6ahcgGihevEUGRGMxCy+Es5qir1
	xwGmLA0K+IaWTlg4BRS6Mzcq0phyvlcH6t8WMlyAyjkJXDThL9mi/S8uAN6j
X-Google-Smtp-Source: AGHT+IHQquNVmkgteuI81WlmGfOAjF4Wk6QtnPAk3e43207JqZlRnG66KSHhS6q32SvIjbr2N5BfvQ==
X-Received: by 2002:a5d:4105:0:b0:337:be25:c0d8 with SMTP id l5-20020a5d4105000000b00337be25c0d8mr144387wrp.20.1705695541806;
        Fri, 19 Jan 2024 12:19:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13-20020adfeecd000000b00337d6d3850esm3725770wrp.9.2024.01.19.12.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:01 -0800 (PST)
Message-ID: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:48 +0000
Subject: [PATCH v2 00/12] Group reffiles tests
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>

This series groups REFFILES specific tests together. These tests are
currently grouped together across the test suite based on functionality.
However, since they exercise low-level behavior specific to the refs backend
being used (in these cases, the ref-files backend), group them together
based on which refs backend they test. This way, in the near future when the
reftables backend gets upstreamed we can add tests that exercise the
reftables backend close by in the t06xx area.

These patches also remove the REFFILES prerequisite, since all the tests in
t06xx are reffiles specific. In the near future, once the reftable backend
is upstreamed, all the tests in t06xx will be forced to run with the
reffiles backend.

Changes since V1:

 * Moved some pack-refs tests to t0601 instead of t0600
 * Clarified some commit messages
 * Converted a test to be refs-backend agnostic
 * Other minor rearranging of tests

John Cai (12):
  t3210: move to t0601
  remove REFFILES prerequisite for some tests in t1405 and t2017
  t1414: convert test to use Git commands instead of writing refs
    manually
  t1404: move reffiles specific tests to t0600
  t1405: move reffiles specific tests to t0601
  t1406: move reffiles specific tests to t0600
  t1410: move reffiles specific tests to t0600
  t1415: move reffiles specific tests to t0601
  t1503: move reffiles specific tests to t0600
  t3903: make drop stash test ref backend agnostic
  t4202: move reffiles specific tests to t0600
  t5312: move reffiles specific tests to t0601

 t/t0600-reffiles-backend.sh                   | 384 ++++++++++++++++++
 ...ck-refs.sh => t0601-reffiles-pack-refs.sh} |  64 +++
 t/t1404-update-ref-errors.sh                  | 237 -----------
 t/t1405-main-ref-store.sh                     |  10 +-
 t/t1407-worktree-ref-store.sh                 |  37 --
 t/t1410-reflog.sh                             |  42 --
 t/t1414-reflog-walk.sh                        |  11 +-
 t/t1415-worktree-refs.sh                      |  11 -
 t/t1503-rev-parse-verify.sh                   |   5 -
 t/t2017-checkout-orphan.sh                    |   2 +-
 t/t3903-stash.sh                              |  12 +-
 t/t4202-log.sh                                |  17 -
 t/t5312-prune-corruption.sh                   |  26 --
 13 files changed, 461 insertions(+), 397 deletions(-)
 create mode 100755 t/t0600-reffiles-backend.sh
 rename t/{t3210-pack-refs.sh => t0601-reffiles-pack-refs.sh} (81%)


base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1647%2Fjohn-cai%2Fjc%2Fgroup-reffiles-tests-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1647/john-cai/jc/group-reffiles-tests-v2
Pull-Request: https://github.com/git/git/pull/1647

Range-diff vs v1:

  1:  0e2b6e197ab <  -:  ----------- t3210: move to t0602
  -:  ----------- >  1:  ca65b9e6122 t3210: move to t0601
  2:  624ad202305 !  2:  29c32d3e6f7 remove REFFILES prerequisite
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    remove REFFILES prerequisite
     +    remove REFFILES prerequisite for some tests in t1405 and t2017
      
          These tests are compatible with the reftable backend and thus do not
     -    need the REFFILES prerequisite.
     +    need the REFFILES prerequisite. Even though 53af25e4
     +    (t1405: mark test that checks existence as REFFILES, 2022-01-31) and
     +    53af25e4 (t1405: mark test that checks existence as REFFILES,
     +    2022-01-31) marked these tests to require REFFILES, the reftable backend
     +    in its current state does indeed work with these tests.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
  3:  19233aa0d44 !  3:  122d19a9095 t1414: convert test to use Git commands instead of writing refs manually
     @@ t/t1414-reflog-walk.sh: test_expect_success 'min/max age uses entry date to limi
      -	one=$(git rev-parse one) &&
      -	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
      -	echo "$head $one $ident	broken reflog entry" >>.git/logs/HEAD &&
     -+	A=$(git rev-parse A) &&
     - 
     +-
      -	echo $one >expect &&
     -+	echo $A >expect &&
     ++	git rev-parse A >expect &&
       	git log -g --format=%H -1 >actual &&
       	test_cmp expect actual
       '
  4:  0f6fea6d32d !  4:  c3f0b81200c t1404: move reffiles specific tests to t0600
     @@ t/t0600-reffiles-backend.sh (new)
      +TEST_PASSES_SANITIZE_LEAK=true
      +. ./test-lib.sh
      +
     -+# Test adding and deleting D/F-conflicting references in a single
     -+# transaction.
     -+df_test() {
     -+	prefix="$1"
     -+	pack=: symadd=false symdel=false add_del=false addref= delref=
     -+	shift
     -+	while test $# -gt 0
     -+	do
     -+		case "$1" in
     -+		--pack)
     -+			pack="git pack-refs --all"
     -+			shift
     -+			;;
     -+		--sym-add)
     -+			# Perform the add via a symbolic reference
     -+			symadd=true
     -+			shift
     -+			;;
     -+		--sym-del)
     -+			# Perform the del via a symbolic reference
     -+			symdel=true
     -+			shift
     -+			;;
     -+		--del-add)
     -+			# Delete first reference then add second
     -+			add_del=false
     -+			delref="$prefix/r/$2"
     -+			addref="$prefix/r/$3"
     -+			shift 3
     -+			;;
     -+		--add-del)
     -+			# Add first reference then delete second
     -+			add_del=true
     -+			addref="$prefix/r/$2"
     -+			delref="$prefix/r/$3"
     -+			shift 3
     -+			;;
     -+		*)
     -+			echo 1>&2 "Extra args to df_test: $*"
     -+			return 1
     -+			;;
     -+		esac
     -+	done
     -+	git update-ref "$delref" $C &&
     -+	if $symadd
     ++if ! test_have_prereq REFFILES
      +	then
     -+		addname="$prefix/s/symadd" &&
     -+		git symbolic-ref "$addname" "$addref"
     -+	else
     -+		addname="$addref"
     -+	fi &&
     -+	if $symdel
     -+	then
     -+		delname="$prefix/s/symdel" &&
     -+		git symbolic-ref "$delname" "$delref"
     -+	else
     -+		delname="$delref"
     -+	fi &&
     -+	cat >expected-err <<-EOF &&
     -+	fatal: cannot lock ref $SQ$addname$SQ: $SQ$delref$SQ exists; cannot create $SQ$addref$SQ
     -+	EOF
     -+	$pack &&
     -+	if $add_del
     -+	then
     -+		printf "%s\n" "create $addname $D" "delete $delname"
     -+	else
     -+		printf "%s\n" "delete $delname" "create $addname $D"
     -+	fi >commands &&
     -+	test_must_fail git update-ref --stdin <commands 2>output.err &&
     -+	test_cmp expected-err output.err &&
     -+	printf "%s\n" "$C $delref" >expected-refs &&
     -+	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
     -+	test_cmp expected-refs actual-refs
     -+}
     ++		skip_all='skipping reffiles specific tests'
     ++		test_done
     ++fi
      +
      +test_expect_success 'setup' '
      +	git commit --allow-empty -m Initial &&
     @@ t/t0600-reffiles-backend.sh (new)
      +	git update-ref --stdin
      +'
      +
     -+test_expect_success 'D/F conflict prevents add long + delete short' '
     -+	df_test refs/df-al-ds --add-del foo/bar foo
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents add short + delete long' '
     -+	df_test refs/df-as-dl --add-del foo foo/bar
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents delete long + add short' '
     -+	df_test refs/df-dl-as --del-add foo/bar foo
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents delete short + add long' '
     -+	df_test refs/df-ds-al --del-add foo foo/bar
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents add long + delete short packed' '
     -+	df_test refs/df-al-dsp --pack --add-del foo/bar foo
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents add short + delete long packed' '
     -+	df_test refs/df-as-dlp --pack --add-del foo foo/bar
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents delete long packed + add short' '
     -+	df_test refs/df-dlp-as --pack --del-add foo/bar foo
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents delete short packed + add long' '
     -+	df_test refs/df-dsp-al --pack --del-add foo foo/bar
     -+'
     -+
     -+# Try some combinations involving symbolic refs...
     -+
     -+test_expect_success 'D/F conflict prevents indirect add long + delete short' '
     -+	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents indirect add long + indirect delete short' '
     -+	df_test refs/df-ial-ids --sym-add --sym-del --add-del foo/bar foo
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents indirect add short + indirect delete long' '
     -+	df_test refs/df-ias-idl --sym-add --sym-del --add-del foo foo/bar
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents indirect delete long + indirect add short' '
     -+	df_test refs/df-idl-ias --sym-add --sym-del --del-add foo/bar foo
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents indirect add long + delete short packed' '
     -+	df_test refs/df-ial-dsp --sym-add --pack --add-del foo/bar foo
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents indirect add long + indirect delete short packed' '
     -+	df_test refs/df-ial-idsp --sym-add --sym-del --pack --add-del foo/bar foo
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents add long + indirect delete short packed' '
     -+	df_test refs/df-al-idsp --sym-del --pack --add-del foo/bar foo
     -+'
     -+
     -+test_expect_success 'D/F conflict prevents indirect delete long packed + indirect add short' '
     -+	df_test refs/df-idlp-ias --sym-add --sym-del --pack --del-add foo/bar foo
     -+'
     -+
      +test_expect_success 'non-empty directory blocks create' '
      +	prefix=refs/ne-create &&
      +	mkdir -p .git/$prefix/foo/bar &&
     @@ t/t0600-reffiles-backend.sh (new)
      +test_done
      
       ## t/t1404-update-ref-errors.sh ##
     -@@ t/t1404-update-ref-errors.sh: test_update_rejected () {
     - 	test_cmp unchanged actual
     - }
     - 
     --# Test adding and deleting D/F-conflicting references in a single
     --# transaction.
     --df_test() {
     --	prefix="$1"
     --	pack=: symadd=false symdel=false add_del=false addref= delref=
     --	shift
     --	while test $# -gt 0
     --	do
     --		case "$1" in
     --		--pack)
     --			pack="git pack-refs --all"
     --			shift
     --			;;
     --		--sym-add)
     --			# Perform the add via a symbolic reference
     --			symadd=true
     --			shift
     --			;;
     --		--sym-del)
     --			# Perform the del via a symbolic reference
     --			symdel=true
     --			shift
     --			;;
     --		--del-add)
     --			# Delete first reference then add second
     --			add_del=false
     --			delref="$prefix/r/$2"
     --			addref="$prefix/r/$3"
     --			shift 3
     --			;;
     --		--add-del)
     --			# Add first reference then delete second
     --			add_del=true
     --			addref="$prefix/r/$2"
     --			delref="$prefix/r/$3"
     --			shift 3
     --			;;
     --		*)
     --			echo 1>&2 "Extra args to df_test: $*"
     --			return 1
     --			;;
     --		esac
     --	done
     --	git update-ref "$delref" $C &&
     --	if $symadd
     --	then
     --		addname="$prefix/s/symadd" &&
     --		git symbolic-ref "$addname" "$addref"
     --	else
     --		addname="$addref"
     --	fi &&
     --	if $symdel
     --	then
     --		delname="$prefix/s/symdel" &&
     --		git symbolic-ref "$delname" "$delref"
     --	else
     --		delname="$delref"
     --	fi &&
     --	cat >expected-err <<-EOF &&
     --	fatal: cannot lock ref $SQ$addname$SQ: $SQ$delref$SQ exists; cannot create $SQ$addref$SQ
     --	EOF
     --	$pack &&
     --	if $add_del
     --	then
     --		printf "%s\n" "create $addname $D" "delete $delname"
     --	else
     --		printf "%s\n" "delete $delname" "create $addname $D"
     --	fi >commands &&
     --	test_must_fail git update-ref --stdin <commands 2>output.err &&
     --	test_cmp expected-err output.err &&
     --	printf "%s\n" "$C $delref" >expected-refs &&
     --	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
     --	test_cmp expected-refs actual-refs
     --}
     --
     - test_expect_success 'setup' '
     - 
     - 	git commit --allow-empty -m Initial &&
      @@ t/t1404-update-ref-errors.sh: test_expect_success 'one new ref is a simple prefix of another' '
       
       '
     @@ t/t1404-update-ref-errors.sh: test_expect_success 'one new ref is a simple prefi
      -	git update-ref --stdin
      -'
      -
     --test_expect_success REFFILES 'D/F conflict prevents add long + delete short' '
     --	df_test refs/df-al-ds --add-del foo/bar foo
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents add short + delete long' '
     --	df_test refs/df-as-dl --add-del foo foo/bar
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents delete long + add short' '
     --	df_test refs/df-dl-as --del-add foo/bar foo
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents delete short + add long' '
     --	df_test refs/df-ds-al --del-add foo foo/bar
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents add long + delete short packed' '
     --	df_test refs/df-al-dsp --pack --add-del foo/bar foo
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents add short + delete long packed' '
     --	df_test refs/df-as-dlp --pack --add-del foo foo/bar
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents delete long packed + add short' '
     --	df_test refs/df-dlp-as --pack --del-add foo/bar foo
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents delete short packed + add long' '
     --	df_test refs/df-dsp-al --pack --del-add foo foo/bar
     --'
     --
     --# Try some combinations involving symbolic refs...
     --
     --test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short' '
     --	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents indirect add long + indirect delete short' '
     --	df_test refs/df-ial-ids --sym-add --sym-del --add-del foo/bar foo
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents indirect add short + indirect delete long' '
     --	df_test refs/df-ias-idl --sym-add --sym-del --add-del foo foo/bar
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents indirect delete long + indirect add short' '
     --	df_test refs/df-idl-ias --sym-add --sym-del --del-add foo/bar foo
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short packed' '
     --	df_test refs/df-ial-dsp --sym-add --pack --add-del foo/bar foo
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents indirect add long + indirect delete short packed' '
     --	df_test refs/df-ial-idsp --sym-add --sym-del --pack --add-del foo/bar foo
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents add long + indirect delete short packed' '
     --	df_test refs/df-al-idsp --sym-del --pack --add-del foo/bar foo
     --'
     --
     --test_expect_success REFFILES 'D/F conflict prevents indirect delete long packed + indirect add short' '
     --	df_test refs/df-idlp-ias --sym-add --sym-del --pack --del-add foo/bar foo
     --'
     --
     - # Test various errors when reading the old values of references...
     - 
     - test_expect_success 'missing old value blocks update' '
     + test_expect_success REFFILES 'D/F conflict prevents add long + delete short' '
     + 	df_test refs/df-al-ds --add-del foo/bar foo
     + '
      @@ t/t1404-update-ref-errors.sh: test_expect_success 'incorrect old value blocks indirect no-deref delete' '
       	test_cmp expected output.err
       '
  5:  c2af695f551 !  5:  42dc9948aa5 t1405: move reffiles specific tests to t0600
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    t1405: move reffiles specific tests to t0600
     +    t1405: move reffiles specific tests to t0601
      
     -    Move this test to t0600 with other reffiles specific tests since it is
     -    reffiles specific in that it looks into the loose refs directory for an
     -    assertion.
     +    Move this test to t0601 with other reffiles specific pack-refs tests
     +    since it is reffiles specific in that it looks into the loose refs
     +    directory for an assertion.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     - ## t/t0600-reffiles-backend.sh ##
     -@@ t/t0600-reffiles-backend.sh: test_expect_success 'setup' '
     - 	E=$(git rev-parse HEAD)
     + ## t/t0601-reffiles-pack-refs.sh ##
     +@@ t/t0601-reffiles-pack-refs.sh: test_expect_success 'prepare a trivial repository' '
     + 	HEAD=$(git rev-parse --verify HEAD)
       '
       
      +test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
     @@ t/t0600-reffiles-backend.sh: test_expect_success 'setup' '
      +	test -z "$N"
      +'
      +
     - test_expect_success 'empty directory should not fool rev-parse' '
     - 	prefix=refs/e-rev-parse &&
     - 	git update-ref $prefix/foo $C &&
     + SHA1=
     + 
     + test_expect_success 'see if git show-ref works as expected' '
      
       ## t/t1405-main-ref-store.sh ##
      @@ t/t1405-main-ref-store.sh: test_expect_success 'setup' '
  6:  69ea950cfea =  6:  98e40a024b9 t1406: move reffiles specific tests to t0600
  7:  ae71747871c =  7:  d93c9c410b9 t1410: move reffiles specific tests to t0600
  8:  9d105263695 !  8:  8327b12a313 t1415: move reffiles specific tests to t0600
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    t1415: move reffiles specific tests to t0600
     +    t1415: move reffiles specific tests to t0601
      
     -    Move this test into t0600 with other reffiles specific tests since it
     -    checks for individua loose refs and thus is specific to the reffiles
     -    backend.
     +    Move this test into t0601 with other reffiles pack-refs specific tests
     +    since it checks for individua loose refs and thus is specific to the
     +    reffiles backend.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     - ## t/t0600-reffiles-backend.sh ##
     -@@ t/t0600-reffiles-backend.sh: test_expect_success 'empty reflog' '
     - 	test_must_be_empty err
     + ## t/t0601-reffiles-pack-refs.sh ##
     +@@ t/t0601-reffiles-pack-refs.sh: test_expect_success SYMLINKS 'pack symlinked packed-refs' '
     + 	test "$(test_readlink .git/packed-refs)" = "my-deviant-packed-refs"
       '
       
      +# The 'packed-refs' file is stored directly in .git/. This means it is global
  9:  dcec7f10ab6 !  9:  891a3d057d2 t1503: move reffiles specific tests to t0600
     @@ Commit message
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## t/t0600-reffiles-backend.sh ##
     -@@ t/t0600-reffiles-backend.sh: test_expect_success 'refs/worktree must not be packed' '
     - 	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
     +@@ t/t0600-reffiles-backend.sh: test_expect_success 'empty reflog' '
     + 	test_must_be_empty err
       '
       
      +test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
 10:  56a9c8f20dd <  -:  ----------- t3903: move reffiles specific tests to t0600
  -:  ----------- > 10:  bfd5b403170 t3903: make drop stash test ref backend agnostic
 11:  39e69fde3d7 ! 11:  976be7efc89 t4202: move reffiles specific tests to t0600
     @@ Commit message
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## t/t0600-reffiles-backend.sh ##
     -@@ t/t0600-reffiles-backend.sh: test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
     - 	test_cmp expect actual
     +@@ t/t0600-reffiles-backend.sh: test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
     +        test_must_fail git rev-parse --verify broken
       '
       
      +test_expect_success 'log diagnoses bogus HEAD hash' '
 12:  316a20ed179 ! 12:  7329e87148a t5312: move reffiles specific tests to t0600
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    t5312: move reffiles specific tests to t0600
     +    t5312: move reffiles specific tests to t0601
      
     -    Move a few tests into t0600 since they specifically test the packed-refs
     +    Move a few tests into t0601 since they specifically test the packed-refs
          file and thus are specific to the reffiles backend.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     - ## t/t0600-reffiles-backend.sh ##
     -@@ t/t0600-reffiles-backend.sh: test_expect_success 'log diagnoses bogus HEAD symref' '
     - 	test_grep broken stderr
     + ## t/t0601-reffiles-pack-refs.sh ##
     +@@ t/t0601-reffiles-pack-refs.sh: test_expect_success 'refs/worktree must not be packed' '
     + 	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
       '
       
      +# we do not want to count on running pack-refs to
     @@ t/t0600-reffiles-backend.sh: test_expect_success 'log diagnoses bogus HEAD symre
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success  'pack-refs does not drop broken refs during deletion' '
     ++test_expect_success 'pack-refs does not drop broken refs during deletion' '
      +	git update-ref -d refs/heads/other &&
      +	git rev-parse refs/heads/main >actual &&
      +	test_cmp expect actual

-- 
gitgitgadget
