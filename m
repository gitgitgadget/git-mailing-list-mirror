From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Put quotes around branch names to prevent special
 characters from being interpreted by the shell.
Date: Sun, 6 Jun 2010 17:55:05 -0400
Message-ID: <20100606215505.GB6993@coredump.intra.peff.net>
References: <1275666800-31852-1-git-send-email-bmeyer@rim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Benjamin C Meyer <bmeyer@rim.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 23:55:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLNoP-0000Xs-Ir
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 23:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378Ab0FFVzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 17:55:10 -0400
Received: from peff.net ([208.65.91.99]:57610 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755309Ab0FFVzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 17:55:07 -0400
Received: (qmail 12312 invoked by uid 107); 6 Jun 2010 21:55:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Jun 2010 17:55:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jun 2010 17:55:05 -0400
Content-Disposition: inline
In-Reply-To: <1275666800-31852-1-git-send-email-bmeyer@rim.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148547>

On Fri, Jun 04, 2010 at 11:53:20AM -0400, Benjamin C Meyer wrote:

> Perforce branch names with spaces (and other special characters) were
> causing issues.
> [...]
> -            details = p4Cmd("branch -o %s" % info["branch"])
> +            details = p4Cmd("branch -o \"%s\"" % info["branch"])

Won't this still fail if your branch name contains quotation marks or
backslashes? Does python have some equivalent to perl's quotemeta to
just shell-escape the problematic characters (or even a way of just
using a straight list in p4Cmd and avoiding the shell altogether)?

I know those characters may not be common, but if we are going to quote,
perhaps we should make it foolproof.

-Peff
