From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] doc: enhance git describe --tags help
Date: Tue, 30 Sep 2008 15:26:46 -0700
Message-ID: <20080930222646.GP21310@spearce.org>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com> <20080928135526.GG5302@artemis.corp> <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com> <20080928143949.GH5302@artemis.corp> <20080928150318.GI5302@artemis.corp> <20080928151259.GJ5302@artemis.corp> <20080929150127.GB18340@spearce.org> <20080930095641.GA9001@strlen.de> <20080930190449.GG21310@spearce.org> <20080930221453.GA13659@strlen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>,
	Erez Zilber <erezzi.list@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>
To: Uwe Kleine-KKKnig <ukleinek@strlen.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 00:28:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KknhF-000658-6H
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 00:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbYI3W0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 18:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbYI3W0r
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 18:26:47 -0400
Received: from george.spearce.org ([209.20.77.23]:43877 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbYI3W0q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 18:26:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 179813835F; Tue, 30 Sep 2008 22:26:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080930221453.GA13659@strlen.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97165>

Uwe Kleine-KKKnig <ukleinek@strlen.de> wrote:
> On Tue, Sep 30, 2008 at 12:04:49PM -0700, Shawn O. Pearce wrote:
> > Uwe Kleine-KKKnig <ukleinek@strlen.de> wrote:
> > >
> > > IMHO --tags should behave as Erez expected (because it's what I
> > > expected, too).
> > 
> > I don't disagree.  I've been tempted to write a patch to change the
> > behavior of git-describe so that --tags and --all control what names
> > are inserted into the candidate list, but don't control the ordering
> > of their selection.
> > 
> > I think this is all that is needed to make the behavior do what you
> > and Erez expected.  But its a pretty big change in the results if
> > you are passing in --all or --tags today.
>
> But it matches the documentation, and the expectations of Erez, me and
> (at least initially) Pierre.
> 
> My POV is still:  If you pass --all or --tags you have to be able to
> handle if a lw tag is used in the answer.

I was agreeing with you.  I've long felt that the --tags and --all
behavior of git-describe was wrong.  But something in the back of
my mind tells me Junio felt otherwise.

Its a change in behavior.  Today users are getting annotated tags
back from `git describe --tags` even if lightweight tags are closer.
Once this code change is in they'll start to get lightweight tags.

Previously `git describe --tags` never gave a lightweight tag if
there was at least one annotated tag in the history.  Now it will
start to give the lightweight tags.  Some users may see that as a
breakage.  Especially after the 1.6 "dashless" change...

> > -static int all;	/* Default to annotated tags only */
> > -static int tags;	/* But allow any tags if --tags is specified */
> > +static int all;	/* Any valid ref can be used */
> > +static int tags;	/* Either lightweight or annotated tags */
>
> Mmmh, IMHO the comment for tags is misleading, its either annotated only
> or both.

Oh, yes, right.  Thanks.  I'll clean it up.

-- 
Shawn.
