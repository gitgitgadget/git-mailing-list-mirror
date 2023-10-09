Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB53CD613F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378852AbjJIV7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378826AbjJIV7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:59:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3541B9D
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:59:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40572aeb673so48742345e9.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696888738; x=1697493538; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlwts+bbb+VqSFpKBCYS8ZXjU5DWMurfTRm1YtuGr3k=;
        b=Ube7kyU5Q5xg/bK5nfZrMwu4FXWeve92VQyT26+c2QNR4bDZTLz83ZdHc+jVHu4WES
         zM/+fYJVc6/JQEhj8Sk5neT54VP9flvVHhaiL8vFFEUHumJUgto6PGiC6ZH6RieLh41d
         BdRAjHRdqbXwcmgcHoKrvWrlZw7Gdt4Y+1JIHbThV7UX3VyRuSVTKDFPsVa/Hc8hERbc
         rptlfe46s9DX6+rXLXzvM47zVb4PWdRTRpQJ08Ui++cd/GDti8skP8eZtykxBubuPY1Z
         N9W7a6HAqH81C1JUHKHPg6XihUFPNUvyod24WIcea7spg9iM2JHlYgyMy3sMLZcOWbdK
         uA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888738; x=1697493538;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlwts+bbb+VqSFpKBCYS8ZXjU5DWMurfTRm1YtuGr3k=;
        b=gmgRsgc3hUMhb4X3Y+SglqrAFqHsAUoZChr6DnqPWY7evfdNQRg3DdWRYTw6wPqo3V
         Nr7lpN6ihu/sbIfBR1BqOD1z/i+txnux/Emvq0FxxNd0++H6YNG0gyb4BL7xcuWqrKPc
         T2R4mWhdWdEA69G2BXDUyLNvC4qkIOKQG07RhaJi+QPyjwdsDnHHxuI3DZwK0aulxHMd
         +60KPEwzEkYZXfU5ISJ9PY7ktXGBC7Np4ox97qEJUSAELRLxZ1qiYB44TOqwkxFEv8RU
         DIB2lpoWp4n+uF5ydwx8UBKqyxv2bspxuhwPCngobOJJpo/PeK28go00DOV6aJAqdZQX
         jIbA==
X-Gm-Message-State: AOJu0YwECYo4u0E5wzDyhMGNjMOj4cR7SXENhr2LKpHEvSTOJ1EGltop
        VGx/UTE4JXeSdtZrzdmTZCsgiarP/5M=
X-Google-Smtp-Source: AGHT+IHLp/zSX7VWYZU/rph3PbMGGbGtsYlJkGU+/De5LMcpCOVm/gS75A6YbTByoRnQMqNG/mMZfg==
X-Received: by 2002:a05:600c:2947:b0:401:c436:8999 with SMTP id n7-20020a05600c294700b00401c4368999mr14647311wmd.30.1696888738123;
        Mon, 09 Oct 2023 14:58:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bca50000000b004064ac107cfsm12341655wml.39.2023.10.09.14.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:58:57 -0700 (PDT)
Message-ID: <402176246ea9d722a71a0ca4e970dfce8a4bf776.1696888736.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
        <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Oct 2023 21:58:53 +0000
Subject: [PATCH v2 1/4] ref-cache.c: fix prefix matching in ref iteration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update 'cache_ref_iterator_advance' to skip over refs that are not matched
by the given prefix.

Currently, a ref entry is considered "matched" if the entry name is fully
contained within the prefix:

* prefix: "refs/heads/v1"
* entry: "refs/heads/v1.0"

OR if the prefix is fully contained in the entry name:

* prefix: "refs/heads/v1.0"
* entry: "refs/heads/v1"

The first case is always correct, but the second is only correct if the ref
cache entry is a directory, for example:

* prefix: "refs/heads/example"
* entry: "refs/heads/"

Modify the logic in 'cache_ref_iterator_advance' to reflect these
expectations:

1. If 'overlaps_prefix' returns 'PREFIX_EXCLUDES_DIR', then the prefix and
   ref cache entry do not overlap at all. Skip this entry.
2. If 'overlaps_prefix' returns 'PREFIX_WITHIN_DIR', then the prefix matches
   inside this entry if it is a directory. Skip if the entry is not a
   directory, otherwise iterate over it.
3. Otherwise, 'overlaps_prefix' returned 'PREFIX_CONTAINS_DIR', indicating
   that the cache entry (directory or not) is fully contained by or equal to
   the prefix. Iterate over this entry.

Note that condition 2 relies on the names of directory entries having the
appropriate trailing slash. The existing function documentation of
'create_dir_entry' explicitly calls out the trailing slash requirement, so
this is a safe assumption to make.

This bug generally doesn't have any user-facing impact, since it requires:

1. using a non-empty prefix without a trailing slash in an iteration like
   'for_each_fullref_in',
2. the callback to said iteration not reapplying the original filter (as
   for-each-ref does) to ensure unmatched refs are skipped, and
3. the repository having one or more refs that match part of, but not all
   of, the prefix.

However, there are some niche scenarios that meet those criteria
(specifically, 'rev-parse --bisect' and '(log|show|shortlog) --bisect'). Add
tests covering those cases to demonstrate the fix in this patch.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 refs/ref-cache.c              |  3 ++-
 t/t1500-rev-parse.sh          | 23 +++++++++++++++++++++++
 t/t4205-log-pretty-formats.sh | 30 ++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 2294c4564fb..6e3b725245c 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -412,7 +412,8 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		if (level->prefix_state == PREFIX_WITHIN_DIR) {
 			entry_prefix_state = overlaps_prefix(entry->name, iter->prefix);
-			if (entry_prefix_state == PREFIX_EXCLUDES_DIR)
+			if (entry_prefix_state == PREFIX_EXCLUDES_DIR ||
+			    (entry_prefix_state == PREFIX_WITHIN_DIR && !(entry->flag & REF_DIR)))
 				continue;
 		} else {
 			entry_prefix_state = level->prefix_state;
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 37ee5091b5c..3f9e7f62e45 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -264,4 +264,27 @@ test_expect_success 'rev-parse --since= unsqueezed ordering' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-parse --bisect includes bad, excludes good' '
+	test_commit_bulk 6 &&
+
+	git update-ref refs/bisect/bad-1 HEAD~1 &&
+	git update-ref refs/bisect/b HEAD~2 &&
+	git update-ref refs/bisect/bad-3 HEAD~3 &&
+	git update-ref refs/bisect/good-3 HEAD~3 &&
+	git update-ref refs/bisect/bad-4 HEAD~4 &&
+	git update-ref refs/bisect/go HEAD~4 &&
+
+	# Note: refs/bisect/b and refs/bisect/go should be ignored because they
+	# do not match the refs/bisect/bad or refs/bisect/good prefixes.
+	cat >expect <<-EOF &&
+	refs/bisect/bad-1
+	refs/bisect/bad-3
+	refs/bisect/bad-4
+	^refs/bisect/good-3
+	EOF
+
+	git rev-parse --symbolic-full-name --bisect >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 16626e4fe96..62c7bfed5d7 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -956,6 +956,36 @@ test_expect_success '%S in git log --format works with other placeholders (part
 	test_cmp expect actual
 '
 
+test_expect_success 'setup more commits for %S with --bisect' '
+	test_commit four &&
+	test_commit five &&
+
+	head1=$(git rev-parse --verify HEAD~0) &&
+	head2=$(git rev-parse --verify HEAD~1) &&
+	head3=$(git rev-parse --verify HEAD~2) &&
+	head4=$(git rev-parse --verify HEAD~3)
+'
+
+test_expect_success '%S with --bisect labels commits with refs/bisect/bad ref' '
+	git update-ref refs/bisect/bad-$head1 $head1 &&
+	git update-ref refs/bisect/go $head1 &&
+	git update-ref refs/bisect/bad-$head2 $head2 &&
+	git update-ref refs/bisect/b $head3 &&
+	git update-ref refs/bisect/bad-$head4 $head4 &&
+	git update-ref refs/bisect/good-$head4 $head4 &&
+
+	# We expect to see the range of commits betwee refs/bisect/good-$head4
+	# and refs/bisect/bad-$head1. The "source" ref is the nearest bisect ref
+	# from which the commit is reachable.
+	cat >expect <<-EOF &&
+	$head1 refs/bisect/bad-$head1
+	$head2 refs/bisect/bad-$head2
+	$head3 refs/bisect/bad-$head2
+	EOF
+	git log --bisect --format="%H %S" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --pretty=reference' '
 	git log --pretty="tformat:%h (%s, %as)" >expect &&
 	git log --pretty=reference >actual &&
-- 
gitgitgadget

