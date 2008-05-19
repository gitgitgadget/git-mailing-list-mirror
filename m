From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [SQUASHED PATCH] Add support for GIT_CEILING_DIRECTORIES
Date: Mon, 19 May 2008 11:49:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805191138210.30431@racer>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer> <alpine.DEB.1.00.0805152055280.30431@racer> <482CA693.3060602@facebook.com> <alpine.DEB.1.00.0805152327440.30431@racer> <482CBCF2.6030202@facebook.com>
 <alpine.DEB.1.00.0805160012310.30431@racer> <482D2F9D.4080809@viscovery.net> <alpine.DEB.1.00.0805161118160.30431@racer> <482D66DC.30602@viscovery.net> <482DC7B6.1080406@facebook.com> <alpine.DEB.1.00.0805170117000.30431@racer>
 <48313258.5010208@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Reiss <dreiss@facebook.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 19 12:50:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy2wy-0001Vh-J5
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 12:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647AbYESKtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 06:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755728AbYESKtt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 06:49:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:46070 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755574AbYESKts (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 06:49:48 -0400
Received: (qmail invoked by alias); 19 May 2008 10:49:46 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp008) with SMTP; 19 May 2008 12:49:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WZAdBMQsWhJ4NHfU7pZZnv7lSajvikAu4yZv9cV
	Y1s/f4602B5jY6
X-X-Sender: gene099@racer
In-Reply-To: <48313258.5010208@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82425>

Hi,

On Mon, 19 May 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
>
> > diff --git a/setup.c b/setup.c
> > index cece3e4..2f7a17a 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -441,6 +441,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
> >  	 */
> >  	offset = len = strlen(cwd);
> >  	for (;;) {
> > +		if (offset <= min_offset)
> > +			goto non_git;
> >  		gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
> >  		if (gitfile_dir) {
> >  			if (set_git_dir(gitfile_dir))
> > @@ -460,6 +462,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
> >  		chdir("..");
> >  		do {
> >  			if (offset <= min_offset) {
> > +non_git:
> >  				if (nongit_ok) {
> >  					if (chdir(cwd))
> >  						die("Cannot come back to cwd");
> 
> Hmm... If the implementation needs a 'goto', then I have the strong
> suspicion that there's already something wrong at the concept level.

I do not share the notion that "goto" = BAD.

> [That said, I'm not in strong support of this feature in general - I'm 
> just caring because *if* it goes in, it will have conflicts with the 
> mingw branch.]

I am not in support of this feature at all, since I do not need it.

However, I saw that David needs it, but I did not agree with the way he 
implemented his patch.  So I tried to show how it is possible to do it in 
a way that looks simpler to me.

Now the ball is back in David's field: he can just take my patch, mangle 
it until it does what he wants, and resubmit.  That said, if the result 
offends my eye again, I will complain again.

Ciao,
Dscho
