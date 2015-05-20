From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Wed, 20 May 2015 13:38:36 -0400
Message-ID: <20150520173836.GA14561@peff.net>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
 <1431806796-28902-1-git-send-email-gjthill@gmail.com>
 <xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
 <xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
 <20150519063716.GA22771@peff.net>
 <xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
 <20150519220918.GA779@peff.net>
 <xmqqr3qbnotm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Hill <gjthill@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 19:38:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv7x5-0002VE-KC
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 19:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbbETRij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 13:38:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:33246 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753059AbbETRij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 13:38:39 -0400
Received: (qmail 5267 invoked by uid 102); 20 May 2015 17:38:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 12:38:38 -0500
Received: (qmail 24909 invoked by uid 107); 20 May 2015 17:38:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 13:38:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 13:38:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3qbnotm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269481>

On Wed, May 20, 2015 at 10:25:41AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Not related to your patch, but I've often wondered if we can just get
> > rid of hold_lock_file_for_append. There's exactly one caller, and I
> > think it is doing the wrong thing. It is add_to_alternates_file(), but
> > shouldn't it probably read the existing lines to make sure it is not
> > adding a duplicate? IOW, I think hold_lock_file_for_append is a
> > fundamentally bad interface, because almost nobody truly wants to _just_
> > append.
> 
> Yeah, I tend to agree.  Perhaps I should throw it into the list of
> low hanging fruits (aka lmgtfy:"git blame leftover bits") and see if
> anybody bites ;-)

Good thinking. I think it is the right urgency and difficulty for that
list.

-Peff
