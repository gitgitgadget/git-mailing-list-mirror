From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Tue, 8 Sep 2015 17:44:38 -0400
Message-ID: <20150908214437.GB24159@sigill.intra.peff.net>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
 <1441633928-18035-1-git-send-email-bernat@primeranks.net>
 <CAPig+cRRMUhWwxAgVHKpMMne7XiOuYGTi_zgQMB=A+XNGUzLqQ@mail.gmail.com>
 <xmqqsi6o95r7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?R8OhYm9yIEJlcm7DoXQ=?= <bernat@primeranks.net>,
	Git List <git@vger.kernel.org>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:44:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZQh2-0000qE-5y
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 23:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbbIHVom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 17:44:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:56460 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752147AbbIHVok (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 17:44:40 -0400
Received: (qmail 17293 invoked by uid 102); 8 Sep 2015 21:44:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 16:44:40 -0500
Received: (qmail 25758 invoked by uid 107); 8 Sep 2015 21:44:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 17:44:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 17:44:38 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsi6o95r7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277525>

On Tue, Sep 08, 2015 at 10:32:12AM -0700, Junio C Hamano wrote:

> Also git_filter_branch__commit_count is now used only inside this
> function, so it is easier to follow to increment it here.
> 
> I suspect that the variable has this unwieldy name for historic
> reasons, perhaps an attempt to avoid name clashes with the end user
> script, but it has many variables (e.g. $commits, $ref, etc.) that
> are way too generic and that I can see no attempt of name clash
> avoidance, so renaming it to $total_commits or something _might_
> make some sense.

I briefly wondered if it had the opposite reason; could it have a
well-defined name because it is meant to be a public value the
user-defined shell snippets can access?

But it is not documented, and I can imagine that "the current count" is
not really useful without "total number of commits", so in practice I
doubt anybody's filter branch script is relying on it.

And looking through the history turns up d5b0c97 (git-filter-branch:
avoid collisions with variables in eval'ed commands, 2009-03-25), which
seems fairly clear. :)

The original name was "i", which I think is probably too short. Calling
it something meaningful but longer than one character is probably
sufficient.

-Peff
