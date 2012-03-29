From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: git-svn: cloning an SVN repo with sub-branches and sub-tags
Date: Thu, 29 Mar 2012 07:40:22 -0700
Message-ID: <92FA9CF9-7E8E-4DE6-8524-030A0AD33C9E@apple.com>
References: <4F7467E1.3090004@pocock.com.au>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Pocock <daniel@pocock.com.au>
X-From: git-owner@vger.kernel.org Thu Mar 29 18:22:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDI7h-0001IY-Ca
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 18:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027Ab2C2QWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 12:22:49 -0400
Received: from bramley.apple.com ([17.151.62.49]:37053 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443Ab2C2QWr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 12:22:47 -0400
X-Greylist: delayed 3927 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Mar 2012 12:22:47 EDT
Received: from relay17.apple.com ([17.128.113.18])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTP id <0M1N00JOKHYV3SL0@mail-out.apple.com> for git@vger.kernel.org;
 Thu, 29 Mar 2012 07:40:27 -0700 (PDT)
X-AuditID: 11807112-b7f466d00000131a-6c-4f74745b2762
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay17.apple.com (Apple SCV relay)
 with SMTP id 4F.2D.04890.B54747F4; Thu, 29 Mar 2012 07:40:27 -0700 (PDT)
Received: from [17.153.52.236] (unknown [17.153.52.236])
 by koseret.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPSA id <0M1N00DNKI3AYY00@koseret.apple.com> for git@vger.kernel.org;
 Thu, 29 Mar 2012 07:40:27 -0700 (PDT)
In-reply-to: <4F7467E1.3090004@pocock.com.au>
X-Mailer: Apple Mail (2.1446)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsUiON1OXTe6pMTfYM9aYYuuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGX0rNnBWnBPrOLiyUssDYzLhbsYOTkkBEwkFv7sZYOwxSQu3FsP
	ZHNxCAl0Mkncm3GHEcJZzCRxZskfdpAqZgEdid7v35hBbF4BPYnJT1czgdjCAh4SzV/ngMXZ
	BDQkPp26C2ZzCuhK3N9wC2gqBweLgKrE8skCEGPEJdbNPQ81UlviybsLrBAjbSQu915gBLGF
	gFZtbWliAbFFgEb+ubmFCeJQWYnHCzayTWAUmIXkollILpqFZOwCRuZVjIJFqTmJlYbmeokF
	BTmpesn5uZsYQYHXUCi0g/H+Lr1DjAIcjEo8vCc1i/2FWBPLiitzDzFKcDArifAejyjxF+JN
	SaysSi3Kjy8qzUktPsQozcGiJM7rZlfkLySQnliSmp2aWpBaBJNl4uCUamC0UevLq/7iYDFv
	V13z/vXVP2cWLu7ZfXxqqdHbKqflMmtWuL9SFM5P7N0b9erRtNZdnKs4/s72/fzXUur1Pral
	N28v3NSvtdzrhcsfW6GminhWowgL0aRd7U65ax68Y2U5Pse1Nmqnbl22OaN20aWuQFOrZge/
	dxKdZTNMa048sivNEcj/fkWJpTgj0VCLuag4EQAFEpPVOAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194267>

You can make this work, but it is very fragile, doesn't scale well, and it only works on recent versions of git. For example, from the LLVM clang project:

ignore-refs = ^refs/remotes/svn/(Apple|ggreif|misc/Apple/williamson-llvm|misc/Apple/Necropolis|tags/Apple|tags/RELEASE_29|tags/RELEASE_30|tags/checker|tags/cremebrulee)
fetch = cfe/trunk:refs/remotes/svn/trunk
branches = cfe/branches/*:refs/remotes/svn/*
branches = cfe/branches/Apple/*:refs/remotes/svn/misc/Apple/*
branches = cfe/branches/Apple/Necropolis/*:refs/remotes/svn/misc/AppleNecropolis/*
branches = cfe/branches/ggreif/*:refs/remotes/svn/misc/ggreif/*
tags = cfe/tags/*:refs/remotes/svn/tags/*
tags = cfe/tags/Apple/*:refs/remotes/svn/tags2/Apple/*
tags = cfe/tags/RELEASE_29/*:refs/remotes/svn/tags2/RELEASE_29/*
tags = cfe/tags/RELEASE_30/*:refs/remotes/svn/tags2/RELEASE_30/*
tags = cfe/tags/checker/*:refs/remotes/svn/tags2/checker/*
tags = cfe/tags/cremebrulee/*:refs/remotes/svn/tags2/cremebrulee/*



On Mar 29, 2012, at 6:47 AM, Daniel Pocock <daniel@pocock.com.au> wrote:

> 
> 
> 
> I'm trying to use git-svn to clone a repo that has sub-branches and sub-tags
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
>  -T trunk \
>  -t tags \
>  -b branches \
>  https://flactag.svn.sourceforge.net/svnroot/flactag \
>  flactag-git1
> 
> I don't get any of the branches or tags, and I get numerous warnings like this:
> 
> W: -empty_dir: branches/d_pocock/autotools/HTTPFetch.cc
> W: -empty_dir: branches/d_pocock/autotools/HTTPFetch.h
> W: Cannot find common ancestor between f475b655c10b55b36df8376a396c0d9534418617 and 7e277bfd626a1caa84681e93a7af73e0160eb2eb. Ignoring merge info.
> W: Cannot find common ancestor between f475b655c10b55b36df8376a396c0d9534418617 and a82cd9bd2197a89303558af9aad43fa0c23d1ddb. Ignoring merge info.
> 
> I have the impression that git-svn does not like the repository layout, and it is not clear from the manual page how to make it work.  Can anyone share any advice about this?
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
