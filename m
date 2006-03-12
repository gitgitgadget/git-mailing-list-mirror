From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 03:27:22 -0800
Message-ID: <7v7j6zgaxx.fsf@assigned-by-dhcp.cox.net>
References: <20060311192954.GQ16135@artsapartment.org>
	<slrne17urp.fr9.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 12 12:27:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIOjR-00043h-LK
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 12:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWCLL1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 06:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWCLL1Y
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 06:27:24 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:45953 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751368AbWCLL1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 06:27:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060312112353.DEYU17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Mar 2006 06:23:53 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Sun, 12 Mar 2006 10:44:09 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17510>

Mark Wooding <mdw@distorted.org.uk> writes:

> This is not the right fix.  NULL can be simply a #define for 0 (see
> 6.3.2.3#3 and 7.17).  You need to write (char *)0 or (char *)NULL.  I
> prefer to avoid the macro NULL entirely, since its misleading behaviour
> is precisely what got us into this mess.

Patches welcome.  We have about 15 or so such instances.

$ git grep -n -H 'execl[_a-z]*(' '*.c'
cat-file.c:139:			return execl_git_cmd("ls-tree", argv[2], NULL);
connect.c:547:		execlp(git_proxy_command, git_proxy_command, host, port, NULL);
connect.c:646:			execlp(ssh, ssh_basename, host, command, NULL);
connect.c:654:			execlp("sh", "sh", "-c", command, NULL);
daemon.c:263:	execl_git_cmd("upload-pack", "--strict", timeout_buf, ".", NULL);
exec_cmd.c:97:int execl_git_cmd(const char *cmd,...)
fetch-clone.c:32:		execl_git_cmd("index-pack", "-o", idx, pack_tmp_name, NULL);
fetch-clone.c:109:		execl_git_cmd("unpack-objects", quiet ? "-q" : NULL, NULL);
git.c:256:	execlp("man", "man", page, NULL);
imap-send.c:948:			execl( "/bin/sh", "sh", "-c", srvc->tunnel, NULL );
merge-index.c:18:		execlp(pgm, arguments[0],
pager.c:14:	execlp(prog, prog, NULL);
rsh.c:106:		execlp(ssh, ssh_basename, host, command, NULL);
upload-pack.c:92:	execl_git_cmd("pack-objects", "--stdout", NULL);
