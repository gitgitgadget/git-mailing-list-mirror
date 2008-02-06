From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase -i and --whitespace, was Re: [PATCH] git-rebase.sh: Update
 USAGE string (No. 1)
Date: Wed, 6 Feb 2008 01:00:29 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802060058550.8543@racer.site>
References: <m3lk6161jo.fsf@localhost.localdomain> <200802041113.m14BDLMl004301@mi1.bluebottle.com> <alpine.LSU.1.00.0802041505230.7372@racer.site> <200802041642.52088.jnareb@gmail.com> <7vir137yvx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, Jari Aalto <jari.aalto@cante.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 02:01:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYfX-0008HX-Tj
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 02:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758656AbYBFBBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 20:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757774AbYBFBBL
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 20:01:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:33044 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757397AbYBFBBK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 20:01:10 -0500
Received: (qmail invoked by alias); 06 Feb 2008 01:01:09 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp034) with SMTP; 06 Feb 2008 02:01:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LWKwMeGiLSJEaTVAOcpajxlAkdNpE0VJvk1iHBH
	xFH8FjNUR130J/
X-X-Sender: gene099@racer.site
In-Reply-To: <7vir137yvx.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72738>

Hi,

On Tue, 5 Feb 2008, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > So it means that synopsis should, instead of current (pre-patch)
> >
> > 'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
> >         [-C<n>] [ --whitespace=<option>] [-p | --preserve-merges]
> >         [--onto <newbase>] <upstream> [<branch>]
> >
> > should read
> >
> > 'git-rebase' [-v | --verbose]  [-p | --preserve-merges]
> >         [{-i | --interactive} | [-C<n>] [ --whitespace=<option>] [-m | --merge]]
> >         [--onto <newbase>] <upstream> [<branch>]
> >
> > or perhaps even separated into interactive / non-interactive merge?
> 
> I think the reality is:
> 
>  * -i ignores the lack of -m (i.e. do not use the slow "merge");
> 
>  * Rebase with -m cannot use -C<n> and --whitespace (hence -i
>    because it forces -m);
> 
>  * -p is only meaningful when using -m;

Even worse, AFAIR -p only works with -i.

> Three possible courses of actions are:
> 
>  (1) fix merge codepath (this is involved --- we would need to
>      teach xdl_merge() to honor --whitespace={warn|error|fix}
>      and -C<n>); or
> 
>  (2) fix -i so that it does not force -m; or
> 
>  (3) adjust the description to reality.
> 
> Obviously the easiest would be to document the behaviour as-is,
> but I suspect (2) would be the best practical solution if we
> wanted to have any improvement compared to the current
> situation.

Granted.  A long time ago, I started making a builtin from rebase/am, but 
I got sidetracked pretty early.

However, I think that (2) and builtinification are pretty related, and can 
be done in one go.

Ciao,
Dscho
