From: Fredrik Noring <noring@nocrew.org>
Subject: [PATCH] Removing hard-coded "via git-CVS emulator" message for commits
Date: Sun, 13 Apr 2008 09:15:40 +0200
Message-ID: <17235429-EC83-4D73-97A5-BA835F3CD71D@nocrew.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-29--17010207
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 09:16:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkwS0-0001O3-3U
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 09:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbYDMHPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 03:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbYDMHPp
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 03:15:45 -0400
Received: from smtpserver.stunet.se ([85.194.0.110]:60165 "EHLO mail.visit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbYDMHPo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 03:15:44 -0400
Received: by mail.visit.se (Postfix, from userid 503)
	id 7673C36E029C; Sun, 13 Apr 2008 09:15:49 +0200 (CEST)
Received: from [10.0.1.2] (cust.dsl-fiber-lan.snet.lk.85.194.37.51.visit.se [85.194.37.51])
	by mail.visit.se (Postfix) with ESMTP id D70CD36E028F;
	Sun, 13 Apr 2008 09:15:48 +0200 (CEST)
X-Mailer: Apple Mail (2.919.2)
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on mail.visit.se
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79394>


--Apple-Mail-29--17010207
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi all,

Attached patch removes the hard-coded "via git-CVS emulator" string  
appended to every commit message by the git-cvsserver command. I  
believe there are "commit-msg" hooks etc. that can achieve the same  
effect in cases where this string is desirable?

  git-cvsserver.perl |    1 -
  1 file changed, 1 deletion(-)

Without the patch, a typical commit message using git-cvsserver looks  
like this:

commit 4bea43114a8f7fafd72c67cd98c5d9e98d1a7cbb
Author: Fredrik Noring
Date:   Sun Apr 13 09:10:05 2008 +0200

     Commit message...

     via git-CVS emulator

All the best,
Fredrik


--Apple-Mail-29--17010207
Content-Disposition: attachment;
	filename=cvsserver-remove-emulator-msg.patch
Content-Type: application/octet-stream;
	x-unix-mode=0664;
	name="cvsserver-remove-emulator-msg.patch"
Content-Transfer-Encoding: 7bit

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 29dbfc9..59a1609 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1325,7 +1325,6 @@ sub req_ci
     # write our commit message out if we have one ...
     my ( $msg_fh, $msg_filename ) = tempfile( DIR => $TEMP_DIR );
     print $msg_fh $state->{opt}{m};# if ( exists ( $state->{opt}{m} ) );
-    print $msg_fh "\n\nvia git-CVS emulator\n";
     close $msg_fh;
 
     my $commithash = `git-commit-tree $treehash -p $parenthash < $msg_filename`;

--Apple-Mail-29--17010207
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit



--Apple-Mail-29--17010207--
