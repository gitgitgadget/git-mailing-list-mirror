From: Junio C Hamano <junkio@cox.net>
Subject: Re: Now What?
Date: Thu, 03 Nov 2005 14:07:39 -0800
Message-ID: <7vll05bd1w.fsf@assigned-by-dhcp.cox.net>
References: <E1EXTw5-00063o-Gt@jdl.com>
	<20051103083840.GA28300@ebar091.ebar.dtu.dk>
	<7v4q6uhx0a.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511031151070.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 23:09:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXnFo-0002nE-6Y
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 23:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVKCWHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 17:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVKCWHm
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 17:07:42 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13794 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751354AbVKCWHl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 17:07:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103220644.BETZ24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 17:06:44 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511031151070.25300@iabervon.org> (Daniel
	Barkalow's message of "Thu, 3 Nov 2005 12:05:42 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11101>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Thu, 3 Nov 2005, Junio C Hamano wrote:
>
>> "Peter Eriksen" <s022018@student.dtu.dk> writes:
>> 
>> > ~/git/git-core]cat .git/remotes/origin
>> > URL: git://git.kernel.org/pub/scm/git/git.git
>> > Pull: master:origin
>> >
>> > ~/git/git-core]git-checkout maint
>> > ~/git/git-core]git pull
>> 
>> You are merging my master into your "maint", probably a copy of
>> my (previous) maint.
>
> I think the situation is that he really wanted to update master, but 
> forgot that he was on the maint branch.

I wonder if it would make sense to have something in .git/remotes/
file that says "run merge only when I am on frotz branch", like
this:

        ~/git/git-core]cat .git/remotes/origin
        URL: git://git.kernel.org/pub/scm/git/git.git
        Pull: master:origin
	Fetch-Only-Unless: master

        ~/git/git-core]git-checkout maint
	~/git/git-core]git pull
	warning: not merging because you are not on 'master' branch.

This would make the above "git pull" behave identical to "git
fetch", and the user can then do:

	$ git checkout master
        $ git pull . origin

Useful?  Useless?
