Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3E0C433E1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8A161976
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhC2Qcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhC2QcB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:32:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025D4C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:32:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c8so13472433wrq.11
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6GjVG4X5zPQsq1bHz1xHKvB4uYAlRO2v7eHkNeoN/U=;
        b=NPE2SK8M9YYMt9puXFmIE+4i4pVddX31f/71pqnXjVYZuuGHy4zPO1f6Lg1QVnB1h+
         E9UfY3MuGC/tGgHoGsakg/JIdiEV2WgmtrMfubPbJF2Dw6ZMEEZgY1jyJ+4Ix2C2sYY4
         YhVRDcNlX+4JuXQNTgLYudONOvH9q8/qYXlT2yUKhmFtmY+KZtOsJVz1cB67rMkBgX0j
         EH5+cj5w29X8e3JDTZXcHy9Wriabnoh3fLp2JBqFCwFl2SPpCV5MKzvlWWCbPOuCxnLl
         uTYbjRG8bVlzkPQrGQ5e9knF7YW6QF8sD9rlzQkMMGNRRzFUbV5MRhJ2igMBbievoPAc
         Mqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6GjVG4X5zPQsq1bHz1xHKvB4uYAlRO2v7eHkNeoN/U=;
        b=jtAY2lSlHh3Mh2FU9isPjor/5fWueSnqYmIojNoC6n42Q70Wr/ptLCnESXLzmBQkQp
         Bm/dyK8cG1qZd4/xoCU1Aph9xCYKiws7syDXeHPgMAoFJ24ybFZNH3DsbhG9pB2n45Qr
         1YO+myi+8yu/Wpi1WxZiZnm/7GHRu6oMaFc4K9PbxP660lNNmwlpWBGyXO1s4TxH8Ukj
         ksW33wTPxgdOD0jPWH56hVXYgzvlmwywJo6JXwV6HuVuTOGcq8iWwffuF8DLi1wYUAuQ
         h6/a9hdTNNhm+ezbKAt74EfMISOl07WPrwExv35WCo9qUxls4CIYZ/EoNTImGahhLkzW
         Kq/w==
X-Gm-Message-State: AOAM531kB9O63gO5UX/T+ZtCdI+xKHx5qiZs083e/Ei/qGngqXEtz7uc
        7gP1yUHGb0erbs1idgKG671LyVsXVQY3Eg==
X-Google-Smtp-Source: ABdhPJxd7S+BTiAyN4P17YpCSEfdOkBa53+BFVB5sF0myHUutJQbZrdkGpkHrZEbzyehoVGFpqKX2g==
X-Received: by 2002:a5d:654a:: with SMTP id z10mr29302133wrv.335.1617035519424;
        Mon, 29 Mar 2021 09:31:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm25410464wmg.41.2021.03.29.09.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:31:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] Makefile: make INSTALL_SYMLINKS affect the build directory
Date:   Mon, 29 Mar 2021 18:31:42 +0200
Message-Id: <patch-4.7-1089ca3d184-20210329T162327Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com> <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the INSTALL_SYMLINKS flag to also affect whether a built-in
like e.g. git-fetch is a symlink or not in git's build directory.

This doesn't matter for anything other than as an aid to developers
who might be confused about their build not matching the installation,
and who'd like to be reminded that e.g. "git-fetch" is a built-in by
"ls" coloring appropriately it as a symlink.

In order to make this work we need to rebuild the relevant programs
when the INSTALL_SYMLINKS flag changes. This also ensures that we'll
install the right thing, we don't want a different "INSTALL_SYMLINKS"
setting during "make all" and "make install" to result in a broken
installation.

We will do the wrong thing here if both the SKIP_DASHED_BUILT_INS and
INSTALL_SYMLINKS are being flipped. But that's not a new bug:

A build with "INSTALL_SYMLINKS=Y SKIP_DASHED_BUILT_INS=" will result
in e.g. "git-fetch" being a symlink. When building again with
"INSTALL_SYMLINKS= SKIP_DASHED_BUILT_INS=Y", only unconditionally
built programs such as "git-upload-pack" will correctly be flipped to
a hardlink, but e.g. "git-fetch" will be left as a symlink.

That's an existing bug (or unexpected behavior) in the
SKIP_DASHED_BUILT_INS flag, not something new being introduced or made
worse here. It's a bit more noticeable now as we might not expect
these now-stale symlinks to be left behind, and "ls" (in some
configurations) will color them prominently.

But we'll still do the right thing on "make install" since we'll
ignore the likes of "git-fetch" there under "SKIP_DASHED_BUILT_INS=Y".
Under "SKIP_DASHED_BUILT_INS=" we'll correctly flip the symlink to a
hardlink or vice-versa if needed before installation.

Still, we should get around to fixing that SKIP_DASHED_BUILT_INS. You
can't reliably set that flag to "Y" for checking whether the tests
rely on the now-skipped dashed built-ins without first running "make
clean" (or knowing you've always been building with
SKIP_DASHED_BUILT_INS=Y).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore |  1 +
 Makefile   | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3dcdb6bb5ab..f90aa21b23b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -5,6 +5,7 @@
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
+/GIT-LNCPFLAGS
 /GIT-PREFIX
 /GIT-PERL-DEFINES
 /GIT-PERL-HEADER
diff --git a/Makefile b/Makefile
index a4784f28f5b..29d9bade5a8 100644
--- a/Makefile
+++ b/Makefile
@@ -337,6 +337,11 @@ all::
 # NO_INSTALL_HARDLINKS. This will not produce any indirect symlinks, we will
 # always symlink to the final target directly.
 #
+# NO_INSTALL_HARDLINKS which will also use symlinking by indirection
+# within the same directory in some cases, INSTALL_SYMLINKS will
+# always symlink to the final target directly. This option also
+# affects dashed built-ins in the build directory pre-installation.
+#
 # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
 # programs as a tar, where bin/ and libexec/ might be on different file systems.
 #
@@ -2197,9 +2202,12 @@ version.sp version.s version.o: EXTRA_CPPFLAGS = \
 		GIT_CEILING_DIRECTORIES="$(CURDIR)/.." \
 		git rev-parse -q --verify HEAD 2>/dev/null)"'
 
+$(BUILT_INS): GIT-LNCPFLAGS
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
-	./ln-or-cp.sh $< $@
+	./ln-or-cp.sh \
+		--install-symlinks "$(INSTALL_SYMLINKS)" \
+		$< $@
 
 config-list.h: generate-configlist.sh
 
@@ -2548,9 +2556,12 @@ git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS) && \
 	mv $@+ $@
 
+$(REMOTE_CURL_ALIASES): GIT-LNCPFLAGS
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
-	./ln-or-cp.sh $< $@
+	./ln-or-cp.sh \
+		--install-symlinks "$(INSTALL_SYMLINKS)" \
+		$< $@
 
 $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) $(filter %.o,$^) \
@@ -2742,6 +2753,10 @@ GIT-LDFLAGS: FORCE
 		echo "$$FLAGS" >GIT-LDFLAGS; \
             fi
 
+GIT-LNCPFLAGS: FORCE
+	@echo INSTALL_SYMLINKS=\''$(subst ','\'',$(subst ','\'',$(INSTALL_SYMLINKS)))'\' >$@+
+	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+
 # We need to apply sq twice, once to protect from the shell
 # that runs GIT-BUILD-OPTIONS, and then again to protect it
 # and the first level quoting from the shell that runs "echo".
-- 
2.31.1.461.gd47399f6574

