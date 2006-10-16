From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 01:45:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 01:45:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZc9O-000496-Mr
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 01:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422938AbWJPXpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 19:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWJPXpk
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 19:45:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:40357 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750814AbWJPXpj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 19:45:39 -0400
Received: (qmail invoked by alias); 16 Oct 2006 23:45:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 17 Oct 2006 01:45:37 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45340713.6000707@utoronto.ca>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28997>

Hi Aaron,

On Mon, 16 Oct 2006, Aaron Bentley wrote:

> --[PinePGP]--------------------------------------------------[begin]--
> Jakub Narebski wrote:
> >>Does it accurately reflect the current status of git? Is their
> >>assessment of git's rename capability correct?
> >
> >
> > For example simple namespace for git: you can use shortened sha1
> > (even to only 6 characters, although usually 8 are used), you can
> > use tags, you can use ref^m~n syntax.
> 
> Bazaar's namespace is "simple" because all branches can be named by a 
> URL, and all revisions can be named by a URL + a number.

How should this cope with a distributed project? IOW how does it deal with 
"this revision and that revision are exactly the same"?

If I understand you correctly, you are claiming that you are not really 
identifying a revision, but a revision _at a certain place with a 
place-dependent number_. This conflicts with my understanding of a 
revision.

> If that's true of Git, then it certainly has a simple namespace.  Using 
> eight-digit hex values doesn't sound simple to me, though.

It depends on your usage. If you want to do anything interesting, like 
assure that you have the correct version, or assure that two different 
person's tags actually tag the same revision, there is no simpler 
representation.

> > I'm not sure about "No" in "Supports Repository". Git supports multiple
> > branches in one repository, and what's better supports development using
> > multiple branches, but cannot for example do a diff or a cherry-pick
> > between repositories (well, you can use git-format-patch/git-am to
> > cherry-pick changes between repositories...).
> 
> That sounds right.  So those branches are persistent, and can be worked
> on independently?

Of course! Persistence (and reliability) are the number one goal of git. 
Performance is the next one.

As an example of completely independet branches, look at the "next" and 
the "todo" branch of git. They are _completely_ independent, i.e. not even 
sharing history, let alone files.

> > Git supports renames in its own way; it doesn't use file ids, nor
> > remember renames (the new "note" header for use e.g. by porcelains
> > didn't pass if I remember correctly). But it does *detect* moving
> > _contents_, and even *copying* _contents_ when requested. And of
> > course it detect renames in merges.
> 
> You'll note we referred to that bevhavior on the page.  We don't think
> what Git does is the same as supporting renames.  AIUI, some Git users
> feel the same way.

Oh, we start another flamewar again?

Honestly, if you want to record renames, why don't you also support (with 
a command for each of those purposes) code copying? And refactoring? And 
copyright year bumps? _put your favourite here_

If you really, really think about it: it makes much more sense to record 
your intention in the commit message. So, instead of recording for _every_ 
_single_ file in folder1/ that it was moved to folder2/, it is better to 
say that you moved folder1/ to folder2/ _because of some special reason_!

Same goes for all other thinkable examples.

If you want to track code, then let the tracker do its work, i.e. let 
git-pickaxe figure where your code came from. It is likely being more 
precise than any human ever can be.

> > Git doesn't have some "plugin framework", but because it has many
> > "plumbing" commands, it is easy to add new commands, and also new
> > merge strategies, using shell scripts, Perl, Python and of course C.
> > So the answer would be "Somewhat", as git has plugable merge strategies,
> > or even "Yes" at it is easy to add new git command.
> 
> It sounds like you're saying it's extensible, not that it supports
> plugins.  Plugins have very simple installation requirements.  They can
> provide merge strategies, repository types, internet protocols, new
> commands, etc., all seamlessly integrated.
> 
> What you're describing actually sounds like the Arch approach to
> extensibility: provide a whole bunch of basic commands and let users
> build an RCS on top of that.

It is more like the Unix way. Let each command do _one_ thing, but let it 
do it _perfectly_.

> As the author of two different Arch front-ends, I can say I haven't
> found that approach satisfactory.  Invoking multiple commands tends
> re-invoke the same validation routines over and over, killing
> efficiency, and diagnostics tend to be pretty poorly integrated.

Welcome to git! Git's commands are very efficient, and you can even pipe 
them efficiently! And now that we have GIT_TRACE, diagnostics are no 
concern.

Ciao,
Dscho
