From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 080/144] t6002-rev-list-bisect.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:25 -0700
Message-ID: <1395735989-3396-81-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:30:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMkd-0002Sm-Qk
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbaCYI2H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:07 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:54936 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbaCYI2F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:05 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so131635pbc.34
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2Cu44GEXmB9Oy0eQa6sV69uNTfEbhBNZs5oWl+o6dYI=;
        b=Gp+P3jcEqmmmisSm0lRIwix3sDRPzyt6h5YMAgS2KjADD0/xPgIHoIfDTS4wy9B3yH
         jRQTsd8A/HKrxd8XLrEw0Pvth14fEDXYox1BNUJ73qRKeeKr/XZRP4ANO/fYo3LBLU1b
         BbJM/863/bb0+V+ieE2PnLDtjXJ/M14Za12Va+m+H8cPvUbSOQiMtOKmf1Pz3974iKgG
         9eWC88037fAakYajuRuVGETCg+qQmENj/LKF+aOvsU4Wy0ELWxwpQOsWu6t+OyUlFhLZ
         cY1PBtxifVIAJWUwb0mtvk8UgSKoKOlCS5kHSo7HtuCz2wc19m4QimonhvzzLJTOW7HQ
         nBtw==
X-Received: by 10.66.122.1 with SMTP id lo1mr25489894pab.118.1395736085322;
        Tue, 25 Mar 2014 01:28:05 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244956>

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
 t/t6002-rev-list-bisect.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index 43ad772..3bf2759 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -27,9 +27,9 @@ test_bisection_diff()
 	# Test if bisection size is close to half of list size within
 	# tolerance.
 	#
-	_bisect_err=3D`expr $_list_size - $_bisection_size \* 2`
-	test "$_bisect_err" -lt 0 && _bisect_err=3D`expr 0 - $_bisect_err`
-	_bisect_err=3D`expr $_bisect_err / 2` ; # floor
+	_bisect_err=3D$(expr $_list_size - $_bisection_size \* 2)
+	test "$_bisect_err" -lt 0 && _bisect_err=3D$(expr 0 - $_bisect_err)
+	_bisect_err=3D$(expr $_bisect_err / 2) ; # floor
=20
 	test_expect_success \
 	"bisection diff $_bisect_option $_head $* <=3D $_max_diff" \
--=20
1.7.10.4
