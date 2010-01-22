From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/3] Fixes to mh/rebase-fixup
Date: Fri, 22 Jan 2010 10:22:28 +0100
Message-ID: <cover.1264151435.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	tarmigan+git@gmail.com, j.sixt@viscovery.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 10:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYFjj-0002zJ-5B
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 10:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab0AVJXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 04:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984Ab0AVJXT
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 04:23:19 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:53974 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab0AVJXO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 04:23:14 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1CC41.dip.t-dialin.net [79.193.204.65])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0M9Mb4N014743;
	Fri, 22 Jan 2010 10:22:38 +0100
X-Mailer: git-send-email 1.6.6
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137750>

This patch series contains fixes to the mh/rebase-fixup patch series
as suggested by reviewers on the mailing list.

Since the mh/rebase-fixup patch series is already in "next", I have
written these fixup patches against "next".  I hope that is OK.

The third patch removes the attempt to use one-shot export of
variables in do_with_author(), as the "$@" command that it calls might
be a shell function.  This issue was discussed on the mailing list
[1].  This change has the side effect that the GIT_AUTHOR_* variables
remain exported after do_with_author() returns, but I don't think that
this is a problem in the context of git-rebase--interactive.sh.
However, additional review would be welcome here.

[1] http://marc.info/?l=git&m=126345851831751&w=2

Michael Haggerty (3):
  rebase -i: Avoid non-portable "test X -a Y"
  rebase -i: Enclose sed command substitution in quotes
  rebase -i: Export GIT_AUTHOR_* variables explicitly

 git-rebase--interactive.sh |    6 ++----
 t/lib-rebase.sh            |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)
