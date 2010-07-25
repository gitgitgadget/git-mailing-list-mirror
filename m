From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 6/7] t/README: A new section about test coverage
Date: Sun, 25 Jul 2010 14:41:00 +0000
Message-ID: <1280068861-17701-7-git-send-email-avarab@gmail.com>
References: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 16:41:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od2OY-0001DE-07
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 16:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab0GYOl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 10:41:29 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36552 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab0GYOlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 10:41:25 -0400
Received: by ewy23 with SMTP id 23so602449ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/hwtJc1p+55FiUPOAo0iNN7eyMPZrfwOtFjPrnGLZno=;
        b=gYVy/DhmkweGlQ0VmmDhEg6JiWNa5T5ArnsvMM7Pj4G98996JKmPsReNwaXhZiGYba
         CRjdGCvuuEz84ims0KVa+G6PQ0z3/l8Onso1HScHeBMAaR14dKDEs2UXZW8KIth2nUup
         nJkNEgu90MlFk179C/V4RRRTrqlvDoTmRhT5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WWfdpcuTcybrrI2np4lugO+em7gmF+e5WR/g33F+tnk5C34lIHpZtspxELKrjdmHPs
         Tb4LaRoIcHq1h1drI0qpIqFYxiPXCFUOWGkWDI/v7nbuJN0OEqD9gMHZ/yeXEvwB4Wrz
         aHLVqkbxKTsFSm0V1lG9peEnDT7gl9Wwzf0LA=
Received: by 10.213.28.134 with SMTP id m6mr5192040ebc.96.1280068884366;
        Sun, 25 Jul 2010 07:41:24 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id x54sm3977142eeh.23.2010.07.25.07.41.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 07:41:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151751>

Document how test writers can generate coverage reports, to ensure
that their codepaths are being properly exercised.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 0d1183c..2fa6744 100644
--- a/t/README
+++ b/t/README
@@ -267,6 +267,9 @@ Do:
 	git merge hla &&
 	git push gh &&
 	test ...
+   =20
+ - Check the test coverage for your tests. See the "Test coverage"
+   below.
=20
 Don't:
=20
@@ -508,3 +511,42 @@ the purpose of t0000-basic.sh, which is to isolate=
 that level of
 validation in one place.  Your test also ends up needing
 updating when such a change to the internal happens, so do _not_
 do it and leave the low level of validation to t0000-basic.sh.
+
+Test coverage
+-------------
+
+You can use the coverage tests to find code paths that are not being
+used or properly exercised yet.
+
+To do that, run the coverage target at the top-level (not in the t/
+directory):
+
+    make coverage
+   =20
+That'll compile Git with GCC's coverage arguments, and generate a test
+report with gcov after the tests finish. Running the coverage tests
+can take a while, since running the tests in parallel is incompatible
+with GCC's coverage mode.
+
+After the tests have run you can generate a list of untested
+functions:
+
+    make coverage-untested-functions
+
+You can also generate a detailed per-file HTML report using the
+Devel::Cover module. To install it do:
+
+   # On Debian or Ubuntu:
+   sudo aptitude install libdevel-cover-perl
+
+   # From the CPAN with cpanminus
+   curl -L http://cpanmin.us | perl - --sudo --self-upgrade
+   cpanm --sudo Devel::Cover
+  =20
+Then, at the top-level:
+
+    make coverage-report-cover-db-html
+
+That'll generate a detailed cover report in the "cover_db_html"
+directory, which you can then copy to a webserver, or inspect locally
+in a browser.
--=20
1.7.0.4
