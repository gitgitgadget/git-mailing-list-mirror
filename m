From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: turn on network daemon tests by default
Date: Tue, 11 Feb 2014 15:04:45 -0500
Message-ID: <20140211200445.GA27946@sigill.intra.peff.net>
References: <20140210191521.GA3112@sigill.intra.peff.net>
 <20140210212931.GA16154@sigill.intra.peff.net>
 <xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 11 21:04:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDJZf-0001tv-6x
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 21:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902AbaBKUEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 15:04:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:48791 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755901AbaBKUEs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 15:04:48 -0500
Received: (qmail 24583 invoked by uid 102); 11 Feb 2014 20:04:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Feb 2014 14:04:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Feb 2014 15:04:45 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241960>

On Tue, Feb 11, 2014 at 11:51:18AM -0800, Junio C Hamano wrote:

> Those who run buildfarms may want to disable the networking test if
> the buildfarms are not isolated well, for example.  They have to be
> told somewhere that now they need to explicitly disable these tests
> and how.

I think they should be OK. The daemons run on the loopback interface, so
there is hopefully not a security implication. If multiple buildfarms
are sharing the same loopback space (e.g., running in separate
directories on the same machine), the "auto" setting should degrade
gracefully. One daemon will "win" the setup, and the tests will run, and
on the other, they will be skipped.

> I am in favor of this change but just pointing out possible fallouts
> might be larger than we think.

Agreed, but I think the only way to know the size of those fallouts is
to try it and see who complains.  I would not normally be so cavalier
with git itself, but I think for the test infrastructure, we have a
small, tech-savvy audience that can help us iterate on it without too
much pain.

-Peff
