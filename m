From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/7] add description parameter to OPT__QUIET
Date: Mon, 8 Nov 2010 13:18:01 -0500
Message-ID: <20101108181801.GB30428@sigill.intra.peff.net>
References: <4CD83917.3040801@lsrfire.ath.cx>
 <4CD83ABD.30804@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:17:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFWHJ-0005du-N5
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab0KHSRH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 13:17:07 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48372 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab0KHSRG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:17:06 -0500
Received: (qmail 30907 invoked by uid 111); 8 Nov 2010 18:17:05 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 08 Nov 2010 18:17:05 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Nov 2010 13:18:01 -0500
Content-Disposition: inline
In-Reply-To: <4CD83ABD.30804@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160962>

On Mon, Nov 08, 2010 at 07:00:29PM +0100, Ren=C3=A9 Scharfe wrote:

> Allows better help text to be defined than "be quiet".  Also make use
> of the macro in a place that already had a different description.  No
> object code changes intended.

Maybe my "don't repeat yourself" spider sense is over-reacting, but of
12 callsites, 11 of them will continue to use "be quiet". Maybe instead
of:

> -#define OPT__QUIET(var)    OPT_BOOLEAN('q', "quiet",   (var), "be qu=
iet")
> +#define OPT__QUIET(var, h)    OPT_BOOLEAN('q', "quiet",   (var), (h)=
)

we could have:

  #define OPT__QUIET_H(var, h) OPT_BOOLEAN('q', "quiet", (var), (h))
  #define OPT__QUIET(var) OPT__QUIET_H(var, "be quiet")

which would limit your patch to changing a single callsite.

-Peff
