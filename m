From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 051/144] t5000-tar-tree.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:56 -0700
Message-ID: <1395735989-3396-52-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:33:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMnk-0006H0-G2
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbaCYIdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:33:35 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35668 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbaCYI1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:34 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so126828pdj.34
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2RCwRVjK+s7vT35HgsEk1M0NV0wgkYhEiMrGmJ3lsMo=;
        b=sv0q1C5FJ9kIwVKbglW/O5y2bgFGUDu3XsSVwIzJsJEvUbtjxQDfBySbvGOwyqCZXc
         mW7VKeXjwFtH21oein2ioMseMegMDSEDhbaZp8YWYJbX7S1VH+EFyHjOpUFT6m1+Vt0M
         1Eyt3GBlDFzG69sPzRVC+4BP0M9eiw8B1mUgFe9UAN7MkslDTis3ii1cLo0DWasq0UW5
         aFvXjlVVKtDfTlxRabmgYhOyi4zfSKHYaySiDfyoyf2U5jiWjU8tiF0i5L3kYV4+rxuK
         gpEDjvskPy/bzCuBcxzThdijTx9tqExVOwyhQTthg6AsplvM3OW5WJZPJtG3XBeHyCg2
         aqOQ==
X-Received: by 10.68.196.226 with SMTP id ip2mr76426249pbc.106.1395736054160;
        Tue, 25 Mar 2014 01:27:34 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244977>

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
 t/t5000-tar-tree.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 1cf0a4e..74fc5a8 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -123,7 +123,7 @@ test_expect_success \
     'add files to repository' \
     'find a -type f | xargs git update-index --add &&
      find a -type l | xargs git update-index --add &&
-     treeid=3D`git write-tree` &&
+     treeid=3D$(git write-tree) &&
      echo $treeid >treeid &&
      git update-ref HEAD $(TZ=3DGMT GIT_COMMITTER_DATE=3D"2005-05-27 2=
2:00:00" \
      git commit-tree $treeid </dev/null)'
@@ -207,7 +207,7 @@ test_expect_success \
=20
 test_expect_success 'clients cannot access unreachable commits' '
 	test_commit unreachable &&
-	sha1=3D`git rev-parse HEAD` &&
+	sha1=3D$(git rev-parse HEAD) &&
 	git reset --hard HEAD^ &&
 	git archive $sha1 >remote.tar &&
 	test_must_fail git archive --remote=3D. $sha1 >remote.tar
@@ -215,7 +215,7 @@ test_expect_success 'clients cannot access unreacha=
ble commits' '
=20
 test_expect_success 'upload-archive can allow unreachable commits' '
 	test_commit unreachable1 &&
-	sha1=3D`git rev-parse HEAD` &&
+	sha1=3D$(git rev-parse HEAD) &&
 	git reset --hard HEAD^ &&
 	git archive $sha1 >remote.tar &&
 	test_config uploadarchive.allowUnreachable true &&
--=20
1.7.10.4
