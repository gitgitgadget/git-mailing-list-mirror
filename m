From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: [patch] documentation: Explain how to free up space after filter-branch
Date: Fri, 12 Dec 2008 18:42:09 +0100
Organization: Intra2net AG
Message-ID: <200812121842.10438.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 12 18:43:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBC33-0001Kw-ID
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 18:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757104AbYLLRmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Dec 2008 12:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756831AbYLLRmP
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 12:42:15 -0500
Received: from re01.intra2net.com ([82.165.28.202]:59940 "EHLO
	re01.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760AbYLLRmP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2008 12:42:15 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by re01.intra2net.com (Postfix) with ESMTP id 7CC6B24E6;
	Fri, 12 Dec 2008 18:42:13 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 218E32AC4B;
	Fri, 12 Dec 2008 18:42:13 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 76B282AC4A;
	Fri, 12 Dec 2008 18:42:11 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-41.fc9.i686; KDE/4.1.3; i686; ; )
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-12_08)
X-Spam-Status: hits=-2.5 tests=[ALL_TRUSTED=-1.8,BAYES_20=-0.74]
X-Spam-Level: 975
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102919>

Explain how to free up space after filter-branch.
Thanks to Bj=F6rn Steinbrink for pointing me in the right direction.

Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-branch.txt
index fed6de6..1432380 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -319,6 +319,18 @@ git filter-branch --index-filter \
 	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
 ---------------------------------------------------------------
=20
+Free up the space in .git if the rewritten version is correct
+by deleting refs/original and pruning the reflog:
+
+----------------------------------------------------
+git for-each-ref --format=3D'%(refname)' refs/original
+	| xargs -i git update-ref -d {}
+
+git reflog expire --expire=3D0 --all
+git repack -a -d --depth=3D250 --window=3D250
+git prune
+----------------------------------------------------
+
=20
 Author
 ------
