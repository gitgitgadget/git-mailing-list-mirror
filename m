From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] lockfile: reset the correct signal
Date: Mon, 26 May 2008 22:36:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805262234210.30431@racer>
References: <20080522195546.GA29911@localhost> <7vod6wr95y.fsf@gitster.siamese.dyndns.org> <20080523221723.GA4366@localhost> <20080525182650.GA17806@localhost> <alpine.DEB.1.00.0805261031480.30431@racer> <20080526193513.GA9978@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon May 26 23:37:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0kNn-0001Hg-7W
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 23:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853AbYEZVgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 17:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754835AbYEZVgj
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 17:36:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:45295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754672AbYEZVgj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 17:36:39 -0400
Received: (qmail invoked by alias); 26 May 2008 21:36:37 -0000
Received: from R105f.r.pppool.de (EHLO racer.local) [89.54.16.95]
  by mail.gmx.net (mp003) with SMTP; 26 May 2008 23:36:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CaFUiSGyC2B85WGbO/Y3MkvyR99DLt5Yv/Baw03
	YReL64Abi12Pbv
X-X-Sender: gene099@racer
In-Reply-To: <20080526193513.GA9978@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82960>

Hi,

On Mon, 26 May 2008, Clemens Buchacher wrote:

> In the function remove_lock_file_on_signal(), the signal handler
> for SIGINT was reset, ignoring the parameter signo.
> 
> This did not pose a problem yet, as remove_lock_file_on_signal()
> was only registered as a SIGINT handler.
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
> 
> On Mon, May 26, 2008 at 10:34:11AM +0100, Johannes Schindelin wrote:
> > Only from the patch did I understand that you actually meant:
> 
> Thank you for fixing that.

Unfortunately, the original patch is already in git.git.

> I also realized that using signals like that can cause races. Shouldn't 
> we use sigaction() instead of signal()?

Dunno.  The man page suggests it, but we have plenty of cases where we use 
signal().  And I think it might be less painful to implement a 
compat-wrapper for the platforms which differ from Linux' interpretation 
of signal().

Ciao,
Dscho
