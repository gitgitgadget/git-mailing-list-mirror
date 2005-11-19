From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Fri, 18 Nov 2005 16:49:34 -0800
Message-ID: <7v3bltea1t.fsf@assigned-by-dhcp.cox.net>
References: <20051117230723.GD26122@nowhere.earth> <437DDDB1.60103@b-i-t.de>
	<Pine.LNX.4.64.0511180915560.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:50:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdGvD-0005bm-6C
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 01:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVKSAtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 19:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVKSAtg
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 19:49:36 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:62904 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751254AbVKSAtg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 19:49:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119004857.BFHO20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 19:48:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12312>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 18 Nov 2005, sf wrote:
>> 
>> A commit is really just the statement: "I changed the tree from state A to
>> state B". After all, the commit message does not describe the new state
>> (neither the old state) but does describe the changes.
>
> There are lots of changelog entries that don't necessarily make sense 
> without knowing what went before them, so history is actually important 
> even in a local sense - it's often what allows the explanation to make 
> sense.

I agree with what you said about commit objects and what they
are meant to describe.  At the same time, I am sympathetic if
somebody wants to be able to say just "The change this commit
brings in can be used to modify the behaviour X to Y".  An
implied prerequisite for such a statement is that you can apply
such a change only to something that has behaviour X, and
internally works in a certain way to exhibit that behaviour, to
begin with (IOW, otherwise the patch does not apply).  While
your "commit describes all the history leading to it" obviously
satisfies that prerequisite, it is stronger than necessary.

For that matter, "tree A changed into tree B" is stronger than
necessary as well.  There are trees other than tree A that has
the same behaviour X, and applying such a change would be valid
to modify its behaviour to Y.

You are absolutely right that commit messages should be taken in
the context of the history leading to it.  However, when we
exchange patches via e-mail, or do "rebase" in the repository,
we also use the commit message to label the change -- and with
that usage, the log message becomes less about describing the
history and more about "modifies X to Y", so it is easy to get
confused.
