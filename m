From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 1/3] Introduce die_errno() that appends strerror(errno) to die()
Date: Sat, 6 Jun 2009 22:56:31 +0200
Message-ID: <200906062256.34074.trast@student.ethz.ch>
References: <cover.1244299302.git.trast@student.ethz.ch> <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch> <200906062236.42858.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 22:56:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD2wc-0007v8-RH
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 22:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbZFFU4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 16:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbZFFU4h
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 16:56:37 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:7860 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbZFFU4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 16:56:36 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Jun 2009 22:56:22 +0200
Received: from thomas.localnet ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Jun 2009 22:56:22 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.27.21-0.1-default; KDE/4.2.3; x86_64; ; )
In-Reply-To: <200906062236.42858.j6t@kdbg.org>
Content-Disposition: inline
X-OriginalArrivalTime: 06 Jun 2009 20:56:22.0404 (UTC) FILETIME=[3F824440:01C9E6E9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120936>

Johannes Sixt wrote:
> On Samstag, 6. Juni 2009, Thomas Rast wrote:
> > +void die_errno(const char *err, ...)
> > +{
> > +	va_list params;
> > +	char msg[1024];
> > +
> > +	va_start(params, err);
> > +
> > +	vsnprintf(msg, sizeof(msg), err, params);
> > +	die("%s: %s", msg, strerror(errno));
> 
> Cannot vsnprintf potentially modify errno?

Manpage turns up nothing, so AFAICT, no.

> > +
> > +	va_end(params);
> 
> This va_end should better be before die().

Not that I object to changing it, but out of curiosity, what do I
break by putting it after?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
