From: Jeff King <peff@peff.net>
Subject: Re: Bug: pull --rebase with =?utf-8?B?w6kg?= =?utf-8?Q?in?= name
Date: Mon, 5 Mar 2012 05:26:57 -0500
Message-ID: <20120305102657.GB29061@sigill.intra.peff.net>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Haber <rene@habr.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 11:27:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4V8E-00017P-5g
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 11:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab2CEK1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 05:27:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37612
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756473Ab2CEK07 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 05:26:59 -0500
Received: (qmail 28188 invoked by uid 107); 5 Mar 2012 10:27:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Mar 2012 05:27:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Mar 2012 05:26:57 -0500
Content-Disposition: inline
In-Reply-To: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192220>

On Mon, Mar 05, 2012 at 10:59:16AM +0100, Ren=C3=A9 Haber wrote:

> I'm having trouble with the following scenario:
> My name contains an =C3=A9 with accent. Having set
> git config --global user.name "Ren=C3=A9 Haber"
> and several commits with that name in a project.

That should work in general, but...

> git pull --rebase
> [...]
> /sw/lib/git-core/git-am: line 675: Haber: command not found
>=20
> The problem lies in .git/rebase-apply/author-script :
>=20
> GIT_AUTHOR_NAME=3D'Rene'=CC=81 Haber
> GIT_AUTHOR_EMAIL=3D'rene@habr.de'
> GIT_AUTHOR_DATE=3D'@1330931169 +0100'

That's definitely not right.

I can't seem to reproduce it here with a simple test (neither with
"Ren=C3=A9" in the author name, nor with an author name containing
single-quote). What version of git are you using (it looks like a recen=
t
one, as it has the magic @-date syntax). Have you set
i18n.commitencoding, or are otherwise using an encoding besides utf8? I=
s
it possible to share the commits that trigger this bug?

-Peff
