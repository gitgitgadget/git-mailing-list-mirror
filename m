From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] t7004 (master) busted on Leopard
Date: Thu, 15 Nov 2007 14:37:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711151434060.30886@racer.site>
References: <17E3F66C-4644-4B64-817C-88062727A2D9@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 15:38:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsfrO-00079e-72
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 15:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757693AbXKOOiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 09:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756934AbXKOOiK
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 09:38:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:42348 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756683AbXKOOiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 09:38:09 -0500
Received: (qmail invoked by alias); 15 Nov 2007 14:38:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 15 Nov 2007 15:38:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2hJJSOqu2sDow3UJQWSMUvlL1WAokAvQe/YP6+8
	ZM54OVrOR7YhYg
X-X-Sender: gene099@racer.site
In-Reply-To: <17E3F66C-4644-4B64-817C-88062727A2D9@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65124>

Hi,

On Thu, 15 Nov 2007, Wincent Colaiuta wrote:

> Commit 4d8b1dc850 added a couple of tests to t7004, and my testing reveals
> that this one has been broken on Leopard since then:
> 
> * FAIL 83: message in editor has initial comment
> GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
> test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0

I think this is our good old friend, MacOSX' sed.  (Wasn't there a 
question today what's wrong with using sed?  I think this issue 
qualifies.)

I imagine that it is that MacOSX' sed is adding a trailing newline (not 
the regexp like you suggested).  Which means that "wc -l" would print "1".  
(You can see for yourself if you run the script with "sh -x ...".)

IMHO a good solution would be

	test -z "$(grep -e '^#' -e '^$' actual)"

Could you test, please?

Thanks,
Dscho
