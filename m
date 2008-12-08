From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Mon, 8 Dec 2008 19:13:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812081911550.7516@eeepc-johanness>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com> <492D7CF5.1020202@drmicha.warpmail.net> <alpine.DEB.1.00.0811261804550.30769@pacific.mpi-cbg.de> <200812071425.52908.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Ondrej Certik <ondrej@certik.cz>,
	Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 19:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9kc3-0005R1-8L
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 19:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbYLHSM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 13:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbYLHSM0
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 13:12:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:40129 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750710AbYLHSMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 13:12:25 -0500
Received: (qmail invoked by alias); 08 Dec 2008 18:12:20 -0000
Received: from ini-firewall.unizh.ch (EHLO eeepc-johanness.lan.ini.uzh.ch) [130.60.5.218]
  by mail.gmx.net (mp056) with SMTP; 08 Dec 2008 19:12:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0v9V4M3T0G+3vMCWSJkuiUZu5lhKXiuial+3Kvh
	wx1+/ls+wJgEo0
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200812071425.52908.angavrilov@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102569>

Hi,

On Sun, 7 Dec 2008, Alexander Gavrilov wrote:

> On Wednesday 26 November 2008 20:08:54 Johannes Schindelin wrote:
> > On Wed, 26 Nov 2008, Michael J Gruber wrote:
> > > Looking at the source I suspect that fast-export fails to denote 
> > > parenthood in the case of yet unmarked parents (last for-loop of 
> > > handle_commit() in builtin_fast_export.c). But I don't really know 
> > > that code at all.
> > 
> > I strongly doubt so.  Noticed the use of has_unshown_parent(commit) in 
> > both cases before calling handle_commit()?
> > 
> > In any case, here is a script that I wrote _long_ time ago, to be able 
> > to reconstruct history from the output of "git rev-list --all 
> > --parents".  Maybe this helps you in reconstructing something that is 
> > handled incorrectly by fast-export | fast-import, but is lighter than 
> > a full-blown repository.
> 
> Today I had time to investigate this problem, and found:
> 
> 1) The root of the problem is that fast-export really wants to walk
>     revisions in topological order, but actually receives them in date
>     order.

Indeed.  Can you submit this patch with a proper commit message, adding a 
test for the issue by setting a bogus GIT_COMMITTER_DATE explicitly?

Thanks,
Dscho
