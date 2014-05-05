From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Silence a bunch of format-zero-length warnings
Date: Mon, 5 May 2014 01:21:17 -0400
Message-ID: <20140505052117.GC6569@sigill.intra.peff.net>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
 <1399183975-2346-4-git-send-email-felipe.contreras@gmail.com>
 <20140504190121.GP75770@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 18:10:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhsv-0005Yp-Tv
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461AbaEEFVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2014 01:21:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:45081 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754411AbaEEFVT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 01:21:19 -0400
Received: (qmail 20800 invoked by uid 102); 5 May 2014 05:21:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 May 2014 00:21:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2014 01:21:17 -0400
Content-Disposition: inline
In-Reply-To: <20140504190121.GP75770@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248118>

On Sun, May 04, 2014 at 07:01:22PM +0000, brian m. carlson wrote:

> On Sun, May 04, 2014 at 01:12:55AM -0500, Felipe Contreras wrote:
> > This is in gcc 4.9.0:
> >=20
> >   wt-status.c: In function =E2=80=98wt_status_print_unmerged_header=
=E2=80=99:
> >   wt-status.c:191:2: warning: zero-length gnu_printf format string =
[-Wformat-zero-length]
> >     status_printf_ln(s, c, "");
> >     ^
> >=20
> > We could pass -Wno-format-zero-length, but it seems compiler-specif=
ic
> > flags are frowned upon, so let's just avoid the warning altogether.
>=20
> I believe these warnings existed before GCC 4.9 as well, but I'm not
> opposed to the change.

Yeah, this started last summer when we added __attribute__((format)) to
the status_printf_ln calls, and I posted essentially the same patch.  W=
e
kind of waffled between "eh, just set -Wno-format-zero-length" and doin=
g
something, and ended up at the former. I'd be fine with doing it this
way; we're not likely to add a lot of new callsites that would make it =
a
hassle to keep up with.

-Peff
