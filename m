From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Fri, 22 Jul 2011 16:02:17 -0600
Message-ID: <20110722220216.GA14118@sigill.intra.peff.net>
References: <20110721202722.3765.qmail@science.horizon.com>
 <alpine.LFD.2.00.1107220907370.1762@xanadu.home>
 <alpine.DEB.2.02.1107221102180.6496@asgard.lang.hm>
 <201107222034.20510.jnareb@gmail.com>
 <CA+55aFzsZ6w_a_wPEuBjtDeSDYQviVfy9UmJMxPz4geu4CRthQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, david@lang.hm,
	Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Anthony Van de Gejuchte <anthonyvdgent@gmail.com>,
	git@vger.kernel.org, Phil Hord <hordp@cisco.com>,
	Shawn Pearce <spearce@spearce.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 00:02:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkNnu-0003aG-5E
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 00:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623Ab1GVWCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jul 2011 18:02:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50476
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420Ab1GVWC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 18:02:29 -0400
Received: (qmail 23591 invoked by uid 107); 22 Jul 2011 22:02:58 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 18:02:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 16:02:17 -0600
Content-Disposition: inline
In-Reply-To: <CA+55aFzsZ6w_a_wPEuBjtDeSDYQviVfy9UmJMxPz4geu4CRthQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177671>

On Fri, Jul 22, 2011 at 12:06:08PM -0700, Linus Torvalds wrote:

> On Fri, Jul 22, 2011 at 11:34 AM, Jakub Narebski <jnareb@gmail.com> w=
rote:
> >
> > That is IF unknown headers are copied verbatim during rebase. =C2=A0=
=46or
> > "encoding" header this is a good thing, for "generation" it isn't.
>=20
> Afaik, they aren't copied verbatim, and never have been. Afaik, the
> only thing that has *ever* written commits is "commit_tree()"
> (originally "main()" in commit-tree.c). Why is this red herring even
> being discussed?

In git.git, that is the case. There are other programs that may write
git commits, though. Try:

  http://www.google.com/codesearch#search/&q=3Dhash-object.*commit&type=
=3Dcs

Many uses seem OK (they are generating a commit from scratch). This one
at least (the sixth result from the search above) would actually
generate buggy generation headers (it modifies parents but passes other
headers through):

  http://www.google.com/codesearch#XUVcT9DKB_U/replace&ct=3Drc&cd=3D7&q=
=3Dhash-object.*commit

It may be worth saying that such code is stupid and ugly and wrong, or
that it is not deployed widely enough to care about.  But it's not
entirely a red herring.

-Peff
