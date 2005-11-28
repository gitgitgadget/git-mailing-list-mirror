From: Junio C Hamano <junkio@cox.net>
Subject: Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 13:46:03 -0800
Message-ID: <7vd5kksaxw.fsf@assigned-by-dhcp.cox.net>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
	<7vbr051ad1.fsf@assigned-by-dhcp.cox.net>
	<20051128105736.GO22159@pasky.or.cz>
	<7vsltgtvk4.fsf@assigned-by-dhcp.cox.net>
	<20051128212804.GV22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 22:48:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egqp8-0001Zc-EC
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 22:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVK1VqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 16:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVK1VqH
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 16:46:07 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:10995 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751320AbVK1VqF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 16:46:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128214451.FYRI26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 16:44:51 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051128212804.GV22159@pasky.or.cz> (Petr Baudis's message of
	"Mon, 28 Nov 2005 22:28:04 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12906>

Petr Baudis <pasky@suse.cz> writes:

>> Here are the things whoever is doing the hooks/post-update for
>> this particular setup needs to think about.
>> 
>>  - is it safe to assume that the guy working on the server
>>    working tree never switch branches?  otherwise, what to do if
>>    the working tree has different branch checked out when push
>>    called post-update?
>
> I wouldn't do anything. Working copy reflects the HEAD; if you don't
> update HEAD, you needn't touch the working copy.
>
>>  - should it allow forced-push that sets HEAD to non descendant
>>    of the current HEAD?  In a shared repository setup,
>>    disallowing forced-push is a good discipline.  OTOH, if this
>>    is primarily used as an installation mechanism to a remote
>>    hosting site, allowing forced-push may be ok.
>
> I would just leave this on the particular head policy.

In case it was not obvious, I was not outlining what I would
want as a git-wide policy.  It was meant as an example of things
people need to think about, IOW, what their head policy should
be, if they want to use git in a workflow that magically checks
things out when a push happens.

>>  - should it do 'git-checkout', 'git-reset --hard HEAD', or
>>    'git-pull . branch_to_push_into'?  The former two pretty much
>>    assumes no development happens on the server repository and
>>    git push is used primarily as an installation mechanism.
>
> Files should be removed properly, which pretty much excludes the former
> two, I think.

Unless you screw with the branch head under a checked out tree,
git-checkout would remove files properly, and "git-reset --hard"
would do the right thing even when you update the branch head of
a checked out tree.  The last one is interesting and might be
useful.
