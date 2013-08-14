From: Jeff King <peff@peff.net>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Wed, 14 Aug 2013 02:59:33 -0400
Message-ID: <20130814065933.GB3744@sigill.intra.peff.net>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
 <7veh9z1gym.fsf@alter.siamese.dyndns.org>
 <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
 <CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com>
 <7vk3jpy1qt.fsf@alter.siamese.dyndns.org>
 <520AC9A8.4030104@gmail.com>
 <7vmwolujvb.fsf@alter.siamese.dyndns.org>
 <520B2478.3000100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	David Jeske <davidj@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 08:59:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9V3V-0005T7-2d
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 08:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864Ab3HNG7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 02:59:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:35223 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942Ab3HNG7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 02:59:36 -0400
Received: (qmail 3424 invoked by uid 102); 14 Aug 2013 06:59:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Aug 2013 01:59:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Aug 2013 02:59:33 -0400
Content-Disposition: inline
In-Reply-To: <520B2478.3000100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232263>

On Wed, Aug 14, 2013 at 12:02:24PM +0530, Sitaram Chamarty wrote:

> >>     # all reflog entries that are not on a branch, tag, or remote
> >>     d1 = !gitk --date-order $(git log -g --pretty=%H) --not --branches --tags --remotes
> [...]
>
> > A potential problem is that the output from "log -g --pretty=%H" or
> > "fsck | grep dangling" may turn out to be humongous.  Other than
> > that, they correctly compute what you want.
> 
> I thought I mentioned that but I can't find my email now so maybe I
> didn't.
> 
> In practice though, I find that, bash at least seems happy to take
> command lines as long as 7+ million characters long, so with the default
> reflog expire times, that should work out to 10,000 commits *per day*.
> [Tested with: echo {1000000..1900000}  > junk; echo `cat junk` | wc]

You can also do:

  git log -g --pretty=%H |
  git log --stdin --not --branches --tags --remotes

to avoid any argv limitations.

-Peff
