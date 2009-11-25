From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Commiting changes onto more than one branch
Date: Wed, 25 Nov 2009 18:41:29 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911251752330.14365@iabervon.org>
References: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>  <76c5b8580911250838x361ae081n271fcee2d1234703@mail.gmail.com>  <6b4a562b0911250847x59116687iba1d1640ca6c3887@mail.gmail.com>  <7vaayazb2a.fsf@alter.siamese.dyndns.org>
 <6b4a562b0911251143s63f09f7bwe4b67d6871d8a1b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-419284665-1259190840=:14365"
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Mike Jarmy <mjarmy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:41:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRUV-00045J-KH
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbZKYXl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 18:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbZKYXl0
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:41:26 -0500
Received: from iabervon.org ([66.92.72.58]:35339 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964978AbZKYXlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:41:25 -0500
Received: (qmail 3166 invoked by uid 1000); 25 Nov 2009 23:41:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Nov 2009 23:41:29 -0000
In-Reply-To: <6b4a562b0911251143s63f09f7bwe4b67d6871d8a1b2@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Content-ID: <alpine.LNX.2.00.0911251821350.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133706>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-419284665-1259190840=:14365
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.0911251821351.14365@iabervon.org>

On Wed, 25 Nov 2009, Mike Jarmy wrote:

> Junio C Hamano wrote:
> > I take it to mean that even though v[345] have diverged, the area that the
> > particular change you have in mind has to touch haven't changed since they
> > forked.
> 
> Correct.  Sometimes, there might be unrelated changes to a given file
> or files, in which case conflict resolution will be done manually.
> But generally speaking, bugfixes will tend to go on quite cleanly.
> 
> > Instead, you can fork such a topic from the latest common.
> >
> >        o--o--o--o--o--o--o--o v4
> >       /
> >    --o--x--x--x--x--x--x--x v3
> >       \
> >        Y---Y
> >            your change(s)
> >
> > and merging this to v3 and v4 will have the desired effect.
> >
> >        o--o--o--o--o--o--o--o---------M v4
> >       /                              /
> >    --o--x--x--x--x--x--x--x---M v3  /
> >       \                      /     /
> >        Y---Y----------------.-----.
> >            your change(s)
> >
> > The merges will incorporate this particular change alone without dragging
> > anything else.  When you merge it to v4, none of the unrelated 'x' will be
> > merged into it.
> 
> That sounds a whole lot like what I need.
> 
> Right now I'm thinking that the right approach is that once we have
> released v3, and started working on v4 heavily, we will probably not
> want to check any commits directly into v3.  Bugfixes will have their
> own branch.   If there is a whole new project or whatever being done
> on top of v3, it will have its own branch as well.
> 
> So once v3 is in beta or whatever and we declare a code freeze, we
> could have a rule that all commits must be merge-commits coming from
> dedicated branches with descriptive, intelligible names.  For each
> dedicated branch, some thought will have to be given as to just where
> off of v3 to branch it from (not just carelessly off the latest tip).
> Meanwhile, new development will continue on v4, with lots of commits
> going right into the branch (or into v4 sub-branches with occasional
> merge-commits into v4).

It's worth noting that you don't have to have any general visibility to 
the dedicated branch. If you look at Junio's graph, there are only two 
branches marked: v3 and v4. The stuff in the bottom line only appears as 
the second parent in the merge commits. Git's data model doesn't require a 
branch for a commit to be "on" like many other VCSes, so it's perfectly 
reasonable for a developer to make a temporary branch, create the fix in 
some private repository, merge it to each applicable official branch, and 
then discard the temporary branch. (The temporary branch is only needed at 
all so that the developer has some way to refer to the fix while merging 
it, and the name only matters in that humans will see it in the merge 
commit message.)

	-Daniel
*This .sig left intentionally blank*
--1547844168-419284665-1259190840=:14365--
