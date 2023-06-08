Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085C9C7EE23
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 19:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbjFHTWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFHTWI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 15:22:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83486359F
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 12:21:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568ab5c813eso13120267b3.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252089; x=1688844089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9eOcfxnU4aQXMr1gs+sYvRfkWGzVSr+DDramR6pAKhw=;
        b=K9+PhHOc+xzCl1LklpNxnG7B1qzH4lhOwOVal9aC3d1lPyqpbeH9uS23WFIcGXkfmI
         8U2VUu4UZotkjgHawDdtT+iLTSNiPzuY5BDaJwed9g7N8O6UlRts1phQAxr7DQ/B5ZNw
         HXnO9jjZ9/pYaIVhBUHCMAmcsfQJ89/yTJel/3hWLnNEiV9WQW/WiRJADHRwhPk3k9tp
         lgdMmIvIK26Ev6qzeYw9swYscOJUZ/UUp/8a+ctXt6WLP294fvpZxJQe4fa+WF6mlBaK
         70wwebpWH3Kqn9kdcQzmt9njNpReYYxKa5ajIm/11gcZMa+/sNX977uSjzJ+yUMiSV/o
         tm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252089; x=1688844089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eOcfxnU4aQXMr1gs+sYvRfkWGzVSr+DDramR6pAKhw=;
        b=C8i6fWX2uDkfCAzOetzOpo1e4zUMRH60jPzDH+Nbjl9dDeqtFjojTeZAWbLrHlW7Kv
         m8+1aVYkCn5D9NQpG6QV1LbmKG0vrzGFX2rJYJ/IeUtVfZEmgdbudmD8P6+J+FmYIpgV
         /TlTXChXtLEn4CVTKDkzbGMKEvrtEreDIOleccLFvVXVZKHkqZZid/PSh+uUaJdNeNUk
         dPsRdsWDCadXIrZEKu7U4JR+V1Bbcx2/l/8Ige57j9tkVDZIvoZAzged0uF/VFk/Wf/n
         pPuwFP5xJrNGGPDZOxV5krewmQKvTdXVBmMWeOdTZW15HHRN3DSA+aZzeUGgrhJ4uixl
         gf3w==
X-Gm-Message-State: AC+VfDwDEFU7c/TIBWClOqm4niTHJR5gfRWVpWDFHcr2X/fzW4w99d6g
        xskIbO45yvsRqyANOtZGAgxW4BQKfhLZbe/0vr9UrXsN7PoxauVKgtc2iuA/c4sXGFfHrYxtqbG
        qqNltcDH9bBzHSWXRU1J9zzdHELCYvkXMnG8XrxUZOKUa1QGSz9aogXJdP91f+Zt0w1njK/d0Jj
        s2
X-Google-Smtp-Source: ACHHUZ5Zwhp5u5JbMBt0bFchbFWP505EYm97N+cuUIFZegtM3nSGHVgo6g76p+mVs+IcPLlPGHKLn+6Jj1tt8ttZ0iSz
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:bde7:a867:45f9:3528])
 (user=jonathantanmy job=sendgmr) by 2002:a81:400a:0:b0:55d:ea61:d8e9 with
 SMTP id l10-20020a81400a000000b0055dea61d8e9mr380518ywn.7.1686252089082; Thu,
 08 Jun 2023 12:21:29 -0700 (PDT)
Date:   Thu,  8 Jun 2023 12:21:21 -0700
In-Reply-To: <cover.1684790529.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <cover.1686251688.git.jonathantanmy@google.com>
Subject: [PATCH v3 0/4] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's an updated version with changes only in the tests:
 - resilience against unsigned-by-default (a "skip" will be shown)
 - for systems that have different quoting behavior, the tests
   will be skipped (see patch 2 for more information)

Some of the test changes may seem a bit of a hack, so if you have
a better way of doing things, please let me know.

I've also included a change to the file format specification. To
reviewers, if you generally agree that we need a version 2 but are still
unsure about how we should migrate, consider saying so and then perhaps
we can merge the first patch while the rest remain under review. This
will give other projects, like JGit, more certainty as to the direction
that the Git project wants to take.

Jonathan Tan (4):
  gitformat-commit-graph: describe version 2 of BDAT
  t4216: test changed path filters with high bit paths
  repo-settings: introduce commitgraph.changedPathsVersion
  commit-graph: new filter ver. that fixes murmur3

 Documentation/config/commitgraph.txt     | 16 ++++-
 Documentation/gitformat-commit-graph.txt |  9 ++-
 bloom.c                                  | 65 +++++++++++++++++-
 bloom.h                                  |  8 ++-
 commit-graph.c                           | 29 ++++++--
 oss-fuzz/fuzz-commit-graph.c             |  2 +-
 repo-settings.c                          |  6 +-
 repository.h                             |  2 +-
 t/helper/test-bloom.c                    |  9 ++-
 t/t0095-bloom.sh                         |  8 +++
 t/t4216-log-bloom.sh                     | 86 ++++++++++++++++++++++++
 11 files changed, 219 insertions(+), 21 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  d4b63945f6 gitformat-commit-graph: describe version 2 of BDAT
1:  c587eb3470 ! 2:  aa4535776e t4216: test changed path filters with high bit paths
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
     +# chosen to be the same under all Unicode normalization forms
     +CENT=$(printf "\xc2\xa2")
     +
    -+test_expect_success 'set up repo with high bit path, version 1 changed-path' '
    ++# Some systems (in particular, Linux on the CI running on GitHub at the time of
    ++# writing) store into CENT a literal backslash, then "x", and so on (instead of
    ++# the high-bit characters needed). In these systems, do not run the following
    ++# tests.
    ++if test "$(printf $CENT | perl -0777 -ne 'no utf8; print ord($_)')" = "194"
    ++then
    ++	test_set_prereq HIGH_BIT
    ++fi
    ++
    ++test_expect_success HIGH_BIT 'set up repo with high bit path, version 1 changed-path' '
     +	git init highbit1 &&
     +	test_commit -C highbit1 c1 "$CENT" &&
     +	git -C highbit1 commit-graph write --reachable --changed-paths
     +'
     +
    -+test_expect_success 'check value of version 1 changed-path' '
    ++test_expect_success HIGH_BIT 'setup check value of version 1 changed-path' '
     +	(cd highbit1 &&
     +		printf "52a9" >expect &&
    -+		get_first_changed_path_filter >actual &&
    -+		test_cmp expect actual)
    ++		get_first_changed_path_filter >actual)
    ++'
    ++
    ++# expect will not match actual if int is unsigned by default. Write the test
    ++# in this way, so that a user running this test script can still see if the two
    ++# files match. (It will appear as an ordinary success if they match, and a skip
    ++# if not.)
    ++if test_cmp highbit1/expect highbit1/actual
    ++then
    ++	test_set_prereq SIGNED_INT_BY_DEFAULT
    ++fi
    ++test_expect_success SIGNED_INT_BY_DEFAULT 'check value of version 1 changed-path' '
    ++	# Only the prereq matters for this test.
    ++	true
     +'
     +
    -+test_expect_success 'version 1 changed-path used when version 1 requested' '
    ++test_expect_success HIGH_BIT 'version 1 changed-path used when version 1 requested' '
     +	(cd highbit1 &&
     +		test_bloom_filters_used "-- $CENT")
     +'
2:  d0e5dd20dc = 3:  d6982268a4 repo-settings: introduce commitgraph.changedPathsVersion
3:  eb19f8a35b ! 4:  e879483c42 commit-graph: new filter ver. that fixes murmur3
    @@ t/t0095-bloom.sh: test_expect_success 'compute unseeded murmur3 hash for test st
      	Hashes:0x5615800c|0x5b966560|0x61174ab4|0x66983008|0x6c19155c|0x7199fab0|0x771ae004|
     
      ## t/t4216-log-bloom.sh ##
    -@@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when version 1 requested' '
    +@@ t/t4216-log-bloom.sh: test_expect_success HIGH_BIT 'version 1 changed-path used when version 1 request
      		test_bloom_filters_used "-- $CENT")
      '
      
    -+test_expect_success 'version 1 changed-path not used when version 2 requested' '
    ++test_expect_success HIGH_BIT 'version 1 changed-path not used when version 2 requested' '
     +	(cd highbit1 &&
     +		git config --add commitgraph.changedPathsVersion 2 &&
     +		test_bloom_filters_not_used "-- $CENT")
     +'
     +
    -+test_expect_success 'set up repo with high bit path, version 2 changed-path' '
    ++test_expect_success HIGH_BIT 'set up repo with high bit path, version 2 changed-path' '
     +	git init highbit2 &&
     +	git -C highbit2 config --add commitgraph.changedPathsVersion 2 &&
     +	test_commit -C highbit2 c2 "$CENT" &&
     +	git -C highbit2 commit-graph write --reachable --changed-paths
     +'
     +
    -+test_expect_success 'check value of version 2 changed-path' '
    ++test_expect_success HIGH_BIT 'check value of version 2 changed-path' '
     +	(cd highbit2 &&
     +		printf "c01f" >expect &&
     +		get_first_changed_path_filter >actual &&
     +		test_cmp expect actual)
     +'
     +
    -+test_expect_success 'version 2 changed-path used when version 2 requested' '
    ++test_expect_success HIGH_BIT 'version 2 changed-path used when version 2 requested' '
     +	(cd highbit2 &&
     +		test_bloom_filters_used "-- $CENT")
     +'
     +
    -+test_expect_success 'version 2 changed-path not used when version 1 requested' '
    ++test_expect_success HIGH_BIT 'version 2 changed-path not used when version 1 requested' '
     +	(cd highbit2 &&
     +		git config --add commitgraph.changedPathsVersion 1 &&
     +		test_bloom_filters_not_used "-- $CENT")
-- 
2.41.0.162.gfafddb0af9-goog

