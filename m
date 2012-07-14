From: Felix Natter <fnatter@gmx.net>
Subject: bzr->git: keep empty directories
Date: Sat, 14 Jul 2012 16:41:04 +0200
Message-ID: <87sjcuz9q7.fsf@bitburger.home.felix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 16:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq3Xh-0000Qh-L5
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 16:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349Ab2GNOlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 10:41:19 -0400
Received: from plane.gmane.org ([80.91.229.3]:50761 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086Ab2GNOlS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 10:41:18 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Sq3X2-0007pv-Rx
	for git@vger.kernel.org; Sat, 14 Jul 2012 16:41:16 +0200
Received: from pd9e8261c.dip.t-dialin.net ([217.232.38.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 16:41:16 +0200
Received: from fnatter by pd9e8261c.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 16:41:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e8261c.dip.t-dialin.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Cancel-Lock: sha1:gLaIeFIpb7kJkbhcejhZrk+C68E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201445>

hello,

when converting a repo from bzr to git:

mkdir freeplane-git1
cd freeplane-git1
git init .
bzr fast-export --plain --export-marks=../marks.bzr ../trunk/ | git fast-import --export-marks=../marks.git
git checkout

Empty directories are not contained in the git working index. This is
because of the --plain option, which "Excludes metadata to maximise
interoperability" and thus does not support empty directories
(http://doc.bazaar.canonical.com/plugins/en/fastimport-plugin.html).

However, when I use "--no-plain" (which according to above documentation
exports empty directories), git cannot handle it:

$ ./freeplane2git.sh 
Initialized empty Git repository in /home/felix/git/freeplane-git1/.git/
15:56:09 Calculating the revisions to include ...
15:56:09 Starting export of 4290 revisions ...
fatal: This version of fast-import does not support feature commit-properties.
fast-import: dumping crash report to .git/fast_import_crash_3915
bzr: broken pipe

I already tried to hack bzr-fastimport's exporter.py so that it does not
emit commit properties but emits empty directories but i was not
successful.

So is there another way to preserve empty directories or shall I report
a bug on bzr fast-export?

Many thanks in advance!
-- 
Felix Natter
