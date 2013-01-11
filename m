From: Jeff King <peff@peff.net>
Subject: Re: git-archive fails against smart-http repos
Date: Fri, 11 Jan 2013 15:58:49 -0500
Message-ID: <20130111205849.GA17810@sigill.intra.peff.net>
References: <6014ED12-17F9-4D57-927F-6AFCD8A51C9D@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bruce Lysik <blysik@apple.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 21:59:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttlh2-0004gL-ET
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 21:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab3AKU6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 15:58:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57797 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232Ab3AKU6v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 15:58:51 -0500
Received: (qmail 24477 invoked by uid 107); 11 Jan 2013 21:00:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jan 2013 16:00:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2013 15:58:49 -0500
Content-Disposition: inline
In-Reply-To: <6014ED12-17F9-4D57-927F-6AFCD8A51C9D@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213243>

On Wed, Jan 09, 2013 at 10:52:48AM -0800, Bruce Lysik wrote:

> Trying to run git-archive fails against smart-http based repos.  Example:
> 
> $ git archive --verbose --format=zip --remote=http://code.toofishes.net/git/dan/initscripts.git
> fatal: Operation not supported by protocol.
> Unexpected end of command stream
> 
> This problem was brought up against my internal repos as well.

Right. Neither the client nor server for the http transport knows how to
handle the "git-upload-archive" service (as opposed to the regular
"git-upload-pack" or "git-receive-pack" services). I don't think there's
anything technical standing in the way; it is has simply never been
implemented.

Currently, you can do remote git-archive only locally, via ssh, or over
git:// (but then only if the server side has explicitly enabled it).

Patches welcome.

-Peff
