From: David Mansfield <david@cobite.com>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 16:19:39 -0400
Message-ID: <42938C5B.4000906@cobite.com>
References: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 22:19:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DafrJ-0008DO-EA
	for gcvg-git@gmane.org; Tue, 24 May 2005 22:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVEXUUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 16:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVEXUUA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 16:20:00 -0400
Received: from iris.cobite.com ([208.222.83.2]:26755 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S262010AbVEXUTm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 16:19:42 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id B75DC9855B; Tue, 24 May 2005 16:19:35 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10857-10; Tue, 24 May 2005 16:19:35 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id E780F988A1; Tue, 24 May 2005 16:19:34 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 8B0759855B; Tue, 24 May 2005 16:19:33 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 24 May 2005, Linus Torvalds wrote:
> 
>>Will fix. This will take another six minutes of testing ;)
> 
> 
> Almost eight minutes. Still, the final average was 8 changesets per
> second, which sounds pretty damn good to me, actually.
> 
> Anyway, I've checked in the fix for the quoting, and I now get the right 
> number of revisions, ie
> 
> 	git-rev-tree $(ls .git/refs/heads/) | wc -l
> 
> returns the same "3757" that cvsps reports. 
> 
> However, "git-fsck-cache --unreachable" reports 102 unreachable blobs,
> which worries me. It's really blobs only, which is strange: it implies
> that we did the "git-update-cache" but not a "git-write-tree" (or that the
> git-write-tree failed for some reason, but that sounds even stranger,
> since we did successfully do all the commits)
> 
> The only way I can see the unreachable blobs happening is if one of he
> ChangeSet entries in cvsps mentions the _same_ pathname twice for a single
> ChangeSet. David, is that possible?
>

Sounds possible.  Unfortunately, the 'uniqueness' of a commit actually 
doesn't exist.  It's all smoke-and-mirrors.  In order to disallow this 
(which I think need to do) I'd need to use some commit member 
information, and add some heuristic: if this file is already in the 
commit, then this MUST be a different commit.  Unfortunately, it's 
possible that the 'member' already in the commit is the wrong one and 
this is the right one, which just sounds horribly ugly to me.

I'll think on it.

David
