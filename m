From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 1/2] test-lib.sh: introduce 4th argument to test_commit() specifying a tag name
Date: Sat, 31 Jul 2010 04:18:46 +0400
Message-ID: <20100731001845.GA24129@wo.int.altlinux.org>
References: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 02:19:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oezn7-0006IY-LG
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 02:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765Ab0GaASt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 20:18:49 -0400
Received: from vint.altlinux.org ([194.107.17.35]:44384 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab0GaASs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 20:18:48 -0400
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 4C31E3F80005
	for <git@vger.kernel.org>; Sat, 31 Jul 2010 00:18:47 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 815293F48760; Sat, 31 Jul 2010 04:18:46 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152273>

When fourth argument to test_commit() is specified, use it as a tag
name, unless it equals to empty string.  In the latter case, skip tag
creation.

Suggested-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 t/test-lib.sh |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 367f053..a203383 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -277,10 +277,12 @@ test_tick () {
 	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }
=20
-# Call test_commit with the arguments "<message> [<file> [<contents>]]=
"
+# Call test_commit with the arguments
+# "<message> [<file> [<contents> [<tagname>]]]"
 #
 # This will commit a file with the given contents and the given commit
-# message.  It will also add a tag with <message> as name.
+# message.  It will also add a tag with the given name unless the latt=
er
+# is the empty string.
 #
 # Both <file> and <contents> default to <message>.
=20
@@ -290,7 +292,7 @@ test_commit () {
 	git add "$file" &&
 	test_tick &&
 	git commit -m "$1" &&
-	git tag "$1"
+	if test -n "${4-$1}"; then git tag "${4-$1}"; fi
 }
=20
 # Call test_merge with the arguments "<message> <commit>", where <comm=
it>


--=20
ldv
