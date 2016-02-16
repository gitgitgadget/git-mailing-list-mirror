From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Tue, 16 Feb 2016 17:34:51 -0500
Message-ID: <20160216223451.GB9014@sigill.intra.peff.net>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
 <1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
 <20160216192231.GA16567@sigill.intra.peff.net>
 <CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
 <20160216204954.GC27484@sigill.intra.peff.net>
 <CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 23:34:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVoCw-0004Vo-3g
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 23:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229AbcBPWey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 17:34:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:43649 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756157AbcBPWex (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 17:34:53 -0500
Received: (qmail 6658 invoked by uid 102); 16 Feb 2016 22:34:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 17:34:53 -0500
Received: (qmail 31817 invoked by uid 107); 16 Feb 2016 22:34:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 17:34:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 17:34:51 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286445>

On Tue, Feb 16, 2016 at 04:09:53PM -0500, Eric Sunshine wrote:

> My initial reaction was negative due to the heavy review burden this
> series has demanded thus far, however, my mind was changing even as I
> composed the above response. In retrospect, I think I'd be okay seeing
> a v6, for the following reasons:
> 
> - I already ended up reviewing the the suggested new changes pretty
> closely as a side-effect of reading your proposal.
> 
> - It would indeed be nice to avoid introducing
> strbuf_split_str_omit_term() in the first place; thus one less thing
> to worry about if someone ever takes on the task of retiring the
> strbuf_split interface.
> 
> - It should be only a minimal amount of work for Karthik, thus
> turnaround time should be short.
> 
> So, I think I'm fine with it, if Karthik is game.

I started to write up a commit message for my proposed change. But it
did make me think of a counter-argument. Right now we parse
"%(align:10,middle)" but do not allow "%(align: 10, middle)".

Should we? Or perhaps: might we? If the answer is yes, we are likely
better off with strbuf_split, because then we are only a strbuf_trim()
away from making that work.

-Peff
