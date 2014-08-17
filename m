From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] run-command: introduce CHILD_PROCESS_INIT
Date: Sun, 17 Aug 2014 03:12:31 -0400
Message-ID: <20140817071230.GB23808@peff.net>
References: <53EFE15B.7030805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 09:12:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIudp-0007yE-JU
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 09:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbaHQHMd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2014 03:12:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:53514 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750808AbaHQHMc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 03:12:32 -0400
Received: (qmail 5205 invoked by uid 102); 17 Aug 2014 07:12:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 02:12:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 03:12:31 -0400
Content-Disposition: inline
In-Reply-To: <53EFE15B.7030805@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255349>

On Sun, Aug 17, 2014 at 12:55:23AM +0200, Ren=C3=A9 Scharfe wrote:

> Most struct child_process variables are cleared using memset right af=
ter
> declaration.  Provide a macro, CHILD_PROCESS_INIT, that can be used t=
o
> initialize them statically instead.  That's shorter, doesn't require =
a
> function call and is slightly more readable (especially given that we
> already have similar macros like STRBUF_INIT, ARGV_ARRAY_INIT etc.).

I think one reason we never had an INIT macro here is that you cannot
simply use the struct after zero-ing it anyway. That's just the first
step, and then you have to tweak a bunch of fields to get what you want=
=2E
So the memset is just one setup line out of many.

Still, I think this is probably an improvement for the reasons you give
above, and we can still memset() in any cases where it makes sense.

Patch itself looks obviously correct.

-Peff
