From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-zip-tree to .gitignore
Date: Mon, 28 Aug 2006 15:43:41 -0700
Message-ID: <7vd5akqy5e.fsf@assigned-by-dhcp.cox.net>
References: <44F17FD5.2030000@lsrfire.ath.cx>
	<7vlkp9x2b9.fsf@assigned-by-dhcp.cox.net>
	<44F21E0B.9010600@lsrfire.ath.cx>
	<7vhczxvlar.fsf@assigned-by-dhcp.cox.net>
	<44F36E03.9090802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 00:43:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHpoy-00007i-Eg
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 00:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWH1WnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 18:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWH1WnE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 18:43:04 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:63643 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964874AbWH1WnC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 18:43:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060828224301.MCSI12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Mon, 28 Aug 2006 18:43:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id Faiy1V00o4Noztg0000000
	Mon, 28 Aug 2006 18:42:59 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44F36E03.9090802@lsrfire.ath.cx> (Rene Scharfe's message of
	"Tue, 29 Aug 2006 00:28:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26184>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>> 
>> I was more worried about possibly having to do --remote once in
>> each for tar-tree and zip-tree in git-daemon.  The version of
>> daemon currently in "pu" can allow git-tar-tree to be accessed
>> from the client via git:// URL.
>
> Good point.  And especially for net transfers a compressed format like
> ZIP or TGZ (not yet implemented) would be better.
>
> Would it make sense to have just one multiplexer command?  I.e.
> something like this:
>
>   git-archive -f <format> [extra]                <tree-ish> [<base>]
>   git-archive -f <format> [extra] --upload       <tree-ish> [<base>]
>   git-archive -f <format> [extra] --remote=<url> <tree-ish> [<base>]
>
> [extra] stands for format specific options like the compression ratio
> for ZIP.  The protocol spoken by upload and --remote would need to be
> extended to be able to specify the format and any format specific options.

I think so.  I never liked the --remote support that was done
inside tar-tree myself and hoped there would be better ways.

> While we're discussing the command line interface, would it make sense
> to support path specs, like e.g. ls-tree does?  Like this:
>
>   git-archive -f <format> [extra] [--prefix=<base>] <tree-ish> [<path>]
>
> Personally, I don't see the need for path specs for archive creation,
> but IF we want to introduce them then the best time to do it would be
> now, at the same time as introducing git-archive (or git-archive-tree).

Well people may want to say more than one <path> to archive only
"include/asm-i386" and "arch/i386" directories, but other than
that, naming <tree-ish> with <revision>:<path> syntax would be
enough.  But I agree with you that it would be now IF we want to
do this.  I am neutral, perhaps slightly in favor.
