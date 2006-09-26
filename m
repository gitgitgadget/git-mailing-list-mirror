From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: "raw" links to blobs at HEAD
Date: Mon, 25 Sep 2006 22:39:20 -0700 (PDT)
Message-ID: <20060926053920.47709.qmail@web31802.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1065030637-1159249160=:47068"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Sep 26 07:49:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS5ol-0005uc-1O
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 07:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWIZFsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 01:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWIZFj2
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 01:39:28 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:39008 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751294AbWIZFjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:21 -0400
Received: (qmail 47711 invoked by uid 60001); 26 Sep 2006 05:39:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=x6WaNQWdbEGrgS69caNL8Ah1G07omgJB0ujouSShvBkckoH02ekg1pSttv0EysL9ue16KWKFrOVOk7oQOk+3bDsCVjetNxrUr57zmTTH72VV/BIbOAia+GUA2djAjKgHRIOvuxXsa5XeN48qnEFSgATPAEBZCGq+nZRDgXnxx3c=  ;
Received: from [71.80.233.118] by web31802.mail.mud.yahoo.com via HTTP; Mon, 25 Sep 2006 22:39:20 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27778>

--0-1065030637-1159249160=:47068
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Currently there is no HTML interface which references (or
can be externally referenced) to yield a _binary_ blob at
HEAD.  There is one for non-binary blobs, but none for
binary ones.

The reason is that "blob"/entry itself for non-binary
entries gives you the "Blob page" where you can click on
last link of the page path, but clicking on the binary
entry/"blob" gives you the raw file.

Binary blobs:
  Since "raw" == the entry itself, we can eliminate this
redundancy and set "raw" to the binary blob at HEAD. This
patch implements that.  If the user wants the binary blob at
hash/hash_base then they can click on the entry itself.

Non-binary blobs:
  With this patch "raw" yields the HEAD revision as per the
above comment for binary blobs.  If the raw output of the
hash/hash_base blob is required the user can click on the entry
(same as for binary only) and then click on "raw" (which
used to be named "plain" not so long ago) or last entry of
"page" path.

Compare the "raw" link for non-binary blobs from tree view,
to the alternative to getting it: click on entry->HEAD->last
entry of "page" path.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
--0-1065030637-1159249160=:47068
Content-Type: text/inline; name="p2.txt"
Content-Description: 1908141687-p2.txt
Content-Disposition: name="p2.txt"; filename="p2.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c7ab3b6..959e3f9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1625,9 +1625,9 @@ sub git_print_tree_entry {
 			              "history");
 		}
 		print " | " .
-		      $cgi->a({-href => href(action=>"blob_plain",
-		                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
-		              "raw");
+			$cgi->a({-href => href(action=>"blob_plain", hash_base=>"HEAD",
+					       file_name=>"$basedir$t->{'name'}")},
+				"raw");
 		print "</td>\n";
 
 	} elsif ($t->{'type'} eq "tree") {
-- 
1.4.2.1.gdbbb

--0-1065030637-1159249160=:47068--
