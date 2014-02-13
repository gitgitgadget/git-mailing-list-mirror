From: Jeff King <peff@peff.net>
Subject: Re: [RFH] hackday and GSoC topic suggestions
Date: Thu, 13 Feb 2014 03:41:38 -0500
Message-ID: <20140213084138.GB28679@sigill.intra.peff.net>
References: <20140205225702.GA12589@sigill.intra.peff.net>
 <xmqq1tz9qxyl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 13 09:41:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDrrd-00085V-8H
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 09:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbaBMIlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 03:41:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:49688 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753158AbaBMIlk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 03:41:40 -0500
Received: (qmail 7226 invoked by uid 102); 13 Feb 2014 08:41:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Feb 2014 02:41:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Feb 2014 03:41:38 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1tz9qxyl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242049>

On Tue, Feb 11, 2014 at 10:57:22AM -0800, Junio C Hamano wrote:

> >  - git stash doesn't use --index as default
> >    http://article.gmane.org/gmane.comp.version-control.git/235892
> 
> I tend to think "git stash" was designed to work this way from day
> one.

Right. The thing that bothers me is the data loss of:

  echo 1 >foo
  git add foo
  echo 2 >foo
  git stash
  git stash pop

The content in "1" is stashed, but gets lost on the apply, and our pop
drops the stash.

> >  - using git commit-tree with "-F -" adds trailing newlines
> >    http://article.gmane.org/gmane.comp.version-control.git/236583
> 
> According to the initial commit that introduced this option, it
> deliberately calls strbuf_complete_line() to make sure we do not
> leave an incomplete line at the end.

Yeah, I think this one is a non-bug. I hadn't read it carefully but the
"trailing newlines" made me think it was adding multiple extra blank
lines. But it looks like it is just the normal strbuf_complete_line, and
that is the right thing to be doing (it has _never_ been encouraged to
have a commit message that does not have a newline at all, and
I think stripspace has enforced that from day one).

> Many of the other items in your "bugs" section seem to be worth
> fixing.

As I mentioned elsewhere, I've yet to see the full results of the
hackday. Hopefully soon. :)

-Peff
