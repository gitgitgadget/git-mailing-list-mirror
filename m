Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D1EC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBFVTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBFVTC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:19:02 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18BD144B5
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:19:01 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h24so14518833qta.12
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Teh0Ty5mELrHL0BuhOUsVBlbaSF9I7iEztzj4dsTjXc=;
        b=XbI2/LJaCzHjb64QKU7blDL24u/rYYsItO7JspPhqS22kaouPEQxSt4TdPXzIA1Epg
         SpeaPSbgMQqe1EOokWK6qVgy//6ijnBRrDijesQct4gE00dH/03rBpP2q6v2m4bSxx5N
         BOBZXQfKE01EsMyF7a9dk3D7YitrxEtNkk1Ssr991rhd9SDHa0NP7q7IMV2euA5cQj9K
         Q3/w/r9EZu4DHEP5s7GB1Ujts+P5n1codgkXxpQTCdAnlKpd5w6pfQWHhwnyAdVuF8nx
         KHFbJF9UeqzDfz4/1eeGPsA+rE2jVr6xmFtDVpa33LpYeGdk8tAMBXXeE3kUKi6zNbtZ
         w7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Teh0Ty5mELrHL0BuhOUsVBlbaSF9I7iEztzj4dsTjXc=;
        b=LrEgbx7TBJooEG2YuoTjhx4MED+bDHDUXMW04P4I3k1wZ+cvOvwfmXaGs2v3MIRcLx
         WfcbWnEvZDXEfhUIQhYEx8Z+XHtCnl3Zd1XQ8Cus5jlr7ipSR6ZFoEEBJCM5WZLj9LBg
         xJcwRdXiK4WEevHU/QWjgXtBIUnIi0PHvAVuBqV6XPd3z/nhWWlI51kzKlACc8ortx0Y
         y9rexPHyI6DK8ahQJlB9LY5UKewCl8zEkHq+x137lADxiuJtY6/8J8KnfvVZkBj5zASZ
         Zv+QzjFSk1Ly2XRe35r/kMfi3jeyOkk4TToL6bTsmPKXZm9Q4TtDfNB0Rdc9o9uSsWA6
         Q6Tw==
X-Gm-Message-State: AO0yUKVHNLOR4yU3isl9vCeE1o1PtuqVAuFUYVkPeOVBARkU4hODzUDZ
        c7f/PzYi5Doem8IUrDrgD78K0QCudvs56g==
X-Google-Smtp-Source: AK7set9k4kwXogtCOf+Q153a5lVOcO45M4vdMB72YcBxOFoLsGkTRLoe6UPpjTq5VRtR4c7hDkmArQ==
X-Received: by 2002:ac8:5cce:0:b0:3b9:a777:3d9a with SMTP id s14-20020ac85cce000000b003b9a7773d9amr1411981qta.44.1675718340580;
        Mon, 06 Feb 2023 13:19:00 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id f11-20020ac8014b000000b003b86d5c4fbbsm8033014qtg.1.2023.02.06.13.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:19:00 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
Date:   Mon,  6 Feb 2023 16:18:23 -0500
Message-Id: <20230206211823.8651-4-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206211823.8651-1-cheskaqiqi@gmail.com>
References: <20230205145245.11078-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script is written in old style,where there are
some executable lines outside test_expect_success. Put the executable
lines inside the test_expect_success.

As t/README says,use "<<-" instead of "<<"
to strip leading TABs used for indentation. Change the "<<" to "<<-"

for example:
-cat >test-patch <<\EOF
-diff a/file b/file

 test_expect_success 'apply at the beginning' '
+       cat >test-patch <<-\EOF
+       diff a/file b/file
+       --- a/file

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 59 +++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index 5ee177e8eb..ab5ecaab7f 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -8,47 +8,42 @@ test_description='git apply trying to add an ending line.
 '
 . ./test-lib.sh
 
-# setup
-
-cat >test-patch <<\EOF
-diff --git a/file b/file
---- a/file
-+++ b/file
-@@ -1,2 +1,3 @@
- a
- b
-+c
-EOF
-
-echo 'a' >file
-echo 'b' >>file
-echo 'c' >>file
-
 test_expect_success setup '
+	cat >test-patch <<-\EOF
+	diff --git a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1,2 +1,3 @@
+	a
+	b
+	+c
+	EOF
+
+	echo 'a' >file
+	echo 'b' >>file
+	echo 'c' >>file
 	git update-index --add file
 '
-# test
 
 test_expect_success 'apply at the end' '
 	test_must_fail git apply --index test-patch
 '
 
-cat >test-patch <<\EOF
-diff a/file b/file
---- a/file
-+++ b/file
-@@ -1,2 +1,3 @@
-+a
- b
- c
-EOF
-
-echo >file 'a
-b
-c'
-git update-index file
-
 test_expect_success 'apply at the beginning' '
+	cat >test-patch <<-\EOF
+	diff a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1,2 +1,3 @@
+	+a
+	b
+	c
+	EOF
+
+	echo >file 'a
+	b
+	c'
+	git update-index file
 	test_must_fail git apply --index test-patch
 '
 
-- 
2.39.0

