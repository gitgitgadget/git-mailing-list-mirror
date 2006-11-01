X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same name as path
Date: Tue, 31 Oct 2006 16:24:45 -0800
Message-ID: <7vejsoovxu.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200610302229.06957.jnareb@gmail.com>
	<200610311753.20711.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 00:25:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610311753.20711.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 31 Oct 2006 17:53:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30611>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf3um-0001Or-H3 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 01:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946236AbWKAAYr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 19:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946238AbWKAAYr
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 19:24:47 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:57218 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1946236AbWKAAYq
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 19:24:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101002446.KNKH2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Tue, 31
 Oct 2006 19:24:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hCQq1V00k1kojtg0000000 Tue, 31 Oct 2006
 19:24:51 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Please remove this chunk from patch!. It makes gitweb "tree" view
> empty. I have forgot that git-ls-tree _requires_ <tree-ish> so there
> is no way to mistake pathspec with <tree-ish>.

To be honest, I dislike these */n series where the the end is
unknown.  It just confuses me what's still surviving, what's
already shot down, and what's being rerolled.

Let's step back a bit and see if we share the same view as to
the status of each one:

[PATCH/RFC 1/n] gitweb: Better git-unquoting and gitweb-quoting of p...

Marked preliminary, perhaps need some discussion and rerolling
but I haven't looked at it.

[PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path

Discussed; we agreed that showing byte values in different
colors is preferable.  Waiting for re-roll.

[PATCH 3/n] gitweb: Use 's' regexp modifier to secure against filena...

I looked at it although haven't said anything yet.  Probably a
safe and good change but I wonder how LF at the end of the line
matches /...(.+)$/s pattern; iow, if we do not use -z does it
still do the right thing?  Otherwise I suspect you would perhaps
need to chomp?

[PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same...

Good fix and even improves readability; will apply after
dropping -- from ls-tree args.

[PATCH 5/n] [take 3] gitweb: New improved patchset view
[PATCH 6/n] gitweb: Remove redundant "blob" links from git_difftree_...
[PATCH 7/n] gitweb: Output also empty patches in "commitdiff" view
[PATCH 8/n] gitweb: Fix two issues with quoted filenames in git_patc...

Haven't looked at them and I do not think people have had enough
time to comment on them yet.
