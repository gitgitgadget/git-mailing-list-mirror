From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 08/11] transport: connect_setup appends protocol
 version number
Date: Wed, 27 May 2015 02:56:17 -0400
Message-ID: <20150527065617.GF885@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-9-git-send-email-sbeller@google.com>
 <xmqq1ti3j7ym.fsf@gitster.dls.corp.google.com>
 <CAGZ79kY=hZ=6pUbpVHUW8rU3AEMx2TwkBYDsDsZ+bPH_QnsYzA@mail.gmail.com>
 <xmqqwpzuip2e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 08:56:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxVGN-0005G4-6X
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbbE0G4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 02:56:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:36498 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751511AbbE0G4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:56:20 -0400
Received: (qmail 32504 invoked by uid 102); 27 May 2015 06:56:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 01:56:20 -0500
Received: (qmail 5030 invoked by uid 107); 27 May 2015 06:56:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:56:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 02:56:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwpzuip2e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270028>

On Tue, May 26, 2015 at 10:09:45PM -0700, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > On Tue, May 26, 2015 at 3:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> >>
> >>         if (...->version < 2) {
> >>                 ... append "-%d" ...
> >>         }
> >>
> >> involved.
> >
> > Oh! I see here you would count the current one as 1, which has no
> > number extension, and any further would have a -${version}. That
> > would transport the intention much better I guess.
> 
> Yeah, except that I screwed up my comparison.  Obviously, I should
> have said "If version is 2 or later, then append -%d to the name,
> otherwise use the name as-is".

FWIW, I had similar head-scratching over Stefan's original. I think it's
OK to say "version 1 is magical, and for historical reasons does not
have its number appended". There's no need for us ever to make
"upload-pack-1"; it just introduces more headaches.

-Peff
