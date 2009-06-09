From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 23:18:06 +0200
Message-ID: <20090609211806.GC13781@atjola.homenet>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> <20090609201200.GA13781@atjola.homenet> <51419b2c0906091340i11965efcr5cf5bb4a71108fa6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 23:18:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME8i1-0008Ob-TH
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 23:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbZFIVSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 17:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbZFIVSH
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 17:18:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:49713 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752722AbZFIVSG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 17:18:06 -0400
Received: (qmail invoked by alias); 09 Jun 2009 21:18:07 -0000
Received: from i59F57D4A.versanet.de (EHLO atjola.local) [89.245.125.74]
  by mail.gmx.net (mp069) with SMTP; 09 Jun 2009 23:18:07 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/WeiZW+lXWThYYlGfKrpvqtOxXgbe7VnWd3RSEOj
	pDk4aX2VNhqoCe
Content-Disposition: inline
In-Reply-To: <51419b2c0906091340i11965efcr5cf5bb4a71108fa6@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121225>

On 2009.06.09 14:40:33 -0600, Elijah Newren wrote:
> Hi,
>=20
> 2009/6/9 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> > On 2009.06.09 11:59:08 -0700, Scott Chacon wrote:
> >> * breaks the various things that 'checkout' does into separate
> >> commands - moves 'revert' to doing what 'checkout -- path' does
> >
> > Looking through the "eg revert" docs [1], I can't seem to find how =
you can
> > do "checkout -- path" with it at all. "eg revert foo" seems to be "=
git
> > checkout HEAD -- foo".
>=20
> If you want to revert only the unstaged changes to path:
>   "checkout -- path" OR "revert --unstaged path"
> If you want to revert both staged and unstaged changes to foo:
>   "checkout HEAD -- foo" OR "revert foo"

OK, so --unstaged doesn't just select the destination, but also the
source, unless you explicitly override it, right?

eg revert [--since HEAD] path
  =3D=3D> source: HEAD, destination: working tree, index

eg revert --unstaged path
  =3D=3D> source: index, destination: working tree

eg revert --unstaged --since HEAD path
  =3D=3D> source: HEAD, destination: working tree


>=20
> > The "eg revert" looks really confusing to me.
> > "eg revert --unstaged --in HEAD~8". Hu? Revert unstaged changes in
> > HEAD~8? Am I missing something?
>=20
> Hmm.  Bad ordering, I guess -- it's revert changes in HEAD~8 to the
> working copy only (by default, revert tries to apply changes to both
> the working copy and the index).  Yeah, it doesn't read very well.
>=20
> I'm not sure I like having "--in" as part of revert, partially becaus=
e
> of this confusion (and partially because I don't think it's
> implementation is correct anyway).  However, I do occasionally really
> like being able to revert the change _to a single file_ made in some
> previous commit, so I haven't removed it from eg (yet?).  *shrug*

I'm not sure that "--in" is the worst thing here. To me, --unstaged is
worse, because I apply the attribute "unstaged" to the changes to be
reverted. And that makes no sense when I supply a commit, a commit
cannot have unstaged changes. I guess that if --unstaged wasn't used to
select the destination, I might have come up with "eg revert --unstaged=
"
myself, just from seeing the options. But seeing that --unstaged can be
used with a commit confused me.

Bj=F6rn
