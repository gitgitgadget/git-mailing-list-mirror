From: Jeff King <peff@peff.net>
Subject: Re: Symbolic 'references' in Git?
Date: Thu, 14 Apr 2011 18:20:20 -0400
Message-ID: <20110414222020.GB19222@sigill.intra.peff.net>
References: <BANLkTinV8niLibzOQRVraYqwB0hKW1=r1w@mail.gmail.com>
 <201104141524.15212.wjl@icecavern.net>
 <BANLkTik5tD5UOrDkpL8ahEgwFjT+suHACQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Wesley J. Landaker" <wjl@icecavern.net>, git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAUtp-0003fb-CD
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 00:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab1DNWUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 18:20:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50711
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932Ab1DNWUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 18:20:23 -0400
Received: (qmail 4467 invoked by uid 107); 14 Apr 2011 22:21:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 18:21:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 18:20:20 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTik5tD5UOrDkpL8ahEgwFjT+suHACQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171566>

On Thu, Apr 14, 2011 at 05:31:13PM -0400, Chris Patti wrote:

> >> Rather than resorting to manually copying the symbolic ref file
> >> around, from repo to repo, is there any way to make such a symboli=
c
> >> 'variable' global?
> >
> > Why not just use a tag or a branch ?
> >
> > git tag -F next-release release-3.15
> >
> > =C2=A0OR
> >
> > git branch -D next-release
> > git branch next-release release-3.15
> >
> > (I personally think branches are nicer for this since tags are "sup=
posed" to
> > be immutable.)
> >
>=20
>=20
> Won't either of those things create a 'next-release' that's frozen in
> time where the release-3.15 branch is *right now*?
>=20
> This is for a CI system (Bamboo) so we need next-release to act as if
> we were using release-3.15 itself.

Yeah, a regular ref won't work for that. A symbolic ref is definitely
what you want, but their contents are not shared via the git-protocol.
So no, they won't make it across clones, fetches, or pushes. We do some
ugly magic to make HEAD work.

-Peff
