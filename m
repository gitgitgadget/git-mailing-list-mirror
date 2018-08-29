Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A57F1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeH2EvS (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:51:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37186 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726759AbeH2EvS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:51:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 601A46046C;
        Wed, 29 Aug 2018 00:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504217;
        bh=ZvwtwdrJLtRtxpiUN348VvqkWXE/OivUKi6lA4k0waU=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rMK6jz0TcrzEMIXLNGTo1246xj7fx1eH7xoAdorNUjKfa3E/a+77LZr/fWvPBsjEy
         UZ6ji1SSeO3OPSihMaMD0IPGxFJ48mScikA3YmFdsXcemaWMCutKIwj/SNCjp0sG9j
         iExUtk66SrEYFKMMzhMOZunTFlQ21EsBWkpSzXSpttz9vkUA74zPP0mFaaQJmTFY6z
         9DiUNQIuD/xOgaqUK/J2Nwztia2PIvUSgt1sBb1q1YqqBPLBsQ/8TklMNDC+ESCb6Y
         Q5W/Ncpd1aWuAekHTmDKFyIe9olq9cixY86Zt14QLVKEJQklmrT6EsN1EUZ1AeWjqO
         iiUTeaviAlMEzvcVhdEkIU0cx4NN++jPnXbmpvxMFexjrKBGNDWUsle7fqBZO6+yxB
         vKvDPUiBYfAGu8KOXEtA6iqbWC5MhajVQFXVpYQpQMw1aFJYDfCW3meMt3SevNUHTc
         YZ4irno3mpL7Ol5zhfP0mvm2l+5K1OL9P/wEDP4/58iExjlXDca
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 00/11] Hash-independent tests (part 3)
Date:   Wed, 29 Aug 2018 00:56:31 +0000
Message-Id: <20180829005642.980617-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the next in the series of improvements to make tests
hash-independent.

A range-diff is below.

Changes from v2:
* Fix a typo in "zero_2".
* Provide better matching of expected output.
* Add and use test_oid_init instead of filename-based test_oid_cache.
* Add test_set_hash.
* Provide better error checking in newly added test functions.
* Move t0000 constants into the test, removing the separate file.
* Switch to using a differently named temporary file in t0027.

Changes from v1:
* Adopt pure shell approach for helper.
* Add tests for the helpers.
* Explicitly refer to SHA-256 now that we know it will be NewHash.
* Updated t0000 to remove SHA1 prerequisite.
* Change name of helper from test_translate to test_oid.
* Add helper to cache information in the shell.
* Simplified lookup of HEAD in t0002.
* Switched to using existing helper function in t0027.
* Simplified handling of IDs in t0064.

brian m. carlson (11):
  t: add tool to translate hash-related values
  t0000: use hash translation table
  t0000: update tests for SHA-256
  t0002: abstract away SHA-1 specific constants
  t0027: make hash size independent
  t0064: make hash size independent
  t1006: make hash size independent
  t1400: switch hard-coded object ID to variable
  t1405: make hash size independent
  t1406: make hash-size independent
  t1407: make hash size independent

 t/oid-info/hash-info           |   8 ++
 t/oid-info/oid                 |  29 +++++
 t/t0000-basic.sh               | 211 ++++++++++++++++++++++-----------
 t/t0002-gitfile.sh             |  27 +++--
 t/t0027-auto-crlf.sh           |   6 +-
 t/t0064-sha1-array.sh          |  49 ++++----
 t/t1006-cat-file.sh            |   6 +-
 t/t1400-update-ref.sh          |   2 +-
 t/t1405-main-ref-store.sh      |   4 +-
 t/t1406-submodule-ref-store.sh |   6 +-
 t/t1407-worktree-ref-store.sh  |   4 +-
 t/test-lib-functions.sh        |  44 +++++++
 12 files changed, 283 insertions(+), 113 deletions(-)
 create mode 100644 t/oid-info/hash-info
 create mode 100644 t/oid-info/oid

range-diff:

1:  fb66b1ff7d !  1:  a897533a90 t: add tool to translate hash-related values
   @@ -3,19 +3,19 @@
        t: add tool to translate hash-related values
    
        Add a test function helper, test_oid, that produces output that varies
   -    depending on the hash in use.  Add an additional helper, test_oid_cache,
   -    that can be used to load data for test_oid, either through a list of
   -    filenames or on standard input.  Check that these functions work in
   +    depending on the hash in use.  Add two additional helpers,
   +    test_oid_cache, which can be used to load data for test_oid from
   +    standard input, and test_oid_init, which can be used to load certain
   +    fixed values from lookup charts.  Check that these functions work in
        t0000, as the rest of the testsuite will soon come to depend on them.
    
        Implement two basic lookup charts, one for common invalid or synthesized
        object IDs, and one for various facts about the hash function in use.
   -    Individual tests can use their own translation files to map object IDs
   -    or other data that needs to vary across hash functions.  Provide
   -    versions for both SHA-1 and SHA-256.
   +    Provide versions for both SHA-1 and SHA-256.
    
   -    Note that due to the implementation used, keys cannot be anything but
   -    shell identifier characters.
   +    Note that due to the implementation used, names used for lookup can
   +    currently consist only of shell identifier characters.  If this is a
   +    problem in the future, we can hash the names before use.
    
        Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
        Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
   @@ -56,7 +56,7 @@
    +007	sha256:0000000000000000000000000000000000000000000000000000000000000007
    +# All zeros or Fs missing one or two hex segments.
    +zero_1		sha1:000000000000000000000000000000000000000
   -+zero_2		sha256:000000000000000000000000000000000000000000000000000000000000000
   ++zero_1		sha256:000000000000000000000000000000000000000000000000000000000000000
    +zero_2		sha1:00000000000000000000000000000000000000
    +zero_2		sha256:00000000000000000000000000000000000000000000000000000000000000
    +ff_1		sha1:fffffffffffffffffffffffffffffffffffffff
   @@ -76,33 +76,39 @@
       EOF
     "
     
   -+test_oid_cache hash-info oid
   ++test_oid_init
    +
   -+test_expect_success 'test_oid_info provides sane info by default' '
   -+	test_oid zero &&
   ++test_expect_success 'test_oid provides sane info by default' '
    +	test_oid zero >actual &&
   -+	grep "00*" actual &&
   -+	test "$(test_oid hexsz)" -eq $(wc -c <actual) &&
   -+	test $(( $(test_oid rawsz) * 2)) -eq "$(test_oid hexsz)"
   ++	grep "^00*$" actual &&
   ++	rawsz="$(test_oid rawsz)" &&
   ++	hexsz="$(test_oid hexsz)" &&
   ++	test "$hexsz" -eq $(wc -c <actual) &&
   ++	test $(( $rawsz * 2)) -eq "$hexsz"
    +'
    +
   -+test_expect_success 'test_oid_info can look up data for SHA-1' '
   -+	test_detect_hash sha1 &&
   -+	test_oid zero >actual &&
   -+	grep "00*" actual &&
   -+	test $(wc -c <actual) -eq 40 &&
   -+	test "$(test_oid rawsz)" -eq 20 &&
   -+	test "$(test_oid hexsz)" -eq 40
   -+'
   -+
   -+test_expect_success 'test_oid_info can look up data for SHA-256' '
   ++test_expect_success 'test_oid can look up data for SHA-1' '
    +	test_when_finished "test_detect_hash" &&
   -+	test_detect_hash sha256 &&
   ++	test_set_hash sha1 &&
    +	test_oid zero >actual &&
   -+	grep "00*" actual &&
   ++	grep "^00*$" actual &&
   ++	rawsz="$(test_oid rawsz)" &&
   ++	hexsz="$(test_oid hexsz)" &&
   ++	test $(wc -c <actual) -eq 40 &&
   ++	test "$rawsz" -eq 20 &&
   ++	test "$hexsz" -eq 40
   ++'
   ++
   ++test_expect_success 'test_oid can look up data for SHA-256' '
   ++	test_when_finished "test_detect_hash" &&
   ++	test_set_hash sha256 &&
   ++	test_oid zero >actual &&
   ++	grep "^00*$" actual &&
   ++	rawsz="$(test_oid rawsz)" &&
   ++	hexsz="$(test_oid hexsz)" &&
    +	test $(wc -c <actual) -eq 64 &&
   -+	test "$(test_oid rawsz)" -eq 32 &&
   -+	test "$(test_oid hexsz)" -eq 64
   ++	test "$rawsz" -eq 32 &&
   ++	test "$hexsz" -eq 64
    +'
    +
     ################################################################
   @@ -117,38 +123,46 @@
       '
     }
    +
   ++test_set_hash () {
   ++	test_hash_algo="$1"
   ++}
   ++
    +test_detect_hash () {
   -+	if test -n "$1"
   -+	then
   -+		test_hash_algo="$1"
   -+	else
   -+		test_hash_algo='sha1'
   -+	fi
   ++	test_hash_algo='sha1'
   ++}
   ++
   ++test_oid_init () {
   ++	test_oid_cache <"$TEST_DIRECTORY/oid-info/hash-info" &&
   ++	test_oid_cache <"$TEST_DIRECTORY/oid-info/oid"
    +}
    +
    +test_oid_cache () {
    +	test -n "$test_hash_algo" || test_detect_hash
   -+	if test -n "$1"
   -+	then
   -+		while test -n "$1"
   -+		do
   -+			test_oid_cache <"$TEST_DIRECTORY/oid-info/$1"
   -+			shift
   -+		done
   -+		return $?
   -+	fi
    +	while read _tag _rest
    +	do
   -+		case $_tag in \#*)
   ++		case $_tag in
   ++		\#*)
   ++			continue;;
   ++		?*)
   ++			# non-empty
   ++			;;
   ++		*)
   ++			# blank line
    +			continue;;
   -+		esac
    +
   -+		_k="${_rest%:*}"
   -+		_v="${_rest#*:}"
   -+		eval "test_oid_${_k}_$_tag=\"$_v\""
   ++		esac &&
   ++
   ++		_k="${_rest%:*}" &&
   ++		_v="${_rest#*:}" &&
   ++		{ echo "$_k" | egrep '^[a-z0-9]+$' >/dev/null ||
   ++			error 'bug in the test script: bad hash algorithm'; } &&
   ++		eval "test_oid_${_k}_$_tag=\"\$_v\"" || return 1
    +	done
    +}
    +
    +test_oid () {
   -+	eval "printf '%s' \"\${test_oid_${test_hash_algo}_$1}\""
   ++	eval "
   ++		test -n \"\${test_oid_${test_hash_algo}_$1+set}\" &&
   ++		printf '%s' \"\${test_oid_${test_hash_algo}_$1}\"
   ++	"
    +}
2:  7b87aac814 =  2:  d63dc976f4 t0000: use hash translation table
3:  39464fb0cc !  3:  9e55529efd t0000: update tests for SHA-256
   @@ -16,11 +16,14 @@
    
        Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    
   -diff --git a/t/oid-info/t0000 b/t/oid-info/t0000
   -new file mode 100644
   ---- /dev/null
   -+++ b/t/oid-info/t0000
   +diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
   +--- a/t/t0000-basic.sh
   ++++ b/t/t0000-basic.sh
    @@
   + ################################################################
   + # Basics of the basics
   + 
   ++test_oid_cache <<\EOF
    +path0f sha1:f87290f8eb2cbbea7857214459a0739927eab154
    +path0f sha256:638106af7c38be056f3212cbd7ac65bc1bac74f420ca5a436ff006a9d025d17d
    +
   @@ -59,15 +62,7 @@
    +
    +simpletree sha1:7bb943559a305bdd6bdee2cef6e5df2413c3d30a
    +simpletree sha256:1710c07a6c86f9a3c7376364df04c47ee39e5a5e221fcdd84b743bc9bb7e2bc5
   -
   -diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
   ---- a/t/t0000-basic.sh
   -+++ b/t/t0000-basic.sh
   -@@
   - ################################################################
   - # Basics of the basics
   - 
   -+test_oid_cache t0000
   ++EOF
    +
     # updating a new file without --add should fail.
     test_expect_success 'git update-index without --add should fail adding' '
   @@ -79,8 +74,7 @@
    -test_expect_success SHA1 'validate object ID of a known tree' '
    -	test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
    +test_expect_success 'validate object ID of a known tree' '
   -+echo $tree &&
   -+	test "$tree" = $(test_oid simpletree)
   ++	test "$tree" = "$(test_oid simpletree)"
         '
     
     # Removing paths.
   @@ -109,10 +103,8 @@
    +	100644 $(test_oid subp3f) 0	path3/subp3/file3
    +	120000 $(test_oid subp3s) 0	path3/subp3/file3sym
       EOF
   -+	cat expected &&
       test_cmp expected current
     '
   - 
    @@
       tree=$(git write-tree)
     '
   @@ -120,7 +112,7 @@
    -test_expect_success SHA1 'validate object ID for a known tree' '
    -	test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b
    +test_expect_success 'validate object ID for a known tree' '
   -+	test "$tree" = $(test_oid root)
   ++	test "$tree" = "$(test_oid root)"
     '
     
     test_expect_success 'showing tree with git ls-tree' '
4:  27fdff34e3 !  4:  4d5b8d4025 t0002: abstract away SHA-1 specific constants
   @@ -28,8 +28,10 @@
       test_cmp expected actual
     '
    @@
   + 		cd enter_repo &&
           git worktree add  ../foo refs/tags/foo
       ) &&
   ++	head=$(git -C enter_repo rev-parse HEAD) &&
       git ls-remote foo >actual &&
    -	cat >expected <<-\EOF &&
    -	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
   @@ -44,6 +46,7 @@
     '
     
     test_expect_success 'enter_repo strict mode' '
   ++	head=$(git -C enter_repo rev-parse HEAD) &&
       git ls-remote --upload-pack="git upload-pack --strict" foo/.git >actual &&
    -	cat >expected <<-\EOF &&
    -	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
5:  bd31663386 <  -:  ---------- t0027: make hash size independent
-:  ---------- >  5:  6037c4d10a t0027: make hash size independent
6:  5d638b82ad =  6:  dfad561965 t0064: make hash size independent
7:  e147833d05 !  7:  8a860a7492 t1006: make hash size independent
   @@ -15,7 +15,7 @@
       test_cmp expect actual
     '
     
   -+test_oid_cache hash-info
   ++test_oid_init
    +
     tree_sha1=$(git write-tree)
    -tree_size=33
8:  78529a19b2 =  8:  1baaf8374a t1400: switch hard-coded object ID to variable
9:  a3c4726386 =  9:  232c043ed7 t1405: make hash size independent
10:  e35b54a199 = 10:  9d0207bc52 t1406: make hash-size independent
11:  2d4a478d0e = 11:  d292c6311f t1407: make hash size independent

