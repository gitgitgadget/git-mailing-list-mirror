From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 13:22:14 -0500
Message-ID: <20090210182214.GA19957@coredump.intra.peff.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com> <20090210110330.GB12089@coredump.intra.peff.net> <7vwsbynv0o.fsf@gitster.siamese.dyndns.org> <20090210181052.GA19634@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 19:23:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWxGs-0005Je-P2
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 19:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbZBJSWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 13:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbZBJSWS
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 13:22:18 -0500
Received: from peff.net ([208.65.91.99]:41600 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142AbZBJSWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 13:22:17 -0500
Received: (qmail 16272 invoked by uid 107); 10 Feb 2009 18:22:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 13:22:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 13:22:14 -0500
Content-Disposition: inline
In-Reply-To: <20090210181052.GA19634@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109287>

On Tue, Feb 10, 2009 at 01:10:52PM -0500, Jeff King wrote:

>   - I don't think the "mini" status is really related to this. The novel
>     thing here is collating the outputs into a single sorted list. But
>     the "mini" output is not about that at all:
> 
>       1. It doesn't care about full output, so it should be able to exit
>          early from the diff, avoid rename detection, etc, so that it is
>          as quick as possible.
> 
>       2. It doesn't collate the output at all. It is about three
>          separate symbols for the three separate lists.

Oh, sorry, I was misreading the "mini" output. I thought the three flags
corresponded to the staged, unstaged, and untracked changes. But they
are "unstaged or staged but added", "unstaged or staged but changed", or
"untracked" (although right now the last is triggered by unmerged
entries?).

I honestly don't see much point in differentiating added versus changed
files. Splitting it into "some things are staged" and "some things are
not staged" makes more sense to me. But if you do want that distinction
then an early exit from the diff is more complicated (since you might
have to keep going to see if there are any of _either_ type).

-Peff
