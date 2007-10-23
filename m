From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else fails.
Date: Tue, 23 Oct 2007 00:34:05 -0400
Message-ID: <20071023043405.GA14735@spearce.org>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net> <Pine.LNX.4.64.0710202258440.25221@racer.site> <20071021023614.GB14735@spearce.org> <Pine.LNX.4.64.0710212256270.25221@racer.site> <20071022042110.GJ14735@spearce.org> <Pine.LNX.4.64.0710221135100.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Parish <sRp@srparish.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:34:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkBTD-0001FR-J2
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbXJWEeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbXJWEeL
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:34:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39357 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbXJWEeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:34:10 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkBSy-0001Md-2I; Tue, 23 Oct 2007 00:34:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5A6AA20FBAE; Tue, 23 Oct 2007 00:34:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710221135100.25221@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62087>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 22 Oct 2007, Shawn O. Pearce wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Earlier, we tried to find the git commands in several possible exec
> > > dirs.  Now, if all of these failed, try to find the git command in
> > > PATH.
> > ...
> > > diff --git a/exec_cmd.c b/exec_cmd.c
> > > index 9b74ed2..70b84b0 100644
> > > --- a/exec_cmd.c
> > > +++ b/exec_cmd.c
> > > @@ -36,7 +36,8 @@ int execv_git_cmd(const char **argv)
> > >  	int i;
> > >  	const char *paths[] = { current_exec_path,
> > >  				getenv(EXEC_PATH_ENVIRONMENT),
> > > -				builtin_exec_path };
> > > +				builtin_exec_path,
> > > +				"" };
> > 
> > So if the user sets GIT_EXEC_PATH="" and exports it we'll search $PATH 
> > before the builtin exec path that Git was compiled with? Are we sure we 
> > want to do that?
> 
> I thought the proper way to unset EXEC_PATH was to "unset GIT_EXEC_PATH".  
> In that case, getenv(EXEC_PATH_ENVIRONMENT) returns NULL and we're fine, 
> no?

Sure.  But can't you also export an environment variable that is
set to the empty string?  At least on UNIX.  Windows thinks unset
and empty string are the same thing.

-- 
Shawn.
