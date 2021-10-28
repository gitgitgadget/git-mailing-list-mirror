Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DA1C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BDB60F92
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhJ1UxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhJ1UxI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:53:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F985C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so248745wmd.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=tkBg/kj9uHXxh/OvqLqp7cY7nTSWOW0lXf5gS3LX33M=;
        b=BgyLvuA6TLw7dczuX8Y/9l7hIHEf5P2FsjyKicJiKRm3qLXdw7G2MER2/c27G8ML8k
         k/ckiuKNIVRVU1aM9emEnNm1eEwZbE4ZGFLSOn8UdHcU4Y05dNWizu2uupwXp+MTrtiD
         VGdDLeSZrWdQISoPTlDUelPBpre19V1EBsGZiAdIU41rXB6w2SL0exiOWvMul/zZkkzq
         xW4B68kyr2o5dN5kwiPjM9LxDN8lNES9x4KY9KO9IhTJIwNgWpihi17kcHti7Na029TY
         v05InY/R7r7cM8C51Q8m3m537yTiQZUG5ScgJkzbdxtpsfq3Xn0ipuDwR31pvgKMc8mc
         DWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=tkBg/kj9uHXxh/OvqLqp7cY7nTSWOW0lXf5gS3LX33M=;
        b=HwDxJosD0Sr8EUOymTgX0WgrlIkzAs/iJrb4/e1af3MH6lFlGiCymEZijAP2MzrhDZ
         V9Ne3MbvAGxoz3epBFYjSWzmV1YiPWBvTlLQZa70mQPYg/G/i2L5yHOt0ag3ZoMlSRYu
         g2TGHhDLWe9bS2coAQkd95VXndNYpcM7aBfNNQVGhWfnufX/yU8zSmA2PXgPJMv39iZ7
         GFzSJfTh4qdjldF9TS+O5dykPh9ggiOpIAxDVPg0h9QalqJg4DPzFOJ/9/WkUWc9SO56
         /tDTzDzG8zuwd4xFr+QfCFHoEZYP6dS3viQY4qRe2X5CfYHzn3u2f8Kp/4EoGDxS8zq/
         GCBg==
X-Gm-Message-State: AOAM533tRGrXgQXbWtpMycEzl3fFRnZDusAy1Fb2QfVSUu4wwHw83Y6b
        CKdWQ3gZMDz7bI6E/aATqmGjO5twTX0=
X-Google-Smtp-Source: ABdhPJxrfE1iSttpdfTfmGBNOYK/2ghpvoBpeWYkzHUjN7DeIG3pXpBCyL91l8yXp/An9tkjGtZShQ==
X-Received: by 2002:a05:600c:ac1:: with SMTP id c1mr6794157wmr.99.1635454239051;
        Thu, 28 Oct 2021 13:50:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q123sm7217552wma.20.2021.10.28.13.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:50:38 -0700 (PDT)
Message-Id: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 20:50:30 +0000
Subject: [PATCH v2 0/7] Allow clean/smudge filters to handle huge files in the LLP64 data model
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series came in via the Git for Windows fork
[https://github.com/git-for-windows/git/pull/3487], and I intend to merge it
before v2.34.0-rc0, therefore I appreciate every careful review you gentle
people can spare.

The x86_64 variant of Windows uses the LLP64 data model, where the long data
type is 32-bit. This is very different from the LP64 data model used e.g. by
x86_64 Linux, where unsigned long is 64-bit.

Most notably, this means that sizeof(unsigned long) != sizeof(size_t) in
general.

However, since Git was born in the Linux ecosystem, where that inequality
does not hold true, it is understandable that unsigned long is used in many
code locations where size_t should have been used. As a consequence, quite a
few things are broken e.g. on Windows, when it comes to 4GB file contents or
larger.

Using Git LFS [https://git-lfs.github.io/] trying to work around such issues
is one such a broken scenario. You cannot git checkout, say, 5GB files. Huge
files will be truncated to whatever the file size is modulo 4GB (in the case
of a 5GB file, it would be truncated to 1GB).

This patch series primarily fixes the Git LFS scenario, by allowing clean
filters to accept 5GB files, and by allowing smudge filters to produce 5GB
files.

The much larger project to teach Git to use size_t instead of unsigned long
in all the appropriate places is hardly scratched by this patch series.

Side note: The fix for the clean filter included in this series does not
actually affect Git LFS! The reason is that Git LFS marks its filter as
required, and therefore Git streams the file contents to Git LFS via a file
descriptor (which is unaffected by LLP64). A "clean" filter that is not
marked as required, however, lets Git take the code path that is fixed by
this patch series.

Changes since v1:

 * Removed extraneous "Signed-off-by:" lines from "git-compat-util:
   introduce more size_t helpers".
 * Integrated Carlo's patch to allow genzeros to generate large amounts of
   NULs, even in LLP64 data models.
 * Using test-tool genzeros instead of dd if=/dev/zero, to help HP NonStop
   (which appears to use the LP64 data model and therefore should pass the
   new test cases even without the fixes provided in this patch series).
 * Accelerating genzeros to have performance characteristics similar to dd
   if=/dev/zero instead of being ~50x slower.

Carlo Marcelo Arenas Belón (1):
  test-genzeros: allow more than 2G zeros in Windows

Johannes Schindelin (2):
  test-tool genzeros: generate large amounts of data more efficiently
  git-compat-util: introduce more size_t helpers

Matt Cooper (4):
  t1051: introduce a smudge filter test for extremely large files
  odb: teach read_blob_entry to use size_t
  odb: guard against data loss checking out a huge file
  clean/smudge: allow clean filters to process extremely large files

 convert.c                   |  2 +-
 delta.h                     |  6 +++---
 entry.c                     |  8 +++++---
 entry.h                     |  2 +-
 git-compat-util.h           | 25 +++++++++++++++++++++++++
 object-file.c               |  6 +++---
 packfile.c                  |  6 +++---
 parallel-checkout.c         |  2 +-
 t/helper/test-genzeros.c    | 21 +++++++++++++++++----
 t/t1051-large-conversion.sh | 23 +++++++++++++++++++++++
 10 files changed, 82 insertions(+), 19 deletions(-)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1068%2Fdscho%2Fhuge-file-smudge-clean-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1068/dscho/huge-file-smudge-clean-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1068

Range-diff vs v1:

 -:  ----------- > 1:  068f897b973 test-genzeros: allow more than 2G zeros in Windows
 -:  ----------- > 2:  6edcbae372e test-tool genzeros: generate large amounts of data more efficiently
 1:  449eb5c205e ! 3:  1bdded86f5d t1051: introduce a smudge filter test for extremely large files
     @@ t/t1051-large-conversion.sh: test_expect_success 'ident converts on output' '
      +# ensures that smudging doesn't mangle large files on 64-bit Windows.
      +test_expect_failure EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
      +	test_commit test small "a small file" &&
     -+	test_config filter.makelarge.smudge "dd if=/dev/zero bs=$((1024*1024)) count=$((5*1024)) && cat" &&
     ++	test_config filter.makelarge.smudge \
     ++		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
      +	echo "small filter=makelarge" >.gitattributes &&
      +	rm small &&
      +	git checkout -- small &&
 2:  5b9d149ba23 ! 4:  3ffd3a001f7 odb: teach read_blob_entry to use size_t
     @@ t/t1051-large-conversion.sh: test_expect_success 'ident converts on output' '
      -test_expect_failure EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
      +test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
       	test_commit test small "a small file" &&
     - 	test_config filter.makelarge.smudge "dd if=/dev/zero bs=$((1024*1024)) count=$((5*1024)) && cat" &&
     - 	echo "small filter=makelarge" >.gitattributes &&
     + 	test_config filter.makelarge.smudge \
     + 		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
 3:  c81ee778b26 ! 5:  32472ae3f98 git-compat-util: introduce more size_t helpers
     @@ Commit message
          We will use them in the next commit.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     -    Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
     -    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## git-compat-util.h ##
      @@
 4:  bca013a0511 = 6:  c6910584108 odb: guard against data loss checking out a huge file
 5:  20387ce3557 ! 7:  d87d4229bb4 clean/smudge: allow clean filters to process extremely large files
     @@ t/t1051-large-conversion.sh: test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files
      +# This clean filter writes down the size of input it receives. By checking against
      +# the actual size, we ensure that cleaning doesn't mangle large files on 64-bit Windows.
      +test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on input' '
     -+	dd if=/dev/zero bs=$((1024*1024)) count=$((5*1024)) >big &&
     ++	test-tool genzeros $((5*1024*1024*1024)) >big &&
      +	test_config filter.checklarge.clean "wc -c >big.size" &&
      +	echo "big filter=checklarge" >.gitattributes &&
      +	git add big &&

-- 
gitgitgadget
