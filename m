From: Tommi Virtanen <tv@inoi.fi>
Subject: git-svn vs. $Id$
Date: Tue, 16 May 2006 20:33:03 +0300
Organization: Inoi Oy
Message-ID: <446A0CCF.2060903@inoi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue May 16 19:33:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg3Q3-0008Ik-Ou
	for gcvg-git@gmane.org; Tue, 16 May 2006 19:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWEPRdL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 May 2006 13:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWEPRdL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 13:33:11 -0400
Received: from i1.inoi.fi ([194.100.97.46]:20902 "EHLO mail.inoi.fi")
	by vger.kernel.org with ESMTP id S932173AbWEPRdJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 13:33:09 -0400
Received: from mail.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.inoi.fi (Postfix) with ESMTP id 632B4AC040
	for <git@vger.kernel.org>; Tue, 16 May 2006 20:33:39 +0300 (EEST)
Received: from [10.116.0.186] (GMMDXXVII.dsl.saunalahti.fi [85.76.242.28])
	by mail.inoi.fi (Postfix) with ESMTP id 347E7AC02B
	for <git@vger.kernel.org>; Tue, 16 May 2006 20:33:39 +0300 (EEST)
User-Agent: Mail/News 1.5 (X11/20060309)
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20128>

Hi. I just ran into trouble with git-svn, related to a file
containing $Id$. Yes, I know $Id$ sucks and should be avoided,
and I'll be removing them shortly, but that doesn't change the
fact that the history contains files with them.

Just wanted to let you know of a workaround:
manually edit the relevant file in .git/git-svn/tree/ to
undo the $Id$ change, and git-svn fetch works again.

$ git-svn fetch
Tree mismatch, Got: c242bb60d78c1dfce133e0bbaca7f13895de00b2, Expected:
07d35ac911cc56aabea86f4467cafc1d92b724c4
 at /home/tv/bin/git-svn line 426
        main::assert_tree('a5890d459de08dc8adbbe34cdfb4b1f44f377ad8')
called at /home/tv/bin/git-svn line 392
        main::assert_svn_wc_clean(2039,
'a5890d459de08dc8adbbe34cdfb4b1f44f377ad8') called at
/home/tv/bin/git-svn line 262
        main::fetch() called at /home/tv/bin/git-svn line 105

$ git diff-tree -p 07d35ac911cc56aabea86f4467cafc1d92b724c4 \
  c242bb60d78c1dfce133e0bbaca7f13895de00b2
diff --git a/anonymized b/anonymized
index 16b3988..f43782a 100644
--- a/anonymized
+++ b/anonymized
@@ -1,4 +1,4 @@
-## $Id: anonymized 1775 2006-04-20 09:25:22Z tv $
+## $Id: anonymized 2025 2006-05-16 07:25:24Z tv $

 blah
 blah


So editing .git/git-svn/tree/anonymized and replacing
"1775 2006-04-20 09:25:22Z tv" with "2025 2006-05-16 07:25:24Z tv"
make git-svn happy again.

--=20
Inoi Oy, Tykist=F6katu 4 D (4. krs), FI-20520 Turku, Finland
http://www.inoi.fi/
Mobile +358 40 762 5656
