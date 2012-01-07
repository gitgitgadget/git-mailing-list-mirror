From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credentials: unable to connect to cache daemon
Date: Sat, 7 Jan 2012 09:55:38 -0500
Message-ID: <20120107145538.GC2461@sigill.intra.peff.net>
References: <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
 <20120105000713.GA24220@ecki.lan>
 <20120105025559.GB7326@sigill.intra.peff.net>
 <20120105160612.GA27251@ecki.lan>
 <20120106155204.GA17355@sigill.intra.peff.net>
 <20120106194800.GA9301@ecki.lan>
 <20120106223215.GA13106@sigill.intra.peff.net>
 <20120107115434.GA8568@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jan 07 15:55:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjXgb-0008Eg-24
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 15:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab2AGOzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 09:55:42 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60074
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab2AGOzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 09:55:42 -0500
Received: (qmail 16476 invoked by uid 107); 7 Jan 2012 15:02:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.2.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Jan 2012 10:02:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Jan 2012 09:55:38 -0500
Content-Disposition: inline
In-Reply-To: <20120107115434.GA8568@ecki.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188082>

On Sat, Jan 07, 2012 at 12:54:36PM +0100, Clemens Buchacher wrote:

> Error out if we just spawned the daemon and yet we cannot connect.

Actually it was intentional not to produce an error. The cache helper is
just a cache, so I consider it "best effort", and if it cannot cache a
password, it's not the end of the world. Git should continue, anyway.

That being said, it's probably nicer to be informative in this case than
not, since it is a configuration error the user probably would like to
fix. And since the rewrite of the credential helper API, it's OK for
helpers to return a failing exit code; git will just ignore it and keep
going.

So I think this is a reasonable thing to do.

Acked-by: Jeff King <peff@peff.net>

> And always release the string buffer.

Oops, thanks.

-Peff
