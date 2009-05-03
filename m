From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] Add explict return to end of subroutines
Date: Sun, 3 May 2009 16:31:26 -0400
Message-ID: <20090503203126.GE20468@coredump.intra.peff.net>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu> <1241010743-7020-2-git-send-email-wfp5p@virginia.edu> <1241010743-7020-3-git-send-email-wfp5p@virginia.edu> <1241010743-7020-4-git-send-email-wfp5p@virginia.edu> <1241010743-7020-5-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bill Pemberton <wfp5p@virginia.edu>
X-From: git-owner@vger.kernel.org Sun May 03 22:31:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0iLV-0005xv-D2
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 22:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145AbZECUb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 16:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755774AbZECUb1
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 16:31:27 -0400
Received: from peff.net ([208.65.91.99]:32931 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757104AbZECUb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 16:31:27 -0400
Received: (qmail 14387 invoked by uid 107); 3 May 2009 20:31:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 03 May 2009 16:31:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 03 May 2009 16:31:26 -0400
Content-Disposition: inline
In-Reply-To: <1241010743-7020-5-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118190>

On Wed, Apr 29, 2009 at 09:12:21AM -0400, Bill Pemberton wrote:

> In perl a subroutine that ends without an explicit return will return
> the value of the last expression evalutated.  This can lead to
> unexpected return values.

I am not opposed to this, but it is really not helping anything. These
functions aren't meant to return any value, and their return values are
not used. In C, they would simply be declared "void", but there is no
way (AFAIK) to do that in perl.

But for some of them, I wonder if you would do better instead of
returning _nothing_ to return something that might make a little bit of
sense. For example, make_message_id munges a global variable. A
useful refactoring might be to have it return the value of the
global variable, and then perhaps even the global could go away, which
_would_ be a real improvement.

-Peff
