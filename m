From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/4] t/README: Update "Skipping tests" to align with best practices
Date: Tue, 27 Jul 2010 21:14:14 +0000
Message-ID: <1280265254-19642-6-git-send-email-avarab@gmail.com>
References: <1280265254-19642-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 23:15:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrUL-00082N-6Y
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab0G0VOx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 17:14:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42099 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab0G0VOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:14:52 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so3597805bwz.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qwCy9hUdJT4SVshm+MALKpjZxebuAPU345sWNGBk83o=;
        b=wmRxO6AsDTRDxw5jjYKjFBTg8k85VYlckJIFdeac4XRoCfI6y4dvXA7Szys7ce9zqo
         To2womDwHJnb6iGnmKFKQpaQm7+scda1w65vla8TOi4jvjLiUp10wbxdlPL/uBkBKW1/
         MCs/AhFzPqYjWHfcSFyUGgRSJK/QgcTu4S9AU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bpq1tdaZZ5o+JUDnHT5TKRlK+h5JjdFmasbF/PHs1Pg0xp5DYLARhW3VOcOYomLsGx
         +GVZEYxlfuc2qJVmArPTSfSHB2qoaCr4mJBE9ebW5fieG4qJc1cs6p9tWCZB1uVYtnDs
         lJ5ANHEbxxHpmYPJS7+ZBSMu/LmZLp90MQeHY=
Received: by 10.204.150.74 with SMTP id x10mr7079249bkv.130.1280265291732;
        Tue, 27 Jul 2010 14:14:51 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id y2sm4172562bkx.20.2010.07.27.14.14.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 14:14:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280265254-19642-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151995>

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
