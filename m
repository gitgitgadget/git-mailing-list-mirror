Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E4C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiGTVWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiGTVWU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023855D0DC
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d8so7885491wrp.6
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=El4WGlebg5bL75LDcHbBlcHtTyg6ltj35s+A4yMquS4=;
        b=LNbsHvKzznc+lD5imXoOCcJoy59LHKO/8XjNykwGmiypph+CJQm5w99v658qKEyHgF
         2MoEF3mUxyCEokBi64brxhPF2ZE2pWeUyaeldboqo6vUX0cpinsz7M+VogjME6X2DFDL
         Z1B7BhP8rrnqwCC5WU8HQyuZETgmn/7JppBUC/52JmoswRYBUDWrjZoHcpcNhUpTksqn
         dQ/n9cXrvU0WT8yUN8sS2qz/QIb9wQsiJZgj89gySBOwVHMcTiqDFMnhOJpDguPYQGdG
         yX47f2DoVRQ3UHyJL5jic9mmO8iBFMJiALEh7yDvxi5sGHrGlWt6d0FeA6xKlBnt6q6J
         wXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=El4WGlebg5bL75LDcHbBlcHtTyg6ltj35s+A4yMquS4=;
        b=3a5jTFBj5cbjohd9FC/f4IqukU3y/TYPAjNUMywSME+S5eIYuIduloG83yeZjIU/3q
         5tdZXRw78FhGqK9Eu8pbMsGn+cYm35emeuIXqbU7zb0UXBP6+H+IEoVUZy0RHE2x8l7e
         DyuBEg1zmteAo8I/uYdGnTgpODjlN7YTJj9X9aVLSeXL99giBIOGJYi+Sek6rpwasQaB
         LauHvTrgFFaZly5k6UBd1qEhbG2x+4Gy/7yjXuplH+hA4YhiHw97O04C70c6q36Aru8Y
         xE5+m9Mf8KBqCp8dIQgbVbEHr6PX/F6SYcQG5nzoVCvRC6qHsyGR1Iy0co04DESZ1ZyC
         jZ4g==
X-Gm-Message-State: AJIora/QMP36fet6AAATQtoXTHY3Qg/O06/ZnOqXTyZ6NBDm7vIW0xt8
        VtGkblkRiQZq6SoFx+cmyDKgLgHZsqzKDw==
X-Google-Smtp-Source: AGRyM1ux5TfBq5ADRJDMx0xQzZbjs2RXU/94HDTMPdaJbJ1WVOlFkc1uqjE6dKRVj8w9sHcQKLqKKA==
X-Received: by 2002:a5d:648b:0:b0:21d:a61c:a9c9 with SMTP id o11-20020a5d648b000000b0021da61ca9c9mr32250387wri.268.1658352135237;
        Wed, 20 Jul 2022 14:22:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/14] tests: move copy/pasted PERL + Test::More checks to a lib-perl.sh
Date:   Wed, 20 Jul 2022 23:21:46 +0200
Message-Id: <patch-v2-08.14-987d9d0e98c-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
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
2.37.1.1064.gc96144cf387

