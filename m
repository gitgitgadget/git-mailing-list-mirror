From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/4] match-trees: drop "x = x" initializations
Date: Sun, 24 Mar 2013 06:01:36 -0400
Message-ID: <20130324100136.GA28884@sigill.intra.peff.net>
References: <20130322161837.GG3083@sigill.intra.peff.net>
 <20130322162155.GB25857@sigill.intra.peff.net>
 <514DFB1A.8040102@lsrfire.ath.cx>
 <7vli9d4crq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 11:02:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJhku-0000iO-HE
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 11:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421Ab3CXKBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 06:01:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37770 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754309Ab3CXKBr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 06:01:47 -0400
Received: (qmail 15097 invoked by uid 107); 24 Mar 2013 10:03:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Mar 2013 06:03:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Mar 2013 06:01:36 -0400
Content-Disposition: inline
In-Reply-To: <7vli9d4crq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218947>

On Sat, Mar 23, 2013 at 09:55:53PM -0700, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
> > Hmm, let's see if we can help the compiler follow the code without
> > making it harder for people to understand.  The patch looks a bit
> > jumbled, but the resulting code is OK in my biased opinion.
>=20
> I actually think the result is much better than a mere "OK"; the
> duplicated "at this point we know path1 (or path2) is missing from
> the other side" has been bothering me and I was about to suggest a
> similar rewrite before I read your message ;-)
>=20
> However, the same compiler still thinks {elem,path,mode}1 can be
> used uninitialized (but not {elem,path,mode}2).  The craziness I
> reported in the previous message is also the same.  With this patch
> on top to swap the side we inspect first, the compiler thinks
> {elem,path,mode}2 can be used uninitialized but not the other three
> variables X-<.

Yeah, I'd agree that the result is more readable, but it does not
address the original problem. Junio, do you want to drop my patch,
squash the initialization of mode into Ren=C3=A9's version, and just ad=
d a
note to the commit message that we still have to deal with the gcc
warning?

-Peff
