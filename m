From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 14/21] Add proper parsing of "tagger" line, but only when
 thorough_verify is set
Date: Sun, 10 Jun 2007 09:52:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100945290.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net> <200706090210.36270.johan@herland.net>
 <200706090218.41941.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJCe-0006g0-T7
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbXFJIzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbXFJIzP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:55:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:52860 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751273AbXFJIzO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:55:14 -0400
Received: (qmail invoked by alias); 10 Jun 2007 08:55:12 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp041) with SMTP; 10 Jun 2007 10:55:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CHpFeD6NCku0k12wONfFIUEd/rzgpQiJbrcI073
	XwoATIDhuO5jX8
X-X-Sender: gene099@racer.site
In-Reply-To: <200706090218.41941.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49687>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> Be explicit about the fact that the "tagger" line is now considered a 
> mandatory part of the tag object. There are however old tags (from 
> before July 2005) that don't have a "tagger" line. We therefore consider 
> the "tagger" line _optional_ when parsing tags without thorough_verify 
> set.

No. The "before July 2005" part is _not_ the reason that we consider this 
line optional.

The fact that it is bad to fail on a fetch, just because you happen to 
have an invalid tag in your repository, is a good reason not to.

The fact that it is bad to fail on a git branch, just because you happen 
to have an invalid tag in your repository, is a good reason not to.

The fact that it is bad to fail on an fsck, just because you happen to 
have an invalid tag in your repository, is a good reason not to.

And yes, if I remember correctly, your original patch did exactly that.

The paradigm to follow is: fail gracefully. I could have an invalid 
_commit_ in my repository, and would still want _every_ Git operation to 
succeed, _as long_ as it does not touch that bad object.

And I damned well want git-fsck to not crash, just because some 
assumptions are made.

Since this is a fundamental critique on your patch series, I will do the 
detailed review on _this_ patch in another mail.

Ciao,
Dscho
