From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 6/6] git-cvsserver: test for pserver authentication support
Date: Sat, 15 May 2010 02:46:04 +0000
Message-ID: <1273891564-7523-7-git-send-email-avarab@gmail.com>
References: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 04:47:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD7PB-0008Qv-HT
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 04:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756425Ab0EOCqw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 22:46:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:6840 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab0EOCqr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 22:46:47 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1937180fga.1
        for <git@vger.kernel.org>; Fri, 14 May 2010 19:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=VIPn/6L98Kos0q9yDdYopAJyaZp8h+HkOQO7ztc+gQw=;
        b=leSGksdZ76XNS4uOB/gv8TbGE0Yv7wJMlMkClCSlCJHc/D2EWdKEhiMXWvi+iynPZe
         0ePKHLUzPOWp8C6H/AIv3Cd5quS0WkzBnRFj8EHtf85+ufcqN3x6G7L4kI28rrdx1fvy
         KCcnhtgj7Nsb61a4TjaKLbD+k6in0Oz+g46n0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KbNOIRX67R+rz4pTnddSctTDNsbuPA579kigXze/Ds0ZQkPjOoMTn0gwMm3sl5R+w4
         uh/+bwjxnbl73qaYT9Z4Jo6gXPeiF2ayZUitMfy6T6/wBsDkNzothL4OUSFoXB7hfX0y
         jpEbIqBDvR2LPLvehBvexDckSeJY0y0lXmLsk=
Received: by 10.87.74.32 with SMTP id b32mr3901625fgl.46.1273891606478;
        Fri, 14 May 2010 19:46:46 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 22sm4155718fkq.17.2010.05.14.19.46.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 19:46:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.84.gd92f8
In-Reply-To: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147130>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t9400-git-cvsserver-server.sh |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-se=
rver.sh
index daef2d6..437e9b8 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -48,7 +48,9 @@ test_expect_success 'setup' '
   git pull secondroot master &&
   git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
   GIT_DIR=3D"$SERVERDIR" git config --bool gitcvs.enabled true &&
-  GIT_DIR=3D"$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.=
log"
+  GIT_DIR=3D"$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.=
log" &&
+  GIT_DIR=3D"$SERVERDIR" git config gitcvs.authdb "$SERVERDIR/auth.db"=
 &&
+  echo cvsuser:cvGVEarMLnhlA > "$SERVERDIR/auth.db"
 '
=20
 # note that cvs doesn't accept absolute pathnames
@@ -94,6 +96,14 @@ git
 END VERIFICATION REQUEST
 EOF
=20
+cat >login-git-ok <<EOF
+BEGIN VERIFICATION REQUEST
+$SERVERDIR
+cvsuser
+Ah<Z:yZZ30 e
+END VERIFICATION REQUEST
+EOF
+
 test_expect_success 'pserver authentication' \
   'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU\$"'
@@ -107,6 +117,10 @@ test_expect_success 'pserver authentication failur=
e (non-anonymous user)' \
    fi &&
    sed -ne \$p log | grep "^I HATE YOU\$"'
=20
+test_expect_success 'pserver authentication success (non-anonymous use=
r with password)' \
+  'cat login-git-ok | git-cvsserver pserver >log 2>&1 &&
+   sed -ne \$p log | grep "^I LOVE YOU\$"'
+
 test_expect_success 'pserver authentication (login)' \
   'cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU\$"'
--=20
1.7.1.84.gd92f8
