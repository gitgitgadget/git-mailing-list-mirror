From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] spawn pager via run_command interface
Date: Tue, 22 Jul 2008 03:50:35 -0400
Message-ID: <20080722075035.GC3999@sigill.intra.peff.net>
References: <20080722044157.GA20787@sigill.intra.peff.net> <20080722053921.GA4983@glandium.org> <20080722060643.GA25023@sigill.intra.peff.net> <20080722061807.GA6714@glandium.org> <20080722064603.GA25221@sigill.intra.peff.net> <20080722071009.GA3610@sigill.intra.peff.net> <20080722071246.GA3584@sigill.intra.peff.net> <20080722071411.GB3584@sigill.intra.peff.net> <20080722071630.GA3669@sigill.intra.peff.net> <488590B9.1080804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, David Bremner <bremner@unb.ca>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:51:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCel-0006RF-DS
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbYGVHug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYGVHug
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:50:36 -0400
Received: from peff.net ([208.65.91.99]:1944 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbYGVHug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:50:36 -0400
Received: (qmail 3659 invoked by uid 111); 22 Jul 2008 07:50:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 03:50:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 03:50:35 -0400
Content-Disposition: inline
In-Reply-To: <488590B9.1080804@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89466>

On Tue, Jul 22, 2008 at 09:48:09AM +0200, Johannes Sixt wrote:

> BTW, you could remove the #ifndef __MINGW32__ around both the definition
> and the use of pager_preexec. We have everything on mingw to compile and
> link this function.

Ah, OK. I left it around the function because I was worried about fd_set
needing some magic for compilation.

However, it still won't be _used_ on Windows, because there is no
opportunity to use the pre-exec callback (it is silently ignored).

-Peff
