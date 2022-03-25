Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153B7C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiCYT3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiCYT25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:28:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363CA1EDA13
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:02:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so12039884wrh.11
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KUXqqEbtYou4QA8WSdiOseCNQVN3JuC2y/Z6w+I6EdE=;
        b=Jj0yo7xWCwnOhcBcbvYt8bECRorjysmLzA0OFq5Hp+M1id7tkc+EX53tkCiLJnbM8T
         6smQvhtB8J5pjkqY27ZOMgJL1Zbf8IC3Mkps9h8fXlyDNUVB1iKSXd6q97R5IVvDUpz3
         CP4wMkDVXrxYCYgsLvt8DzSIuhthob2dHBZU9D5FL/LoGBK1Eib9OxtRh/WWoM7rzuz0
         BT/BmcD5W+l6zZ4O4b4eV/P14GM25QkD3fxfR0EfPVeNaYFUU4O/R+NUa88S+0D0VQAp
         ZJilFFVOhZ6s0YytGHGbhhgBA9yq5L5H6lnS7Jhv1lwH0u22/iJrD8f2oKfo7zyDGzL+
         LmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KUXqqEbtYou4QA8WSdiOseCNQVN3JuC2y/Z6w+I6EdE=;
        b=cYj9YggIxZOc7F/X+T2dcwg82Y7jxmy1luK39ALcOelH5qK2qaEWiZNd4mi+gVEA/e
         mvQ6Q9ZAbFAroR7sFHv98CoktMzTg9UfkcE1933LiYb7mv6CGn5NskPvfikzT5IAdgsc
         papic1k0aIklxopvnjXFwqXTKJ7gcydc7nuNqUQYZWl18a0izpDf8Oe0mRSrjlrXYnW7
         xgTur8GAPQmljMlfWh1I/gSA4knH+8GsfOgo8Z3caHih8eWEDjUs+T4t6RUs5B3vJVZ0
         U9sdzd12MN2ydoaWdDULDjSSC1sRqyGX1GGEaGkiGSk6HGW7oYKZuhNoZw4ytRbxivlZ
         w7Eg==
X-Gm-Message-State: AOAM53285KNkqEZG1n/qa3m20rWYhHgOjioXvHvAX3GSx8e6Uv+bRyi4
        sgbfKjhCjhdn5ck7GVhqsI53DRFcp54=
X-Google-Smtp-Source: ABdhPJxk95o4oFbWAcf1jHc1rpsvHpKutzP8HlrsDH15kcrgQ7VGoAQxBzuNG43chMlwrtwlYzBi0Q==
X-Received: by 2002:a05:6000:144b:b0:204:d97:8d12 with SMTP id v11-20020a056000144b00b002040d978d12mr10812080wrx.572.1648234968526;
        Fri, 25 Mar 2022 12:02:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm6235569wri.105.2022.03.25.12.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:02:47 -0700 (PDT)
Message-Id: <pull.1185.v3.git.1648234967.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
References: <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 19:02:45 +0000
Subject: [PATCH v3 0/2] test-lib-functions: fix test_subcommand_inexact
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chakrabortyabhradeep79@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio discovered in [1] that test_subcommand_inexact is more flexible than
initially intended.

[1] https://lore.kernel.org/git/xmqq4k41vdwe.fsf@gitster.g/

The intention was that we do not need to specify the remaining arguments for
a subcommand, but instead the current behavior is to allow the given
arguments to appear as any subsequence within the command (except that the
first "git" instance must be the first argument).

By changing the test that needed the helper, we can avoid the helper in the
first place. Modify the test and remove the helper.


Changes in v3
=============

 * Significant edits to the test in t7700 based on Junio and Taylor's
   feedback.

 * Patch 2 now deletes the helper as it is not used anywhere.

Thanks, -Stolee

Derrick Stolee (2):
  t7700: check post-condition in kept-pack test
  test-lib-functions: remove test_subcommand_inexact

 t/t7700-repack.sh       | 57 ++++++++++++++++++++++++++++++++++++++---
 t/test-lib-functions.sh | 34 ------------------------
 2 files changed, 54 insertions(+), 37 deletions(-)


base-commit: a68dfadae5e95c7f255cf38c9efdcbc2e36d1931
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1185%2Fderrickstolee%2Ftest-subcommand-fix-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1185/derrickstolee/test-subcommand-fix-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1185

Range-diff vs v2:

 1:  f2f8d12929b ! 1:  fb2c550512e t7700: check post-condition in kept-pack test
     @@ t/t7700-repack.sh: test_expect_success '--write-midx with preferred bitmap tips'
       	)
       '
       
     -+get_sorted_objects_from_packs () {
     -+	git show-index <$(cat) >raw &&
     -+	cut -d" " -f2 raw | sort
     ++# The first argument is expected to be a filename
     ++# and that file should contain the name of a .idx
     ++# file. Send the list of objects in that .idx file
     ++# into stdout.
     ++get_sorted_objects_from_pack () {
     ++	git show-index <$(cat "$1") >raw &&
     ++	cut -d" " -f2 raw
      +}
      +
       test_expect_success '--write-midx -b packs non-kept objects' '
     @@ t/t7700-repack.sh: test_expect_success '--write-midx with preferred bitmap tips'
      +		test_commit base &&
      +		git repack -ad &&
      +		find $objdir/pack -name "*.idx" >before &&
     -+		>$objdir/pack/$(basename $(cat before) .idx).keep &&
     ++		test_line_count = 1 before &&
     ++		before_name=$(cat before) &&
     ++		>${before_name%.idx}.keep &&
      +
      +		# Create a non-kept pack-file
      +		test_commit other &&
     @@ t/t7700-repack.sh: test_expect_success '--write-midx with preferred bitmap tips'
      +		find $objdir/pack -name "*.idx" | sort >after &&
      +		test_line_count = 2 after &&
      +		find $objdir/pack -name "*.keep" >kept &&
     -+		test_line_count = 1 kept &&
     ++		kept_name=$(cat kept) &&
     ++		echo ${kept_name%.keep}.idx >kept-idx &&
     ++		test_cmp before kept-idx &&
      +
      +		# Get object list from the kept pack.
     -+		get_sorted_objects_from_packs \
     -+			<before \
     -+			>old.objects &&
     ++		get_sorted_objects_from_pack before >old.objects &&
      +
      +		# Get object list from the one non-kept pack-file
      +		comm -13 before after >new-pack &&
     -+		get_sorted_objects_from_packs \
     -+			<new-pack \
     -+			>new.objects &&
     ++		test_line_count = 1 new-pack &&
     ++		get_sorted_objects_from_pack new-pack >new.objects &&
      +
      +		# None of the objects in the new pack should
      +		# exist within the kept pack.
 2:  ed67b748971 < -:  ----------- test-lib-functions: fix test_subcommand_inexact
 -:  ----------- > 2:  f5a96a121a5 test-lib-functions: remove test_subcommand_inexact

-- 
gitgitgadget
