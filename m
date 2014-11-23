From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Sun, 23 Nov 2014 14:50:42 -0500
Message-ID: <20141123195041.GA16854@peff.net>
References: <546F5CC7.8060904@drmicha.warpmail.net>
 <b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net>
 <20141121180105.GB26650@peff.net>
 <5470A4C0.3070501@web.de>
 <20141122191932.GA13340@peff.net>
 <5470FE0A.1030802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 23 20:50:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsdBH-00056n-CR
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 20:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbaKWTuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Nov 2014 14:50:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:43741 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751419AbaKWTun (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 14:50:43 -0500
Received: (qmail 10569 invoked by uid 102); 23 Nov 2014 19:50:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Nov 2014 13:50:43 -0600
Received: (qmail 9385 invoked by uid 107); 23 Nov 2014 19:50:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Nov 2014 14:50:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Nov 2014 14:50:42 -0500
Content-Disposition: inline
In-Reply-To: <5470FE0A.1030802@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260103>

On Sat, Nov 22, 2014 at 10:20:10PM +0100, Torsten B=C3=B6gershausen wro=
te:

> > I do not think there is a real _downside_ to using test_must_fail f=
or
> > grep, except that it is a bit more verbose.
> We may burn CPU cycles=20

It adds a single if/else chain. If your shell does not implement that a=
s
a fast builtin, you have bigger performance problems. :)

> I counted 19 "test_must_fail grep" under t/*sh, and 201 "! grep".

I do not mind a patch to fix them, but with the usual caveat of avoidin=
g
stepping on the toes of any topics in flight. It is also fine to leave
them until the area is touched.

> As a general rule for further review of shell scripts can we say ?
> ! git                # incorrect, we don't capture e.g. segfaults of =
signal=20
> test_must_fail grep  # correct, but not preferred for new code
> ! grep               # preferred for new code
> test_must_fail git   # correct

I think that's true. The snippet from t/README Junio quoted lays it out
pretty clearly, I think. If you didn't know there was documentation in
t/README that was worth reading before writing tests, then that is the
thing I think should go in CodingGuidelines.

-Peff
