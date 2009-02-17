From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] test suite: correct export var=val usage
Date: Tue, 17 Feb 2009 17:57:37 -0500
Message-ID: <1234911457-37188-1-git-send-email-jaysoffian@gmail.com>
References: <7vr61w3dug.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 23:59:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYuI-0003QL-2w
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 23:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbZBQW5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 17:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbZBQW5m
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 17:57:42 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:58512 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbZBQW5l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 17:57:41 -0500
Received: by gxk22 with SMTP id 22so4748803gxk.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 14:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=RAApqsriIWWbbCKnzlRjPGwHcK5uc0bm1HxJ3Ye9xBs=;
        b=f3IEFnjCK08N3XenzFsn5D1eqjZyb0pa/XVvNbPPB3SJ1rd2Vny0au2cKJ/s5Jh4wH
         UomiT+rF2l8BlxmUjB5ODjxpjhW+jY+7WkZ1bXNKQsjdtOwfv59GF7JgRZQsIZIfMUur
         fhL4tp0E+mSyRV1+s8dx0CsImfYCZ4IGYFgrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kwK1RD55ArwzW4olio4J/Oif4b0rMWSR05D9UeL4ZK23TstaDNLZ2NAfhrwkm1kKqB
         AqoeJw9GRFaNVLZ0bR7L6QIxx2Bm6uxjcoIE3Qsf74GoOZFgfXAJfopwpAoj1rNZbsNi
         9v3G5R7NIAJwZW0HQWQv7I5OCoishJD831J1c=
Received: by 10.64.193.2 with SMTP id q2mr3632746qbf.51.1234911459989;
        Tue, 17 Feb 2009 14:57:39 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id s12sm14591299qbs.9.2009.02.17.14.57.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 14:57:39 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.218.g1b4fab
In-Reply-To: <7vr61w3dug.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110467>

Some shells do not like "export var=val", and the right way to write
these is to do an usual assignment and then export just variable names.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Argh. Last time. How come I only notice typos after they go to the list?
The prior version had a '&&' on the wrong line. I think it wouldn't be
a problem because it's in a (...) subshell but this way is better.

 t/t3301-notes.sh                 |    4 ++--
 t/t3302-notes-index-expensive.sh |    4 ++--
 t/t9301-fast-export.sh           |    4 ++--
 t/test-lib.sh                    |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 2321316..18c4eb6 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -39,13 +39,13 @@ test_expect_success 'need valid notes ref' '
 
 test_expect_success 'refusing to edit in refs/heads/' '
 	(MSG=1 GIT_NOTES_REF=refs/heads/bogus &&
-	 export MSG= GIT_NOTES_REF=refs/heads/bogus &&
+	export MSG GIT_NOTES_REF &&
 	 test_must_fail git notes edit)
 '
 
 test_expect_success 'refusing to edit in refs/remotes/' '
 	(MSG=1 GIT_NOTES_REF=refs/remotes/bogus &&
-	 export MSG= GIT_NOTES_REF=refs/heads/bogus &&
+	 export MSG GIT_NOTES_REF &&
 	 test_must_fail git notes edit)
 '
 
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index 00d27bf..0ef3e95 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -29,7 +29,7 @@ create_repo () {
 	done &&
 	git update-ref refs/heads/master $commit &&
 	{
-		export GIT_INDEX_FILE=.git/temp;
+		GIT_INDEX_FILE=.git/temp; export GIT_INDEX_FILE;
 		git rev-list HEAD | cat -n | sed "s/^[ 	][ 	]*/ /g" |
 		while read nr sha1; do
 			blob=$(echo note $nr | git hash-object -w --stdin) &&
@@ -63,7 +63,7 @@ cat > time_notes << \EOF
 	while [ $i -lt $2 ]; do
 		case $1 in
 		no-notes)
-			export GIT_NOTES_REF=non-existing
+			GIT_NOTES_REF=non-existing; export GIT_NOTES_REF
 		;;
 		notes)
 			unset GIT_NOTES_REF
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 9985721..86c3760 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -185,8 +185,8 @@ test_expect_success 'submodule fast-export | fast-import' '
 
 '
 
-export GIT_AUTHOR_NAME='A U Thor'
-export GIT_COMMITTER_NAME='C O Mitter'
+GIT_AUTHOR_NAME='A U Thor'; export GIT_AUTHOR_NAME
+GIT_COMMITTER_NAME='C O Mitter'; export GIT_COMMITTER_NAME
 
 test_expect_success 'setup copies' '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2021446..7a847ec 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -98,7 +98,7 @@ do
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
 		immediate=t; shift ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
-		export GIT_TEST_LONG=t; shift ;;
+		GIT_TEST_LONG=t; export GIT_TEST_LONG; shift ;;
 	-h|--h|--he|--hel|--help)
 		help=t; shift ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
-- 
1.6.2.rc1.218.g1b4fab
