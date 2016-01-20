From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: remove unnecessary backslashes
Date: Wed, 20 Jan 2016 13:24:21 -0500
Message-ID: <20160120182421.GA27562@sigill.intra.peff.net>
References: <1453310497-7971-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Matthew Kraai <matt.kraai@abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Jan 20 19:24:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLxQl-0007aR-QZ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 19:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934760AbcATSY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 13:24:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:57140 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934556AbcATSYY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 13:24:24 -0500
Received: (qmail 7565 invoked by uid 102); 20 Jan 2016 18:24:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jan 2016 13:24:24 -0500
Received: (qmail 7590 invoked by uid 107); 20 Jan 2016 18:24:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jan 2016 13:24:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jan 2016 13:24:21 -0500
Content-Disposition: inline
In-Reply-To: <1453310497-7971-1-git-send-email-kraai@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284458>

On Wed, Jan 20, 2016 at 09:21:37AM -0800, Matt Kraai wrote:

> From: Matthew Kraai <matt.kraai@abbott.com>
> 
> asciidoctor does not remove backslashes used to escape curly brackets from
> the HTML output if the contents of the curly brackets are empty or contain
> at least a <, -, or space.  asciidoc does not require the backslashes in
> these cases, so just remove them.

I think these backslashes may have been necessary in older versions of
asciidoc, but I don't recall the details. Looks like we did a similar
round of cleanups already in 4538a88256, so this is probably safe (and I
verified with asciidoc 8.6.9 that the generated output is the same).

> -'<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
> +'<refname>@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::

I see you didn't tweak the middle one here, because it _does_ look like
an attribute. Does asciidoctor actually remove the backslashes there?

> -'<refname>@\{<n>\}', e.g. 'master@\{1\}'::
> +'<refname>@{<n>}', e.g. 'master@\{1\}'::

Ditto here for "1". IMHO asciidoctor's behavior is somewhat crazy, as it
means you have to know arcane quoting rules to get correct output (you
cannot just err on the side of quoting). But it's probably still worth
working around.

-Peff
