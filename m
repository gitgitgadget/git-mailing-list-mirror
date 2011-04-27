From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 0/2] RFC/POC: patterns for branch list
Date: Wed, 27 Apr 2011 14:15:17 +0200
Message-ID: <cover.1303906496.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 14:15:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF3eU-0000XD-1d
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 14:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758881Ab1D0MPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 08:15:22 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46365 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758821Ab1D0MPV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 08:15:21 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 31F8320D25
	for <git@vger.kernel.org>; Wed, 27 Apr 2011 08:15:21 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 27 Apr 2011 08:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=1NnwP3+GBy49stZN5JpMG9rX15M=; b=htmK25PhD3SuXDDhQPIv+25gSx4jneY8gqYRBHjTuqcadO/CotNujw2bSwlfsyVwFRbQsKnWLFw7mcS4wzu1zg7+Rnj1mXXT9zcv1xGGRQdfWCI0QQ3zJM9UhjFu+dNsUirg5beM/FtVx7Po7s/MH9MPuyTNN1qIh7jUnZxjmFI=
X-Sasl-enc: 8K9xNEldQSUygaG71jurXtTzmwVyRb88jQ2O1q1r6hNz 1303906520
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A9BD044871A;
	Wed, 27 Apr 2011 08:15:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.270.gafca7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172226>

This mini series is about introducing patterns to the list mode of
'git branch' much like the pattern for 'git tag -l'. There are several
things which I would like to do but would like to rfc first:

'-l' is the natural short option name for '--list'. This is taken for the
rarely used or needed 'create reflog' option. I'd change the latter to
'-g,--create-reflog' (cmp. log) and take '-l,--list' but know the reaction
already.

'-v' and '-vv' both take considerable time (because they need to walk).
It makes more sense to have '-v' display cheap output (upstream name)
and '-vv' add expensive output (ahead/behind info). '-vvv' could add super
expensive info (ahead/equivalent/behind a la cherry-mark).

But all of the above are changes to current (ui) behaviour. In the two patches
below, only the automatic activation of the list mode with -v/-vv is a
change of (undocumented) behaviour.

And yes, git-for-each-ref can do all this and more, but that is plumbing.

Michael J Gruber (2):
  branch: allow pattern arguments
  branch: introduce --list argument

 builtin/branch.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

-- 
1.7.5.270.gafca7
