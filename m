From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Added a remote helper to interact with mediawiki,
 pull & clone handled
Date: Thu, 2 Jun 2011 18:49:31 -0400
Message-ID: <20110602224931.GA28189@sigill.intra.peff.net>
References: <1307006911-4326-1-git-send-email-arnaud.lacurie@ensimag.imag.fr>
 <20110602170327.GA2928@sigill.intra.peff.net>
 <BANLkTi=eYg3uT1hQZO03i4MLyhRkPzXK6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?SsOpcsOpbWll?= Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 03 00:49:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSGhy-00073h-H5
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 00:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab1FBWtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 18:49:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50654
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab1FBWte (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 18:49:34 -0400
Received: (qmail 584 invoked by uid 107); 2 Jun 2011 22:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Jun 2011 18:49:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2011 18:49:31 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=eYg3uT1hQZO03i4MLyhRkPzXK6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174984>

On Thu, Jun 02, 2011 at 10:28:33PM +0200, Arnaud Lacurie wrote:

> > Overall, it's looking pretty good. I like that I can resume a
> > half-finished import via "git fetch". Though I do have one complaint:
> > running "git fetch" fetches the metainfo for every revision of every
> > page, just as it does for an initial clone. Is there something in the
> > mediawiki API to say "show me revisions since N" (where N would be the
> > mediawiki revision of the tip of what we imported)?
> 
> I am not sure I understand your question. Because actually, we are
> supporting this, thanks to git notes. Like when you git fetch after a
> clone, it checks only the last revisions

Sorry, I was partially wrong in what I wrote above. I was resuming a
failed import (because of the bogus timestamp), so the numbers of
revisions were still high, and I thought they were the same as in the
original version. I see now doing a fetch on the completed import that
it properly finds 0 revisions for each page. So that's good.

However, it does still take O(number of pages) requests just to find out
that there is nothing to fetch. For the git wiki, this takes on the
order of 1.5 minutes to do an empty fetch. When getting the list of
pages, I wonder if there is a way in the mediawiki API to say "show me
only pages which have been modified since rev N".

-Peff
