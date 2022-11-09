Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545DEC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 14:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiKIOQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiKIOQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 09:16:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD08E40
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 06:16:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so1380909wmi.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 06:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMY8HwqLJIIeN11FUNh4BDlOGzzJhZ/3s+55OUgcM68=;
        b=LOmHZTh2nk1fwxWLPgaNB6qVuHyjGrjHNNO6U9M/qsiaqRBZK9CKHZmOzuWOlsNevJ
         Mi3xAQnD4r5cbmdYwt+R5U9jVwvEE/djnlvM8z6klTqUOBE/6OTysWPinJr9NYnPfMUb
         kUlerGiXAZCB5+2MR5TCSQxVUBHQ9bzJERud54J9QX8IBmdO3RUHxQD8PHri8KCsV0XI
         ORUatmyFwRIRGjc/xld1rc6rbuTNIi1+bro//ZVqqIkSN72kZ3WAYrwFheLnT1fu7QLT
         oQv8goSoS+XnLmBbN9QhI0fyG69D5xFbSK4I8488CdnRn/v2wRllg7xtMchc4MapBshO
         lmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMY8HwqLJIIeN11FUNh4BDlOGzzJhZ/3s+55OUgcM68=;
        b=HLlQQ+BE4PzoZqEZfsRTvv8uWaeHvD8WolUMfamCWm29A7k3hXoRajltItBghF82/p
         vdi+7vj4AcI3ati6RoqRgRe0eRRMP6UPehrkLDCfQWyKSdbRKyqNXhkHko35Qw0mEzw/
         rzYgA60uzDUBJg7x0i2YgkoPXxeRWvp/PL2DQicINJDvhgg8Tz5VwjA4AZ62D/ZqfvoR
         ecnzEbcDWZsT1MrVUm/EYUrBkU1aztO+YrfY1AXoC1Le9kt5IFBYoZnCNs5g6JmTcaw/
         M7ZNX4e9RC7kIEKpCjR5XGSMi9zgfmF5i0lqc6jlRFQloLdR0jJNGP7Jmwg6SS6oWQ/d
         ogaw==
X-Gm-Message-State: ANoB5pnwzD7ZbPmIhYsW1TfzZepC9nW/j6Yns99OpgSt8gybpkZCF1fq
        X5Zhu/EuXVr/wwmUNmUo2hHjfvBOtUs=
X-Google-Smtp-Source: AA0mqf4zZ7G9Pq5/ZIuvEipr+5y1PDwbelmIDy0LfCMLjexvbMhh+Wztq9tvrF2jKVt3oUkgRy30wA==
X-Received: by 2002:a05:600c:4fd3:b0:3cf:a464:e881 with SMTP id o19-20020a05600c4fd300b003cfa464e881mr13294538wmq.54.1668003395116;
        Wed, 09 Nov 2022 06:16:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003c6b9749505sm2008294wmq.30.2022.11.09.06.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:16:34 -0800 (PST)
Message-Id: <54f2ebefa0d8308dc00f6dd035c1baae4a8e1fc7.1668003388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1389.v2.git.1668003388.gitgitgadget@gmail.com>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
        <pull.1389.v2.git.1668003388.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 14:16:27 +0000
Subject: [PATCH v2 2/3] config: require at least one digit when parsing
 numbers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the input to strtoimax() or strtoumax() does not contain any digits
then they return zero and set `end` to point to the start of the input
string.  git_parse_[un]signed() do not check `end` and so fail to return
an error and instead return a value of zero if the input string is a
valid units factor without any digits (e.g "k").

Tests are added to check that 'git config --int' and OPT_MAGNITUDE()
reject a units specifier without a leading digit.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 config.c                 | 8 ++++++++
 t/t0040-parse-options.sh | 7 +++++++
 t/t1300-config.sh        | 6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/config.c b/config.c
index d5069d4f01d..b7fb68026d8 100644
--- a/config.c
+++ b/config.c
@@ -1167,6 +1167,10 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 		val = strtoimax(value, &end, 0);
 		if (errno == ERANGE)
 			return 0;
+		if (end == value) {
+			errno = EINVAL;
+			return 0;
+		}
 		factor = get_unit_factor(end);
 		if (!factor) {
 			errno = EINVAL;
@@ -1202,6 +1206,10 @@ static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 		val = strtoumax(value, &end, 0);
 		if (errno == ERANGE)
 			return 0;
+		if (end == value) {
+			errno = EINVAL;
+			return 0;
+		}
 		factor = get_unit_factor(end);
 		if (!factor) {
 			errno = EINVAL;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 64d2327b744..7d7ecfd5716 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -714,4 +714,11 @@ test_expect_success 'negative magnitude' '
 	grep "non-negative integer" err &&
 	test_must_be_empty out
 '
+
+test_expect_success 'magnitude with units but no numbers' '
+	test_must_fail test-tool parse-options --magnitude m >out 2>err &&
+	grep "non-negative integer" err &&
+	test_must_be_empty out
+'
+
 test_done
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index c6661e61af5..2575279ab84 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2228,6 +2228,12 @@ test_expect_success '--type rejects unknown specifiers' '
 	test_i18ngrep "unrecognized --type argument" error
 '
 
+test_expect_success '--type=int requires at least one digit' '
+	test_must_fail git config --type int --default m some.key >out 2>error &&
+	grep "bad numeric config value" error &&
+	test_must_be_empty out
+'
+
 test_expect_success '--replace-all does not invent newlines' '
 	q_to_tab >.git/config <<-\EOF &&
 	[abc]key
-- 
gitgitgadget

