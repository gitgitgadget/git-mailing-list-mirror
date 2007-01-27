From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 27 Jan 2007 14:23:31 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701271415280.3021@xanadu.home>
References: <7vps90lvoh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 20:23:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAt9D-0000VW-QW
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 20:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbXA0TXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 14:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbXA0TXc
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 14:23:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21484 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbXA0TXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 14:23:32 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCJ00HWNKJ7T1D0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 27 Jan 2007 14:23:31 -0500 (EST)
In-reply-to: <7vps90lvoh.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37988>

On Sat, 27 Jan 2007, Junio C Hamano wrote:

> * np/dreflog (Fri Jan 26 17:26:11 2007 -0500) 8 commits
>  - add reflog when moving HEAD to a new branch
>  - create_symref(): do not assume pathname from git_path() persists
>    long enough
>  - add logref support to git-symbolic-ref
>  - move create_symref() past log_ref_write()
>  - add reflog entries for HEAD when detached
>  - enable separate reflog for HEAD
>  - lock_ref_sha1_basic(): remember the original name of a ref when
>    resolving it
>  - make reflog filename independent from struct ref_lock
> 
> Perhaps 1.5.0 material, but I do not think anybody in the
> current code pays attention to reflog for HEAD ("HEAD@{....}"
> syntax and log or show-branch with -g option would look at the
> underlying ref and prune and friends do not protect its
> entries), so merge it post 1.5.0 after these issues are fixed.

I might be partial of course, but I think it is preferable to merge it 
before 1.5.0 since this causes a behavior change.  Currently HEAD@{n} 
inherits the reflog of the branch HEAD is currently on.  With this patch 
serie HEAD@{n} is the true reflog for HEAD regardless of where it is now 
and where it has been independently of the current branch.  Of course I 
consider the later behavior to be more sensible and it might be a good 
idea to give it to 1.5.0 users at the same time as the detached head 
support rather than creating a behavior change later on when reflogs are 
more popular.

I'll look at prune and friend for teaching them about the new reflog 
entries.


Nicolas
