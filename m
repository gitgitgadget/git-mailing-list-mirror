From: J Smith <dark.panda@gmail.com>
Subject: [PATCH/RFC 2/2] grep: rename "grep.extendedRegexp" option to "grep.patternType"
Date: Tue, 31 Jul 2012 18:53:29 -0400
Message-ID: <1343775209-56505-2-git-send-email-dark.panda@gmail.com>
References: <1343775209-56505-1-git-send-email-dark.panda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 00:53:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwLJs-0005kF-5L
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 00:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab2GaWxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 18:53:34 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:49524 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab2GaWxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 18:53:33 -0400
Received: by vcbfk26 with SMTP id fk26so6433600vcb.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 15:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1RH67FMG/HjVu110rHkV4TXyiv+V4FRpnC4tsSAyhAI=;
        b=axcktEgFyGGmr/Qutx5umovgdBng6GOBOBN4hAAQibOYT2bbbNV8E61jrISVOps8Rz
         qCPLfzVAKEVMtWOFr0qc9H5Prhq5Mrv/Cy4LfFkZtrh3nzTXFB0EvLipoZKH1jUAoOcg
         vL66aYLrsa2usCOFcapXT43rYgVdU02uxBuSWmDsMeEKnIP25R3JXDgT1XQXEqKnTe7b
         VsNcaD7P1lbld9GbGuneB1lw/XU6D1ndXR5Q4YhKrrThcOT17fWPWjgoEmXYpPtDtLVZ
         /ClPVsQNWqnLlOPj+OKyUYnVaLV/N5pJ8BvxmLLvin638Rqz/gqsdlz0fJ6gyWnsb0LN
         T6Xg==
Received: by 10.220.141.202 with SMTP id n10mr15316469vcu.49.1343775212452;
        Tue, 31 Jul 2012 15:53:32 -0700 (PDT)
Received: from localhost.localdomain (surf3.net.rss.rogers.com. [24.114.255.3])
        by mx.google.com with ESMTPS id l9sm1324261vdw.14.2012.07.31.15.53.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2012 15:53:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343775209-56505-1-git-send-email-dark.panda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202691>

With the addition of the "basic", "extended", "fixed", and "perl"
values for the "grep.extendedRegexp" option the name "grep.patternType"
better represents the option's functionality. "grep.extendedRegexp"
remains available as an alias to "grep.patternType" for the purposes of
backwards compatibility.
---
 Documentation/config.txt   |  5 ++-
 Documentation/git-grep.txt |  5 ++-
 builtin/grep.c             |  4 ++-
 t/t7810-grep.sh            | 80 ++++++++++++++++++++++++++--------------------
 4 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 67d9f24..9644bba 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1210,13 +1210,16 @@ gitweb.snapshot::
 grep.lineNumber::
 	If set to true, enable '-n' option by default.

-grep.extendedRegexp::
+grep.patternType::
 	Sets the default matching behavior. This option can be set to a
 	boolean value or one of 'basic', 'extended', 'fixed', or 'perl'
 	which will enable the '--basic-regexp', '--extended-regexp',
 	'--fixed-strings' or '--perl-regexp' options accordingly. The value
 	of 'true' is equivalent to 'extended'.

+grep.extendedRegexp::
+	Alias for grep.patternType.
+
 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
 	making or verifying a PGP signature. The program must support the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 100328f..d51cc19 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -42,13 +42,16 @@ CONFIGURATION
 grep.lineNumber::
 	If set to true, enable '-n' option by default.

-grep.extendedRegexp::
+grep.patternType::
 	Sets the default matching behavior. This option can be set to a
 	boolean value or one of 'basic', 'extended', 'fixed', or 'perl'
 	which will enable the '--basic-regexp', '--extended-regexp',
 	'--fixed-strings' or '--perl-regexp' options accordingly. The value
 	of 'true' is equivalent to 'extended'.

+grep.extendedRegexp::
+	Alias for grep.patternType.
+

 OPTIONS
 -------
diff --git a/builtin/grep.c b/builtin/grep.c
index 249fc7d..a8c1c32 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -317,7 +317,9 @@ static int grep_config(const char *var, const char *value, void *cb)
 	if (userdiff_config(var, value) < 0)
 		return -1;

-	if (!strcmp(var, "grep.extendedregexp")) {
+	if (!strcmp(var, "grep.patterntype") ||
+			/* for backwards compatibility */
+			!strcmp(var, "grep.extendedregexp")) {
 		grep_pattern_type_options(parse_pattern_type_arg(var, value), opt);
 		return 0;
 	}
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index c21cd61..6bfe368 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -239,32 +239,32 @@ do
 		git grep --max-depth 0 -n -e vvv $H -- t . >actual &&
 		test_cmp expected actual
 	'
-	test_expect_success "grep $L with grep.extendedRegexp=false" '
+	test_expect_success "grep $L with grep.patternType=false" '
 		echo "ab:a+bc" >expected &&
-		git -c grep.extendedRegexp=false grep "a+b*c" ab >actual &&
+		git -c grep.patterntype=false grep "a+b*c" ab >actual &&
 		test_cmp expected actual
 	'

-	test_expect_success "grep $L with grep.extendedRegexp=true" '
+	test_expect_success "grep $L with grep.patternType=true" '
 		echo "ab:abc" >expected &&
-		git -c grep.extendedRegexp=true grep "a+b*c" ab >actual &&
+		git -c grep.patterntype=true grep "a+b*c" ab >actual &&
 		test_cmp expected actual
 	'

-	test_expect_success "grep $L with grep.extendedRegexp=extended" '
+	test_expect_success "grep $L with grep.patternType=extended" '
 		echo "ab:abc" >expected &&
-		git -c grep.extendedregexp=extended grep "a+b*c" ab >actual &&
+		git -c grep.patterntype=extended grep "a+b*c" ab >actual &&
 		test_cmp expected actual
 	'

-	test_expect_success "grep $L with grep.extendedRegexp=fixed" '
+	test_expect_success "grep $L with grep.patternType=fixed" '
 		echo "ab:abc" >expected &&
-		git -c grep.extendedregexp=fixed grep "ab" ab >actual &&
+		git -c grep.patterntype=fixed grep "ab" ab >actual &&
 		test_cmp expected actual
 	'

-	test_expect_success "grep $L with a valid regexp and grep.extendedRegexp=fixed " '
-		test_must_fail git -c grep.extendedregexp=fixed grep "a*" ab
+	test_expect_success "grep $L with a valid regexp and grep.patternType=fixed " '
+		test_must_fail git -c grep.patterntype=fixed grep "a*" ab
 	'

 	test_expect_success "grep $L with grep.extendedRegexp=basic" '
@@ -748,91 +748,91 @@ test_expect_success LIBPCRE 'grep -P pattern' '
 	test_cmp expected actual
 '

-test_expect_success 'grep pattern with grep.extendedRegexp=true' '
+test_expect_success 'grep pattern with grep.patternType=true' '
 	>empty &&
-	test_must_fail git -c grep.extendedregexp=true \
+	test_must_fail git -c grep.patterntype=true \
 		grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp empty actual
 '

-test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=true' '
-	git -c grep.extendedregexp=true \
+test_expect_success LIBPCRE 'grep -P pattern with grep.patternType=true' '
+	git -c grep.patterntype=true \
 		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp expected actual
 '

-test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=basic' '
-	git -c grep.extendedregexp=basic \
+test_expect_success LIBPCRE 'grep -P pattern with grep.patternType=basic' '
+	git -c grep.patterntype=basic \
 		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp expected actual
 '

-test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=extended' '
+test_expect_success LIBPCRE 'grep -P pattern with grep.patternType=extended' '
 	git -c grep.extendedregexp=extended \
 		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp expected actual
 '

-test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=fixed' '
-	git -c grep.extendedregexp=fixed \
+test_expect_success LIBPCRE 'grep -P pattern with grep.patternType=fixed' '
+	git -c grep.patterntype=fixed \
 		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp expected actual
 '

-test_expect_success LIBPCRE 'grep pattern with grep.extendedRegexp=perl' '
-	git -c grep.extendedregexp=perl \
+test_expect_success LIBPCRE 'grep pattern with grep.patternType=perl' '
+	git -c grep.patterntype=perl \
 		grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp expected actual
 '

-test_expect_success 'grep -E pattern with grep.extendedRegexp=perl' '
-	test_must_fail git -c grep.extendedregexp=perl \
+test_expect_success 'grep -E pattern with grep.patternType=perl' '
+	test_must_fail git -c grep.patterntype=perl \
 		grep -E "\p{Ps}.*?\p{Pe}" hello.c
 '

-test_expect_success 'grep -G pattern with grep.extendedRegexp=perl' '
-	test_must_fail git -c grep.extendedregexp=perl \
+test_expect_success 'grep -G pattern with grep.patternType=perl' '
+	test_must_fail git -c grep.patterntype=perl \
 		grep -G "\p{Ps}.*?\p{Pe}" hello.c
 '

-test_expect_success 'grep pattern with grep.extendedRegexp=fixed' '
+test_expect_success 'grep pattern with grep.patternType=fixed' '
 	>empty &&
-	test_must_fail git -c grep.extendedregexp=fixed \
+	test_must_fail git -c grep.patterntype=fixed \
 		grep ".*" ab >actual &&
 	test_cmp empty actual
 '

-test_expect_success 'grep -E pattern with grep.extendedRegexp=basic' '
+test_expect_success 'grep -E pattern with grep.patternType=basic' '
 	{
 		echo "ab:a+b*c"
 		echo "ab:a+bc"
 		echo "ab:abc"
 	} >expected &&
-	git -c grep.extendedregexp=basic \
+	git -c grep.patterntype=basic \
 		grep -E ".?" ab >actual &&
 	test_cmp expected actual
 '

-test_expect_success 'grep -E pattern with grep.extendedRegexp=fixed' '
+test_expect_success 'grep -E pattern with grep.patternType=fixed' '
 	{
 		echo "ab:a+b*c"
 		echo "ab:a+bc"
 		echo "ab:abc"
 	} >expected &&
-	git -c grep.extendedregexp=fixed \
+	git -c grep.patterntype=fixed \
 		grep -E ".?" ab >actual &&
 	test_cmp expected actual
 '

-test_expect_success 'grep -G pattern with grep.extendedRegexp=fixed' '
+test_expect_success 'grep -G pattern with grep.patternType=fixed' '
 	>empty &&
-	test_must_fail git -c grep.extendedregexp=fixed \
+	test_must_fail git -c grep.patterntype=fixed \
 		grep -G ".?" ab >actual &&
 	test_cmp empty actual
 '

-test_expect_success 'grep with grep.extendedRegexp=nonsense properly dies' '
-	test_must_fail git -c grep.extendedregexp=nonsense \
+test_expect_success 'grep with grep.patternType=nonsense properly dies' '
+	test_must_fail git -c grep.patterntype=nonsense \
 		grep "\p{Ps}.*?\p{Pe}" hello.c
 '

@@ -1015,4 +1015,14 @@ test_expect_success LIBPCRE 'grep -P "^ "' '
 	test_cmp expected actual
 '

+test_expect_success "grep with grep.extendedRegexp=true for backwards compatibility" '
+	{
+		echo "ab:a+b*c"
+		echo "ab:a+bc"
+		echo "ab:abc"
+	} >expected &&
+	git -c grep.extendedregexp=true grep "a?" ab >actual &&
+	test_cmp expected actual
+'
+
 test_done
--
1.7.11.3
