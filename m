From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] document string_list_clear
Date: Fri, 12 Dec 2014 14:24:17 -0500
Message-ID: <20141212192417.GA21132@peff.net>
References: <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <20141210084351.GA29776@peff.net>
 <20141210091815.GA18372@google.com>
 <20141212091625.GA9049@peff.net>
 <20141212183114.GA29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:24:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzVpA-0007V5-AF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 20:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934701AbaLLTYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 14:24:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:52232 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932531AbaLLTYT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 14:24:19 -0500
Received: (qmail 14722 invoked by uid 102); 12 Dec 2014 19:24:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 13:24:19 -0600
Received: (qmail 13557 invoked by uid 107); 12 Dec 2014 19:24:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 14:24:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Dec 2014 14:24:17 -0500
Content-Disposition: inline
In-Reply-To: <20141212183114.GA29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261362>

On Fri, Dec 12, 2014 at 10:31:14AM -0800, Jonathan Nieder wrote:

> Separate from the question of history, I honestly prefer this way of
> doing API documentation relative to 90% of the API documentation in
> headers I've seen in other projects.  I suspect you don't.  That's
> okay --- it's possible for rational people to disagree about things.
> 
> It's moot given that we don't seem to disagree about what should be
> done about it.  Why keep arguing?

Fair enough.

> > I think the end result that I posted is still strictly better than what
> > we have currently, with the exception that I should have reformatted the
> > hanging indents. What is it that you don't like about it?
> 
> Other issues of inconsistent markup.  For example, some comments are
> strangely indented, and some look like
> 
> 	/* First line
> 	 * second line
> 	 * third line */

Yeah, I had to strip the indent from:

  strbuf_init::
	description of strbuf_init...

when "strbuf_init::" went away, but it looks like I missed two of them.
And I see one "/* First line" where the "header" from "Adding data to
the buffer" got merged with a note. I agree those should be fixed.

I used our normal single-line comment style for most of those:

  /* Related to the size of the buffer */

in some places. But I'd be happy, too, with:

  /*
   * Related to the size of the buffer
   */

(and probably using a full sentence, or caps or underlining or something
to indicate that the comment begins a new section of the header file).

> I chose not to list markup issues for the same reason (it's more
> tedious to go back and forth than for someone to spend some time to
> get it mostly-right first on their own).  I am kind of confused about
> the current status, since I've said again and again that I'd be happy
> to see the documentation in the header but you still seem to be trying
> to convince me of that.  What am I missing?

I think partially it was crossing mails. While I was writing the
response that you responded to just now, I ended up postponing it for
other work, and in the meantime you sent several more messages
indicating you were OK with moving documentation into the headers. I
almost scrapped my response, but frankly I was left a bit confused by
your position, since it seemed the opposite of the 2 patches you had
sent moving things out of headers.

Do not feel obligated to make me unconfused. If you are on board with
putting documentation in the headers, then I think we can move forward
with that plan.

So what next?

I agree there are some formatting problems in the strbuf.h patch I sent
earlier. I'm happy to fix them and resend, but I'm not 100% sure that
fixing all the problems I see will not leave problems for you. I can fix
them and you can review if you want. Or alternatively, if you have more
drastic formatting or wording changes in mind, maybe it would make sense
for you to take a pass?

I _don't_ want to commit to moving all of api-* into headers myself.
It's something I would rather have happen over time as people touch
areas[1], because it's tedious and time-consuming. That does create an
inconsistency, in the sense that some APIs will be documented in
Documentation/technical, and others in their header files. But as long
as each _individual_ API is documented in one or the other, I don't see
that as a big problem (of course the status quo is a mix for some APIs,
so we will live with that until they are touched, but that is no worse
than today's state).

-Peff

[1] I had a vague plan to put new documentation into headers, and slowly
    migrate that way until we had a critical mass. But that was moving
    somewhat slowly, and obviously escaped the notice of many people. :)
