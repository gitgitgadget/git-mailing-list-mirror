X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jim Meyering <jim@meyering.net>
Subject: can I remove or move a tag in a remote repository?
Date: Sun, 19 Nov 2006 19:42:53 +0100
Message-ID: <87wt5rffbm.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 18:45:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Original-Lines: 46
X-Virus-Scanned: ClamAV 0.88.6/2203/Sat Nov 18 04:54:38 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31851>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glre8-0003qn-9y for gcvg-git@gmane.org; Sun, 19 Nov
 2006 19:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932823AbWKSSn6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 13:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbWKSSn6
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 13:43:58 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:32469 "EHLO
 zeus1.kernel.org") by vger.kernel.org with ESMTP id S932823AbWKSSn5 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 13:43:57 -0500
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64]) by
 zeus1.kernel.org (8.13.8/8.13.1) with ESMTP id kAJIhO5J024183 for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 18:43:37 GMT
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000) id
 49BE94EF5F; Sun, 19 Nov 2006 19:42:53 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

Periodically, I sync the coreutils git repository to an otherwise
read-only CVS repo, and use a cheap git tag named "cvs-head" to keep
track of the point to which the latest sync operation has run.
Then, after every sync-git-to-cvs operation, I run this:

  git-tag -f -m "most recent version that has been sync'd to cvs" cvs-head $sha1

Also periodically, I push my git working dir/repo to a public place,

  http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=summary

-----------------
Just today, I have finally pushed tags to that public repo, including the
"cvs-head" one (before there were no tags in the remote repo).  But now,
I've just done a local sync-to-cvs operation, which has resulted in
moving that tag to point to a different point in the git repo.

Here's the problem:
When I try to push the new tags, git-push fails:

  $ git-push -f --tags ssh+git://git.sv.gnu.org/srv/git/coreutils master:refs/heads/master
  updating 'refs/tags/cvs-head'
    from 2fd3fd29a8b40be695bc2327c8cd3bd33e521100
    to   db18f53ffb221e9957124d8af81c11a7e350ac3b
  ...
  Total 1, written 1 (delta 0), reused 0 (delta 0)
  Unpacking 1 objects
  error: denying non-fast forward; you should pull first

I get the same error also when using --force.

Perhaps I shouldn't push the cvs-head tag at all.
A few questions:
  - is there a way to say "push all tags matching /COREUTILS-*/"
      or to say "push all tags, except the ones on this list"?
  - is there a way to remove the cvs-head tag from the remote directory?
      Note: I don't have shell access there.  I can request that someone
      with shell access do it, but shouldn't have to resort to that.
  - is there some way to make "git push" do what I want, and update the
      offending tag in the remote repo?

Thanks for listening,

