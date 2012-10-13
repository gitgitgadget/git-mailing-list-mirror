From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 0/2] git-cvsimport: support local timezone
Date: Fri, 12 Oct 2012 23:11:53 -0500
Message-ID: <cover.1350100320.git.chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 06:12:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMt5E-0002zM-6g
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 06:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883Ab2JMEL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 00:11:57 -0400
Received: from [38.98.186.242] ([38.98.186.242]:10977 "HELO burner.cogcap.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1750836Ab2JMEL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 00:11:56 -0400
Received: by burner.cogcap.com (Postfix, from userid 10028)
	id D597B2B096D; Fri, 12 Oct 2012 23:11:55 -0500 (CDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207568>

Changes to support local timezone offsets in imported commits.  Modified
documentation to clarify behavior of new -l option.

Also, I split the original patch into two because using
localtime()/timelocal() does not affect current functionality, but makes
for sane results if someone monkeys with the hardcoded TZ environment
setting.  Also, the problem solved by the second patch could also be
addressed by simply removing the hardcoded TZ setting in favor of having
the user specify in their environment.  Both of these solutions build on
the changes made in the first patch, though.

Chris Rorvick (2):
  git-cvsimport: use localtime for converting timestamps
  git-cvsimport: allow local timezone for commits

 Documentation/git-cvsimport.txt |   13 ++++++++++---
 git-cvsimport.perl              |   13 +++++++------
 2 files changed, 17 insertions(+), 9 deletions(-)
