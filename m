From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/22] t3204: test deleting references when lock files
 already exist
Date: Tue, 1 Apr 2014 15:53:39 -0400
Message-ID: <20140401195338.GA21715@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
 <1396367910-7299-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:53:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4kk-0007aR-Gr
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbaDATxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:53:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:52002 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751676AbaDATxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:53:41 -0400
Received: (qmail 20496 invoked by uid 102); 1 Apr 2014 19:53:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 14:53:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 15:53:39 -0400
Content-Disposition: inline
In-Reply-To: <1396367910-7299-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245642>

On Tue, Apr 01, 2014 at 05:58:09PM +0200, Michael Haggerty wrote:

> When deleting a reference, it might be that another process already
> holds the lock on the loose reference file and/or the packed-refs
> file.  In those cases, there is no alternative but for the delete to
> fail.  Verify that in such cases the reference values are left
> unchanged.
> 
> But in fact, when the packed-refs file lock cannot be acquired, the
> loose reference file is deleted anyway, potentially leaving the
> reference with a changed value (its packed value, which might even
> point at an object that has been garbage collected).  Thus one of the
> new tests is marked test_expect_failure.

Nice find. If I understand correctly, the problem is at the plumbing
level, and this could also be demonstrated with update-ref?

I don't think it is a big deal, but I was thrown for a minute by the use
of "git branch" (as in, "is this something special with branches, or is
this about all refs?").

-Peff
