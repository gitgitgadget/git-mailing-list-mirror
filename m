From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 067/144] t5520-pull.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:12 -0700
Message-ID: <1395735989-3396-68-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:32:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMm8-0004GO-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbaCYIby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:31:54 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40197 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbaCYI1v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:51 -0400
Received: by mail-pa0-f46.google.com with SMTP id kp14so123996pab.33
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ti9CgwTedQL2SfYL4XlHJENMk7qWcU+ovBBskOgYvX4=;
        b=tMxcJ7AlMJit2MjQ9oPE1zKxrlLMOH3Ve5PcIrgnBNUVPryZSnGXLjnJu7QYMUeorZ
         GW0vL7yHAilFI7FHJYlUmDqRpcSMGdrr6NiIBc71/ILLg2yi7wSWms9cRXWX8PSPcMbI
         vjuT9xJKWC/YtxWum4QoyEaTA+RlArxZO1Gg7wXLHaItsuuKO5eKbJA4znodCjroH8cj
         DXwEU1hw99aCaZwodD9CiO6MagnIO+FxaTxlJS9K6R1K2yuoe0KPTKGqkd1LCiRTzZ6y
         dnKFtybZwa7v58GtTtCYiBxZPaS7lt4dboN6HqHAq95xyC0p/HQ2SF+sGLtG3DTzlWZL
         J2Tw==
X-Received: by 10.68.224.195 with SMTP id re3mr76805097pbc.93.1395736070934;
        Tue, 25 Mar 2014 01:27:50 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244965>

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
 t/t5520-pull.sh |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 227d293..a68c099 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -9,7 +9,7 @@ modify () {
 	mv "$2.x" "$2"
 }
=20
-D=3D`pwd`
+D=3D$(pwd)
=20
 test_expect_success setup '
=20
@@ -94,9 +94,9 @@ test_expect_success 'test . as a remote' '
 	echo updated >file &&
 	git commit -a -m updated &&
 	git checkout copy &&
-	test `cat file` =3D file &&
+	test $(cat file) =3D file &&
 	git pull &&
-	test `cat file` =3D updated
+	test $(cat file) =3D updated
 '
=20
 test_expect_success 'the default remote . should not break explicit pu=
ll' '
@@ -105,9 +105,9 @@ test_expect_success 'the default remote . should no=
t break explicit pull' '
 	git commit -a -m modified &&
 	git checkout copy &&
 	git reset --hard HEAD^ &&
-	test `cat file` =3D file &&
+	test $(cat file) =3D file &&
 	git pull . second &&
-	test `cat file` =3D modified
+	test $(cat file) =3D modified
 '
=20
 test_expect_success '--rebase' '
--=20
1.7.10.4
