From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Unification of user message strings
Date: Mon, 19 Mar 2012 16:53:00 -0400
Message-ID: <20120319205300.GA3039@sigill.intra.peff.net>
References: <1332179503-2992-1-git-send-email-vfr@lyx.org>
 <1332179503-2992-2-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:53:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9jZo-0002m1-DF
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 21:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab2CSUxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 16:53:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53761
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422Ab2CSUxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 16:53:05 -0400
Received: (qmail 1949 invoked by uid 107); 19 Mar 2012 20:53:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Mar 2012 16:53:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Mar 2012 16:53:00 -0400
Content-Disposition: inline
In-Reply-To: <1332179503-2992-2-git-send-email-vfr@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193457>

On Mon, Mar 19, 2012 at 06:51:42PM +0100, Vincent van Ravesteijn wrote:

> Rewrite user messages to stick to a uniform style for all messages.
> From the surrounding code, the following guidelines were deduced:
> - messages start with a capital,

I was surprised by this one, as I think we generally use lower-case
messages. Grepping shows that lower-case has a slight edge, though it i=
s
far from decided:

  $ git grep -E '(error|die)\((_\()?"[A-Z]' | wc -l
  810
  $ git grep -E '(error|die)\((_\()?"[a-z]' | wc -l
  1267

-Peff

PS I was curious if it was simply that some people prefer one way and
   not the other, but the results are quite mixed. Below is the result
   of a small script I wrote that calculates "upper-casedness" per
   author using the above regexes and git-blame.

   The first number is the percentage of an author's messages starting
   with upper-case characters, followed by the total number of messages
   for that author, followed by the author's name. I limited the output
   to the top 20 by total number, as there is a long tail of people
   contributing just a few messages.

      0.14 37 Martin Koegler
      0.14 42 Johannes Sixt
      0.14 81 Jonathan Nieder
      0.16 31 Pierre Habouzit
      0.18 92 Nicolas Pitre
      0.20 66 Jeff King
      0.20 87 Linus Torvalds
      0.26 348 Junio C Hamano
      0.35 20 Christian Couder
      0.37 43 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
      0.39 18 Ren=C3=A9 Scharfe
      0.41 32 Miklos Vajna
      0.45 270 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
      0.47 129 Shawn O. Pearce
      0.50 36 David Barr
      0.54 57 Johannes Schindelin
      0.62 39 Ramkumar Ramachandra
      0.67 21 Daniel Barkalow
      0.76 59 Johan Herland

   You can see that some people are usually lowercase and some are usua=
lly
   uppercase, but there are many people near 50%, doing both equally.
   There's also some inaccuracy in my simplistic sampling. For example,
   of my 13 upper-case messages, 11 of them are "BUG:".
