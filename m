From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] filter-branch: fail gracefully when a filter fails
Date: Thu, 5 Jul 2007 09:58:24 -0400
Message-ID: <20070705135824.GB5493@sigill.intra.peff.net>
References: <Pine.LNX.4.64.0707041535420.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 15:58:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Rqo-0005rq-Co
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 15:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760439AbXGEN61 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 09:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760237AbXGEN61
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 09:58:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4561 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759851AbXGEN60 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 09:58:26 -0400
Received: (qmail 29148 invoked from network); 5 Jul 2007 13:58:49 -0000
Received: from unknown (HELO sigill.intra.peff.net) (71.63.4.50)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP
  (cert postmaster@peff.net); 5 Jul 2007 13:58:49 -0000
Received: (qmail 11417 invoked by uid 1000); 5 Jul 2007 13:58:24 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707041535420.4071@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51677>

On Wed, Jul 04, 2007 at 03:36:01PM +0100, Johannes Schindelin wrote:

> 	It is slightly ugly that the output of msg-filter is written
> 	to a temporary file. But I do not know a better method to
> 	catch a failing msg-filter. Help?

If you mean, in general, to catch the exit code of the first part of a
pipe, you have to do something like this:

status=`((cmd1; echo $? >&3) | cmd2) 3>&1`

which is pretty ugly in itself, and if you want the stdout of cmd2, then
you have to add even more redirection. I'm not sure it's worth it.

-Peff
