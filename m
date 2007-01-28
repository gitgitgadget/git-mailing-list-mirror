From: Junio C Hamano <junkio@cox.net>
Subject: Re: More precise tag following
Date: Sun, 28 Jan 2007 12:01:27 -0800
Message-ID: <7vhcuaex9k.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701281107050.25027@woody.linux-foundation.org>
	<7vveirdkpb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701281143190.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 21:01:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBGDT-0002YL-Kb
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 21:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbXA1UB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 15:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932803AbXA1UB3
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 15:01:29 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:49690 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932792AbXA1UB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 15:01:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128200127.BPGH3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 15:01:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Gk0V1W0041kojtg0000000; Sun, 28 Jan 2007 15:00:29 -0500
In-Reply-To: <Pine.LNX.4.64.0701281143190.25027@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 28 Jan 2007 11:57:33 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38045>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But for the actual viewer parts, which don't need internal git knowledge, 
> let's just document the blame format, so that others can do it:
>
> The new format is fairly easy to parse: each blame entry is always
>
>  - starts with a line of
>
> 	<40-byte hex sha1> <sourceline> <resultline> <num_lines>
>
>  - the first time that commit shows up in the stream, it has various
>    other information about it printed out with a one-word tag at the 
>    beginning of each line about that "extended commit info" (author, 
>    email, committer, dates, summary etc)
>
>  - each entry is _always_ finished by a
>
> 	"filename" <whitespace-quoted-filename-goes-here>
>
> and thus it's really quite easy to parse for some line- and word-oriented 
> parser (which should be quite natural for most scripting languages).
>
> NOTE! For people who do parsing: to make it more robust, just ignore any 
> lines in between the first and last one ("<sha1>" and "filename" lines) 
> where you don't recognize the tag-words (or care about that particular 
> one) at the beginning of the "extended information" lines. That way, if 
> there is ever added information (like the commit encoding or extended 
> commit commentary), a blame viewer won't ever care.

Thanks for these notes, which I should have written.  I would
also caution them to ignore if there is anything they do not
understand between "filename" and <sha1>.

A sample code to parse it in Perl was just posted by me ;-).
