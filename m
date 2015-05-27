From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/WIP 1/8] wrapper: implement xopen()
Date: Wed, 27 May 2015 17:53:07 -0400
Message-ID: <20150527215307.GC23259@peff.net>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
 <1432733618-25629-2-git-send-email-pyokagan@gmail.com>
 <55661513.8000306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed May 27 23:53:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxjGF-0005p7-2l
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 23:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbbE0VxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 17:53:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:36927 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750922AbbE0VxK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 17:53:10 -0400
Received: (qmail 16836 invoked by uid 102); 27 May 2015 21:53:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:53:09 -0500
Received: (qmail 10971 invoked by uid 107); 27 May 2015 21:53:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 17:53:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 17:53:07 -0400
Content-Disposition: inline
In-Reply-To: <55661513.8000306@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270103>

On Wed, May 27, 2015 at 09:03:47PM +0200, Torsten B=C3=B6gershausen wro=
te:

> The original open can take 2 or 3 parameters, how about this:
> int xopen(const char *path, int oflag, ... )
> {
>         va_list params;
>         int mode;
>         int fd;
>=20
>         va_start(params, oflag);
>         mode =3D va_arg(params, int);
>         va_end(params);
>=20
>         fd =3D open(path, oflag, mode);

Don't you need a conditional on pulling the mode arg off the stack
(i.e., if O_CREAT is in the flags)?

-Peff
