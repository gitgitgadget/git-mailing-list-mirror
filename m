From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Replacing the system call pread() with lseek()/xread()/lseek()
 sequence.
Date: Wed, 10 Jan 2007 00:42:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701100041310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: 7v1wm4kl24.fsf@assigned-by-dhcp.cox.net <11683766523955-git-send-email->
 <11683766521544-git-send-email-> <45A40C15.1070200@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 00:42:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4QcK-0005XM-Kq
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbXAIXmy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbXAIXmy
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:42:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:58897 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932539AbXAIXmx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:42:53 -0500
Received: (qmail invoked by alias); 09 Jan 2007 23:42:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 10 Jan 2007 00:42:52 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <45A40C15.1070200@shadowen.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36426>

Hi,

On Tue, 9 Jan 2007, Andy Whitcroft wrote:

> Stefan-W. Hahn wrote:
>
> > +        if (current_offset != lseek(fd, current_offset, SEEK_SET))
> > +                return -1;
> 
> How likely are we ever to be in the right place here?

You mean something like

	if (current_offset != offset + count &&
			current_offset != lseek(fd, current_offset, SEEK_SET))
		return -1;

instead? Seems cheap enough.

Ciao,
Dscho
