X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Combined diff format documentation
Date: Wed, 25 Oct 2006 15:40:51 -0700
Message-ID: <7vejswkoi4.fsf@assigned-by-dhcp.cox.net>
References: <ehoo2k$1g6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 22:41:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ehoo2k$1g6$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	26 Oct 2006 00:22:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30113>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcrQf-0001HR-FW for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965105AbWJYWkx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWJYWkx
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:40:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:58054 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S965105AbWJYWkx
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:40:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025224052.LEGT6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 18:40:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id emgb1V0071kojtg0000000 Wed, 25 Oct 2006
 18:40:35 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> 1. "git diff" header which looked like this
> 2. the "index" extended header line changes from
> 3. The "rename/copy" headers seems to be never present; see below.
>...

Thanks for starting this.  Your observation is correct.  It was
pretty much designed for quick _content_ inspection and renames
would work correctly to pick which blobs from each tree to
compare but otherwise not reflected in the output (the pathnames
are not shown as far as I know).  We could probably add it if
some users need it.

> 5. Hunk header is also modified: in ordinary diff we have
> ...
>    It might be not obvoious that we have (number of parents + 1) '@'
>    characters in chunk header for combined dif format.

Correct.  This was done to prevent people from accidentally
feeding it to "patch -p1".  In other words, we wanted to make it
so obvious that it is _not_ a patch.

There may be more information in "git log -- combine-diff.c"
output that ought to be collected into the documentation, and
now might be a good time to do so, given that that part of the
system is fairly stable and has not changed for quite some time
in git timescale.

>    BTW. it is not mentioned in documentation that git diff uses hunk section
>    indicator, and what regexp/expression it uses (and is it configurable).
>    Not described in documentation.

If you mean by "hunk section indicator" the output similar to
GNU diff -p option, I think it is not worth mentioning and we
are not ready to mention it yet (we have not etched the
expression in stone).  Nobody jumped up and down to say it needs
to be configurable, so it is left undocumented more or less
deliberately.

> 6. Documentation/diff-format.txt explains combined and condensed combined
>    format quite well, although it doesn't tell us if we can have plusses and
>    minuses together in one line...

But you already know the answer to that question, since you
asked me a few days ago ;-).

Patches to documentation would be easier to comment on and more
productive, I guess.

> Below there are following diffs: with first parent, merge (with all parents)
> with renames detection, combined, combined with rename detection. Is it all
> expected?

Yes.  I do not see anything obviously unexpected in your output.

