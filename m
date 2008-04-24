From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3 v2] Add --blob-filter option to filter-branch.
Date: Wed, 23 Apr 2008 21:33:00 -0400
Message-ID: <20080424013259.GA31146@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0804232113480.20267@eeepc-johanness> <1208981890-758-1-git-send-email-apenwarr@gmail.com> <20080423215501.GB30057@sigill.intra.peff.net> <32541b130804231507l4aff2ca3x962bf385a409685b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 03:33:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoqLJ-00018D-Jh
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 03:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbYDXBc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 21:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbYDXBc5
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 21:32:57 -0400
Received: from peff.net ([208.65.91.99]:3273 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbYDXBc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 21:32:57 -0400
Received: (qmail 12040 invoked by uid 111); 24 Apr 2008 01:32:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 21:32:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 21:33:00 -0400
Content-Disposition: inline
In-Reply-To: <32541b130804231507l4aff2ca3x962bf385a409685b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80282>

On Wed, Apr 23, 2008 at 06:07:03PM -0400, Avery Pennarun wrote:

> I think it would be fine to index into the cache using $path$sha1,
> which would seem to resolve this issue.  The catch is that $path isn't
> a very good cachefile name.  I'd suggest doing an md5sum or something
> on it, but that would result in an extra fork for every file, which
> brings us back to our original level of slowness (or worse).
> 
> Hmm, I gues using a cachefile like $sha1/$path would work; it requires
> a "mkdir -p", but only when *filling* the cache.

Keep in mind that $path can have slashes. So you actually need to:

   mkdir -p `dirname $sha1/$path`
   echo $new >$sha1/$path

-Peff
