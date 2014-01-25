From: David Kastrup <dak@gnu.org>
Subject: [PATCH 0/3] "Teaser" patch for rewriting blame for efficiency
Date: Sat, 25 Jan 2014 19:23:38 +0100
Message-ID: <1390674221-25767-1-git-send-email-dak@gnu.org>
References: <877g9ocjsk.fsf@fencepost.gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 25 19:24:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W77uC-0004QA-BH
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 19:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbaAYSYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 13:24:25 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:55942 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbaAYSYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 13:24:24 -0500
Received: from localhost ([127.0.0.1]:54980 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W77tv-0001J2-Ja; Sat, 25 Jan 2014 13:24:15 -0500
Received: by lola (Postfix, from userid 1000)
	id 5096AE0725; Sat, 25 Jan 2014 19:23:55 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <877g9ocjsk.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241073>

Ok, here is the "teaser" for the git-blame rewrite.  The first two
patches are already in pu and only contained for simplicity.  The
third patch gives a pretty good idea about the work that's up.  It is
missing support for the -M and -C options (I think, if that's what the
"move" and "copy" detection are supposed to be about).  Part of
preexisting code is #if 0/#endif removed since I don't know yet
whether the implementation of copy/move will need some of that.

Apart from these rather obvious problems, the question is whether it
is ok to do the finished rewrite as a single commit since I cannot
really envision useful intermediate stages.

While there is not much of a point on commenting on the code (and its
tentative changes) within #if 0/#endif, the code that is actually
compiled is of course open to preliminary criticism.

For obvious reasons, patch #3 is not signed off: it should never be
committed in its current form.

David Kastrup (3):
  builtin/blame.c: struct blame_entry does not need a prev link
  Eliminate same_suspect function in builtin/blame.c
  builtin/blame.c: large-scale rewrite

 builtin/blame.c | 595 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 371 insertions(+), 224 deletions(-)

-- 
1.8.3.2
