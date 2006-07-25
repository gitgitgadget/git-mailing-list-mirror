From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow an alias to start with "-p"
Date: Tue, 25 Jul 2006 08:18:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607250813450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607190125150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xmjh5sv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607241408170.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060725050312.GA5618@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 08:19:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5GFq-0008NG-HT
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 08:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWGYGSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 02:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGYGSs
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 02:18:48 -0400
Received: from mail.gmx.de ([213.165.64.21]:1222 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751440AbWGYGSs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 02:18:48 -0400
Received: (qmail invoked by alias); 25 Jul 2006 06:18:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 25 Jul 2006 08:18:46 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jeff King <peff@peff.net>
In-Reply-To: <20060725050312.GA5618@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24159>

Hi,

On Tue, 25 Jul 2006, Jeff King wrote:

> On Mon, Jul 24, 2006 at 02:10:45PM +0200, Johannes Schindelin wrote:
> 
> > @@ -264,6 +289,7 @@ int main(int argc, const char **argv, ch
> >  	if (!strncmp(cmd, "git-", 4)) {
> >  		cmd += 4;
> >  		argv[0] = cmd;
> > +		handle_alias(&argc, &argv);
> >  		handle_internal_command(argc, argv, envp);
> >  		die("cannot handle %s internally", cmd);
> >  	}

My fault. This was a left-over from my original alias patch. (I did a 
merge, and just used "git-diff next" instead of "git-diff --merge next". 
<Clickety-click/> Nope, that would not have worked either.

> Patch is below (wow, that +++ is kind of ugly!).

Same here.

> git: choose internal commands over aliases for git-*
> 
> This is especially important because some commands (like init-db) don't
> require a working GIT_DIR, and alias expansion tries to look at it. It
> also matches the behavior of "git cmd".
> 
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

> @@ -289,8 +289,8 @@ int main(int argc, const char **argv, ch
>  	if (!strncmp(cmd, "git-", 4)) {
>  		cmd += 4;
>  		argv[0] = cmd;
> -		handle_alias(&argc, &argv);
>  		handle_internal_command(argc, argv, envp);
> +		handle_alias(&argc, &argv);
>  		die("cannot handle %s internally", cmd);
>  	}

Alternatively, you can just delete it. IIRC we decided that aliases with 
"git-" commands do not make sense.

Ciao,
Dscho
