From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] remote.c: silently tolerate single-level keys like
	remote.default
Date: Thu, 23 Apr 2009 12:40:09 -0400
Message-ID: <20090423164008.GA26346@coredump.intra.peff.net>
References: <1240494546-25775-1-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 23 18:48:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx1zl-0006ES-Pn
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 18:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbZDWQkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 12:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbZDWQkP
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 12:40:15 -0400
Received: from peff.net ([208.65.91.99]:43643 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbZDWQkO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 12:40:14 -0400
Received: (qmail 23471 invoked by uid 107); 23 Apr 2009 16:40:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 23 Apr 2009 12:40:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Apr 2009 12:40:09 -0400
Content-Disposition: inline
In-Reply-To: <1240494546-25775-1-git-send-email-j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117348>

On Thu, Apr 23, 2009 at 03:49:05PM +0200, Johannes Sixt wrote:

> Typos in configuration keys usually do not hurt because they never match
> in look-ups. But this case is different: it does match, but it does not
> have the expected format. With this patch this situation is treated more
> like a typo.

I definitely think causing the command to fail is bad, but should we
perhaps still warn the user? I know that we can't catch _every_ typo in
the config, but if there is something obviously wrong that we've
detected, it is nice to let the user know.

> -		return error("Config with no key for remote %s", name);
> +		return 0;

IOW,

  + warn("Config with no key for remote %s", name);
  + return 0;

-Peff
