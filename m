From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: don't segfault when given --path with a missing
 value
Date: Thu, 15 Nov 2012 10:15:28 -0800
Message-ID: <20121115181527.GA22506@sigill.intra.peff.net>
References: <20121115161758.GC6157@sigill.intra.peff.net>
 <1353003001-22600-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 19:15:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ3yd-0006xB-45
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 19:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768649Ab2KOSPd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 13:15:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49653 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768630Ab2KOSPc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 13:15:32 -0500
Received: (qmail 19106 invoked by uid 107); 15 Nov 2012 18:16:19 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 13:16:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 10:15:28 -0800
Content-Disposition: inline
In-Reply-To: <1353003001-22600-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209838>

On Thu, Nov 15, 2012 at 10:10:01AM -0800, Carlos Mart=C3=ADn Nieto wrot=
e:

> When given a variable without a value, such as '[section] var' and
> asking git-config to treat it as a path, git_config_pathname returns
> an error and doesn't modify its output parameter. show_config assumes
> that the call is always successful and sets a variable to indicate
> that vptr should be freed. In case of an error however, trying to do
> this will cause the program to be killed, as it's pointing to memory
> in the stack.
>=20
> Detect the error and return immediately to avoid freeing or accessing
> the uninitialed memory in the stack.
>=20
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

Acked-by: Jeff King <peff@peff.net>

> Yeah, that's more sensible. I didn't notice that the buffer never get=
s
> written to in this codepath, and the trying to print it out is silly
> when we know that there is nothing valid to print.

> Thanks for the review. I've included your test as well, which really
> makes all of this your code.

Eh, I guess so. You did the hard part of finding it, though. ;)

> Do we have some equivalent of a Basically-writen-by line?

Nothing structured. But I am comfortable enough with the number of time=
s
I am mentioned in "git log" already, so don't worry about it.

-Peff
