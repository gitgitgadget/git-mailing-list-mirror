From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 06/11] remote.h: add get_remote_capabilities,
 request_capabilities
Date: Wed, 27 May 2015 16:09:25 -0400
Message-ID: <20150527200924.GA14309@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-7-git-send-email-sbeller@google.com>
 <CAPig+cRfJKAQ8Q5PF1VfTAGA1njXAshC0RbnMv9cEp4bH_MN7A@mail.gmail.com>
 <20150527065030.GE885@peff.net>
 <CAPig+cQUtjVbdF5eEo0EH-QXz4q_UqOtoFZ5DcTNzceCxWLS=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:09:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxhdt-0007yA-C0
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbbE0UJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:09:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:36815 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751476AbbE0UJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:09:28 -0400
Received: (qmail 10859 invoked by uid 102); 27 May 2015 20:09:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 15:09:27 -0500
Received: (qmail 10007 invoked by uid 107); 27 May 2015 20:09:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:09:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 16:09:25 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQUtjVbdF5eEo0EH-QXz4q_UqOtoFZ5DcTNzceCxWLS=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270079>

On Wed, May 27, 2015 at 01:19:39PM -0400, Eric Sunshine wrote:

> >> The 'len > 4' check is needed because there's no guarantee that 'line'
> >> is NUL-terminated. Correct?
> >
> > I think this was just blindly copied from get_remote_heads(). And I
> > think that code was being overly paranoid. Ever since f3a3214 (Make
> > send/receive-pack be closer to doing something interesting, 2005-06-29),
> > the pkt-line reader will add an extra NUL to the buffer to ease cases
> > like this.
> 
> Thanks. I had started digging into packet_read() to determine whether
> it guaranteed NUL-termination, but didn't get far enough to decide. I
> agree that if NUL-termination is guaranteed, then the 'len > 4' check
> is superfluous (and confusing, which is why it caught my attention in
> the first place).

Yeah, agreed that it should be cleaned up. Interestingly, if you dig on
that line, I've touched it several times myself and never noticed this.
:)

-Peff
