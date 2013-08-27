From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 08/11] Improve section "Merging multiple trees"
Date: Tue, 27 Aug 2013 20:03:09 +0200 (CEST)
Message-ID: <1931551541.34581.1377626589383.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 20:03:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENbn-0000NC-LF
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 20:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab3H0SDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 14:03:12 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:47214 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752603Ab3H0SDL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 14:03:11 -0400
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id 7B484107AED;
	Tue, 27 Aug 2013 20:03:09 +0200 (CEST)
Received: from mail-in-18.arcor-online.net (mail-in-18.arcor-online.net [151.189.21.58])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 65C19212074;
	Tue, 27 Aug 2013 20:03:09 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-18.arcor-online.net (Postfix) with ESMTP id 62F573DC359;
	Tue, 27 Aug 2013 20:03:09 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-18.arcor-online.net 62F573DC359
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377626589; bh=XTmuYgOIwxpXq0qS+5Fsttewc78jXoOd1aJPj8GQn74=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=l2U1ZG8Fy7eig1dhMBpJYtLrd1wgoLfL7xPQZyYN7atbX7EATDvWSi53iB9bIbv1T
	 mOt+svDTP3ukHpdku9h4ZfGAQSERh/VXtGnG3y4B7w3tnYTP1xHoz6RmT8j+Ck98Ff
	 nq6o5CIv91S1CNXMI07DtVB68RWL4Hiqt1legq/I=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 20:03:09 +0200 (CEST)
In-Reply-To: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233128>


Remove unnecessary quoting.
Simplify description of three-way merge.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index c20e8df..a7ca3e3 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4004,27 +4004,26 @@ to see what the top commit was.
 Merging multiple trees
 ----------------------
 
-Git helps you do a three-way merge, which you can expand to n-way by
-repeating the merge procedure arbitrary times until you finally
-"commit" the state.  The normal situation is that you'd only do one
-three-way merge (two parents), and commit it, but if you like to, you
-can do multiple parents in one go.
+Git can help you perform a three-way merge, which can in turn be
+used for a many-way merge by repeating the merge procedure several
+times.  The usual situation is that you only do one three-way merge
+(reconciling two lines of history) and commit the result, but if
+you like to, you can merge several branches in one go.
 
-To do a three-way merge, you need the two sets of "commit" objects
-that you want to merge, use those to find the closest common parent (a
-third "commit" object), and then use those commit objects to find the
-state of the directory ("tree" object) at these points.
+To perform a three-way merge, you start with the two commits you
+want to merge, find their closest common parent (a third commit),
+and compare the trees corresponding to these three commits.
 
-To get the "base" for the merge, you first look up the common parent
-of two commits with
+To get the "base" for the merge, look up the common parent of two
+commits:
 
 -------------------------------------------------
 $ git merge-base <commit1> <commit2>
 -------------------------------------------------
 
-which will return you the commit they are both based on.  You should
-now look up the "tree" objects of those commits, which you can easily
-do with (for example)
+This prints the name of a commit they are both based on. You should
+now look up the tree objects of those commits, which you can easily
+do with
 
 -------------------------------------------------
 $ git cat-file commit <commitname> | head -1
-- 
1.8.3.msysgit.0


---
Thomas
