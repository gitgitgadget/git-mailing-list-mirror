From: esr@thyrsus.com (Eric S. Raymond)
Subject: Heads up, an emergency fix for git-cvsimport is coming shortly
Date: Sun, 30 Dec 2012 14:21:16 -0500 (EST)
Message-ID: <20121230192116.C2A2444143@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 20:22:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpOSm-0001OY-QS
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 20:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab2L3TWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 14:22:00 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:45822
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab2L3TV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 14:21:58 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id C2A2444143; Sun, 30 Dec 2012 14:21:16 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212340>

Bad news: the combination of cvsps and the existing git-cvsimport
script is seriously broken in both places.  This morning I fixed a
nasty bug in cvsps's branch detection and shipped 3.3. This is a
different bug from the broken (and now removed) ancestry-branch
tracking.

Good news: I have fixed all the urgent bugs (and now you know how I
spent my holidays).  Somewhat to my surprise, half the problems listed
on the git-cvsimport manual page turned out to be problems in
git-cvsimport itself, not more cvsps lossage. Those bugs are dead.

cvsps is now much better about warning when it cannot translate a tag
or sees a dubious branch structure.  I've also enhanced git-cvsimport
to have an engine switch so it can optionally use cvs2git as its 
conversion engine. If and when I can get parsecvs back into working
shape, I will add it to the set of supported engines.

I have a test suite that proves fixes for all the urgent problems, but
that needs a bit more work before I'm willing to call it done.

In a few days I will ship a patch that replaces git-cvsimport with a
working version and removes the t960[123] tests from the git tree.
Those are not actually tests of git-cvsimport itself but of the
underlying conversion engine, and now form about half of cvsps's own
regression-test suite.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

It is proper to take alarm at the first experiment on our
liberties. We hold this prudent jealousy to be the first duty of
citizens and one of the noblest characteristics of the late
Revolution. The freemen of America did not wait till usurped power had
strengthened itself by exercise and entangled the question in
precedents. They saw all the consequences in the principle, and they
avoided the consequences by denying the principle. We revere this
lesson too much ... to forget it	-- James Madison.
