From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/4] Generate cover letters with format-patch
Date: Wed, 6 Feb 2008 11:43:14 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802061129120.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:44:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMnOC-00049s-7p
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 17:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYBFQnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 11:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbYBFQnb
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 11:43:31 -0500
Received: from iabervon.org ([66.92.72.58]:58417 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796AbYBFQn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 11:43:28 -0500
Received: (qmail 27664 invoked by uid 1000); 6 Feb 2008 16:43:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 16:43:15 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72813>

Cover letters are often useful for patch series that don't have a single 
patch whose message should explain everything. But they're somewhat of a 
pain to generate by hand, since you have to remember what generated text 
you want to put in them, how you want to address them, how many patches 
are in the series, what you're putting in the subject tag, and so forth. 
This series adds a --cover-letter flag that generates one more message at 
the start of the series, with all of the sequencing and generation code 
intact, with a few spaces for you to fill in. This cover letter is an 
example of the output (without the option to thread the patches).

IIRC, I requested this feature, and Johannes implemented it and sent me a 
patch, and then I rewrote the patch almost entirely, but I'd never have 
figured out format-patch without his patch as a guide.

	-Daniel
*This .sig left intentionally blank*

Daniel Barkalow (4):
      Improve message-id generation flow control for format-patch
      Export some email and pretty-printing functions
      Retain extra blank lines between the summary and the body
      Add a --cover-letter option to format-patch

 Documentation/git-format-patch.txt                 |    6 +
 builtin-log.c                                      |  244 ++++++++++++++------
 commit.h                                           |   15 ++
 log-tree.c                                         |  126 ++++++-----
 log-tree.h                                         |    2 +
 pretty.c                                           |   32 ++--
 t/t4013-diff-various.sh                            |    1 +
 ...tch_--stdout_--cover-letter_-n_initial..master^ |  101 ++++++++
 8 files changed, 378 insertions(+), 149 deletions(-)
 create mode 100644 t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
