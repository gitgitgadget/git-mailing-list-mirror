From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Wed, 26 Mar 2008 05:33:10 -0400
Message-ID: <20080326093310.GA937@coredump.intra.peff.net>
References: <7caf19ae394accab538d2f94953bb62b55a2c79f.1206486012.git.peff@peff.net> <200803260759.48922.tlikonen@iki.fi> <20080326062029.GA26286@coredump.intra.peff.net> <20080326083033.GA13933@mithlond.arda.local> <20080326083925.GA31475@coredump.intra.peff.net> <20080326092303.GA17835@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Mar 26 10:34:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeS17-0006ie-GH
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 10:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbYCZJdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 05:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbYCZJdN
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 05:33:13 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1214 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbYCZJdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 05:33:12 -0400
Received: (qmail 16899 invoked by uid 111); 26 Mar 2008 09:33:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Mar 2008 05:33:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2008 05:33:10 -0400
Content-Disposition: inline
In-Reply-To: <20080326092303.GA17835@mithlond.arda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78278>

On Wed, Mar 26, 2008 at 11:23:03AM +0200, Teemu Likonen wrote:

> Hmm, do you send the 0000-cover-letter.patch with 'git send-email'? It
> seems that this cover letter don't get MIME headers when sent that way.
> Sending through 'mutt -H' it works fine but then the Message-Id needs to
> be copy-pasted manually to send-mail for the rest of the series (to have
> them appear as replies, that is). No problem with that.

No, I have format-patch do the threading. So something like:

  git format-patch --cover-letter --thread --stdout upstream >mbox
  mutt -f mbox

and then in mutt I bind a key to <resend-message>. For each message, I
do the 'resend', set the recipient headers, look it over one last time,
and then send. The most annoying part is entering the recipients;
usually it isn't too bad because I have short aliases for Junio and the
list, but I had to, e.g., cut and paste your address twice for the other
series.

Probably munging the 'to:' and 'cc:' before running mutt would make the
most sense, but I haven't gotten around to it yet.

> I mostly use (and promote) UTF-8 and now that I begin to understand how
> send-email works I can live with the current behaviour just fine. Don't
> take my feedback as complaining. :)

OK, I am inclined to leave the patches as-is, then, and wait for
somebody to complain about their pet encoding. My reasoning is that:

  - in most cases throughout git, we assume things are happening in
    utf-8, so I don't think it will come as a great surprise
  - I think doing it right might be more complex than just send-mail; I
    am thinking there might need to be a "stuff the user inputs is in
    encoding X" config option. And I don't want to do the work. :)

> Thanks for your work on this. Really.

No problem at all. Thank you for helping make git better with bug
reports!

-Peff
