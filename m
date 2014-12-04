From: Jeff King <peff@peff.net>
Subject: Re: Enhancement Request: "locale" git option
Date: Thu, 4 Dec 2014 04:55:58 -0500
Message-ID: <20141204095557.GE27455@peff.net>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
 <54801B50.4080500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 10:56:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwT8x-0006NE-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 10:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbaLDJ4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2014 04:56:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:48272 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753730AbaLDJ4A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 04:56:00 -0500
Received: (qmail 24771 invoked by uid 102); 4 Dec 2014 09:56:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 03:56:00 -0600
Received: (qmail 5018 invoked by uid 107); 4 Dec 2014 09:56:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 04:56:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 04:55:58 -0500
Content-Disposition: inline
In-Reply-To: <54801B50.4080500@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260752>

On Thu, Dec 04, 2014 at 09:29:04AM +0100, Torsten B=C3=B6gershausen wro=
te:

> How about
> alias git=3D'LANGUAGE=3Dde_DE.UTF-8 git'
> in your ~/.profile ?
> (Of course you need to change de to the language you want )

Besides being awkward in scripts (which will not respect the alias and
use a different language!), that variable will also be inherited by
programs git spawns. So the editor, for example, may end up in the wron=
g
language.

I think respecting core.locale would make sense (probably the change
would go into git_setup_gettext(), but you may have to fight with the
setup code over looking at config so early in the process).

However, I think the original question is not one of localizing git, bu=
t
rather of having it _not_ localized (avoiding the German translations).
There is a hack you can do that for that, which is to set
GIT_TEXTDOMAINDIR to something nonsensical (like "/"), which will mean
git cannot find the .po files, and just uses the builtin messages.

-Peff
