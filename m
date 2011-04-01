From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/4] reflog, show and command line overrides
Date: Fri,  1 Apr 2011 11:20:30 +0200
Message-ID: <cover.1301649372.git.git@drmicha.warpmail.net>
References: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 11:24:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5aaV-00017j-Sx
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 11:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab1DAJYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 05:24:09 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34791 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752933Ab1DAJYH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 05:24:07 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D5650208C0;
	Fri,  1 Apr 2011 05:24:06 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 01 Apr 2011 05:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=cqAjXkbgAb3kMYOubjZfyW5Ew7U=; b=nvuJXg0JqT+jFhTLtU8y99PxH7rGGceLowt+Wz+tMPyp38hSNqsdSYAbQ+LyLuX3qPgS96RGbi16vzHm5yu5xTioFvdy3pNFUVriHinwnZwlRKP2XQAQGrWza0+j+FN9Rae4lmcUuWbOIcy86TOd19VqeTeHVLp7kbDmvsJ2wJc=
X-Sasl-enc: FZSlEeDD6lhIo7d/jusPCePNFo6HgjggWvqcnRd3sZ/0 1301649846
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 58EA5405202;
	Fri,  1 Apr 2011 05:24:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170566>

While thinking about how to redo 3/3 (show: do not prune by pathspec) I
noticed a somehow related reflog problem, which overrides some command line
options.

So, here is some refactoring, a test exposing the reflog problem, and a fix for
reflog (the new 1/4 through 3/4). Those 3 should be general good cleanup.

It turned out that the refactoring does not help with the show problem, but I
changed the old 3/3 so that we change the pruning by commits only when the user
has not requested to walk with show (the new 4/4). No time for new test now, sorry.

The old 1/3 and 2/3 ("Did you mean...") are not impacted (and not resent). They
make for independent good UI cleanup also (and were related thematically only,
not technically).

Michael J Gruber (4):
  builtin/log.c: separate default and setup of cmd_log_init()
  t/t1411: test reflog with formats
  reflog: fix overriding of command line options
  builtin/show: do not prune by pathspec

 builtin/log.c          |   32 +++++++++++++++++++-------------
 t/t1411-reflog-show.sh |   18 ++++++++++++++++++
 2 files changed, 37 insertions(+), 13 deletions(-)

-- 
1.7.4.2.668.gba03a4
