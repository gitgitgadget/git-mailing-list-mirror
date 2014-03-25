From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 097/144] t8003-blame-corner-cases.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:42 -0700
Message-ID: <1395735989-3396-98-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMik-00008U-I4
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbaCYI2Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:24 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:59427 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaCYI2X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:23 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so126330pad.29
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3IlwD3j0oYfoqEyjgB57qkLM4L16myLmvs4qQgZqTho=;
        b=BziPSz4mYpp9ykG7AqizTekMHEh45CUUbfn78MY+7H3bYO2vFU0ACueUtDG5wdOJuU
         yTvdT5iqmyHhR5X41yMv0IhXNbooC5nYLpTZ04Rl48roUIM+pJwqrWeEvjF7xq9DZJUi
         k44S//KxIwcNFbkwzchrUnlPo08kf+xHvUBC4lmSSi1fggnhnbdwTH4mIfQ96an4Ff+u
         Bfj8KMpvXPtHhg7VWhhLKAkUrMceAWesYyFOEag0ivFE06fnREqfiMNpKFdma8vgwsa/
         y7nGaA4KlPI1f1C69XEY7M99xXPjr1hN0Ux2/NgW+20TRp9YhBQiJ8IR5dZbmFZ9xTUN
         +9Kg==
X-Received: by 10.66.217.133 with SMTP id oy5mr78283519pac.46.1395736102733;
        Tue, 25 Mar 2014 01:28:22 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244936>

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
 t/t8003-blame-corner-cases.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases=
=2Esh
index e7cac1d..4216d08 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -153,7 +153,7 @@ test_expect_success 'blame path that used to be a d=
irectory' '
 '
=20
 test_expect_success 'blame to a commit with no author name' '
-  TREE=3D`git rev-parse HEAD:`
+  TREE=3D$(git rev-parse HEAD:)
   cat >badcommit <<EOF
 tree $TREE
 author <noname> 1234567890 +0000
@@ -161,7 +161,7 @@ committer David Reiss <dreiss@facebook.com> 1234567=
890 +0000
=20
 some message
 EOF
-  COMMIT=3D`git hash-object -t commit -w badcommit`
+  COMMIT=3D$(git hash-object -t commit -w badcommit)
   git --no-pager blame $COMMIT -- uno >/dev/null
 '
=20
--=20
1.7.10.4
