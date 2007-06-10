From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 15/21] Make tag names (i.e. the tag object's "tag" line)
 optional
Date: Sun, 10 Jun 2007 10:07:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706101004440.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net> <200706090210.36270.johan@herland.net>
 <200706090219.12011.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:10:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJRR-0008Ol-TF
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbXFJJKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 05:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXFJJKd
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:10:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:51506 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751975AbXFJJKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:10:32 -0400
Received: (qmail invoked by alias); 10 Jun 2007 09:10:31 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp021) with SMTP; 10 Jun 2007 11:10:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jAdhM0hCj1Tr3DhtpDV/1z5Rw5VsVlNiPSFSywX
	X5c6MlizHCrP4u
X-X-Sender: gene099@racer.site
In-Reply-To: <200706090219.12011.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49693>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> The tag line is now optional. If not given in the tag object data, it
> defaults to the empty string ("") in the parsed tag object.
> 
> The patch also adds a change to git-show; when asked to display a tag
> object with no name (missing "tag" header), we will show the tag's sha1
> instead of an empty string.
> 
> Finally the patch includes some tweaks to the selftests to make them 
> work with optional tag names.

If you don't actually _test_ missing tag names, you might just as well 
leave the tests alone.

> -					t->tag,
> +					*(t->tag) ? t->tag : name,

This is misleading. What you wanted to say is t->tag[0] == '\0', or 
*(t->tag) == '\0'.

As you wrote it, you have to think a couple of times why it is okay to 
dereference t->tag, to check if you say t->tag.

Besides, it breaks if you _do_ have an empty tag. In that case, I _want_ 
to see that it is actually empty, and _not_ the SHA1 substituted for it.

Ciao,
Dscho
