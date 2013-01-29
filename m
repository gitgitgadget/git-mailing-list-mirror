From: Jeff King <peff@peff.net>
Subject: Re: Cloning remote HTTP repository: Can only see 'master' branch
Date: Tue, 29 Jan 2013 03:23:17 -0500
Message-ID: <20130129082317.GA6396@sigill.intra.peff.net>
References: <83605E83-1110-449B-969D-AB43158376EA@atastypixel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Tyson <michael@atastypixel.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 09:23:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U06Tm-0005UU-RO
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 09:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548Ab3A2IXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 03:23:21 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53210 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190Ab3A2IXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 03:23:20 -0500
Received: (qmail 19608 invoked by uid 107); 29 Jan 2013 08:24:42 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 03:24:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 03:23:17 -0500
Content-Disposition: inline
In-Reply-To: <83605E83-1110-449B-969D-AB43158376EA@atastypixel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214913>

On Tue, Jan 29, 2013 at 04:54:13PM +1100, Michael Tyson wrote:

> I've a readonly git repository that I'm hosting via HTTP (a bare git
> repository located within the appropriate directory on the server). I
> push to it via my own SSH account (local repository with a remote
> pointing to the ssh:// URL).
> 
> This has all worked fine so far - I push via ssh, and others can clone
> and pull via the HTTP URL.
> 
> I've recently added a branch - "beta" - which pushed just fine, but
> now cloning via the HTTP URL doesn't seem to show the new branch -
> just master:

If you are using the "dumb" http protocol (i.e., the web server knows
nothing about git, and just serves the repo files), you need to run "git
update-server-info" after each push in order to update the static file
that tells the git client about each ref. You can have git do it
automatically for you by setting receive.updateServerInfo in the server
repo's config.

If the server is yours to control, consider setting up the "smart" http
protocol, as it is much more efficient. Details are in "git help
http-backend".

-Peff
