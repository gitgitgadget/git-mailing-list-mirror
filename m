From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] wt-status: correct and simplify check for detached
 HEAD
Date: Sat, 28 Nov 2015 12:31:31 -0500
Message-ID: <20151128173131.GF27264@sigill.intra.peff.net>
References: <563D2DE7.1030005@web.de>
 <20151124213601.GB29185@sigill.intra.peff.net>
 <56551A11.9030809@web.de>
 <20151125091503.GA1779@sigill.intra.peff.net>
 <5655C14A.1060308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Duy Nguyen <pclouds@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 28 18:32:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2jLv-0005lW-Tr
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 18:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbbK1Rbg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Nov 2015 12:31:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:34704 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751443AbbK1Rbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 12:31:34 -0500
Received: (qmail 20544 invoked by uid 102); 28 Nov 2015 17:31:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 11:31:34 -0600
Received: (qmail 23682 invoked by uid 107); 28 Nov 2015 17:31:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 12:31:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Nov 2015 12:31:31 -0500
Content-Disposition: inline
In-Reply-To: <5655C14A.1060308@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281794>

On Wed, Nov 25, 2015 at 03:10:18PM +0100, Ren=C3=A9 Scharfe wrote:

> Fix that by doing the comparison using strcmp() and only after the
> branch name is extracted.  This way neither too less nor too many
> characters are checked.  While at it call strchrnul() to find the end
> of the branch name instead of open-coding it.
>=20
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> We can be more careful when parsing -- or avoid parsing and backtrack
> if we found "HEAD" after all.  The latter is simpler, and string
> parsing is tricky enough that we better take such opportunities to
> simplify the code..

Yeah, I think this is nicer. We end up allocating either way anyway, so
the only extra effort is copy the string.

-Peff
