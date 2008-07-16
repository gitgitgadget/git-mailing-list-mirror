From: Torsten Paul <Torsten.Paul@gmx.de>
Subject: gitk: Author/Committer name with special characters
Date: Thu, 17 Jul 2008 00:24:37 +0200
Message-ID: <487E7525.7000708@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:25:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJFRV-0007JU-JC
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 00:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbYGPWYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 18:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbYGPWYv
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 18:24:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:41488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753662AbYGPWYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 18:24:50 -0400
Received: (qmail invoked by alias); 16 Jul 2008 22:24:48 -0000
Received: from unknown (EHLO [10.161.241.10]) [92.117.241.10]
  by mail.gmx.net (mp057) with SMTP; 17 Jul 2008 00:24:48 +0200
X-Authenticated: #1774914
X-Provags-ID: V01U2FsdGVkX1/sZsoKz0Ls/ltLXSaqXA5uN/ClxtbAP8PvZmChk+
	wpFV92JRF6UCSX
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88771>

Hi!

I'm tracking a subversion repository which is running on
a windows machine with git-svn. The user names look like
DOMAIN\username and that's giving a strange display in
gitk as the backslash sequence is evaluated.

I'm not sure if I found the correct place to prevent this,
so I'd like to ask if the following change would be the
correct thing to prepare as patch...

ciao,
   Torsten.


diff --git a/gitk-git/gitk b/gitk-git/gitk
index fddcb45..f114fa2 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1510,10 +1510,10 @@ proc parsecommit {id contents listed} {
         set tag [lindex $line 0]
         if {$tag == "author"} {
             set audate [lindex $line end-1]
-           set auname [lrange $line 1 end-2]
+           set auname [join [lrange [split $line] 1 end-2]]
         } elseif {$tag == "committer"} {
             set comdate [lindex $line end-1]
-           set comname [lrange $line 1 end-2]
+           set comname [join [lrange [split $line] 1 end-2]]
         }
      }
      set headline {}
