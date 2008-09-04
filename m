From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fix AsciiDoc errors in merge documentation
Date: Thu, 04 Sep 2008 23:48:48 +0200
Message-ID: <200809042348.48570.johan@herland.net>
References: <48BFBBEF.6010403@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Gustaf Hendeby <hendeby@isy.liu.se>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 23:51:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbMj9-0003zy-1S
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 23:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941AbYIDVts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 17:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754738AbYIDVtr
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 17:49:47 -0400
Received: from smtp.getmail.no ([84.208.20.33]:58084 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757399AbYIDVtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 17:49:46 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K6O0022ZXYVIN00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 04 Sep 2008 23:49:43 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6O00L5SXXCNP10@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 04 Sep 2008 23:48:48 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6O0098ZXXCKJH0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 04 Sep 2008 23:48:48 +0200 (CEST)
In-reply-to: <48BFBBEF.6010403@isy.liu.se>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94963>

In the section on conflict markers, the "<<<<<<<" sequence is compiled by
AsciiDoc into invalid XML. A way to resolve this is by inserting something
between the last two characters in that sequence (i.e. between '<' and '"').

This patch encloses the conflict markers in backticks, which renders them
in a monospace font (in the HTML version; the manual page is unaffected),
and with the pleasant side-effect that it also fixes the AsciiDoc compile
problem.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Thursday 04 September 2008, Gustaf Hendeby wrote:
> Trying to compile the documentation from next has failed for me for a
> while and now I got to the point where I tracked down the offending
> commit: 70a3f89733a (git-merge documentation: describe how conflict is
> presented).

This fixes the problem for me.


Have fun! :)

...Johan


 Documentation/git-merge.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 69dd872..1f30830 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -146,8 +146,8 @@ And here is another line that is cleanly resolved or unmodified.
 ------------
 
 The area a pair of conflicting changes happened is marked with markers
-"<<<<<<", "=======", and ">>>>>>>".  The part before the "=======" is
-typically your side, and the part after it is typically their side.
+"`<<<<<<<`", "`=======`", and "`>>>>>>>`".  The part before the "`=======`"
+is typically your side, and the part after it is typically their side.
 
 The default format does not show what the original said in the conflicted
 area.  You cannot tell how many lines are deleted and replaced with the
@@ -173,8 +173,8 @@ Git makes conflict resolution easy.
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
-In addition to the "<<<<<<", "=======", and ">>>>>>>" markers, it uses
-another "|||||||" marker that is followed by the original text.  You can
+In addition to the "`<<<<<<<`", "`=======`", and "`>>>>>>>`" markers, it uses
+another "`|||||||`" marker that is followed by the original text.  You can
 tell that the original just stated a fact, and your side simply gave in to
 that statement and gave up, while the other side tried to have a more
 positive attitude.  You can sometimes come up with a better resolution by
-- 
1.6.0.96.g2fad1
