Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ED9C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1720A6137D
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhJEAVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 20:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhJEAV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 20:21:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15884C061755
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 17:19:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j193-20020a2523ca000000b005b789d71d9aso15355082ybj.21
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 17:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lx30UrSudKzemubZUac9a9uNzOEMm1FXbvNUave0GrI=;
        b=C319uvz2h9E0miReAdRmoOER2cijzutlGYFn7f9OaChfrRG3joA3dPqALqhiMUiBD1
         BMFHBXG7Wrsh0O0NqjIw+7IdMM6D92UW0zszD7YoXoo1/SdyduwMEoU14AeWqMoKOeT5
         4aMDkMebk5UFefivi13FNpxHATQTowKFihb6m5RkhrKqB3VbQ+hEetqSHVxBeW+kM28a
         UD4XRnNiBmrsNgZRrjKENWgXrkDEsCiXpTa/YV1MhYN0W1iScAmY74aGKdoHh4XCQxmS
         Jya6ieUz6ySqwifuR7Irq5jacbdQ0itnvrO/7Sz6u9t6vuvoP3n/LfttuC//Aizl6oVE
         btbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lx30UrSudKzemubZUac9a9uNzOEMm1FXbvNUave0GrI=;
        b=R9WU9ZewU3UMjbPoUIKItOHkIOQMgGZxYAs4XybGJelLFLSLl+H7OiDlRPSu1vocRY
         OlkZQir8YJERpvB/ngdDGq7FvV7KdkRgfNjnPRnyxGTrzaPJER7VlITye5Fild4NzajO
         u8H0iFIRDEyTp2MVqd4ECwwmR3AnRwktckxvHmIHpX15UCq4GknWn6dloezHA8dcXlKM
         aRcLKXbacmX0b3VbQGYnqKGCghXyO46vJVcyLvgwaXulSCCnoVHejtnESZVmd5J7TyDI
         JpLwEfAD4Sbp8/6tnaOnj57AaXeqrYm2nGf8esISjTAGWj0D1VBnN910uMED0eZWbq3n
         NgJg==
X-Gm-Message-State: AOAM531tWQl7FqIh7teVkwPGKOF8Bvn3Q1qaXN8kVECM+4qrV05NuTbz
        gw2WubrrFPh3c2UrYM+t+biAAyIuPOfornDFveD8koT5QBaK0KTkZfVOkh44hFEHGNvJ42XRpax
        MCxB6R+Gz1mYfu8NqZrslnlE039Z5Z2J3eBLwkFqgKBl5nkvK4wtF4TOK4Q4CJjo=
X-Google-Smtp-Source: ABdhPJxMQEuwoi/z13NaZu8TRtv6P0ipkFQU+IsewXguYKjUWxVkqZx1YXzG7dKrv7tQqcz1ug3FtxxFw/ZQrw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:4788:: with SMTP id
 u130mr17567832yba.489.1633393179245; Mon, 04 Oct 2021 17:19:39 -0700 (PDT)
Date:   Mon,  4 Oct 2021 17:19:28 -0700
In-Reply-To: <20210917225459.68086-1-chooglen@google.com>
Message-Id: <20211005001931.13932-1-chooglen@google.com>
Mime-Version: 1.0
References: <20210917225459.68086-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v3 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone! This patch was created in response to something we observed in
Google, where fsck failed to detect that the commit graph was invalid. We
initially assumed that fsck never checked the commit graph, but it turns out
that it does so only when core.commitgraph is set, even though we set defaults
for "whether to use the commit graph" in the repository settings.

Instead of using the config, let's use repository settings where
available. Replace core.commitGraph and core.multiPackIndex with their
equivalent repository settings in fsck and gc.

I don't anticipate any more business logic changes and the previous comments
were focused on testing style, so hopefully this should be good to merge.

Changes since v2:
* Various small test fixes (thanks Eric!). Most notably, I've used -c instead of
  test_config because test_config can affect the values in subsequent tests.
* Rewording fix in patch 3 commit message
* Refactor tests in patch 3 so that we use a single helper function instead of
  copy-pasted code

Changes since v1:
* clean up typo in patch 1 commit message 
* document the commits that patches 1 and 2 address
* use test helpers in patch 1
* rewrite patch 2's tests so that it's easier to tell that each test
  does something different
* reword patch 3 commit message to explain the bug
* add tests to patch 3

Glen Choo (3):
  fsck: verify commit graph when implicitly enabled
  fsck: verify multi-pack-index when implictly enabled
  gc: perform incremental repack when implictly enabled

 builtin/fsck.c              |  5 +++--
 builtin/gc.c                |  5 ++---
 t/t5318-commit-graph.sh     | 23 ++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh |  5 ++++-
 t/t7900-maintenance.sh      | 28 ++++++++++++++++++++++++----
 5 files changed, 55 insertions(+), 11 deletions(-)

Range-diff against v2:
1:  97ab2bb529 ! 1:  2f9ff949e6 fsck: verify commit graph when implicitly enabled
    @@ t/t5318-commit-graph.sh: test_expect_success 'detect incorrect chunk count' '
      	cd "$TRASH_DIRECTORY/full" &&
      	git fsck &&
      	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
    -@@ t/t5318-commit-graph.sh: test_expect_success 'git fsck (checks commit-graph)' '
    - 	test_must_fail git fsck
    - '
    - 
    + 		"incorrect checksum" &&
    + 	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
    ++	test_must_fail git -c core.commitGraph=true fsck
    ++'
    ++
     +test_expect_success 'git fsck (ignores commit-graph when config set to false)' '
     +	cd "$TRASH_DIRECTORY/full" &&
     +	git fsck &&
     +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
     +		"incorrect checksum" &&
     +	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
    -+	test_config core.commitGraph false &&
    -+	git fsck
    ++	git -c core.commitGraph=false fsck
     +'
     +
     +test_expect_success 'git fsck (checks commit-graph when config unset)' '
    ++	cd "$TRASH_DIRECTORY/full" &&
     +	test_when_finished "git config core.commitGraph true" &&
     +
    -+	cd "$TRASH_DIRECTORY/full" &&
     +	git fsck &&
     +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
     +		"incorrect checksum" &&
     +	test_unconfig core.commitGraph &&
     +	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
    -+	test_must_fail git fsck
    -+'
    -+
    - test_expect_success 'setup non-the_repository tests' '
    - 	rm -rf repo &&
    - 	git init repo &&
    + 	test_must_fail git fsck
    + '
    + 
2:  ace92453ca ! 2:  b13ca2a695 fsck: verify multi-pack-index when implictly enabled
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'verify incorrect offset' '
      	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
      		"incorrect object offset" \
     -		"git -c core.multipackindex=true fsck"
    -+		"git -c core.multipackindex=true fsck" &&
    -+		test_must_fail git fsck &&
    -+		git -c core.multipackindex=false fsck
    ++		"git -c core.multiPackIndex=true fsck" &&
    ++	test_unconfig core.multiPackIndex &&
    ++	test_must_fail git fsck &&
    ++	git -c core.multiPackIndex=false fsck
      '
      
      test_expect_success 'corrupt MIDX is not reused' '
3:  d6959d61c1 < -:  ---------- gc: perform incremental repack when implictly enabled
-:  ---------- > 3:  76943aff80 gc: perform incremental repack when implictly enabled
-- 
2.33.0.800.g4c38ced690-goog

