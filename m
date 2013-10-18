From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Fri, 18 Oct 2013 18:50:32 -0400
Message-ID: <201310182250.r9IMoW57003157@freeze.ariadne.com>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com>
	<xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
	<201310171909.r9HJ9mxd007908@freeze.ariadne.com> <xmqq4n8fzmmj.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 00:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXIsa-0002Ua-N0
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 00:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757406Ab3JRWuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 18:50:35 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:40641
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757376Ab3JRWue (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Oct 2013 18:50:34 -0400
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id emjA1m00327AodY5Cmqamk; Fri, 18 Oct 2013 22:50:34 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id emqZ1m00i1KKtkw3fmqZVr; Fri, 18 Oct 2013 22:50:34 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r9IMoWdW003158;
	Fri, 18 Oct 2013 18:50:33 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r9IMoW57003157;
	Fri, 18 Oct 2013 18:50:32 -0400
In-reply-to: <xmqq4n8fzmmj.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1382136634;
	bh=gc7A760tkEqo8qjhEG3iOyPSeImWqGqNRP7yBwP7gsI=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=CnJr8TESIqQZMt+BSTtCiF3IGhHF6eiWsjnVqS3Uimc6CUgPw5cGNqQcJc8A6qG2K
	 0WHcE00Bcum4PP0D4b/XyHorKt/zkHkfU8gDHpLB13Kaf77HYPl/loFCAeyiw+kCia
	 ySkBKHkArcEobsfcDP5imTfSr762jtIwyROXYVm1xUQffKun9w6CIr5GZCJN2EXnjl
	 ahOFf1+MNWGjg/Q8yz2Jhq98je9cJ9OH4MScx0rfMcqxngjqXTT7eyitynBtVyQrCL
	 W+xEsXq9C6NkJ0ACF+xVW6JX57Sj+yswbs/X1snzXX0x7sDD7O204YaOCH23aJX2kS
	 VqV/cLtecmXgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236376>

> From: Junio C Hamano <gitster@pobox.com>

> Now, when you say "the cwd contains the .git directory", do you mean
> 
> 	cd /repositories
>         git add ../working/trees/proj-wt1/file
> 
> updates "file" in the /repositories/proj.git/index?  Or do you mean
> this?

The pattern I use is to have this:

	/repository/.git
	/working/...

then

	cd /repository
	git add /working/x/y/z

works as you'd expect it to.  "git rm" seems to work correctly under
these circumstances as well.

I seem to recall that using relative <path> values doesn't work under
some conditions involving symbolic links, but I can't recall the
details right now.

> you talk about starting Git command _outside_ the working tree
> (whether the working tree has its repository embedded in it is not
> very relevant).

The above pattern is what I mean, where the cwd is not within the work
tree.

Dale
