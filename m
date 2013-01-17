From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 0/8] Initial Python 3 support
Date: Thu, 17 Jan 2013 18:53:53 +0000
Message-ID: <cover.1358448207.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:55:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvucq-0003uk-DC
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 19:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab3AQSzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 13:55:19 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:46995 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab3AQSzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 13:55:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E6E6ECDA5CF;
	Thu, 17 Jan 2013 18:55:15 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JL+QQqHRgmNb; Thu, 17 Jan 2013 18:55:07 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by jackal.aluminati.org (Postfix) with ESMTP id 6E3CBCDA583;
	Thu, 17 Jan 2013 18:55:07 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 24A75276DFE;
	Thu, 17 Jan 2013 18:55:07 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x8umieBoLWRt; Thu, 17 Jan 2013 18:55:06 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id C4016276DFB;
	Thu, 17 Jan 2013 18:54:39 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213862>

This series does enough so that everything except git-p4 runs under
Python 3.

As discussed with Pete, it may not make sense to change git-p4 to
support Python 3 until Perforce's Python output mode is changed.  So
does it make sense to merge this now and say "use Python 2 if you want
git-p4"?

Changes since v1:

* rebased on master after fc/remote-testgit-feature-done was merged,
  leading to an extra change in patch 8 (git-remote-testpy: call print
  as a function)
* changed patch 2 (git_remote_helpers: fix input when running under
  Python 3) to treat ref names as byte strings

John Keeping (8):
  git_remote_helpers: Allow building with Python 3
  git_remote_helpers: fix input when running under Python 3
  git_remote_helpers: Force rebuild if python version changes
  git_remote_helpers: Use 2to3 if building with Python 3
  svn-fe: allow svnrdump_sim.py to run with Python 3
  git-remote-testpy: hash bytes explicitly
  git-remote-testpy: don't do unbuffered text I/O
  git-remote-testpy: call print as a function

 contrib/svn-fe/svnrdump_sim.py     |  4 ++--
 git-remote-testpy.py               | 42 +++++++++++++++++++-------------------
 git_remote_helpers/.gitignore      |  1 +
 git_remote_helpers/Makefile        | 10 +++++++--
 git_remote_helpers/git/importer.py |  9 +++++---
 git_remote_helpers/setup.py        | 10 +++++++++
 6 files changed, 48 insertions(+), 28 deletions(-)

-- 
1.8.1.1.260.g99b33f4.dirty
