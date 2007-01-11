From: Junio C Hamano <junkio@cox.net>
Subject: Re: Removing files
Date: Thu, 11 Jan 2007 14:41:01 -0800
Message-ID: <7vejq12nlu.fsf@assigned-by-dhcp.cox.net>
References: <87bql5cok3.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 23:41:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H58bk-0002OI-9z
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 23:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbXAKWlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 11 Jan 2007 17:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbXAKWlN
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 17:41:13 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:59916 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154AbXAKWlN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jan 2007 17:41:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111224112.QRGV18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 17:41:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9ygM1W0091kojtg0000000; Thu, 11 Jan 2007 17:40:21 -0500
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <87bql5cok3.fsf@morpheus.local> (David =?iso-8859-1?Q?K=E5ged?=
 =?iso-8859-1?Q?al's?= message of
	"Thu, 11 Jan 2007 21:10:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36630>

David K=E5gedal <davidk@lysator.liu.se> writes:

> I'm wondering what the best way to commit the removal of a file is.

 $ rm -f foo
 $ git-commit -a

> git status shows:
>
>   $ git status
>   # On branch refs/heads/messages
>   # Changed but not added:
>   #   (use "git add <file>..." to incrementally add content to commit=
)
>   #
>   #       deleted:    foo

Suggesting "git add" to record the deletion feels insane.  Is
this what we still do?  I think there have been much work=20
in this area recently so the wordings might have already fixed.

> Ok, so that didn't work.  Let's try rm instead:
>
>   $ git rm foo
>   fatal: pathspec 'foo' did not match any files
>

The above message is from an older version of git-rm, but the
one that will be in v1.5.0 is not any better.  It errs out with
"No such file or directory".  A workaround using today's tool is
to do "git rm --cached fo"

I think the right fix is to suggest "git add/rm" in status
output and make "git rm" not barf if the user has already
removed the file from the working tree.

       =20
