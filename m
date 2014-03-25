From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 063/144] t5510-fetch.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:08 -0700
Message-ID: <1395735989-3396-64-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:32:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMmf-0004vU-Hx
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbaCYIc0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:32:26 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:47533 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872AbaCYI1r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:47 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so129640pbb.40
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YEhOwpnGy8mYUNFbBNyzDdZO3R0Wf0Rqz1eomoj6gTw=;
        b=BXSnnLwKpmuqFpBNPTrq7cehYVoDOPYp0XomT4AmN/jFGfnIjsQD80RSaLax/pX+lG
         Sai3LK8Ysdapt1N6hyp7b3GubN43L61dTQgKiAE813qOl3VNABCzV0NfybneVho4VcXd
         SJ4e5qjcT/JBnrpaSu2T2XYqxLSY/LGs6p25i1aXVRTG7a9wDfS8e6n0J/oTTFIcjG8X
         3Gp/o6eeCqxgNvE7P6nVwdl2Oh0Ps8sr+zDGyof5gIuDy+dPGe6T8U3NOFRcPzZoUSym
         SoCqVJlvaDXXP6pNtWepstEGXzko25pm75W6acp42x82SHco9hBjPiCcZSHUZzP1Oana
         55Cw==
X-Received: by 10.68.172.37 with SMTP id az5mr14368935pbc.139.1395736067190;
        Tue, 25 Mar 2014 01:27:47 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244970>

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
 t/t5510-fetch.sh |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ab28594..31b185e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -7,7 +7,7 @@ test_description=3D'Per branch config variables affects=
 "git fetch".
=20
 . ./test-lib.sh
=20
-D=3D`pwd`
+D=3D$(pwd)
=20
 test_bundle_object_count () {
 	git verify-pack -v "$1" >verify.out &&
@@ -64,8 +64,8 @@ test_expect_success "fetch test" '
 	cd two &&
 	git fetch &&
 	test -f .git/refs/heads/one &&
-	mine=3D`git rev-parse refs/heads/one` &&
-	his=3D`cd ../one && git rev-parse refs/heads/master` &&
+	mine=3D$(git rev-parse refs/heads/one) &&
+	his=3D$(cd ../one && git rev-parse refs/heads/master) &&
 	test "z$mine" =3D "z$his"
 '
=20
@@ -75,8 +75,8 @@ test_expect_success "fetch test for-merge" '
 	git fetch &&
 	test -f .git/refs/heads/two &&
 	test -f .git/refs/heads/one &&
-	master_in_two=3D`cd ../two && git rev-parse master` &&
-	one_in_two=3D`cd ../two && git rev-parse one` &&
+	master_in_two=3D$(cd ../two && git rev-parse master) &&
+	one_in_two=3D$(cd ../two && git rev-parse one) &&
 	{
 		echo "$one_in_two	"
 		echo "$master_in_two	not-for-merge"
--=20
1.7.10.4
