X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: git-svn todo/wishlist
Date: Thu, 2 Nov 2006 23:01:36 -0800
Message-ID: <20061103070136.GB31917@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 07:01:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30789>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gft3d-0008MV-0v for gcvg-git@gmane.org; Fri, 03 Nov
 2006 08:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753171AbWKCHBh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 02:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbWKCHBh
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 02:01:37 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39836 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1753171AbWKCHBg (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 02:01:36 -0500
Received: by hand.yhbt.net (Postfix, from userid 500) id 5983A2DC034; Thu,  2
 Nov 2006 23:01:36 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

There are several things I'd like to see in git-svn, but haven't had
much time to do myself, and more interesting things keep popping up :)

Some of these I dread working on because it involves having to wrangle
with the (imho) overly complex SVN API, but the end user experience
should be better afterwards :)

1. Ability to transfer deltas over fetches.  Currently, we transfer
   deltas only when committing, but when we fetch, we fetch whole files
   if they're modified (like git with dumb protocols).  Our current method
   is very fast with fast connections and the code is very simple (I
   ripped the code off svnimport :), but users behind slower links will
   find the waiting for the svn server to generate a delta to be faster.

2. Ability to login and accept SSL certificates without relying on
   the caching done by the svn command-line client.  I tried doing this
   a while back, but was unsuccessful, and didn't look into it further.
   I couldn't get svm/SVN::Mirror to work with this, either.  This could
   be a bug in SVN bindings, too...

3. Documentation.  The -i/GIT_SVN_ID= stuff should probably be promoted
   more now that branches/tags are better supported.  More examples,
   too...

4. Would storing the SVN URLs in .git/config be a good idea?  I'm
   considering it as it would potentially simplify some things for
   people tracking multiple trees.

5. Ability to create tags/branches on the SVN side.  I'd like to avoid
   having to re-fetch all the new stuff into git if I created a new
   tag/branch on the SVN side.  This shouldn't be very hard to do.
   Avoiding re-fetching new stuff when somebody else creates a
   tag/branch would also be nice, but more involved.

6. Faster multi-fetch across a single repository.  This would probably
   be easier if we relied less on global variables and subprocesses.

7. Some method of handling svn:externals would be a nice feature to
   have.  This would be easier with subproject support from git.

8. Packed refs.  I haven't looked into this at all yet, I just heard of
   it just heard about it a while back and it ("packed refs") sounded
   like it could replace the .rev_db files I'm using in git-svn.

9. If not packed refs, then .rev_db could be transparently compressed.
   It's good for high-activity trunks; but very space-inefficient
   for tags and sparse branches.

-- 
