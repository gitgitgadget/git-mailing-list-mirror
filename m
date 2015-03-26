From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge: deprecate 'git merge <message> HEAD <commit>'
 syntax
Date: Thu, 26 Mar 2015 09:20:15 -0400
Message-ID: <20150326132014.GA16427@peff.net>
References: <xmqqvbhoz75m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 14:20:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb7hv-00024Z-QZ
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 14:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbbCZNUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 09:20:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:38699 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751896AbbCZNUS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 09:20:18 -0400
Received: (qmail 32427 invoked by uid 102); 26 Mar 2015 13:20:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Mar 2015 08:20:17 -0500
Received: (qmail 23818 invoked by uid 107); 26 Mar 2015 13:20:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Mar 2015 09:20:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Mar 2015 09:20:15 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbhoz75m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266326>

On Wed, Mar 25, 2015 at 09:58:45PM -0700, Junio C Hamano wrote:

> We had this in "git merge" manual for eternity:
> 
>     'git merge' <msg> HEAD <commit>...
> 
>     [This] syntax (<msg> `HEAD` <commit>...) is supported for
>     historical reasons.  Do not use it from the command line or in
>     new scripts.  It is the same as `git merge -m <msg> <commit>...`.

It would be nice to see this ancient wart ago. I agree we need a
deprecation period, though, as you've outlined here.

>  builtin/merge.c               | 1 +
>  git-cvsimport.perl            | 2 +-
>  git-pull.sh                   | 2 +-
>  t/t3402-rebase-merge.sh       | 2 +-
>  t/t6021-merge-criss-cross.sh  | 6 +++---
>  t/t9402-git-cvsserver-refs.sh | 2 +-
>  6 files changed, 8 insertions(+), 7 deletions(-)

Maybe squash in:

diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 27c3d73..2af1bee 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -24,7 +24,7 @@ test_expect_success 'prepare repository' '
 '
 
 test_expect_success 'Merge with d/f conflicts' '
-	test_expect_code 1 git merge "merge msg" B master
+	test_expect_code 1 git merge -m "merge msg" master
 '
 
 test_expect_success 'F/D conflict' '


We do not call it HEAD here, but the setup test just before has put us
on branch B, so I think it is equivalent.

-Peff
