From: Marco Costalba <mcostalba@yahoo.it>
Subject: Subject: [PATCH] Fix git-commit-script to output on stderr when -v fails
Date: Sat, 20 Aug 2005 09:07:15 -0700 (PDT)
Message-ID: <20050820160715.37321.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 18:08:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6VsY-0003wQ-F7
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 18:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVHTQHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 12:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVHTQHZ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 12:07:25 -0400
Received: from web26309.mail.ukl.yahoo.com ([217.146.176.20]:44897 "HELO
	web26309.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932358AbVHTQHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 12:07:25 -0400
Received: (qmail 37323 invoked by uid 60001); 20 Aug 2005 16:07:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Z/Sh1j2G/PXo2S+rPDAZ5qcZDVEP2BKJviAzqBj5vcb371Alm0Clb2oiSFXp8iT1uP9pbZxsidAnUscHO2W/loCgWHxPY5jSk8TBGt2BWRX4Hq8XjQ4+7inmQPhgB9jHbxAuWwfzlA9D8ksJGgUjQ+rU2RE5kcZ3FjmbqWca6e4=  ;
Received: from [151.42.200.166] by web26309.mail.ukl.yahoo.com via HTTP; Sat, 20 Aug 2005 09:07:15 PDT
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Marco Costalba <mcostalba@yahoo.it>
Date: 1124553736 +0200

When git-commit-script is called with -v option and
verify test fails result is print on stdout
instead of stderr.

Signed-off-by: Marco Costalba <mcostalba@yahoo.it>

---

 git-commit-script |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

676a1dcf50a5abc3bc9751c9dbb0146ae31ebfc9
diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -113,16 +113,16 @@ t)
 	    sub bad_line {
 		my ($why, $line) = @_;
 		if (!$found_bad) {
-		    print "*\n";
-		    print "* You have some suspicious patch lines:\n";
-		    print "*\n";
+		    print STDERR "*\n";
+		    print STDERR "* You have some suspicious patch lines:\n";
+		    print STDERR "*\n";
 		    $found_bad = 1;
 		}
 		if ($reported_filename ne $filename) {
-		    print "* In $filename\n";
+		    print STDERR "* In $filename\n";
 		    $reported_filename = $filename;
 		}
-		print "* $why (line $lineno)\n$line\n";
+		print STDERR "* $why (line $lineno)\n$line\n";
 	    }
 	    open $fh, "-|", qw(git-diff-cache -p -M --cached HEAD);
 	    while (<$fh>) {



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
