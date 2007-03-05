From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Tue, 6 Mar 2007 00:09:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703052359440.13683@wbgn013.biozentrum.uni-wuerzburg.de>
References: <esgm1m$33f$1@sea.gmane.org>
 <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EC3905.7070406@lu.unisi.ch> <Pine.LNX.4.63.0703051648330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EC4B55.3090505@lu.unisi.ch> <Pine.LNX.4.63.0703051812030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EC51C6.5080505@lu.unisi.ch> <Pine.LNX.4.63.0703051930560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EC8959.1090303@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Tue Mar 06 00:10:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOMK5-0006Lu-P0
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 00:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbXCEXKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 18:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbXCEXKF
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 18:10:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:34310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752251AbXCEXJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 18:09:46 -0500
Received: (qmail invoked by alias); 05 Mar 2007 23:09:45 -0000
X-Provags-ID: V01U2FsdGVkX18GtjBpLGsGEgC40kOvy7dAWu61F8CNHlHLPvWeAX
	JhI0IEq+hKfNMG
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45EC8959.1090303@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41500>

Hi,

On Mon, 5 Mar 2007, Paolo Bonzini wrote:

> > Yes, this is what the source does. But again, the return value is what 
> > you should -- and indeed forever can -- rely on. I am not really happy 
> > that dwim_ref() touches ref, even if nothing was found, but it is an 
> > _implementation detail_.
> 
> It's not fair to not have any documentation in the code, force the 
> contributor to reverse engineer the documentation, and say it is relying 
> on an implementation detail.  In otherwise undocumented code, 
> implementation == interface.

Ah, sorry. The "return 0 on success, other values mean different sorts of 
errors" concept is so ubiquituous in Unix-like systems, that nobody 
bothered documenting that.

Actually, we usually use "-1" to mean error, and depending on the function 
have different meanings for ">0".

But the best documentation for a function is actually the code using it, 
and I thought that you had a look at them. Very often, I do "git grep bla" 
to see where the function called "bla()" was used. For me, examples are 
worth a thousand man pages...

A supplemental remark on the sscanf() thing: when I was forced to work on 
Windows, I made it a habit not to rely on specs. So often, things just did 
not work as described, and complaining did not help. For example, we had 
to throw out _all_ uses of templates in a certain project, because the C 
compiler would choke with an internal error.

So, my hesitation regarding sscanf() stems mainly from the fact that it 
appears rarely used to me, and such constructs are more likely to break 
expectations when trying to port to different architectures.

And _that_ is why I do not hesitate using printf(): it is much more likely 
that an incompatibility in printf() is fixed, whereas with sscanf() it 
will likely end up worked-around all the time instead of being fixed.

Ciao,
Dscho
