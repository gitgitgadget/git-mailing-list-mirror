From: Jeff King <peff@peff.net>
Subject: Re: fetch --no-tags with and w/o --all
Date: Wed, 6 Mar 2013 20:08:29 -0500
Message-ID: <20130307010829.GB850@sigill.intra.peff.net>
References: <1879950.i2j8pjGADy@gandalf>
 <7vboawp4zy.fsf@alter.siamese.dyndns.org>
 <20130307002038.GA31571@sigill.intra.peff.net>
 <7vhakonirb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Cristian Tibirna <ctibirna@giref.ulaval.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 02:08:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDPKL-0007iZ-Ha
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 02:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab3CGBIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 20:08:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38701 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509Ab3CGBIb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 20:08:31 -0500
Received: (qmail 32553 invoked by uid 107); 7 Mar 2013 01:10:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 20:10:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 20:08:29 -0500
Content-Disposition: inline
In-Reply-To: <7vhakonirb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217568>

On Wed, Mar 06, 2013 at 04:41:44PM -0800, Junio C Hamano wrote:

> > Or we could just pass them through. Looks like this was already fixed by
> > 8556646 (fetch --all: pass --tags/--no-tags through to each remote,
> > 2012-09-05), which is in v1.7.12.2 and higher.
> 
> ;-)  No wonder this looked somewhat familiar.

I still find it somewhat gross that we actually re-construct the
command-line from the parsed flag variables. It seems like it would be
easier to simply propagate the argv we got in the first place, and then
we would not have any chance of omitting a new option that is added
later.

Probably not worth worrying about now, though, as the fix is long since
shipped.  The next person who is adding an option can look at doing that
refactoring. And it may be that there are some options we don't
propagate intentionally (I didn't look closely).

-Peff
