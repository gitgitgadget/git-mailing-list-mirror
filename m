From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] quickfetch(): Prevent overflow of the rev-list command line
Date: Thu, 09 Jul 2009 11:07:46 +0200
Message-ID: <200907091107.46838.johan@herland.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
 <200907091043.03263.johan@herland.net> <4A55AF88.3090205@viscovery.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 11:08:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOpcE-0004JP-3p
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 11:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758433AbZGIJHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 05:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbZGIJHt
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 05:07:49 -0400
Received: from mx.getmail.no ([84.208.15.66]:39356 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757207AbZGIJHt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 05:07:49 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI006KZC0Z3G40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 11:07:47 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI0065XC0ZIS30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 11:07:47 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.9.85422
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <4A55AF88.3090205@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122957>

On Thursday 09 July 2009, Johannes Sixt wrote:
> Johan Herland schrieb:
> > Does anybody with Windows/MSYS experience know how this scenario
> > (write() to a terminated process, followed by close()) would play out
> > in msysGit?
>
> The first write() sometimes fails with EPIPE, otherwise it fails with
> EINVAL. All subsequent write()s fail with EINVAL. The setting of SIGPIPE
> is irrelevant because it is unknown to Windows.
>
> There's precedent already in write_or_die.c. You should not write the
> error message for both EPIPE and EINVAL.

Thanks, but what about the subsequent close()? Will it fail with EINVAL? 
EBADF? or will is succeed (like on Linux)?

I will send an updated patch with all fixes, as soon as I know what to do 
about close().


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
