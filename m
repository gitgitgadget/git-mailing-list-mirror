From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 6/6] t/README: A new section about test coverage
Date: Sat, 24 Jul 2010 20:51:03 +0000
Message-ID: <1280004663-4887-7-git-send-email-avarab@gmail.com>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 22:52:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oclhd-0007lP-Tn
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 22:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634Ab0GXUwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 16:52:07 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63711 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575Ab0GXUwF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 16:52:05 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so496366ewy.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 13:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=GOkAAtZp6/iQQ6+4ijYVa5yb0zJgEfO9az4GYoClIvI=;
        b=BRtKa17hAB46OOPFKR4OzKfoxMLi3iNyqdVTuwLAX+TBjwUjb0AkY38PWvq1qk0JKT
         tVnd2hPd6f9IOfL/G05MkGL5UnzuJlzTis9ntAGY1eaFl5k3LslBpf57tmHbpcasc3Fm
         tjkqZ1fruMnNA7S6rkk/tknTeiqxWK5ISbYME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ReQ+X6pusXZnczVq4yhzjDIOoBfl2o7xxiS9gbCGCnsbPhOnciITv/dndPQZev9xEE
         jx/yPWrQ1e530fVaOWBGj2jr9tVZmfF+fbj+MBfZwBT5QCd1BY2PQA3IA9vjFyZV3HPJ
         Ysk02ETy0JXpqequWwaX6BxGIcV6JDDcsoE9c=
Received: by 10.213.31.139 with SMTP id y11mr4696510ebc.27.1280004723267;
        Sat, 24 Jul 2010 13:52:03 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm2701243eei.6.2010.07.24.13.52.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 13:52:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280004663-4887-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151675>

Document how test writers can generate coverage reports, to ensure
that their tests are really testing the code they think they're
testing.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 0d1183c..718f35d 100644
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
@@ -508,3 +511,40 @@ the purpose of t0000-basic.sh, which is to isolate=
 that level of
 validation in one place.  Your test also ends up needing
 updating when such a change to the internal happens, so do _not_
 do it and leave the low level of validation to t0000-basic.sh.
+
+Test coverage
+-------------
+
+You can use the coverage tests to find out if your tests are really
+testing your code code. To do that, run the coverage target at the
+top-level (not in the t/ directory):
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
+    make coverage-report-untested-functions
+
+You can also generate a detailed per-file HTML report using the
+Devel::Cover module. To install it do:
+
+   # On Debian:
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
