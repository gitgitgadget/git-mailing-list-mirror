From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: use of temporary refs in resolve
Date: Mon, 08 Aug 2005 09:50:30 +0100
Message-ID: <tnxk6iwx161.fsf@arm.com>
References: <7v3bplwmzg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 10:56:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E23PK-0001Be-9I
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 10:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVHHIwB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 04:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVHHIwB
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 04:52:01 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:46027 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750765AbVHHIwA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 04:52:00 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j788okOU007197;
	Mon, 8 Aug 2005 09:50:46 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id JAA18817;
	Mon, 8 Aug 2005 09:51:34 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 8 Aug 2005 09:51:02 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bplwmzg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 07 Aug 2005 12:44:35 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 08 Aug 2005 08:51:02.0534 (UTC) FILETIME=[4E269A60:01C59BF6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Here is my understanding of various "temporary heads" left
> directly underneath $GIT_DIR:
>
>     HEAD      : updated only after successful auto merge.
>
>     ORIG_HEAD : records the head value before resolve started.
>                 if automerge fails, this is the same as HEAD,
>                 but after successful automerge, this can be used
>                 to see what the previous head was.  This is the
>                 first parent of the resulting commit.
>
>     MERGE_HEAD: present if auto merge is unsuccessful and
> 		records the other head being merged.
>
>     LAST_MERGE: present if merge is unsuccessful or impossible and
> 		records the other head being merged.

Is FETCH_HEAD going to be preserved by the git-fetch-script operation?
It should be, unless, git-pull-script removes it or it is changed to
do the fetch as well.

In a repository managed with StGIT (i.e. updated with 'stg pull'), the
base of the stack is always the same with FETCH_HEAD and StGIT uses
this file. I also find it quite useful for:

  gitk ORIG_HEAD..FETCH_HEAD

to only see the remote commits since the local StGIT patches are
always seen as commits on top of the FETCH_HEAD. It's also useful for
people using 'git rebase'.

-- 
Catalin
