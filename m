Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A801C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 19:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C6120727
	for <git@archiver.kernel.org>; Fri, 15 May 2020 19:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISgvAc/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgEOTwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 15:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOTwH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 15:52:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FD2C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 12:52:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so1487891pfd.4
        for <git@vger.kernel.org>; Fri, 15 May 2020 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nw/r2eW1O4y1oBTBx4DRbn0JuW7ASenk8YOF/WxQCZ0=;
        b=ISgvAc/c4Kh3JMHQryJV/c0IwZEiBefNJx7YDbJALaa/2t3/8aigAFJU3OVWxDn4YH
         7Ek7QsGZM+M1SJ5rxN0fACrHI+KA2YFyV7ZHCds/aj0ufyD3Bz/IlVrQpkgqG9OXJmdk
         4s5TxUqJT3MR3ZaD048q9FKMt3UNrTGgNgyla2VxT8Jbj++E3cOuOwjBiATKJbi3B6/v
         1wzkw56l1fjrzO6H45E/5xmRCSvbTcBfiPBy2KvgJMatxj3ZOUvje7DABAN1aiUxHzDB
         StWuWuLv3jLfD/uzIN2xma59Xm/CBxErqgU+A9WyoL5R9mcgjb1qCy0HSA2IduQ8p9PQ
         HfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nw/r2eW1O4y1oBTBx4DRbn0JuW7ASenk8YOF/WxQCZ0=;
        b=mj/umhuycdFMraFWk7MddZeXmpCsRdS7Jj1QOckVTHdY5aNOJOY0XAOwRNnkEzynFb
         mNy3c+9MfSEHWVJr3SlBFAbyl+a9YHoVD6t1ZmBaN7luJR+LNdMH3P0HQdmn7e/vdBnj
         KsGS7ZqC8vbhF1io/E0WoD3vXVOhoqifuVEhmBhjzTyx2O2+UrJw4fPYs7Oswd+OW19l
         H+Kn915+avndgkmv/5p7wDDYLxMsS4bqeghTJs0f2c9fn0sM7IJde60TCDl093nN8nIO
         3bNjRH6BOcxrstcgQtP18DVY/O1tGVhgeF+t08Rkg983RJXwyhaC3Ea6uOZxYNiNtxiw
         06MA==
X-Gm-Message-State: AOAM532MpqKGZSoOxwNctgho2geJkPHEfHmQB/CBVfW7aw1FynWzp1ia
        cuqNBR5OCS7ZdOKNVpWhoMAMQ7k0
X-Google-Smtp-Source: ABdhPJzEncCba2d5ryjkXqgcXiO0+zSAHtwKmwlw4jk1g6aKbHkmQmFMrOJOl15QuVRX9ICRx3RGQA==
X-Received: by 2002:aa7:96b6:: with SMTP id g22mr5331164pfk.225.1589572325581;
        Fri, 15 May 2020 12:52:05 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id n67sm2329809pfn.16.2020.05.15.12.52.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 12:52:04 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     emaste@freebsd.org, sunshine@sunshineco.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2] t4210: detect REG_ILLSEQ dynamically
Date:   Fri, 15 May 2020 12:51:56 -0700
Message-Id: <20200515195157.41217-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.812.g046d49d455
In-Reply-To: <20200513111636.30818-1-carenas@gmail.com>
References: <20200513111636.30818-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

7187c7bbb8 (t4210: skip i18n tests that don't work on FreeBSD, 2019-11-27)
adds a REG_ILLSEQ prerequisite to avoid failures from the tests added with
4e2443b181 (log tests: test regex backends in "--encode=<enc>" tests,
2019-06-28), but hardcodes it to be only enabled for FreeBSD.

Instead of hardcoding the affected platform, add a test using test-tool to
make sure it can be dynamically detected in other affected systems (like
DragonFlyBSD or macOS), and while at it, enhance the tool so it can report
better on the cause of failure and be silent when needed.

To minimize changes, it is assumed the regcomp error is of the right type
since we control the only caller, and is also assumed to affect both basic
and extended syntax (only extended is tested, but both behave the same in
all three affected platforms).

The description of the first test which wasn't accurate has been corrected,
and unlike the original fix from 7187c7bbb8, that created a special case
for FreeBSD by adding REG_ILLSEQ to the common set in test-lib, this does
not need changes to test-lib and therefore had those reverted.

Only the affected engines will have their tests suppressed, which include
"fixed" if the PCRE optimization that uses LIBPCRE2 since b65abcafc7
(grep: use PCRE v2 for optimized fixed-string search, 2019-07-01) is not
available.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v2:
- address all suggestions from Eric
- reorder tests and add a helper functions (probably overly verbose) to
  clarify when the tests will be skipped (no prereq is used)

 t/helper/test-regex.c | 19 +++++++++---
 t/t4210-log-i18n.sh   | 70 ++++++++++++++++++++++++++++++++-----------
 t/test-lib.sh         |  6 ----
 3 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index 10284cc56f..7a8ddce45b 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -41,16 +41,21 @@ int cmd__regex(int argc, const char **argv)
 {
 	const char *pat;
 	const char *str;
-	int flags = 0;
+	int ret, silent = 0, flags = 0;
 	regex_t r;
 	regmatch_t m[1];
+	char errbuf[64];
 
 	if (argc == 2 && !strcmp(argv[1], "--bug"))
 		return test_regex_bug();
 	else if (argc < 3)
 		usage("test-tool regex --bug\n"
-		      "test-tool regex <pattern> <string> [<options>]");
+		      "test-tool regex [--silent] <pattern> <string> [<options>]");
 
+	if (!strcmp(argv[1], "--silent")) {
+		silent = 1;
+		argv++;
+	}
 	argv++;
 	pat = *argv++;
 	str = *argv++;
@@ -67,8 +72,14 @@ int cmd__regex(int argc, const char **argv)
 	}
 	git_setup_gettext();
 
-	if (regcomp(&r, pat, flags))
-		die("failed regcomp() for pattern '%s'", pat);
+	ret = regcomp(&r, pat, flags);
+	if (ret) {
+		if (silent)
+			return 1;
+
+		regerror(ret, &r, errbuf, sizeof(errbuf));
+		die("failed regcomp() for pattern '%s' (%s)", pat, errbuf);
+	}
 	if (regexec(&r, str, 1, m, 0))
 		return 1;
 
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index c3792081e6..a89f456817 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -10,6 +10,12 @@ latin1_e=$(printf '\351')
 # invalid UTF-8
 invalid_e=$(printf '\303\50)') # ")" at end to close opening "("
 
+if test_have_prereq GETTEXT_LOCALE &&
+	! LC_ALL=$is_IS_locale test-tool regex --silent $latin1_e $latin1_e EXTENDED
+then
+	have_reg_illseq=1
+fi
+
 test_expect_success 'create commits in different encodings' '
 	test_tick &&
 	cat >msg <<-EOF &&
@@ -56,38 +62,68 @@ test_expect_success !MINGW 'log --grep does not find non-reencoded values (latin
 	test_must_be_empty actual
 '
 
+trigger_undefined_behaviour()
+{
+	local engine=$1
+
+	case $engine in
+	fixed)
+		if test -n "$have_reg_illseq" &&
+			! test_have_prereq LIBPCRE2
+		then
+			return 0
+		else
+			return 1
+		fi
+		;;
+	basic|extended)
+		if test -n "$have_reg_illseq"
+		then
+			return 0
+		else
+			return 1
+		fi
+		;;
+	perl)
+		return 1
+		;;
+	esac
+}
+
 for engine in fixed basic extended perl
 do
 	prereq=
 	if test $engine = "perl"
 	then
-		prereq="PCRE"
-	else
-		prereq=""
+		prereq=PCRE
 	fi
 	force_regex=
 	if test $engine != "fixed"
 	then
-	    force_regex=.*
+		force_regex='.*'
 	fi
-	test_expect_success !MINGW,!REGEX_ILLSEQ,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
-		cat >expect <<-\EOF &&
-		latin1
-		utf8
-		EOF
-		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$latin1_e\" >actual &&
-		test_cmp expect actual
-	"
 
 	test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
-		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$utf8_e\" >actual &&
+		LC_ALL=$is_IS_locale git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$utf8_e\" >actual &&
 		test_must_be_empty actual
 	"
 
-	test_expect_success !MINGW,!REGEX_ILLSEQ,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
-		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$invalid_e\" >actual &&
-		test_must_be_empty actual
-	"
+	if ! trigger_undefined_behaviour $engine
+	then
+		test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep searches in log output encoding (latin1 + locale)" "
+			cat >expect <<-\EOF &&
+			latin1
+			utf8
+			EOF
+			LC_ALL=$is_IS_locale git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$latin1_e\" >actual &&
+			test_cmp expect actual
+		"
+
+		test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
+			LC_ALL=$is_IS_locale git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$invalid_e\" >actual &&
+			test_must_be_empty actual
+		"
+	fi
 done
 
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0ea1e5a05e..81473fea1d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1454,12 +1454,6 @@ case $uname_s in
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	;;
-FreeBSD)
-	test_set_prereq REGEX_ILLSEQ
-	test_set_prereq POSIXPERM
-	test_set_prereq BSLASHPSPEC
-	test_set_prereq EXECKEEPSPID
-	;;
 *)
 	test_set_prereq POSIXPERM
 	test_set_prereq BSLASHPSPEC
-- 
2.26.2.812.g046d49d455

