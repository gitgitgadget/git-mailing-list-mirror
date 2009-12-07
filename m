From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] Documentation: 'git add -A' can remove files
Date: Mon, 07 Dec 2009 09:20:09 +0100
Message-ID: <4B1CBAB9.7030306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 09:20:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHYpQ-0000uM-K2
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 09:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933167AbZLGIUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 03:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758962AbZLGIUI
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 03:20:08 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:46494 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576AbZLGIUH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 03:20:07 -0500
Received: by ewy19 with SMTP id 19so129433ewy.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 00:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=gW15W34eTisRXE1DqvJ8a0FmS8gYbxN07Pm3S15A5bY=;
        b=FCrKKowV27ocNBKFoIRMUAkOqucYuGiz37C4lveZG9Nt58HxawCYMMvxxpNjQF2B76
         7OHKLih2KiFkr25eLR5ttCauUZum9tYZTIfSJ59i/KNG6JPD+DoLsRI1xkWpM7OiADfh
         h6PFnnB6W+qRm3+Mlj9IOEKkrrplEVQFkiBTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=pNRq7PlON+3UjXyBtUPaR6qXbqTTi1JQUFlOHjRqw0CiQg5rRkqXQMWAquhnzePQBw
         6rnSGFAi3wEzvMrKgjyXSJY3pgA+B234r9Jn8AquHqyUTtX81LANcTkWSftf53U0NTb0
         nh2dejfoLH+qOg/h1hs/vGIQc7FkFMbgGg0wU=
Received: by 10.213.90.136 with SMTP id i8mr1822725ebm.83.1260174011556;
        Mon, 07 Dec 2009 00:20:11 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm8847009eyz.7.2009.12.07.00.20.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 00:20:11 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134722>

The current documentation fails to mention that 'git add -A/--all'
can remove files as well as add them, and it also does not
say anything about filepatterns (whether they are allowed,
mandatory, or optional). It is also not clear what the similarities
and differences to the -u option are.

Update the intro paragraph (as suggested by Junio, with some minor
edits) to make it clear that 'git add' is able to delete and to
also cover the -p option.

Reword the description of -u to make it clearer (based on by
Bj=C3=B6rn Steinbrink's suggestion).

Simplify the description of  -A by saying "Like -u" and then
describe the differences (based on the suggestions by Bj=C3=B6rn
Steinbrink and Junio).

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
I have to leave for work now, so I'll just send the first part
now, which I think is much improved compared to
the previous version. Thanks Junio and Bj=C3=B6rn S for the
suggestions.

 Documentation/git-add.txt |   33 ++++++++++++++++++++-------------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e93e606..ed68ea3 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -14,8 +14,12 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-This command adds the current content of new or modified files to the
-index, thus staging that content for inclusion in the next commit.
+This command updates the index using the current content found in
+the working tree, to prepare the content staged for the next commit.
+It typically adds the current content of existing paths as a whole,
+but with some options it can also be used to add content with
+only part of the changes made to the working tree files applied, or
+remove paths that do not exist in the working tree anymore.
=20
 The "index" holds a snapshot of the content of the working tree, and i=
t
 is this snapshot that is taken as the contents of the next commit.  Th=
us
@@ -92,20 +96,23 @@ apply.
=20
 -u::
 --update::
-	Update only files that git already knows about, staging modified
-	content for commit and marking deleted files for removal. This
-	is similar
-	to what "git commit -a" does in preparation for making a commit,
-	except that the update is limited to paths specified on the
-	command line. If no paths are specified, all tracked files in the
-	current directory and its subdirectories are updated.
+	Only match <filepattern> against already tracked files in
+	the index rather than the working tree. That means that it
+	will never stage new files, but that it will stage modified
+	new contents of tracked files and that it will remove files
+	from the index if the corresponding files in the working tree
+	have been removed.
++
+If no <filepattern> is given, default to "."; in other words,
+update all tracked files in the current directory and its
+subdirectories.
=20
 -A::
 --all::
-	Update files that git already knows about (same as '\--update')
-	and add all untracked files that are not ignored by '.gitignore'
-	mechanism.
-
+	Like `-u`, but match <filepattern> against files in the
+	working tree in addition to the index. That means that it
+	will find new files as well as staging modified content and
+	removing files that are no longer in the working tree.
=20
 -N::
 --intent-to-add::
--=20
1.6.6.rc1.31.g1a56b
