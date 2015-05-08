From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] sha1_name: get_sha1_with_context learns to follow
 symlinks
Date: Fri, 8 May 2015 16:39:52 -0400
Message-ID: <20150508203952.GA13457@peff.net>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
 <1431108819-6831-2-git-send-email-dturner@twopensource.com>
 <CAPig+cRzXQp_afDrOdKrUQ-=DD1P_UcDzs8aSZnTfesd7R20wQ@mail.gmail.com>
 <CAPc5daXmJSfdB_eyQ5ppVp2NhYGZvPChGAyn4p2hEde=4x9EEQ@mail.gmail.com>
 <xmqq6182ke9i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:40:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqp3w-0005m9-GY
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbbEHUj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 16:39:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:55850 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932200AbbEHUjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 16:39:55 -0400
Received: (qmail 24280 invoked by uid 102); 8 May 2015 20:39:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 May 2015 15:39:55 -0500
Received: (qmail 23424 invoked by uid 107); 8 May 2015 20:40:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 May 2015 16:40:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 May 2015 16:39:52 -0400
Content-Disposition: inline
In-Reply-To: <xmqq6182ke9i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268663>

On Fri, May 08, 2015 at 01:25:45PM -0700, Junio C Hamano wrote:

> Perhaps something like the attached patch is a good idea (I used
> "BUG:" for now), I wonder?
> 
>  Documentation/CodingGuidelines | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Yeah, this looks good (and we definitely prefer BUG:, though I am
responsible for over 1/3 of the existing incidences).

I have been tempted to provide a macro or function for it, and have it
actually call abort() to trigger a coredump. I.e., basically assert(),
except unconditional but you get to write a more useful message.

So all of the sites would just become:

  BUG("frotz() called with NULL pointer to xyzzy parameter");

or similar.

-Peff
