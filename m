Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E99C433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 14:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbhKVOYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 09:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhKVOYF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 09:24:05 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F46AC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:20:58 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o29so15559182wms.2
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OuCqtHRK/vK4Q099RfeF3vUiPh0kfiXb7vMkw7ScbpY=;
        b=VrXHLUAe0wHTu4+qT8VQXkuBX/yUhDJ2dLojBs8CNXKSx01SYQ0bUciiH//2f/0/kH
         ISUYSKLEzR+E3APWwApeJtLRoVvc8FLNtflTwav+hY1d6VfKAClsTx6Y9wtyxRY+47GA
         E+jWC5fSccZq4hwHBjjbIXVwSEd1rzXus2FJuohjo4Jx1hhN32naiUEseqsI03E8plkx
         pI++lryhJanBTEWPThvOnZ0st0N7i48p+N6rHvGBhCHjntQdr62mg5PAUKA54I5cBsde
         mZSrM6+i1MSBGAuSIRYgOyVD+e3HnXFNXpwKlqqeUoU4oSOCaFLvZz9h4gUK6qgsjGbs
         +2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OuCqtHRK/vK4Q099RfeF3vUiPh0kfiXb7vMkw7ScbpY=;
        b=IcVDN2vgAygo2/9JjorBjAKgvZVfSvmuwJAhCBIbTTmAU6lP6dw9CSgsh2ogO1wVoz
         L3afJ3fVBiTUauVT+Dg031e9el+h2xx4YJPra7yOWOy3vBF+XS6V/oLpFwUVp705jkh/
         HOZ6nPYkh2KEXKWOZFKwHjVr/HzoJQzKbI1cA1nowsEmh0IhJzzth2DfJVXrjK9SkxtX
         MNaehyUoVRi9xbUEiEmlr1C5RqKi6x8LkerX4rIHxNQJV6vwd7X9FmL2jigCeEcXrj06
         hWpdJSGxjyUTP3mLwhVBV2cepxUbEiaoAxAliKzNxVLc3CyKRzxEbnLgmCT9yMimtjHV
         /oZQ==
X-Gm-Message-State: AOAM531vpQ8vNf+gzNIytQn1HiTKCj3tF/unny0pvX0G28Cpv0/3Gjcs
        vZzvHhJ1RzjKR0zK86g+AFV+MT5SA80=
X-Google-Smtp-Source: ABdhPJxwJ8+M+R79DhdbJOPob4CJ3XyirEf2ZEmiHlneSWXWd+9rtB9/g35D+A0n1TBhW2FhA3eOeg==
X-Received: by 2002:a1c:9851:: with SMTP id a78mr29410987wme.116.1637590856647;
        Mon, 22 Nov 2021 06:20:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm10666078wrr.10.2021.11.22.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:20:56 -0800 (PST)
Message-Id: <fd2595d370a8a257c44693fdc98194cd8447e22a.1637590855.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 14:20:52 +0000
Subject: [PATCH 1/4] show-branch: show reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
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

