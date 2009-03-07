From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] config: set help text for --bool-or-int
Date: Sat, 7 Mar 2009 17:48:07 -0500
Message-ID: <20090307224807.GA18548@coredump.intra.peff.net>
References: <1236446046-18319-1-git-send-email-peff@peff.net> <1236446046-18319-3-git-send-email-peff@peff.net> <94a0d4530903071307p46092810rb1637bfc853ee4d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 23:49:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg5L2-0008Qb-Bo
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 23:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbZCGWsU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 17:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbZCGWsU
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 17:48:20 -0500
Received: from peff.net ([208.65.91.99]:36652 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbZCGWsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 17:48:20 -0500
Received: (qmail 17751 invoked by uid 107); 7 Mar 2009 22:48:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Mar 2009 17:48:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Mar 2009 17:48:07 -0500
Content-Disposition: inline
In-Reply-To: <94a0d4530903071307p46092810rb1637bfc853ee4d1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112592>

On Sat, Mar 07, 2009 at 11:07:46PM +0200, Felipe Contreras wrote:

> On Sat, Mar 7, 2009 at 7:14 PM, Jeff King <peff@peff.net> wrote:
> > The conversion to parse_opt left this as NULL; on glibc
> > systems, the usage message prints
> >
> > =C2=A0 --bool-or-int =C2=A0 (null)
> >
> > and on other ones, segfaults.
>=20
> Shouldn't then OPT_BIT make sure there is no crash?

Perhaps, but it doesn't (and I assume you mean usage_with_help, as
OPT_BIT is just filling in the struct). It's not clear what a NULL help
parameter should do, though. Hide the option? Show no help description?
There are already ways to accomplish both of those.

> I was surprised when it didn't complain. I thought on making it "" bu=
t
> I wanted to make it visible that there was no documentation for that,
> which is the reason I left it that way.

OK. I think there are really valid options:

  1. it's there with a description (which is what my patch does)

  2. it's there without a description, because it's obvious what it doe=
s
     coming after --bool and --int

  3. it's hidden

I really don't care which. But what is there now is broken.

-Peff
