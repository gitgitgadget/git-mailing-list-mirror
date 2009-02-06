From: Jeff King <peff@peff.net>
Subject: Re: How to find out which gitignore blocks my git-add
Date: Fri, 6 Feb 2009 14:33:59 -0500
Message-ID: <20090206193359.GF19494@coredump.intra.peff.net>
References: <498C0525.5040100@gonsolo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gonzo <gonzo@gonsolo.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVWU8-0003Nd-LT
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 20:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbZBFTeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 14:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbZBFTeE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 14:34:04 -0500
Received: from peff.net ([208.65.91.99]:60841 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbZBFTeB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 14:34:01 -0500
Received: (qmail 24354 invoked by uid 107); 6 Feb 2009 19:34:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 14:34:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 14:33:59 -0500
Content-Disposition: inline
In-Reply-To: <498C0525.5040100@gonsolo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108778>

On Fri, Feb 06, 2009 at 10:38:45AM +0100, Gonzo wrote:

> After doing a "git add file" I get the message:
>
> "The following paths are ignored by one of your .gitignore files:
> ..."
>
> Is there an easy way to find out which line in which gitignore file  
> blocks this add?

No, I don't think so.

> Would this be a viable addition to "git add -v"?

I think it might be useful to be able to get this information. However,
rather than coupling it with "git add", it might make more sense to have
a separate way to query "is this being ignored, and if so, by what
pattern". Then you could use that tool to generally debug your
.gitignore patterns.

I'm not sure how painful it would be to implement. You'd probably have
to record and pass back that information from dir.c:excluded, which is
where we decide whether or not a file is ignored (most of the code calls
it "excluded", but it is the same concept). Want to take a stab at
writing a patch?

-Peff
