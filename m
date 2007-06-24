From: Daniel Barkalow <barkalow@iabervon.org>
Subject: DWIM ref names for push/fetch
Date: Sun, 24 Jun 2007 18:25:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706241808550.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 00:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2aWB-0003pM-Pj
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 00:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbXFXWZO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 18:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbXFXWZO
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 18:25:14 -0400
Received: from iabervon.org ([66.92.72.58]:3323 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbXFXWZN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 18:25:13 -0400
Received: (qmail 8051 invoked by uid 1000); 24 Jun 2007 22:25:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jun 2007 22:25:12 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50836>

AFAICT, the rules are currently:

for push, we compare the source against the list of local refs, and do 
some complicated stuff to figure out what it matches. Then we compare the 
destination against the list of remote refs (with no destination being 
interpreted as the full name of the source), and do the same complicated 
stuff.

for fetch, we accept anything that starts with "refs/heads/", 
"refs/tags/", or "refs/remotes/"; prepend "refs/" to anything that starts 
with "heads/", "tags/", or "remotes/"; and prepend "refs/heads/" to 
anything else. (NB: I'm looking at Julian's C translation, rather than the 
original shell scripts, which I find inpenetrable).

Is this difference simply due to the different languages the matching 
portions of these were originally written in? Would it be okay to change 
fetch to work like push? It would be nice to have a single procedure for 
determining which (if any) of a list of refs is the match for some string, 
regardless of why we're looking.

	-Daniel
*This .sig left intentionally blank*
