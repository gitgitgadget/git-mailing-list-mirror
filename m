From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Some questions on the idea of
Date: Sat, 14 Apr 2012 22:15:50 -0400
Message-ID: <20120415021550.GA24102@sigill.intra.peff.net>
References: <20120330203430.GB20376@sigill.intra.peff.net>
 <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
 <4F76E430.6020605@gmail.com>
 <4F772E48.3030708@gmail.com>
 <20120402210708.GA28926@sigill.intra.peff.net>
 <4F84DD60.20903@gmail.com>
 <20120411213522.GA28199@sigill.intra.peff.net>
 <4F872D24.8010609@gmail.com>
 <20120412210315.GC21018@sigill.intra.peff.net>
 <4F8A2EBD.1070407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 04:16:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJF19-00063Z-8F
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 04:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708Ab2DOCQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 22:16:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34746
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756650Ab2DOCQA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 22:16:00 -0400
Received: (qmail 5070 invoked by uid 107); 15 Apr 2012 02:16:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 14 Apr 2012 22:16:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Apr 2012 22:15:50 -0400
Content-Disposition: inline
In-Reply-To: <4F8A2EBD.1070407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195542>

On Sat, Apr 14, 2012 at 09:13:17PM -0500, Neal Kreitzinger wrote:

> Does a file's delta-compression efficiency in the pack-file directly
> correlate to its efficiency of transmission size/bandwidth in a
> git-fetch and git-push?  IOW, are big-files also a problem for
> git-fetch and git-push by taking too long in a remote transfer?

Yes. The on-the-wire format is a packfile. We create a new packfile on
the fly, so we may find new deltas (e.g., between objects that were
stored on disk in two different packs), but we will mostly be reusing
deltas from the existing packs.

So any time you improve the on-disk representation, you are also
improving the network bandwidth utilization.

-Peff
