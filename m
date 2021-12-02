Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B46C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348258AbhLBRkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348195AbhLBRkA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:40:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6814BC06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 09:36:37 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v11so293275wrw.10
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 09:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OuCqtHRK/vK4Q099RfeF3vUiPh0kfiXb7vMkw7ScbpY=;
        b=aYEd2RcwaIw1U0ocZs3cjdiIdvLtSZCl7bV5iJil4kxCIGxSiuSKF9vUxuRcuuI96W
         HVkkpx9C/Ww+nsmhdXUk1GDjrZrrhf0n4t6hJ4rfzGJx13ZPf9viT6Ud01ooKEypSX+J
         LyrNONcJCJlWJa35Rh+r49VZuYbV296gPXwM2mGKnxeKxtQgU+GqUIlI/G6et0H8PnUX
         /ri6dC4HdY1IVd7G0/E8PxjsPyS9yk3bEmdIZ9ZpQOtLIq1ouZZysD1nHlrQCVoJIT6z
         SLS/TVUrFdIPJNwyt/lNxtsJThHrKig8xr5OgrIMAc/jPplxjoevwShXAcmfKtk/94I7
         yl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OuCqtHRK/vK4Q099RfeF3vUiPh0kfiXb7vMkw7ScbpY=;
        b=8P8bW0jZ9nW6Rz1tRfSiy1A3ixYudjsOyiF/s/FFqyxKqc1HDieTnThI8Tg1HtSPGR
         XRG6J/1lMBt2cD9Fbwm6Wiyhqdj8L0G10XKUN0xVE3zxLqSjy7Lsn//hdBzqcy3BhAfk
         2uNGAJqdE/vNXsULVA87ED6zM2g61Mvcaq0M6AoBPABxTzcN2iwoz8NQKuxVNUPCtf7g
         dQ52PRtvkLi2cnpmz/mGGdXrL1jT9mGGHWGx9BliSS9NBM/A/zdx4nR41eOxuT7vByRN
         x0L09PxBEtJMd+wDZyuP2ncQy/I+wtMNgDYe0GT+6g59LLCKQvhDTT886khEdMt9YB6Z
         nRFw==
X-Gm-Message-State: AOAM533FTIWYYDNdcFR5p1XIRGnt7CAohNV+OmAXnrfUfXJWqtqVOTEI
        9M7LJARHZiHI9pmK0EKlKjM+V+LBPBE=
X-Google-Smtp-Source: ABdhPJw1KGuJvjkfbAQlU66ipb6lSssBkhL5seyVRvBADwvbrPahbvb1PHeUmGz5ODmlbwJef+N3sw==
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr15526144wrw.78.1638466595821;
        Thu, 02 Dec 2021 09:36:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm314604wms.15.2021.12.02.09.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:36:35 -0800 (PST)
Message-Id: <6e94a6fbe05e38c849c1311b18b0a95030af21ba.1638466593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>
References: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
        <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 17:36:29 +0000
Subject: [PATCH v3 1/5] show-branch: show reflog message
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

Before, --reflog option would look for '\t' in the reflog message. As refs.c
already parses the reflog line, the '\t' was never found, and show-branch
--reflog would always say "(none)" as reflog message

Add test.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/show-branch.c  | 12 +++++++-----
 t/t3202-show-branch.sh | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 082449293b5..f1e8318592c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -761,6 +761,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			char *logmsg;
 			char *nth_desc;
 			const char *msg;
+			char *end;
 			timestamp_t timestamp;
 			int tz;
 
@@ -770,11 +771,12 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				reflog = i;
 				break;
 			}
-			msg = strchr(logmsg, '\t');
-			if (!msg)
-				msg = "(none)";
-			else
-				msg++;
+
+			end = strchr(logmsg, '\n');
+			if (end)
+				*end = '\0';
+
+			msg = (*logmsg == '\0') ? "(none)" : logmsg;
 			reflog_msg[i] = xstrfmt("(%s) %s",
 						show_date(timestamp, tz,
 							  DATE_MODE(RELATIVE)),
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index ad9902a06b9..d4d64401e4b 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -4,6 +4,9 @@ test_description='test show-branch'
 
 . ./test-lib.sh
 
+# arbitrary reference time: 2009-08-30 19:20:00
+GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
+
 test_expect_success 'setup' '
 	test_commit initial &&
 	for i in $(test_seq 1 10)
@@ -146,4 +149,16 @@ test_expect_success 'show branch --merge-base with N arguments' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show branch --reflog=2' '
+	sed "s/^>	//" >expect <<-\EOF &&
+	>	! [refs/heads/branch10@{0}] (4 years, 5 months ago) commit: branch10
+	>	 ! [refs/heads/branch10@{1}] (4 years, 5 months ago) commit: branch10
+	>	--
+	>	+  [refs/heads/branch10@{0}] branch10
+	>	++ [refs/heads/branch10@{1}] initial
+	EOF
+	git show-branch --reflog=2 >actual &&
+	test_cmp actual expect
+'
+
 test_done
-- 
gitgitgadget

