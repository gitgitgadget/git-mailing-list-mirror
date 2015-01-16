From: Jeff King <peff@peff.net>
Subject: [PATCH 0/7] migrate api-strbuf.txt into strbuf.h
Date: Fri, 16 Jan 2015 04:02:26 -0500
Message-ID: <20150116090225.GA30797@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 10:02:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YC2nb-00033L-UG
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 10:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbbAPJCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 04:02:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:35398 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752296AbbAPJC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 04:02:29 -0500
Received: (qmail 2745 invoked by uid 102); 16 Jan 2015 09:02:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 03:02:29 -0600
Received: (qmail 23367 invoked by uid 107); 16 Jan 2015 09:02:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 04:02:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jan 2015 04:02:26 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262539>

This is a re-roll of this series:

  http://thread.gmane.org/gmane.comp.version-control.git/260922/focus=261374

from early December to move the strbuf documentation into the header
file. I've incorporated all of the minor formatting feedback and
suggestions from Jonathan and Stefan in response to that series.

Patch 2 is new from Stefan, and just fixes the comment blocks that
already existed in strbuf.h to be consistent.

Patches 3-5 are the same as the old 2-4 (modulo a header I missed in the
original of 5).

Both Junio and Jonathan noted that tighter grouping of related functions
can be more readable in some places. Patches 6 and 7 adjust those two
spots. This moves us farther from a single comment describing each
function, which may make extracting the documentation later harder. But
I think it makes reading the in-header documentation much more pleasant.

  [1/7]: strbuf.h: integrate api-strbuf.txt documentation
  [2/7]: strbuf.h: unify documentation comments beginnings
  [3/7]: strbuf.h: drop asciidoc list formatting from API docs
  [4/7]: strbuf.h: format asciidoc code blocks as 4-space indent
  [5/7]: strbuf.h: reorganize api function grouping headers
  [6/7]: strbuf.h: drop boilerplate descriptions of strbuf_split_*
  [7/7]: strbuf.h: group documentation for trim functions

The two things I _didn't_ do are:

  1. Read through for possible places to use `backticks` or other
     punctuation to make the source more readable. I think this is a
     good goal, but it's largely orthogonal, so we can build it on top
     just as easily (and also, it's tedious; I'm happy to work towards
     that goal slowly as I touch or read specific pieces of
     documentation).

  2. We do not consistently use parameter names in declarations. They
     have no meaning to the compiler, of course, but they are a good way
     of making the documentation more readable, since it gives us a
     concrete name to refer to (and also some declarations are simply
     confusing, such as when there are two ints next to each other;
     which is which?).  This is in the same boat as (1). I think it's a
     good direction, but I did not make a pass.  Patches welcome. :)

And of course the elephant in the room is the other dozen or more
api-*.txt files. I'd propose to do this strbuf.h series (and possible
follow-ons mentioned above) and stop there for a bit. That will let us
form a more coherent opinion on whether we like this system in practice,
how it ages as functions are changed and added, etc. That might affect
how or if we end up converting other files.

It does leave us in an inconsistent state (some documentation is in
Documentation/technical, and some is in the headers), but I think that
is largely where we're at today. IMHO this is a strict improvement
because at least the logical chunk of "strbuf" is now in a single place.

-Peff
