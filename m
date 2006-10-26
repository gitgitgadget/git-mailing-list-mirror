X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 17:25:31 -0400
Message-ID: <20061026212531.GB15941@coredump.intra.peff.net>
References: <20061024002622.GC17019@over-yonder.net> <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz> <20061024163458.GH17019@over-yonder.net> <Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz> <20061025002713.GN17019@over-yonder.net> <Pine.LNX.4.63.0610251459160.1754@qynat.qvtvafvgr.pbz> <20061025235306.GD17019@over-yonder.net> <45408A53.10400@op5.se> <ehq78n$ec7$1@sea.gmane.org> <4540A1FE.4050300@ableton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 21:25:44 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4540A1FE.4050300@ableton.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30263>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdCjJ-0007TI-O6 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 23:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1945894AbWJZVZe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 17:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945899AbWJZVZe
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 17:25:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:41690
 "HELO peff.net") by vger.kernel.org with SMTP id S1945894AbWJZVZe (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 17:25:34 -0400
Received: (qmail 19810 invoked from network); 26 Oct 2006 17:24:37 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 26 Oct 2006 17:24:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Oct
 2006 17:25:31 -0400
To: Nicholas Allen <allen@ableton.com>
Sender: git-owner@vger.kernel.org

On Thu, Oct 26, 2006 at 01:54:38PM +0200, Nicholas Allen wrote:

> I would have thought that supports renames would also involve flagging a 
> conflict when merging a file that has been renamed on 2 separate 
> branches. ie 2 branches rename the file to different names and then one 
> branch is merged into the other. In this situation, the user should be 
> told of a rename conflict. Bzr supports this as far as I know. Not sure 
> about git though as I have never used it.

It works as you expect:

$ git-init-db
$ touch foo
$ git-add foo
$ git-commit -m foo
Committing initial tree 4d5fcadc293a348e88f777dc0920f11e7d71441c
$ git-checkout -b other
$ git-mv foo bar
$ git-commit -m bar
$ git-checkout master
$ git-mv foo baz
$ git-commit -m baz$a
$ git-pull . other
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with 5a1dfd32c56a24d0ef06f0e71d731fcd49d5dc6e
Merging:
76ac76ee3ce890d43648ebc009d278dc81a327e0 baz
5a1dfd32c56a24d0ef06f0e71d731fcd49d5dc6e bar
found 1 common ancestor(s):
c9e7e95de6fdbb2af06ea44cc60d1ac1a63eaad6 foo
CONFLICT (rename/rename): Rename foo->baz in branch HEAD rename foo->bar
in 5a1dfd32c56a24d0ef06f0e71d731fcd49d5dc6e
Automatic merge failed; fix conflicts and then commit the result.

