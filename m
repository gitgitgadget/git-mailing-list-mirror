From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Obscure commit message formatting issue
Date: Sun, 11 Nov 2007 16:28:19 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711111559220.29952@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 22:28:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrKM8-0004MQ-0w
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 22:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbXKKV2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 16:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbXKKV2V
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 16:28:21 -0500
Received: from iabervon.org ([66.92.72.58]:38003 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbXKKV2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 16:28:20 -0500
Received: (qmail 27078 invoked by uid 1000); 11 Nov 2007 21:28:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Nov 2007 21:28:19 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64518>

The current code drops extra blank lines between the first line of a 
commit message (the summary line) and the remainder. That is:

This is the summary


This is another bit


This is a third bit

turns into:

Subject: This is the summary
Other-Headers:

This is another bit


This is a third bit


This is an issue if you want to generate an email whose body starts with a 
blank line, and I assume (although I haven't tried), that rebase would 
lose a blank line out of commits formatted like that. We don't seem to 
have any tests that require that line to get suppressed, and we also don't 
suppress any other blank lines. Is there some reason to do it?

I'd guess that the "first" handling in pp_remainder() was intended to skip 
the blank line between the summary line and the body, but that line has 
already been consumed by other code.

	-Daniel
*This .sig left intentionally blank*
