From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Update local tracking refs when pushing- no way to disable
Date: Thu, 5 Jul 2007 23:37:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707052320090.14638@iabervon.org>
References: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 05:37:47 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6edd-00038j-P0
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 05:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759645AbXGFDhe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 23:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755526AbXGFDhd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 23:37:33 -0400
Received: from iabervon.org ([66.92.72.58]:1498 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbXGFDhd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 23:37:33 -0400
Received: (qmail 11605 invoked by uid 1000); 6 Jul 2007 03:37:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jul 2007 03:37:32 -0000
In-Reply-To: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51719>

On Thu, 5 Jul 2007, Dan McGee wrote:

> In this commit:
> b516968ff62ec153e008d033c153affd7ba9ddc6
> 
> I don't know if anyone else has the same way of working as I do, but I
> tend to set the "remote.<name>.skipDefaultUpdate" property to true for
> my publicly visible repository, just so I don't have duplicate branch
> heads lying around in my local repository. Call this peculiar, but I
> like it that way. However, git-push does not respect this property,
> meaning I know have these branches whether I want them or not. In a
> tool such as qgit or even 'git branch -a' output, it starts to get
> awful cluttered.

What git-fetch and git-push care about is whether you have an entry 
"remote.<name>.fetch" with a colon and stuff on the right of it. If so, 
this is a pattern that is used to generate the duplicate branch heads that 
you don't want. git clone sets it up to a default pattern 
(refs/remotes/origin/*), and I don't think there's any way to make it not 
do that, but you can just reconfigure it afterwards if you don't like it.

I can't see where git-push would get the names to use if you don't have 
such an entry, and having the entry isn't useful if you actually don't 
want those refs. It's probably just a matter of deleting it, since it was 
probably created for you by some tool trying to be helpful.

(AFAICT, the only additional stuff that -a shows with git branch is the 
stuff that you're deleting; perhaps qgit should have an option to not show 
remotes, or not show them by default or only show them if what they point 
to isn't otherwise marked? Anyway, it shouldn't be necessary to avoid 
having this information just so that it isn't shown in interfaces you 
use.)

	-Daniel
*This .sig left intentionally blank*
