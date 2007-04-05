From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Document --left-right option to rev-list.
Date: Thu, 5 Apr 2007 10:53:07 -0400
Message-ID: <20070405145307.GA18458@174.242.249.10.in-addr.arpa>
References: <7vwt0rqftv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davidk@lysator.liu.se
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 05 16:53:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZTL5-0006X1-Ra
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 16:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767027AbXDEOxS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 5 Apr 2007 10:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767029AbXDEOxR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 10:53:17 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44942 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767027AbXDEOxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 10:53:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 8131E1FFC143;
	Thu,  5 Apr 2007 14:53:10 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
In-Reply-To: <7vwt0rqftv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43830>

Explanation is paraphrased from "577ed5c... rev-list --left-right"
---

Junio C Hamano <junkio@cox.net> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> "git log -Sleft-right" will actually give me the documentation I wan=
t,
>> since the docs are written but only put in the commit message.
>
> Fair enough.  Perhaps the list can help out ;-).

Like this?  :-)

 Documentation/git-rev-list.txt |   19 +++++++++++++++++++
 builtin-rev-list.c             |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-lis=
t.txt
index 3fa45b8..5b33865 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -21,6 +21,7 @@ SYNOPSIS
 	     [ \--stdin ]
 	     [ \--topo-order ]
 	     [ \--parents ]
+	     [ \--left-right ]
 	     [ \--encoding[=3D<encoding>] ]
 	     [ \--(author|committer|grep)=3D<pattern> ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
@@ -101,6 +102,24 @@ include::pretty-formats.txt[]
=20
 	Print the parents of the commit.
=20
+--left-right::
+
+	Mark which side of a symmetric diff a commit is reachable from.
+	Commits from the left side are prefixed with `<` and those from
+	the right with `>`.  If combined with `--boundary`, those
+	commits are prefixed with `-`.  For example:
+
+----------------------------------------------------------------------=
-
+	$ git rev-list --left-right --boundary --pretty=3Doneline A...B
+
+	>bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb 3rd on b
+	>bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb 2nd on b
+	<aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 3rd on a
+	<aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 2nd on a
+	-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 1st on b
+	-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 1st on a
+----------------------------------------------------------------------=
-
+
 Diff Formatting
 ~~~~~~~~~~~~~~~
=20
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index f91685a..09774f9 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -35,6 +35,7 @@ static const char rev_list_usage[] =3D
 "    --header | --pretty\n"
 "    --abbrev=3Dnr | --no-abbrev\n"
 "    --abbrev-commit\n"
+"    --left-right\n"
 "  special purpose:\n"
 "    --bisect\n"
 "    --bisect-vars"
--=20
1.5.1.32.gdd6cd
