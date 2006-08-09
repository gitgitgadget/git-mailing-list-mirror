From: Junio C Hamano <junkio@cox.net>
Subject: Re: Strange output of git-diff-tree
Date: Wed, 09 Aug 2006 12:26:38 -0700
Message-ID: <7vwt9h3e35.fsf@assigned-by-dhcp.cox.net>
References: <ebcnml$btf$1@sea.gmane.org>
	<7vfyg54vjb.fsf@assigned-by-dhcp.cox.net>
	<7vbqqt4vct.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 21:26:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAthU-0007T4-IG
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 21:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWHIT0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 15:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWHIT0l
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 15:26:41 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35270 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751147AbWHIT0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 15:26:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809192639.BSYJ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 15:26:39 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vbqqt4vct.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 09 Aug 2006 11:28:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25134>

Junio C Hamano <junkio@cox.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> First (noticed by matled) is that for git-diff-tree with single tree
>>> as an argument it outputs fist commit-id of commit given at input. 
>>> It is not mentioned in documentation and I think totally unnecessary:
>>>
>>> 1038:jnareb@roke:~/git> git diff-tree --abbrev origin
>>> d5dc6a76d49367cddc015e01d2e9aa22e64d7e28
>>> :040000 040000 44fb36d... 1c26294... M  Documentation
>>
>> Working as specified as in the original version.  See
>> core-tutorial and look for "git-diff-tree -p HEAD".
>
> My mistake -- if you are talking about the first line that shows
> the commit object name, I am not sure if this was from the
> beginning or a recent slip-up.  Will need to look into it.
>
> I thought you were talking about 1-argument diff-tree, sorry.

Turns out that git-diff-tree from 1.0.0 behaves this way.  Since
7384889 (May 18, 2005), one-tree form of diff-tree showed the
"header" line that has the commit object name at the top, and
since 1809266 (Jun 23, 2005) we have exactly one commit object
name there; before that we used to say "commitA (from commitB)".

I agree that showing the single argument that is given on the
command line as the first output line might seem redundant, but
it has been done this way for a long time (eternity in git
timescale), so let's not risk breaking people's scripts by
changing it.
