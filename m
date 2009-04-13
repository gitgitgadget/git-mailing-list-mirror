From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-add: introduce --edit (to edit the diff vs. the 
 index)
Date: Mon, 13 Apr 2009 18:21:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904131820260.10279@pacific.mpi-cbg.de>
References: <cover.1239225986u.git.johannes.schindelin@gmx.de>  <61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de>  <46dff0320904081900n7bff2280rc49315e3db427919@mail.gmail.com>  <46dff0320904091843p3e034647j3c78506b4d0c2b4@mail.gmail.com>
  <alpine.DEB.1.00.0904102009440.10279@pacific.mpi-cbg.de> <46dff0320904101811g3b5dcc8ag195d40005b181c52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1652074626-1239639679=:10279"
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 18:22:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtOtG-0004uo-Ad
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 18:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbZDMQSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 12:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbZDMQSg
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 12:18:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:44118 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752626AbZDMQSg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 12:18:36 -0400
Received: (qmail invoked by alias); 13 Apr 2009 16:18:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 13 Apr 2009 18:18:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ja2V3AUMJn048KH4WdEVdt8hsTeT+5tIlvbJ6/2
	Rjcvn50MwxBdy1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <46dff0320904101811g3b5dcc8ag195d40005b181c52@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116446>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1652074626-1239639679=:10279
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 11 Apr 2009, Ping Yin wrote:

> On Sat, Apr 11, 2009 at 2:10 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Fri, 10 Apr 2009, Ping Yin wrote:
> >
> >> On Thu, Apr 9, 2009 at 10:00 AM, Ping Yin <pkufranky@gmail.com> wrote:
> >> > On Thu, Apr 9, 2009 at 5:30 AM, Johannes Schindelin
> >> > <johannes.schindelin@gmx.de> wrote:
> >> >> With "git add -e [<files>]", Git will fire up an editor with the 
> >> >> current diff relative to the index (i.e. what you would get with 
> >> >> "git diff [<files>]").
> >> >>
> >> >> Now you can edit the patch as much as you like, including 
> >> >> adding/removing lines, editing the text, whatever.  Make sure, 
> >> >> though, that the first character of the hunk lines is still a 
> >> >> space, a plus or a minus.
> >> >>
> >> >> After you closed the editor, Git will adjust the line counts of 
> >> >> the hunks if necessary, thanks to the --recount option of apply, 
> >> >> and commit the patch.  Except if you deleted everything, in which 
> >> >> case nothing happens (for obvious reasons).
> >> >>
> >> >> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de> 
> >> >> ---
> >> >>
> >> >>     I actually promised myself not to resend this patch, but a   
> >> >>   certain guy who has a hat now asked for it.
> >> >>
> >> >
> >> > I am that guy :-). Thanks. Sometimes "add -e" is more useful than 
> >> > "add -p" since i can see the full context when editing the patch. 
> >> > However, sometimes the ability to edit the index directly is even 
> >> > more useful. For example, if it's a big change (or rewritten), it 
> >> > is hard to edit the patch instead of the index (in diff mode with 
> >> > the worktree file side by side). I even encounter a case that i 
> >> > can't beat the patch into a shape i want when using 'add -p'  ( it 
> >> > will fail to apply)
> >> >
> >>
> >> How about this?
> >>  'add --edit=patch' to edit the patch and "add --edit=index" to edit the index
> >
> > As others have mentioned, there _is_ a reason we have a working 
> > directory. Please understand this as a "I do not like the idea of 
> > editing the index directly at all".
> 
> When doing "add --edit" to edit the patch, do you work on the working 
> directory? I think they are just different ways to change the index?

Of course I do "git stash save --keep-index" after staging those changes.

Ciao,
Dscho

--8323328-1652074626-1239639679=:10279--
