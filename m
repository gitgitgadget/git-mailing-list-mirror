From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-update-server-info crashes on hera.kernel.org:/pub/scm/libs/klibc/klibc.git
Date: Sat, 03 Dec 2005 22:16:54 -0800
Message-ID: <7vzmnhtmi1.fsf@assigned-by-dhcp.cox.net>
References: <43921DAE.7060606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 07:17:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EinBP-00005M-Re
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 07:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVLDGQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 01:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVLDGQ5
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 01:16:57 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20968 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932202AbVLDGQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 01:16:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051204061659.UQGJ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Dec 2005 01:16:59 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43921DAE.7060606@zytor.com> (H. Peter Anvin's message of "Sat,
	03 Dec 2005 14:35:26 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13177>

I made a copy of that repository on hera and tried it but cannot
reproduce (with or without -f flag -- and running under gdb with
symbols did not make difference either).  Sorry, I am baffled.
The same machine, the same set of input and binary.

junio@hera:~/t(0)$ echo $PATH
/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/X11R6/bin
junio@hera:~/t(0)$ (cd /pub/scm/libs/klibc/ && tar cf - klibc.git ) | tar xf -
junio@hera:~/t(0)$ head -n 4 klibc.git/objects/info/packs
P pack-122eb314270865bdaaded7d02c7340014537abbf.pack
D 0
T 0 005146812e1e36309409128e0bbaf86e6745a637 tag
T 0 00aea41acad6d139679416a79ff9139a50b5001c tag
junio@hera:~/t(0)$ GIT_DIR=klibc.git /usr/bin/git-update-server-info ; echo $?
0
junio@hera:~/t(0)$ head -n 4 klibc.git/objects/info/packs
P pack-1433c87e76496ad3f628652c0cb81d288c178fc5.pack
P pack-f9db0b232716d835858232fbecfb410d22ae5afb.pack
D 0
junio@hera:~/t(0)$ rm -fr klibc.git
junio@hera:~/t(0)$ (cd /pub/scm/libs/klibc/ && tar cf - klibc.git ) | tar xf -  junio@hera:~/t(0)$ head -n 4 klibc.git/objects/info/packs
P pack-122eb314270865bdaaded7d02c7340014537abbf.pack
D 0
T 0 005146812e1e36309409128e0bbaf86e6745a637 tag
T 0 00aea41acad6d139679416a79ff9139a50b5001c tag
junio@hera:~/t(0)$ GIT_DIR=klibc.git /usr/bin/git-update-server-info -f; echo $?
0
junio@hera:~/t(0)$ head -n 4 klibc.git/objects/info/packs
P pack-122eb314270865bdaaded7d02c7340014537abbf.pack
P pack-1433c87e76496ad3f628652c0cb81d288c178fc5.pack
P pack-f9db0b232716d835858232fbecfb410d22ae5afb.pack
D 0
junio@hera:~/t(0)$ exit
