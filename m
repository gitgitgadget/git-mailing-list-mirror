From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] config: drop file pointer validity check in
 get_next_char()
Date: Tue, 26 Feb 2013 15:05:56 -0500
Message-ID: <20130226200556.GB13830@sigill.intra.peff.net>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
 <20130226193050.GA22756@sandbox-ub>
 <20130226194023.GC22756@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:06:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQnC-0006es-7n
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 21:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759781Ab3BZUGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 15:06:00 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33211 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756619Ab3BZUGA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 15:06:00 -0500
Received: (qmail 9884 invoked by uid 107); 26 Feb 2013 20:07:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Feb 2013 15:07:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2013 15:05:56 -0500
Content-Disposition: inline
In-Reply-To: <20130226194023.GC22756@sandbox-ub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217171>

On Tue, Feb 26, 2013 at 08:40:23PM +0100, Heiko Voigt wrote:

> The only location where cf is set in this file is in do_config_from().
> This function has only one callsite which is config_from_file(). In
> config_from_file() its ensured that the f member is set to non-zero.

Makes sense, although...

> -	if (cf && ((f = cf->f) != NULL)) {
> +	if (cf) {
> +		FILE *f = cf->f;

Couldn't we say the same thing about "cf" here (i.e., that it would
never be NULL)? Can we just get rid of this conditional entirely?

-Peff
