Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D851FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbcFYFYj (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34297 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbcFYFYH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:07 -0400
Received: by mail-lf0-f65.google.com with SMTP id l184so23684322lfl.1
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEnt+3D/n68T6V8UTjtIg6ll8nlT1SIPw/yPiHMmAVg=;
        b=npHKhFdSoq/aKVX9FFAVPEYwYpoDkCdbRYCFK9cr4R8uwQMXbx8Rxgfj3ANw8iuL9U
         5z2rCuiaxrcwKu3KaGri4ImK9xTCWuoTA8CPKsux3fycsVoBrJqWsZ4JuQnl8dLZv51o
         kfTWHvluteuFYTW/t4Pbp+yZugGb/pGQO0MMkD521UTt6LJ6ru0dB5P8egJ4EZZ7Pcjz
         eirtJYAmwjpqz57NGLHiPYzTe0+oOg15Y7Sm8hJOtnluUpXW/960D8jXbI+Pn99+Bmpx
         Oik53lfCywssx10bZmG5hQO34BIWvti6BWKZURp+eK1/hLqtiHep6PWl0dcFrdeE52Sn
         4mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEnt+3D/n68T6V8UTjtIg6ll8nlT1SIPw/yPiHMmAVg=;
        b=CiMw63T1b2EtXKwMifBR9MlMO8zsaT9dcjbd5jnKQ4bOaqCThLGeqnZOFgyBT/CCdT
         Nk8uZwuapSUPJCstRm3uMJqKxYBj6mT+d9Xkg4LKQKZaY7xUBMVsYwbRdzG3jO2bSdoS
         7dCk7S2p/wrinZ46fpWK1EjZWJhtthZ7OFrwEkf/JYtBv+qhiW9j8wypJ7OYwxqVKT3o
         7SarHak9n0YdoAjceLG89LceJpezg0baWPsoPRUU3QGwZJAepnqnwVKJmZUHORCujo7y
         wzOv4VCf75DokF/4ur6nSlF6RIfY1Z5HJuaYZ9dGBoCVyhRycuNLJeXZeiYUdtLZ++C9
         q9Hg==
X-Gm-Message-State: ALyK8tLYQvX/G4SZvEiDCom+xrsh/fde0J7JrGMpeBSkHKnNawr2OAuxIwtf4yBHwqHzAA==
X-Received: by 10.25.143.149 with SMTP id r143mr2461670lfd.165.1466832245200;
        Fri, 24 Jun 2016 22:24:05 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:04 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/12] test-regex: isolate the bug test code
Date:	Sat, 25 Jun 2016 07:22:28 +0200
Message-Id: <20160625052238.13615-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625052238.13615-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
 <20160625052238.13615-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is in preparation to turn test-regex into some generic regex
testing command.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0070-fundamental.sh |  2 +-
 test-regex.c           | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 5ed69a6..991ed2a 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -31,7 +31,7 @@ test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
 
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=1
-	test-regex
+	test-regex --bug
 '
 
 test_done
diff --git a/test-regex.c b/test-regex.c
index 0dc598e..67a1a65 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 
-int main(int argc, char **argv)
+static int test_regex_bug(void)
 {
 	char *pat = "[^={} \t]+";
 	char *str = "={}\nfred";
@@ -16,5 +16,13 @@ int main(int argc, char **argv)
 	if (m[0].rm_so == 3) /* matches '\n' when it should not */
 		die("regex bug confirmed: re-build git with NO_REGEX=1");
 
-	exit(0);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	if (argc == 2 && !strcmp(argv[1], "--bug"))
+		return test_regex_bug();
+	else
+		usage("test-regex --bug");
 }
-- 
2.8.2.526.g02eed6d

