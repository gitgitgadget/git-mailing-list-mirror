From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v8 3/4] tests: add new test for the url_normalize function
Date: Mon, 22 Jul 2013 05:56:43 -0700
Message-ID: <60d85be89d27515d913ae15e10c332f@f74d39fa044aa309eaea14b9f57fe79>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 22 14:57:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Ffp-0001iC-Uu
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 14:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab3GVM5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 08:57:04 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:62309 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab3GVM5B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 08:57:01 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so6991914pad.2
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+vRV4ngjGAqr8hI8lyDUIMu5hpyHGNQgzCH9K8u+qw=;
        b=RcK+u94bBy12oS7x+/3bA6MgFBOZdmkKcCfdh8HYvwzn+TqN2fig2tzJPA9sBxSX+l
         dL7x9E6DE8f9PVNkX6sEbUUV7T/8s7p8n0F5umZN+aIoVCi78ReAiJMj2kzHkZ9lCZzo
         I+ceMhr9T4z9X7G5/6ur2vMsQaVKc+asUPW6Z1A1ltcw+7WJpb+rky6jREQ4AyNJ98kE
         rEiS1ec6o3kkoqoYtGc846gVKqp4Pu/42FdF7YgZUjefkPjusUdBH6tiSwK6cT9K3d1e
         ptLb7OaVDWfcaSConR8j5tZdkX8cxiQp7w8rwupXXIl8SLHXm94t+GZwmckrnYUOojqt
         y+lw==
X-Received: by 10.68.171.35 with SMTP id ar3mr30504642pbc.61.1374497820047;
        Mon, 22 Jul 2013 05:57:00 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id x8sm35698437pbb.39.2013.07.22.05.56.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 05:56:59 -0700 (PDT)
In-Reply-To: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230979>

In order to perform sane URL matching for http.<url>.* options,
http.c normalizes URLs before performing matches.

A new test-url-normalize test program is introduced along with
a new t5200-url-normalize.sh script to run the tests.

Since the url_normalize function currently lives in http.c this
test will be skipped if NO_CURL is defined since http.c is skipped
in that case.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 .gitignore               |   1 +
 Makefile                 |   5 ++
 t/.gitattributes         |   1 +
 t/t5200-url-normalize.sh | 198 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t5200/README           |  18 +++++
 t/t5200/config-1         |   8 ++
 t/t5200/config-2         |   3 +
 t/t5200/url-1            | Bin 0 -> 20 bytes
 t/t5200/url-10           | Bin 0 -> 23 bytes
 t/t5200/url-11           | Bin 0 -> 25 bytes
 t/t5200/url-2            | Bin 0 -> 20 bytes
 t/t5200/url-3            | Bin 0 -> 23 bytes
 t/t5200/url-4            | Bin 0 -> 23 bytes
 t/t5200/url-5            | Bin 0 -> 23 bytes
 t/t5200/url-6            | Bin 0 -> 23 bytes
 t/t5200/url-7            | Bin 0 -> 23 bytes
 t/t5200/url-8            | Bin 0 -> 23 bytes
 t/t5200/url-9            | Bin 0 -> 23 bytes
 test-url-normalize.c     | 131 +++++++++++++++++++++++++++++++
 19 files changed, 365 insertions(+)
 create mode 100755 t/t5200-url-normalize.sh
 create mode 100644 t/t5200/README
 create mode 100644 t/t5200/config-1
 create mode 100644 t/t5200/config-2
 create mode 100644 t/t5200/url-1
 create mode 100644 t/t5200/url-10
 create mode 100644 t/t5200/url-11
 create mode 100644 t/t5200/url-2
 create mode 100644 t/t5200/url-3
 create mode 100644 t/t5200/url-4
 create mode 100644 t/t5200/url-5
 create mode 100644 t/t5200/url-6
 create mode 100644 t/t5200/url-7
 create mode 100644 t/t5200/url-8
 create mode 100644 t/t5200/url-9
 create mode 100644 test-url-normalize.c

diff --git a/.gitignore b/.gitignore
index 6669bf0..cd97e16 100644
--- a/.gitignore
+++ b/.gitignore
@@ -198,6 +198,7 @@
 /test-string-list
 /test-subprocess
 /test-svn-fe
+/test-url-normalize
 /test-wildmatch
 /common-cmds.h
 *.tar.gz
diff --git a/Makefile b/Makefile
index 0f931a2..f83879c 100644
--- a/Makefile
+++ b/Makefile
@@ -567,6 +567,7 @@ TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
+TEST_PROGRAMS_NEED_X += test-url-normalize
 TEST_PROGRAMS_NEED_X += test-wildmatch
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
@@ -2235,6 +2236,10 @@ test-parse-options$X: parse-options.o parse-options-cb.o
 
 test-svn-fe$X: vcs-svn/lib.a
 
+test-url-normalize$X: test-url-normalize.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+
 .PRECIOUS: $(TEST_OBJS)
 
 test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
diff --git a/t/.gitattributes b/t/.gitattributes
index 1b97c54..f6f1df3 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1 +1,2 @@
 t[0-9][0-9][0-9][0-9]/* -whitespace
+t5200/url-* binary
diff --git a/t/t5200-url-normalize.sh b/t/t5200-url-normalize.sh
new file mode 100755
index 0000000..d2dd886
--- /dev/null
+++ b/t/t5200-url-normalize.sh
@@ -0,0 +1,198 @@
+#!/bin/sh
+
+test_description='url normalization'
+. ./test-lib.sh
+
+if test -n "$NO_CURL"; then
+	skip_all='skipping test, git built without http support'
+	test_done
+fi
+
+# The base name of the test url files
+tu="$TEST_DIRECTORY/t5200/url"
+
+# The base name of the test config files
+tc="$TEST_DIRECTORY/t5200/config"
+
+# Note that only file: URLs should be allowed without a host
+
+test_expect_success 'url scheme' '
+	! test-url-normalize "" &&
+	! test-url-normalize "_" &&
+	! test-url-normalize "scheme" &&
+	! test-url-normalize "scheme:" &&
+	! test-url-normalize "scheme:/" &&
+	! test-url-normalize "scheme://" &&
+	! test-url-normalize "file" &&
+	! test-url-normalize "file:" &&
+	! test-url-normalize "file:/" &&
+	test-url-normalize "file://" &&
+	! test-url-normalize "://acme.co" &&
+	! test-url-normalize "x_test://acme.co" &&
+	! test-url-normalize "-test://acme.co" &&
+	! test-url-normalize "0test://acme.co" &&
+	! test-url-normalize "+test://acme.co" &&
+	! test-url-normalize ".test://acme.co" &&
+	! test-url-normalize "schem%6e://" &&
+	test-url-normalize "x-Test+v1.0://acme.co" &&
+	test "$(test-url-normalize -p "AbCdeF://x.Y")" = "abcdef://x.y/"
+'
+
+test_expect_success 'url authority' '
+	! test-url-normalize "scheme://user:pass@" &&
+	! test-url-normalize "scheme://?" &&
+	! test-url-normalize "scheme://#" &&
+	! test-url-normalize "scheme:///" &&
+	! test-url-normalize "scheme://:" &&
+	! test-url-normalize "scheme://:555" &&
+	test-url-normalize "file://user:pass@" &&
+	test-url-normalize "file://?" &&
+	test-url-normalize "file://#" &&
+	test-url-normalize "file:///" &&
+	test-url-normalize "file://:" &&
+	! test-url-normalize "file://:555" &&
+	test-url-normalize "scheme://user:pass@host" &&
+	test-url-normalize "scheme://@host" &&
+	test-url-normalize "scheme://%00@host" &&
+	! test-url-normalize "scheme://%%@host" &&
+	! test-url-normalize "scheme://host_" &&
+	test-url-normalize "scheme://user:pass@host/" &&
+	test-url-normalize "scheme://@host/" &&
+	test-url-normalize "scheme://host/" &&
+	test-url-normalize "scheme://host?x" &&
+	test-url-normalize "scheme://host#x" &&
+	test-url-normalize "scheme://host/@" &&
+	test-url-normalize "scheme://host?@x" &&
+	test-url-normalize "scheme://host#@x" &&
+	test-url-normalize "scheme://[::1]" &&
+	test-url-normalize "scheme://[::1]/" &&
+	! test-url-normalize "scheme://hos%41/" &&
+	test-url-normalize "scheme://[invalid....:/" &&
+	test-url-normalize "scheme://invalid....:]/" &&
+	! test-url-normalize "scheme://invalid....:[/" &&
+	! test-url-normalize "scheme://invalid....:["
+'
+
+test_expect_success 'url port checks' '
+	test-url-normalize "xyz://q@some.host:" &&
+	test-url-normalize "xyz://q@some.host:456/" &&
+	! test-url-normalize "xyz://q@some.host:0" &&
+	! test-url-normalize "xyz://q@some.host:0000000" &&
+	test-url-normalize "xyz://q@some.host:0000001?" &&
+	test-url-normalize "xyz://q@some.host:065535#" &&
+	test-url-normalize "xyz://q@some.host:65535" &&
+	! test-url-normalize "xyz://q@some.host:65536" &&
+	! test-url-normalize "xyz://q@some.host:99999" &&
+	! test-url-normalize "xyz://q@some.host:100000" &&
+	! test-url-normalize "xyz://q@some.host:100001" &&
+	test-url-normalize "http://q@some.host:80" &&
+	test-url-normalize "https://q@some.host:443" &&
+	test-url-normalize "http://q@some.host:80/" &&
+	test-url-normalize "https://q@some.host:443?" &&
+	! test-url-normalize "http://q@:8008" &&
+	! test-url-normalize "http://:8080" &&
+	! test-url-normalize "http://:" &&
+	test-url-normalize "xyz://q@some.host:456/" &&
+	test-url-normalize "xyz://[::1]:456/" &&
+	test-url-normalize "xyz://[::1]:/" &&
+	! test-url-normalize "xyz://[::1]:000/" &&
+	! test-url-normalize "xyz://[::1]:0%300/" &&
+	! test-url-normalize "xyz://[::1]:0x80/" &&
+	! test-url-normalize "xyz://[::1]:4294967297/" &&
+	! test-url-normalize "xyz://[::1]:030f/"
+'
+
+test_expect_success 'url port normalization' '
+	test "$(test-url-normalize -p "http://x:800")" = "http://x:800/" &&
+	test "$(test-url-normalize -p "http://x:0800")" = "http://x:800/" &&
+	test "$(test-url-normalize -p "http://x:00000800")" = "http://x:800/" &&
+	test "$(test-url-normalize -p "http://x:065535")" = "http://x:65535/" &&
+	test "$(test-url-normalize -p "http://x:1")" = "http://x:1/" &&
+	test "$(test-url-normalize -p "http://x:80")" = "http://x/" &&
+	test "$(test-url-normalize -p "http://x:080")" = "http://x/" &&
+	test "$(test-url-normalize -p "http://x:000000080")" = "http://x/" &&
+	test "$(test-url-normalize -p "https://x:443")" = "https://x/" &&
+	test "$(test-url-normalize -p "https://x:0443")" = "https://x/" &&
+	test "$(test-url-normalize -p "https://x:000000443")" = "https://x/"
+'
+
+test_expect_success 'url general escapes' '
+	! test-url-normalize "http://x.y?%fg" &&
+	test "$(test-url-normalize -p "X://W/%7e%41^%3a")" = "x://w/~A%5E%3A" &&
+	test "$(test-url-normalize -p "X://W/:/?#[]@")" = "x://w/:/?#[]@" &&
+	test "$(test-url-normalize -p "X://W/$&()*+,;=")" = "x://w/$&()*+,;=" &&
+	test "$(test-url-normalize -p "X://W/'\''")" = "x://w/'\''" &&
+	test "$(test-url-normalize -p "X://W?'\!'")" = "x://w/?'\!'"
+'
+
+test_expect_success 'url high-bit escapes' '
+	test "$(test-url-normalize -p "$(cat "$tu-1")")" = "x://q/%01%02%03%04%05%06%07%08%0E%0F%10%11%12" &&
+	test "$(test-url-normalize -p "$(cat "$tu-2")")" = "x://q/%13%14%15%16%17%18%19%1B%1C%1D%1E%1F%7F" &&
+	test "$(test-url-normalize -p "$(cat "$tu-3")")" = "x://q/%80%81%82%83%84%85%86%87%88%89%8A%8B%8C%8D%8E%8F" &&
+	test "$(test-url-normalize -p "$(cat "$tu-4")")" = "x://q/%90%91%92%93%94%95%96%97%98%99%9A%9B%9C%9D%9E%9F" &&
+	test "$(test-url-normalize -p "$(cat "$tu-5")")" = "x://q/%A0%A1%A2%A3%A4%A5%A6%A7%A8%A9%AA%AB%AC%AD%AE%AF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-6")")" = "x://q/%B0%B1%B2%B3%B4%B5%B6%B7%B8%B9%BA%BB%BC%BD%BE%BF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-7")")" = "x://q/%C0%C1%C2%C3%C4%C5%C6%C7%C8%C9%CA%CB%CC%CD%CE%CF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-8")")" = "x://q/%D0%D1%D2%D3%D4%D5%D6%D7%D8%D9%DA%DB%DC%DD%DE%DF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-9")")" = "x://q/%E0%E1%E2%E3%E4%E5%E6%E7%E8%E9%EA%EB%EC%ED%EE%EF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-10")")" = "x://q/%F0%F1%F2%F3%F4%F5%F6%F7%F8%F9%FA%FB%FC%FD%FE%FF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-11")")" = "x://q/%C2%80%DF%BF%E0%A0%80%EF%BF%BD%F0%90%80%80%F0%AF%BF%BD"
+'
+
+test_expect_success 'url username/password escapes' '
+	test "$(test-url-normalize -p "x://%41%62(^):%70+d@foo")" = "x://Ab(%5E):p+d@foo/"
+'
+
+test_expect_success 'url normalized lengths' '
+	test "$(test-url-normalize -l "Http://%4d%65:%4d^%70@The.Host")" = 25 &&
+	test "$(test-url-normalize -l "http://%41:%42@x.y/%61/")" = 17 &&
+	test "$(test-url-normalize -l "http://@x.y/^")" = 15
+'
+
+test_expect_success 'url . and .. segments' '
+	test "$(test-url-normalize -p "x://y/.")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/./")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/a/.")" = "x://y/a" &&
+	test "$(test-url-normalize -p "x://y/a/./")" = "x://y/a/" &&
+	test "$(test-url-normalize -p "x://y/.?")" = "x://y/?" &&
+	test "$(test-url-normalize -p "x://y/./?")" = "x://y/?" &&
+	test "$(test-url-normalize -p "x://y/a/.?")" = "x://y/a?" &&
+	test "$(test-url-normalize -p "x://y/a/./?")" = "x://y/a/?" &&
+	test "$(test-url-normalize -p "x://y/a/./b/.././../c")" = "x://y/c" &&
+	test "$(test-url-normalize -p "x://y/a/./b/../.././c/")" = "x://y/c/" &&
+	test "$(test-url-normalize -p "x://y/a/./b/.././../c/././.././.")" = "x://y/" &&
+	! test-url-normalize "x://y/a/./b/.././../c/././.././.." &&
+	test "$(test-url-normalize -p "x://y/a/./?/././..")" = "x://y/a/?/././.." &&
+	test "$(test-url-normalize -p "x://y/%2e/")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/%2E/")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/a/%2e./")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/b/.%2E/")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/c/%2e%2E/")" = "x://y/"
+'
+
+# http://@foo specifies an empty user name but does not specify a password
+# http://foo  specifies neither a user name nor a password
+# So they should not be equivalent
+test_expect_success 'url equivalents' '
+	test-url-normalize "httP://x" "Http://X/" &&
+	test-url-normalize "Http://%4d%65:%4d^%70@The.Host" "hTTP://Me:%4D^p@the.HOST:80/" &&
+	! test-url-normalize "https://@x.y/^" "httpS://x.y:443/^" &&
+	test-url-normalize "https://@x.y/^" "httpS://@x.y:0443/^" &&
+	test-url-normalize "https://@x.y/^/../abc" "httpS://@x.y:0443/abc" &&
+	test-url-normalize "https://@x.y/^/.." "httpS://@x.y:0443/"
+'
+
+test_expect_success 'url config normalization matching' '
+	test "$(test-url-normalize -c "$tc-1" "useragent" "https://other.example.com/")" = "other-agent" &&
+	test "$(test-url-normalize -c "$tc-1" "useragent" "https://example.com/")" = "example-agent" &&
+	test "$(test-url-normalize -c "$tc-1" "sslVerify" "https://example.com/")" = "false" &&
+	test "$(test-url-normalize -c "$tc-1" "useragent" "https://example.com/path/sub")" = "path-agent" &&
+	test "$(test-url-normalize -c "$tc-1" "sslVerify" "https://example.com/path/sub")" = "false" &&
+	test "$(test-url-normalize -c "$tc-1" "noEPSV" "https://elsewhere.com/")" = "true" &&
+	test "$(test-url-normalize -c "$tc-1" "noEPSV" "https://example.com")" = "true" &&
+	test "$(test-url-normalize -c "$tc-1" "noEPSV" "https://example.com/path")" = "true" &&
+	test "$(test-url-normalize -c "$tc-2" "useragent" "HTTPS://example.COM/p%61th")" = "example-agent" &&
+	test "$(test-url-normalize -c "$tc-2" "sslVerify" "HTTPS://example.COM/p%61th")" = "false"
+'
+
+test_done
diff --git a/t/t5200/README b/t/t5200/README
new file mode 100644
index 0000000..e3a67d9
--- /dev/null
+++ b/t/t5200/README
@@ -0,0 +1,18 @@
+The url data files in this directory contain URLs with characters
+in the range 0x01-0x1f and 0x7f-0xff to test the proper normalization
+of unprintable characters.
+
+A select few characters in the 0x01-0x1f range are skipped to help
+avoid problems running the test itself.
+
+The urls are in test files in this directory rather than being
+embedded in the test script for portability.
+
+The config data files in this directory represent configurations
+to be parsed by http_options so that the final option value can be
+tested.
+
+The config files may contain more than one same-named section to
+simulate having a system, global and .git config file.
+
+
diff --git a/t/t5200/config-1 b/t/t5200/config-1
new file mode 100644
index 0000000..8aaf23c
--- /dev/null
+++ b/t/t5200/config-1
@@ -0,0 +1,8 @@
+[http]
+	useragent = other-agent
+	noEPSV = true
+[http "https://example.com"]
+	useragent = example-agent
+	sslVerify = false
+[http "https://example.com/path"]
+	useragent = path-agent
diff --git a/t/t5200/config-2 b/t/t5200/config-2
new file mode 100644
index 0000000..749f4bd
--- /dev/null
+++ b/t/t5200/config-2
@@ -0,0 +1,3 @@
+[http "https://example.com/path"]
+	useragent = example-agent
+	sslVerify = false
diff --git a/t/t5200/url-1 b/t/t5200/url-1
new file mode 100644
index 0000000000000000000000000000000000000000..519019c5ce6c58478f048a2f39e2321370d318c6
GIT binary patch
literal 20
bcmb=h($_E4XJle#VP#|I;Nuq%6ygE^Admtt

literal 0
HcmV?d00001

diff --git a/t/t5200/url-10 b/t/t5200/url-10
new file mode 100644
index 0000000000000000000000000000000000000000..b9965de6a5d74b122179821212b2c27c8ae03e80
GIT binary patch
literal 23
hcmV+y0O<dCIxjDAFYxj5^Yr!h_xSnx`~3a>{|dCd5i<Y)

literal 0
HcmV?d00001

diff --git a/t/t5200/url-11 b/t/t5200/url-11
new file mode 100644
index 0000000000000000000000000000000000000000..f0a50f10096a20d597f40c775f09a71276e0050a
GIT binary patch
literal 25
hcmb=h($_E4Kh$u4|APe$@AvQhFrlI0!}|Suxd5(W4xs=5

literal 0
HcmV?d00001

diff --git a/t/t5200/url-2 b/t/t5200/url-2
new file mode 100644
index 0000000000000000000000000000000000000000..43334b05b2de3794d6020abd96e634a4e9e49cb0
GIT binary patch
literal 20
bcmb=h($_E47Zwo}6PJ*bmXVc{ujc{)C{+Vx

literal 0
HcmV?d00001

diff --git a/t/t5200/url-3 b/t/t5200/url-3
new file mode 100644
index 0000000000000000000000000000000000000000..7378c7bec247b996bc67b00a05ed89cf47d4b7a7
GIT binary patch
literal 23
ecmb=h($_E4Z)j|4ZfR|6@96C6?&<C8=K=t7Jqj}b

literal 0
HcmV?d00001

diff --git a/t/t5200/url-4 b/t/t5200/url-4
new file mode 100644
index 0000000000000000000000000000000000000000..220b198c97f942fea4960f51a2105cc42261061a
GIT binary patch
literal 23
hcmV+y0O<dCIxjDAFOZRvla!T~mzbHFo1C4Vp9*`u3o`%!

literal 0
HcmV?d00001

diff --git a/t/t5200/url-5 b/t/t5200/url-5
new file mode 100644
index 0000000000000000000000000000000000000000..1ccd9277792840955bb124bdde21f4b08bcccb63
GIT binary patch
literal 23
hcmV+y0O<dCIxjDAFQB2Kqok##r>Lo_tE{cAuL^}d3^M=#

literal 0
HcmV?d00001

diff --git a/t/t5200/url-6 b/t/t5200/url-6
new file mode 100644
index 0000000000000000000000000000000000000000..e8283aac6dff049d3e02454db6e684c5790a5996
GIT binary patch
literal 23
hcmV+y0O<dCIxjDAFR-z)v$VCgx45~wyS%-=zY31M4Kn}$

literal 0
HcmV?d00001

diff --git a/t/t5200/url-7 b/t/t5200/url-7
new file mode 100644
index 0000000000000000000000000000000000000000..fa7c10b615259deefd15b638b021da7c60eba1b2
GIT binary patch
literal 23
hcmV+y0O<dCIxjDAFTlaV!^FkL$H>Xb%goKr&kC454l@7%

literal 0
HcmV?d00001

diff --git a/t/t5200/url-8 b/t/t5200/url-8
new file mode 100644
index 0000000000000000000000000000000000000000..79a0ba836f5b8886b0a73f161eb292af2b105e65
GIT binary patch
literal 23
hcmV+y0O<dCIxjDAFVNA_)6~`0*Vx(G+uYsW-wL6<4>JG&

literal 0
HcmV?d00001

diff --git a/t/t5200/url-9 b/t/t5200/url-9
new file mode 100644
index 0000000000000000000000000000000000000000..8b44bec48b94467c63e8e1ad18162e465da6d6dd
GIT binary patch
literal 23
hcmV+y0O<dCIxjDAFW}+g<K*S$=jiF`>+J3B?+U9u5HkP(

literal 0
HcmV?d00001

diff --git a/test-url-normalize.c b/test-url-normalize.c
new file mode 100644
index 0000000..f18bd88
--- /dev/null
+++ b/test-url-normalize.c
@@ -0,0 +1,131 @@
+#ifdef NO_CURL
+
+int main()
+{
+	return 125;
+}
+
+#else /* !NO_CURL */
+
+#include "http.c"
+
+static int run_http_options(const char *file,
+			    const char *opt,
+			    const char *url)
+{
+	struct strbuf opt_lc;
+	size_t i, len;
+
+	if (git_config_with_options(http_options, (void *)url, file, 0))
+		return 1;
+
+	len = strlen(opt);
+	strbuf_init(&opt_lc, len);
+	for (i = 0; i < len; ++i) {
+		strbuf_addch(&opt_lc, tolower(opt[i]));
+	}
+
+	if (!strcmp("sslverify", opt_lc.buf))
+		printf("%s\n", curl_ssl_verify ? "true" : "false");
+	else if (!strcmp("sslcert", opt_lc.buf))
+		printf("%s\n", ssl_cert);
+#if LIBCURL_VERSION_NUM >= 0x070903
+	else if (!strcmp("sslkey", opt_lc.buf))
+		printf("%s\n", ssl_key);
+#endif
+#if LIBCURL_VERSION_NUM >= 0x070908
+	else if (!strcmp("sslcapath", opt_lc.buf))
+		printf("%s\n", ssl_capath);
+#endif
+	else if (!strcmp("sslcainfo", opt_lc.buf))
+		printf("%s\n", ssl_cainfo);
+	else if (!strcmp("sslcertpasswordprotected", opt_lc.buf))
+		printf("%s\n", ssl_cert_password_required ? "true" : "false");
+	else if (!strcmp("ssltry", opt_lc.buf))
+		printf("%s\n", curl_ssl_try ? "true" : "false");
+	else if (!strcmp("minsessions", opt_lc.buf))
+		printf("%d\n", min_curl_sessions);
+	else if (!strcmp("maxrequests", opt_lc.buf))
+		printf("%d\n", max_requests);
+	else if (!strcmp("lowspeedlimit", opt_lc.buf))
+		printf("%ld\n", curl_low_speed_limit);
+	else if (!strcmp("lowspeedtime", opt_lc.buf))
+		printf("%ld\n", curl_low_speed_time);
+	else if (!strcmp("noepsv", opt_lc.buf))
+		printf("%s\n", curl_ftp_no_epsv ? "true" : "false");
+	else if (!strcmp("proxy", opt_lc.buf))
+		printf("%s\n", curl_http_proxy);
+	else if (!strcmp("cookiefile", opt_lc.buf))
+		printf("%s\n", curl_cookie_file);
+	else if (!strcmp("postbuffer", opt_lc.buf))
+		printf("%u\n", (unsigned)http_post_buffer);
+	else if (!strcmp("useragent", opt_lc.buf))
+		printf("%s\n", user_agent);
+
+	return 0;
+}
+
+#define url_normalize(u) http_options_url_normalize(u)
+
+int main(int argc, char **argv)
+{
+	const char *usage = "test-url-normalize [-p | -l] <url1> | <url1> <url2>"
+		" | -c file option <url1>";
+	char *url1, *url2;
+	int opt_p = 0, opt_l = 0, opt_c = 0;
+	char *file = NULL, *optname = NULL;
+
+	/*
+	 * For one url, succeed if url_normalize succeeds on it, fail otherwise.
+	 * For two urls, succeed only if url_normalize succeeds on both and
+	 * the results compare equal with strcmp.  If -p is given (one url only)
+	 * and url_normalize succeeds, print the result followed by "\n".  If
+	 * -l is given (one url only) and url_normalize succeeds, print the
+	 * returned length in decimal followed by "\n".
+	 * If -c is given, call git_config_with_options using the specified file
+	 * and http_options and passing the normalized value of the url.  Then
+	 * print the value of 'option' afterwards.  'option' must be one of the
+	 * valid 'http.*' options.
+	 */
+
+	if (argc > 1 && !strcmp(argv[1], "-p")) {
+		opt_p = 1;
+		argc--;
+		argv++;
+	} else if (argc > 1 && !strcmp(argv[1], "-l")) {
+		opt_l = 1;
+		argc--;
+		argv++;
+	} else if (argc > 3 && !strcmp(argv[1], "-c")) {
+		opt_c = 1;
+		file = argv[2];
+		optname = argv[3];
+		argc -= 3;
+		argv += 3;
+	}
+
+	if (argc < 2 || argc > 3)
+		die(usage);
+
+	if (argc == 2) {
+		url1 = url_normalize(argv[1]);
+		if (!url1)
+			return 1;
+		if (opt_p)
+			printf("%s\n", url1);
+		if (opt_l)
+			printf("%u\n", (unsigned)strlen(url1));
+		if (opt_c)
+			return run_http_options(file, optname, url1);
+		return 0;
+	}
+
+	if (opt_p || opt_l || opt_c)
+		die(usage);
+
+	url1 = url_normalize(argv[1]);
+	url2 = url_normalize(argv[2]);
+	return (url1 && url2 && !strcmp(url1, url2)) ? 0 : 1;
+}
+
+#endif /* !NO_CURL */
-- 
1.8.3
