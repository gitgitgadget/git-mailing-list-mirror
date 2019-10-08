Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F861F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 09:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfJHJWu (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 05:22:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43934 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfJHJWu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 05:22:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so2626936pgl.10
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+p4ab3OCqNFVxDO7dZsf+tlwvDdtHpSPyXLHgP0jF6E=;
        b=A54Fk4zIVLfeRPtDHX+tGKc+dPwi68HUK2IjV5QkUnAvZ9thVJUtRBjqGUl2PUWC9A
         I3Z/4f80s0CCz0nMvYdQScrQdtolzHmTNWTtGlCUDQJ95SE/vVQqYtb3H6PFQPEE3Udr
         WoL9BTU7/etgVsNvUgkRIr1ZDkMpH3fd+GAjL/s8AHd2bln3sVha28msai74ZlmIDUFi
         D+nXu4hq40q4k4ayBkiFTofjhNVlr3SCnBASTD1fBAmpMBGumOyzX9ViAITVNeuTlKSU
         vLIaN0Q8jcw1iLiB9gFcEVJldVx1WywGDszhvlnDsjmJG0+H7b6TBGZ2TwKsn0MaBsY8
         BYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+p4ab3OCqNFVxDO7dZsf+tlwvDdtHpSPyXLHgP0jF6E=;
        b=KQE3OfGJdRcL1lePXCZoP98dbkuhTMUytHtsY+XIH09I5mp7K0aLY/W2syWRlhi2FT
         dvMpu2PvJqQXNsh1su98a7+aWNjm4/qt7udBhf6y10l/zhcVE1MEd9Zv13pVo5bXyBEw
         fa81jFKRNTuwgZcQNeEfPEKwRqnOwK2UzPajm30wJb4MM4dfliT1er7a1VU2CaKoHYAJ
         Ftdzo4ImPAC2WnCWD4CcEWSXekoEsI0J4Ev6Z9uv6BMfopWT/z0slM+/C0ResATAyVwk
         1gSygaEfOl5IoNP9ZLg1s7avrATTzbFR7SY8yUGsO8ftETVMsm/NvStfjDDid37ziTjW
         +vEw==
X-Gm-Message-State: APjAAAU0JacULDaNGjufNHn+GlFzLdoDiN4r3l2n/i7093SuK+7eRnS0
        9EppNjg2xDaxCTQZrWUvrh0/pN8s
X-Google-Smtp-Source: APXvYqx83hqRDSCJCH/5TspH4lll6aPrnoTN8gqRcSR31HXZNuNgKtKYYGKa1+GzpAc2WDKYPnCJGA==
X-Received: by 2002:a17:90a:37d1:: with SMTP id v75mr4677588pjb.33.1570526569151;
        Tue, 08 Oct 2019 02:22:49 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id q29sm21776038pgc.88.2019.10.08.02.22.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 02:22:48 -0700 (PDT)
Date:   Tue, 8 Oct 2019 02:22:47 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2] t0000: cover GIT_SKIP_TESTS blindspots
Message-ID: <b5f3af8a630aec2d8bffe8e76f1d113171eda250.1570526491.git.liu.denton@gmail.com>
References: <08273a0d0deae610b93d7f5eb28b0df5f978bf20.1569996425.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08273a0d0deae610b93d7f5eb28b0df5f978bf20.1569996425.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the tests for GIT_SKIP_TESTS do not cover the situation where
we skip an entire test suite. The tests also do not cover the situation
where we have GIT_SKIP_TESTS defined but the test suite does not match.

Add two test cases so we cover this blindspot.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Changes since v1:

* Added another test case to cover the blindspot where GIT_SKIP_TESTS is
  defined but the test suite does not match.

Range-diff against v1:
1:  08273a0d0d ! 1:  b5f3af8a63 t0000: cover GIT_SKIP_TESTS blindspot
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    t0000: cover GIT_SKIP_TESTS blindspot
    +    t0000: cover GIT_SKIP_TESTS blindspots
     
         Currently, the tests for GIT_SKIP_TESTS do not cover the situation where
    -    we skip an entire test suite. Add a test case so we cover this
    -    blindspot.
    +    we skip an entire test suite. The tests also do not cover the situation
    +    where we have GIT_SKIP_TESTS defined but the test suite does not match.
    +
    +    Add two test cases so we cover this blindspot.
     
      ## t/t0000-basic.sh ##
     @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS sh pattern' "
    @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS sh pattern' "
     +		EOF
     +	)
     +"
    ++
    ++test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' "
    ++	(
    ++		GIT_SKIP_TESTS='notgit' && export GIT_SKIP_TESTS &&
    ++		run_sub_test_lib_test git-skip-tests-unmatched-suite \
    ++			'GIT_SKIP_TESTS does not skip unmatched suite' <<-\\EOF &&
    ++		for i in 1 2 3
    ++		do
    ++			test_expect_success \"passing test #\$i\" 'true'
    ++		done
    ++		test_done
    ++		EOF
    ++		check_sub_test_lib_test git-skip-tests-unmatched-suite <<-\\EOF
    ++		> ok 1 - passing test #1
    ++		> ok 2 - passing test #2
    ++		> ok 3 - passing test #3
    ++		> # passed all 3 test(s)
    ++		> 1..3
    ++		EOF
    ++	)
    ++"
     +
      test_expect_success '--run basic' "
      	run_sub_test_lib_test run-basic \

 t/t0000-basic.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4c01f60dd3..4d3f7ba295 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -391,6 +391,44 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' "
 	)
 "
 
+test_expect_success 'GIT_SKIP_TESTS entire suite' "
+	(
+		GIT_SKIP_TESTS='git' && export GIT_SKIP_TESTS &&
+		run_sub_test_lib_test git-skip-tests-entire-suite \
+			'GIT_SKIP_TESTS entire suite' <<-\\EOF &&
+		for i in 1 2 3
+		do
+			test_expect_success \"passing test #\$i\" 'true'
+		done
+		test_done
+		EOF
+		check_sub_test_lib_test git-skip-tests-entire-suite <<-\\EOF
+		> 1..0 # SKIP skip all tests in git
+		EOF
+	)
+"
+
+test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' "
+	(
+		GIT_SKIP_TESTS='notgit' && export GIT_SKIP_TESTS &&
+		run_sub_test_lib_test git-skip-tests-unmatched-suite \
+			'GIT_SKIP_TESTS does not skip unmatched suite' <<-\\EOF &&
+		for i in 1 2 3
+		do
+			test_expect_success \"passing test #\$i\" 'true'
+		done
+		test_done
+		EOF
+		check_sub_test_lib_test git-skip-tests-unmatched-suite <<-\\EOF
+		> ok 1 - passing test #1
+		> ok 2 - passing test #2
+		> ok 3 - passing test #3
+		> # passed all 3 test(s)
+		> 1..3
+		EOF
+	)
+"
+
 test_expect_success '--run basic' "
 	run_sub_test_lib_test run-basic \
 		'--run basic' --run='1 3 5' <<-\\EOF &&
-- 
2.23.0.248.g3a9dd8fb08

