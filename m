From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 4/5] t/t7800-difftool.sh: Skip with prereq on no PERL
Date: Wed, 28 Jul 2010 10:34:58 +0000
Message-ID: <1280313299-721-5-git-send-email-avarab@gmail.com>
References: <1280313299-721-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 12:36:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3zS-0006yf-6V
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 12:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795Ab0G1Kfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 06:35:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43062 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727Ab0G1Kf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 06:35:29 -0400
Received: by bwz1 with SMTP id 1so3850012bwz.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PQZskgJ8dlpQwXIEPrLo/qFg+vNtc9Q4Rf7K8EK3J3w=;
        b=GDfA9KDKdYboguYEn2xtrAc9L9vKUCDGemzNzGc2WxeBRQB4bUpqnQmBCVYCi3ew4z
         a5gXj48JZiDyujilKL2f1Q8khlEBTSWGarFqqE94HrfFQD1F7fyqDhVIZnOTJE6ALeCh
         jSIiM7MqzTctJvOHZk8d2DLbziqOOcna92DqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LZW0l/YMMhqeGl3wNp1xK35SRTykyjDeAu2lhQFQPxFrCjtIq/TTIxpT7Vqhl8/+Ms
         oR/Pgfz7HnM34y2hWutI5MUNjGe3bAGgnQso8S1WghTqIx58sr9jqDilOWzCGlo/LPPO
         rcbfHwq55ye8/otDm4BvqPppVzPLIi1mgTiVw=
Received: by 10.204.150.74 with SMTP id x10mr7674248bkv.130.1280313326689;
        Wed, 28 Jul 2010 03:35:26 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id g11sm4661233bkw.22.2010.07.28.03.35.24
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 03:35:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280313299-721-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152075>

Change t/t7800-difftool.sh to to skip with the the three-arg prereq
form of test_expect_success instead of bailing out.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7800-difftool.sh |   49 ++++++++++++++++++++++---------------------=
------
 1 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 196827e..58dc6f6 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -10,11 +10,6 @@ Testing basic diff tool invocation
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq PERL; then
-	skip_all=3D'skipping difftool tests, perl not available'
-	test_done
-fi
-
 LF=3D'
 '
=20
@@ -50,7 +45,7 @@ prompt_given()
 }
=20
 # Create a file on master and change it on branch
-test_expect_success 'setup' '
+test_expect_success PERL 'setup' '
 	echo master >file &&
 	git add file &&
 	git commit -m "added file" &&
@@ -62,7 +57,7 @@ test_expect_success 'setup' '
 '
=20
 # Configure a custom difftool.<tool>.cmd and use it
-test_expect_success 'custom commands' '
+test_expect_success PERL 'custom commands' '
 	restore_test_defaults &&
 	git config difftool.test-tool.cmd "cat \$REMOTE" &&
=20
@@ -75,13 +70,13 @@ test_expect_success 'custom commands' '
 '
=20
 # Ensures that git-difftool ignores bogus --tool values
-test_expect_success 'difftool ignores bad --tool values' '
+test_expect_success PERL 'difftool ignores bad --tool values' '
 	diff=3D$(git difftool --no-prompt --tool=3Dbad-tool branch)
 	test "$?" =3D 1 &&
 	test "$diff" =3D ""
 '
=20
-test_expect_success 'difftool honors --gui' '
+test_expect_success PERL 'difftool honors --gui' '
 	git config merge.tool bogus-tool &&
 	git config diff.tool bogus-tool &&
 	git config diff.guitool test-tool &&
@@ -92,7 +87,7 @@ test_expect_success 'difftool honors --gui' '
 	restore_test_defaults
 '
=20
-test_expect_success 'difftool --gui works without configured diff.guit=
ool' '
+test_expect_success PERL 'difftool --gui works without configured diff=
=2Eguitool' '
 	git config diff.tool test-tool &&
=20
 	diff=3D$(git difftool --no-prompt --gui branch) &&
@@ -102,7 +97,7 @@ test_expect_success 'difftool --gui works without co=
nfigured diff.guitool' '
 '
=20
 # Specify the diff tool using $GIT_DIFF_TOOL
-test_expect_success 'GIT_DIFF_TOOL variable' '
+test_expect_success PERL 'GIT_DIFF_TOOL variable' '
 	git config --unset diff.tool
 	GIT_DIFF_TOOL=3Dtest-tool &&
 	export GIT_DIFF_TOOL &&
@@ -115,7 +110,7 @@ test_expect_success 'GIT_DIFF_TOOL variable' '
=20
 # Test the $GIT_*_TOOL variables and ensure
 # that $GIT_DIFF_TOOL always wins unless --tool is specified
-test_expect_success 'GIT_DIFF_TOOL overrides' '
+test_expect_success PERL 'GIT_DIFF_TOOL overrides' '
 	git config diff.tool bogus-tool &&
 	git config merge.tool bogus-tool &&
=20
@@ -136,7 +131,7 @@ test_expect_success 'GIT_DIFF_TOOL overrides' '
=20
 # Test that we don't have to pass --no-prompt to difftool
 # when $GIT_DIFFTOOL_NO_PROMPT is true
-test_expect_success 'GIT_DIFFTOOL_NO_PROMPT variable' '
+test_expect_success PERL 'GIT_DIFFTOOL_NO_PROMPT variable' '
 	GIT_DIFFTOOL_NO_PROMPT=3Dtrue &&
 	export GIT_DIFFTOOL_NO_PROMPT &&
=20
@@ -148,7 +143,7 @@ test_expect_success 'GIT_DIFFTOOL_NO_PROMPT variabl=
e' '
=20
 # git-difftool supports the difftool.prompt variable.
 # Test that GIT_DIFFTOOL_PROMPT can override difftool.prompt =3D false
-test_expect_success 'GIT_DIFFTOOL_PROMPT variable' '
+test_expect_success PERL 'GIT_DIFFTOOL_PROMPT variable' '
 	git config difftool.prompt false &&
 	GIT_DIFFTOOL_PROMPT=3Dtrue &&
 	export GIT_DIFFTOOL_PROMPT &&
@@ -160,7 +155,7 @@ test_expect_success 'GIT_DIFFTOOL_PROMPT variable' =
'
 '
=20
 # Test that we don't have to pass --no-prompt when difftool.prompt is =
false
-test_expect_success 'difftool.prompt config variable is false' '
+test_expect_success PERL 'difftool.prompt config variable is false' '
 	git config difftool.prompt false &&
=20
 	diff=3D$(git difftool branch) &&
@@ -170,7 +165,7 @@ test_expect_success 'difftool.prompt config variabl=
e is false' '
 '
=20
 # Test that we don't have to pass --no-prompt when mergetool.prompt is=
 false
-test_expect_success 'difftool merge.prompt =3D false' '
+test_expect_success PERL 'difftool merge.prompt =3D false' '
 	git config --unset difftool.prompt
 	git config mergetool.prompt false &&
=20
@@ -181,7 +176,7 @@ test_expect_success 'difftool merge.prompt =3D fals=
e' '
 '
=20
 # Test that the -y flag can override difftool.prompt =3D true
-test_expect_success 'difftool.prompt can overridden with -y' '
+test_expect_success PERL 'difftool.prompt can overridden with -y' '
 	git config difftool.prompt true &&
=20
 	diff=3D$(git difftool -y branch) &&
@@ -191,7 +186,7 @@ test_expect_success 'difftool.prompt can overridden=
 with -y' '
 '
=20
 # Test that the --prompt flag can override difftool.prompt =3D false
-test_expect_success 'difftool.prompt can overridden with --prompt' '
+test_expect_success PERL 'difftool.prompt can overridden with --prompt=
' '
 	git config difftool.prompt false &&
=20
 	prompt=3D$(echo | git difftool --prompt branch | tail -1) &&
@@ -201,7 +196,7 @@ test_expect_success 'difftool.prompt can overridden=
 with --prompt' '
 '
=20
 # Test that the last flag passed on the command-line wins
-test_expect_success 'difftool last flag wins' '
+test_expect_success PERL 'difftool last flag wins' '
 	diff=3D$(git difftool --prompt --no-prompt branch) &&
 	test "$diff" =3D "branch" &&
=20
@@ -215,7 +210,7 @@ test_expect_success 'difftool last flag wins' '
=20
 # git-difftool falls back to git-mergetool config variables
 # so test that behavior here
-test_expect_success 'difftool + mergetool config variables' '
+test_expect_success PERL 'difftool + mergetool config variables' '
 	remove_config_vars
 	git config merge.tool test-tool &&
 	git config mergetool.test-tool.cmd "cat \$LOCAL" &&
@@ -233,7 +228,7 @@ test_expect_success 'difftool + mergetool config va=
riables' '
 	restore_test_defaults
 '
=20
-test_expect_success 'difftool.<tool>.path' '
+test_expect_success PERL 'difftool.<tool>.path' '
 	git config difftool.tkdiff.path echo &&
 	diff=3D$(git difftool --tool=3Dtkdiff --no-prompt branch) &&
 	git config --unset difftool.tkdiff.path &&
@@ -243,32 +238,32 @@ test_expect_success 'difftool.<tool>.path' '
 	restore_test_defaults
 '
=20
-test_expect_success 'difftool --extcmd=3Dcat' '
+test_expect_success PERL 'difftool --extcmd=3Dcat' '
 	diff=3D$(git difftool --no-prompt --extcmd=3Dcat branch) &&
 	test "$diff" =3D branch"$LF"master
 '
=20
-test_expect_success 'difftool --extcmd cat' '
+test_expect_success PERL 'difftool --extcmd cat' '
 	diff=3D$(git difftool --no-prompt --extcmd cat branch) &&
 	test "$diff" =3D branch"$LF"master
 '
=20
-test_expect_success 'difftool -x cat' '
+test_expect_success PERL 'difftool -x cat' '
 	diff=3D$(git difftool --no-prompt -x cat branch) &&
 	test "$diff" =3D branch"$LF"master
 '
=20
-test_expect_success 'difftool --extcmd echo arg1' '
+test_expect_success PERL 'difftool --extcmd echo arg1' '
 	diff=3D$(git difftool --no-prompt --extcmd sh\ -c\ \"echo\ \$1\" bran=
ch)
 	test "$diff" =3D file
 '
=20
-test_expect_success 'difftool --extcmd cat arg1' '
+test_expect_success PERL 'difftool --extcmd cat arg1' '
 	diff=3D$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$1\" branc=
h)
 	test "$diff" =3D master
 '
=20
-test_expect_success 'difftool --extcmd cat arg2' '
+test_expect_success PERL 'difftool --extcmd cat arg2' '
 	diff=3D$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$2\" branc=
h)
 	test "$diff" =3D branch
 '
--=20
1.7.0.4
