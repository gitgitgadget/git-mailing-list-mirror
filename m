From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Get a copy of an old version of a file, using git gui/gitk
Date: Fri, 19 Sep 2008 11:12:23 +0200
Message-ID: <20080919091223.GA13778@atjola.homenet>
References: <884843.41605.qm@web95002.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 11:14:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgc3U-0000YU-Gt
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 11:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbYISJM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 05:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbYISJM2
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 05:12:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:51798 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750709AbYISJM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 05:12:27 -0400
Received: (qmail invoked by alias); 19 Sep 2008 09:12:25 -0000
Received: from i577B8FFC.versanet.de (EHLO atjola.local) [87.123.143.252]
  by mail.gmx.net (mp012) with SMTP; 19 Sep 2008 11:12:25 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18czvZs7A8cHov2Ls99rq/8u1x7tuuvlzmaUVmhnP
	mL6kzKR1lzkKYC
Content-Disposition: inline
In-Reply-To: <884843.41605.qm@web95002.mail.in2.yahoo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96268>

[Fixed that top-posting for you...]

On 2008.09.19 14:02:30 +0530, dhruva wrote:
> From: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
> > On 2008.09.19 08:58:04 +0100, Peter Krefting wrote:
> > > From the command line, I would try to find the SHA-1 and use git
> > > cat-file, but I can't figure out how to do it from the GUIs. Or, =
to
> > > fall back to the command-line, how to get the SHA-1 for the objec=
t out
> > > of git gui/gitk.
> >=20
> > You don't need the sha1 of the blob object, just the revision and t=
he
> > filename, and then you can reference the blob using the
> > :syntax.
> >=20
> > For example:
> >     git cat-file blob HEAD^^^:some/file.c
> > or less plumb-ish:
> >     git show HEAD^^^:some/file.c
> >=20
> > I've been told that neither cares about the CRLF conversion, and I =
don't
> > know if there's anything except "git checkout" that actually does c=
are
> > about it. With checkout, you would do:
> >=20
> > git checkout HEAD^^^ -- some/file.c
> >=20
> > But that replaces the current version of that file in your working =
tree
> > and index with the version from the HEAD^^^ revision, so that might=
 not
> > be exactly what you were looking for.
>
> Using gitk, you can branch at the change that has the file (and
> content, I am not using version as git does not version files) you
> want. Check out that branch and you will have that file (and all othe=
r
> files at that changeset). When you are done, you can just delete that
> branch... branching is _cheap_

Yeah, that works, but only if you have no uncommitted changes (which
git would try to apply to the version you check out). And that obviousl=
y
replaces _all_ files in your working tree and index, so that doesn't
have any advantages compared to the "git checkout $commit -- file"
approach. The disadvantage is just shifted from "uncommitted changes to
that file are lost" to "uncommitted changes to that file are kept", so
you don't even get the actual version of that file that you wanted to
have in the first place.

Besides that, why even bother with branch creation at all? Just checkou=
t
that revision (puts you on a detached HEAD), do whatever you want, and
checkout the branch you were working on again. No need to create a
branch if you don't intend to create commits you want to keep...

Bj=F6rn
