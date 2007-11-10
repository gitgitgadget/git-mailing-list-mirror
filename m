From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Fri, 9 Nov 2007 19:51:45 -0500
Message-ID: <20071110005145.GC14992@sigill.intra.peff.net>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045256.GD31760@sigill.intra.peff.net> <4734EB36.2030408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Nov 10 01:52:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqeaI-0000aw-Nl
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 01:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854AbXKJAv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 19:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755724AbXKJAv5
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 19:51:57 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2967 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbXKJAv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 19:51:56 -0500
Received: (qmail 20706 invoked by uid 111); 10 Nov 2007 00:51:52 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 09 Nov 2007 19:51:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2007 19:51:45 -0500
Content-Disposition: inline
In-Reply-To: <4734EB36.2030408@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64291>

On Sat, Nov 10, 2007 at 12:20:22AM +0100, Ren=E9 Scharfe wrote:

> > This void cast is pointless, since all pointers types convert impli=
citly
> > to void pointers anyway. At best, it does nothing, and at worst, it
> > hides an actual type error if the function signature or the type of
> > 'commit' change.
>=20
> When commit (of type const struct commit*) is implicitly converted to
> void *, gcc complains because the "const" qualifier is silently dropp=
ed.

Bleh. You're right, of course. I don't like casting away constness, but
it is stupid for strbuf_expand to take a "const void *" since it has no
idea how it will be used (although I note your caching patch also neatl=
y
does away with this, anyway).

-Peff
