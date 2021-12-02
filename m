Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936A7C433FE
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348279AbhLBRkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348253AbhLBRkC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:40:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB971C06175A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 09:36:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 137so381644wma.1
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 09:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1BZh/t0ymUFfsqomhePzDDHwHXDn9QscnvyFCjOlys0=;
        b=Ls0wt5ZZLGvDwD9WP01tbr0Bz6RV/6fWqGFH29qf+K0P8/U7WLf79CxrRi9nwr6gnG
         NfZ3lhjr9OgpIPDaPRrItRNKiwsv3Yn5qaxcSq9tUkwVYJpDyxdz+Sp68eItDQVaLV3N
         Zcxth1QukHxZeAGTWVpXJ3ltbtlojtYCu7Gzd88sIJrv9qOwFNGDLqFVb6n8f4dQ5fK0
         VsT7JD9tq8XZujWHhzJELoV9dOgqC9eV5Dj9k5NHrnHnUv/BthHGheSlm+caJHcE+3JG
         /1SPdrqKfjQabaEfW/PL19pCOcry/wRD4Afn5BCp8plZ4OCZTLAJ1qCDjVg1+Bgo7E2V
         FKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1BZh/t0ymUFfsqomhePzDDHwHXDn9QscnvyFCjOlys0=;
        b=sivUDass1fXL2oP9F2ZdF6yTA0FPpZpn18CbZl8XZ3MtSM3lPaoEjiCdNazXxV081G
         GGDXyWOWfxFwNpi4Q2heU35WZA83k9kZhXdErfmqzf/e6hfxqwiYLj7SJ8BEbvC9HTsj
         RfZhikRR0EH968bK//aSoJ9o11yZSBeUqRV11cfqFsfbk793LYcWmuA3cQAwzrdYdl4g
         INm2I0Ks2yNZLAlV2tdAwdOixCClhYW/yXFC7jfDKzBexJGPXEvzQMDGgJVOvO5gc5gR
         1EX9gHTsHw7TkeEvW+eahMW1dh81Pe+j3TmO3cwjN2wVaSMnUsatCoPcVBeefezK9TAx
         YDUA==
X-Gm-Message-State: AOAM531vDmcrHV0NNqbhYDShAf3zLukC+mxFMllg9FqsxVRmK/npO1oz
        e9E4IWgKBj7Mi9KaDVjKk+1FyQyu3jY=
X-Google-Smtp-Source: ABdhPJzQPsR0WhcTWGJwfz6gU3dXzwnQbm/gfLeIgDgB26aFEOxOwQNDiBOHWCvJqFSnHkpsaisyjw==
X-Received: by 2002:a05:600c:378b:: with SMTP id o11mr8133306wmr.157.1638466598061;
        Thu, 02 Dec 2021 09:36:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm326110wmq.11.2021.12.02.09.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:36:37 -0800 (PST)
Message-Id: <40ba92dbf0d0a772534d8c00f86b375a08d25a12.1638466593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>
References: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
        <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 17:36:32 +0000
Subject: [PATCH v3 4/5] test-ref-store: tweaks to for-each-reflog-ent format
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
index 5ac33dfb598..775e5da5b95 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -152,8 +152,9 @@ static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
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
index 0d4f73acaa8..ef8fdcef466 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -321,8 +321,9 @@ $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
 EOF
 test_expect_success "verifying $m's log (logged by touch)" '
-	test_when_finished "rm -rf .git/$m .git/logs expect" &&
-	test_cmp expect .git/logs/$m
+	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
+	test-tool ref-store main for-each-reflog-ent $m >actual &&
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
+	test-tool ref-store main for-each-reflog-ent $m >actual &&
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

