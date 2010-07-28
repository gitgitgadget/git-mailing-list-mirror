From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 5/5] t/README: Update "Skipping tests" to align with best practices
Date: Wed, 28 Jul 2010 10:34:59 +0000
Message-ID: <1280313299-721-6-git-send-email-avarab@gmail.com>
References: <1280313299-721-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 12:35:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3zR-0006yf-0s
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 12:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab0G1Kfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 06:35:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33116 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab0G1Kfa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 06:35:30 -0400
Received: by bwz1 with SMTP id 1so3850048bwz.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qwCy9hUdJT4SVshm+MALKpjZxebuAPU345sWNGBk83o=;
        b=M4isO3u958oggKi3UpBwOyen32MCyTA82TwEpNLnOAz0XjesXcLwlQm0jRUpYXDgGF
         HSqr53lrnEMxJEAUkn2GdsSY/loRLLtW8dXZQGLXIgWx9hc0U843qV4N8uel/BBfD/cR
         VUm+Sn/QRyPXJFMpWlPUvmlNWKt62TWEghdcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YidkNvZoUHbbnQ4ZqCggLxt4XxwW67DKWdetokCjPvGdwPk4MyzcPYWrNnLZzd/lRe
         tDcYuKhfE9728ut/JFfhDGQGHUfJos2bYvp/dV24f5b1RA1Y2GATQ++cKfZrUtod7uem
         tQsiALbQ1gnFR3mHDSDaFw6A7PnsCvDigp688=
Received: by 10.204.47.193 with SMTP id o1mr7698015bkf.134.1280313329216;
        Wed, 28 Jul 2010 03:35:29 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id g11sm4661233bkw.22.2010.07.28.03.35.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 03:35:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280313299-721-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152073>

The example I initially added to "Skipping tests" wasn't very
good. We'd rather skip tests using the three-arg prereq form to the
test_* functions, not bail out with a skip message.

Change the documentation to reflect that, but retain the bailout
example under a disclaimer which explains that it's probably not a
good idea to use it.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index 0d1183c..12b714b 100644
--- a/t/README
+++ b/t/README
@@ -307,9 +307,21 @@ Keep in mind:
 Skipping tests
 --------------
=20
-If you need to skip all the remaining tests you should set skip_all
-and immediately call test_done. The string you give to skip_all will
-be used as an explanation for why the test was skipped. for instance:
+If you need to skip tests you should do so be using the three-arg form
+of the test_* functions (see the "Test harness library" section
+below), e.g.:
+
+    test_expect_success PERL 'I need Perl' "
+        '$PERL_PATH' -e 'hlagh() if unf_unf()'
+    "
+
+The advantage of skipping tests like this is that platforms that don't
+have the PERL and other optional dependencies get an indication of how
+many tests they're missing.
+
+If the test code is too hairy for that (i.e. does a lot of setup work
+outside test assertions) you can also skip all remaining tests by
+setting skip_all and immediately call test_done:
=20
 	if ! test_have_prereq PERL
 	then
@@ -317,6 +329,9 @@ be used as an explanation for why the test was skip=
ped. for instance:
 	    test_done
 	fi
=20
+The string you give to skip_all will be used as an explanation for why
+the test was skipped.
+
 End with test_done
 ------------------
=20
--=20
1.7.0.4
