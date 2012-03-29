From: Daniel Pocock <daniel@pocock.com.au>
Subject: git-svn: cloning an SVN repo with sub-branches and sub-tags
Date: Thu, 29 Mar 2012 14:47:13 +0100
Message-ID: <4F7467E1.3090004@pocock.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 16:00:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDFtX-00009Q-39
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 16:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759383Ab2C2OAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 10:00:01 -0400
Received: from mail1.trendhosting.net ([195.8.117.5]:41490 "EHLO
	mail1.trendhosting.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758276Ab2C2OAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 10:00:00 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Mar 2012 10:00:00 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail1.trendhosting.net (Postfix) with ESMTP id 8EC041577D
	for <git@vger.kernel.org>; Thu, 29 Mar 2012 14:53:25 +0100 (BST)
Received: from mail1.trendhosting.net ([127.0.0.1])
	by localhost (thp003.trendhosting.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BFHBwlOVpr-0 for <git@vger.kernel.org>;
	Thu, 29 Mar 2012 14:53:19 +0100 (BST)
Received: from [192.168.5.2] (thp001.trendhosting.net [195.8.117.3])
	by mail1.trendhosting.net (Postfix) with ESMTP id 1EE1C15765
	for <git@vger.kernel.org>; Thu, 29 Mar 2012 14:53:19 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.20) Gecko/20110804 Lightning/1.0b2 Thunderbird/3.1.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194259>




I'm trying to use git-svn to clone a repo that has sub-branches and sub-tags

The SVN layout is like this:

branches/user1/workitem1
branches/user1/workitem2
branches/user2/workitem1
branches/user2/workitem2

tags/v1.0
tags/v1.1
tags/debian/v1.0-1
tags/debian/v1.1-1
tags/debian/v1.1-2

In git, I would like to have branches with the same names, e.g.

branches/user1/workitem1
branches/user1/workitem2
branches/user2/workitem1
branches/user2/workitem2

and tags like this:

1.0  (notice I don't want to keep the v1.0, drop the v)
1.1
debian/1.0-1
debian/1.1-1
debian/1.1-2

However, if I run

git svn clone \
   -T trunk \
   -t tags \
   -b branches \
   https://flactag.svn.sourceforge.net/svnroot/flactag \
   flactag-git1

I don't get any of the branches or tags, and I get numerous warnings 
like this:

W: -empty_dir: branches/d_pocock/autotools/HTTPFetch.cc
W: -empty_dir: branches/d_pocock/autotools/HTTPFetch.h
W: Cannot find common ancestor between 
f475b655c10b55b36df8376a396c0d9534418617 and 
7e277bfd626a1caa84681e93a7af73e0160eb2eb. Ignoring merge info.
W: Cannot find common ancestor between 
f475b655c10b55b36df8376a396c0d9534418617 and 
a82cd9bd2197a89303558af9aad43fa0c23d1ddb. Ignoring merge info.

I have the impression that git-svn does not like the repository layout, 
and it is not clear from the manual page how to make it work.  Can 
anyone share any advice about this?
