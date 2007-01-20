From: Junio C Hamano <junkio@cox.net>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Sat, 20 Jan 2007 12:42:18 -0800
Message-ID: <7v7ivh77md.fsf@assigned-by-dhcp.cox.net>
References: <17842.1385.366750.915767@lisa.zopyra.com>
	<7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
	<7vfya57ast.fsf@assigned-by-dhcp.cox.net>
	<17842.29542.229557.460473@lisa.zopyra.com>
	<7vbqkt78n7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 21:42:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8N2e-00028A-54
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 21:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965379AbXATUmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 15:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965380AbXATUmU
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 15:42:20 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39786 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965379AbXATUmU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 15:42:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120204219.YSWT19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sat, 20 Jan 2007 15:42:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DYic1W0121kojtg0000000; Sat, 20 Jan 2007 15:42:37 -0500
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <7vbqkt78n7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 20 Jan 2007 12:20:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37290>

Junio C Hamano <junkio@cox.net> writes:

> Bill Lear <rael@zopyra.com> writes:
>
>> We are using git 1.4.4.1, the latest I thought available, not 1.4.4.4
>> (perhaps you mis-typed?).
>>
>> In any case, I personally would love to try the latest build of git,
>> but I don't think I can convince the rest of the company to do so.
>>
>> I just got an email from one of the developers.  He seems to think
>> this is alleviated by using bash instead of tcsh.
>
> Heh, you'll never know what you would get until you ask.  I
> temporarily run chsh on myself to use tcsh as my login shell,
> and sure enough I am getting the error.
>
> fatal: protocol error: bad line length character: 75 70 64 61
>
> It reads "u p d a"; most likely the command name we are running,
> which is "update".  I think it is spitting out an error message
> or something silly like that saying "update hook is not
> executable".  Let me dig a bit further and report later.

That was output to stdout made from the update hook in my case.
I do not know your setup, but if you make sure your update hook
does not spit out anything to its stdout (diag can go to stderr),
you should be able to work it around.

Funny thing is, at least in recent enough git, I think we set up
redirection to force output from hook scripts to stderr, but I
do not remember when it happened.  Let's see...

	...goes and looks...

That was supposed to have been fixed with commit cd83c74c (Dec
30, 2006), but this indicates the fix is not working at all when
your login shell is tcsh.

Hmmmmmm.....
