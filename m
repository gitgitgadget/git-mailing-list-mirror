Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E5AC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiEYPCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245038AbiEYPBz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0292AFB13
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso1291156wma.0
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z9IxtYpTOmmUNIoUdSuKzuSelfyJ5z/hHgvnSuipErQ=;
        b=BMNR8kkfMlfgCNbjTMXyGV75udLGan5CVrW51XrCFSm1HeDk5DIPouWS0vUNHTo0L3
         HyS2VJg3EM9SeWbv9qeT2l8oHQjTezzuVIC5vC6hjhfqK5n/9oHDdCxoe9Vgyj2rkf1i
         4/wSD7C9TD5D//tmMmZYgWiJw5tZxh3lIWrD/egEHy8K1QAVxpOeO8j3AoR0ol6OyNUK
         Iw7n+VO9RxZ5gt/6L1oC5Xdoe9Yhajtj+JrVVfSuJdi8B7P7Wi2XRrzu9IyzRF3+7B+E
         nkNpFjOM8ZzNBn7c+noa74LcKgYmWQLtrk+zz5ONdfJW06Mspk54Ij/Frq0rlgnUO/GU
         gjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z9IxtYpTOmmUNIoUdSuKzuSelfyJ5z/hHgvnSuipErQ=;
        b=u8hH57aRHPmB+gIEMnGdFvkOROJtgR6GDZcx73FFReKBLRtS1cTMTJogUav/gICVWF
         rJy6J/Wy2gvH3mcpK6LBOBRAU3rQu3Akw9t9IlegyP2stGTvq1Q3Nej0R7r56fDzuY+b
         ruWxCs6nTfvKGxw/jVLZHEKFzhOChI/OewD4/F/WiKlw3vrnekRzL0Hzj3GhkRcDD5aG
         gZhZAo2X43n3EwZtwRJg0m6JNVlhQ058vk4Wkk83u3p1MARgmSN8FH3UTlU1CJqsDNt2
         01a80lc7ekVvrWwLLgjnES88HgvfSfN9hnExxvfqjYcEfzWMd9tBluGS9emdcAzcjD7G
         NLlg==
X-Gm-Message-State: AOAM531v6YVy0BnkYt7Wz7uEt2Upi2SuB3u1wGW7tlegKTQ+DRiDXUUd
        gftDIZATylBEYeLruOKBUnGEtveC6Yw=
X-Google-Smtp-Source: ABdhPJyPOahcmm3VLrD0VSqwD1ZmVxZWtV4kw5AXj/TykGIHjyTabGbffuE6Z7HL01dKdS23fqywAw==
X-Received: by 2002:a7b:c5cd:0:b0:38c:8b1b:d220 with SMTP id n13-20020a7bc5cd000000b0038c8b1bd220mr8477182wmk.118.1653490900051;
        Wed, 25 May 2022 08:01:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12-20020adff70c000000b0020c5253d925sm2193418wrp.113.2022.05.25.08.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:38 -0700 (PDT)
Message-Id: <fc3a0e7847ff62a30d71fd48817740651e0bdbe0.1653490853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:50 +0000
Subject: [PATCH v8 28/30] t7527: test Unicode NFC/NFD handling on MacOS
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

