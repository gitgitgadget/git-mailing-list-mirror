From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] {fetch,upload}-pack: allow --depth=0 for
 infinite depth
Date: Tue, 24 Aug 2010 13:46:22 -0400
Message-ID: <20100824174622.GA31283@sigill.intra.peff.net>
References: <1282565304-3122-1-git-send-email-pclouds@gmail.com>
 <1282565304-3122-3-git-send-email-pclouds@gmail.com>
 <20100824135341.GA6457@coredump.intra.peff.net>
 <7vvd6zx63h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 19:46:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnxZh-0001SH-Gl
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 19:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab0HXRqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 13:46:11 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34548 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214Ab0HXRqK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 13:46:10 -0400
Received: (qmail 19085 invoked by uid 111); 24 Aug 2010 17:46:09 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 24 Aug 2010 17:46:09 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Aug 2010 13:46:22 -0400
Content-Disposition: inline
In-Reply-To: <7vvd6zx63h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154329>

On Tue, Aug 24, 2010 at 10:39:46AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > On Mon, Aug 23, 2010 at 10:08:24PM +1000, Nguy=E1=BB=85n Th=C3=A1i =
Ng=E1=BB=8Dc Duy wrote:
> >
> >> Users can do --depth=3D2147483648 for infinite depth now. It just =
looks
> >> ugly. So make "0" special (i.e. infinite depth) at plumbing/protoc=
ol
> >> level.
> >
> > What happens if I connect to an older server? Shouldn't "I understa=
nd
> > depth=3D0 is infinite" be a server capability, and we hack around i=
t by
> > sending depth=3D2^32-1 when we have a modern client but an older se=
rver?
>=20
> Good point.  Do we also need to find out how wide an int is on the ot=
her
> end in that case?

I doubt it. We can probably assume that the remote can handle a signed
32-bit depth (so really, my example should have been 2^31-1). If they
can't, then it would probably be at best an unsigned 16-bit int, in
which case we could only handle a depth of 65535 commits. There are way
more than that in common repositories, so --depth with such an
implementation would be pretty broken already.

-Peff
