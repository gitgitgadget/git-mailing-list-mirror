Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194B3C433FE
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244952AbiEZVua (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349214AbiEZVti (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BBCE8BAF
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 129-20020a1c0287000000b003974edd7c56so167245wmc.2
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z9IxtYpTOmmUNIoUdSuKzuSelfyJ5z/hHgvnSuipErQ=;
        b=pTFxRvflbyAsD4V1SH37pIBIyVhLQZpi1NlGt4LdJ13D+R+LSnCAX9RK3zIGhvbqvH
         gKy3eDEfgw4fb7EHEggJqkEn6qDQ3tFu9jtepDKJwMMTyxXWVDNqeya2k5ijwrEVB6s0
         pJBFdh61Gm+6tAx4AU9+jc7d3EGcvdd6QfiTq6xrYWMd2NADBlpCF2tQ3eNmkDscXJJ/
         dSNecEjk2+lG3/zQ6mcdwo+fF9La32zSVTLIQDYVJq9dgPkQo9pNJwy0KODi9qMfS5nL
         +ihoTE83+IwpPRlrnd/I46F/4MCD7uhPHb4Yu+ceox2dfoV10az7w5ChQr3/KHappQK2
         IpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z9IxtYpTOmmUNIoUdSuKzuSelfyJ5z/hHgvnSuipErQ=;
        b=bRQ+hi5wVbu23zRVHccDYvxHUXeBWTENX8Y2fTTmGf4f/38dqKmX3gNO7q4JlJy0pv
         Y5/4B5BPjOijNOe5rNjOvmoicA506l1fvlkRem935t3gRxNhzVaVZzre5Ocx2/5N4bmm
         NCq62P5Bsv33hkysHqOMVY/vuRURfFLILP63ea6bkMSZ45CdiP/4sKcBvVlsuc4lqKKA
         EQS7XCbyFEiwMENGn0J6+iyW8YzhcKw7L4MFTYmWh3+C/1OZl0WV+zY3e2vTJF9MagvY
         xDiHVdglJwjlzqgrAsqwpQzwrjaG03KZF1QMjcmIhSG47ksVmCZjuf0axnIbHaFnhzaM
         CBfA==
X-Gm-Message-State: AOAM533wPh2EWq5DpyMo9AVg2eI2j3F1Md0f8RwVcy+aYHACUWP3UheF
        +MhAIr6ascUdRoJuO8lGNmseiyYHzS4=
X-Google-Smtp-Source: ABdhPJzBpOGPnzyJISf3fnJ+wzxMFPP79B5Ewe+hC7t8u1/Xm+mxjeN5hy5hehXiKKRr6mB418oIGg==
X-Received: by 2002:a7b:cb84:0:b0:382:a9b9:2339 with SMTP id m4-20020a7bcb84000000b00382a9b92339mr4181170wmi.91.1653601775123;
        Thu, 26 May 2022 14:49:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b0020feb9c44c2sm265871wrs.20.2022.05.26.14.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:34 -0700 (PDT)
Message-Id: <b27dc48a6507283418e52bc8dd47640bfaf34ac9.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:22 +0000
Subject: [PATCH v9 28/30] t7527: test Unicode NFC/NFD handling on MacOS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Confirm that the daemon reports events using the on-disk
spelling for Unicode NFC/NFD characters.  On APFS we still
have Unicode aliasing, so we cannot create two files that
only differ by NFC/NFD, but the on-disk format preserves
the spelling used to create the file.  On HFS+ we also
have aliasing, but the path is always stored on disk in
NFD.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index fbb7d6aef6e..9edae3ed830 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -868,4 +868,59 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
 	egrep "^event: abc/def/xyz$" ./insensitive.trace
 '
 
+# The variable "unicode_debug" is defined in the following library
+# script to dump information about how the (OS, FS) handles Unicode
+# composition.  Uncomment the following line if you want to enable it.
+#
+# unicode_debug=true
+
+. "$TEST_DIRECTORY/lib-unicode-nfc-nfd.sh"
+
+# See if the OS or filesystem does NFC/NFD aliasing/munging.
+#
+# The daemon should err on the side of caution and send BOTH the
+# NFC and NFD forms.  It does not know the original spelling of
+# the pathname (how the user thinks it should be spelled), so
+# emit both and let the client decide (when necessary).  This is
+# similar to "core.precomposeUnicode".
+#
+test_expect_success !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
+	test_when_finished "stop_daemon_delete_repo test_unicode" &&
+
+	git init test_unicode &&
+
+	start_daemon -C test_unicode --tf "$PWD/unicode.trace" &&
+
+	# Create a directory using an NFC spelling.
+	#
+	mkdir test_unicode/nfc &&
+	mkdir test_unicode/nfc/c_${utf8_nfc} &&
+
+	# Create a directory using an NFD spelling.
+	#
+	mkdir test_unicode/nfd &&
+	mkdir test_unicode/nfd/d_${utf8_nfd} &&
+
+	git -C test_unicode fsmonitor--daemon stop &&
+
+	if test_have_prereq UNICODE_NFC_PRESERVED
+	then
+		# We should have seen NFC event from OS.
+		# We should not have synthesized an NFD event.
+		egrep    "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace &&
+		egrep -v "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace
+	else
+		# We should have seen NFD event from OS.
+		# We should have synthesized an NFC event.
+		egrep "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace &&
+		egrep "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace
+	fi &&
+
+	# We assume UNICODE_NFD_PRESERVED.
+	# We should have seen explicit NFD from OS.
+	# We should have synthesized an NFC event.
+	egrep "^event: nfd/d_${utf8_nfd}/?$" ./unicode.trace &&
+	egrep "^event: nfd/d_${utf8_nfc}/?$" ./unicode.trace
+'
+
 test_done
-- 
gitgitgadget

