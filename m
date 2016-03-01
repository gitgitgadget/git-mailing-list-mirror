From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] compat/mingw: brown paper bag fix for 50a6c8e
Date: Tue, 1 Mar 2016 00:54:57 -0500
Message-ID: <20160301055457.GA1359@sigill.intra.peff.net>
References: <56D3E56A.5010608@web.de>
 <20160229092816.GA23910@sigill.intra.peff.net>
 <56D415C6.2040203@web.de>
 <20160229100258.GC2950@sigill.intra.peff.net>
 <xmqqtwkr9vu6.fsf@gitster.mtv.corp.google.com>
 <20160229213620.GD25342@sigill.intra.peff.net>
 <56D52D77.1030406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 01 06:55:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aadH1-0007rW-7l
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 06:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbcCAFzB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2016 00:55:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:52235 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750771AbcCAFzA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 00:55:00 -0500
Received: (qmail 4083 invoked by uid 102); 1 Mar 2016 05:55:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 00:55:00 -0500
Received: (qmail 5071 invoked by uid 107); 1 Mar 2016 05:55:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 00:55:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 00:54:57 -0500
Content-Disposition: inline
In-Reply-To: <56D52D77.1030406@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287999>

On Tue, Mar 01, 2016 at 06:49:43AM +0100, Torsten B=C3=B6gershausen wro=
te:

> However, suspecting jk/epipe-in-async, I don't know if we can do
> something against this warning:
>=20
>  CC run-command.o
> run-command.c: In function 'async_exit':
> run-command.c:631:1: warning: 'noreturn' function does return
>  }
>  ^

The only thing that function does is call pthread_exit(), which should
also be marked NORETURN. Looks like the one in compat/win32/pthread.h
isn't?

-Peff
