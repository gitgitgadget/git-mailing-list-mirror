Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B72C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 14:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiKIOQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiKIOQe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 09:16:34 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574A4E1E
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 06:16:33 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p16so10910559wmc.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 06:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nveuKvKrOpNIII5Fs4N8005aNBsRx9p1QcKTgzbTSjo=;
        b=QMtguuxXbfTf7pLLbq135/oB8+0HgyiwlTv13rJNrekrdaEepEhd94ifw3/cGKDzTG
         Al0wpvWgfWW0MWxsngrruDSkATJRcQHIe8CUV58ybu3T5wUICFSzf/UNq6TcCe1wW5bn
         expJUnB+obM0560YWP6/3CZt+Dr/TjuiMUbVlBZvdWSXzUG3dtL3bQUC9SosHonFVc0j
         C7fl48qxG/5UzBjTqCeg036uYGUsXkocg4IWFimiZunzZHBXvJ5/1aTf+XN9DfirUGRV
         qm+BFACsuysMPcJNJbZehw/J8yZEC8uNzQvzFzDTnAl0AWMbbflgXKn93Uf6BRCE+neC
         3Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nveuKvKrOpNIII5Fs4N8005aNBsRx9p1QcKTgzbTSjo=;
        b=DwDE0ECmN7Oak8toysfSSSWm5qZwJRQgohS/f8SvZs8o5l+AmTCn7AGuInNnmDgtu0
         PcazsIoINwOq3lE99i7eFKIPc/slY70ywQF2eBaKSLq1tTK6nbTWoJzIIdQlQb0YhA/M
         yNDSNQdm8whxARcpsak5nUuhOimZ0GlZsKfFM0ghuNyb7qUzr1LXulRkELj3Jsm/qEjn
         9QgBgjF/HsbVAvrtlxwJTOYdtt7a7rjoIiEGGKf2TZNbl+o5cwkZ5VRbleAzXoiOKLae
         EzslSOdQreTpT6H1k85LxH286rPuo618TQcoiGsVauz2dhBHcct10+3wrxMSuNsQHkev
         qhJg==
X-Gm-Message-State: ACrzQf1tCdDxLT+ZiwFr5vNMsxI3P9D64cnRWitj58M69TIN9oqWw9Sm
        RMcWXI4wdETOL83/RyxpiZ7aWgY8T48=
X-Google-Smtp-Source: AMsMyM7iasIYHSMnimBlYIUES99vECXjJ8xu/dITo0tSyEPXO4/CVviGvPXCZoHMKBQqPEKKP1a1lg==
X-Received: by 2002:a05:600c:3511:b0:3c6:bf7a:8658 with SMTP id h17-20020a05600c351100b003c6bf7a8658mr880342wmq.17.1668003391456;
        Wed, 09 Nov 2022 06:16:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18-20020a056000125200b0023677fd2657sm12856991wrx.52.2022.11.09.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:16:29 -0800 (PST)
Message-Id: <pull.1389.v2.git.1668003388.gitgitgadget@gmail.com>
In-Reply-To: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 14:16:25 +0000
Subject: [PATCH v2 0/3] a few config integer parsing fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some issues I noticed when reading the integer parsing
code in config.c

 * git_parse_unsigned() does not reject negative values
 * git_parse_[un]signed() accept a units specifier without any digits
 * git_parse_signed() has in integer overflow when parsing MAXINT_MIN

Thanks to everyone who commented on V1. I've updated patches 1 & 2 to
include the tests suggested by peff and added tests for OPT_MAGNITUDE() as
that uses the same code path.

Cover Letter for V1:

Ideally we'd have a test tool to unit test functions like this, I haven't
found time to write that yet. cc'ing René for patch 3 as he was the last
person to touch that code.

Phillip Wood (3):
  git_parse_unsigned: reject negative values
  config: require at least one digit when parsing numbers
  git_parse_signed(): avoid integer overflow

 config.c                 | 24 +++++++++++++++++++-----
 t/t0040-parse-options.sh | 12 ++++++++++++
 t/t1050-large.sh         |  6 ++++++
 t/t1300-config.sh        |  6 ++++++
 4 files changed, 43 insertions(+), 5 deletions(-)


base-commit: e85701b4af5b7c2a9f3a1b07858703318dce365d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1389%2Fphillipwood%2Fconfig-integer-parsing-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1389/phillipwood/config-integer-parsing-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1389

Range-diff vs v1:

 1:  9c8440e5e82 ! 1:  d1ac79909b9 git_parse_unsigned: reject negative values
     @@ Commit message
          string that contains '-' as we do in strtoul_ui(). I've chosen to treat
          negative numbers as invalid input and set errno to EINVAL rather than
          ERANGE one the basis that they are never acceptable if we're looking for
     -    a unsigned integer.
     +    a unsigned integer. This is also consistent with the existing behavior
     +    of rejecting "1–2" with EINVAL.
      
     +    As we do not have unit tests for this function it is tested indirectly
     +    by checking that negative values of reject for core.bigFileThreshold are
     +    rejected. As this function is also used by OPT_MAGNITUDE() a test is
     +    added to check that rejects negative values too.
     +
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## config.c ##
     @@ config.c: static int git_parse_unsigned(const char *value, uintmax_t *ret, uintm
       		errno = 0;
       		val = strtoumax(value, &end, 0);
       		if (errno == ERANGE)
     +
     + ## t/t0040-parse-options.sh ##
     +@@ t/t0040-parse-options.sh: test_expect_success 'subcommands are incompatible with KEEP_DASHDASH unless in c
     + 	grep ^BUG err
     + '
     + 
     ++test_expect_success 'negative magnitude' '
     ++	test_must_fail test-tool parse-options --magnitude -1 >out 2>err &&
     ++	grep "non-negative integer" err &&
     ++	test_must_be_empty out
     ++'
     + test_done
     +
     + ## t/t1050-large.sh ##
     +@@ t/t1050-large.sh: test_description='adding and checking out large blobs'
     + 
     + . ./test-lib.sh
     + 
     ++test_expect_success 'core.bigFileThreshold must be non-negative' '
     ++	test_must_fail git -c core.bigFileThreshold=-1 rev-parse >out 2>err &&
     ++	grep "bad numeric config value" err &&
     ++	test_must_be_empty out
     ++'
     ++
     + test_expect_success setup '
     + 	# clone does not allow us to pass core.bigfilethreshold to
     + 	# new repos, so set core.bigfilethreshold globally
 2:  cd753602e48 ! 2:  54f2ebefa0d config: require at least one digit when parsing numbers
     @@ Commit message
          an error and instead return a value of zero if the input string is a
          valid units factor without any digits (e.g "k").
      
     +    Tests are added to check that 'git config --int' and OPT_MAGNITUDE()
     +    reject a units specifier without a leading digit.
     +
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## config.c ##
     @@ config.c: static int git_parse_unsigned(const char *value, uintmax_t *ret, uintm
       		factor = get_unit_factor(end);
       		if (!factor) {
       			errno = EINVAL;
     +
     + ## t/t0040-parse-options.sh ##
     +@@ t/t0040-parse-options.sh: test_expect_success 'negative magnitude' '
     + 	grep "non-negative integer" err &&
     + 	test_must_be_empty out
     + '
     ++
     ++test_expect_success 'magnitude with units but no numbers' '
     ++	test_must_fail test-tool parse-options --magnitude m >out 2>err &&
     ++	grep "non-negative integer" err &&
     ++	test_must_be_empty out
     ++'
     ++
     + test_done
     +
     + ## t/t1300-config.sh ##
     +@@ t/t1300-config.sh: test_expect_success '--type rejects unknown specifiers' '
     + 	test_i18ngrep "unrecognized --type argument" error
     + '
     + 
     ++test_expect_success '--type=int requires at least one digit' '
     ++	test_must_fail git config --type int --default m some.key >out 2>error &&
     ++	grep "bad numeric config value" error &&
     ++	test_must_be_empty out
     ++'
     ++
     + test_expect_success '--replace-all does not invent newlines' '
     + 	q_to_tab >.git/config <<-\EOF &&
     + 	[abc]key
 3:  f058f391c38 = 3:  673e6f1ab93 git_parse_signed(): avoid integer overflow

-- 
gitgitgadget
