From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/14] Remove unused code from imap-send.c
Date: Sun, 13 Jan 2013 22:06:47 -0800
Message-ID: <20130114060647.GA4359@sigill.intra.peff.net>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:07:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TudCQ-0003Yd-Mh
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 07:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab3ANGGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 01:06:51 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60684 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab3ANGGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 01:06:50 -0500
Received: (qmail 15674 invoked by uid 107); 14 Jan 2013 06:08:06 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 01:08:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jan 2013 22:06:47 -0800
Content-Disposition: inline
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213449>

On Mon, Jan 14, 2013 at 06:32:32AM +0100, Michael Haggerty wrote:

> As discussed before [1], imap-send.c was copied from isync, including
> a lot of code that is not used within the git project.  This patch
> series rips a bunch of it out.

Thanks, this looks like a good direction.

I did not notice any problems reading through the patches, but my brain
is frazzled from a day of flying. I missed the problem Jonathan noticed.
:)

Some of the things you are removing are for advanced IMAP features that
imap-send does not need. In theory, somebody might extend it to use them
in the future. But since it has not seen any active feature development
in years, and since anybody could resurrect the code by reverting your
commits, I don't think it is a big risk.

I suspect you could go even further in ripping things out (e.g., I do
not think a server will generate an untagged namespace response at all
if we do not ask for it by issuing a namespace command). But you've
certainly grabbed the low-hanging fruit that can mostly be verified by
the compiler, and I don't know if it's worth the effort to go much
further, as it would require a lot of manual verification (and
understanding of IMAP, which will rot your brain).

-Peff
