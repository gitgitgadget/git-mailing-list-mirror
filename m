From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 6/7] git rm: Support for removing submodules
Date: Thu, 17 Jul 2008 14:35:01 +0200
Message-ID: <20080717123501.GD10151@machine.or.cz>
References: <20080716190753.19772.93357.stgit@localhost> <20080716191134.19772.85003.stgit@localhost> <alpine.DEB.1.00.0807170038430.4318@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 14:36:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJSiK-0001fN-On
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 14:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbYGQMfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 08:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbYGQMfF
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 08:35:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54875 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbYGQMfF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 08:35:05 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E010B2C4C025; Thu, 17 Jul 2008 14:35:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807170038430.4318@eeepc-johanness>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88841>

  Hi,

On Thu, Jul 17, 2008 at 12:41:57AM +0200, Johannes Schindelin wrote:
> On Wed, 16 Jul 2008, Petr Baudis wrote:
> 
> > This patch adds support for removing submodules to 'git rm', including 
> > removing the appropriate sections from the .gitmodules file to reflect 
> > this
> 
> I have no time to look at the whole series, or even at the patch, but I 
> have concerns.  Do you really remove the whole directory?  Because if you 
> do, you remove more than what can be possibly reconstructed from the 
> object store.

  no; I remove only the index entry and the empty directory made for
non-checked-out submodules (I just try rmdir() and ignore ENOTEMPTY
error).  I make that clear in git rm documentation, but not in the patch
description; I will fix that.

> I wonder if it really makes sense to integrate that into git-rm, and not 
> git-submodule, if only to introduce another level of consideration for the 
> user before committing what is potentially a big mistake.

  That is good question and I forgot to elaborate on this in the cover
letter. However, I believe that integrating this functionality into the
basic commands makes for a smoother user experience, following the
principle of the least surprise. It is difficult for me to argue
extensively in further favor of this choice, though. :-)

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
