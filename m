X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sylvain Beucler <beuc@gnu.org>
Subject: Overwriting bare repositories' master
Date: Sun, 29 Oct 2006 22:03:33 +0100
Message-ID: <20061029210333.GG12285@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 21:04:06 +0000 (UTC)
Cc: savannah-hackers-public@gnu.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Ovh-Remote: 82.238.35.175 (perso.beuc.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30461>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeHow-0004nv-23 for gcvg-git@gmane.org; Sun, 29 Oct
 2006 22:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030257AbWJ2VDv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 16:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWJ2VDv
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 16:03:51 -0500
Received: from 42.mail-out.ovh.net ([213.251.189.42]:32666 "EHLO
 42.mail-out.ovh.net") by vger.kernel.org with ESMTP id S1030257AbWJ2VDu
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 16:03:50 -0500
Received: (qmail 27858 invoked by uid 503); 29 Oct 2006 21:03:33 -0000
Received: from b6.ovh.net (HELO mail139.ha.ovh.net) (213.186.33.56) by
 42.mail-out.ovh.net with SMTP; 29 Oct 2006 21:03:33 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50) by b0.ovh.net with
 SMTP; 29 Oct 2006 21:03:48 -0000
Received: from perso.beuc.net (HELO localhost.localdomain) (82.238.35.175) by
 ns0.ovh.net with SMTP; 29 Oct 2006 21:03:45 -0000
Received: from me by localhost.localdomain with local (Exim 4.63)
 (envelope-from <beuc@beuc.net>) id 1GeHoc-0006Gk-06; Sun, 29 Oct 2006
 22:03:34 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

I'm trying to setup a git hosting facility, such as repo.or.cz. The
facility provides a pre-initialized git repository only accessible
through git-shell.

The goal is to minimise the system admins' intervention, and I have a
question about a branch 'overwriting'. For example, let's say the user
makes an initial import to refs/heads/master for testing purposes,
then wants to start over and import the real project. Can he put a
wholy different git repository in place of the other one, at the same
destination?

I tried and I found something that doesn't seem to follow the
documentation:

repo_one$ git push Beuc@cvs.sv.gnu.org:/srv/git/sources/administration.git \
  master:refs/heads/master
# [OK]
repo_two$ git push --force Beuc@cvs.sv.gnu.org:/srv/git/administration.git \
  +refs/heads/master:refs/heads/master
updating 'refs/heads/master'
  from ee3bda653dfabaf0f78f2a9977abec180f2b19dc
  to   c9a726b610bafc82142a16af80b83d28375ca619
Generating pack...
Done counting 0 objects.
Total 0, written 0 (delta 0), reused 0 (delta 0)
Unpacking 0 objects
error: denying non-fast forward; you should pull first

From man git-push:
"If the optional plus + is used, the remote ref is updated even if it
does not result in a fast forward update."

This also makes one wonder how the 'pu' git branch is updated.


One the one hand, this means that sysadmin intervention is required to
reset such a repository, which is bad. One the other hand, this is
also a security because users cannot erase history, even if there a
cron job to prune&pack the git repositories, which is good.

Is this by design? Or should it work?

-- 
