Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C70DC3F6B0
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiG0XOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiG0XOB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:14:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC864D810
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:14:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id id17so82090wmb.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EfXI4BqFk7qqSdXMOoW1YUSBAaPHIUHmDrndxXs/XGM=;
        b=cXeA1srZE9MEQUgiTl8XxU9LzLdOj536wWJbUeb60fUD7x57dPpA78qXBDfN0vGTfE
         CyRB0iyHvYmFtT/taZbz2nIzSASP3Wp5W3DSVS5c2E5UCiHxCKQLE+m+R+aVGtD9PoFa
         XLZAYaNK8ps0ApUc7hG9WhBPltxA1haOzn0oHn5IUcJE9x7xyEbUYv05MMLAGJyRSLfx
         /Sd4wKjlxmnfmU9v8qph7gEhZKwYqr8mqHK0sctWNnAJOIOd14DdodjJEIwmsKyY96wJ
         Zat96Y+Le6Uzvspn7NXzKdpieZ1NRELKjR9kMtU0kAInGDy6nG6ikEXBtsyrsefuq2G6
         51tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EfXI4BqFk7qqSdXMOoW1YUSBAaPHIUHmDrndxXs/XGM=;
        b=CW2p3q12dIiHc9GJbUZQrBHi6Z1L1lHh7LgGn6ZeKaBhxe2ge9oX7uksewILHO6Mgj
         nn6Sz9Z0zF00tEvQbJHLxojS8g/RpLWkNlXFBTv3ZDkA+1361cAC6Cqknh+tVdIOryIA
         GWfIOaN1MT0m+KPXEEllj24PYWXgQh25JHEa6RYgP6ZT0+MK0jXIVBN1Gu6/DS0IRCVo
         D3SIHsDdlykvrhKk8lAR6wSACpbO1mA8iZZqUCWInYOewTTLeL98x3dgQjtxNT+wJF2q
         3xpoQuv8Y8l+kin6mUQ+IODTJ8wZHZsLQiTc/tRNKBIbRx1xdUrMHC4MGBGZzWYxW1nw
         B9sA==
X-Gm-Message-State: AJIora+F+TOjaXcd6etskromZEUswN7+upJl5YRIlvMV2tbggtSrpPfP
        zKxUjuxjhLV3D4kdmhNTUX+6G8t2AJXIng==
X-Google-Smtp-Source: AGRyM1shsLvLXNHxHsLl+aViHy1sEmR1hTULI3cIL5KAKmIXko4ZBFLQ7EUoGFgxZuiMoRWqD63NxQ==
X-Received: by 2002:a7b:c8ce:0:b0:3a3:2cf8:edb with SMTP id f14-20020a7bc8ce000000b003a32cf80edbmr4626256wml.70.1658963638550;
        Wed, 27 Jul 2022 16:13:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:13:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/15] tests: move copy/pasted PERL + Test::More checks to a lib-perl.sh
Date:   Thu, 28 Jul 2022 01:13:36 +0200
Message-Id: <patch-v3-08.15-53ea78bf417-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the original "perl -MTest::More" prerequisite check was added in
[1] it's been copy/pasted in [2], [3] and [4]. As we'll be changing
these codepaths in a subsequent commit let's consolidate these.

While we're at it let's move these to a lazy prereq, and make them
conform to our usual coding style (e.g. "\nthen", not "; then").

1. e46f9c8161a (t9700: skip when Test::More is not available,
   2008-06-29)
2. 5e9637c6297 (i18n: add infrastructure for translating Git with
   gettext, 2011-11-18)
3. 8d314d7afec (send-email: reduce dependencies impact on
   parse_address_line, 2015-07-07)
4. f07eeed123b (git-credential-netrc: adapt to test framework for git,
   2018-05-12)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../netrc/t-git-credential-netrc.sh           | 11 ++---------
 t/lib-perl.sh                                 | 19 +++++++++++++++++++
 t/t0202-gettext-perl.sh                       | 12 ++----------
 t/t9700-perl-git.sh                           | 11 ++---------
 4 files changed, 25 insertions(+), 28 deletions(-)
 create mode 100644 t/lib-perl.sh

diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
index 07227d02287..ff17a9460cd 100755
--- a/contrib/credential/netrc/t-git-credential-netrc.sh
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -3,16 +3,9 @@
 	cd ../../../t
 	test_description='git-credential-netrc'
 	. ./test-lib.sh
+	. "$TEST_DIRECTORY"/lib-perl.sh
 
-	if ! test_have_prereq PERL; then
-		skip_all='skipping perl interface tests, perl not available'
-		test_done
-	fi
-
-	perl -MTest::More -e 0 2>/dev/null || {
-		skip_all="Perl Test::More unavailable, skipping test"
-		test_done
-	}
+	skip_all_if_no_Test_More
 
 	# set up test repository
 
diff --git a/t/lib-perl.sh b/t/lib-perl.sh
new file mode 100644
index 00000000000..d0bf509a167
--- /dev/null
+++ b/t/lib-perl.sh
@@ -0,0 +1,19 @@
+# Copyright (c) 2022 Ævar Arnfjörð Bjarmason
+
+test_lazy_prereq PERL_TEST_MORE '
+	perl -MTest::More -e 0
+'
+
+skip_all_if_no_Test_More () {
+	if ! test_have_prereq PERL
+	then
+		skip_all='skipping perl interface tests, perl not available'
+		test_done
+	fi
+
+	if ! test_have_prereq PERL_TEST_MORE
+	then
+		skip_all="Perl Test::More unavailable, skipping test"
+		test_done
+	fi
+}
diff --git a/t/t0202-gettext-perl.sh b/t/t0202-gettext-perl.sh
index df2ea34932b..043b190626c 100755
--- a/t/t0202-gettext-perl.sh
+++ b/t/t0202-gettext-perl.sh
@@ -7,16 +7,8 @@ test_description='Perl gettext interface (Git::I18N)'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
-
-if ! test_have_prereq PERL; then
-	skip_all='skipping perl interface tests, perl not available'
-	test_done
-fi
-
-perl -MTest::More -e 0 2>/dev/null || {
-	skip_all="Perl Test::More unavailable, skipping test"
-	test_done
-}
+. "$TEST_DIRECTORY"/lib-perl.sh
+skip_all_if_no_Test_More
 
 # The external test will outputs its own plan
 test_external_has_tap=1
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 102c133112c..17fc43f6e57 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -5,16 +5,9 @@
 
 test_description='perl interface (Git.pm)'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-perl.sh
 
-if ! test_have_prereq PERL; then
-	skip_all='skipping perl interface tests, perl not available'
-	test_done
-fi
-
-perl -MTest::More -e 0 2>/dev/null || {
-	skip_all="Perl Test::More unavailable, skipping test"
-	test_done
-}
+skip_all_if_no_Test_More
 
 # set up test repository
 
-- 
2.37.1.1127.g4ecf1c08f67

