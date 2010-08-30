From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 12/17] gettext tests: test re-encoding with a UTF-8 msgid under Shell
Date: Mon, 30 Aug 2010 21:28:18 +0000
Message-ID: <1283203703-26923-13-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBva-0000N5-L3
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab0H3V3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:12 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:47033 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab0H3V3K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:10 -0400
Received: by mail-ww0-f42.google.com with SMTP id 14so307664wwi.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=d9K2NKYG2CXQlYU2KKFUFCBul+DjCWI47iT9+Ja+IZA=;
        b=EYpO6a7r94i6RNGQk2aepCZVtO9jlZ+29/Yfk56zJT60dLV/TjZKl6OzqpF6W10pf3
         1nVvDOKXWgLci7NT64Pn+Uf42YmR+6w9cnIymYShXAuDP0xgNqYQ/ktbAv1HkC84CeMe
         j7JZDciPGhcW2TEzFM6xJTOs6ypj1rdZl73cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PGmHCIJv11ZooFo5JwliTSIZ/pkquO1Qt/lDgtdH07JgLp7uLFW0dEiROZ0oWwdOlQ
         0rDXQ0iayNohcIc7U+s+yNZyAN7dj9TJTocla5gD5l5vL+73ilBk3gvi0d+6Pqd9JUuX
         Yjb9gGMCH4/p8ZSFYfKg1pMHVmszsIfyphAE4=
Received: by 10.227.138.6 with SMTP id y6mr5504841wbt.162.1283203749788;
        Mon, 30 Aug 2010 14:29:09 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.29.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:29:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154861>

A test that tests that calling gettext on a UTF-8 msgid works, and
that recoding the resulting string works too.

This test uses the --from-code=3DUTF-8 xgettext(1) argument introduced
in an earlier patch.

This patch only tests the shellscript portion of our gettext
interface. I can't get any of these tests to fail on any of the
gettext implementations I have around, even without the previous patch
to gettext.c. But having exhaustive tests in this area is good
regardless.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/is.po                           |    6 ++++++
 t/t0200/test.c                     |    3 +++
 t/t0204-gettext-reencode-sanity.sh |   21 +++++++++++++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/po/is.po b/po/is.po
index 39b63b9..dfa3804 100644
--- a/po/is.po
+++ b/po/is.po
@@ -37,6 +37,12 @@ msgid "TEST: Old English Runes"
 msgstr "TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=9A=A6=
 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=E1=9B=
=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=9A=E1=
=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=A6=E1=
=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=B9=E1=
=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=9A=AB=
"
=20
 #. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:21
+#, c-format
+msgid "TEST: =E2=80=98single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quo=
tes"
+msgstr "TILRAUN: =E2=80=9Aeinfaldar=E2=80=98 og =E2=80=9Etv=C3=B6falda=
r=E2=80=9C g=C3=A6salappir"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
 #: t/t0200/test.sh:8
 msgid "TEST: A Shell test string"
 msgstr "TILRAUN: Skeljartilraunastrengur"
diff --git a/t/t0200/test.c b/t/t0200/test.c
index 82682dc..ff15c2f 100644
--- a/t/t0200/test.c
+++ b/t/t0200/test.c
@@ -16,4 +16,7 @@ int main(void)
=20
 	/* TRANSLATORS: This is a test. You don't need to translate it. */
 	printf(_("TEST: Old English Runes"));
+
+	/* TRANSLATORS: This is a test. You don't need to translate it. */
+	printf(_("TEST: =E2=80=98single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D=
 quotes"));
 }
diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reenc=
ode-sanity.sh
index 3222e37..1a7ea37 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -40,4 +40,25 @@ test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emi=
tting ISO-8859-1 from our UT
 	fi
 '
=20
+test_expect_success GETTEXT_LOCALE 'gettext: Fetching a UTF-8 msgid ->=
 UTF-8' '
+    printf "TILRAUN: =E2=80=9Aeinfaldar=E2=80=98 og =E2=80=9Etv=C3=B6f=
aldar=E2=80=9C g=C3=A6salappir" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: =E2=80=98sin=
gle=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quotes" >actual &&
+    test_cmp expect actual
+'
+
+# How these quotes get transliterated depends on the gettext implement=
ation:
+#
+#   Debian:  ,einfaldar' og ,,tv=C3=B6faldar" [GNU libintl]
+#   FreeBSD: `einfaldar` og "tv=C3=B6faldar"  [GNU libintl]
+#   Solaris: ?einfaldar? og ?tv=C3=B6faldar?  [Solaris libintl]
+#
+# Just make sure the contents are transliterated, and don't use grep -=
q
+# so that these differences are emitted under --verbose for curious
+# eyes.
+test_expect_success GETTEXT_ISO_LOCALE 'gettext: Fetching a UTF-8 msgi=
d -> ISO-8859-1' '
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: =E2=80=98=
single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quotes" >actual &&
+    grep "einfaldar" actual &&
+    grep "$(echo tv=C3=B6faldar | iconv -f UTF-8 -t ISO8859-1)" actual
+'
+
 test_done
--=20
1.7.2.2.536.g3f548
