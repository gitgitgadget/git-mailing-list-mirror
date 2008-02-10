From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [Feature Request] Better Subversion integration
Date: Sun, 10 Feb 2008 18:53:51 +0100
Message-ID: <20080210175351.GA13411@atjola.homenet>
References: <FC5B6F22-27A9-4F0F-85EE-0B72B94C69E2@gmail.com> <20080210035611.GA2454@atjola.homenet> <47AF2BBF.1060403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Granieri Jr <sjgdev@gmail.com>,
	Git Users List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Feb 10 18:54:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOGNq-0001kc-A6
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 18:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbYBJRxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 12:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbYBJRxz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 12:53:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:56310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751544AbYBJRxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 12:53:54 -0500
Received: (qmail invoked by alias); 10 Feb 2008 17:53:52 -0000
Received: from i577B8755.versanet.de (EHLO atjola.local) [87.123.135.85]
  by mail.gmx.net (mp023) with SMTP; 10 Feb 2008 18:53:52 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18Tbmgnz4sTbjJtVTYwehE3pdTPbo+EdwcUtJuEuT
	uA1jVQwYARAwyW
Content-Disposition: inline
In-Reply-To: <47AF2BBF.1060403@alum.mit.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73383>

On 2008.02.10 17:52:15 +0100, Michael Haggerty wrote:
> Bj=F6rn Steinbrink wrote:
> > On 2008.02.09 20:44:59 -0600, Sam Granieri Jr wrote:
> >> Right now, git-svn import (or clone) will convert tags and branche=
s as =20
> >> remote branches.
> >> I would like it if git could pick up subversion tags and translate=
 them=20
> >> as git tags upon importing
> >=20
> > SVN tags aren't like git tags. A "tag" in SVN is just another direc=
tory,
> > which you can modify at will. Yeah, I know, you _should_ not commit=
 any
> > changes to SVN "tags", but shit happens. And once you modify the "t=
ag"
> > in SVN, you would have to invalidate the git tag, and finding a com=
mit
> > that matches the SVN state of things is probably way too expensive =
to be
> > practical. Maybe some --we-never-mess-up-svn-tag-alike-branches cou=
ld
> > be added to allow git-svn to create teal git tags though? Dunno, I =
don't
> > care much. Shouldn't be too hard to find some shell magic to create
> > tags, if one wants them.
>=20
> Because of the way an SVN repository is stored, it should be cheap to
> ask SVN whether the contents of a tag in the HEAD revision are identi=
cal
> to the contents at the time the tag was created.  If there was any
> change anywhere under the tag directory, then the node of the tag
> directory will be different in the two revisions.
>=20
> For that matter, you could ask SVN for information about the revision=
s
> in which the tags/ directory was changed (this is also very cheap), a=
nd
> make sure that none of those changes modified an existing tag.  This
> scan could be done at the beginning of a conversion to determine whic=
h
> tags were handled as pure tags (and therefore convertible as git tags=
)
> and which were not (and therefore require more complicated handling).

Yeah, but what if a "tag" in SVN is modified after that? Then the git
tag becomes kinda invalid, and I see no cheap way to figure out if ther=
e
is a commit somewhere that has the same content of the new "tag". That'=
s
what I'm talking about.

The only way I see to handle that is to create a new commit in git and
tag that. But IMHO that's totally nuts, because the tag doesn't even
point to a commit of the "real" branch anymore. And you'd either need t=
o
replace/remove the old tag or use a naming scheme that includes some
@rev marker, both of which are just confusing when talking about tags.

Bj=F6rn
