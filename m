From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Tue, 02 May 2006 14:54:20 -0700
Message-ID: <7vbqugks8j.fsf@assigned-by-dhcp.cox.net>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
	<e34bdf$ho4$1@sea.gmane.org> <7vhd4as00i.fsf@assigned-by-dhcp.cox.net>
	<e34cb4$is1$1@sea.gmane.org> <44571967.7080807@op5.se>
	<7vy7xkn6kd.fsf@assigned-by-dhcp.cox.net> <e378fs$lpc$1@sea.gmane.org>
	<7v1wvcmejr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605021422200.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 23:54:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb2p7-0008Jo-3s
	for gcvg-git@gmane.org; Tue, 02 May 2006 23:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWEBVyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 17:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWEBVyW
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 17:54:22 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:63955 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965008AbWEBVyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 17:54:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060502215421.HQBI27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 17:54:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605021422200.4086@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 2 May 2006 14:23:05 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19431>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 2 May 2006, Junio C Hamano wrote:
>> 
>>  - The shell-script one, if you use GNU grep, accepts more
>>    options to grep than what the current built-in one supports.
>>    Notable ones that are missing: fixed strings (-F), patterns
>>    from file (-f), count matches (-c), omit filenames (-h),
>>    skipping binary files (-I, -U), files without match (-L),
>>    pcre (-P), silent (-q), word expression (-w), NUL (-z).  They
>>    should be easy to add if somebody cares enough, and I plan to
>>    do a few myself before pushing it out to "master".
>
> I use "-w" all the time, along with -5 or similar to get context for the 
> grep.

Noted; -w is missing; -A/-B/-C are already there so you could
say -C 5 instead, and -<n> should be easy to add.

On a related tangent, ever since I started using the built-in
grep with ls-files like wildcard, I find myself typing something
like this by mistake (this is from my day-job work project that
has src/mx.js and src/mxstyle.css among other things):

	git diff 268a94 -- 'src/mx*'

I am tempted to suggest switching pathspecs used by diff and log
family to do the same wildcarding, perhaps after tightening the
wildcard vs directory prefix logic used in the builtin-grep of
the current "next" tip, which is a bit looser than necessary.
