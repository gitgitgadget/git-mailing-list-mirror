From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 041/144] t4010-diff-pathspec.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:46 -0700
Message-ID: <1395735989-3396-42-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMhq-0007QX-Ao
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbaCYI1a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:30 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:50803 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbaCYI1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:24 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so128386pdj.37
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4s/cNTeTwj80zSJqsl7ALhEhX0iVB1sI2Vs189qTcss=;
        b=ZjCWSN1uSljgkH107dGoZxmyt8rZ1Au6MEUpbP2nMA64rHI9eRgxUDrXDfttC8nZWe
         hjDZTOFqk+TxzrEkhn/y1c5ta5iKGBU5Dq3mPfptZrrEHfkQ4dGrZX+YZUXQC/8XmL4f
         l40JCKDQOBxFE86hScB2f/H1aGMx5kH1KEWkA+/vwDCbgKSFiNmxihJC+HDHZiTSNHR2
         bTFUqRQYlvf4LFHnLh/Pjm1lGG6FcNE9WGssf7UegKnqB+SqfcOfBa2FJEs3ViOixvNU
         jKfz/cgnRpvyTmkMIQuWOcLnmYdr+ujo7UCH9qDJxTfP0GFv6LvnlT+iBbnibPCiOKgK
         0n+A==
X-Received: by 10.68.190.200 with SMTP id gs8mr14289926pbc.130.1395736043906;
        Tue, 25 Mar 2014 01:27:23 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244920>

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
 t/t4010-diff-pathspec.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 2bb9736..bf07841 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -18,7 +18,7 @@ test_expect_success \
      mkdir path1 &&
      echo rezrov >path1/file1 &&
      git update-index --add file0 path1/file1 &&
-     tree=3D`git write-tree` &&
+     tree=3D$(git write-tree) &&
      echo "$tree" &&
      echo nitfol >file0 &&
      echo yomin >path1/file1 &&
@@ -131,7 +131,7 @@ test_expect_success 'diff multiple wildcard pathspe=
cs' '
 	mkdir path2 &&
 	echo rezrov >path2/file1 &&
 	git update-index --add path2/file1 &&
-	tree3=3D`git write-tree` &&
+	tree3=3D$(git write-tree) &&
 	git diff --name-only $tree $tree3 -- "path2*1" "path1*1" >actual &&
 	cat <<-\EOF >expect &&
 	path1/file1
--=20
1.7.10.4
