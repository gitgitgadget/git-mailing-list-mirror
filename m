From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git rebase -i failing on cygwin -- git checkout-index says File
 Exists
Date: Tue, 20 Jan 2009 22:16:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901202212470.3586@pacific.mpi-cbg.de>
References: <4285cd450901201209i792195dfmdec1fb14d627b25e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ludvig Strigeus <strigeus@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 23:17:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPOuq-0005H3-3v
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 23:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760968AbZATWQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 17:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753814AbZATWQ0
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 17:16:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:34133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756076AbZATWQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 17:16:25 -0500
Received: (qmail invoked by alias); 20 Jan 2009 21:16:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 20 Jan 2009 22:16:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Mk6U/vbWMQ04M1LUEDD0Kdm+ayieaCYu5gE3+l2
	R60tRQbyha5POk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4285cd450901201209i792195dfmdec1fb14d627b25e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106531>

Hi,

On Tue, 20 Jan 2009, Ludvig Strigeus wrote:

> I'm having some weird problem with Git on Cygwin on Windows XP. I start 
> with a totally clean repo, and then run interactive rebase to edit a 
> historical commit. I exit the editor without doing anything (I get 
> similar issues if I modify stuff inside the editor).
> 
> $ git st
> # On branch master
> nothing to commit (working directory clean)
> 
> $ git rebase -i 4a1552c81b622f85b0e9170c6fd7a22b4a3e633c
> error: git checkout-index: unable to create file util/stringfuncs.cpp
> (File exists)

This is the error that should stop the whole thing.

> fatal: Could not reset index file to revision '4965936'.
> error: Entry 'util/boink-py.cc' not uptodate. Cannot merge.
> fatal: merging of trees 0c27b10e163f00655486976896d096302b0f5c21 and
> 7c7dfd93d678cfc564649738d45260e0b5d9f5a7 failed
> Could not apply d9c7ac9... Various reorganizations.

But here, it should not have continued.

Having said that, I often had that case with interactive rebase, because 
I had an untracked file lying around (in your case util/stringfuncs.cpp) 
that was tracked in the version I was trying to rebase onto, but it 
stopped right there, even on msysGit.

Hopefully you can investigate the scenario more, by "git rebase --abort", 
and then running the rebase -i again, but with GIT_TRACE=1.

Ciao,
Dscho
