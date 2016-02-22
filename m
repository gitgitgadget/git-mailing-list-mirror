From: tboegi@web.de
Subject: [PATCH 1/1] convert.c: correct attr_action
Date: Mon, 22 Feb 2016 06:11:38 +0100
Message-ID: <1456117898-30357-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 06:10:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXikm-0000Xx-3z
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 06:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbcBVFJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 00:09:42 -0500
Received: from mout.web.de ([212.227.15.4]:64619 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731AbcBVFJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 00:09:41 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LmQS2-1Zxq2C4B1u-00Zu9l; Mon, 22 Feb 2016 06:09:39
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:+BdVrhSlQ/JxVQfVUFGCsJrJMEgnfLiwGJiBzsL4SR66s//27Dk
 v6jH+QbS/87kgLp85E5fl43jBZrsnzXLRfYcYXYa/+w2T3FPL6ur7WwAfzyPZnybQoFdEjS
 KdETMOdr5gHjp0yTottne2zdbpIwWriH5zAdiMX+TPfPPs+Rew24SFycx8o1dB2UWDgteLV
 b/we/Te28yJSzUX4syM3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kib4xpbUilY=:FJUwqOwU9c3G6gMEu8+e28
 qdytifiBRZrE3w9/xvLyaJ40sadlhtRx1xwL0iS7+EwzngPGkW2JCpHwLU0FU+LlHJIeqMNUE
 GANxoXXwux4GU06Bjxn6l+kIMb2SAxwD5FLaVcF+3+YNpQA7YkZokAn7MyOoy/wcfJy1P54wx
 qylJIU+DAPBE2ztxe85lNwxwfe/IHMDLSGJoNCJq+nY5Afb/UZaUHuMQ39KRNPUGZ4BLhjsRY
 OK9NOw3v7Hwfm9igzJfnQekEW4TLyXJ5OanJhSpvre1WCEmCgFDjbNYLo+JGn46a2PikSAGWJ
 BiVyZNwrWCWNSiq/NNHX4D7p825y4jgTDsGx7CNNGzrsiktdxqJqJkPWn7omBUk1Tly8sJXVZ
 ZXhXWpZ9x2J5mKRVuS3tBj0JXVu189brAVy8Xy97t8a3gEz+LxbDMBcSCMkBnCiHCpjjEqqSS
 akIuaoHks3E/vMzv+hDX1D42obdDOMP24+omGMrAG9iaGmnjMQ+Tp2VkO6X4BJTHQWw9uYV/c
 zggYhwO9qkX/8mOmlwlkGVgO0XQH+4Fh4S2k6KbbQZs9P44L3tnOBBOrUkau2v26VdaThSL5t
 QcD97K4nM+bgaJcNBgJuS67A9BTlkuSXmwn2xzvCCBHP4jm1Ibw524MZRNq9lPSE2qDpC6fdW
 fVpIt2zOd9SXq6XwsrbKHITw7AEOt0AdVqy1AMLb3YtNJM357o58wuOIL88cWzCpUXfwRXBfg
 dUVvX1XBOeF3PuvO6jst0fRi4RH/XcUd+vyTCfPe72w2LiyHRxGcksoIlHfChcJW5I5p/1o/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286880>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Commit "convert.c: refactor crlf_action" unified the crlf_handling
and introdused a bug for "git ls-files --eol".
The "text" attribute was shown as "text eol=3Dlf" or "text eol=3Dcrlf",
depending on core.autocrlf or core.eol.
Correct this and add test cases in t0027.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
This fix needs to go on top of tb/conversion
convert.c            |  3 ++-
 t/t0027-auto-crlf.sh | 47 ++++++++++++++++++++++++++++++++++++++++----=
---
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/convert.c b/convert.c
index 18af685..0bc32ec 100644
--- a/convert.c
+++ b/convert.c
@@ -708,7 +708,7 @@ static enum crlf_action git_path_check_crlf(struct =
git_attr_check *check)
 	const char *value =3D check->value;
=20
 	if (ATTR_TRUE(value))
-		return text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_INPUT;
+		return CRLF_TEXT;
 	else if (ATTR_FALSE(value))
 		return CRLF_BINARY;
 	else if (ATTR_UNSET(value))
@@ -792,6 +792,7 @@ static void convert_attrs(struct conv_attrs *ca, co=
nst char *path)
 			ca->crlf_action =3D CRLF_TEXT_INPUT;
 		else if (eol_attr =3D=3D EOL_CRLF)
 			ca->crlf_action =3D CRLF_TEXT_CRLF;
+		ca->attr_action =3D ca->crlf_action;
 	} else {
 		ca->drv =3D NULL;
 		ca->crlf_action =3D CRLF_UNDEFINED;
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index fc4c628..f9c92c6 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -159,6 +159,39 @@ stats_ascii () {
=20
 }
=20
+attr_ascii () {
+	case "$1" in
+	"-text") echo "-text"	;;
+	lf)	echo "text eol=3Dlf" ;;
+	crlf)	echo "text eol=3Dcrlf" ;;
+	text)
+		case "$2" in
+		"")	echo "text" ;;
+		lf)	echo "text eol=3Dlf" ;;
+		crlf)	echo "text eol=3Dcrlf" ;;
+		*) echo invalid_attr2 "$2" ;;
+		esac
+		;;
+	auto)
+		case "$2" in
+		"")	echo "text=3Dauto" ;;
+		lf)	echo "text=3Dauto eol=3Dlf" ;;
+		crlf)	echo "text=3Dauto eol=3Dcrlf" ;;
+		*) echo invalid_attr2 "$2"	;;
+		esac
+		;;
+	"")
+		case "$2" in
+		"")	echo "" ;;
+		lf)	echo "text eol=3Dlf" ;;
+		crlf)	echo "text eol=3Dcrlf" ;;
+		*) echo invalid_attr2 "$2" ;;
+		esac
+		;;
+	*)echo invalid_attr1 "$1"	;;
+	esac
+}
+
 check_files_in_repo () {
 	crlf=3D$1
 	attr=3D$2
@@ -228,15 +261,15 @@ checkout_files () {
 	test_expect_success "ls-files --eol attr=3D$attr $ident $aeol core.au=
tocrlf=3D$crlf core.eol=3D$ceol" '
 		test_when_finished "rm expect actual" &&
 		sort <<-EOF >expect &&
-		i/crlf w/$(stats_ascii $crlfname) crlf_false_attr__CRLF.txt
-		i/mixed w/$(stats_ascii $lfmixcrlf) crlf_false_attr__CRLF_mix_LF.txt
-		i/lf w/$(stats_ascii $lfname) crlf_false_attr__LF.txt
-		i/-text w/$(stats_ascii $lfmixcr) crlf_false_attr__LF_mix_CR.txt
-		i/-text w/$(stats_ascii $crlfnul) crlf_false_attr__CRLF_nul.txt
-		i/-text w/$(stats_ascii $crlfnul) crlf_false_attr__LF_nul.txt
+		i/crlf w/$(stats_ascii $crlfname) attr/$(attr_ascii $attr $aeol) crl=
f_false_attr__CRLF.txt
+		i/mixed w/$(stats_ascii $lfmixcrlf) attr/$(attr_ascii $attr $aeol) c=
rlf_false_attr__CRLF_mix_LF.txt
+		i/lf w/$(stats_ascii $lfname) attr/$(attr_ascii $attr $aeol) crlf_fa=
lse_attr__LF.txt
+		i/-text w/$(stats_ascii $lfmixcr) attr/$(attr_ascii $attr $aeol) crl=
f_false_attr__LF_mix_CR.txt
+		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crl=
f_false_attr__CRLF_nul.txt
+		i/-text w/$(stats_ascii $crlfnul) attr/$(attr_ascii $attr $aeol) crl=
f_false_attr__LF_nul.txt
 		EOF
 		git ls-files --eol crlf_false_attr__* |
-		sed -e "s!attr/[^	]*!!g" -e "s/	/ /g" -e "s/  */ /g" |
+		sed -e "s/	/ /g" -e "s/  */ /g" |
 		sort >actual &&
 		test_cmp expect actual
 	'
--=20
2.7.0.303.g2c4f448.dirty
