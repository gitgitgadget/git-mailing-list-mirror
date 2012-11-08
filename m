From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Another minor cleanup involving string_lists
Date: Thu, 8 Nov 2012 12:38:35 -0500
Message-ID: <20121108173835.GH15560@sigill.intra.peff.net>
References: <1352104883-21053-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 08 18:38:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWW45-00089L-G9
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 18:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab2KHRik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 12:38:40 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36494 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754801Ab2KHRij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 12:38:39 -0500
Received: (qmail 31235 invoked by uid 107); 8 Nov 2012 17:39:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 12:39:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 12:38:35 -0500
Content-Disposition: inline
In-Reply-To: <1352104883-21053-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209176>

On Mon, Nov 05, 2012 at 09:41:21AM +0100, Michael Haggerty wrote:

> Nothing really earthshattering here.  But it's funny how every time I
> look closely at a site where I think string_lists could be used, I
> find problems with the old code.  In this case is_absolute_path() is
> called with an argument that is not a null-terminated string, which is
> incorrect (though harmless because the function only looks at the
> first two bytes of the string).

Thanks, the new version is much easier on the eyes.

> Another peculiarity of the (old and new) code is that it rejects
> "comments" even in paths taken from the colon-separated environment
> variable GIT_ALTERNATE_OBJECT_DIRECTORIES.  The fix would be to change
> link_alt_odb_entries() to take a string_list and let the callers strip
> out comments when appropriate.  But it didn't seem worth the extra
> code.

I don't think it's worth worrying about. Given that the entries must be
absolute paths anyway, we do not even have to worry about an insane path
starting with "#".

-Peff
