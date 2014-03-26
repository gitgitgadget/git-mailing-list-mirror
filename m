From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] log: do not segfault on gmtime errors
Date: Wed, 26 Mar 2014 15:01:58 -0400
Message-ID: <20140326190157.GB12912@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
 <20140326182103.GB7087@sigill.intra.peff.net>
 <xmqqvbv0iy6u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 20:02:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSt5U-0005qh-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 20:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbaCZTCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 15:02:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:47786 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754894AbaCZTB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 15:01:59 -0400
Received: (qmail 17188 invoked by uid 102); 26 Mar 2014 19:01:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 14:01:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 15:01:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbv0iy6u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245210>

On Wed, Mar 26, 2014 at 11:58:49AM -0700, Junio C Hamano wrote:

> > Unlike the FreeBSD thing that Ren=C3=A9 brought up, this is not a p=
roblem in
> > the code, but just in the test. So I think our options are basicall=
y:
> >
> >   1. Scrap the test as unportable.
> >
> >   2. Hard-code a few expected values. I'd be unsurprised if some ot=
her
> >      system comes up with a slightly different date in 162396404, s=
o we
> >      may end up needing several of these.
> >
> > I think I'd lean towards (2), just because it is testing an actual
> > feature of the code, and I'd like to continue doing so. And while w=
e may
> > end up with a handful of values, there's probably not _that_ many
> > independent implementations of gmtime in the wild.
>=20
> Or "3. Just make sure that 'git log' does not segfault"?

That would not test the FreeBSD case, which does not segfault, but
returns a bogus sentinel value.

I don't know how important that is. This is such a minor feature that i=
t
is not worth a lot of maintenance headache in the test. But I also do
not know if this is going to be the last report, or we will have a bunc=
h
of other systems that need their own special values put into the test.

-Peff
