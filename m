From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Invalid refspec?
Date: Thu, 20 Mar 2008 09:21:18 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803200914420.19665@iabervon.org>
References: <2008-03-20-11-53-31+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Mar 20 14:22:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcKii-0002RX-Dq
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 14:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbYCTNVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 09:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753737AbYCTNVV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 09:21:21 -0400
Received: from iabervon.org ([66.92.72.58]:39738 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322AbYCTNVV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 09:21:21 -0400
Received: (qmail 13794 invoked by uid 1000); 20 Mar 2008 13:21:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Mar 2008 13:21:18 -0000
In-Reply-To: <2008-03-20-11-53-31+trackit+sam@rfc1149.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77656>

On Thu, 20 Mar 2008, Samuel Tardieu wrote:

> I am using git master branch locally (1.5.5.rc0.133.g7e207), and the
> server is using 1.5.4.rc3.g16335. I want to push my HEAD~1 revision
> into the 2.0 branch on the server, and it looks like it is not
> expanded anymore in the refspec:
> 
> % git push origin HEAD~1:2.0
> fatal: Invalid refspec 'HEAD~1:2.0'
> fatal: The remote end hung up unexpectedly
> 
> Isn't HEAD~1 supposed to be expanded locally? Using the SHA-1 instead
> of HEAD~1 works fine.

Ah, yes. I added checks for invalid refspecs, and missed that you can use 
things that are invalid as ref names but valid as object names.

We need a test for the src being an object name around line 443 in 
remote.c; I'll have something this evening if nobody beats me to it. For 
now, you can comment out line 444 (except for a semicolon) to disable the 
check that's in your way.

	-Daniel
*This .sig left intentionally blank*
