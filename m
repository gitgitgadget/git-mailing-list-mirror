From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [Feature Request] Better Subversion integration
Date: Sun, 10 Feb 2008 23:18:08 +0100
Message-ID: <20080210221808.GA16615@atjola.homenet>
References: <FC5B6F22-27A9-4F0F-85EE-0B72B94C69E2@gmail.com> <20080210035611.GA2454@atjola.homenet> <47AF2BBF.1060403@alum.mit.edu> <20080210175351.GA13411@atjola.homenet> <47AF5242.9080804@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Granieri Jr <sjgdev@gmail.com>,
	Git Users List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:18:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOKVc-0007sB-T5
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 23:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbYBJWSN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 17:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbYBJWSN
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 17:18:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:41438 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751799AbYBJWSM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 17:18:12 -0500
Received: (qmail invoked by alias); 10 Feb 2008 22:18:09 -0000
Received: from i577B8755.versanet.de (EHLO atjola.local) [87.123.135.85]
  by mail.gmx.net (mp015) with SMTP; 10 Feb 2008 23:18:09 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19p6m9tNFNpWoPUfCLY3S3jsQcz2Ake0nwLcpsK4T
	/MoL0C4F0owSK6
Content-Disposition: inline
In-Reply-To: <47AF5242.9080804@alum.mit.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73426>

On 2008.02.10 20:36:34 +0100, Michael Haggerty wrote:
> Bj=F6rn Steinbrink wrote:
> > On 2008.02.10 17:52:15 +0100, Michael Haggerty wrote:
> >> Bj=F6rn Steinbrink wrote:
> >>> On 2008.02.09 20:44:59 -0600, Sam Granieri Jr wrote:
> >>>> Right now, git-svn import (or clone) will convert tags and branc=
hes as =20
> >>>> remote branches.
> >>>> I would like it if git could pick up subversion tags and transla=
te them=20
> >>>> as git tags upon importing
> >>> SVN tags aren't like git tags. A "tag" in SVN is just another dir=
ectory,
> >>> which you can modify at will. Yeah, I know, you _should_ not comm=
it any
> >>> changes to SVN "tags", but shit happens. And once you modify the =
"tag"
> >>> in SVN, you would have to invalidate the git tag, and finding a c=
ommit
> >>> that matches the SVN state of things is probably way too expensiv=
e to be
> >>> practical. Maybe some --we-never-mess-up-svn-tag-alike-branches c=
ould
> >>> be added to allow git-svn to create teal git tags though? Dunno, =
I don't
> >>> care much. Shouldn't be too hard to find some shell magic to crea=
te
> >>> tags, if one wants them.
> >> Because of the way an SVN repository is stored, it should be cheap=
 to
> >> ask SVN whether the contents of a tag in the HEAD revision are ide=
ntical
> >> to the contents at the time the tag was created.  If there was any
> >> change anywhere under the tag directory, then the node of the tag
> >> directory will be different in the two revisions.
> >>
> >> For that matter, you could ask SVN for information about the revis=
ions
> >> in which the tags/ directory was changed (this is also very cheap)=
, and
> >> make sure that none of those changes modified an existing tag.  Th=
is
> >> scan could be done at the beginning of a conversion to determine w=
hich
> >> tags were handled as pure tags (and therefore convertible as git t=
ags)
> >> and which were not (and therefore require more complicated handlin=
g).
> >=20
> > Yeah, but what if a "tag" in SVN is modified after that? Then the g=
it
> > tag becomes kinda invalid, and I see no cheap way to figure out if =
there
> > is a commit somewhere that has the same content of the new "tag". T=
hat's
> > what I'm talking about.
> >=20
> > The only way I see to handle that is to create a new commit in git =
and
> > tag that. But IMHO that's totally nuts, because the tag doesn't eve=
n
> > point to a commit of the "real" branch anymore. And you'd either ne=
ed to
> > replace/remove the old tag or use a naming scheme that includes som=
e
> > @rev marker, both of which are just confusing when talking about ta=
gs.
>=20
> You're right; when importing incrementally there is no way to know wh=
at
> people will do with a tag after the initial conversion.  I was thinki=
ng
> more of a one-time conversion.
>=20
> If a new tag is created cleanly in subversion (that is, a single copy
> from a single location, then you can read the SVN source (trunk or
> branch name + SVN revision number) directly out of SVN.  A persistent
> look-up table could keep track of the git hashes corresponding to suc=
h
> sources.
>=20
> If a clean tag is later modified, would it be reasonable to
> "retroactively" create a git branch based on the contents of the old
> tag, and modify that?

That's the first option I described (well, I skipped the "create a
branch" part). But you would get a history like this:

Before the tag change:

 ---A (tag XYZ)
     \
      B---C---D (trunk)

After the tag change:

 ---A---A' (tag XYZ)
     \
      B---C---D (trunk)

So not only does the tag move, but it's also no longer in the history o=
f
trunk. And that makes it IMHO a bit confusing/useless to do that. With
the branches, you at least _know_ that things can change. Tags are not
supposed to do so.

That said, I'd not oppose any optional support to create such tags, I'd
just never use it.

Bj=F6rn
