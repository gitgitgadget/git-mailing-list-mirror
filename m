From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Making format-patch output better when blank line is
	missing?
Date: Sat, 17 Jan 2009 10:47:11 -0500
Message-ID: <20090117154711.GD27071@coredump.intra.peff.net>
References: <20090117123545.GA22842@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sat Jan 17 16:48:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODPb-0002Oy-So
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761862AbZAQPrQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 10:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761845AbZAQPrP
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:47:15 -0500
Received: from peff.net ([208.65.91.99]:54502 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761577AbZAQPrN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:47:13 -0500
Received: (qmail 31834 invoked by uid 107); 17 Jan 2009 15:47:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Jan 2009 10:47:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Jan 2009 10:47:11 -0500
Content-Disposition: inline
In-Reply-To: <20090117123545.GA22842@chistera.yi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106067>

On Sat, Jan 17, 2009 at 01:35:45PM +0100, Adeodato Sim=C3=B3 wrote:

> I'm using git-format-patch to send commit diff emails, and it was
> recently brought to my atention that if a commit message consists
> entirely in a paragraph with no blank lines (particluarly, no blank l=
ine
> after the first line, which is not a summary but just the first line =
of
> the paragraph), git-format-patch will place all the commit message in
> the Subject, which is inconvenient to read.

Yeah, such messages don't really interact well with the idea of a
subject/body commit format.

> Do you think it would be good to have format-patch do something like
> this in this case?:
>=20
>     Subject: [PATCH] This commit introduces a new function bla() that=
 [...]
>=20
>     [...] makes it possible to apply the frobniz operation to objects
>     that don't bla bla bla bla.
>=20
> (I realize that, with this, the applying logic would have to learn ab=
out
> it. Hm.)

I think it would be more readable to simply limit the subject line, add
"...", and then repeat the whole paragraph in the body. Then worst case=
,
the person applying just gets the text repeated, like:

  This commit introduces a new function bla() that...

  This commit introduces a new function bla() that makes it possible to
  aply the forbniz operation to objects that don't bla bla bla bla.

which is actually pretty reasonable. And best case, the person applying
fixes it up appropriately. But I don't know if it is worth trying to
come up with a reversible format. Patches sent through email are meant
to preserve what's on the other end, but it doesn't _have_ to be exact,
especially in the face of somebody ignoring the workflow conventions
that the patch format is meant to support.

-Peff
