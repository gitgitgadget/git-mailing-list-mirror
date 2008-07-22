From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow pager of diff command be enabled/disabled
Date: Tue, 22 Jul 2008 00:58:06 -0400
Message-ID: <20080722045806.GD20787@sigill.intra.peff.net>
References: <20080721212849.GB4748@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 06:59:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL9xt-0007O2-CR
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 06:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbYGVE6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 00:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYGVE6J
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 00:58:09 -0400
Received: from peff.net ([208.65.91.99]:4294 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbYGVE6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 00:58:08 -0400
Received: (qmail 2486 invoked by uid 111); 22 Jul 2008 04:58:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 00:58:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 00:58:06 -0400
Content-Disposition: inline
In-Reply-To: <20080721212849.GB4748@blimp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89436>

On Mon, Jul 21, 2008 at 11:28:49PM +0200, Alex Riesen wrote:

> See for example, status and show commands. Besides,
> Documentation/RelNotes-1.6.0.txt mentions that pager.<cmd>
> can be used to enable/disable paging behavior per command.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> 
> Also, really export check_pager_config, which just got another call
> site.

This patch looks correct to me. There are also a bunch of other commands
for which pager.* doesn't work. Basically, anything that doesn't ask for
RUN_SETUP is on its own to set up paging if it wants (because Bad Things
happen when we try to look in the config before setup has been run).

Most of them people probably don't care about (really, who wants paging
by default on git-apply?). But it is yet another hidden inconsistency
from the paging patch.

-Peff
