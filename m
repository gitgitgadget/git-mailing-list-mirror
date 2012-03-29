From: Stephen Bash <bash@genarts.com>
Subject: Re: git-svn: cloning an SVN repo with sub-branches and sub-tags
Date: Thu, 29 Mar 2012 12:03:13 -0400 (EDT)
Message-ID: <de61c3ca-6678-49da-8803-a78d9f25a3b6@mail>
References: <4F7467E1.3090004@pocock.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Pocock <daniel@pocock.com.au>
X-From: git-owner@vger.kernel.org Thu Mar 29 18:03:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDHou-0006QM-8P
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 18:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865Ab2C2QDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 12:03:24 -0400
Received: from hq.genarts.com ([173.9.65.1]:60633 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751938Ab2C2QDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 12:03:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id B8BF4BE6EAD;
	Thu, 29 Mar 2012 12:03:19 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tNv6ApAcuj8B; Thu, 29 Mar 2012 12:03:13 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id B8C7FBE6EAC;
	Thu, 29 Mar 2012 12:03:13 -0400 (EDT)
In-Reply-To: <4F7467E1.3090004@pocock.com.au>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC17 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194264>



----- Original Message -----
> From: "Daniel Pocock" <daniel@pocock.com.au>
> To: git@vger.kernel.org
> Sent: Thursday, March 29, 2012 9:47:13 AM
> Subject: git-svn: cloning an SVN repo with sub-branches and sub-tags
> 
> I'm trying to use git-svn to clone a repo that has sub-branches and
> sub-tags
> 
> The SVN layout is like this:
> 
> branches/user1/workitem1
> branches/user1/workitem2
> branches/user2/workitem1
> branches/user2/workitem2
> 
> tags/v1.0
> tags/v1.1
> tags/debian/v1.0-1
> tags/debian/v1.1-1
> tags/debian/v1.1-2
> 
> In git, I would like to have branches with the same names, e.g.
> 
> branches/user1/workitem1
> branches/user1/workitem2
> branches/user2/workitem1
> branches/user2/workitem2
> 
> and tags like this:
> 
> 1.0  (notice I don't want to keep the v1.0, drop the v)
> 1.1
> debian/1.0-1
> debian/1.1-1
> debian/1.1-2
> 
> However, if I run
> 
> git svn clone \
>    -T trunk \
>    -t tags \
>    -b branches \
>    https://flactag.svn.sourceforge.net/svnroot/flactag \
>    flactag-git1
> 
> I don't get any of the branches or tags, and I get numerous warnings
> like this:
> 
> W: -empty_dir: branches/d_pocock/autotools/HTTPFetch.cc
> W: -empty_dir: branches/d_pocock/autotools/HTTPFetch.h
> W: Cannot find common ancestor between
> f475b655c10b55b36df8376a396c0d9534418617 and
> 7e277bfd626a1caa84681e93a7af73e0160eb2eb. Ignoring merge info.
> W: Cannot find common ancestor between
> f475b655c10b55b36df8376a396c0d9534418617 and
> a82cd9bd2197a89303558af9aad43fa0c23d1ddb. Ignoring merge info.
> 
> I have the impression that git-svn does not like the repository
> layout and it is not clear from the manual page how to make it 
> work.  Can anyone share any advice about this?

Complicated layouts can require a special git-svn configuration.  See the configuration section at the end of the git-svn manpage:

  http://schacon.github.com/git/git-svn.html

My usual work flow is:

  git svn init /path/to/git/repo
  cd /path/to/git/repo
  edit .git/config
  git svn fetch

In the [svn-remote] section of Git config you can have multiple fetch, branches, and tag entries as long as each entry maps to a unique Git ref.

HTH,
Stephen
