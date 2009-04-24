From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 25 Apr 2009 01:16:32 +0200
Message-ID: <20090424231632.GB10155@atjola.homenet>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:18:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUey-0007TW-8Q
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbZDXXQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 19:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbZDXXQq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:16:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:52033 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752528AbZDXXQp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:16:45 -0400
Received: (qmail invoked by alias); 24 Apr 2009 23:16:43 -0000
Received: from i59F5B10E.versanet.de (EHLO atjola.local) [89.245.177.14]
  by mail.gmx.net (mp037) with SMTP; 25 Apr 2009 01:16:43 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/jYG15NiTjsA0UhmFV2ygD54qFqa5GDiQ4DtocaR
	3v9qyhP+4Ppl3c
Content-Disposition: inline
In-Reply-To: <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117513>

On 2009.04.24 17:18:44 -0500, Michael Witten wrote:
> On Fri, Apr 24, 2009 at 16:38, Jeff King <peff@peff.net> wrote:
> > On Fri, Apr 24, 2009 at 05:34:00PM -0400, Daniel Barkalow wrote:
> >
> >> I'd say that blobs and trees are an implementation detail of "the =
full
> >> content of a version of the project", not something conceptually
> >> important. Likewise, the date representation used in commits isn't
> > ...
> > No, that isn't critical for understanding how _commit_ operations w=
ork,
> > but I think that is exactly the sort of conceptual knowledge that l=
et
> > people use git more fully.
>=20
> I think the key conlusion here is that the main concepts are *objects=
*
> and references to those objects. One type of object is not necessaril=
y
> more low-level or high-level than another type of object; each type o=
f
> object is the most important type of object for a particular task in
> or view of the git world.
>=20
> > I disagree. I think it's important to note that trees and blobs hav=
e a
> > name, and you can refer to them. Once you know that, the fact that =
you
> > can do:
> >
> > =A0git show master
> > =A0git show master:Documentation
> > =A0git show master:Makefile
> >
> > just makes sense. You are always just specifying an object, but the=
 type
> > is different for each (and show "does the right thing" based on obj=
ect
> > type).
>=20
> In fact, I think it's important to note that the notation:
>=20
>     git show master:Makefile
>=20
> actually involves a translation from a Unix filesystem address to a
> git object address that is then used to find the relevant data.

Hm? Resolving master:Makefile means to first find what master is, most
likely the shortname for refs/heads/master. That usually references a
commit object (by its name). The "<tree-ish>:<path>" syntax then causes
git to lookup the tree referenced by that commit (again, by its name).
And then the tree entry for "Makefile" is looked up, leading to the nam=
e
for the object identified by "master:Makefile".

> In fact, I think masking this kind of thing with a catch-all word
> 'reference' is a bad idea.

"master:Makefile" is not a reference. Just "master" is a shortname for =
a
reference, the full name might be refs/heads/master.

git has:
 - object names (which happen to be SHA-1 hashes).
 - references (which reference objects by their names)
 - symbolic references (which reference other references by their names=
)

The "<tree-ish>:<path>" syntax is not called "reference".

> Rather than being hidden, it should be exposed: I think it would be
> beneficial to use the word 'address' rather than 'reference' when
> talking about the SHA-1 names. Then HEAD could be called a pointer
> variable, etc.

What's wrong with just calling the object name "object name"? Reference=
s
are something different, and the above "master:Makefile" is yet a
different thing, using the "extended SHA1" syntax to identify an object=
=2E

> So, a pointer variable's value is an object address that is the
> location of an object in git 'memory'. I think using this approach
> would make things significantly more transparent.

But then HEAD would be a pointer pointer variable (symbolic ref), unles=
s
you have a detached HEAD.

Bj=F6rn
