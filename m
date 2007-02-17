From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for
 disconnected transfer
Date: Sat, 17 Feb 2007 09:40:00 -0500
Message-ID: <45D713C0.1010401@verizon.net>
References: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
 <7vhctl50zc.fsf@assigned-by-dhcp.cox.net>	<45D63C7A.4050300@verizon.net>
 <7vfy95w9sc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 15:40:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIQjR-0001V6-VB
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 15:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbXBQOkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 09:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965264AbXBQOkG
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 09:40:06 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:36466 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965265AbXBQOkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 09:40:04 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDM008TP3ENVZ60@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 17 Feb 2007 08:40:00 -0600 (CST)
In-reply-to: <7vfy95w9sc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39989>

Junio C Hamano wrote:
> I do not think your patch (original or respun) checks if it is
> overwriting the current branch.  Even if it is a fast forward,
> it should check this condition and prevent the end user from
> getting confused.  The above sample command line you quoted from
> my message can potentially have the same problem, but "git
> fetch" checks and refuses.
>   
True. I've been using this to mirror remote/* and tags. Making this just 
an alternate transport behind fetch and pull is clearly the cleanest way 
to deal with non-remote branches.
> A final note.  A real 'mirror' mode should also remove stale
> refs that do not exist on the remote side anymore, which is a
> different use case as your bundle, which presumably is primarily
> meant to carry not all but only selected set of refs, and most
> likely not the 'master' branch head (and I am guessing that that
> is why you forgot to make sure you are not overwriting the
> current branch in the unbundle script).  A real 'mirror' mode
> would use a separate option to remove a ref that does not exist
> on the remote end anymore, like:
>
> 	$ git fetch --mirror-all git://git.kernel.org/pub/scm/git/git.git
>   
Perhaps "git fetch --mirror --delete" would be more suggestive of the 
difference to "git fetch --mirror"?

Mark
