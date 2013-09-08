From: Jeff King <peff@peff.net>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Sun, 8 Sep 2013 04:03:11 -0400
Message-ID: <20130908080311.GA25498@sigill.intra.peff.net>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
 <87wqon7ok4.fsf@igel.home>
 <7vli52uym0.fsf@alter.siamese.dyndns.org>
 <20130720002241.GA22143@sigill.intra.peff.net>
 <CALWbr2w7XCuD5tUSwR+Cwv4wyXLk8MHDGyU2Dr+jA9vOfDYqig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 10:03:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZxu-0003v8-Ny
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab3IHIDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:03:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:43535 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690Ab3IHIDP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 04:03:15 -0400
Received: (qmail 9742 invoked by uid 102); 8 Sep 2013 08:03:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 03:03:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 04:03:11 -0400
Content-Disposition: inline
In-Reply-To: <CALWbr2w7XCuD5tUSwR+Cwv4wyXLk8MHDGyU2Dr+jA9vOfDYqig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234216>

On Tue, Aug 20, 2013 at 05:12:47PM +0200, Antoine Pelisse wrote:

> On Sat, Jul 20, 2013 at 2:22 AM, Jeff King <peff@peff.net> wrote:
> > I do plan to finish it eventually, but if anyone else feels like picking
> > it up, I'd be glad to review patches and/or share my work-in-progress as
> > a starting point.
> 
> I have some free time to come, and would like to work on that feature.
> Does the offer still hold ?
> If it does, I would be interested in your patches.

I'm sorry I have taken so long to get back to you on this. I was hoping
to revisit the topic and make sure the patches were in a sensible state
for showing to somebody. But it took me some time to get around to it,
and now that I have, they're really not looking very good.

My general strategy was to factor out all of the "which refs to select"
code from git-tag (which knows --contains and --points-at) and
git-branch (which knows --merged, --no-merged, and --contains), and then
make them all available in a library-ish way to both commands, as well
as for-each-ref (which also knows name matching, which all 3 should
know, too). You can see my messy in-progress commit (that does not even
compile) at:

  git://github.com/peff/git.git jk/contains-wip

Part of the complication is that the filters have to happen at different
times (you can efficiently ask "--contains" for each ref as you see it,
but asking "--merged" must happen after you have collected each one).

I do not recall at this point what other issues led me to stop working
on it (it may simply have been time for dinner, and I never came back to
it). So the patches there may or may not actually be helpful to you.

Sorry I can't be more helpful. I'd be happy to discuss or review if you
want to work on it.

-Peff
