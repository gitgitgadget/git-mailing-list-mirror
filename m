From: esr@thyrsus.com (Eric S. Raymond)
Subject: I have end-of-lifed cvsps
Date: Wed, 11 Dec 2013 19:17:38 -0500 (EST)
Message-ID: <20131212001738.996EB38055C@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 12 01:24:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqu4S-0004Wk-Nq
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 01:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab3LLAX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 19:23:58 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:60166
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3LLAX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 19:23:58 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2013 19:23:58 EST
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 996EB38055C; Wed, 11 Dec 2013 19:17:38 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239220>

On the git tools wiki, the first paragraph of the entry for cvsps now
reads:

  Warning: this code has been end-of-lifed by its maintainer in favor of
  cvs-fast-export. Several attempts over the space of a year to repair
  its deficient branch analysis and tag assignment have failed.  Do not
  use it unless you are converting a strictly linear repository and
  cannot get rsync/ssh read access to the repo masters. If you must use
  it, be prepared to inspect and manually correct the history using
  reposurgeon.

I tried very hard to salvage this program - the ability to
remote-fetch CVS repos without rsync access was appealing - but I
reached my limit earlier today when I actually found time to assemble
a test set of CVS repos and run head-to-head tests comparing cvsps
output to cvs-fast-export output.

I've long believed that that cvs-fast-export has a better analyzer
than cvsps just from having read the code for both of them, and having
had to fix some serious bugs in cvsps that have no analogs in
cvs-fast-export.  Direct comparison of the stream outputs revealed
that the difference in quality was larger than I had prevously grasped.

Alas, I'm afraid the cvsps repo analysis code turns out to be crap all
the way down on anything but the simplest linear and near-linear
cases, and it doesn't do so hot on even those (all this *after* I
fixed the most obvious bugs in the 2.x version). In retrospect, trying
to repair it was misdirected effort.

I recommend that git sever its dependency on this tool as soon as
possible. I have shipped a 3.13 release with deprecation warnings fot
archival purposes, after which I will cease maintainance and redirect
anyone inquiring about cvsps to cvs-fast-export.

(I also maintain cvs-fast-export, but credit for the excellent analysis code 
goes to Keith Packard.  All I did was write the output stage, document
it, and fix a few minor bugs.)
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

You [should] not examine legislation in the light of the benefits it will
convey if properly administered, but in the light of the wrongs it
would do and the harm it would cause if improperly administered
	-- Lyndon Johnson, former President of the U.S.
