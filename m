From: Jeff King <peff@peff.net>
Subject: Re: [BUG] shallow clones over http
Date: Sat, 13 Apr 2013 02:03:10 -0400
Message-ID: <20130413060310.GA21921@sigill.intra.peff.net>
References: <20130403040352.GA8284@sigill.intra.peff.net>
 <loom.20130410T135840-387@post.gmane.org>
 <loom.20130410T144700-304@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tom <mail@tgries.de>
X-From: git-owner@vger.kernel.org Sat Apr 13 08:03:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQtYT-0006fM-ST
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 08:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513Ab3DMGDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 02:03:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43704 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478Ab3DMGDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 02:03:13 -0400
Received: (qmail 2123 invoked by uid 107); 13 Apr 2013 06:05:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 13 Apr 2013 02:05:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Apr 2013 02:03:10 -0400
Content-Disposition: inline
In-Reply-To: <loom.20130410T144700-304@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221053>

On Wed, Apr 10, 2013 at 12:48:51PM +0000, Tom wrote:

> The problem occurs to me also when I want to "deepen" a shallow clone of
> MediaWiki via https://
> 
>  git clone --depth 1 https://gerrit.wikimedia.org/r/p/mediawiki/core.git
>  git pull --depth=99999
> 
> fatal: git fetch-pack: expected shallow list.
> 
> Perhaps it helps someone to find the reason.
> 
> UPDATE:
> 
> This however works
> 
>  git clone --depth=2 https://gerrit.wikimedia.org/r/p/mediawiki/core.git
>  git fetch --depth=5

Yes, I experienced the same thing. I don't think the problem is related
to the depth per se, but rather the particular pattern of ACKs that
upload-pack sends based on which commits are being selected.

-Peff
