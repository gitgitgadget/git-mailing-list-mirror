From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 070/144] t5537-fetch-shallow.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:15 -0700
Message-ID: <1395735989-3396-71-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:30:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMl5-0002yv-J0
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbaCYIar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:30:47 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:64854 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaCYI1z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:55 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so129948pbc.32
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VMnLKkUlzSAp78s9fJupN7dho9XsDjDsW+/MvwCVydE=;
        b=HvSVjBkqiEef1zSwuvPGX9J6yIK9D+QVd6X7HYSy9XlS0t4rFR89vJhtvqHip3qCyA
         IVlcy3GMvhgKCmDp7MwLAA7yeVhO+5v8TA+99idDuBR/zAmpczrTl9KRSlUqff4vhPA0
         HLHsU48vhxeULDGwGaTZj+sqZu17lAXuVMiTthavEUtZNN2ZZ2f4kH6CcAVD9zP8E85Z
         Gg7xFacBB+fpaMZkq5t5Zb9CTKCzmrNrn+snN2VJY8mwTVZehL+kibEur0+vbTHc0u3S
         ovsbMKdIx3x18xP8hZJgP0kyvPv80nwGyCCOO1pqhA2nZZJgZVLDNWXDvwEAoKgTsjUQ
         li6g==
X-Received: by 10.68.178.131 with SMTP id cy3mr9249057pbc.146.1395736074630;
        Tue, 25 Mar 2014 01:27:54 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244959>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5537-fetch-shallow.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index be951a4..d9ea98a 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -98,7 +98,7 @@ EOF
 test_expect_success 'fetch something upstream has but hidden by client=
s shallow boundaries' '
 	# the blob "1" is available in .git but hidden by the
 	# shallow2/.git/shallow and it should be resent
-	! git --git-dir=3Dshallow2/.git cat-file blob `echo 1|git hash-object=
 --stdin` >/dev/null &&
+	! git --git-dir=3Dshallow2/.git cat-file blob $(echo 1|git hash-objec=
t --stdin) >/dev/null &&
 	echo 1 >1.t &&
 	git add 1.t &&
 	git commit -m add-1-back &&
@@ -114,7 +114,7 @@ add-1-back
 EOF
 	test_cmp expect actual
 	) &&
-	git --git-dir=3Dshallow2/.git cat-file blob `echo 1|git hash-object -=
-stdin` >/dev/null
+	git --git-dir=3Dshallow2/.git cat-file blob $(echo 1|git hash-object =
--stdin) >/dev/null
=20
 '
=20
--=20
1.7.10.4
