From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Tue, 02 May 2006 17:01:40 -0700
Message-ID: <7vwtd4ht7f.fsf@assigned-by-dhcp.cox.net>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
	<e34bdf$ho4$1@sea.gmane.org> <7vhd4as00i.fsf@assigned-by-dhcp.cox.net>
	<e34cb4$is1$1@sea.gmane.org> <44571967.7080807@op5.se>
	<7vy7xkn6kd.fsf@assigned-by-dhcp.cox.net> <e378fs$lpc$1@sea.gmane.org>
	<7v1wvcmejr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605021422200.4086@g5.osdl.org>
	<7vbqugks8j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 02:01:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb4oM-0007a9-Cc
	for gcvg-git@gmane.org; Wed, 03 May 2006 02:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWECABn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 20:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWECABn
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 20:01:43 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:55447 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965046AbWECABm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 20:01:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060503000142.JJGP24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 20:01:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vbqugks8j.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 02 May 2006 14:54:20 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19446>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Tue, 2 May 2006, Junio C Hamano wrote:
>>> 
>>>  - The shell-script one, if you use GNU grep, accepts more
>>>    options to grep than what the current built-in one supports.
>>>    Notable ones that are missing: fixed strings (-F), patterns
>>>    from file (-f), count matches (-c), omit filenames (-h),
>>>    skipping binary files (-I, -U), files without match (-L),
>>>    pcre (-P), silent (-q), word expression (-w), NUL (-z).  They
>>>    should be easy to add if somebody cares enough, and I plan to
>>>    do a few myself before pushing it out to "master".
>>
>> I use "-w" all the time, along with -5 or similar to get context for the 
>> grep.
>
> Noted; -w is missing; -A/-B/-C are already there so you could
> say -C 5 instead, and -<n> should be easy to add.

I did both -<n> and -w, and pushed it out in "next".

What we have:

        -<n>, -[ABC] <n> (and -[ABC]<n>)
        -E
        -G
        -H (but it is an no-op -- we always show name)
        -c
        -e (you can do multiple patterns now)
        -i
        -n
        -v
        -w
	-l

What are still missing:

        -I (easy)
        -L (probably a bit intrusive)
        -P (code is easy -- deciding dependency on pcre is OK is harder)
        -U (probably not so easy but may be useful)
        -Z (probably easy but is it useful?)
        -q (may not be worth doing)
        -z (easy but pointless)
	-F (dunno)
	-f (with the enhancement to do multiple -e, trivial to add this)
