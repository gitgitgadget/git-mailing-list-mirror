From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/2] git-p4: fix submit regression with --use-client-spec
Date: Sat, 25 Feb 2012 20:06:23 -0500
Message-ID: <1330218385-22309-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Laurent=20Charri=C3=A8re?= <lcharriere@promptu.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 02:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1SZl-0003tB-SU
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 02:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab2BZBGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 20:06:31 -0500
Received: from honk.padd.com ([74.3.171.149]:55344 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305Ab2BZBGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 20:06:30 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id C0BB0E8D;
	Sat, 25 Feb 2012 17:06:29 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A4C1E313D8; Sat, 25 Feb 2012 20:06:25 -0500 (EST)
X-Mailer: git-send-email 1.7.9.220.g4b839
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191550>

This pair of patches fixes a regression that happened with ecb7cf9
(git-p4: rewrite view handling, 2012-01-02).  There are two factors that
affect where files go in the client when submitting:  the cilent spec,
and the depot path.  When the depot path was not exactly the root of
the client, submit fails.

Fix this by always using the true client root.  And also notice that
somebody has to tell the submit path that it should be looking at the
cilent spec.  Save useClientSpec in a configuration variable if it
was specified as an option on the command line.

Junio: can you put this on maint to go out with the next 1.9.x?

Pete Wyckoff (2):
  git-p4: set useClientSpec variable on initial clone
  git-p4: fix submit regression with clientSpec and subdir clone

 Documentation/git-p4.txt      |   10 ++-
 contrib/fast-import/git-p4    |   97 ++++++++++++++++---------
 t/t9809-git-p4-client-view.sh |  159 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 219 insertions(+), 47 deletions(-)

-- 
1.7.9.219.g1d56c.dirty
