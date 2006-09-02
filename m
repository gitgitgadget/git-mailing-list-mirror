From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Sat, 02 Sep 2006 14:19:26 -0700
Message-ID: <7v1wquynj5.fsf@assigned-by-dhcp.cox.net>
References: <44F977C0.4060901@lsrfire.ath.cx>
	<44F982BD.1050509@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 02 23:19:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJcti-0002zi-Hw
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 23:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbWIBVTW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 17:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWIBVTW
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 17:19:22 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:3491 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751604AbWIBVTV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 17:19:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902211920.FAFI12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 2 Sep 2006 17:19:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HZKM1V0081kojtg0000000
	Sat, 02 Sep 2006 17:19:21 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44F982BD.1050509@lsrfire.ath.cx> (Rene Scharfe's message of
	"Sat, 02 Sep 2006 15:10:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26358>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Does it make sense to change the wire protocol to simply send the
> command line options one by one?

Which wire protocol are you talking about?  The one between
upload-tar and local "tar-tree --remote"?  I think that one was
a tar-tree specific hack and we do not want to mimic it.

Your idea of making archiver neutral upload/download pair makes
sense.  The daemon can invoke upload-archive with a single
parameter (the repository, "."), just like upload_tar() in
"pu:daemon.c" does [*1*], and upload-archive talks with the
other end to know which archiver to run with what paramter.  We
would probably want to use some sort of side-band mechanism so
that we can do progress-bar as well.


*1* Unrelated side note.  I find myself typing "git less" quite
    often ;-)

	git less pu:daemon.c

    and get "no such command, dummy" response.  

    Yes, I know I could alias it to "-p cat-file -p".  I am just
    too lazy to do so.



-- 
VGER BF report: U 0.709954
