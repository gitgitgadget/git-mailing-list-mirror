From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [RFC] Re: git-svn: make git-svn commit-diff able to work without explicit arguments
Date: Tue, 2 Jan 2007 16:26:46 -0500
Message-ID: <052E1601-5422-48A0-81B3-9A454467CE5F@silverinsanity.com>
References: <459AA31E.5070705@gmail.com> <7vr6udtbmv.fsf@assigned-by-dhcp.cox.net> <20070102211339.GF17898@hades.madism.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	=?ISO-8859-1?Q?Steve_Fr=E9cinaux?= <nudrema@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 22:27:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1r9t-00027G-G3
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 22:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbXABV0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 16:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbXABV0x
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 16:26:53 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:45825 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbXABV0w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 16:26:52 -0500
Received: from [192.168.1.6] (cpe-66-67-221-135.rochester.res.rr.com [66.67.221.135])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id DED241FFC02B;
	Tue,  2 Jan 2007 21:26:51 +0000 (UTC)
In-Reply-To: <20070102211339.GF17898@hades.madism.org>
To: Pierre Habouzit <madcoder@debian.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35820>

>   The reason is simple, I often use git commit as :wq in my editor,  
> and
> sometimes think that in a A--B--C--D and in fact, I'd prefer to have:
>
>   {A,C}--B--D. how is it possible to do that in a not too cumbersome
> way? because that would make sens to work in some scratch branch, and
> then reorganize patches in a saner better way in the master branch.
>
>   But I fail to see how to achieve that without using cumbersome
> export-to-patch then git apply patch and edit logs which is painful  
> and
> not really using git.

The command you seem to be looking for is git-cherry-pick.  To  
combine the two commits, I'd do something like:

$ git cherry-pick A
$ git cherry-pick C
$ git reset HEAD~2
$ git add <files>
$ git commit

And then you could rebase the work branch on top of the new master,  
which should catch that A and C were already committed with minimal  
effort.  Of course there may be a cleaner way to do it, but this is  
what I do.

~~ Brian Gernhardt
