From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 027/144] t1511-rev-parse-caret.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:32 -0700
Message-ID: <1395735989-3396-28-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:36:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMqp-0001hH-LU
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbaCYIgo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:36:44 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34084 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbaCYI1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so133815pbb.5
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YMnygHIaLZun6uw/Yu7+W1NdcRf+2p/ECQs1XKhOzi4=;
        b=QwpKAvagp0YMPsZM10zvNBw/rhojeg0BhZrJ1Paty3aTFveshHxyGNptM6K6PvOZCl
         OAYFsLjfTJSav5/xvKgc2RETj9DZm4P69Mp2n1xgBTIoEH7/B3HfFnyhS6lPlj3agL9b
         DCfgv4P9fNT5LTB+Q8CLTwtQrMKIxqOQqoD5W+BXQlU0djklsqe5WekscHAJY2s2Mi+R
         NcTRn8fd0Duyl8wGaHHO25vXYvsRzrpK/PYEuGHLbYTvgP/7UsdC/sFPuoiZE9IeD2J4
         MhXyKTGQE0+QzSwXuhU5efQesRrmrj80eJTrCiyYK8OsETWHSSpY3Gudjyp7iG45j8/T
         eZOg==
X-Received: by 10.68.90.132 with SMTP id bw4mr14306675pbb.136.1395736029170;
        Tue, 25 Mar 2014 01:27:09 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244998>

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
 t/t1511-rev-parse-caret.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index 15973f2..7043ba7 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -6,11 +6,11 @@ test_description=3D'tests for ref^{stuff}'
=20
 test_expect_success 'setup' '
 	echo blob >a-blob &&
-	git tag -a -m blob blob-tag `git hash-object -w a-blob` &&
+	git tag -a -m blob blob-tag $(git hash-object -w a-blob) &&
 	mkdir a-tree &&
 	echo moreblobs >a-tree/another-blob &&
 	git add . &&
-	TREE_SHA1=3D`git write-tree` &&
+	TREE_SHA1=3D$(git write-tree) &&
 	git tag -a -m tree tree-tag "$TREE_SHA1" &&
 	git commit -m Initial &&
 	git tag -a -m commit commit-tag &&
--=20
1.7.10.4
