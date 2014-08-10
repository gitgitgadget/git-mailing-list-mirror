From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] checkpatch: Add test for commit id formatting style in
 commit log
Date: Sun, 10 Aug 2014 14:41:37 -0700
Message-ID: <1407706897.4082.24.camel@joe-AO725>
References: <20140702130210.fd40d67f0819cfb5f3e9e5ca@linux-foundation.org>
	 <1404331746.14624.95.camel@joe-AO725>
	 <20140702131534.c613f55f79519b3862f79e40@linux-foundation.org>
	 <1404338448.14741.8.camel@joe-AO725>
	 <CAMuHMdV1TXLmuAofwrUuT-KKUfkEYdXsM34VRrfhB6FxXfdeeg@mail.gmail.com>
	 <1407706081.4082.21.camel@joe-AO725>
	 <20140810143500.2d556ae9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Sun Aug 10 23:42:07 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1XGasQ-0002Uy-GM
	for glk-linux-kernel-3@plane.gmane.org; Sun, 10 Aug 2014 23:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbaHJVlo (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 10 Aug 2014 17:41:44 -0400
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:52474 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751407AbaHJVll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2014 17:41:41 -0400
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9A53B351019;
	Sun, 10 Aug 2014 21:41:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2538:2553:2559:2562:2828:3138:3139:3140:3141:3142:3304:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6119:7522:7652:7903:10007:10400:10848:10967:11026:11232:11473:11658:11914:12043:12294:12517:12519:12555:12740:21080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:1:0
X-HE-Tag: hand03_82ebb5de1b14b
X-Filterd-Recvd-Size: 3535
Received: from [192.168.1.162] (pool-71-103-235-196.lsanca.fios.verizon.net [71.103.235.196])
	(Authenticated sender: joe@perches.com)
	by omf03.hostedemail.com (Postfix) with ESMTPA;
	Sun, 10 Aug 2014 21:41:39 +0000 (UTC)
In-Reply-To: <20140810143500.2d556ae9.akpm@linux-foundation.org>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255110>

On Sun, 2014-08-10 at 14:35 -0700, Andrew Morton wrote:
> On Sun, 10 Aug 2014 14:28:01 -0700 Joe Perches <joe@perches.com> wrote:
> > > On Thu, Jul 3, 2014 at 12:00 AM, Joe Perches <joe@perches.com> wrote:
> > > > Commit logs have various forms of commit id references.
> > > >
> > > > Try to standardize on a 12 character long lower case
> > > > commit id along with a description of parentheses and
> > > > the quoted subject line
> > > >
> > > > ie: commit 0123456789ab ("commit description")
> > > 
> > > Now this is in mainline, checkpatch starts complaining about my "too long"
> > > (40 chars) commit IDs in commit messages :-(
> > > 
> > > 40 chars may be too long (but it's quick to copy-and-paste, as "git show"
> > > shows that by default), but 12 sounds a bit short, as that's only 48 bits.
> > 
> > Right now, this test allows 12 to 16 byte length commit ids
> > without emitting a warning.
> > 
> > Andrew wanted this test, I don't care how long the commit id
> > is in the commit log.
> 
> Well, I mainly wanted to stop having to add "commit description" when
> people forget it.  The length check was perhaps a bit anal.  How about
> we make it "12 or more"?

Fine by me, just change the 16 to 40
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 31a731e..b385bcb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2133,7 +2133,7 @@ sub process {
 # Check for improperly formed commit descriptions
 		if ($in_commit_log &&
 		    $line =~ /\bcommit\s+[0-9a-f]{5,}/i &&
-		    $line !~ /\b[Cc]ommit [0-9a-f]{12,16} \("/) {
+		    $line !~ /\b[Cc]ommit [0-9a-f]{12,40} \("/) {
 			$line =~ /\b(c)ommit\s+([0-9a-f]{5,})/i;
 			my $init_char = $1;
 			my $orig_commit = lc($2);
@@ -2141,7 +2141,7 @@ sub process {
 			my $desc = 'commit description';
 		        ($id, $desc) = git_commit_info($orig_commit, $id, $desc);
 			ERROR("GIT_COMMIT_ID",
-			      "Please use 12 to 16 chars for the git commit ID like: '${init_char}ommit $id (\"$desc\")'\n" . $herecurr);
+			      "Please use 12 or more chars for the git commit ID like: '${init_char}ommit $id (\"$desc\")'\n" . $herecurr);
 		}
 
 # Check for added, moved or deleted files
