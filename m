X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jim Meyering <jim@meyering.net>
Subject: an option to make "git-diff Z A" prints Z's diff before A's
Date: Wed, 25 Oct 2006 09:15:18 +0200
Message-ID: <871wowzx15.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 07:15:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Original-Lines: 33
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30036>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gccz3-00064p-CV for gcvg-git@gmane.org; Wed, 25 Oct
 2006 09:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423025AbWJYHPV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 03:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423039AbWJYHPV
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 03:15:21 -0400
Received: from mx.meyering.net ([82.230.74.64]:42219 "EHLO mx.meyering.net")
 by vger.kernel.org with ESMTP id S1423025AbWJYHPT (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 03:15:19 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000) id
 6FF805ED7; Wed, 25 Oct 2006 09:15:18 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

In a recent patch set I prepared, I placed the names of the
more relevant files at the front of the list given to "git-diff".
So I was surprised to see diff output in which the blocks of output
are sorted by file name.  The parts I'd tried to put at the "top"
ended up being buried in the latter part of the patch.

Here's a small test case:

mkdir d && cd d && touch x y && git-init-db
git-add x y && git-commit -m. x y
echo a > x && echo a > y
git-diff y x|grep '^d'

I expected this git-diff output, with "y's" diff first:
diff --git a/y b/y
diff --git a/x b/x

but got this, where x's come first:
diff --git a/x b/x
diff --git a/y b/y

I know about the -O<orderfile> option, and it can make git-diff do
what I want, but only if I first create a separate file containing
the names that I'm already providing to git-diff in the very same order.

Is there an easier way?

If not, would you be amenable to a new option enabling this behavior
without requiring a temporary file?

