From: Pavel Roskin <proski@gnu.org>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 07 May 2006 21:21:40 -0400
Message-ID: <1147051300.17371.32.camel@dv>
References: <1147037659.25090.25.camel@dv>
	 <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	 <Pine.LNX.4.64.0605071718440.3718@g5.osdl.org>
	 <Pine.LNX.4.63.0605080303410.13588@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 08 03:21:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcuRX-0004SK-DC
	for gcvg-git@gmane.org; Mon, 08 May 2006 03:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWEHBVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 21:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWEHBVo
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 21:21:44 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:36793 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932242AbWEHBVo
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 May 2006 21:21:44 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FcuRT-0000zG-KL
	for git@vger.kernel.org; Sun, 07 May 2006 21:21:43 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FcuRQ-0007yv-Sj; Sun, 07 May 2006 21:21:40 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605080303410.13588@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19741>

Hello, Johannes!

On Mon, 2006-05-08 at 03:05 +0200, Johannes Schindelin wrote:
> The ["blablabla"] syntax fails the is-it-obvious-what-this-does test. What 
> *is* wrong with the " for " syntax? IIRC it was even proposed by you, and 
> it happens to be backward compatible.

Not trying to answer for Linus, here's my take.

The "for" syntax is one more layer in the config hierarchy.  Adding
another layer is a more intrusive solution than relaxing the syntax of
the existing elements without changing their semantic.

git-repo-config is "for" agnostic.  It doesn't parse "for" (as far as I
know).

"for" can be confusing in some contexts, or may force inversion of the
hierarchy to make the config file more readable.  How would you
implement branch descriptions?  See this:

[branchdata]
description = "netdev" for "Network device development"

and this

[branchdata]
description = "Network device development" for "netdev"

The later is closer to English.  Or should we use the first approach and
"is" instead of "for"?

Now, how can I get a description for the "netdev" branch by one
git-repo-config command, without pipes?

-- 
Regards,
Pavel Roskin
