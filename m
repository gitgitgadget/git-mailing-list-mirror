From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/3] Introduce die_errno() that appends strerror(errno) to die()
Date: Sat, 6 Jun 2009 22:36:42 +0200
Message-ID: <200906062236.42858.j6t@kdbg.org>
References: <cover.1244299302.git.trast@student.ethz.ch> <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 06 22:37:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD2dP-0001lO-K1
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 22:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbZFFUgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 16:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZFFUgn
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 16:36:43 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:31403 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbZFFUgm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 16:36:42 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 49FBC1000B;
	Sat,  6 Jun 2009 22:36:43 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EDD773BDFC;
	Sat,  6 Jun 2009 22:36:42 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120934>

On Samstag, 6. Juni 2009, Thomas Rast wrote:
> +void die_errno(const char *err, ...)
> +{
> +	va_list params;
> +	char msg[1024];
> +
> +	va_start(params, err);
> +
> +	vsnprintf(msg, sizeof(msg), err, params);
> +	die("%s: %s", msg, strerror(errno));

Cannot vsnprintf potentially modify errno?

> +
> +	va_end(params);

This va_end should better be before die().

-- Hannes
