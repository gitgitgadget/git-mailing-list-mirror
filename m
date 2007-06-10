From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Comment on weak refs
Date: Sun, 10 Jun 2007 07:33:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100716480.4059@racer.site>
References: <200706040251.05286.johan@herland.net> <200706092019.13185.johan@herland.net>
 <7vk5ucd6of.fsf_-_@assigned-by-dhcp.cox.net> <200706100325.32846.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 08:37:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxH2x-0007vr-J2
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 08:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758251AbXFJGgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 02:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758724AbXFJGgl
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 02:36:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:52970 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758271AbXFJGgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 02:36:40 -0400
Received: (qmail invoked by alias); 10 Jun 2007 06:36:39 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp046) with SMTP; 10 Jun 2007 08:36:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189fwhWgtE9H2USnUHqfEmiUmqCcyU1j5r05XB42R
	g/FmpzlC6xEkIa
X-X-Sender: gene099@racer.site
In-Reply-To: <200706100325.32846.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49654>

Hi,

On Sun, 10 Jun 2007, Johan Herland wrote:

> On Sunday 10 June 2007, Junio C Hamano wrote:
>
> > Maybe you first think A and B are related and then later change your 
> > mind.  Should "softref" relationships be versioned?
> 
> Intriguing idea. Not immediately sure how we would implement it 
> though...

Has my lightweight annotation patch reached you?

I like my approach better than yours, because it is

1) a way, way smaller patch, and
2) it automatically includes the versionability.

After thinking about it a little more (my plane was slow, and as a result 
I am allowed to spend 8 more hours in Paris), I think that a small but 
crucial change would make this thing even more useful:

Instead of having "core.showAnnotations" be a boolean config, it might be 
better to have "core.annotationsRef" instead, overrideable by the 
environment variable GIT_ANNOTATION_REF.

With this, you can have different refs for different kinds of annotations.

For example, some people might add bugtracker comments (even comments like 
"this commit was bad: introduced bug #798, solved by commit 9899fdadc.."). 
Those comments could live in refs/annotations/bugs. To see them, just say 

	GIT_ANNOTATION_REF=refs/annotations/bugs gitk

Voila.

I am quite certain that treating annotations as branches, containing 
fan-out directories for the reverse lookup. I am even quite certain that 
in most cases, a working-directory-less merging is possible for such 
annotations.

Ciao,
Dscho
