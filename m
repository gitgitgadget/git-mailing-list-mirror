From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/5] Extend pattern refspecs
Date: Thu, 5 Mar 2009 23:56:13 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903052346270.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 05:57:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfS81-0008Rl-CX
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 05:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbZCFE4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 23:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbZCFE4Q
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 23:56:16 -0500
Received: from iabervon.org ([66.92.72.58]:51773 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbZCFE4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 23:56:16 -0500
Received: (qmail 6356 invoked by uid 1000); 6 Mar 2009 04:56:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Mar 2009 04:56:13 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112379>

This series only supports the narrowest case of having the * in the middle 
of a side of a refspec: having it as a full path component on each side.

Patches 1-3 centralize all of the parsing and matching rules to a pair of 
functions; patch 4 makes the stored representation more convenient (and 
serves as a distinguished bisection outcome for anything I missed that was 
relying on the contents of struct refspec for patterns); and patch 5 
extends the matching implementation and loosens the ref format 
requirements to allow the * to be in the middle.

An easy followup would relax the restrictions further without requiring 
any particularly tricky further changes.

Daniel Barkalow (5):
  Make clone parse the default fetch refspec with the regular code
  Use a single function to match names against patterns
  Use the matching function to generate the match results
  Keep '*' in pattern refspecs
  Support '*' in the middle of a refspec

 builtin-clone.c    |   25 ++++++++--------
 refs.c             |   15 +++++----
 remote.c           |   78 +++++++++++++++++++++++++++++----------------------
 t/t5511-refspec.sh |   12 ++++++++
 4 files changed, 77 insertions(+), 53 deletions(-)
