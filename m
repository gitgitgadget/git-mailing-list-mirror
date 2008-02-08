From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] builtin-commit: remove .git/SQUASH_MSG upon successful
	commit
Date: Fri, 8 Feb 2008 09:53:58 +0000
Message-ID: <20080208095358.25666.qmail@b4daf7aef4dba9.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 10:54:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNPw8-0001Le-QW
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 10:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbYBHJxn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2008 04:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbYBHJxm
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 04:53:42 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:33205 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932643AbYBHJxl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 04:53:41 -0500
Received: (qmail 25667 invoked by uid 1000); 8 Feb 2008 09:53:58 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73060>

After doing a merge --squash, and commit afterwards, the commit message
template SQUASH_MSG in the git directory is not removed, which means th=
at
the content of SQUASH_MSG is used as default commit message for all
subsequent commits.  So have git commit remove the file SQUASH_MSG from
the git directory upon a successful commit.

The problem was discovered by Fr=E9d=E9ric Bri=E8re, reported through
 http://bugs.debian.org/464656

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-commit.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index c787bed..3a47275 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -929,6 +929,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
=20
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
+	unlink(git_path("SQUASH_MSG"));
=20
 	if (commit_index_files())
 		die ("Repository has been updated, but unable to write\n"
--=20
1.5.4
