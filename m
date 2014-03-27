From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/10] [RFC] pickaxe for function names
Date: Thu, 27 Mar 2014 15:03:14 -0400
Message-ID: <20140327190314.GB28668@sigill.intra.peff.net>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, l.s.r@web.de
To: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 27 20:03:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFaE-0004ai-KO
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 20:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249AbaC0TDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 15:03:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:48668 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757177AbaC0TDR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 15:03:17 -0400
Received: (qmail 25656 invoked by uid 102); 27 Mar 2014 19:03:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Mar 2014 14:03:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2014 15:03:14 -0400
Content-Disposition: inline
In-Reply-To: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245320>

On Thu, Mar 27, 2014 at 02:50:46PM -0400, David A. Dalrymple (and Bhushan G. Lodha) wrote:

> This series introduces a --function-name=<pattern> option for git-log, intended
> to search for commits which touch a function matching a certain pattern (a
> feature we've seen requested and are interested in using ourselves).

How does your feature compare with the line-level history viewer? E.g.:

  git log -L:myfunc:foo.c

I guess by being part of pickaxe, it can be used to generally select
commits (whereas "-L" is about drilling down a particular set of lines,
so something like --full-diff would not work).

But "-L" can do many things that pickaxe can't. It is not just about
finding lines touched within a pattern, but uses the pattern to
determine an initial set of lines, and then recursively "blames" those
lines going back through history. So how you specify the pattern is more
flexible (you can give any line range, for example), and it should be
able to cross boundaries like function renames.

-Peff
