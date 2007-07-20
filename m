From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-submodule fixes for call to git config --get-regexp
Date: Fri, 20 Jul 2007 19:36:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707201933360.14781@racer.site>
References: <b6ebd0a50707201023h12ed3c61v31ccb2b356c1ee42@mail.gmail.com>
 <7vsl7jvthk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Larson <clarson@kergoth.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 20:36:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBxLV-0001ro-H9
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 20:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759975AbXGTSgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 14:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758386AbXGTSgy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 14:36:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:49394 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757576AbXGTSgx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 14:36:53 -0400
Received: (qmail invoked by alias); 20 Jul 2007 18:36:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 20 Jul 2007 20:36:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fAq8pvuWfskPS3GGrxZnWQpbDtbPuwDiSAEdNjv
	AxEcZ7jNUQpT2m
X-X-Sender: gene099@racer.site
In-Reply-To: <7vsl7jvthk.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53111>

Hi,

On Fri, 20 Jul 2007, Junio C Hamano wrote:

> "Chris Larson" <clarson@kergoth.com> writes:
> 
> > +       name=$(GIT_CONFIG=.gitmodules git config --get-regexp
> > '^submodule\..*\.path$' "^$path$" |
> >        sed -nre 's/^submodule\.(.+)\.path .+$/\1/p')

I wonder why it is a regular expression to begin with, since we seem to 
prefer shell patterns on paths.

However, _if_ we already go with regexps, why not just put it into the 
"sed" call, which is _already_ there, and leave "git config" alone?  IOW 
call

	git config --get-regexp '^submodule\..*\.path$' |
		sed -nre 's/^submodule\.(.*$path.*)\.path .+$\1/p'

Hmm?

Ciao,
Dscho
