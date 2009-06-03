From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Fix warnings in nedmalloc when compiling with GCC
 4.4.0
Date: Wed, 3 Jun 2009 14:57:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906031455520.10241@intel-tinevez-2-302>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-2-git-send-email-prohaska@zib.de> <1243786525-4493-3-git-send-email-prohaska@zib.de> <1243786525-4493-4-git-send-email-prohaska@zib.de> <1243786525-4493-5-git-send-email-prohaska@zib.de>
 <1243786525-4493-6-git-send-email-prohaska@zib.de> <1243786525-4493-7-git-send-email-prohaska@zib.de> <1243786525-4493-8-git-send-email-prohaska@zib.de> <1243786525-4493-9-git-send-email-prohaska@zib.de> <1243786525-4493-10-git-send-email-prohaska@zib.de>
 <1243786525-4493-11-git-send-email-prohaska@zib.de> <7vhbz0mmai.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de> <7vr5y3lxrj.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906021448300.4440@intel-tinevez-2-302>
 <7viqjefxcv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 14:57:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBq1v-0005L7-9j
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 14:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbZFCM5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 08:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbZFCM5I
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 08:57:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:45257 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753054AbZFCM5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 08:57:07 -0400
Received: (qmail invoked by alias); 03 Jun 2009 12:57:07 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp029) with SMTP; 03 Jun 2009 14:57:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/YKFQYnkPYCHrpbuxfqog5hjQGsn9KlUsJ40P/6Y
	ToGA6eJWqfFLnS
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7viqjefxcv.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120608>

Hi,

On Tue, 2 Jun 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Okay, how about this in the commit body in addition?
> >
> > -- snip --
> > Nedmalloc's source code has a cute #define construct to avoid inserting
> > an if() statement, because that might interact badly with enclosing if()
> > statements.  However, there is no danger of that now, but GCC > 4
> > complains "warning: value computed is not used".
> >
> > Also, with the version of MinGW's headers in msysGit, we need to include 
> > malloc.h lest the compiler complain about an "incompatible implicit 
> > declaration of built-in function 'alloca'".
> > -- snap --
> >
> > Hmm?
> 
> As to the first one, I think your problem description is clear (the
> problem is clear without being explained to begin with) but "there is no
> danger of that now" is somewhere between a lame excuse for not doing it
> the right way and a bug waiting to happen.  If "value computed is not
> used" is the issue, why doesn't this work?
> 
>     #define ensure_initialization() (void)(mparams.magic != 0 || init_mparams())

That works.

> As to the second one, I think you lost "even if we happen to" part (that
> logically corresponds to "... that is why we do not want to limit the
> inclusion to !__MINGW32__ case") from the description, making it less
> readable...

You mean "even if we happen to be on Windows"?  Fine with me.  Want me to 
resend a fixed patch?

Ciao,
Dscho
