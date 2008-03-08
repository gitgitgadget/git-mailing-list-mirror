From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 09/11] Provide API access to init_db()
Date: Sat, 8 Mar 2008 18:55:29 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081840070.19665@iabervon.org>
References: <alpine.LNX.1.00.0803081804200.19665@iabervon.org> <alpine.LSU.1.00.0803090026170.3975@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:56:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8te-0006Ii-6A
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbYCHXzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYCHXzc
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:55:32 -0500
Received: from iabervon.org ([66.92.72.58]:60902 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbYCHXzc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:55:32 -0500
Received: (qmail 21436 invoked by uid 1000); 8 Mar 2008 23:55:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:55:29 -0000
In-Reply-To: <alpine.LSU.1.00.0803090026170.3975@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76627>

On Sun, 9 Mar 2008, Johannes Schindelin wrote:

> On Sat, 8 Mar 2008, Daniel Barkalow wrote:
> 
> > The caller first calls set_git_dir() to specify the GIT_DIR, and then 
> > calls init_db() to initialize it. This also cleans up various parts of 
> > the code to account for the fact that everything is done with GIT_DIR 
> > set, so it's unnecessary to pass the specified directory around.
> 
> I think the most controversial part is that you change the way it is 
> determined if the repository is a bare one.  It might have the same 
> result (I do not have time to check it...), but the computation is 
> performed differently.

It's actually doing the same computation; the difference is how the result 
is reported. Mine commits to the repo being non-bare if it doesn't think 
it's bare, which the current code leaves as "we don't know, assume 
non-bare". But since we actually create a work tree if we guess it's 
non-bare, it really is non-bare. So then the later code can assume it's 
either 0 or 1, and not worry about -1 being equivalent to 0.

	-Daniel
*This .sig left intentionally blank*
