From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Thu, 2 May 2013 20:40:17 +0000
Message-ID: <20130502204017.GB26623@dcvr.yhbt.net>
References: <1438528085.20130501090926@gmail.com>
 <1409591910.20130501123153@gmail.com>
 <7vhaim8w48.fsf@alter.siamese.dyndns.org>
 <455264907.20130501235104@gmail.com>
 <20130501213031.GA13056@dcvr.yhbt.net>
 <7v1u9q5pu5.fsf@alter.siamese.dyndns.org>
 <20130502024926.GA12172@dcvr.yhbt.net>
 <12810110770.20130502213124@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 22:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY0Ii-0002cG-9W
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 22:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787Ab3EBUkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 16:40:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59896 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932619Ab3EBUkS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 16:40:18 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5201F42E;
	Thu,  2 May 2013 20:40:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <12810110770.20130502213124@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223262>

Ilya Basin <basinilya@gmail.com> wrote:
> Hi. I won't send you updated patches until I import and test my huge
> repo. Everything will be here:
> https://github.com/basinilya/git/commits/v1.8.2.2-git-svn-fixes
> 
> At the moment I've decided not to implement the Junio's proposal:
> > >> JCH> comment line "# added by git-svn only to keep the directory" and
> > >> JCH> consider a directory that has nothing but .gitignore that consists
> > >> JCH> of only that exact comment line an "added placeholder" directory to
> > >> JCH> work it around.
> 
> But the config file is not an option too: I have 400 tags, each has
> 200 empty folders.
> 
> Instead I decided to store the paths in a text file (see
> https://github.com/basinilya/git/commit/a961aedd81cb8676a52cfe71ccb6eba0f9e64b90 ).
> I'm not planning to push this change to you.
> 
> The last error I encountered is:
> r7009 = 39805bb078983e34f2fc8d2c8c02d695d00d11c0 (refs/remotes/DMC4_Basic)
> Too many open files: Can't open file '/home/il/builds/sicap/gitsvn/prd_dmc4.svn/db/revs/0/786': Too many open files at /.snapshots/persist/builds/git/git-git/perl/blib/lib/Git/SVN/Ra.pm line 282.
> 
> I think It's unrelated to empty dirs.

Can you get an lsof on the git-svn process right before this?
What's your open files limit?
