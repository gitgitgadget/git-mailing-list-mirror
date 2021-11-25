Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4458CC433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 16:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356596AbhKYQNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356374AbhKYQMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 11:12:46 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F6C06139A
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:57 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o29so5980329wms.2
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I/XcjhTXOahDGN3s2nzZ6+d0TIy2qW88yldrIIBGgbE=;
        b=hek6EJcv1++Iw1LqgdjDut0+sfhXihdoaLqqoZnrrCAwfYXtleC8fUJONv/S1YI68r
         ojpbHK8ufMnUUicmb8Sd6xV/2zQPB+D9ovjl03cvFIufPHyKXMSCpWQgd4f18l//5s0m
         2fS/5+X34syxBuMbg7Ru89KJKW+chdDtLkZI5qzWbWjKZPgVyC4Co6OYImHbaFNSYlHk
         q9VnWDfdmN7v5vLRgTAGRSV/Fl4eO820YJ0XlsJriFBwxDbrwz07tJh6/OeLp2RNKsrX
         xYaV0Juh3CMvx4d3GinBNAG5a382BCrTfViNpj31ahXIfSZWQ3U+tQhMD7vBBYhAa8ym
         2KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I/XcjhTXOahDGN3s2nzZ6+d0TIy2qW88yldrIIBGgbE=;
        b=xfyD5TH16k+nOMlfT2KVDpksC4BwxJKx/6dNaVdfMFUe+KJwVXiBqpPnMNvFtSAAs/
         XniDq3K+y6BhyXdU+qOrgTylV8FhWWpn9r9qcJF2oeljp63HFNC3brAalg2dn1gPePcf
         zIaged1N1TQJaon3VlPAzBjzaf1eZmwLShI0Z/t6FYW+U6lBdo12otZ6GX5yZ2V7vER0
         A+ifpU7ONVKSUM96XB1e8ieIhR+0zF/ns2iExHfqV4LApjprDZlSHauHv9qFxEaFZw8M
         foyJ80oOJDIkr0NyAxR9c4jxIFMnG31vEsyELeCeqFbaR/tAW9B9IYpC7KcqGGKqvEIq
         QbIg==
X-Gm-Message-State: AOAM5313F9of9vem0Nk1iBAVS/arIiMV90nDEFuCwFUNhAbz+/pXfrur
        TAc5b+t6QSVzPo4kc5TAWvUaYt4iFz8=
X-Google-Smtp-Source: ABdhPJw9cQPOTapP+HZvWG/mHDEHU7OU7/GUNa/91olDgwuxeEvujGeCGoT+SCaxGRzuXj+Z3/3GCA==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr8413557wmh.104.1637855876454;
        Thu, 25 Nov 2021 07:57:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17sm3109780wrp.34.2021.11.25.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 07:57:56 -0800 (PST)
Message-Id: <62f5cb8a8243f9e5c2af5c148ed586a2504c8cee.1637855872.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 15:57:51 +0000
Subject: [PATCH v2 4/5] test-ref-store: tweaks to for-each-reflog-ent format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

We have some tests that read from files in .git/logs/ hierarchy
when checking if correct reflog entries are created, but that is
too specific to the files backend.  Other backends like reftable
may not store its reflog entries in such a "one line per entry"
format.

Update for-each-reflog-ent test helper to produce output that
is identical to lines in a reflog file files backend uses.
That way, (1) the current tests can be updated to use the test
helper to read the reflog entries instead of (parts of) reflog
files, and perform the same inspection for correctness, and (2)
when the ref backend is swapped to another backend, the updated
test can be used as-is to check the correctness.

Adapt t1400 to use the for-each-reflog-ent test helper.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c |  5 +++--
 t/t1400-update-ref.sh     | 13 ++++++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index ef244aa6b27..2b13d09a0be 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -151,8 +151,9 @@ static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
 		       const char *committer, timestamp_t timestamp,
 		       int tz, const char *msg, void *cb_data)
 {
-	printf("%s %s %s %" PRItime " %d %s", oid_to_hex(old_oid),
-	       oid_to_hex(new_oid), committer, timestamp, tz, msg);
+	printf("%s %s %s %" PRItime " %+05d%s%s", oid_to_hex(old_oid),
+	       oid_to_hex(new_oid), committer, timestamp, tz,
+	       *msg == '\n' ? "" : "\t", msg);
 	return 0;
 }
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 0d4f73acaa8..0d46a488032 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -321,8 +321,9 @@ $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
 EOF
 test_expect_success "verifying $m's log (logged by touch)" '
-	test_when_finished "rm -rf .git/$m .git/logs expect" &&
-	test_cmp expect .git/logs/$m
+	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
+	test-tool ref-store main for-each-reflog-ent $m > actual &&
+	test_cmp actual expect
 '
 
 test_expect_success "create $m (logged by config)" '
@@ -350,8 +351,9 @@ $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
 EOF
 test_expect_success "verifying $m's log (logged by config)" '
-	test_when_finished "rm -f .git/$m .git/logs/$m expect" &&
-	test_cmp expect .git/logs/$m
+	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
+	test-tool ref-store main for-each-reflog-ent $m > actual &&
+	test_cmp actual expect
 '
 
 test_expect_success 'set up for querying the reflog' '
@@ -467,7 +469,8 @@ $h_OTHER $h_FIXED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151040 +0000	co
 $h_FIXED $h_MERGED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151100 +0000	commit (merge): Merged initial commit and a later commit.
 EOF
 test_expect_success 'git commit logged updates' '
-	test_cmp expect .git/logs/$m
+	test-tool ref-store main for-each-reflog-ent $m >actual &&
+	test_cmp expect actual
 '
 unset h_TEST h_OTHER h_FIXED h_MERGED
 
-- 
gitgitgadget

