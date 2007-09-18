From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] git-svnimport: Use separate arguments in the pipe for git-rev-parse
Date: Tue, 18 Sep 2007 09:47:53 +0200
Message-ID: <20070918074753.GQ31176@kiste.smurf.noris.de>
References: <200709161857.06065.danda@osc.co.cr> <20070917070303.GI31176@kiste.smurf.noris.de> <200709171333.48331.danda@osc.co.cr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan Libby <danda@osc.co.cr>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:16:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYG3-0006Yz-5H
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbXIRIQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbXIRIQW
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:16:22 -0400
Received: from smurf.noris.de ([192.109.102.42]:52133 "EHLO smurf.noris.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbXIRIQV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:16:21 -0400
X-Greylist: delayed 1680 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Sep 2007 04:16:20 EDT
Received: from kiste.smurf.noris.de ([192.109.102.35])
	by smurf.noris.de with smtp (Exim 4.63)
	(envelope-from <smurf@smurf.noris.de>)
	id 1IXXoK-0001oy-Po; Tue, 18 Sep 2007 09:47:57 +0200
Received: (nullmailer pid 22791 invoked by uid 501);
	Tue, 18 Sep 2007 07:47:53 -0000
Content-Disposition: inline
In-Reply-To: <200709171333.48331.danda@osc.co.cr>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58543>


Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>
---
Please tell me whether that works for you.

Somebody else, preferably its author, can fix git-svn. ;-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index d3ad5b9..aa5b3b2 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -633,7 +633,7 @@ sub commit {
 
 	my $rev;
 	if($revision > $opt_s and defined $parent) {
-		open(H,"git-rev-parse --verify $parent |");
+		open(H,'-|',"git-rev-parse","--verify",$parent);
 		$rev = <H>;
 		close(H) or do {
 			print STDERR "$revision: cannot find commit '$parent'!\n";
-- 
1.5.2.5

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"Could a being create the fifty billion galaxies, each with two hundred
 billion stars, then rejoice in the smell of burning goat flesh?"
                         [Ron Patterson]
