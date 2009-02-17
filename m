From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2009, #05; Mon, 16)
Date: Tue, 17 Feb 2009 14:30:27 -0500
Message-ID: <20090217193027.GA16093@coredump.intra.peff.net>
References: <7vfxid8phr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZVfu-0004zK-Kv
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 20:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbZBQTab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 14:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbZBQTaa
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 14:30:30 -0500
Received: from peff.net ([208.65.91.99]:47564 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264AbZBQTa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 14:30:29 -0500
Received: (qmail 31478 invoked by uid 107); 17 Feb 2009 19:30:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Feb 2009 14:30:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2009 14:30:27 -0500
Content-Disposition: inline
In-Reply-To: <7vfxid8phr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110444>

[oops, resend as I screwed up Jonas' address in the last one]

On Mon, Feb 16, 2009 at 11:57:36PM -0800, Junio C Hamano wrote:

> * jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
>  + blame: show "previous" information in --porcelain/--incremental
>    format
>  + git-blame: refactor code to emit "porcelain format" output
> 
> This gives Porcelains (like gitweb) the information on the commit _before_
> the one that the final blame is laid on, which should save them one
> rev-parse to dig further.  The line number in the "previous" information
> may need refining, and sanity checking code for reference counting may
> need to be resurrected before this can move forward.
> 
> I thought recent tig discussion may blow new life into it, but is this
> unneeded?  If so I'd rather revert it (or discard after 1.6.2).

I never got a chance to look closely at this patch series; Jonas ended
up implementing something in tig which does a diff-tree to guess where
we want the view to go:

  http://repo.or.cz/w/tig.git?a=commitdiff;h=b6d0d41e01e4e435385db260cf34fd5d9069d782

It has been working pretty well for me in practice. I'm sure that blame
could do it faster internally, but it really isn't performance critical,
as it is triggered by user input.

So a blame implementation might help other callers, but I don't think
there is much motivation from tig's point of view.

-Peff
