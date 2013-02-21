From: =?UTF-8?B?VGFkZXVzeiBBbmRyemVqIEthZMWCdWJvd3NraQ==?= 
	<yess@hell.org.pl>
Subject: [PATCH 2/2] Documentation: filter-branch env-filter example
Date: Thu, 21 Feb 2013 21:23:38 +0100
Message-ID: <5126824A.2060903@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 21:24:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8cgW-0004iM-Ob
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 21:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab3BUUXk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 15:23:40 -0500
Received: from hell.org.pl ([213.135.50.122]:57411 "EHLO hell.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753104Ab3BUUXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 15:23:39 -0500
Received: from [10.2.0.23] (unknown [193.107.214.17])
	by hell.org.pl (Postfix) with ESMTP id DBE93F0082
	for <git@vger.kernel.org>; Thu, 21 Feb 2013 21:23:38 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216793>

filter-branch --env-filter example that shows how to change the email
address in all commits before publishing a project.

Signed-off-by: Tadeusz Andrzej Kad=C5=82ubowski <yess@hell.org.pl>
---
 Documentation/git-filter-branch.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-branch.txt
index e50ee2f..660bd32 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -329,6 +329,27 @@ git filter-branch --msg-filter '
 ' HEAD~10..HEAD
 --------------------------------------------------------
 +The `--env-filter` option can be used to modify committer and/or auth=
or
+identity.  For example, if you found out that your commits have the wr=
ong
+identity due to a misconfigured user.email, you can make a correction,
+before publishing the project, like this:
+
+
+--------------------------------------------------------
+git filter-branch --env-filter '
+	if test "$GIT_AUTHOR_EMAIL" =3D "root@localhost"
+	then
+		GIT_AUTHOR_EMAIL=3Djohn@example.com
+		export GIT_AUTHOR_EMAIL
+	fi
+	if test "$GIT_COMMITTER_EMAIL" =3D "root@localhost"
+	then
+		GIT_COMMITTER_EMAIL=3Djohn@example.com
+		export GIT_COMMITTER_EMAIL
+	fi
+' -- --all
+--------------------------------------------------------
+
 To restrict rewriting to only part of the history, specify a revision
 range in addition to the new branch name.  The new branch name will
 point to the top-most revision that a 'git rev-list' of this range
--=20
1.7.11.7
