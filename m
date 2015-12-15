From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Tue, 15 Dec 2015 18:32:07 -0500
Message-ID: <20151215233207.GA30294@sigill.intra.peff.net>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Doug Kelly <dougk.ff7@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 00:32:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8z51-0002Iw-Tq
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 00:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427AbbLOXcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 18:32:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:42685 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754419AbbLOXcK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 18:32:10 -0500
Received: (qmail 19925 invoked by uid 102); 15 Dec 2015 23:32:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 17:32:10 -0600
Received: (qmail 21424 invoked by uid 107); 15 Dec 2015 23:32:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Dec 2015 18:32:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Dec 2015 18:32:07 -0500
Content-Disposition: inline
In-Reply-To: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282509>

On Tue, Dec 15, 2015 at 02:48:42PM -0800, Junio C Hamano wrote:

> * dk/gc-more-wo-pack (2015-11-24) 3 commits
>  - gc: Clean garbage .bitmap files from pack dir
>  - t5304: Add test for .bitmap garbage files
>  - prepare_packed_git(): find more garbage
> 
>  Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
>  .bitmap and .keep files.
> 
>  Waiting for review.

I just read through and made some comments.

Note that I think there was a re-roll of the first patch after I picked
up the original:

  http://article.gmane.org/gmane.comp.version-control.git/281759

Hopefully Doug will re-post the whole series after taking a look at my
comments.

> * jc/strbuf-gets (2015-10-28) 17 commits
> [...]
> 
>  Teach codepaths that communicate with users by reading text files
>  to be more lenient to editors that write CRLF-terminated lines.
>  Note that this is only about communication with Git, like feeding
>  list of object names from the standard input instead of from the
>  command line, and does not involve files in the working tree.
> 
>  Waiting for review.

I like the intent here, but I was a little disappointed that we end up
with two almost identical strbuf functions. But even if the ultimate
endgame is to drop back to one, the conservative route is to keep them
both until all new code paths have "opted in" to the new behavior.
However, I found the naming confusing: it was not at all clear to me
which of strbuf_gets and strbuf_getline did the CRLF-munging. Perhaps
it would be more obvious if the new one was strbuf_getline_crlf or
something. I dunno.

-Peff
