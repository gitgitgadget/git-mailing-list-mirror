From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] Support building on systems without poll(2)
Date: Thu, 27 May 2010 09:02:22 -0400
Message-ID: <20100527130221.GA1672@coredump.intra.peff.net>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
 <1274948384-167-2-git-send-email-abcd@gentoo.org>
 <AANLkTikoFSMmAyCYPoejTObEmCMv4TmTDx7P4sdWcOJy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, jrnieder@gmail.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 15:02:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHcjH-0000Aw-Fc
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 15:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab0E0NC0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 09:02:26 -0400
Received: from peff.net ([208.65.91.99]:55171 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039Ab0E0NCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 09:02:25 -0400
Received: (qmail 20535 invoked by uid 107); 27 May 2010 13:02:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 27 May 2010 09:02:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 May 2010 09:02:22 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikoFSMmAyCYPoejTObEmCMv4TmTDx7P4sdWcOJy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147851>

On Thu, May 27, 2010 at 10:43:35AM +0200, Sverre Rabbelier wrote:

> On Thu, May 27, 2010 at 10:19, Jonathan Callen <abcd@gentoo.org> wrot=
e:
> > Some systems do not have sys/poll.h or poll(2). =C2=A0Don't build
> > git-daemon, git-upload-archive, or git-upload-pack on such systems.
>=20
> I thought git-upload-pack is required for push support in git?

No, that's send-pack. Upload-pack is the server side of fetching. And
yes, these names are confusing. Before I worked a lot on the send-pack
code, I used to mix them up all the time. :)

So without upload-pack, one cannot be the server side of a fetch. Which
means you can still work as a client, but it does mean that even local
clones won't work (actually, the clone will work due to the local
hardlink optimization, but further fetches will fail).

-Peff
