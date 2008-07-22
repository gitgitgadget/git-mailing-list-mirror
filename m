From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Tue, 22 Jul 2008 22:44:50 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807222242160.8986@racer>
References: <alpine.DEB.1.00.0807222100150.8986@racer> <20080722203730.GC5113@blimp.local> <20080722210354.GD5113@blimp.local> <alpine.DEB.1.00.0807222207110.8986@racer> <20080722212633.GF5113@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPg6-0002MW-6i
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbYGVVov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYGVVov
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:44:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:55754 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750855AbYGVVou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:44:50 -0400
Received: (qmail invoked by alias); 22 Jul 2008 21:44:48 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp015) with SMTP; 22 Jul 2008 23:44:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WZZZ+797W/f5d8z4dpe6U8Jari0pCd9ZJWJhkkp
	Gk+t2847xcFmED
X-X-Sender: gene099@racer
In-Reply-To: <20080722212633.GF5113@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89547>

Hi,

On Tue, 22 Jul 2008, Alex Riesen wrote:

> @@ -704,9 +707,10 @@ const char *help_unknown_cmd(const char *cmd)
>  
>  	if (!main_cmds.cnt)
>  		die ("Uh oh.  Your system reports no Git commands at all.");
> +	git_config(git_help_config, NULL);
>  	best_similarity = similarity(main_cmds.names[0]->name);
> -	if (main_cmds.cnt < 2 || best_similarity <
> -			similarity(main_cmds.names[1]->name)) {
> +	if (autocorrect && (main_cmds.cnt < 2 ||
> +		best_similarity < similarity(main_cmds.names[1]->name))) {
>  		if (!*cwd)
>  			exit(1);
>  		if (chdir(cwd))

This "if" already checks if there is only one candidate.  So you should 
just add an inner "if (autocorrect) ... else single = 1;" or some such.

However, I think that the intention of this patch is too much DWIMery, 
which might be good for me (just like my "git add remote" patch), but not 
for the general audience.

Ciao,
Dscho
