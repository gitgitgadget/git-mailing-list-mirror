From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC v3 7/9] write_entry(): use fstat() instead of lstat()
 when file is open
Date: Thu, 5 Feb 2009 12:03:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902051202440.7491@intel-tinevez-2-302>
References: <cover.1233751281.git.barvik@broadpark.no> <21073c1f3f6c2c81b26a632f495325f5e7a7de5a.1233751281.git.barvik@broadpark.no> <49899FA4.2020003@viscovery.net> <7vfxiut57t.fsf@gitster.siamese.dyndns.org> <86tz7ayo51.fsf_-_@broadpark.no>
 <498A9FD3.2020601@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kjetil Barvik <barvik@broadpark.no>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 12:05:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV23J-0003cQ-M0
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 12:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbZBELDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 06:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbZBELDv
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 06:03:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:43199 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751476AbZBELDu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 06:03:50 -0500
Received: (qmail invoked by alias); 05 Feb 2009 11:03:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp047) with SMTP; 05 Feb 2009 12:03:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196c3t5zjZ6g14f0MiTKurM7ZD62zu/efTioNh5L4
	EYyv11BOpEAixc
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <498A9FD3.2020601@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108550>

Hi,

On Thu, 5 Feb 2009, Johannes Sixt wrote:

> Kjetil Barvik schrieb:
> >   And, yes, since each lstat() call cost approximately 44 microseconds
> >   compared to 12-16 for each lstat() on my Linux box, there was a little
>                                ^^^^^^^ fstat()?
> >   performance gain from this patch.
> 
> This does look like a good gain. But do you have hard numbers that back
> the claim?
> 
> If you can squeeze out a 10% improvement on Linux with this patch, we
> should take it, and if it turns out that it doesn't work on Windows, we
> could trivially throw in an #ifdef MINGW (or even #ifdef WIN32 if Cygwin
> is affected, too) that skips the fstat() optimization.

Of course, what we _really_ would do is to provide a flag, say, 
FSTAT_UNRELIABLE and test for _that_ (after defining it in the Makefile 
for the appropriate platforms).

Ciao,
Dscho
