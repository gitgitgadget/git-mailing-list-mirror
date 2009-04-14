From: Jeff King <peff@peff.net>
Subject: Re: help with git query
Date: Tue, 14 Apr 2009 01:46:54 -0400
Message-ID: <20090414054654.GC19027@coredump.intra.peff.net>
References: <3a69fa7c0904131151p35945ed3y58cba069bd801337@mail.gmail.com> <d77df1110904131331p24f52220o74c401c97fbb904d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: E R <pc88mxer@gmail.com>, git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 07:48:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtbVW-0007z5-28
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 07:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbZDNFq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 01:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbZDNFq4
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 01:46:56 -0400
Received: from peff.net ([208.65.91.99]:56941 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbZDNFq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 01:46:56 -0400
Received: (qmail 7226 invoked by uid 107); 14 Apr 2009 05:46:59 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 14 Apr 2009 01:46:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Apr 2009 01:46:54 -0400
Content-Disposition: inline
In-Reply-To: <d77df1110904131331p24f52220o74c401c97fbb904d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116515>

On Mon, Apr 13, 2009 at 03:31:49PM -0500, Nathan W. Panike wrote:

> > for each branch:
> >  - info about the latest commit on that branch (date and time, message, etc.)
> 
> Depending on what you want to do---from a bash shell, you could do:
> 
> for i in $(git branch -a | cut -b3-); do echo $i; git show -s $i; echo; done

Ick, please use the plumbing designed for this exact thing instead of
trying to parse "git branch":

  $ git for-each-ref --format='%(subject)
    %(authorname) %(authoremail)
    %(authordate)' refs/heads/

or however you want to format it. See "git help for-each-ref" for a list
of fields (you can also just pipe the output of for-each-ref into a
shell loop, as in your example, but with the format options there is
often no need).

-Peff
