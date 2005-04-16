From: "Zed A. Shaw" <zedshaw@zedshaw.com>
Subject: Introductions
Date: Sat, 16 Apr 2005 12:50:15 -0400
Organization: ZedShaw.com
Message-ID: <1113670215.6025.36.camel@thamachine>
Reply-To: zedshaw@zedshaw.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 16 18:48:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMqT0-0002l9-CM
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 18:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVDPQvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVDPQvt
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 12:51:49 -0400
Received: from smtp04.mrf.mail.rcn.net ([207.172.4.63]:11930 "EHLO
	smtp04.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S262703AbVDPQvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 12:51:16 -0400
Received: from 207-237-211-198.c3-0.80w-ubr3.nyr-80w.ny.cable.rcn.com (HELO mythtv) (207.237.211.198)
  by smtp04.mrf.mail.rcn.net with ESMTP; 16 Apr 2005 12:51:16 -0400
X-IronPort-AV: i="3.92,106,1112587200"; 
   d="scan'208"; a="23176828:sNHT20447004"
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Just a short message to introduce myself and give a shameless plug.  I'm
Zed A. Shaw and I'm the author of a little unknown SCM called FastCST
(http://www.zedshaw.com/projects/fastcst ).  While I doubt that Linus
would ever adopt fastcst as his tool (and I probably wouldn't want him
too since it's not quite ready for prime time) I did find many of the
discussions on the list so far very interesting.

Some sent me Linus' message about wanting to do a diff on the whole
source tree, and just thought I'd mention that I already tried this in
FastCST.  FastCST uses a suffix array to construct a delta (not a diff),
so I thought it might be possible to simply apply the delta algorithm to
the entire source tree and get very small changesets.

It worked on small source trees, but when it came to the Linux 2.6 tree
it choked hard.  Even with an efficient suffix array implementation,
you're talking about performing a diff/delta on 225M of source.  Added
to the problem is that you have to track file locations within the
massive blob.  In the end, it also wasn't much more efficient from a
size/space/time perspective so I dropped it.

My current solution to Linus' problem is to use an inverted index to
process all the sources and revisions on the fly as they are created.
Using the inverted index, I'm able to VERY quickly find any chunk of
source in files or revisions.  This lets me track things like how
functions move through the files, where chunks of code moved to, etc.
In the end this turns out to be much more efficient (7 seconds on my
computer to find all references to "sprintf" in the Linux 2.6 source) as
I can use the super small deltas for distributing changes, and give
developers a means tracking content changes across "the world" in a
simple search format.

Anyway, just thought I'd throw in my experiences attempting what Linus
is talking about.  I actually agree with him that rename tracking isn't
that great, but I've come to the conclusion that tracking renames is
actually a specific case of just a general search problem.  Different
strokes for different folks I guess.

Other than that, I'm mostly interested in reading the messages and
probably won't write anything unless people ask me directly for
something.  Thanks!

Zed A. Shaw

