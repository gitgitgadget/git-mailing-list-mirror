Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EE5C33CA4
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A57206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsjV1q8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKUWUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:38 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44379 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUWUh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:37 -0500
Received: by mail-wr1-f48.google.com with SMTP id i12so6292016wrn.11
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FeMle/vvKHKWFJvUQ6wmKMyy52PVuexwsHeVnliddmo=;
        b=dsjV1q8RsfhW5Fy9NsDf1x2y9gOsy/BfTlo+RJcRXkM2zrS4NVJjPsaYqwN4WySUnS
         wsHEET3VQDu3ySLlDehglnPF+Spi/NNZH4zAD5hsss+kRrR0s5c0AzAa7DV94EnWhYkF
         +nuPNQp1p5morov4+8HeByvUzjnUuqyOiDOEE/0jJFlsDUeVU368QXemO9nIfmqPk3oX
         U+Ae0pXdkrLOKT0Rjw/XfujBFxojdCryQVi1FuNUn5c6lJWobweOBAIwJQtytg0GLnQg
         DkMwdHD9+L76ttf7J5wsMwG2x1FgfeSz88TQxsrdD75oZBMPh6ThD9mbdXivwJYEud8m
         vAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FeMle/vvKHKWFJvUQ6wmKMyy52PVuexwsHeVnliddmo=;
        b=FynF680gm1cRtbu6ZJ7R5g9k7zcc9xtDCNTMEU2h0Urdkuao9k3QZiYAFUZk1k0ocy
         OFUxRPYs3cImG9dYf3j9wc+pRQ0XZBy81s7u+Nr0FPBJ5kFJuHPHxWMIJgu2GtA4IiOf
         W4nru3ru8cwE9OkZ/yV72dpWomf5VAuxofc1MPuYXPxR3dM5O9uzVstdtGG+urlp5SYn
         zBOsvA7GFrfY7l+P8b636a+7cgrVo28ICmh2EaxlFeYsJqVienHLei1KYInx4xMvwNoX
         s8freFBhRgboPZPoLJF88ZHloUAOhv9nHapn1YE7p2BknopwsM8gtXd0bjp+KM6JG3Uh
         IYbg==
X-Gm-Message-State: APjAAAVbkn/hsiLyHsLeDilJ6+QU0yZtKdj/N0ALtL2eASrVRi1J7qVL
        H+C/DVo19ZxmrvLdJk618zd28Mvk
X-Google-Smtp-Source: APXvYqwwNdh+6Zj9+Vw3fViRDLut8rbZq34Qt1cy5L0+wzLT9MrIjbgvDIcS3Ma2E1dcsBxRplqYog==
X-Received: by 2002:adf:ed4e:: with SMTP id u14mr14261796wro.132.1574374834512;
        Thu, 21 Nov 2019 14:20:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v184sm1228955wme.31.2019.11.21.14.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:34 -0800 (PST)
Message-Id: <47cecb4a83a3f726088ffba0b00679384c7349ae.1574374826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:26 +0000
Subject: [PATCH 11/11] test-lib: clear watchman watches at test completion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/test-lib-functions.sh | 15 +++++++++++++++
 t/test-lib.sh           |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e0b3f28d3a..03573caf42 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1475,3 +1475,18 @@ test_set_port () {
 	port=$(($port + ${GIT_TEST_STRESS_JOB_NR:-0}))
 	eval $var=$port
 }
+
+test_clear_watchman () {
+	if test $GIT_TEST_FSMONITOR -ne ""
+	then
+		watchman watch-list |
+			grep "$TRASH_DIRECTORY" |
+			sed "s/\t\"//g" |
+			sed "s/\",//g" >repo-list
+
+		for repo in $(cat repo-list)
+		do
+			watchman watch-del "$repo"
+		done
+	fi
+}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 30b07e310f..067a432ea5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1072,6 +1072,8 @@ test_atexit_handler () {
 	# sure that the registered cleanup commands are run only once.
 	test : != "$test_atexit_cleanup" || return 0
 
+	test_clear_watchman
+
 	setup_malloc_check
 	test_eval_ "$test_atexit_cleanup"
 	test_atexit_cleanup=:
-- 
gitgitgadget
