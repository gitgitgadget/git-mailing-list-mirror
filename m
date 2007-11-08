From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-checkout: Handle relative paths containing "..".
Date: Thu, 8 Nov 2007 14:25:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081420570.4362@racer.site>
References: <1194489192-20021-1-git-send-email-dsymonds@gmail.com> 
 <7v4pfx3zs3.fsf@gitster.siamese.dyndns.org> <ee77f5c20711080510i138729b9vb0b9ad485cb2db3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 15:25:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq8KI-0005xg-M9
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 15:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758302AbXKHOZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 09:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756982AbXKHOZY
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 09:25:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:40504 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753742AbXKHOZY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 09:25:24 -0500
Received: (qmail invoked by alias); 08 Nov 2007 14:25:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 08 Nov 2007 15:25:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9AgtN2WX9WiYoqXex/EMXDnTjCwlJWnUtjfbeuQ
	ICHpLd7ATuh1Sl
X-X-Sender: gene099@racer.site
In-Reply-To: <ee77f5c20711080510i138729b9vb0b9ad485cb2db3@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64028>

Hi,

On Fri, 9 Nov 2007, David Symonds wrote:

> On Nov 8, 2007 7:30 PM, Junio C Hamano <junio@pobox.com> wrote:
> >
> > Have you tested this patch from the toplevel of any tree, where
> > "git-rev-parse --show-cdup" would yield an empty string?
> 
> No, I didn't. Arguably, "git-rev-parse --show-cdup" should always return 
> a path to the top-level, which would make this kind of construction much 
> simpler.

As it is, we have a convenience function for this, to make it much 
simpler: cd_to_toplevel in git-sh-setup.

> > I also wonder how this patch (with an obvious fix to address the above 
> > point) would interact with GIT_DIR and/or GIT_WORK_TREE in the 
> > environment.
> 
> No idea. I'm still learning my way around the git codebase, so I was
> hoping for some review and feedback from more experienced Gits.

It _should_ work with GIT_DIR/GIT_WORK_TREE, as the full name is relative 
to the project root, and that's exactly where cd_to_toplevel is jumping 
to.  And the first call to ls-files should make certain that the paths are 
correct, so there should be no confusion either.

But yes, I have been burnt by that work tree stuff too many times, so I'd 
appreciate tests for that (both positive and negative ones).

Ciao,
Dscho
