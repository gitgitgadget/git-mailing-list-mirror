From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 6 Mar 2008 11:55:05 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061153400.15786@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>  <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at>  <alpine.LSU.1.00.0802281159550.22527@racer.site>  <200803052221.12495.johannes.sixt@telecom.at>  <alpine.LSU.1.00.0803052317350.15786@racer.site>
  <7vir00lski.fsf@gitster.siamese.dyndns.org>  <alpine.LSU.1.00.0803052327570.15786@racer.site>  <alpine.LSU.1.00.0803060212170.15786@racer.site>  <20080306063331.GA7325@glandium.org> <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 11:56:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDld-0003KI-V1
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761072AbYCFKzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 05:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758595AbYCFKzH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:55:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:44106 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758189AbYCFKzF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 05:55:05 -0500
Received: (qmail invoked by alias); 06 Mar 2008 10:55:04 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp031) with SMTP; 06 Mar 2008 11:55:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IL6c0B1lIYzBFd/R3VzvZX+7pv3ka3KWOexNT+v
	koWT7ghmE9mUZ/
X-X-Sender: gene099@racer.site
In-Reply-To: <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76370>

Hi,

On Thu, 6 Mar 2008, Reece Dunn wrote:

> On 06/03/2008, Mike Hommey <mh@glandium.org> wrote:
> > On Thu, Mar 06, 2008 at 02:14:43AM +0100, Johannes Schindelin wrote:
> >  >
> >  > The most common use of addf() was to init a strbuf and addf() right 
> >  > away. Since it is so common, it makes sense to have a function 
> >  > strbuf_initf() to wrap both calls into one.
> >  >
> >  > Unfortunately, C (and cpp) has no way to make this easy without 
> >  > code duplication, as we need to va_init() in strbuf_addf() possibly 
> >  > a few times.  So the code for addf() is copied.  Fortunately, the 
> >  > code is pretty short, so not too much had to be copied as-is.
> >
> >
> > The problem with code duplication is not about code size, but more 
> > about not forgetting to fix bugs in all incarnations of the duplicated 
> > code.
> >
> > Is it so ugly to use a macro ?
> 
> Why not have a strbuf_vaddf and strbuf_vinitf that take a va_arg as a 
> parameter. This would mean that you don't have code duplication, and it 
> is flexible enough if you want to add more customisations in the future. 
> No macro needed. This is what the printf/scanf family of functions do.

The problem is that we have to restart va_list() if the buffer was too 
small.

So your suggestion is out, unless you suggest to implement the whole 
printf mechanism... which I hope you're not.

Ciao,
Dscho

