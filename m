From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase -i and --whitespace, was Re: [PATCH] git-rebase.sh: Update
 USAGE string (No. 1)
Date: Mon, 4 Feb 2008 16:32:11 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041629140.7372@racer.site>
References: <m3lk6161jo.fsf@localhost.localdomain> <200802041113.m14BDLMl004301@mi1.bluebottle.com> <alpine.LSU.1.00.0802041505230.7372@racer.site> <200802041642.52088.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1994806315-1202142734=:7372"
Cc: =?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, Jari Aalto <jari.aalto@cante.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:33:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM4GB-0002BI-Ia
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 17:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbYBDQcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 11:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbYBDQcw
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 11:32:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:56666 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751162AbYBDQcv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 11:32:51 -0500
Received: (qmail invoked by alias); 04 Feb 2008 16:32:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 04 Feb 2008 17:32:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cg+8ghBzc/33jzYiXzH/3oaO1vDXMf1CjJQtUFp
	sOT5VRwzaTZI8/
X-X-Sender: gene099@racer.site
In-Reply-To: <200802041642.52088.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72520>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1994806315-1202142734=:7372
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 4 Feb 2008, Jakub Narebski wrote:

> W poniedziałek 4. lutego 2008 16:06, Johannes Schindelin napisał:
> > On Mon, 4 Feb 2008, しらいしななこ wrote:
> > 
> > > I tried to run "git rebase --interactive --whitespace=strip" but it does 
> > > not seem to strip blank characters at the end of my lines.  Did I find a 
> > > bug?
> > 
> > Yes.  Interactive rebase never bothered with --whitespace options, since 
> > it works purely with cherry-pick (the --merge option to non-interactive 
> > rebase).  Therefore, the operation is not patch based, and does not call 
> > git-apply at all (which would handle the whitespace).
> 
> So it means that synopsis should, instead of current (pre-patch)
> 
> 'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
>         [-C<n>] [ --whitespace=<option>] [-p | --preserve-merges]
>         [--onto <newbase>] <upstream> [<branch>]
> 
> should read
> 
> 'git-rebase' [-v | --verbose]  [-p | --preserve-merges]
>         [{-i | --interactive} | [-C<n>] [ --whitespace=<option>] [-m | --merge]]
>         [--onto <newbase>] <upstream> [<branch>]
> 
> or perhaps even separated into interactive / non-interactive merge?

Or the --merge code path should check if there was any --whitespace 
option, and re-apply each commit using something like

	git reset --hard HEAD^ &&
	git diff-tree HEAD@{1}..HEAD |
	git apply --index <whitespace options>

Ciao,
Dscho

---1463811741-1994806315-1202142734=:7372--
