From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else fails.
Date: Mon, 22 Oct 2007 11:35:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221135100.25221@racer.site>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net>
 <Pine.LNX.4.64.0710202258440.25221@racer.site> <20071021023614.GB14735@spearce.org>
 <Pine.LNX.4.64.0710212256270.25221@racer.site> <20071022042110.GJ14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Parish <sRp@srparish.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 12:36:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijudz-0008Ie-5y
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 12:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbXJVKgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 06:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbXJVKgM
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 06:36:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:47857 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751120AbXJVKgL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 06:36:11 -0400
Received: (qmail invoked by alias); 22 Oct 2007 10:36:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 22 Oct 2007 12:36:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187e1Z5jPY7b2/g5AhRFkEEb8822TY/Kw7QynW/Bs
	bJmdba/NiMSil4
X-X-Sender: gene099@racer.site
In-Reply-To: <20071022042110.GJ14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61983>

Hi,

On Mon, 22 Oct 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Earlier, we tried to find the git commands in several possible exec
> > dirs.  Now, if all of these failed, try to find the git command in
> > PATH.
> ...
> > diff --git a/exec_cmd.c b/exec_cmd.c
> > index 9b74ed2..70b84b0 100644
> > --- a/exec_cmd.c
> > +++ b/exec_cmd.c
> > @@ -36,7 +36,8 @@ int execv_git_cmd(const char **argv)
> >  	int i;
> >  	const char *paths[] = { current_exec_path,
> >  				getenv(EXEC_PATH_ENVIRONMENT),
> > -				builtin_exec_path };
> > +				builtin_exec_path,
> > +				"" };
> 
> So if the user sets GIT_EXEC_PATH="" and exports it we'll search $PATH 
> before the builtin exec path that Git was compiled with? Are we sure we 
> want to do that?

I thought the proper way to unset EXEC_PATH was to "unset GIT_EXEC_PATH".  
In that case, getenv(EXEC_PATH_ENVIRONMENT) returns NULL and we're fine, 
no?

Ciao,
Dscho
