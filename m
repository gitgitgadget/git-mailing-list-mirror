From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: Do not automatically append " git" to custom site name
Date: Wed, 11 Oct 2006 18:06:21 -0400
Message-ID: <20061011220621.GA4041@coredump.intra.peff.net>
References: <20061011202228.27279.97423.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 00:07:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXmDc-0005a5-PF
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 00:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWJKWGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 18:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWJKWGZ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 18:06:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:44737 "HELO
	peff.net") by vger.kernel.org with SMTP id S965110AbWJKWGY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 18:06:24 -0400
Received: (qmail 4441 invoked from network); 11 Oct 2006 18:06:21 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Oct 2006 18:06:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Oct 2006 18:06:21 -0400
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20061011202228.27279.97423.stgit@rover>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28757>

On Wed, Oct 11, 2006 at 10:22:28PM +0200, Petr Baudis wrote:

> +our $site_name = "++GITWEB_SITENAME++" || "$ENV{'SERVER_NAME'} Git" || "Untitled Git";

This will never show "Untitled" (instead it shows " Git") and will cause
a perl warning if $ENV{SERVER_NAME} is not defined and warnings are
enabled (which tye are in gitweb).

I think this is what you want:

our $site_name = "++GITWEB_SITENAME++" ||
                 ($ENV{SERVER_NAME} || "Untitled") . " Git";

-Peff
