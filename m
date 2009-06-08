From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] Introduce die_errno() that appends
	strerror(errno) to die()
Date: Mon, 8 Jun 2009 18:07:13 -0400
Message-ID: <20090608220713.GB29942@sigill.intra.peff.net>
References: <cover.1244299302.git.trast@student.ethz.ch> <cover.1244494646.git.trast@student.ethz.ch> <5f43aa9d0b69e99600a73bddd4c93217608ab661.1244494647.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDmzy-0002k3-BT
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 00:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbZFHWHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 18:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZFHWHN
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 18:07:13 -0400
Received: from peff.net ([208.65.91.99]:47664 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbZFHWHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 18:07:12 -0400
Received: (qmail 24430 invoked by uid 107); 8 Jun 2009 22:07:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 08 Jun 2009 18:07:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 18:07:13 -0400
Content-Disposition: inline
In-Reply-To: <5f43aa9d0b69e99600a73bddd4c93217608ab661.1244494647.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121121>

On Mon, Jun 08, 2009 at 11:02:18PM +0200, Thomas Rast wrote:

> +void die_errno(const char *fmt, ...)
> +{
> +	va_list params;
> +	char fmt_with_err[1024];
> +
> +	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, strerror(errno));
> +
> +	va_start(params, fmt);
> +	die_routine(fmt_with_err, params);
> +	va_end(params);
> +}

Aren't you assuming that strerror(errno) has no '%'-signs here, which is
what kicked off the whole discussion?

-Peff
