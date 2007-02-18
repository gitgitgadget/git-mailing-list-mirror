From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sun, 18 Feb 2007 01:40:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180135240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180107250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqjsqpgs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 01:41:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIa6s-0002pF-A2
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 01:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965469AbXBRAkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 19:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965472AbXBRAkx
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 19:40:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:35332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965469AbXBRAkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 19:40:53 -0500
Received: (qmail invoked by alias); 18 Feb 2007 00:40:51 -0000
X-Provags-ID: V01U2FsdGVkX18rrutGzqMrSjIiZGcOq3WyYr0sGFJDPezEo0Fj4/
	77+A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vbqjsqpgs.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40040>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > If I read this correctly, running 'git apply' inside a git repository
> >> > will parse $GIT_DIR/config and $HOME/.gitconfig. However, outside of a
> >> > repository it will parse neither. It would make more sense to me to
> >> > still parse $HOME/.gitconfig to pick up the user's global options.
> >> 
> >> I thought about that, but decided against it.  If you are truly
> >> operating outside a git managed repository, it does not feel
> >> right to apply configuration user has for git.
> >
> > That is a good point. But in the same vein, why not have a flag to 
> > git-apply, and let it ignore the configuration altogether?
> 
> Do you mean --whitespace=strip option from the command line?

I meant something like 
"--whitespace=I-know-the-patch-is-sane-but-lets-add-cr-to-all-lfs".

> But I think Jeff is right.  It would make sense to let apply
> and perhaps 'diff', if we can somehow merge 'diff2' into it,
> still read from $HOME/.gitconfig if available.

Yes, especially if you are soo used to colours as I grew to be used to 
them. This was literally one of the reasons I wrote diff2 in the first 
place. Another was --color-words.

BTW any good ideas how to make diff fall back to diff2, so that no similar 
case falls back to diff-index?

I am really wondering if you can have a syntax which Does The Right Thing 
at all times. Maybe we can teach diff that exactly two arguments, which 
both exist in the filesystem, and at least one of them is not tracked, 
then please use diff2? I wonder how often you do something like

	git diff object.c object-refs.c

and how confusing it would be that it could mean two things, diff2 _and_ 
diff-index?

Ciao,
Dscho
