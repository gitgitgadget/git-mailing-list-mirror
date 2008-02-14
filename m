From: Jeff King <peff@peff.net>
Subject: Re: git-status producing incorrect results
Date: Thu, 14 Feb 2008 11:54:32 -0500
Message-ID: <20080214165432.GA28059@coredump.intra.peff.net>
References: <20080214164505.GA21932@coredump.intra.peff.net> <alpine.LSU.1.00.0802141650080.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:55:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPhMa-00005Q-Qx
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 17:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbYBNQyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 11:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbYBNQyf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 11:54:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1245 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbYBNQye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 11:54:34 -0500
Received: (qmail 8816 invoked by uid 111); 14 Feb 2008 16:54:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 14 Feb 2008 11:54:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2008 11:54:32 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802141650080.30505@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73890>

On Thu, Feb 14, 2008 at 04:51:04PM +0000, Johannes Schindelin wrote:

> I experienced the same bug, but when I looked in the tests, I had the 
> impression that it tested for that very bug, and succeeded.  And I did not 
> have time to look into it further.

Which test did you think was checking for it?

> Speaking of tests... How about it?

I included a "from scratch" test case in my last message which I think
helps in understanding what's happening. But if we just want to test
this condition (it fails because there is a new file that is added but
not committed):

diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index b64ce30..11e5655 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -128,4 +128,8 @@ test_expect_success 'status without relative paths' '
 
 '
 
+test_expect_success 'status of partial commit excluding new file in index' '
+	git status modified
+'
+
 test_done
