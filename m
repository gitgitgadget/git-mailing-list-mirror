From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 13:46:35 -0700
Message-ID: <7v1wpx9gwk.fsf@assigned-by-dhcp.cox.net>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745.15344.qmail@web51005.mail.yahoo.com>
	<20060927033459.GA27622@coredump.intra.peff.net>
	<20060926234309.b16aa44e.seanlkml@sympatico.ca>
	<20060927042850.GB9460@spearce.org>
	<7vfyedd3bw.fsf@assigned-by-dhcp.cox.net>
	<20060927151102.GC20705@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 22:47:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSgIi-0005br-9O
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 22:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030821AbWI0Uqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 16:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030823AbWI0Uqh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 16:46:37 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:16075 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030821AbWI0Uqg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 16:46:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927204636.OJGA12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Sep 2006 16:46:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TYmd1V00x1kojtg0000000
	Wed, 27 Sep 2006 16:46:38 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27930>

Shawn Pearce <spearce@spearce.org> writes:

> You are missing:
> +	setup_ident();
>
> Without that reflog can't get the proper committer data from the
> host's gecos information.  This is probably what is desired for
> most pushes over SSH.

What's even more interesting is when there is .git/config file
and you do not override it with environment variables; the log
entry will be made under the name of the repository user.name in
such a case.

>> +	git_config(git_default_config);
>> +
>>  	write_head_info();

Often setup_ident() needs to go together with git_config(), and
you need to remember that setup must come before config.  These
rules are a bit cumbersome to follow and I often forget.

I wonder if we can have a simpler start-up sequence perhaps to
avoid future mistakes like this?
