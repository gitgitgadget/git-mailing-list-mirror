From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 6 Mar 2007 05:56:29 -0500
Message-ID: <20070306105629.GA13285@coredump.intra.peff.net>
References: <20070306093917.GA1761@coredump.intra.peff.net> <989B956029373F45A0B8AF02970818902DAA12@zch01exm26.fsl.freescale.net> <20070306104127.GA13096@coredump.intra.peff.net> <7vveheprsc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Li Yang-r58472 <LeoLi@freescale.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 11:56:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOXLM-0006Ml-R0
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 11:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965838AbXCFK4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 05:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965837AbXCFK4c
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 05:56:32 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4775 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965838AbXCFK4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 05:56:31 -0500
Received: (qmail 11986 invoked from network); 6 Mar 2007 05:56:48 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 6 Mar 2007 05:56:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2007 05:56:29 -0500
Content-Disposition: inline
In-Reply-To: <7vveheprsc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41572>

On Tue, Mar 06, 2007 at 02:53:07AM -0800, Junio C Hamano wrote:

> But then you are letting _other_ mod_perl users to affect your
> behaviour, aren't you?  "sub autoEscape" does this:

Yes (but I don't know how mod_perl works, and I haven't been able to
find a simple answer by skimming the docs).

> If we worry about mod_perl (provided if $CGI::Q is shared across
> mod_perl users), I suspect we would need to be a bit more
> paranoid, perhaps like this, woudln't we?
> [...]
> +$cgi->autoEscape(1);

That rebreaks the original problem, though. Calling escapeHTML doesn't
look at $cgi, it looks at $Q (the "default" CGI object). I believe
escape is _already_ set to 1 for $cgi (which is why the $cgi->escapeHTML
patch worked).

-Peff
