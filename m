From: Johan Herland <johan@herland.net>
Subject: Re: Comment on weak refs
Date: Sun, 10 Jun 2007 15:41:44 +0200
Message-ID: <200706101541.44362.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706100325.32846.johan@herland.net>
 <Pine.LNX.4.64.0706100716480.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 15:41:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxNfy-0002b0-Nu
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 15:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbXFJNlt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 09:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbXFJNlt
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 09:41:49 -0400
Received: from smtp.getmail.no ([84.208.20.33]:57360 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbXFJNls (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 09:41:48 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00I05A1N0800@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 15:41:47 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00E6PA1K0X10@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 15:41:44 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00DUTA1KBT40@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 15:41:44 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706100716480.4059@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49729>

On Sunday 10 June 2007, Johannes Schindelin wrote:
> On Sun, 10 Jun 2007, Johan Herland wrote:
> > On Sunday 10 June 2007, Junio C Hamano wrote:
> Has my lightweight annotation patch reached you?
> 
> I like my approach better than yours, because it is
> 
> 1) a way, way smaller patch, and
> 2) it automatically includes the versionability.

I see your point, but your lightweight annotations are solving a different 
problem, aren't they? They do provide the after-the-fact annotations that 
sort of sparked of these discussions, but I can't see how your patch is a 
replacement of the general "relationships between arbitrary objects" 
concept that softrefs try to solve.

Of course, it might be that the lightweight annotations are "good enough" 
for the use cases we currently see, and that softrefs are a bit overkill. 
We'll just have to see what features people (like Pierre) really need.

> After thinking about it a little more (my plane was slow, and as a result 
> I am allowed to spend 8 more hours in Paris), I think that a small but 
> crucial change would make this thing even more useful:
> 
> Instead of having "core.showAnnotations" be a boolean config, it might be 
> better to have "core.annotationsRef" instead, overrideable by the 
> environment variable GIT_ANNOTATION_REF.
> 
> With this, you can have different refs for different kinds of annotations.
> 
> For example, some people might add bugtracker comments (even comments like 
> "this commit was bad: introduced bug #798, solved by commit 9899fdadc.."). 
> Those comments could live in refs/annotations/bugs. To see them, just say 
> 
> 	GIT_ANNOTATION_REF=refs/annotations/bugs gitk
> 
> Voila.

Nice. Something similar should be possible to do with softrefs as well.

> I am quite certain that treating annotations as branches, containing 
> fan-out directories for the reverse lookup. I am even quite certain that 
> in most cases, a working-directory-less merging is possible for such 
> annotations.

I'm not convinced about the working-directory-less merging. AFAICS the 
lightweight annotations will behave pretty much like the "regular" version 
controlled filesystem, and you'll have the same kind of conflicts when you 
merge stuff between repos. I'd be glad to be proven wrong, of course.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
