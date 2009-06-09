From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Expand the rename(2) workaround in mingw to cover case
  change in filename
Date: Tue, 9 Jun 2009 09:27:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906090924170.26154@pacific.mpi-cbg.de>
References: <20090608203248.GA22972@blimp.localdomain>  <alpine.DEB.1.00.0906082355350.26154@pacific.mpi-cbg.de>  <81b0412b0906081508v5435c59cm3faf3ac92a56578c@mail.gmail.com>  <4A2DF92D.1080605@viscovery.net>
 <81b0412b0906082304x750eb8cif3356458829de3bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-100354873-1244532455=:26154"
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 09:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDvjN-0003l4-Id
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 09:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757435AbZFIH0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 03:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755834AbZFIH0g
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 03:26:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:41843 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752295AbZFIH0g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 03:26:36 -0400
Received: (qmail invoked by alias); 09 Jun 2009 07:26:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 09 Jun 2009 09:26:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Wrskxe9dWFsbKtbY0cjALXl1tawB0P4ZzDJN5IW
	DRaGuZaqMkfgxg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81b0412b0906082304x750eb8cif3356458829de3bc@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121148>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-100354873-1244532455=:26154
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 9 Jun 2009, Alex Riesen wrote:

> 2009/6/9 Johannes Sixt <j.sixt@viscovery.net>:
> > Alex Riesen schrieb:
> >> 2009/6/8 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >>> On Mon, 8 Jun 2009, Alex Riesen wrote:
> >>>> NOT TESTED. Can't. My Windows broke again. Not even compile-tested.
> >>> Yes, that is pretty easy to see as you first used pold/pnew and then
> >>> src/dst.
> >>
> >> Yep.
> >>
> >>> I minimally fixed up your patch (it now uses strbuf), and added a
> >>> test-case.
> >>>
> >>> This test-case is actually crucial: it shows that your patch is not
> >>> enough: the culprit is this code in builtin-mv.c:167--168:
> >>>
> >>>                else if (lstat(dst, &st) == 0) {
> >>>                        bad = "destination exists";
> >>
> >> Ah, thanks. Missed that completely.
> >
> > That's the reason why I think any work-around for this problem is not
> > worth it.
> 
> What is the lstat is for, anyway?

It is to avoid overwriting existing files.

> > If you want to be cross-platfrom, make up your mind about file names 
> > in advance.
> 
> I suspect it is the other way around. Some platforms just hate the idea 
> of being ported to. Or its designers have poor imagination and never 
> though about the fact that other platforms exist.

Actually, think about it as a brilliant business plan: make developers be 
stuck with developing for your platform, then they lack the time to take 
care of other platforms.

The bigger question with the patch is if the lstat() call can tell us 
if this is the same file (really the same, not just a hardlink (= same 
contents)).

Ciao,
Dscho

--8323328-100354873-1244532455=:26154--
