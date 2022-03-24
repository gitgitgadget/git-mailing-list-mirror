Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0540C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352060AbiCXQyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351931AbiCXQxz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DA9B0D28
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so7577020wmb.4
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E8xmQ7dYip7SaSRf9IXmrYL6K0sMohTDrDq1DYcKE54=;
        b=B8XZ3CQrh8kkU7+5rkf09okzMxXj4oEMRSU/7TBsx0Cqvntld+82b6mcBy3m+t84r6
         TxCW1YtaQc58VZ8/Z6K3h+nrtUsggNORAn56e448k6QCysSZnnLxIzF1zXZllbpFXr3I
         dKWUTyGCp00IFpFFcYi63sw2GQbUbDCHhRNsxzVP1OZ7Pm/zYygmr2/tW7bqJsuezm/6
         2WgZSPdQKIyrnenf5S5g/WV/uOZf41RkXHyK3KukroGhGkoNydt1jaEDjPD/EZf7GENB
         cj1vweBdzvQ+htEicwupA8UPBISdDyudIZj2A9NwR4zNgyS/i5Axqcpalqd8iGb/wI3k
         8FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E8xmQ7dYip7SaSRf9IXmrYL6K0sMohTDrDq1DYcKE54=;
        b=CZ6Xr3gYe6+ZX7ssUeMwd1KvT4vkoE1X5oZCb/If8j0/M/5HPTx4k12rX9waDNAGpm
         l3aYP9qGv9SwXZJhv7/2hDVBvMHS5UoAIJzueW8txk+AlQfYbBc9P9VGOPjxIf3oAnyb
         JTviB0Zyacfrkj4S9q7AexGofnD7pba+v7VTx+snlaFSPzNANZByr71jo2q/yY6T12Ta
         62xSawyyQ/Ib32kc48+5TkTlHih61jkbpWlghkcYcPcp6Ehe8lTbNq/1yok61r5B1sC2
         1Fk2BNs/TKA3NEsEyVMx/gUI9djWYCKTI/aUAlIYM6qU5rwlwgq4BOX3xKSeQCyv8VH0
         75CA==
X-Gm-Message-State: AOAM531pqMKp3wIyhJnvTBlwlAhIrWXlh8xELlrZ5YTVuiZC1F7ebhCn
        qLeJnQkzUi0JJEzgHLqm11BxgyndfW0=
X-Google-Smtp-Source: ABdhPJzV+BnD9K4yQAy65bpX4QoNstaNfBrvJxNOqebPvkHKzf9irm0JsyoRpESM69TDIQ/0wgoSUw==
X-Received: by 2002:a05:600c:1552:b0:38c:de92:6a2f with SMTP id f18-20020a05600c155200b0038cde926a2fmr1045906wmg.152.1648140717630;
        Thu, 24 Mar 2022 09:51:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b0038a18068cf5sm6339958wmb.15.2022.03.24.09.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:56 -0700 (PDT)
Message-Id: <bc2d5a7a9306c895f4a1105c08d86f24e5ea542c.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:19 +0000
Subject: [PATCH v4 26/27] t/lib-unicode-nfc-nfd: helper prereqs for testing
 unicode nfc/nfd
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a set of prereqs to help understand how file names
are handled by the filesystem when they contain NFC and NFD
Unicode characters.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/lib-unicode-nfc-nfd.sh | 167 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100755 t/lib-unicode-nfc-nfd.sh

diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
new file mode 100755
index 00000000000..cf9c26d1e22
--- /dev/null
+++ b/t/lib-unicode-nfc-nfd.sh
@@ -0,0 +1,167 @@
+# Help detect how Unicode NFC and NFD are handled on the filesystem.
+
+# A simple character that has a NFD form.
+#
+# NFC:       U+00e9 LATIN SMALL LETTER E WITH ACUTE
+# UTF8(NFC): \xc3 \xa9
+#
+# NFD:       U+0065 LATIN SMALL LETTER E
+#            U+0301 COMBINING ACUTE ACCENT
+# UTF8(NFD): \x65  +  \xcc \x81
+#
+utf8_nfc=$(printf "\xc3\xa9")
+utf8_nfd=$(printf "\x65\xcc\x81")
+
+# Is the OS or the filesystem "Unicode composition sensitive"?
+#
+# That is, does the OS or the filesystem allow files to exist with
+# both the NFC and NFD spellings?  Or, does the OS/FS lie to us and
+# tell us that the NFC and NFD forms are equivalent.
+#
+# This is or may be independent of what type of filesystem we have,
+# since it might be handled by the OS at a layer above the FS.
+# Testing shows on MacOS using APFS, HFS+, and FAT32 reports a
+# collision, for example.
+#
+# This does not tell us how the Unicode pathname will be spelled
+# on disk, but rather only that the two spelling "collide".  We
+# will examine the actual on disk spelling in a later prereq.
+#
+test_lazy_prereq UNICODE_COMPOSITION_SENSITIVE '
+	mkdir trial_${utf8_nfc} &&
+	mkdir trial_${utf8_nfd}
+'
+
+# Is the spelling of an NFC pathname preserved on disk?
+#
+# On MacOS with HFS+ and FAT32, NFC paths are converted into NFD
+# and on APFS, NFC paths are preserved.  As we have established
+# above, this is independent of "composition sensitivity".
+#
+# 0000000 63 5f c3 a9
+#
+# (/usr/bin/od output contains different amount of whitespace
+# on different platforms, so we need the wildcards here.)
+#
+test_lazy_prereq UNICODE_NFC_PRESERVED '
+	mkdir c_${utf8_nfc} &&
+	ls | od -t x1 | grep "63 *5f *c3 *a9"
+'
+
+# Is the spelling of an NFD pathname preserved on disk?
+#
+# 0000000 64 5f 65 cc 81
+#
+test_lazy_prereq UNICODE_NFD_PRESERVED '
+	mkdir d_${utf8_nfd} &&
+	ls | od -t x1 | grep "64 *5f *65 *cc *81"
+'
+	mkdir c_${utf8_nfc} &&
+	mkdir d_${utf8_nfd} &&
+
+# The following _DOUBLE_ forms are more for my curiosity,
+# but there may be quirks lurking when there are multiple
+# combining characters in non-canonical order.
+
+# Unicode also allows multiple combining characters
+# that can be decomposed in pieces.
+#
+# NFC:        U+1f67 GREEK SMALL LETTER OMEGA WITH DASIA AND PERISPOMENI
+# UTF8(NFC):  \xe1 \xbd \xa7
+#
+# NFD1:       U+1f61 GREEK SMALL LETTER OMEGA WITH DASIA
+#             U+0342 COMBINING GREEK PERISPOMENI
+# UTF8(NFD1): \xe1 \xbd \xa1  +  \xcd \x82
+#
+# But U+1f61 decomposes into
+# NFD2:       U+03c9 GREEK SMALL LETTER OMEGA
+#             U+0314 COMBINING REVERSED COMMA ABOVE
+# UTF8(NFD2): \xcf \x89  +  \xcc \x94
+#
+# Yielding:   \xcf \x89  +  \xcc \x94  +  \xcd \x82
+#
+# Note that I've used the canonical ordering of the
+# combinining characters.  It is also possible to
+# swap them.  My testing shows that that non-standard
+# ordering also causes a collision in mkdir.  However,
+# the resulting names don't draw correctly on the
+# terminal (implying that the on-disk format also has
+# them out of order).
+#
+greek_nfc=$(printf "\xe1\xbd\xa7")
+greek_nfd1=$(printf "\xe1\xbd\xa1\xcd\x82")
+greek_nfd2=$(printf "\xcf\x89\xcc\x94\xcd\x82")
+
+# See if a double decomposition also collides.
+#
+test_lazy_prereq UNICODE_DOUBLE_COMPOSITION_SENSITIVE '
+	mkdir trial_${greek_nfc} &&
+	mkdir trial_${greek_nfd2}
+'
+
+# See if the NFC spelling appears on the disk.
+#
+test_lazy_prereq UNICODE_DOUBLE_NFC_PRESERVED '
+	mkdir c_${greek_nfc} &&
+	ls | od -t x1 | grep "63 *5f *e1 *bd *a7"
+'
+
+# See if the NFD spelling appears on the disk.
+#
+test_lazy_prereq UNICODE_DOUBLE_NFD_PRESERVED '
+	mkdir d_${greek_nfd2} &&
+	ls | od -t x1 | grep "64 *5f *cf *89 *cc *94 *cd *82"
+'
+
+# The following is for debugging. I found it useful when
+# trying to understand the various (OS, FS) quirks WRT
+# Unicode and how composition/decomposition is handled.
+# For example, when trying to understand how (macOS, APFS)
+# and (macOS, HFS) and (macOS, FAT32) compare.
+#
+# It is rather noisy, so it is disabled by default.
+#
+if test "$unicode_debug" = "true"
+then
+	if test_have_prereq UNICODE_COMPOSITION_SENSITIVE
+	then
+		echo NFC and NFD are distinct on this OS/filesystem.
+	else
+		echo NFC and NFD are aliases on this OS/filesystem.
+	fi
+
+	if test_have_prereq UNICODE_NFC_PRESERVED
+	then
+		echo NFC maintains original spelling.
+	else
+		echo NFC is modified.
+	fi
+
+	if test_have_prereq UNICODE_NFD_PRESERVED
+	then
+		echo NFD maintains original spelling.
+	else
+		echo NFD is modified.
+	fi
+
+	if test_have_prereq UNICODE_DOUBLE_COMPOSITION_SENSITIVE
+	then
+		echo DOUBLE NFC and NFD are distinct on this OS/filesystem.
+	else
+		echo DOUBLE NFC and NFD are aliases on this OS/filesystem.
+	fi
+
+	if test_have_prereq UNICODE_DOUBLE_NFC_PRESERVED
+	then
+		echo Double NFC maintains original spelling.
+	else
+		echo Double NFC is modified.
+	fi
+
+	if test_have_prereq UNICODE_DOUBLE_NFD_PRESERVED
+	then
+		echo Double NFD maintains original spelling.
+	else
+		echo Double NFD is modified.
+	fi
+fi
-- 
gitgitgadget

