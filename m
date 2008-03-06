From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 6 Mar 2008 11:53:28 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061148180.15786@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <200803052221.12495.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803052317350.15786@racer.site>
 <7vir00lski.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803052327570.15786@racer.site> <alpine.LSU.1.00.0803060212170.15786@racer.site> <20080306063331.GA7325@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 11:54:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDjw-0002jy-IX
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448AbYCFKxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 05:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757883AbYCFKx3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:53:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:56943 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755992AbYCFKx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 05:53:28 -0500
Received: (qmail invoked by alias); 06 Mar 2008 10:53:26 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp049) with SMTP; 06 Mar 2008 11:53:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18mMw5WvRsmM6b2rPEkBW74UIR4pSbQ0UDZDKd2Qp
	F0tViRBNJgA1zg
X-X-Sender: gene099@racer.site
In-Reply-To: <20080306063331.GA7325@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76369>

Hi,

On Thu, 6 Mar 2008, Mike Hommey wrote:

> On Thu, Mar 06, 2008 at 02:14:43AM +0100, Johannes Schindelin wrote:
> > 
> > The most common use of addf() was to init a strbuf and addf() right 
> > away. Since it is so common, it makes sense to have a function 
> > strbuf_initf() to wrap both calls into one.
> > 
> > Unfortunately, C (and cpp) has no way to make this easy without code 
> > duplication, as we need to va_init() in strbuf_addf() possibly a few 
> > times.  So the code for addf() is copied.  Fortunately, the code is 
> > pretty short, so not too much had to be copied as-is.
> 
> The problem with code duplication is not about code size, but more about 
> not forgetting to fix bugs in all incarnations of the duplicated code.

Yes, I know.

> Is it so ugly to use a macro ?

AFAIR it is unportable to have a macro

#define strbuf_initf(buf, fmt, ...) \
	(strbuf_init(buf, strlen(fmt) + 64), strbuf_addf(buf, fmt, args);) 

(GNU cpp groks it, but what about the others?)

Or you mean the whole body of the implementation of strbuf_addf()?  Now, 
_that_ would be ugly.

Ciao,
Dscho

