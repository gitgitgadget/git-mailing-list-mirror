Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D53CC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349366AbiEZVud (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349297AbiEZVth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246EE8BA1
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p10so3627692wrg.12
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cTk9CmwWw4iGOz0CS3tNgQG+VGNLJ2QH91BcLkMnKNg=;
        b=dK3hBqPDm6zGvHkOKfVQ3guaLFL2NGLVftyaOFeqHnSFlMTee9jMzHfUcDEIVM0d/N
         9E9Expi2Nuxec8+ziRNAgTO0oVXY7bD43wPpEtpzl0KnKbqY2DQGs8aulQ2AzKabEsgo
         GuuXxSipR9aJu3WoPaCag+nV5sZUiCisi6+UoNhgQSxtYlujCr8WmZBNk9dEZxskTe62
         7zrIxjidQEa2uFJoL57yiTLRh3IZdox2Z77+tEBkZnmJEFNI7San7UZAV62CBOD5EogC
         Fe2Z41V8YR1bcGcfYtB6/4GeHlnNrkC0aPs0+4hNK7EYXzjhxlPf2UUBhndifEnqjAon
         6tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cTk9CmwWw4iGOz0CS3tNgQG+VGNLJ2QH91BcLkMnKNg=;
        b=Eqi2RtSbpSWjOfDAqDOYBsNFTIn/CN4Ol/wnh0TGLGyUhx+Iuj9ylHQicwiW0+pMFs
         pbzHmmYh1rlqBEu9Ik1SiKrMEIfikHfawXnHTDGR7Gm/G79vXM+M7/2IpPh+aoKnV7Ev
         pS8TmDPul+BLpTBY0sc1lgQvvGMEsVQOsgLjnsh7rlHrfcJ8aRD+RHuEwCOKB+Z4K4k7
         qW+7whcjOO6zz7MivRzSJq6CJLfWwTYEjbdTtmBYlBQSAxvjusjWCMfASLtMcHHonbP9
         1/mE6E9cLQ+QFwC1gpmETVNO72Haj5uCqRVt7zHnEoE/+bDD8EyfLyeyfKHlWQVFVIyj
         0htQ==
X-Gm-Message-State: AOAM531q/NfCXCdpOdNWeOsxZC3wYWDP9QM2v+9AK8nkNFjuO2b9QTKD
        o5aKmwU4Rmv3y9zR2KZunKxYukVmwgI=
X-Google-Smtp-Source: ABdhPJzeFJLVltElqHWux/QKYcvGaMW7m68h2NFYKBy6Lrnd5sGSA0d1QxdJkJRl9f1dLiDkeFAY9A==
X-Received: by 2002:adf:fb4c:0:b0:20f:d4e7:b84f with SMTP id c12-20020adffb4c000000b0020fd4e7b84fmr19531533wrs.406.1653601774032;
        Thu, 26 May 2022 14:49:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s22-20020a1cf216000000b003974ba5cacdsm223662wmc.35.2022.05.26.14.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:33 -0700 (PDT)
Message-Id: <e5a7f05d9d414a8b680114f3a71739a20088bae4.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:21 +0000
Subject: [PATCH v9 27/30] t/lib-unicode-nfc-nfd: helper prereqs for testing
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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
 t/lib-unicode-nfc-nfd.sh | 162 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100755 t/lib-unicode-nfc-nfd.sh

diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
new file mode 100755
index 00000000000..22232247efc
--- /dev/null
+++ b/t/lib-unicode-nfc-nfd.sh
@@ -0,0 +1,162 @@
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
+test_lazy_prereq UNICODE_NFC_PRESERVED '
+	mkdir c_${utf8_nfc} &&
+	ls | test-tool hexdump >dump &&
+	grep "63 5f c3 a9" dump
+'
+
+# Is the spelling of an NFD pathname preserved on disk?
+#
+test_lazy_prereq UNICODE_NFD_PRESERVED '
+	mkdir d_${utf8_nfd} &&
+	ls | test-tool hexdump >dump &&
+	grep "64 5f 65 cc 81" dump
+'
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
+	ls | test-tool hexdump >dump &&
+	grep "63 5f e1 bd a7" dump
+'
+
+# See if the NFD spelling appears on the disk.
+#
+test_lazy_prereq UNICODE_DOUBLE_NFD_PRESERVED '
+	mkdir d_${greek_nfd2} &&
+	ls | test-tool hexdump >dump &&
+	grep "64 5f cf 89 cc 94 cd 82" dump
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

