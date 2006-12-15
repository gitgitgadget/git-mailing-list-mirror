X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 12:27:53 +0100
Organization: At home
Message-ID: <elu0n5$u0i$1@sea.gmane.org>
References: <200612132200.41420.andyparkins@gmail.com> <20061213225627.GC32568@spearce.org> <200612140908.36952.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 11:26:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 63
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34494>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvBCU-0002hi-2C for gcvg-git@gmane.org; Fri, 15 Dec
 2006 12:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751641AbWLOLZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 06:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWLOLZ6
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 06:25:58 -0500
Received: from main.gmane.org ([80.91.229.2]:51659 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751641AbWLOLZ5
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 06:25:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvBCF-0002cZ-J3 for git@vger.kernel.org; Fri, 15 Dec 2006 12:25:47 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 12:25:47 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 12:25:47 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> On Wednesday 2006 December 13 22:56, Shawn Pearce wrote:
> 
>>   git cat-file -p $REV:$file
>>
>> not sure how much easier it gets than that.  Load in the bash
>> completion from contrib/completion and you can even tab complete
>> the $file part.
> 
> Yes.  I was a little unfair on that one; I forgot about the REV:file syntax.  
> However, it's still not simple for a new user; I think I'd say "draw" if 
> the "-p" weren't a requirement.

  $ git repo-config alias.less "-p cat-file -p"
  $ git repo-config alias.cat     "cat-file -p"

remedies that.

[...]
>> How is it unfriendly?  What specifically would you change to make
>> it more friendly?
> 
> $ git-ls-tree v1.0.0
> 100644 blob 906e98492080d2fde9467a9970fc92d7a8cfeaf8    Makefile
> 
> I'm a newbie:  what's that number at the front?  What's a blob?  What's that 
> great big number - I've only seen commit hashes that look like that, and that 
> isn't one.  Definitely not friendly.

The number in front is octal mode of a file or directory. "blob"
is a file (or symbolic link), "tree" is a directory, all of this
can be found in git(7).

The "great big number" is blob hash. All objects are identified
and referenced by SHA-1 hash of its contents: be it commits, blobs
(contents of a file), trees (content of a directory), tags.

You can always use --abbrev option to have it shortened.

> $ svn list -r 14
> Makefile
> 
> It could probably be fixed by making git-ls-files capable of understanding 
> tree-ish.

Perhaps we should add git-ls which would be porcelain frontend
to git-ls-files and git-ls-tree, just like git-diff is frontend
to git-diff-files, git-diff-index and git-diff-tree (and also does
pure blob diff).

"svn list -r 14" equivalent is "git ls-tree --name-only v1.0.0".
You can always do

  $ git repo-config alias.list "ls-tree --name-only"

(or use --name-status instead of --name-only).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

