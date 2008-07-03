From: Jeff King <peff@peff.net>
Subject: Re: ':/<oneline prefix>' notation doesn't support full file syntax
Date: Thu, 3 Jul 2008 06:47:45 -0400
Message-ID: <20080703104744.GB26162@sigill.intra.peff.net>
References: <279b37b20807022242q69ad2fcbwb8c11a9d6165272d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:36:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEO36-0007XG-Ft
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657AbYGCMeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756645AbYGCMeX
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:34:23 -0400
Received: from peff.net ([208.65.91.99]:2365 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756599AbYGCMeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:34:22 -0400
Received: (qmail 2397 invoked by uid 111); 3 Jul 2008 10:47:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 03 Jul 2008 06:47:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jul 2008 06:47:45 -0400
Content-Disposition: inline
In-Reply-To: <279b37b20807022242q69ad2fcbwb8c11a9d6165272d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87277>

On Wed, Jul 02, 2008 at 10:42:52PM -0700, Eric Raible wrote:

> Although the rev-parse documentation claims that the
> tree-ish:path/to/file syntax works is applicable, this is
> not so when using the :/ "oneline prefix" syntax:
> 
> % git rev-parse v1.5.0.1-227-g28a4d94
> 28a4d940443806412effa246ecc7768a21553ec7
> % git rev-parse ":/object name"
> 28a4d940443806412effa246ecc7768a21553ec7
> 
> % git rev-parse v1.5.0.1-227-g28a4d94:sha1_name.c
> 0781477a71ac4d76a1b8783868d6649cae7f8507
> % git rev-parse ":/object name":sha1_name.c
> :/object name:sha1_name.c
> fatal: ambiguous argument ':/object name:sha1_name.c': unknown
> revision or path not in the working tree.
> Use '--' to separate paths from revisions
> 
> A quick look at int sha1_name.c:get_sha1() shows that it doesn't
> even try to make this work.  Is this worth fixing?
> Or at least documenting?

IMHO, :/ should stop eating text at the first ':', and allow '\:' for
a literal colon and '\\' for a literal backslash.

I think nobody has really cared up to this point (and I can't say that I
care that much now, but I wouldn't object to such a patch).

-Peff
