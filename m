From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v7 3/4] tests: add new test for the url_normalize function
Date: Sun, 21 Jul 2013 20:18:37 -0700
Message-ID: <185ed81d5965642db680fa361ee07ce@f74d39fa044aa309eaea14b9f57fe79>
References: <f1109cf05979890ea9441fae7881586@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
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
X-From: git-owner@vger.kernel.org Mon Jul 22 05:19:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V16eR-0004js-8v
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 05:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121Ab3GVDS5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Jul 2013 23:18:57 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33707 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743Ab3GVDSy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 23:18:54 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so6379067pdj.28
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 20:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9hN4aHaG1k3XuzQq1qBpNhaoWsWONDddmGfyCM33GPY=;
        b=AX0nJHVg4x5mtlwFzRK2JNIIrL1+pNO6yP1qKMYkWSz690f7p0BMKg3hGMIZSKXWXK
         870UZIwpkgRmTAubWX4if6Tro/vYfUhMPHvUhyw5Um9twL6YYghU08dTA8jIumXJCsAQ
         oT35gQcJVzLJTYd9zaxQAqmF1enQepGL/kc8CdTCFCKXAzJIWDj/yeETICrWyDor1+gl
         zAKbJi6CQb4ro+EX+wgM/i/BpwaACURWocRhg9sdCU249uUOHCQetypT00vHsodO9lNB
         wb++5yVPdYfZQcbt1rYs9S4o+P4kFnkrG/5HBDGbP4y+1RhjsQwn7sT3bEZB7zEVIcO1
         BPuQ==
X-Received: by 10.68.179.225 with SMTP id dj1mr27927424pbc.193.1374463134103;
        Sun, 21 Jul 2013 20:18:54 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id fl2sm36325047pab.23.2013.07.21.20.18.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 20:18:53 -0700 (PDT)
In-Reply-To: <f1109cf05979890ea9441fae7881586@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230954>

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
 t/t5200-url-normalize.sh | 182 +++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t5200/README           |   9 +++
 t/t5200/url-1            |   1 +
 t/t5200/url-10           |   1 +
 t/t5200/url-11           |   1 +
 t/t5200/url-2            |   1 +
 t/t5200/url-3            |   1 +
 t/t5200/url-4            |   1 +
 t/t5200/url-5            |   1 +
 t/t5200/url-6            |   1 +
 t/t5200/url-7            |   1 +
 t/t5200/url-8            |   1 +
 t/t5200/url-9            |   1 +
 test-url-normalize.c     |  61 ++++++++++++++++
 16 files changed, 269 insertions(+)
 create mode 100755 t/t5200-url-normalize.sh
 create mode 100644 t/t5200/README
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
@@ -567,6 +567,7 @@ TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-string-list
 TEST_PROGRAMS_NEED_X +=3D test-subprocess
 TEST_PROGRAMS_NEED_X +=3D test-svn-fe
+TEST_PROGRAMS_NEED_X +=3D test-url-normalize
 TEST_PROGRAMS_NEED_X +=3D test-wildmatch
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
@@ -2235,6 +2236,10 @@ test-parse-options$X: parse-options.o parse-opti=
ons-cb.o
=20
 test-svn-fe$X: vcs-svn/lib.a
=20
+test-url-normalize$X: test-url-normalize.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+
 .PRECIOUS: $(TEST_OBJS)
=20
 test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
diff --git a/t/t5200-url-normalize.sh b/t/t5200-url-normalize.sh
new file mode 100755
index 0000000..12ac411
--- /dev/null
+++ b/t/t5200-url-normalize.sh
@@ -0,0 +1,182 @@
+#!/bin/sh
+
+test_description=3D'url normalization'
+. ./test-lib.sh
+
+if test -n "$NO_CURL"; then
+	skip_all=3D'skipping test, git built without http support'
+	test_done
+fi
+
+# The base name of the test url files
+tu=3D"$TEST_DIRECTORY/t5200/url"
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
+	test "$(test-url-normalize -p "AbCdeF://x.Y")" =3D "abcdef://x.y/"
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
+	test "$(test-url-normalize -p "http://x:800")" =3D "http://x:800/" &&
+	test "$(test-url-normalize -p "http://x:0800")" =3D "http://x:800/" &=
&
+	test "$(test-url-normalize -p "http://x:00000800")" =3D "http://x:800=
/" &&
+	test "$(test-url-normalize -p "http://x:065535")" =3D "http://x:65535=
/" &&
+	test "$(test-url-normalize -p "http://x:1")" =3D "http://x:1/" &&
+	test "$(test-url-normalize -p "http://x:80")" =3D "http://x/" &&
+	test "$(test-url-normalize -p "http://x:080")" =3D "http://x/" &&
+	test "$(test-url-normalize -p "http://x:000000080")" =3D "http://x/" =
&&
+	test "$(test-url-normalize -p "https://x:443")" =3D "https://x/" &&
+	test "$(test-url-normalize -p "https://x:0443")" =3D "https://x/" &&
+	test "$(test-url-normalize -p "https://x:000000443")" =3D "https://x/=
"
+'
+
+test_expect_success 'url general escapes' '
+	! test-url-normalize "http://x.y?%fg" &&
+	test "$(test-url-normalize -p "X://W/%7e%41^%3a")" =3D "x://w/~A%5E%3=
A" &&
+	test "$(test-url-normalize -p "X://W/:/?#[]@")" =3D "x://w/:/?#[]@" &=
&
+	test "$(test-url-normalize -p "X://W/$&()*+,;=3D")" =3D "x://w/$&()*+=
,;=3D" &&
+	test "$(test-url-normalize -p "X://W/'\''")" =3D "x://w/'\''" &&
+	test "$(test-url-normalize -p "X://W?'\!'")" =3D "x://w/?'\!'"
+';#'
+
+test_expect_success 'url high-bit escapes' '
+	test "$(test-url-normalize -p "$(cat "$tu-1")")" =3D "x://q/%01%02%03=
%04%05%06%07%08%0E%0F%10%11%12" &&
+	test "$(test-url-normalize -p "$(cat "$tu-2")")" =3D "x://q/%13%14%15=
%16%17%18%19%1B%1C%1D%1E%1F%7F" &&
+	test "$(test-url-normalize -p "$(cat "$tu-3")")" =3D "x://q/%80%81%82=
%83%84%85%86%87%88%89%8A%8B%8C%8D%8E%8F" &&
+	test "$(test-url-normalize -p "$(cat "$tu-4")")" =3D "x://q/%90%91%92=
%93%94%95%96%97%98%99%9A%9B%9C%9D%9E%9F" &&
+	test "$(test-url-normalize -p "$(cat "$tu-5")")" =3D "x://q/%A0%A1%A2=
%A3%A4%A5%A6%A7%A8%A9%AA%AB%AC%AD%AE%AF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-6")")" =3D "x://q/%B0%B1%B2=
%B3%B4%B5%B6%B7%B8%B9%BA%BB%BC%BD%BE%BF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-7")")" =3D "x://q/%C0%C1%C2=
%C3%C4%C5%C6%C7%C8%C9%CA%CB%CC%CD%CE%CF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-8")")" =3D "x://q/%D0%D1%D2=
%D3%D4%D5%D6%D7%D8%D9%DA%DB%DC%DD%DE%DF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-9")")" =3D "x://q/%E0%E1%E2=
%E3%E4%E5%E6%E7%E8%E9%EA%EB%EC%ED%EE%EF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-10")")" =3D "x://q/%F0%F1%F=
2%F3%F4%F5%F6%F7%F8%F9%FA%FB%FC%FD%FE%FF" &&
+	test "$(test-url-normalize -p "$(cat "$tu-11")")" =3D "x://q/%C2%80%D=
=46%BF%E0%A0%80%EF%BF%BD%F0%90%80%80%F0%AF%BF%BD"
+'
+
+test_expect_success 'url username/password escapes' '
+	test "$(test-url-normalize -p "x://%41%62(^):%70+d@foo")" =3D "x://Ab=
(%5E):p+d@foo/"
+'
+
+test_expect_success 'url normalized lengths' '
+	test "$(test-url-normalize -l "Http://%4d%65:%4d^%70@The.Host")" =3D =
25 &&
+	test "$(test-url-normalize -l "http://%41:%42@x.y/%61/")" =3D 17 &&
+	test "$(test-url-normalize -l "http://@x.y/^")" =3D 15
+'
+
+test_expect_success 'url . and .. segments' '
+	test "$(test-url-normalize -p "x://y/.")" =3D "x://y/" &&
+	test "$(test-url-normalize -p "x://y/./")" =3D "x://y/" &&
+	test "$(test-url-normalize -p "x://y/a/.")" =3D "x://y/a" &&
+	test "$(test-url-normalize -p "x://y/a/./")" =3D "x://y/a/" &&
+	test "$(test-url-normalize -p "x://y/.?")" =3D "x://y/?" &&
+	test "$(test-url-normalize -p "x://y/./?")" =3D "x://y/?" &&
+	test "$(test-url-normalize -p "x://y/a/.?")" =3D "x://y/a?" &&
+	test "$(test-url-normalize -p "x://y/a/./?")" =3D "x://y/a/?" &&
+	test "$(test-url-normalize -p "x://y/a/./b/.././../c")" =3D "x://y/c"=
 &&
+	test "$(test-url-normalize -p "x://y/a/./b/../.././c/")" =3D "x://y/c=
/" &&
+	test "$(test-url-normalize -p "x://y/a/./b/.././../c/././.././.")" =3D=
 "x://y/" &&
+	! test-url-normalize "x://y/a/./b/.././../c/././.././.." &&
+	test "$(test-url-normalize -p "x://y/a/./?/././..")" =3D "x://y/a/?/.=
/./.." &&
+	test "$(test-url-normalize -p "x://y/%2e/")" =3D "x://y/" &&
+	test "$(test-url-normalize -p "x://y/%2E/")" =3D "x://y/" &&
+	test "$(test-url-normalize -p "x://y/a/%2e./")" =3D "x://y/" &&
+	test "$(test-url-normalize -p "x://y/b/.%2E/")" =3D "x://y/" &&
+	test "$(test-url-normalize -p "x://y/c/%2e%2E/")" =3D "x://y/"
+'
+
+# http://@foo specifies an empty user name but does not specify a pass=
word
+# http://foo  specifies neither a user name nor a password
+# So they should not be equivalent
+test_expect_success 'url equivalents' '
+	test-url-normalize "httP://x" "Http://X/" &&
+	test-url-normalize "Http://%4d%65:%4d^%70@The.Host" "hTTP://Me:%4D^p@=
the.HOST:80/" &&
+	! test-url-normalize "https://@x.y/^" "httpS://x.y:443/^" &&
+	test-url-normalize "https://@x.y/^" "httpS://@x.y:0443/^" &&
+	test-url-normalize "https://@x.y/^/../abc" "httpS://@x.y:0443/abc" &&
+	test-url-normalize "https://@x.y/^/.." "httpS://@x.y:0443/"
+'
+
+test_done
diff --git a/t/t5200/README b/t/t5200/README
new file mode 100644
index 0000000..b908fe9
--- /dev/null
+++ b/t/t5200/README
@@ -0,0 +1,9 @@
+The data files in this directory contain URLs with characters in
+the range 0x01-0x1f and 0x7f-0xff to test the proper normalization
+of unprintable characters.
+
+A select few characters in the 0x01-0x1f range are skipped to
+help avoid problems running the test itself.
+
+They are in test files in this directory rather than being
+embedded in the test script for portability.
diff --git a/t/t5200/url-1 b/t/t5200/url-1
new file mode 100644
index 0000000..519019c
--- /dev/null
+++ b/t/t5200/url-1
@@ -0,0 +1 @@
+x://q/=01=02=03=04=05=06=07=08=0E=0F=10=11=12
diff --git a/t/t5200/url-10 b/t/t5200/url-10
new file mode 100644
index 0000000..b9965de
--- /dev/null
+++ b/t/t5200/url-10
@@ -0,0 +1 @@
+x://q/=F0=F1=F2=F3=F4=F5=F6=F7=F8=F9=FA=FB=FC=FD=FE=FF
diff --git a/t/t5200/url-11 b/t/t5200/url-11
new file mode 100644
index 0000000..f0a50f1
--- /dev/null
+++ b/t/t5200/url-11
@@ -0,0 +1 @@
+x://q/=C2=80=DF=BF=E0=A0=80=EF=BF=BD=F0=90=80=80=F0=AF=BF=BD
diff --git a/t/t5200/url-2 b/t/t5200/url-2
new file mode 100644
index 0000000..43334b0
--- /dev/null
+++ b/t/t5200/url-2
@@ -0,0 +1 @@
+x://q/=13=14=15=16=17=18=19=1B=1C=1D=1E=1F=7F
diff --git a/t/t5200/url-3 b/t/t5200/url-3
new file mode 100644
index 0000000..7378c7b
--- /dev/null
+++ b/t/t5200/url-3
@@ -0,0 +1 @@
+x://q/=80=81=82=83=84=85=86=87=88=89=8A=8B=8C=8D=8E=8F
diff --git a/t/t5200/url-4 b/t/t5200/url-4
new file mode 100644
index 0000000..220b198
--- /dev/null
+++ b/t/t5200/url-4
@@ -0,0 +1 @@
+x://q/=90=91=92=93=94=95=96=97=98=99=9A=9B=9C=9D=9E=9F
diff --git a/t/t5200/url-5 b/t/t5200/url-5
new file mode 100644
index 0000000..1ccd927
--- /dev/null
+++ b/t/t5200/url-5
@@ -0,0 +1 @@
+x://q/=A0=A1=A2=A3=A4=A5=A6=A7=A8=A9=AA=AB=AC=AD=AE=AF
diff --git a/t/t5200/url-6 b/t/t5200/url-6
new file mode 100644
index 0000000..e8283aa
--- /dev/null
+++ b/t/t5200/url-6
@@ -0,0 +1 @@
+x://q/=B0=B1=B2=B3=B4=B5=B6=B7=B8=B9=BA=BB=BC=BD=BE=BF
diff --git a/t/t5200/url-7 b/t/t5200/url-7
new file mode 100644
index 0000000..fa7c10b
--- /dev/null
+++ b/t/t5200/url-7
@@ -0,0 +1 @@
+x://q/=C0=C1=C2=C3=C4=C5=C6=C7=C8=C9=CA=CB=CC=CD=CE=CF
diff --git a/t/t5200/url-8 b/t/t5200/url-8
new file mode 100644
index 0000000..79a0ba8
--- /dev/null
+++ b/t/t5200/url-8
@@ -0,0 +1 @@
+x://q/=D0=D1=D2=D3=D4=D5=D6=D7=D8=D9=DA=DB=DC=DD=DE=DF
diff --git a/t/t5200/url-9 b/t/t5200/url-9
new file mode 100644
index 0000000..8b44bec
--- /dev/null
+++ b/t/t5200/url-9
@@ -0,0 +1 @@
+x://q/=E0=E1=E2=E3=E4=E5=E6=E7=E8=E9=EA=EB=EC=ED=EE=EF
diff --git a/test-url-normalize.c b/test-url-normalize.c
new file mode 100644
index 0000000..d68312d
--- /dev/null
+++ b/test-url-normalize.c
@@ -0,0 +1,61 @@
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
+#define url_normalize(u) http_options_url_normalize(u)
+
+int main(int argc, char **argv)
+{
+	const char *usage =3D "test-url-normalize [-p | -l] <url1> | <url1> <=
url2>";
+	char *url1, *url2;
+	int opt_p =3D 0, opt_l =3D 0;
+
+	/*
+	 * For one url, succeed if url_normalize succeeds on it, fail otherwi=
se.
+	 * For two urls, succeed only if url_normalize succeeds on both and
+	 * the results compare equal with strcmp.  If -p is given (one url on=
ly)
+	 * and url_normalize succeeds, print the result followed by "\n".  If
+	 * -l is given (one url only) and url_normalize succeeds, print the
+	 * returned length in decimal followed by "\n".
+	 */
+
+	if (argc > 1 && !strcmp(argv[1], "-p")) {
+		opt_p =3D 1;
+		argc--;
+		argv++;
+	} else if (argc > 1 && !strcmp(argv[1], "-l")) {
+		opt_l =3D 1;
+		argc--;
+		argv++;
+	}
+
+	if (argc < 2 || argc > 3)
+		die(usage);
+
+	if (argc =3D=3D 2) {
+		url1 =3D url_normalize(argv[1]);
+		if (!url1)
+			return 1;
+		if (opt_p)
+			printf("%s\n", url1);
+		if (opt_l)
+			printf("%u\n", (unsigned)strlen(url1));
+		return 0;
+	}
+
+	if (opt_p || opt_l)
+		die(usage);
+
+	url1 =3D url_normalize(argv[1]);
+	url2 =3D url_normalize(argv[2]);
+	return (url1 && url2 && !strcmp(url1, url2)) ? 0 : 1;
+}
+
+#endif /* !NO_CURL */
--=20
1.8.3
