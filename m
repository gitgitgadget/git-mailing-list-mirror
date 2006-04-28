From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] annotate: fix warning about uninitialized scalar
Date: Fri, 28 Apr 2006 10:42:28 +0200
Message-ID: <20060428084228.GB4313@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 11:48:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZPaj-0001WI-FP
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 11:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWD1Jsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 05:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWD1Jsq
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 05:48:46 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:35960 "EHLO XSMTP0.ethz.ch")
	by vger.kernel.org with ESMTP id S1030347AbWD1Jsp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Apr 2006 05:48:45 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Fri, 28 Apr 2006 11:48:43 +0200
Received: from spinlock.ch ([129.132.210.92]) by xfe1.d.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Fri, 28 Apr 2006 11:48:43 +0200
Received: (nullmailer pid 6917 invoked by uid 1000);
	Fri, 28 Apr 2006 08:42:28 -0000
To: junkio@cox.net
Mail-Followup-To: junkio@cox.net, git@vger.kernel.org
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.16-rc6 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 28 Apr 2006 09:48:43.0198 (UTC) FILETIME=[EF8245E0:01C66AA8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19273>

Use of uninitialized value in scalar chomp at
./git-annotate.perl line 212, <$kid> chunk 4.

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>

---

 git-annotate.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

5322aefa820eef2d635d5dbf621269aefce52135
diff --git a/git-annotate.perl b/git-annotate.perl
index bf920a5..5f8a766 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -209,6 +209,9 @@ sub find_parent_renames {
 	while (my $change = <$patch>) {
 		chomp $change;
 		my $filename = <$patch>;
+		if(!$filename) {
+			next;
+		}
 		chomp $filename;
 
 		if ($change =~ m/^[AMD]$/ ) {
-- 
1.3.1.gc4586
