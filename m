From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Tue, 19 Jan 2016 20:56:03 -0500
Message-ID: <20160120015602.GC24541@sigill.intra.peff.net>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
 <20160119191234.GA17562@sigill.intra.peff.net>
 <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
 <20160120002606.GA9359@glandium.org>
 <xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>, larsxschneider@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:56:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLi0J-0005rU-3z
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 02:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933357AbcATB4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 20:56:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:56647 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933107AbcATB4F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 20:56:05 -0500
Received: (qmail 28489 invoked by uid 102); 20 Jan 2016 01:56:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 20:56:05 -0500
Received: (qmail 28900 invoked by uid 107); 20 Jan 2016 01:56:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 20:56:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 20:56:03 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284412>

On Tue, Jan 19, 2016 at 05:46:55PM -0800, Junio C Hamano wrote:

> > "Travis CI VMs run on 1.5 virtual cores."
> 
> Yup, that 1.5 was already mentioned in the earlier thread, but many
> tests are mostly I/O bound, so 1.5 (or 2 for that matter) does not
> mean we should not go higher than -j2 or -j3.  What I meant was that
> the 3 comes from the old discussion "let's be nice to those who
> offer this to us for free".

I am very appreciative that we can use Travis for free, but I doubt they
care much one way or the other how we parallelize. Everything is
sandboxed enough that we should not be able to cause problems for them
or other customers. It's all CPU seconds to them (or should be, anyway).

The thing that _would_ probably bother them is throwing too many builds
at it (right now we are building the integration branches; it would be
useful information to build individual topics, too, but that would
increase the number of CPU seconds we ask them for).

-Peff
