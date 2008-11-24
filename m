From: Andriy Gapon <avg@icyb.net.ua>
Subject: Re: git-svn and svnsync
Date: Mon, 24 Nov 2008 14:56:04 +0200
Message-ID: <492AA464.5070404@icyb.net.ua>
References: <48F6F631.90709@icyb.net.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 14:10:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4bCw-0003Qs-2K
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 14:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbYKXNIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 08:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbYKXNIz
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 08:08:55 -0500
Received: from citadel.icyb.net.ua ([212.40.38.140]:2783 "EHLO
	citadel.icyb.net.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbYKXNIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 08:08:54 -0500
X-Greylist: delayed 764 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Nov 2008 08:08:53 EST
Received: from odyssey.starpoint.kiev.ua (alpha-e.starpoint.kiev.ua [212.40.38.101])
	by citadel.icyb.net.ua (8.8.8p3/ICyb-2.3exp) with ESMTP id OAA07336
	for <git@vger.kernel.org>; Mon, 24 Nov 2008 14:56:05 +0200 (EET)
	(envelope-from avg@icyb.net.ua)
User-Agent: Thunderbird 2.0.0.17 (X11/20081106)
In-Reply-To: <48F6F631.90709@icyb.net.ua>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101604>

on 16/10/2008 11:07 Andriy Gapon said the following:
> 
> I did the following:
> 1. mirror svn repository using svnsync
> 2. clone the mirror with git-svn --use-svnsync-props and some tweaking[*]
> 3. run git svn info in the clone
> 4. get error "Unable to determine upstream SVN information from working
> tree history"
> 
> git svn log and git svn rebase do not work either.
> git log does work.
> 
> I have git version 1.6.0.2 (from FreeBSD ports).
> [*] About the tweaking - I manually massaged config file to get the
> branches I was interested in, so .git/config is this:
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> [svn-remote "svn"]
>         useSvnsyncProps = 1
>         url = file:///system/devel/svn/base
>         fetch = head:refs/remotes/trunk
>         fetch = stable/6:refs/remotes/stable_6
>         fetch = stable/7:refs/remotes/stable_7
>         fetch = releng/6.3:refs/remotes/releng_6_3
>         fetch = releng/6.4:refs/remotes/releng_6_4
>         fetch = releng/7.0:refs/remotes/releng_7_0
>         fetch = release/6.3.0:refs/remotes/release_6_3_0
>         fetch = release/7.0.0:refs/remotes/release_7_0_0
> 
> This is .git/svn/.metadata:
> ; This file is used internally by git-svn
> ; You should not have to edit it
> [svn-remote "svn"]
>         reposRoot = file:///system/devel/svn/base
>         uuid = ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f
>         svnsync-uuid = ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f
>         svnsync-url = svn://svn.freebsd.org/base
> 
> So you can see the original svn repository URL.
> 
> git log reports svn info like the following:
> git-svn-id: svn://svn.freebsd.org/base/stable/7@183898
> ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f
> 
> It seems that the problem is that the code in find_by_url() and/or
> read_all_remotes() subroutines (in git-svn.perl) are not aware of
> svnsync and do not realize an URL in logs and URL in svn-remote are
> different.
> BTW, I see that there is some special svm logic in read_all_remotes.
> 
> Thank you very much for any help in advance.
> 

Anyone?
I wonder if this is my local problem/misconfiguration or an issue with
git-svn.


-- 
Andriy Gapon
