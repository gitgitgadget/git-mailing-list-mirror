From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 21/25] t9001: use test_when_finished
Date: Tue, 24 Mar 2015 22:47:10 -0400
Message-ID: <20150325024710.GB15051@peff.net>
References: <20150320100429.GA17354@peff.net>
 <20150320101321.GU12543@peff.net>
 <20150325030022.Horde.yvJScxCdU4w4HDIV_xUwrw1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:47:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YabLh-0004MU-0j
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 03:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbbCYCrN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 22:47:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:38119 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752225AbbCYCrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 22:47:12 -0400
Received: (qmail 10593 invoked by uid 102); 25 Mar 2015 02:47:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Mar 2015 21:47:12 -0500
Received: (qmail 10732 invoked by uid 107); 25 Mar 2015 02:47:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Mar 2015 22:47:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2015 22:47:10 -0400
Content-Disposition: inline
In-Reply-To: <20150325030022.Horde.yvJScxCdU4w4HDIV_xUwrw1@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266249>

On Wed, Mar 25, 2015 at 03:00:22AM +0100, SZEDER G=C3=A1bor wrote:

> >Instead, they can all use test_when_finished, and we can
> >even make the code simpler by factoring out the shared
> >lines.
>=20
> I think that saving the value of 'sendemail.confirm' is not necessary=
=2E
>=20
> There are two blocks of confirmation tests, this patch concerns only =
tests
> of the second block.  The first block of confirmation tests is nearly=
 at
> the beginning of the file in order to check the "no confirm" cases ea=
rly.
> If any of those fails the remainig tests in the file are skipped beca=
use
> they might hang.  The last of those tests sets 'sendemail.confirm' to
> 'never' and leaves it so to avoid unintentional prompting in the rema=
ining
> tests and then its value is not modified until that second block of
> confirm tests are reached.  This means that when those tests save the
> value of 'sendemail.confirm' they always save 'never'.  Then why save=
 it,
> just use test_when_finished to restore it to 'never' and all is well.

Yeah, I suspected this while writing it the patch, but I preferred to
keep it more obvious that there would be no accidental regression, sinc=
e
the series was already so long (and also because calling save_confirm i=
s
not any worse than test_when_finished).

I don't mind a patch on top simplifying out save_confirm, if you're
confident that's what we're always saving.

-Peff
