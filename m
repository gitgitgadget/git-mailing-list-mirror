From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH] gitk: Display the date of a tag in a human friendly way.
Date: Fri,  4 Jan 2013 15:47:11 +0000
Message-ID: <1357314431-32710-1-git-send-email-wildfire@progsoc.org>
Cc: Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 00:44:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrGvt-0002ZN-HT
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 00:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab3ADXnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 18:43:55 -0500
Received: from eth1822.nsw.adsl.internode.on.net ([150.101.200.29]:37869 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab3ADXny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 18:43:54 -0500
X-Greylist: delayed 28505 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jan 2013 18:43:53 EST
Received: from [84.93.170.255] (helo=localhost.localdomain)
	by giskard.kumria.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <wildfire@progsoc.org>)
	id 1Tr9Vk-0001Ma-0Y; Sat, 05 Jan 2013 02:48:44 +1100
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212654>

By selecting a tag within gitk you can display information about it.
This information is output by using the command

 'git cat-file tag <tagid>'

This outputs the *raw* information from the tag, amongst which is the
time - in seconds since the epoch. As useful as that value is, I find it
a lot easier to read and process time which it is something like:

 "Mon Dec 31 14:26:11 2012 -0800"

This change will modify the display of tags in gitk like so:

  @@ -1,7 +1,7 @@
   object 5d417842efeafb6e109db7574196901c4e95d273
   type commit
   tag v1.8.1
  -tagger Junio C Hamano <gitster@pobox.com> 1356992771 -0800
  +tagger Junio C Hamano <gitster@pobox.com> Mon Dec 31 14:26:11 2012 -0800

   Git 1.8.1
   -----BEGIN PGP SIGNATURE-----

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 gitk-git/gitk |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d93bd99..aae1c58 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -10675,7 +10675,7 @@ proc showtag {tag isnew} {
     set linknum 0
     if {![info exists cached_tagcontent($tag)]} {
 	catch {
-           set cached_tagcontent($tag) [exec git cat-file tag $tag]
+           set cached_tagcontent($tag) [exec git cat-file -p $tag]
 	}
     }
     if {[info exists cached_tagcontent($tag)]} {
-- 
1.7.9.5
