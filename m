From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-import: use hashcmp() for SHA1 hash comparison
Date: Fri, 18 Jul 2014 19:57:08 -0400
Message-ID: <20140718235706.GA11192@peff.net>
References: <53C944B3.5080106@web.de>
 <20140718184246.GS12427@google.com>
 <53C971FD.6040500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 19 01:57:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8I1f-0005Mo-6K
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 01:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbaGRX5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 19:57:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:36180 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbaGRX5M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 19:57:12 -0400
Received: (qmail 5145 invoked by uid 102); 18 Jul 2014 23:57:12 -0000
Received: from mobile-166-194-028-117.mycingular.net (HELO sigill.intra.peff.net) (166.194.28.117)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Jul 2014 18:57:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jul 2014 19:57:08 -0400
Content-Disposition: inline
In-Reply-To: <53C971FD.6040500@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253858>

On Fri, Jul 18, 2014 at 09:14:05PM +0200, Ren=C3=A9 Scharfe wrote:

> If inlining is really better is another matter; I don't understand ho=
w
> 1a812f3a (hashcmp(): inline memcmp() by hand to optimize) could have =
made
> git gc 18% faster, as it claimed.  I would expect memcmp(), which can
> compare more than a byte at a time, to be significantly faster -- or =
at
> least just as fast as whatever the compiler does with the inlined ver=
sion.

I looked into this a while ago[1]. I think with glibc 2.13 and up, the
memcmp is a win. We should consider switching back if that is what is
common now.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/218396
