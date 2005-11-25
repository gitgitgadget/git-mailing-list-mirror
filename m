From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-mail in sh
Date: Fri, 25 Nov 2005 10:30:50 -0800
Message-ID: <7vwtiwmvfp.fsf@assigned-by-dhcp.cox.net>
References: <4386DD45.6030308@op5.se>
	<7v7jaxou5b.fsf@assigned-by-dhcp.cox.net> <43874935.2080804@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 25 19:32:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfiLk-0003kB-G4
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 19:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVKYSaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 13:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVKYSaw
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 13:30:52 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:19669 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751268AbVKYSaw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 13:30:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051125183023.QMPV3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 25 Nov 2005 13:30:23 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12745>

Andreas Ericsson <ae@op5.se> writes:

> It doesn't CC them, but any number of email-addresses can be specified 
> on the command line (so long as they don't include spaces, but that can 
> be taken care of).

Again I do not think I'd ever use that feature from the original
send-email myself, but the difference is that this CC list
depends on each commit (sign-offs taken from a commit are
added to CC list for only that commit).

>>  * <bottom>..<top> pair is to format changes in <top> but not in
>>    <bottom>; typically <top> is the name of a topic branch, and
>>    <bottom> is typically "origin".  This is to encourage the use
>>    of topic branches.
>
> Would that be
>
> 	git-send-patch origin..HEAD
>
> to get the changes in the current branch since head?

Yes, and that could be spelled "git-send-patch ..HEAD" as well,
if we go with my suggestion to default <bottom> to "origin".

>>  * <commit> is a shorthand for <commit>^1..<commit>; this is to
>>    allow you to quickly pick just one commit and send it out.
>
> Marvellous the things one learn. I didn't know about that syntax before. :)

Just to make sure you did not misunderstand me, I meant: the
proposed program acts as if <commit>^1..<commit> was given when
single <commit> is given.

But you are right.  We could make a single <commit> a short-hand
for "origin"..<commit>; if somebody wants to pick just one
commit from a topic branch, he can always say <commit>^1..<commit>.

> I'm wondering if it wouldn't be better to move much of 
> git-format-patch's functionality to git-send-patch and support a 
> "--todisk" option. After all, how many patches are created but not sent 
> anywhere?

Manymanymanymanymany.  I do all my rebases and cherry-picks via
format-patch piped to git-am, and obviously they are never sent
out.
