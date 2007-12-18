From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 22:24:26 +0100
Message-ID: <200712182224.28152.jnareb@gmail.com>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> <20071218204623.GC2875@steel.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dana How" <danahow@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:29:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jzk-0005YN-PD
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757735AbXLRVYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 16:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757729AbXLRVYe
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:24:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:14560 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756759AbXLRVYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 16:24:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so191069ugc.16
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 13:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=tumKB4JqKA/QvlkwN1qVH6Z5rnGAtszmOYYda7/zJ2s=;
        b=BFqsMPhQMmzD9ts4kbvsoJgVVKs2wjvBxiFupztDs4+fxpsVB55YV4wy80e/nL7hwoXKegDonN+Bbqc94kdHIiY66TKHyoVEklbFmImr3wSZeguJdlu28LSUwwkeWfc7JZpB5WQwPnhV5niYojTVNIo8ItyaiQ1/Is+ekPN/Arw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=V+DNadwq7BiYBKy8oAL4Xhty5u7VUsIjYe7o6BAt+1ESXdFnFeNTuoLqcmso6LL4oJzC5JOt3qLE72k1dn/6YaTzcE2OEHSHtVGAaERCDSpKScCXtnobo4V2POPlMpusCfMmeMpt7N8NbDvJKDpx3+MWbiHSDXwJY9ScknLpx9U=
Received: by 10.67.116.7 with SMTP id t7mr1347865ugm.38.1198013070213;
        Tue, 18 Dec 2007 13:24:30 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.201])
        by mx.google.com with ESMTPS id u1sm2982685uge.14.2007.12.18.13.24.27
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 13:24:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071218204623.GC2875@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68819>

On Tue, 18 Dec 2007, Alex Riesen wrote:
> Jakub Narebski, Tue, Dec 18, 2007 18:50:20 +0100:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> 
>>> Noticed by a collegue of mine. Consider:
>>> 
>>>     $ cd $GIT/t
>>>     $ git show 570f32266:t/test-lib.sh    # works
>>>     $ git show 570f32266:test-lib.sh      # does not work
>>>     $ git show 570f32266:./test-lib.sh    # does not work
>>>     $ git show 570f32266:/t/test-lib.sh   # does not work
>>> 
>>> Considering that the relative path names work as filters (and many
>>> agreed on that being useful), it would be nice to allow relative
>>> pathnames in blob specifications for git-show and git-cat-file.
>>> 
>>> (besides the colon is a good delimiter, even tab-completion
>>> works with it) 
>> 
>> If you think about it a bit, relative path names nor absolute
>> path names does and should not work.  570f32266:t/test-lib.sh
>> means path t/test-lib.sh staring from 570f32266^{tree}.  Where
>> you are in the filesystem is not important and matters not for
>> this syntax.  Besides if you access other branch file might be
>> not in filesystem (deleted file, or disjoint branch with separate
>> contents like 'todo' or 'html' branch in git.git repository).
> 
> Not convinced. It is *not* the plumbing problem I was trying to
> describe. They discussion, metaphorically, should not have left the
> command-line parser.
> 
> I think that we have parsing of the blob locators at the wrong level:
> so that git-show, git-log and git-diff can handle its pathnames as
> they handle path filters (relative to cwd),

What cwd? <path> in <tree-ish>:<path> syntax is "relative" to <tree-ish>.
IMHO "<tree-ish>:<path>" should be considered (and is considered) as
one object: current working directory doesn't matter at all there,
contrary to "<tree-ish> -- <pathspec>" where it is natural that <pathspec>
is relative to current working directory.

What should git do in your proposal when we are on master branch in
Documentation subdirectory, and want to check TODO file in todo branch?
"git show todo:TODO" is most natural IMHO.

Note that for true <tree> as <tree-ish> you just don't know where
in the working area directory hierarchy <tree> can be. This means you
do't know relation of <tree> and <path> in <tree>:<path> to cwd.

> and git-cat-file, 
> git-diff-tree, git-rev-list, etc can handle theirs always relative to
> the project root.

Not "relative to project root". Relative to tree-ish used on right hand
side in <tree-ish>:<path> extended SHA-1 syntax. It is usually project
root, because when you specify <commit> or <tag> as <tree-ish> it refers
to top/root directory of a project.

> I actually do not see any problem for git-show (being porcelain-level
> program) to treat *each and every* path anywhere relatively to the
> current directory. It is just more comfortable.

This breaks backward compatibility, hard. And IMHO breaks layers.

But if (big if) it was to be implemented, default behavior should be
unchanged, and relative to the cwd (layers!) should use new syntax,
for example

     $ cd $GIT/t
     $ git show 570f32266:t/test-lib.sh    # works
     $ git show 570f32266:test-lib.sh      # should not work
     $ git show 570f32266:./test-lib.sh    # should work
     $ git show 570f32266:/t/test-lib.sh   # should perhaps work
 
Currently ":/<text>" (but not "<ref>:/<text>") is taken; see
git-rev-parse(1), "Specifying revisions".

-- 
Jakub Narebski
Poland
