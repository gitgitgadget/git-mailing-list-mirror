From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 1/2] Documentation: 'git add -A' can remove files
Date: Mon, 07 Dec 2009 00:03:38 +0100
Message-ID: <4B1C384A.8000106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 00:03:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHQ8o-0004Mx-MY
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 00:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934362AbZLFXDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 18:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757766AbZLFXDf
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 18:03:35 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:29722 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757760AbZLFXDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 18:03:34 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1016762eyd.19
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 15:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=fjvCZsscWuQwGsWBoebUxwLg0wcG6NhOZ0B2AZZMvGg=;
        b=PfCI2pejlicaXG+JwBoUlOcDCwLzDHyXGUOqvK/DcRa4SDn6UZ6pvNiiNPLzGLz0U9
         Kzm3SboSEOYD4lyb8eIN4MxyF4w1aROoujMQFa6WerCzhelgsbklWGUKgwt06obx5qEO
         BLXzkJJwpCjCNUXDCxNrdneZDo3H9+/Aih72o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=ZCnYevP7562ZptwwB7pzoN4kpFHLxibu4hE7AoPJilBcbtpLCWLXx7FxjVSVVjJ9BC
         jk4OawI1C80EshP0dxmKyUd9vFiKbepaxksk9ISUQubDxi0b7urs35rHdnLNyw8aU+sk
         jFa5WE1LCcYUMUNfBICQNyaMeewrnGMWmhSqk=
Received: by 10.213.8.28 with SMTP id f28mr13655568ebf.39.1260140619672;
        Sun, 06 Dec 2009 15:03:39 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 13sm3122372ewy.9.2009.12.06.15.03.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 15:03:39 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134691>

Document that 'git add -A/--all' can remove files no longer
present in the working tree from the index, and also document the
behavior with and without path arguments on the command line.

Also update the intro paragraph (as suggested by Junio, with
some minor edits) to make it clear that 'git add' is able to
delete and to also cover the -p option.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
Thanks, Junio, for reviewing my patch, and for suggesting a
much better intro paragraph.

I have cut out the mention of rsync and the reference from
git-rm.

I also realized that the documentation was not clear on whether
any path arguments were allowed, so I have clarified that too.

 Documentation/git-add.txt |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e93e606..6d3e76f 100644
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
+remove paths that do not exist in the work tree anymore.
=20
 The "index" holds a snapshot of the content of the working tree, and i=
t
 is this snapshot that is taken as the contents of the next commit.  Th=
us
@@ -102,10 +106,14 @@ apply.
=20
 -A::
 --all::
-	Update files that git already knows about (same as '\--update')
-	and add all untracked files that are not ignored by '.gitignore'
-	mechanism.
-
+	Update files that git already knows about (same as '\--update'),
+	add all untracked files that are not ignored by the '.gitignore'
+	mechanism and remove files from the index that are no longer
+	present in the working tree.
++
+If no paths are given on the command line, `git add -A` will operate
+on the current directory and its subdirectories. If paths are given,
+it will operate on those paths and their subdirectories.
=20
 -N::
 --intent-to-add::
--=20
1.6.6.rc1.31.g1a56b
