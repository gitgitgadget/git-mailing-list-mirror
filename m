From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/2] Fail merge gently
Date: Mon, 3 Dec 2007 00:32:38 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712030025032.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 06:33:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz3vP-0008I5-EX
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 06:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbXLCFcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 00:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbXLCFcj
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 00:32:39 -0500
Received: from iabervon.org ([66.92.72.58]:46457 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbXLCFcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 00:32:39 -0500
Received: (qmail 20072 invoked by uid 1000); 3 Dec 2007 05:32:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Dec 2007 05:32:38 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66864>

This series makes it possible to call unpack_trees() and get an error 
result instead of having it call die(). Additionally, it allows the caller 
to suppress error messages, in case it's just going to try something else 
instead of actually failing. This passes all of the tests, and should 
have no effect on existing code except for making the exit messages not 
say "fatal:", and merge-recursive will free its tree cache before exiting, 
and print an additional message already in the code but previously 
inaccessible.

This is preliminary for builtin-checkout, which I'm partway through. I 
think I'm down to the case where a real merge is needed for -m, but I'm 
not sure, and I think I need to write a bunch of tests for checkout.

Daniel Barkalow (2):
      Allow callers of unpack_trees() to handle failure
      Add flag to make unpack_trees() not print errors.

 builtin-read-tree.c |    3 +-
 unpack-trees.c      |   90 ++++++++++++++++++++++++++++++---------------------
 unpack-trees.h      |    1 +
 3 files changed, 56 insertions(+), 38 deletions(-)

	-Daniel
*This .sig left intentionally blank*
